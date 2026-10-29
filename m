Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B675606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Sh1X1IeX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983CE112417;
	Thu, 29 Oct 2026 16:04:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F27112417
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o826O3Zcwo27fzoZWaH0+aeymXkC/OqObYg+qO9h+6MmqjfcTRj3uH+Xa6unjVxVoOnNEwctg7qtNgRe/vXhfNHz+gY6WB2p9AloCHDJyIi9scBj0z4jGUhQawc51XsKWusrwH0NiuATqUnJQmZqROtJtF/JJJDjqLVsYi/RGAB4LjZzL1DCNZB9pyzp91jQKzrmbB2mZu2ZuoNl1qs4xbzXSeDpRTpSI1j70YXjYLvIYl/BjDJqK/N6tCQgkwnmiXcPvRxFNRMAJQF3BsxlDgw2pTnhMgmxrZhO5Dl1pc9KSOjOquLjd4QMizfQceQ6CS8jf3UCEfu0fXEtA/Dzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIgp6vL1AC4inpBW23GiubnUudX86vJkUim+knVvdvo=;
 b=OsYm+47DdPxGqeRr9H4EtW7l5XqGh/8mxddFytwIcpaOJJ9jcMWWmocJOQqFCD1+7U1AlZr/xlXaIUIXwkoJJya3+ggNacJWp4ukQajs9gOYeYfdsQOsEyyK5JGd+uDoxV5oGlQ+1DfXvOZT3032OMTuoCrPPHI3NJsqVRm3NwWRhEhrSphTutZ7jHRwkHYJT6IfcLUCmk96oFSSvFQC8qbGnEcH6Uy5BRV5A/GiNMo1nfJDjMgdVgTkQ9j8rp3iEVb2vIvYo5aobdCMg49PXP8XyDdIP7+GWDTDxf4uC32lBKUBVEmsy8lZLrBwZ3Z0XNHh1A/Go5ZS3KFsrDht8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIgp6vL1AC4inpBW23GiubnUudX86vJkUim+knVvdvo=;
 b=Sh1X1IeX7vM79emAdM/pbxws6Ygejaxiz+mALmsBsy4zUkBTjbXJudZkvJWGGTjLAUmMH2ath8kDH2d070GO7errZ1t5ECZScK6h/nu6KFajLGbqH8TapUjlJT5QgSBrZVoTj8Gb96DHxpS3vrqIMwycH2el8Lt6IyfrVGctjT+n+LfZoVAD1lMLZZTSDI/UemgSUOZIAo56zzV7v77FZDnkmlp3TdYrt7bLs81Ho+cPCyG7VoT6GjF7orzrpHwucI33rPE7lNaGoHeyS2fRCd7iiXA3qNVqqzsbTA5rfCVWNmxcoCXx2wYWv3A6KPHbiRXlpVyikro2agtiO2QZkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:03:58 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:03:58 +0000
Date: Thu, 29 Oct 2026 12:03:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/31] accel: ethosu: Fix runtime PM get error handling
Message-ID: <auNuZw7mIM2gXfi5@lizhi-Precision-Tower-5810>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-6-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-ethosu-fixes-v4-6-4aa25e22578e@kernel.org>
X-ClientProxiedBy: CYZPR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:930:a2::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: db7f3bcd-973e-4906-b14f-08df35d63dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|261009223027099003|11063799006|4143699003|261021123027099003|10067099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: /TLmimP2APHEvSTW9YWt1f89jW/gRZAqXJYz+J9c+zKfMy+LfG0tQ3sM7mYe/yyS/b4MAQwbPGGTMbh7XDUK9UtTKuWAYF4vnTGHuiOw75+2N93xdnwZCgTEyRTCB36hIKnr6IRzMal3ciLXc83+n4qT5XuIXP/xGTsEEyLWAvzN6yrIOq9dQ3kxhWkhZxjEjlRETAcKPtsRngPh2krxBTRDkUFxvEuCgy0tQegUFbV8fnS9fYA+AR2VqeTjveqdUR0TSWlGPY2ZOYn/ugVypwFU5xEMwM6eEAM2V4kt4CXQW07bdXno7M/OiK5ap3uK3Pq4lGbY29+1s/kp1EhTIHujH6vzLTR95B8MluaQhqsr9jc+wgZfyYTekYnyxTsz0iFC0lI25yDLNghSQSdqNgzGTsUVhuyIz6DIS/o/l58pfcMF/9btQMsLL8C3dtIcLk2U3HbgVGBjWNnNhMDKV4/zKnI3hKxmp29JgkQhFx9L/hW/8F4IS51Tnc/od1Ag81FBJ/ykgubFh3VzasB/GD7TDBOJht9ZBuCWu/87tSaaiP1BzDZHLO+EWRCigs+rmXHrYnNyTVyMg3IgJuK8jF/fktoDzqpyQpEbKzDg5ESKbF57wm6eToF46fYGyyZDW0azAdrd0xubkiKKZLrAmwcWTNUawxpgnsQcDRMUjRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(261009223027099003)(11063799006)(4143699003)(261021123027099003)(10067099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwvG4yLD5S96Xf0Fj4irURu8hKPQ5nkpZzHUYMgGhrqHB6FpNTxba92h1PBp?=
 =?us-ascii?Q?IXsNDG7UQIrLnmbXraQjeRRbjs0q/VFqXI23xAzQTIkk10+SZqd1FkeUl07S?=
 =?us-ascii?Q?pkXHszmApU7MqiWVMHmuTmG6kMMF7nHnT79/CByCWm0hvpG+Exhe+3OLbzgR?=
 =?us-ascii?Q?Pw+rwte51f3UN5/yoi8ynPV08ap7p4E3VCKu4cFMfsTh7qNTLsWxH/2E9UZK?=
 =?us-ascii?Q?/zKsjXRgsIF4+YOebxqAF+Dey78UUCugBAfMPkPtmceCq/FtwI5QK5QiwtKw?=
 =?us-ascii?Q?EVLRGcq46XdDIXIJi8MOJozCs9RoA6OE16tmygms3JlK90Hm/Tu1YJP3EnL9?=
 =?us-ascii?Q?XYfFQEDhD5TL8tBWL4q3G0O9sNGDUXmMAoDO3OYrpS3QA5eVOhR0kWG7vwSu?=
 =?us-ascii?Q?7ryA8Pm09jMJG8WnKlQBWq8+IL1y2/PLdGnUQKmEljefpRFeEFyEp6Jx3Lnj?=
 =?us-ascii?Q?/F/9UHYyI8zilQQqlgSl2oujlyZq2z2I8pdVjLxi/gufAxFZ9qypXLWD171d?=
 =?us-ascii?Q?cMBQzf0NVQA0LDZdzzH1imI2mBrHKSZOZnsRIJYHWkZ8tLx8z62Wtdwyx9ZL?=
 =?us-ascii?Q?lQ9Z3T+3HZUrDUEYlrPXRvekKCi6DCE2abTmCTyPzws3cUDm2HCGbfRFGk/L?=
 =?us-ascii?Q?pKEahehhwVJgSVX7sNXsmhQbBCgq70rhl8LFSYlTSblJXYr9yS4KhPFtr7K7?=
 =?us-ascii?Q?Ruo0HvPViTYjcT/8e1Nh/h0o5ZKMMc+grymoxVhHD8ORpe/4HwHWtIqpOpwt?=
 =?us-ascii?Q?vfKHCckq5L/cvWuTYAB9KydSmFxV4oNeqkcd05IjlOvcVS8MVzBxm7pk0Tvj?=
 =?us-ascii?Q?sOD8wR1+v7jesVz33xJGMtTz7CP8i9kqnC+e/LbETan7fyf5KkhtbWs6VPmT?=
 =?us-ascii?Q?tlXjhlIQuBOk1j0LZBdJ7JlQoMBZJa+KYxDP/mogUfKF2a21uhZxjYEFvJqw?=
 =?us-ascii?Q?pD120uHQ8g992m41WUjptkEWOV9ZKjuzMkJo6i4eOsLjPwy8kRaExwl5IsJu?=
 =?us-ascii?Q?ok4EhSkVNhwWYzrZpudi51jgEbmjeqCcXWnJ+OR2OeNFfsk0l46gmcSoAZPt?=
 =?us-ascii?Q?RdcBR28i2xGTYpCOKlqcYkhFosDD7M+n9u1zE87djnYKE7rzRaC3TwSAezuY?=
 =?us-ascii?Q?hPl/MpTLNfd+vUrr6920L3m8eoxrpSbJj6nqwTDSM1SUQLNtUHBig3D3JWq5?=
 =?us-ascii?Q?nHiwD0Frck3e5MolURALej67MrZENJkMMjQDLuWnWGHp3iBSnasTxk6gbrqj?=
 =?us-ascii?Q?J6Etef7f/lSITtZop0FhL1d5XZBDKdvUdgBfKQgdBvP2Mmigvk0bSHKj5kTh?=
 =?us-ascii?Q?StllSWIPTspvjRvYbvWv5Si6yI3RkPjKNixIod5YVTJQE9i0GnmJrgCSbQDL?=
 =?us-ascii?Q?oOzyx4r1AP3SZtTdxo9oNzSA1FwPAhlY4xxM1VXouxX5jMlmhew0CEnxWB6a?=
 =?us-ascii?Q?Jr7F8svrZao8ODWEZtZ3QI6SwYMBxaPSVS9yrePZ3A1Dk81eBDh2lgUYRZUr?=
 =?us-ascii?Q?Sx8sShtMhm8SkZ3WJiJErq9SxpS8El2Fz9X3sYqL1knNuSqGKbrQPunK00Md?=
 =?us-ascii?Q?iJSWLoN77f+vSR1rzv+t519sT3RR3CW9S9oBOLl2AWz9XnGnDhWoxELjZqrv?=
 =?us-ascii?Q?6P1duhRmoZ9o8SsIcguAKmWuUBf2dz1XpxtVxTFUp5SquhVaCBtppfNxlcpW?=
 =?us-ascii?Q?DXcVkQEBNkAsEqh2Sa5pJOvdAALe5k7kwosw4EFS/iCuyTDHr7fJZWTNVgZG?=
 =?us-ascii?Q?c5UhGS6IILstDQSLIz4obYx96CYIKQv/XBJdyTEV9e+eWcBYQvRu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7f3bcd-973e-4906-b14f-08df35d63dcf
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:03:58.7202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6j69Jmlo2k0z3ataNWR3cKBngqRmtHtk0b3oKes1Adh9hChEH9z4DWI1zyBRkJvOpJ0OhX12gVenUAci8IGsG2LZYBntQEKwd2s8NRwjmCDvlBkII3d5GqyLU5/jU6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10889
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:35:53AM -0500, Rob Herring (Arm) wrote:
> pm_runtime_get_if_active() can return an error including for !CONFIG_PM.
> Do not treat that as an active runtime-PM reference.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v4:
>  - new patch
> ---
>  drivers/accel/ethosu/ethosu_perfmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
> index 26f625374f9d..0ae2df3ceac8 100644
> --- a/drivers/accel/ethosu/ethosu_perfmon.c
> +++ b/drivers/accel/ethosu/ethosu_perfmon.c
> @@ -71,7 +71,8 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
>
>  	ncounters = perfmon->ncounters - 1;
>
> -	if (!pm_runtime_get_if_active(ethosu->base.dev)) {

pm_runtime_get_if_active() return 1 when active
			   return 0 when suspend
			   return -EINVAL when !CONFIG_PM

!pm_runtime_get_if_active() shoud be correct if !CONFIG_PM. when !CONFIG_PM
we treat all devices is actived.

I think stub pm_runtime_get_if_active() for !CONFIG_PM return -EINVAL is
wrong.

It should be similar with stub

static inline int __pm_runtime_resume(struct device *dev, int rpmflags)
{
	return 1;
}

I will create patch change -EINVAL to 1.

Frank

> +	if (IS_ENABLED(CONFIG_PM) &&
> +	    pm_runtime_get_if_active(ethosu->base.dev) <= 0) {
>  		ethosu->perfmon_state.active = NULL;
>  		return;
>  	}
>
> --
> 2.53.0
>
