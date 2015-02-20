######################################################################################
###
### Scripts for the calculation of SGPs for Arkansas
###
######################################################################################

### Load SGP Package

require(SGP)


### NULL out baseline matrices

SGPstateData[["AR"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- NULL


### Load data

load('Data/Arkansas_Data_LONG.Rdata')
load('Data/Arkansas_Data_LONG_INSTRUCTOR_NUMBER.Rdata')


### Create Configurations

ARKANSAS.2013.config <- list(
	MATHEMATICS.2013.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
                sgp.grade.sequences=list(c('1', '2'), c('1', '2', '3'), c('1', '2', '3', '4'), c('1', '2', '3', '4', '5'), c('2', '3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('4', '5', '6', '7', '8'))),
	LITERACY.2013.config=list(
                sgp.content.areas=c('LITERACY', 'LITERACY', 'LITERACY', 'LITERACY', 'LITERACY'),
                sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
                sgp.grade.sequences=list(c('1', '2'), c('1', '2', '3'), c('1', '2', '3', '4'), c('1', '2', '3', '4', '5'), c('2', '3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('4', '5', '6', '7', '8'))),
	EOC_MATHEMATICS_1.2013 =list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'EOC_MATHEMATICS_1'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(3:6, 7), c(4:7, 8), c(5:8, 9))),
	EOC_MATHEMATICS_2.2013 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'EOC_MATHEMATICS_1', 'EOC_MATHEMATICS_2'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(4:6, 7, 8), c(5:7, 8, 9), c(6:8, 9, 10)))

ARKANSAS.2014.config <- list(
	MATHEMATICS.2014.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2009', '2010', '2011', '2012', '2013', '2014'),
                sgp.grade.sequences=list(c('1', '2'), c('1', '2', '3'), c('1', '2', '3', '4'), c('1', '2', '3', '4', '5'), c('1', '2', '3', '4', '5', '6'), c('2', '3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))),
	LITERACY.2014.config=list(
                sgp.content.areas=c('LITERACY', 'LITERACY', 'LITERACY', 'LITERACY', 'LITERACY', 'LITERACY'),
                sgp.panel.years=c('2009', '2010', '2011', '2012', '2013', '2014'),
                sgp.grade.sequences=list(c('1', '2'), c('1', '2', '3'), c('1', '2', '3', '4'), c('1', '2', '3', '4', '5'), c('1', '2', '3', '4', '5', '6'), c('2', '3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))),
	EOC_MATHEMATICS_1.2014 =list(
		sgp.content.areas=c(rep('MATHEMATICS', 5), 'EOC_MATHEMATICS_1'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013', '2014'),
		sgp.grade.sequences=list(c(2:6, 7), c(3:7, 8), c(4:8, 9))),
	EOC_MATHEMATICS_2.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'EOC_MATHEMATICS_1', 'EOC_MATHEMATICS_2'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013', '2014'),
		sgp.grade.sequences=list(c(3:6, 7, 8), c(4:7, 8, 9), c(5:8, 9, 10)))

ARKANSAS.config <- c(ARKANSAS.2013.config, ARKANSAS.2014.config)


### Step 1: prepareSGP

Arkansas_SGP <- prepareSGP(Arkansas_Data_LONG, data_supplementary=list(INSTRUCTOR_NUMBER=Arkansas_Data_LONG_INSTRUCTOR_NUMBER))


### Step 2: analyzeSGP

Arkansas_SGP <- analyzeSGP(
		sgp_object=Arkansas_SGP,
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		sgp.config=ARKANSAS.config)
#		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(PERCENTILES=20)))

### Step 3: combineSGP

Arkansas_SGP <- combineSGP(Arkansas_SGP)


### Step 4: summarizeSGP

Arkansas_SGP <- summarizeSGP(Arkansas_SGP)


### Step 5: visualizeSGP

visualizeSGP(Arkansas_SGP, sgPlot.demo.report=TRUE)


### Step 6: outputSGP

outputSGP(Arkansas_SGP)
