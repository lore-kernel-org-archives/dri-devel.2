Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA94EC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EBA10E4BF;
	Wed, 22 Jul 2026 18:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="koRr+jpD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B32910E4BF;
 Wed, 22 Jul 2026 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784743824; x=1816279824;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YlL5okqVm4zrUMUnGAelbWMQCqgkS2XY7g1gJVlqfeI=;
 b=koRr+jpDgd6XFRyOuE3OqWvZVG6cFGvD+69Am0+U+CkkY1qTi9XYOixm
 TQFmJWNZZe+hQwFUQGRsuK30h9KaG38bsWH2hj9gDbZIDcSe8nB2SjPV4
 YgtxoA7vjaS/UNQ2VLk/EbxXcwKHYSKQM+W8IH52IrKlLMzPhscF5S3mX
 2YTJcAn15sMe9DSZ5vW+r/ZguAEAcyZvLgVqRr9KbNEkAZAiqS7OwYB20
 37UUU74jUEFkonKdJqqrF9pOM05YyuRZzsJ45w4/TbvJjJZhJ8LdJXp2S
 V+pc3KmQx2Vi/5b2ivqG8RFqQcLozE9tSgklWaxZpRMjdlr+Vus3aAfEV A==;
X-CSE-ConnectionGUID: e0vyoFtwSiW6NvT2eEfJLw==
X-CSE-MsgGUID: cBcXPrs3TtyVNo0ySd5kjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85582156"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="85582156"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 11:10:24 -0700
X-CSE-ConnectionGUID: mS+9md2jT4Gjrf5/8H2iMg==
X-CSE-MsgGUID: ancjQtoGT5ONKsPVsDGnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="255517084"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 11:10:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 11:10:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 11:10:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 11:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usp2ucC0ztV5xQf915KdIoovK/tS/1qE5DHNvUnanvsdg1YouBlRC70O5P0FHEloqhllwRNwT5dIjiSxXX8wGKkh1y9XNAu40+jnUTrFWAc65DvpP39Q7uZjNG22wZ8qz7XKd6eLwWkDHY2ERN8uUWUXx2NBbEii+UCuQnd2snLWwEo+OhunyvLJ+eJFgERgzG07ovJB+OK3G4W/sq3tHjldditF6ia/yZ+Upoyu5qWySrpNbIb73cP3HMWQG4aIlLIxvOgXUGL2KUwV6K4b5RgTlA7uUPobKLk2vjyHB5UnEg8iQp3yAlRWO6se8Iq1m1vbYJD8lJDPip+zwqbc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lb5/1GzFrBXvZR6yy/FCkZBWgclfzO/sLyjWxBN2K4=;
 b=RUvGl9uU6JA/4Kqn0UsQBMcgiME2C8mYOVvrNMsSEVxXt7k+yUVPuRl4WFq6FpEwnU6+1R4qo+Z1RTgJy14ZwLstBCuIlA4jd1c8Zghq8tOL0JJFgVtErLyQO1HMhjxRxeGrsgFHfJUuX5Qy6bhd/ArOnbkwm1vxiIyFQ9EmbgwyL4IaRwMrjdDirF5gIXs7ZV0C1TLhsJEILXjFQO+Id+ImAwQ22tb5xT1x6Ca2O7vbE7WBSfeP8OuW4ZUxHrlcGRdC7WgFt219s+W+8d14VfUX5wezUaPf7SjL2xjkZFJi893r4uvgPtsJ/buaGmdXPqq9wGQOC3G2eyZeu+FmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 18:10:20 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 18:10:20 +0000
Date: Wed, 22 Jul 2026 11:10:17 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR steering
Message-ID: <20260722181017.GF2327163@mdroper-desk1.amr.corp.intel.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-2-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722004654.744249-2-talesam@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2446ca23-165c-44a3-00eb-08dee81c7dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2m82m/Pajz1tXaQ+eUkUwt8M5CBp31J89S4lHuswFWpcZbj6RSZ4ZdZlCjpaM9gG03o8E69d0va6I12YdZGGp3PrCO/2H+wMZEyYaC22+++ZHefTyaknyz1vNYJWdWKz2ydg/1vfuT1vImjZOL8T72vPfZthYk3Wxq0JzNDMmZ+HDcoyxUgptAYHV7qfeU+Hz/TbxhMnbaSYRpetWyUCpuTaTsoxoSjSDg40yoSTIH3GqrsWQwa2GVXHAanL0QdH8HfDvl/mR1oDFk3D71tWUURoWm4nCvPv8nDwjJkOeKUganK8zlBIr2mVk7AJOSJa3CNicis46dI/o2qb7MGlUELMc6t45bKu6jfUBzGCNQtuLbqB16cOaD4R3DsAl37k/ggC+raQL7CB3Mcz1qL6DFAZCkqfJYD4XMKT1jAhUil9gMy3sR+iZWYpl+4y8Vne8wBUnL2XTT1sIsBPSlRa+YCAbaARfpKaUwXhfBB428yggn5/Msc0fDnJJl8iVUyLyVsD0navOLbRnJt9lBWeE49AvkT7gNWSSEfMKDq4RVmo93z6mAYafLMFG//V0VRACDlxZVjdqVNmbev9g8kyHgidCg+EPWGTj5cQASmnt1uN1h6RmoMK5gpq6MzEul551UEObQuaT3/2czs3Of6ABrk3/Fayp1L+QX3CUx8jEjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rZI9RS1BWSgcViGhYKi5hq0Th3rN9eyO76Wh6vmeMGt6FO5+RZaEygA8NA?=
 =?iso-8859-1?Q?vr7YGVnoX6eNwzf7tdShPxw154srE1fwDwNzQ5UwJWndsM0BCsOa8BMQ3M?=
 =?iso-8859-1?Q?K+N2sAE+RzmgOKJ+YZgSZ1Lp7zsCbFrLF/aFcfeP/RmTBSnKfG+ZyqgwBT?=
 =?iso-8859-1?Q?pl1eJRM+BWD9M6C0IBnrp92G49ZiCMGFtLV2pvX4QKoHxKEF8bhYLHWg6F?=
 =?iso-8859-1?Q?tTmkmE1z1K8sZhmT0pAuuK6l3gPMfT7ARrziKKV1moL5dT1E0JzPreX++m?=
 =?iso-8859-1?Q?pO+i1ak4mXDirT1sKYEqXmb83XGDi9Nx04T2z0fN2qstJ1phISIS3bfMsM?=
 =?iso-8859-1?Q?C/4QXE9uyVPPTxzPjDgJTrRlcTgsYdmpWRwK1b30gawy/Xbltup+/Lwiby?=
 =?iso-8859-1?Q?6bVv/xwijG9dnabLhQ0yQtPB+LqmFOoIhY4x1yoQ/DsuV5OWCv8KD4beR1?=
 =?iso-8859-1?Q?YZYdohUQNHmtemBYDxakHVYOAiMbnxTCvhP6/DQpPTbPwuG4un8Eil6yAM?=
 =?iso-8859-1?Q?PuW5T1pq2WbnO7wonqiTMa/eLHd1cAD87zBMsLfTgkRPNCCCnuxRRhWq76?=
 =?iso-8859-1?Q?IzGc40P6MnxiWYm/saKpOH/2vsK+YG4ZYNXVQZQTOc5L++Taux4crFtRSB?=
 =?iso-8859-1?Q?8WXetsvmgm+EZlQYGhNptf2USXi0nVqXedk4WVRweqyRoPAh/QiQ5GVZNM?=
 =?iso-8859-1?Q?pYQfx3N1yxJKcoha5ufdb9PWjNdMqfSKhgLBVFgthFCiLexJt5sRxf65r9?=
 =?iso-8859-1?Q?5+OC+mQE7CUnJKNX5ZojoOAndetg7TRDxYqbAkPS3Cb+B2+9hvhijhweZO?=
 =?iso-8859-1?Q?dtGI/m2NnUCsJAfDBpXg5N8PXbEAdg4/8VdASpxDBd2DVVI6ypAV8VjZQ9?=
 =?iso-8859-1?Q?QRKOd1P/a2+uB4Gdiq0nCazjb8FhaPwET66YtsXr8SEW0wLaJVA9tPl/2I?=
 =?iso-8859-1?Q?tSqCWUDBlmewNpX4FJZKNSHlRouo37ehM9ZsdKa6iySoc5vODAitSnur1y?=
 =?iso-8859-1?Q?ibrzCo4CGKkLK0NNADVWBz7axsceny1eRQIe6bZFV0rwBFIMuUfjVQyu6I?=
 =?iso-8859-1?Q?M3Uxses2I5bNZ/ag+BiUa5Teep4Lxo8ur9u34gh4MOyPrV0YflaD/qMLAE?=
 =?iso-8859-1?Q?aMvT+BEEwDkqqAvItJ6hgiJSXr4U3NyirexhMug0nua8JagkADI+KO6xNC?=
 =?iso-8859-1?Q?hRDuYN3GSrbdXu8LtTuaoYLDDCdurD6JvKxZLECcmCnqDXblSPtBqxTom1?=
 =?iso-8859-1?Q?cEiXIbk4Z7aJN/GuQou8I96XBg7zVY9+5+yy54ABP57w1jEaXIOdC2R0cc?=
 =?iso-8859-1?Q?ZWtDwU9oGA1W56xsLhXcU4FvjvFfVcSL8dOrN/yQfd1Pw1MyOuyC9VNvBo?=
 =?iso-8859-1?Q?eKupAFveIZhbeZvpbpciMqgk6xbbQtvTm3dhLNDJAVoG+OGcUkLtIrvRhf?=
 =?iso-8859-1?Q?cFrCtuqrrqU4sPkUBfIpz3+4Koo/wrjDq4sLxuqxOv8il1ksKzmRY99Ugr?=
 =?iso-8859-1?Q?gXbZdVk8RRR9Q3k7BwrCY1uH7caEOh1YF/pgW7i+JR1kDOd6HGu3jSCene?=
 =?iso-8859-1?Q?2XejsO1Yxr2H+YrxxO1R1FcQ6DmGyQjPhG3EI3501NXbP2+aNnW93SNVpj?=
 =?iso-8859-1?Q?M4xjKRYFZb4shgHjeCbw5Vy7vGBHTcl8BFzydGiT/yzM7jB+2qNMZGtLra?=
 =?iso-8859-1?Q?0orTRTnjV9VehEkipVMXBPxdBbpc1flg2dQv5srV6l8UQeX99T5dj6s/mu?=
 =?iso-8859-1?Q?4pUZGHYBy0m0udckln3zJ1XEuYR1hx2N8kMZsOPFdaMkMzVsA5Z7dDNwBP?=
 =?iso-8859-1?Q?Xj/2NUzZD6PO1uE51PEQWlJYtzjyoTo=3D?=
X-Exchange-RoutingPolicyChecked: sO6bq4YYhRiEpqzGLUPkfIXZq0Ofwv3Fl7zUViBXE2qCJmcVOrUV69UPILcXvEW8jJ2DGCtZj8mbobkD8mA9wNYlHSqpUEIFz7wdsQtUK3GuCClr2+N6OPnBNnqNTcxC4Htr2knMbbHYNjj6JMffuzvWHVYWgoDAbdr5V5+OCuImpiRKdYnNQmNyzaAyxPIMbEJUTew66eKz9G5UykZHimy9yB2eDI/el1KgGI8b2b6UY+6LKT1C2pspkJHpwW+oj9WUdVwneirVezFt5uMw0MFp7hdFLfEBRwJqPNp2yUDv1Af4rX1JwBw2FT8wAGTaCDFiMcBNDVCQSsB042V36A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2446ca23-165c-44a3-00eb-08dee81c7dbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 18:10:20.1936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0StR+onuoupgfvrLVVhhh4FH7xpqbNMIZDT+n9YWrAcZDHHYtBNo95p0LQr8vuhSd7w/5DlCCdxu+Bn43ZytC+dI0o7VXbr6kPLi0UVhH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
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

On Tue, Jul 21, 2026 at 09:46:51PM -0300, Tales A. Mendonça wrote:
> On MTL and newer platforms xe uses STEER_SEMAPHORE to synchronize MCR
> steering with external agents such as firmware. The current code waits
> only 10us for the semaphore, while already holding the software MCR
> spinlock, and fires drm_WARN_ON_ONCE() with a full stack trace when the
> wait times out. On an Arrow Lake-P system this triggers during resume
> while firmware still owns the semaphore:
> 
>   drm_WARN_ON_ONCE(ret == -110)
>   WARNING: drivers/gpu/drm/xe/xe_gt_mcr.c:697 mcr_lock
> 
> Port the i915 MCR locking model (intel_gt_mcr_lock/unlock) to xe:
> 
> - Wait for the hardware semaphore before taking the software spinlock,
>   so the wait may sleep instead of spinning inside the critical
>   section.
> - Allow up to 100ms for firmware to release the semaphore, matching
>   i915.
> - Demote the WARN stack to a rate-limited GT error, using the same
>   message as i915 for easier cross-driver triage.
> - Grab GT forcewake before touching the semaphore and hold it over the
>   entire lock/steer/unlock cycle (Wa_22018931422). The steering
>   registers are in an "always on" domain with respect to RC6, but are
>   sensitive while higher-level platform sleep states are
>   entering/exiting.

This workaround only applies to specific platforms (MTL and ARL), but
your implementation here is grabbing forcewake on all platforms, which
we don't want to happen.  Workarounds should be implemented through the
workaround layers of the driver (either RTP or OOB) so that they only
apply on the specific platforms that need them.

I did a previous implementation of this workaround a couple years ago:

https://lore.kernel.org/all/20250114190242.2026743-2-matthew.d.roper@intel.com/

but we decided not to apply it because the Xe driver doesn't officially
support MTL or ARL (using force_probe to force Xe to probe the device is
only intended for driver developers, not end users).  Generally we only
include workarounds in Xe for unsupported platforms like MTL/ARL if they
also apply to one of the platforms that the driver is intended to
support, or if the workaround is trivial (e.g., one extra RTP entry).


Matt

> 
> The GT resume/reset paths already hold XE_FORCEWAKE_ALL around their
> MCR accesses, so the forcewake reference taken here is usually just a
> refcount increment; it closes the Wa_22018931422 window for the
> remaining callers (debugfs, OA, EU stall, etc.).
> 
> mcr_lock() may now sleep; add might_sleep() to document and enforce
> that contract. All current callers are in process context.
> 
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_gt_mcr.c | 70 +++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
> index a97b236dab7..e1e3c0688dc 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
> @@ -10,6 +10,8 @@
>  
>  #include "regs/xe_gt_regs.h"
>  #include "xe_assert.h"
> +#include "xe_device.h"
> +#include "xe_force_wake.h"
>  #include "xe_gt_printk.h"
>  #include "xe_gt_topology.h"
>  #include "xe_gt_types.h"
> @@ -58,6 +60,8 @@ enum {
>  	MCR_OP_WRITE
>  };
>  
> +#define MCR_STEER_SEMAPHORE_TIMEOUT_US	100000
> +
>  static const struct xe_mmio_range xelp_l3bank_steering_table[] = {
>  	{ 0x00B100, 0x00B3FF },
>  	{},
> @@ -692,33 +696,58 @@ bool xe_gt_mcr_get_nonterminated_steering(struct xe_gt *gt,
>   * to synchronize with external clients (e.g., firmware), so a semaphore
>   * register will also need to be taken.
>   */
> -static void mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
> +static unsigned int mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
>  {
>  	struct xe_device *xe = gt_to_xe(gt);
> +	unsigned int fw_ref = 0;
>  	int ret = 0;
>  
> -	spin_lock(&gt->mcr_lock);
> +	might_sleep();
>  
>  	/*
>  	 * Starting with MTL we also need to grab a semaphore register
>  	 * to synchronize with external agents (e.g., firmware) that now
>  	 * shares the same steering control register. The semaphore is obtained
>  	 * when a read to the relevant register returns 1.
> +	 *
> +	 * The steering control and semaphore registers are inside an
> +	 * "always on" power domain with respect to RC6.  However there
> +	 * are some issues if higher-level platform sleep states are
> +	 * entering/exiting at the same time these registers are accessed.
> +	 * Grabbing GT forcewake and holding it over the entire
> +	 * lock/steer/unlock cycle ensures that those sleep states have
> +	 * fully exited before we access these registers, matching what
> +	 * i915 does in intel_gt_mcr_lock().
> +	 *
> +	 * Wa_22018931422
>  	 */
> -	if (GRAPHICS_VERx100(xe) >= 1270)
> -		ret = xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1, 10, NULL,
> -				     true);
> +	if (GRAPHICS_VERx100(xe) >= 1270) {
> +		fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
> +		if (!xe_force_wake_ref_has_domain(fw_ref, XE_FW_GT))
> +			xe_gt_err_ratelimited(gt, "failed to get MCR forcewake\n");
> +
> +		ret = xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1,
> +				     MCR_STEER_SEMAPHORE_TIMEOUT_US, NULL,
> +				     false);
> +	}
> +
> +	spin_lock(&gt->mcr_lock);
> +
> +	if (ret == -ETIMEDOUT)
> +		xe_gt_err_ratelimited(gt, "hardware MCR steering semaphore timed out\n");
>  
> -	xe_gt_WARN_ON_ONCE(gt, ret == -ETIMEDOUT);
> +	return fw_ref;
>  }
>  
> -static void mcr_unlock(struct xe_gt *gt) __releases(&gt->mcr_lock)
> +static void mcr_unlock(struct xe_gt *gt, unsigned int fw_ref) __releases(&gt->mcr_lock)
>  {
> +	spin_unlock(&gt->mcr_lock);
> +
>  	/* Release hardware semaphore - this is done by writing 1 to the register */
> -	if (GRAPHICS_VERx100(gt_to_xe(gt)) >= 1270)
> +	if (GRAPHICS_VERx100(gt_to_xe(gt)) >= 1270) {
>  		xe_mmio_write32(&gt->mmio, STEER_SEMAPHORE, 0x1);
> -
> -	spin_unlock(&gt->mcr_lock);
> +		xe_force_wake_put(gt_to_fw(gt), fw_ref);
> +	}
>  }
>  
>  /*
> @@ -807,10 +836,11 @@ u32 xe_gt_mcr_unicast_read_any(struct xe_gt *gt, struct xe_reg_mcr reg_mcr)
>  						     &group, &instance);
>  
>  	if (steer) {
> -		mcr_lock(gt);
> +		unsigned int fw_ref = mcr_lock(gt);
> +
>  		val = rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ,
>  					   group, instance, 0);
> -		mcr_unlock(gt);
> +		mcr_unlock(gt, fw_ref);
>  	} else {
>  		val = xe_mmio_read32(&gt->mmio, reg);
>  	}
> @@ -832,13 +862,14 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
>  			   struct xe_reg_mcr reg_mcr,
>  			   int group, int instance)
>  {
> +	unsigned int fw_ref;
>  	u32 val;
>  
>  	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>  
> -	mcr_lock(gt);
> +	fw_ref = mcr_lock(gt);
>  	val = rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ, group, instance, 0);
> -	mcr_unlock(gt);
> +	mcr_unlock(gt, fw_ref);
>  
>  	return val;
>  }
> @@ -857,11 +888,13 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
>  void xe_gt_mcr_unicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
>  			     u32 value, int group, int instance)
>  {
> +	unsigned int fw_ref;
> +
>  	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>  
> -	mcr_lock(gt);
> +	fw_ref = mcr_lock(gt);
>  	rw_with_mcr_steering(gt, reg_mcr, MCR_OP_WRITE, group, instance, value);
> -	mcr_unlock(gt);
> +	mcr_unlock(gt, fw_ref);
>  }
>  
>  /**
> @@ -876,6 +909,7 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
>  			       u32 value)
>  {
>  	struct xe_reg reg = to_xe_reg(reg_mcr);
> +	unsigned int fw_ref;
>  
>  	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
>  
> @@ -884,9 +918,9 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
>  	 * access, the MULTICAST bit should already be set, so there's no need
>  	 * to touch the steering register.
>  	 */
> -	mcr_lock(gt);
> +	fw_ref = mcr_lock(gt);
>  	xe_mmio_write32(&gt->mmio, reg, value);
> -	mcr_unlock(gt);
> +	mcr_unlock(gt, fw_ref);
>  }
>  
>  void xe_gt_mcr_steering_dump(struct xe_gt *gt, struct drm_printer *p)
> -- 
> 2.55.0
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
