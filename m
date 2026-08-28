Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8CAC61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB4A10F402;
	Fri, 28 Aug 2026 15:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bwm97O+0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA0C10F3FE;
 Fri, 28 Aug 2026 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787932236; x=1819468236;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fwdNXkW1MQTBdf9vWEFs6tNEhvTzjjgTddYdRR7gdXY=;
 b=Bwm97O+08wOHq5kLbPo84VyGp7bihG/RWP8bIJVFvahQvtyxfzOAlopd
 hJAB/0SUjL/IpEWMdc+kE/1563XVEON6xy6ddlS9DPEO+9s/AbdKjxvzF
 yaeLtQ+bvJVAcBlPJtcbr+qkcF+P4BxTVKjUMEgY627Bbq3IAC3Z0nrWD
 WVM/HWM/jmyZCb7XpQe/36nXte5J3zcpNDJHNSKP4bcHA93qtHQOuTMp6
 NvSUFTCZLD77RHdhz8YDUBHqKSGmLkU5jc2Z0VgdyH/6NihMMimeXj50T
 ZfKcway2wpqO7rS8VLeOsg769uoOQ1JXYzos91OhBVkcEMh7pNx3slSU/ A==;
X-CSE-ConnectionGUID: rm70xVsuSHWVZ6clrvtP7Q==
X-CSE-MsgGUID: InAI0apIQsyGtCvOQbyQRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="90953960"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="90953960"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 08:50:36 -0700
X-CSE-ConnectionGUID: qf1Y8f8uTsuHoAMEHHUxtQ==
X-CSE-MsgGUID: ZwS8UP4aS7KiTBHjs5x/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="264438704"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 08:50:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 08:50:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 08:50:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 08:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtpBLVZzhwEvR1rnCrJKXp1Zp1NKehX0pk7bXnDSngU5AiKVtRSFizbsaMlwXDaoD4Mzlr4aSyweKrU+tWj9PYm8Rp0AGfzd2Axpvq6I+cBuvPmF49yPLAvrWmGyGA4NVd4lMrcKTVAyzQ8cuWhiIR+S19LJx4RBGXfZYGRr8X/vArTrSMyaDHj0J0Fz0j48rfIKxiwzYg+hQdtsy0lw4z82o2Dy9h2mS/dnsZ09OXWABMfqBUPXXg6vnN58nnwXSjqeJi0GmfMndWORmtIFUGHgejZhQhBqirVT75TDJTp22Wf5/XjMGhVxCxeRdQKec/lwkuFYjXAkCk29+AjXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhqpvcScFQSD8x2Y+KQoLOGmc3KbJuH/8bTa9EaSkJw=;
 b=FEew0hCf1CYNBNN+P80DSCnX203uDz/2w5l0b6UfA0Xb3rEXawtT65E0qxHpVEYv1Rs28WtxaryVXmgketaCpl++/+RpGc8ZaJDBRkXEiEKc8Hr2OOCYKehL6rJz4B84RPDmbm0312v/ejviehIOz6Ojf3tkci2StJK2SPQ7RmenVhGPf3GX+aNeqP1ob767LowyxpfAQy40U1Pjyj+JBUXP75n+i4xe9aFXZ5/6hIuAeMSUMw+VkyvH+q/MnG7k4rCltkUdQS727Rlovv/DQOXXRsWm3Wq+9PSKe6SL+g0nWq15fiCiE2Aob0PHJmFeP8KL6SiJfsoz/67kxXGmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 15:50:30 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:50:30 +0000
Date: Fri, 28 Aug 2026 11:50:25 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <yaolu@kylinos.cn>
CC: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <umesh.nerlige.ramappa@intel.com>, <jose.souza@intel.com>,
 <ashutosh.dixit@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/oa: Remove sysfs entry on idr_alloc failure in
 xe_oa_add_config_ioctl()
Message-ID: <apGuQY7vZRIUZghZ@intel.com>
References: <20260828060812.163548-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828060812.163548-1-yaolu@kylinos.cn>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ2PR11MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4001daec-029f-453f-a963-08df051c1691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8jyLcHukgJcWp2s0ItXASvh687mnVP7LPTs6qFTOW735kMICA9ueiFx4ohGQJe81pNSYhVnWZKVuzJ+2hkOqbQvNw1STtChW+s2xd31YiJEUFC2P3mxMgkcHPpPJpidqFefolwhnu48Ecn6lI9v6aYrBE8OiC6c/XJHfVM4k5Z++0WA06bt6LlZFIS+epUkEwNv5QQicvCj3Z2eoo3VW54GwUDK1XVjz0JYljCDl3veApoyXsYajFBSfAQdyVrzet9INF1EWYCuQPfUcEpyrqfeGQ2WRs6koCe8XHpIMqBfDE7DXvm4DXCApCGTsueqDZROEJWzGmVLeZ+KqkMTYndbAPQXNRl4RuEEUNSYueaikmardEedhNCnRchgkGPzKkWtN4FWE5RxLkaqcPnQyWHJ8NaBCPzo/E8XLZZsO1OArHDDE8mEAkGdkh4HIXEFkKpKFr83MxZsAWYIoE77Wc3P9XpP3CQjL7/UV7rBeBi9aClUfNI+PJDdtBygekHroaxUPrYNWNSJcj+PQ3c9N6ycJo3hL9S7QcKKplU5ejHO8rFKMaue5Wb94BtVLTM+xZJJT2IbGbFLxF/bpmfJZ/RNiNtga5R6JuF3xbU/TWqHXhkl5Efct4hEwjPSErSIH6Ae9bWTlyie9k/6z3s6sclOT/bx2LD/SSbHqfr1aMvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+XEUhGWj+sSGYz6HGVbvEtA9HUA4BVN1eIlqmX7N8mp8MBhUioamqoT2rQpM?=
 =?us-ascii?Q?HwP8uUXs1Hwcyd5K18vAMfSTvydqsoEEqRCifiv/SvibvnMyNqEm6LPBiK0x?=
 =?us-ascii?Q?3YSfwPEzNzBN3y7hSiI4/efcMHhmTHJQnXAANcAwFme7GuqJq0ZGV7mSB2XF?=
 =?us-ascii?Q?9Ra/+A5ViV/QjJfWTMBZLQNgiVkHT/CGCzu+5lVthvh7GDtdbknUHB0X/tXJ?=
 =?us-ascii?Q?a19E/zG16q8jNIj0E/ZfyemKGhLAX/v3335s6cZpdmqWpEXZcrDXwOKrNygL?=
 =?us-ascii?Q?Wqc9HH/QTLdhkpqLO4xrF9WaA+wPzT1KbI9evVaoSuWByAw34MVqctknfQ9M?=
 =?us-ascii?Q?/uB6Jt2vEvEzvYMbJXbXEbZTiCPYbN4p2AArO7DkH9G5Iy4Oo6409v2/xaW/?=
 =?us-ascii?Q?MZbs6Y6Zj28LLXp3+btqGJWqL7qLkm1EldRlTtfNFSMbn23ZD1escpyMrXdx?=
 =?us-ascii?Q?/0es7Tg4u4ZT+I6Zfr5vGCWhbXSOjAhniT3SgSTJO6WBdmWWpZXYxaMulZaN?=
 =?us-ascii?Q?wylx47fL+gXj+NbRFduBFR1klzU65fKraHGMhIP4KaIuuv2WHlwZDYuwmcaJ?=
 =?us-ascii?Q?Y0a8iPtizuIREzvPgHFxTwFa2SRgC0nxGz12PzjhThlJj6mK6pNpu4bC3BMI?=
 =?us-ascii?Q?UvMpBKFHkIX6DWoBtvr0H6B8Uy9h1KVSLaQvrjuk4sc99ryp5yKtapnHUFZD?=
 =?us-ascii?Q?mnF8tH9bSxHYv6hIzWjKxKLTCH2M0BHElLF4aYqpU1B/ffgv7RoLyXyT33ke?=
 =?us-ascii?Q?tm8jZgD8Y7Uf/UH8pfGTywx0ebsmD7nvUFSXdyOwZZoFb4MRekg5AHaymfYw?=
 =?us-ascii?Q?WikOx8DS5Xz6RT/8k5zW7IgUvUrtyg0qhjmZMqvsEJ6aa8RGu7d+VK00c1q9?=
 =?us-ascii?Q?btDl7EGlTowjb9Jq3cE1i0q/E5OY6gMNsj0IuVpTMNj1SsFZn772xHywgS1J?=
 =?us-ascii?Q?Gb22MMDpw0Kwhb8X31TYJeB0me3ME8zWjW8OYb7qTK2mXy1xqdFCHXMYBpkn?=
 =?us-ascii?Q?5499Tx3JKcWMMxGDKtDC8xyf9jtuXt6XFTJvvkEMIUTzrr44yM4fI+mhAbs0?=
 =?us-ascii?Q?nd4WFYcvgN5yzp16bb0HcBA1VqjV5oeo7gOKsgyTZw6+NPj5+cSNJWKG1Y4a?=
 =?us-ascii?Q?i/d8RYjb6vuTbLpbrAA2U8Gcrpc3uztYFpSfR3oKRmJlrRpEryTTjigZ8qhl?=
 =?us-ascii?Q?Y/igJtGG9Dt9nlpthl0/1d4Zsno8c7lhdd8dahAb21w82w45AqXyesVOQoaA?=
 =?us-ascii?Q?msJ7PNSOQ5Nu5SUqRBpZPVZVXnMC7q6OyuOaYH9QX0fQAkV/QnL+C0BlclsT?=
 =?us-ascii?Q?JdlKG6sKL0vsifeNdmNka8Y/XPBEdYyTkT8NXLJQ1+h2T9dbnAL8Un2qrtdd?=
 =?us-ascii?Q?LsN2Bi5wqb8xlziWbBIU1uPiybJsxn9bWaXZizn0xz2/65cjmrz5K6KI/0Et?=
 =?us-ascii?Q?pmvdMyG/3NfPVcSoL+/nOHHnbZgci23CKsxPnGleSHYnbq6YV1/uqOsguYQb?=
 =?us-ascii?Q?bq9jw2f3uB/HTHXvkpMG0o693F3MXvgApikxcW1tD6R/QOXIReop0+cdwZbu?=
 =?us-ascii?Q?iMS96swVWtjPNrWzFCpOUZrctwUFav50YOWLrVv9ZZZ/64/+9i14wHjZfp95?=
 =?us-ascii?Q?7sGureCIbXNY/4Pkj/NmU8iR/tjEDkEPYWz+ktCs7xHuEJtdQjfczlyatHqB?=
 =?us-ascii?Q?Rgh9yempO1QEFJkMMZq3Yz2WcZ8b8WHtBPn2ZKUP6CEbf8v91fk4ORutZsNN?=
 =?us-ascii?Q?2dFeDR0ijQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: KWsaNgly0j7FrPV9lY/Fs6TsdBiBTlk88sOLc7Amba5EdKLabtrzxo7y+vL+hu60daXs0wsdB9nkicLsK67skOtJuxcZPVTjkX8d/3I+axZAFt5Zl9Fr8YTvaFmNwVv+SgoQm33lXlJeQAEC9q3QAHrh0GOBXmwO4rfcIzIs7+cwaX1DEHUenamf72RsRkH0zGRNZAdnMI24iBesc0vwesK8x5gJ0iDP4Ub4gVHrctE+7tzKIZy6yX/81+MdB9/qZEX9d2Co8OJSYI4sXu005Qty5tElZwtmp2Ok/kDot/UN6ekF+I9/h3OIt8I6Jio/14RxuvcGqt9qYjs+K+K/Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4001daec-029f-453f-a963-08df051c1691
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:50:30.7693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF+Al4dFElZ+MbrO9YYgUyy+beAGOa1psnWGDJGmgM1tuXD0eV3Ij2pA+ejlwLsqEcZU7OtAfoai698vjasIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com
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

On Fri, Aug 28, 2026 at 02:08:12PM +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> If idr_alloc() fails after create_dynamic_oa_sysfs_entry() has
> succeeded, the error path frees the OA config without removing the
> metrics sysfs group.
> 
> Remove the sysfs group before releasing the config, and fix up the
> misleading error message copied from the sysfs creation failure path.
> 
> Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/xe/xe_oa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 9c5384b95c63..73e51db13f56 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -2435,8 +2435,9 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
>  
>  	oa_config->id = idr_alloc(&oa->metrics_idr, oa_config, 1, 0, GFP_KERNEL);
>  	if (oa_config->id < 0) {
> -		drm_dbg(&oa->xe->drm, "Failed to create sysfs entry for OA config\n");
> +		drm_dbg(&oa->xe->drm, "Failed to allocate id for OA config\n");
>  		err = oa_config->id;
> +		sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);

good catch, but instead of adding this removal here, could you please
create a new goto so the error handling keeps consistent?

something like:

-		drm_dbg(&oa->xe->drm, "Failed to create sysfs entry for OA config\n");
+		drm_dbg(&oa->xe->drm, "Failed to allocate id for OA config\n");
  		err = oa_config->id;
-		goto sysfs_err;
+		goto id_alloc_err;

...

+id_alloc_err:
+		sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
sysfs_err:

>  		goto sysfs_err;
>  	}
>  
> -- 
> 2.25.1
> 
