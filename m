Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E004FF4942
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A4A10E3AE;
	Mon, 30 Mar 2026 05:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bkg7bN4u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323E410E3AD;
 Mon, 30 Mar 2026 05:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774848393; x=1806384393;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9pKdK7w+v+0Jrezv/wn08yUjIfLwxsPjx71bHNC/TGw=;
 b=bkg7bN4uX5TK9SJ6WHYecZLxAdQ79DtzluBGEPPvj9F65ynYem9Nb9fj
 k7NQXpHMzBqEVP5dn7ZUqys7WLYkVgcDi7ohXUJYYru6NtkLJsrCp7Avs
 T7Us1EhXAQT+RnODgn7GzWi3HhpL1Lzp2gZrnWl54X+vJ+jkzB+aX9XTR
 SIko6V3LV2e4f/RPNV0XBs8jNqZzEmHR+jJTyV9p0fqAUlrC4vDMMVCmG
 OZuC9YudfIU42GhN4JN1ZAGZU5eIQDVgoKwkJzmuAhNHFp8l+OckoLcuW
 haUrOtaptzWagh5IoAyXcL9HQNE/bjT2b0OrYSEFx2Hg2cwZk5Daae+Qs Q==;
X-CSE-ConnectionGUID: 5Oa7PZlrTwyhIBlbcPPphA==
X-CSE-MsgGUID: bKh8zw9MQGqYPTH0vlCobw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="78428266"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="78428266"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:26:29 -0700
X-CSE-ConnectionGUID: xDe0Y4qHRMa9CNsc1ir71g==
X-CSE-MsgGUID: KXfG5qMXR+yGHnrqTxp2YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="224962812"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:26:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:26:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 22:26:23 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:26:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAeA8c2LT25lhYVQRetZOIrdUEatHFRNfsDPhji1hGfL3/TjVwuq1FGUrbZO8taoRvhGIJqxFJqO2Gx0pXKXyzCTBKDCIL/n3dVAq9QzE2r34abY70jSm+cHb7Lw1N50gTgjodRY2mQyTI5eeYVO9ZhD+znUexOmJunP4D5s/wxwUr+D1sUBl3i6EmNiHdb2ymeHNSPuk7/reiy4BUpME8MTD6Ew68qCxP8e1xUCi5TDEMmPagLNeH27Ba8rs1KO1oo0z6yHLzNPaJ1xkXP/UOSdzlHeo4qNWr6Y8Uhm6kOfBAZopmQpOE22c0ExCXecV5W+/vVSguxIVMC1D1zywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11sioPmVDAz07vDalsjJeeLJNHXcbW+zAAjNoWKZ45I=;
 b=C6sgV1jfNqKA56voW0Mcy8t4vH49heGBs3qDG3oi8LR8wnNEXOpdMag8B6twJWErw3f4XyVWaat5339OF7wpORwru5zGounJ8n9xxCUPmO9a1gFs22MKCSbyQHNWG2SunYyEWOIoaCCZOWV8saxymkbemE/FkIhS2jKzi7mirzI3Gm46pGl2jJaQ0BSvreRhGRzwU9OL+yTP13fqACgIXi4VHbi+4aP0HnxGCLO0I/0CZBHa+9DqXkRSSCRqyDGAvwg09SSOr4m/JcwWyViYCJixiFuqAy/YivmE9RJHTLOPcL0cMfMmEJumpJV8TBtLX6AyaswBlPtFT6XFe4ArUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 05:26:20 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 05:26:20 +0000
Message-ID: <d3504362-19cd-463b-bfc2-25859a2466f5@intel.com>
Date: Mon, 30 Mar 2026 10:56:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET for power
 management unit error
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-9-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260318064016.374656-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::14) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ2PR11MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a68a8ce-1543-4cb7-4308-08de8e1cdfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zTeO8tHtqY/nVr2YIYnVGlvqTTLQUt1OE2/lHNvriUnVA/JailpKf3Suv5nn/YJ2S4x4fKyARE9kanGQFj53nUraiHvsUXKWESDGF6FPHx8AawGXEtIdvTJiS28QLuzqie0KtYB231ihKS2KmhOItifNJd5MZkFaiEzWEqPIZECJ2BPgPQjm2+RdmYKtFWL0JDfzFQyro/ChMZIZjSqbX5rc2qF/W3UnlhKaEzJiVVeo9KwLl5nrJD0CBcjkrasdgdk+8P1OC9naqV0dSeYx76yx6834V7Zzv00m0rlRHRX3tvBrZk4vP4Tli4/g1N8Y2RFy9BADw2jA2UEcsCdKQP/ZkWn/KHQG8ZJmKKJc8zSboE58pWPWwFE8mUQYeq5p6KjOx4pp1vAR3hVUSV3fqbaVBoyYeDxfXP1QMPWRiZnQuwc1DGZPbUH1rZstCr6Bo5y7c1f4m0p47r5fdhAfQ5VxAUD4+yzSmgy2b2UMCkAbHXa33Yc+nwaK5+gxCFYY04JzH8ni9M17RWL+kImx/m2/5Qx2bDYrEt6AtRFPE44iymgxYN9yw0w/Xk3qm8UTVGMY79p0jk+vGV/1KeH/sy26kMzZb7i05rU2xNlDv1aUd7kKE1f56QCw5pZcQNXJTyBjNpH4VFUoC385paxAXOinBa/BbCmlJEiIDnbXwfRdieSNh+pyP8J4rRK1rFp00kn1MGBqZRjXMZ4fKYbztwrYYTOoLp7gzDT1YSkiSVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZKZGJQNW1mNGdrY1JTMEgxM1FFWDEzeGNYZmFHSzE3YmJLNjY4NlhwUWpl?=
 =?utf-8?B?Ull3N042TFNHQ3FxRlhXY1lYc3d2ZW8yTE1XaUp6TXljaHJhbzllWWxPWmtL?=
 =?utf-8?B?WDl2Z3NVS01nRWN3RStyU0xqRzdiL3VzLzlWN0J0MndmOVJlSkdaQ1c1QWl1?=
 =?utf-8?B?UUZIRmRiNUVnRE04dlEra0NqT3pkYjUybU1qd0VvU3J1cjlKKy9PZ1hBRkpO?=
 =?utf-8?B?SjRFK2VSRVUwUTFIUlpFblA3RVVxeHpXTXFjQStQNStXc1ZTc1VzRTlOTU5v?=
 =?utf-8?B?VldMQUVlYlV2UHZsRlFzMUtyREdUbDNQSU9tR2ZMMk40NEtFYytXUzhXWG5M?=
 =?utf-8?B?ZE9HSkNaWEErR2hjZjMwZWp6LzUwa2RNUUVyR0VXZkJOMFZWdTRSQjJiVHNE?=
 =?utf-8?B?S3YvY3ByaW56WHlQSXlxK0JsNUtTYWx4YTNyd0l1NENDK09UZWhYajNTSHhR?=
 =?utf-8?B?YUtDdDYrWHVGOGNINjlVV3N1anVxL2M5dmhMVEpLSU9lYjBUQnIwb00xcDVh?=
 =?utf-8?B?TFlKUkxKL29TcG5kOVdQVGZ6QUxaaXFkY0E5TE5peWk1a0gyYnd4MzVMa204?=
 =?utf-8?B?OUpidFVVVXg4N1gzMXdUdXhaQm0xdXRpR0gzVTFVRTM0MWw1WnBjYkFwYUVk?=
 =?utf-8?B?UnpiUGd2b1Ywc1cwM0llRXZ0cFlFOUxPdElOLzBDeVR5VkxMdjV4bm8raERh?=
 =?utf-8?B?WkJCME5jUmpTSjJBVmErVXRIR2R0bURHSGNSbkMraXRKTDZvV3NPOXFQQVMy?=
 =?utf-8?B?S0daNk1xc1BkZzFOeGtpQ3BxU3RMcDRvTjhPQ2crakEyMjI2ODEyTXJYcnNW?=
 =?utf-8?B?RHgxdFBydmlhcWs4TFE3OEt5eDFTbks4SlRwQW9IbUVqeWNLbktuS0Z4ckd1?=
 =?utf-8?B?eFh6WG5USnZMcmx4TGRaQ1ZleDN3RHhReDJlK0g0WXZqaVEwZkpmTzd1dzlZ?=
 =?utf-8?B?MkV5OWlUZFlIYUhWc0FHQkJtbHo1VnV3SDlkS2tTRG5QRXh5VTNUSTV2MmM0?=
 =?utf-8?B?anpSb1hNaERBeGZTa2VET21vYjBvQjQrWitHc29DQ1RPcGZMTUIxL05GUk05?=
 =?utf-8?B?WHEvY0xaWEE4T1RrOWV4Q296WlNYdjF3S2tIeUNiRmllbjlJTG5yaWJVMGNS?=
 =?utf-8?B?d0tzYkhDVGQ0cGpjQzZuamRCSVRIWXoxSUJtdXJUbzNMc2Z0bmV4SHJMUC9w?=
 =?utf-8?B?OUs2QzlnRWFKMXdLNFhvT1pCczNLTTR5TVVNQk5NSUdEOS84QmR5ajJLUlVT?=
 =?utf-8?B?TkVaTGxhQTlFVFRObUp2ZHZBZHFWcTFQRmhSYVZpYW5LZzcwa0dRank2RFoz?=
 =?utf-8?B?UU8vU0pTSVptMUpBMGZPVW9VRGZzV09NbGNERXJoM0RYbUNpbHlnZmQ5eFYy?=
 =?utf-8?B?NlFIenJPOUFEREl3YXJ1SHV3ZS91VEwySWVnTWhGdnl6b2ZBdWRkNkhjSlBD?=
 =?utf-8?B?Z01pSStqSUwzYUZDdzFDcUpmL1ljZW5YL0doUjJzeUdTdFFyam1UcURVcmlp?=
 =?utf-8?B?M29LK2pZN3lYam1TODNXVDlMN1A5VDlmYXVlQ21Eck8rMi95WWUwQU9ZaGNt?=
 =?utf-8?B?d3M2dnMvd24zVEFFL1ZhcDFCR1ZBdlZyVndjVE1SUURWbTI0NDl0MWw4T0tt?=
 =?utf-8?B?a0ZEQXJwRDJyUmFLUEhEbHVaNUFnU3V1SnlwT0crK0NPL2Z2ZGozWVRFeTRX?=
 =?utf-8?B?dW9aWnBjWVdNL0owS1JvczVJdGpZejM1Q2JOWDhvLzE3MFNpUEtIN0FiYmRm?=
 =?utf-8?B?YWNjVVNaenRqVEdpSmYxV2RCOHVUK2lueHA0VjBOYmZia2hua1A5Mmh0WHV6?=
 =?utf-8?B?UnUvb25WQ2R1NlUwbzJCMk9sdXNFZGVSTThQbi9JY0RtNEN0OXRWbkZpdFlL?=
 =?utf-8?B?YnBmdzhLcGdRTGw4KzNXMlk4SEltNTg0ckNvRCtsQ0hCV1RQU1hVNU1POWRF?=
 =?utf-8?B?ditCdHdlNkVkNHdRaGFyNGpyRndkRitDbnkxQ01uWkFteFJBZE01aXdSVkM5?=
 =?utf-8?B?UnZaVDBhYm50Q3NqRUcxR1pGM1lpeVlIdCsrdnlPS0czbkEvYnlaa2hVaFFk?=
 =?utf-8?B?TnZJOU03MktTOEg2N1N0Y2NFTWRPbFpLNnA1eE85aFloeDFiTngxTExzWW91?=
 =?utf-8?B?dHQvRkw1dWpKSFJidFBNc1IreVNrYmZEdHBaZFlkSmFEK3dpVmI5L0wwbysz?=
 =?utf-8?B?TCtlMG5UR0Urd3l3Y2w4clM5Z0doZjhBRGZsalNNOEp2YTdHY1FPSnpsNlRL?=
 =?utf-8?B?aGMxdGxzcjZYZ3crTW9DcDYrWDcxZHNoTzcwQ2lIazRkdnJjNFVqZWRyWlVp?=
 =?utf-8?B?Q3I0OWJqWTFDNnh2T2lZWW9DMVZSV3lYejloT2xxejhzREVnK1lhQT09?=
X-Exchange-RoutingPolicyChecked: VaMl8wBLP1OzecYtvs5X/3ahkB7NqcmGX6tRCFGUaU36G0fSqcAxhg49uuxJtSRkf5Lkz4UnIgca1bi4WKK9SWnSgUdBrNxttNJnOhR9ONGUbeen2D7mEOu06Q0/0BJIZBfjnQ9JVaPJ1LwOoyGMDmtXn8jIcyF5aaTZGIoqcSUHrgaxO0TMQVcb/Hrj5iTwetQF1iFjfHcJqua0D4BDj0T1v+q4DFzdJCOa0MSc7j15deSvxq52lmlZvs16wJjY3OFSa5801qtoVpBXZX+5cKOUgw04fVaknViCBShfffATelIvl1PM35+i5CehRr6N9AQg47vxn2lkYDKlCXKZDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a68a8ce-1543-4cb7-4308-08de8e1cdfc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:26:20.1991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgn3C/YjUDhlFyGknvSjg5MnurCJHU7x6Pc9b8jh7IS+ziTjzLZBoNx6Pkkn/211hHzbbPmpBivniDGOn4aBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
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


On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
> Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to
> handle power management unit errors requiring complete device power
> cycling.

Same as other comments, do not use power management unit errors.

Keep the documentation in drm-layer vendor agnostic so that anyone can 
use this method for

any scenario that requires cold-reset


Thanks
Riana

>
> This method addresses scenarios where recovery mechanisms
> (driver reload, PCIe reset, etc.) are insufficient to restore
> device functionality. When set, it indicates to userspace that
> only a full cold reset can recover the device from its current error
> state. The cold reset method serves as a last resort for power management
> unit errors.
>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   drivers/gpu/drm/drm_drv.c | 2 ++
>   include/drm/drm_device.h  | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 6b965c3d3307..2dace9070531 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -535,6 +535,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>   		return "bus-reset";
>   	case DRM_WEDGE_RECOVERY_VENDOR:
>   		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";
>   	default:
>   		return NULL;
>   	}
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index bc78fb77cc27..3e386eb42023 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -37,6 +37,7 @@ struct pci_controller;
>   #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
>   #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
>   #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery method */
> +#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* full device cold reset */
>   
>   /**
>    * struct drm_wedge_task_info - information about the guilty task of a wedge dev
