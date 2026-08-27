Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C5C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B848510F1C1;
	Thu, 27 Aug 2026 20:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ko/Ynftn";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013047.outbound.protection.outlook.com
 [40.107.162.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483AD10F1C1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzWBbbe6lOkk/V9v6CUomTZ4jCtTM6fuytBVHkvJLCMjetTpW7SMNtooavrov89SENuEC4tgSOMeJ//B+HBBj5i3Ns6IR9bHIAr4HB14ByyrCRIqwXBDjXLEIU8xUWfaf/1kQaXRpm3JG7JL0kJi4qebIXE1oTlvWbTsP0aMy0IY0Ok5yAUB6/eY/pPwM+dysg9JIiZPyrePAc50aonlePKHvwBSdJ3mCNnfVUDmuHujeAn8r/Qqo2C7ygAGDQYvFtnQqGx0Bhmfl2R8aQlsqRmCHXy9vpLKuRS3dmS4s/0alS7KO4A56eQozGtbpcLclxO9yJ/B6kZugWdPi7DKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNIt5SEahbDNiHdx8envSGkAIgeUzF6HYbLfuiFU0Wc=;
 b=xKyOGAXcBH2v2t1dvefPfMNbTjbNKWquZpLUhTa87eaxnA+nACmEWIK2zwIGezrgSyYaVIVSqtjgN+R0SvzzTEZU2ul14CqRa106PlvX6Q+IhTzy8ebGp3SnJmkrQnDMTtNSxoxBzKt5d5MFDSJ/wUALOD0HDW7XsM3bkO/FE1jZYt4hIl3UqIc0no37p+Cp2rJgQBrMMnIUAz8Ds7lp4+G1F/FgFIczp12rMSSscmq0OF7yY46rYPcWaaCvm+93lxorGdJk9pWgW+Nw2AH6TvK1BSVbNKwMnGLPIgckrjup0M0k6J+ay5KI+qFTePqEsmp0Ih49hiH9VEI2d8mLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNIt5SEahbDNiHdx8envSGkAIgeUzF6HYbLfuiFU0Wc=;
 b=ko/YnftnG4rjkgEHLcyEh0ekKbGUta98Bz9BhsI6BRY+x7VFrfHGkTmKBo3kXQ9yjquRctZf+jcDn3K/V4fBOSdLuUpsXiMUdqJ2BdWBHYRcQ2CRGcvdnJeZe6KnoHeXtkaD9aNMgKuEk6tUMae7RlHBDMHihX8QTMAnXpe3bUrAOMEnOrSGCbpBOo9QgnJV2oscPMtd1t4zG88J/NtjphvarE3Eei+wNc5jPdenwckOYzCRSCy31oAoe0dW9qtrKAeswlcIG+/2O/DDmVLTsd1k2iPsfWKyQIm0eZYUfmnVSfK//vKQqJVvUCs30sEqWIkwPPpmZWB+L9XIsnTxxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11569.eurprd04.prod.outlook.com (2603:10a6:102:50a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:48:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:48:12 +0000
Date: Thu, 27 Aug 2026 16:48:04 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] accel: ethosu: Fix ethosu_job_open() return value
Message-ID: <apCihFgPhcOEL8Je@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-1-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-1-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH7PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:510:174::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4c9888-1acd-42a8-d049-08df047c824a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MnkNybLbZ0fFWdox7MRR/5M53HXUFhpHYcqDJNYeS4OspCZSEwX70BS8PrzFEV1nDszgMJjAZDdAPJJCruUu6/20feykoIDsgOuhBBZadiZ4twm/7ufTiluyRCjcPRV1d7GdOYypIx0Cqajh7LgwhiXj5EQRQQ9gvJH+TpAKUS1NzqTnDiby7qGxeruuneAVdbU/UlMCd3R7GqgXXaZEsRbMqSbb1X6ObwCOty134XosnTF4z5+2gSXd+Wy83zHfbybwBdIKbaCoYAFHcGB8qowXTp29lsNG/MJTn3Sr1117ASbcnV1R6jmP7erW3evZNd3eIRT9pj9u7FlNb7QBXoqtJ4fJqgP6uB6jsbkfxQT4vVpX0vg4Abz/4YeQGdZFIy5phtInPB/hoBnI6UU2P98SBUWh/FqkrPu8o+u50PQdVFRXO5y6tvaMzpNjGQvdshalP8rHwIMLQ9SkpMUwj8imTbdi1b542ewzZGaIyrwshHFe+H+C1rQNuVy/ywEiYcn35ubOyMt6BLHXdlhYu/FztlWlrvpQXpfBFK94ANaXWLYrbHpXl+boSrO832UKH1tA9bDH3OCXVgF04rxG0euju2hjmf71I7XxeMiNYIigGAs4mkKIu44ZWsmMnUobEOrYBrbGXNeBMzLBmDu1UqShPtI1uIHmpk7yGS81KmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHW+beIrpf7MwMQ/DHn//JqHi64jTruU3rhzkYeT9CznyUa6k7Yqkuh/0gpM?=
 =?us-ascii?Q?yFiADzFAfuTqvX6OkFJQ+EdKvOpsmL/VLQEhhdwzZt8U7S+8PEHSRjbMvab2?=
 =?us-ascii?Q?2Ql6tDMsQbIsxQsjXBhpWmWMtuwZbMfwgnlQ7vhKFdSSVf02Oo+IdqRTj179?=
 =?us-ascii?Q?N0U0+7h//P0ktx+DqqCEelI1gdYW5LuZUQVVz9nfJ4SOOm37IeQO+RqDbbbW?=
 =?us-ascii?Q?jJwNE1AwG9YxXW2vhyM/f0fWANJ8Xe+dU+vdPyozxLCgLcP2T3rxVtQeR2lH?=
 =?us-ascii?Q?QAkGlkQf1IRede6yejg0zT1KYWuGI2BojpBS3tUxfYN7qcuZls85fuwnr2dz?=
 =?us-ascii?Q?9oRPyF5mCh4b3eArCNQgqYxTWn2ZfzHOMUmbrhDjgHnb/iC3w4Cc/eR3LOnJ?=
 =?us-ascii?Q?dbXKndhCROeBETzvuCWvvrDjcLCWeRs272bFSZb8up++99B4yWAhxrI1ltma?=
 =?us-ascii?Q?pOcXfH8EE0I2nztTMsRkfbpc+de/DOoTBV6Wf1Qo4p1oD4/way7RDNWGILiI?=
 =?us-ascii?Q?M0sB9VsfZLSMrcVMDIJat5F37Vkfa0Shc1Z5JYOx/vO2GiDnQvSPupxC4Lzb?=
 =?us-ascii?Q?tn07Ecv5ehkuxwCc/ECD5jiDppgJrdvhPjV4rn9QN3R9V1eIgrqS3C4mmXkB?=
 =?us-ascii?Q?k+GS8qVPSG4NpNWYwMgOp/nMliuiEZ75ZG5+4c4+9dlUWS5rbyXV9evjj/xL?=
 =?us-ascii?Q?+YB8S7kBQJ/wxcA8c6p4c7lrwwaHGXL8V5tN7PjNcs3KEcSxrRu7S16STj7b?=
 =?us-ascii?Q?mLdpl2rHfb3bpxBJgGnONha0otkcjp86xmHL64WynKcOo+z/ouMALjhgNbdR?=
 =?us-ascii?Q?crc6QuuL2PzId69SHa4SQHuABDCziQ4pAZa/StG+BRPV09uMmfAH+ASVnTje?=
 =?us-ascii?Q?+f/UJPJnXmBMkQj4Zsq/OJAGKm30Bos2ET4xqzWf7tH/kQJtS27D9uyqw8bA?=
 =?us-ascii?Q?WY02Bf0/j/dU9lff1DalhO38DvgStk156htLiwK7XJAxjubz+Tp3dZK2D2h3?=
 =?us-ascii?Q?ba9mbnxleiy/BirGXyagyFrgghgROH9NpZA6AO/5gkU1b2gcWolc+hhxr8J6?=
 =?us-ascii?Q?A5M7WQhNPLuIQMhXPS9WpQOU2azPVJoLs8toYroTzktLO7aD4yZHR5Qbdf87?=
 =?us-ascii?Q?nTeyt3exQoSwdSwpQ98vETM9W6kTQznTVWfp1j8n5CyRgcyTxgSmAvyxM1Ju?=
 =?us-ascii?Q?alfLz3NFpeBXZ7JkAfSoyRpOEMkYT0dJaSJA4CrwG/7ERmGkSn6ySzPKcCCg?=
 =?us-ascii?Q?DCE32maIPuNEGpH7mgWf111KesbAfgKnEIhiggg80dnDUXZqsH/aFXuNHBk2?=
 =?us-ascii?Q?jtEBrsrvBiJvLvSn+BJxwZzaaFCqrpSNZ89DmLncRw34QR84PFesKQaDta/y?=
 =?us-ascii?Q?9vfAgoPkTtuhasTYrGGLUirHhkn8cU37DAN4u+G0+Ket0BZUO71sPR0pqn+t?=
 =?us-ascii?Q?+AUGOPg1fbDlL5Ck4vXBkfITRkMC/QIjSurRsEboqoXuHRccefh9L7z62OFp?=
 =?us-ascii?Q?mlwa58qBx6jayjHcEgE7zLbIYv+n/H24L6r0FekmzX4rFqijtlvGxeb55J+P?=
 =?us-ascii?Q?YIM7mMpO6yXaB06fUJZ1MotkQC6CaSrMGEHmabC4aozbZa96D+WAMgAAnGNg?=
 =?us-ascii?Q?H6qu6jLHI3Gv6E0XuI5zHBUmN3xuJOyGzOQ8dAHzhZP6x43VDVlsnTW0zp+k?=
 =?us-ascii?Q?65pcj91Qtvj8GQJv7PgrzBAz5sgmsJ0JLujx0+O5U14XyW5+zTaV16h456Iz?=
 =?us-ascii?Q?H5b7B9Jy/ycD7Y0gK+GtMGlCjJ5Pu36/RupFczVPVZa5pbWaYaIB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c9888-1acd-42a8-d049-08df047c824a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:48:12.0919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuK3eelUZhPpT8pPGCl4+6TEJvljJm62jJwUcaCsKylmIb/KlTC3XNO8mQipaUcObAK1y1D0QAPb28WJMX5BQcJdNyAjqyRd0jelM8HoIFq1HrxWdTWVk22UOneL++4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11569
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Aug 27, 2026 at 03:33:00PM -0500, Rob Herring (Arm) wrote:
> A WARN_ON() returns a 0 or 1, not the original negative errno. Just drop
> the WARN_ON() as the FD open will pass the return code to userspace and
> there's only one possible source of the error (drm_sched_entity_init()).
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_job.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index 6a038c0384cc..99c8812691e5 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -368,12 +368,10 @@ int ethosu_job_open(struct ethosu_file_priv *ethosu_priv)
>  {
>  	struct ethosu_device *dev = ethosu_priv->edev;
>  	struct drm_gpu_scheduler *sched = &dev->sched;
> -	int ret;
>
> -	ret = drm_sched_entity_init(&ethosu_priv->sched_entity,
> -				    DRM_SCHED_PRIORITY_NORMAL,
> -				    &sched, 1, NULL);
> -	return WARN_ON(ret);
> +	return drm_sched_entity_init(&ethosu_priv->sched_entity,
> +				     DRM_SCHED_PRIORITY_NORMAL,
> +				     &sched, 1, NULL);
>  }
>
>  void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
>
> --
> 2.53.0
>
