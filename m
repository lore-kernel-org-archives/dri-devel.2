Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B3C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E1610F4DA;
	Fri, 11 Sep 2026 06:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TI98Olh1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B846310F4C9;
 Fri, 11 Sep 2026 06:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789107650; x=1820643650;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JOanKYQQrJp67q+5E81NmFEgPj/vhfSWieMg77bSztA=;
 b=TI98Olh17DMmQY1MldnOs81QT7YFatdYlNi+BXqb6lh99AgBGBDbMXer
 jV9KmCBfB8wDuMdKJZE300WgctEtJ6wnqnEyW6jSpFBxbvHThudz0iZS3
 Iha837VcwsXkeg2r1Lg4lzci52EkvPJVbQJPVdBnyvRW7jooaFYDc8O/h
 ifjccjf1VAh2u2M3u7li8S9krLbx44nd7ikEShTakoexH124edxb7j6yr
 2jm7052l0ytVylPi87GOH7afwLPuNPqA+omKV19IgTPclDQOQiSUhS/Gu
 AY6R4AcrhXxXFVzw2zSqzpGi6Nr1b34+GqbEuJPpLIaHA7AeKWOlc1VYK g==;
X-CSE-ConnectionGUID: K6JFs33hQXu+3+JxaRLAHA==
X-CSE-MsgGUID: M65a4SBQSC6CLRAA5Xt9IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89606814"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89606814"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:20:50 -0700
X-CSE-ConnectionGUID: E0JXmHIAR6GhJjs24XFJSQ==
X-CSE-MsgGUID: QhVS3p6ZQFOEx645xzrqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="275979974"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:20:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:20:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 23:20:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXQaWi1hOf+0VX2J5/iVDIwzBkkh9wRaRV7lOgyoqg8XJydoCnWwQg+xDPRI235VoLhR+xVKIeUSS09jMIRSDRGR7xAULQLWncLqAcY0ekwCDWvJhqi5gk399jd2uoZwt9A8jtmaOpo16P0rLwP3QUR9LiTZnPUCzQG10GWp5EwrHuvPcEwwiZv+RMsDqEbTc/vZieHqYlIER0VycIEMPnCVUOxPgFWJuFDLkRuP71YWW8MLuV52NGdxYrx1GMJG7xlDFddep8jvgwyS3jk2wKMWS3HsGiky6GztlngGjJ+m2Ff2DfwaOzUfqj+gNVY1Oo3BpIAvogqqDqfwnGM7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Haab5MDZRzEjF2hv8w3RobDttCD+ZH703NKuhN/m8=;
 b=rhUztAoFTk3jW9Wx5U29nPybwsg3JYo1O+bMrYGYAZUbfyUH2Lw1Uqacf8UVx6zJHZvELkzEg/mYosyMzft9nXCZWXMdNvleVNV0FYp3reUp/86Oz+9A6jMRQYzEDHRkwC6boiti4V8JnQQiTsW6SI8XA0O2QqxR6mg+QoM7pYXTJxMJR92U54rSdgALQCIBcXeDhWhE276VCCb6mOWJOLIibMxY6rFivIZrFzjJB06+FQUCcaWNYzycYc9coBoo0eOWaZgwrqkJeHbOyI4PiDhDnILbgAMqZ4q/d15OgCrjUv77Jve66g8XJhwbd61D10AYBsmp+JB7sESoP5HM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:20:46 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:20:46 +0000
Date: Fri, 11 Sep 2026 06:20:36 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <pdl3iofwyj5o52udk6tb7efutiqbt4dyajwyaeleti7ni47vix@5gacfnk3rsvq>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-5-krzysztof.karas@intel.com>
 <aqMt2sldJO05k5O3@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aqMt2sldJO05k5O3@zenone.zhora.eu>
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a44f10-38e1-4322-9499-08df0fccd0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: YpxSKRBVJhqKXBizF7jlmdyGi/MNdjaeqSO9673Dlobo1VCEUO80qS0h4/3hb+TEsNLsG7LKhuepaROMwowr1kSdNaFKtx5E53xuZki2+ONjgLRmXlqWejDDihbrEy6y42SK5a9TYwDyHCpzrbpShW7899yW5gdy6mWEp8chiTn4r1zYwAPcWMrmnqk7gFM8HE3Y0+pqnlR6756nwQjo7f/ImaLGRvBz+qX+Jvylr6zwbmuN6RXjIstENeoKQnOXYi08MDKxIrO6beUoby9CESujMpclsJqpJqiA32B8rG/OS7YYK4xUUBKZfBd9twPD1y12bUHzG/d+YtmXIoJH6ulX74klC/EptSG5Iof0GRIrGgJ9MfmYxW+NQTQiGpkb//ahYBKbYvDrYP+dUAa4zVnip44dZuqV9FKzLGU14WTbkIXrBGK291jikn6r3IXPmSFSQuJ7vH+ydSa1ByuUux2NdbmfHtSpVsdClmhoVbixpq6kDvuN7sgrOVKxpUQ4ERVcM6DYy2CwqMoyREztzYFsFr9CuSvjVFKvG53+2au8nL2lwe6epTxPhd0aZHPrBi+ORU19NfScz9+nBl8TQqWumsqK440iXV1JgHZgTADYE9nJflk8cjjPS1M8na8RQy4IT3n5NgmaSB2+GlnhDVrTwG4+9HpzZ8Mmg7vZWEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNLSU40ZitmNm1PRE80ZFEraWpMejJtWTlSU1BVamVmRStLTzg4UnRUKzJn?=
 =?utf-8?B?cVJUeUE2OFJNTHdUNTU0N25HdllOVjZwNGxXUko2K1ZmZ1FJYlAxVm45ZzRF?=
 =?utf-8?B?ck9ZbkFuVitXWmlWSHp0VkV2NnVDTjJFTCsvS2ZYU2l0S01KMllDWnRmRm1Q?=
 =?utf-8?B?ZFFoOXNTZ0NVb2V6V09wdUYzUHFQWHBuUEZKazM4YUZqb1J3eFVaa1E5RCt1?=
 =?utf-8?B?QjdPVWJvaE9BNkNhalZmSWJYOHFVOGlYcEVrSGpPUGJNTzRRR3VCTnBsZzhD?=
 =?utf-8?B?WHk1by81eHY4UEJVWXZPQzJxRXhKYmc3NlNncFFPK1h6aXAxa2d4UnlJQm1w?=
 =?utf-8?B?SGp3eWRGWHRoei9jMGNFTC9BK0hTdk82VmFjaEp6QXNGSlBxTmRLR3FFbDV2?=
 =?utf-8?B?d0JRNnlhU3VjYUlZR1dWNVZyNEVhVmxSeER4cjlnYXFCdVhxOWs5aHByNDZQ?=
 =?utf-8?B?RUkrUy9vTHRnSDRUUEwrUWRWcDFidkJmSmVQUzBydSszZGx6UzRNZElCM2R2?=
 =?utf-8?B?MHpLWmplV1NtczZ0KytqdUN1ZDhKaXVTNU1OVzNkTVJqUlpneVBnN21SY01r?=
 =?utf-8?B?b3U2M200cG1pRVBCbFpycVppZnhURWgwWGtNRndiejlacTFXS1F5UDFXd1ov?=
 =?utf-8?B?K2craDY4dmtvQkk1bTd6RUp4ZmV1SU54ajVwTXV3dlpZakVSeGd4V2JkZlk0?=
 =?utf-8?B?dFJVbm9mWHpVL2l3OXVZeHppc3VhOXhMOWZOcXVLNzg4UGR2ZWhBUWZmQUti?=
 =?utf-8?B?SHJoak9hb1I4V2VPUGNQaDNnOXB4ODhFN1J6ZjBHQjFhaU9QcFJyWU9lSWh3?=
 =?utf-8?B?YXlhbzM1cDdKUnRHc2ZsVFNIL3JscCtTeDkxeXArbkhTR04rU0U2YzB5OGRr?=
 =?utf-8?B?ckd2L0lVeXpuVzBuUUpjbDlsbTlHM3JlWnBmZjN5VnZkakZoRG5EeXFKcUMz?=
 =?utf-8?B?SXBYWm5rQmxVcVkxMnhlM1Z5WU1EUG8wOVZEcDRxVTVQZk0zVVBiS0JDS3Ni?=
 =?utf-8?B?QlFuM3BDQmFyY1BHZjZDdThvSWwxbFdsemRYc24xcDNnQThmYjRwdnhjYllL?=
 =?utf-8?B?OElmMVJ6ekNvMm55QU9kdnNGVDcyRDV4Zi8za24xaWMwdUcyNy82elRLSXZF?=
 =?utf-8?B?cFdKZ0s0L0YvZGRENkdya0haU2ZucnlRVmlCZ3F2WDNGR0hWTnlMeWcrSGph?=
 =?utf-8?B?ZU1melplS0VBcHkvTWQzQUpRVFdkb2JyWWFxT3UzQlBvckdPbWJsYTBuTTRL?=
 =?utf-8?B?ZEdBbmlKSXl1UkJJMm1jYzEyejMySTQ1bWp2NHhrMXJ3MGZoc29PODZVam1p?=
 =?utf-8?B?a3F1ajhtMGE2ZTJFRDBWWThycTBlTlRpeHVPUzFMT1lseG1iSWRQS0JrbFFp?=
 =?utf-8?B?SitYYXp2K0dsYjlRZWx5YkZ5ZGVzQ3I0MFNDTVpraEJMWmZhZ3VoKzRhbjBj?=
 =?utf-8?B?dmE2ZW9SWm5rWksrS0ZUcWJZUlRuYkJ6L3dVaHU2V0FwQTV4anhTVEVKbmE1?=
 =?utf-8?B?ak53VW5OOHJPbWFjejI5UC94YmJRelF0bWpJcTFoaFZOY1VyOGdVeVJIQ1Vx?=
 =?utf-8?B?TS8rSVJMNFF4SURYQ2tlT1MyYjBYUlVIOUNnalVFWEFOai84ZGllNk5UYkVH?=
 =?utf-8?B?bGpkUFB4QVo1UmorejZIMC9PTWpXTTArY0NPaVIvRHhBczhtMFRpRkhxZmVE?=
 =?utf-8?B?L2dpanVJMmZrcmQ0WWdUVHF1enNyTjNmUXNVOFVtbGRRVU1rTnhjS0xzanhm?=
 =?utf-8?B?WDdQNHg5QTlWVlZxMU5qRnBTQkNveVZGTGY5dXRqVm1XNFZCZ3FMK1IzV3o3?=
 =?utf-8?B?akpxN2VWd0grcUV0RHlBQmlaNTR1akY3TW1NczlkcnNpM2RpVWg0ZnphZ3lS?=
 =?utf-8?B?RVZkd2dkQnkwaFRaVVdYendWODh2RFNDeFhkeWdIeXJpdmFRd2orTzFYazFJ?=
 =?utf-8?B?WENsMFRNd3RDOVprVm5IdnpJcC9Wd2VPQ3FycGI0ZVVCUVZncGtqVm9KUzZO?=
 =?utf-8?B?SDhYcXFvTzNtKysrTlJuMlROcDNFTXpObTZQWWd5NTQ3djNiVnRMZ3FSK21Y?=
 =?utf-8?B?N0JoUlkrYS94T0FZNDNvWWZPeGhna2FGMUJJd3pNcUQxbVQ0MllraFNid3M3?=
 =?utf-8?B?b1pYeE90TWdQMGw1SXpEUmFzdWMvZ1NhTE9FbnZsNHo4bXREYVpWeUF3YUh4?=
 =?utf-8?B?THEwUGtuNHFQZDFMcEVpZS9kMDJIU0tsVWZqdFhWYzZxZEF3MXBBSGVBb0dl?=
 =?utf-8?B?ZE82NURLUEg4b2xELzNrNldWN0xERnJyUCtKbG5iazRqMm01QisyS094Njll?=
 =?utf-8?B?ZTJtQnl4Vklmb1M2aGRUektORWM5WjhvVWE2RnNYTmlqRWNUMXJUb1RldXJF?=
 =?utf-8?Q?O9wuGa67+aJu0vaE=3D?=
X-Exchange-RoutingPolicyChecked: bNrFFQCcMsBTT4g7td1oLkJhCz2eYTvKjSlLhamtDlcT+JkyC9Hr6Q6I0UJmpkokedJ34AA7+gLIVDgoow5/gLo9FRujcRkMFhLOWAx3/JnTHjkBZ+N+7lFtTFDwcvgHP564VmEWeoZs++zDc7AWP8N56LggV4mx50+jxCpM4fmuMMou+4jdgaRvcXEkqOqLLehNkF58mcjDKD49PPQmtgYYXF1YAO9ayTrfjs8pSvn9WMSNuZkPDtqCGVt0aFE7UxYfNatVm6+3pnHssfMUzVI3Bs5TtkCxRgCSLxpd7KnWjsAbX5Ap5ss12uiQldlc8tAIfYwBtCcgJoV2OQfszw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a44f10-38e1-4322-9499-08df0fccd0f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:20:46.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVQVCt6++G4Mtz7u6pMzma/AUlzhXUNfbSS7mEDvXnhi44+eVT0WooPWSCB1M2aVt5COTY1RQKg1cEeyRxrSwNIYOVl0a801rO4OrTEmW7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
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

Hi Andi,

On 2026-09-11 at 00:25:46 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> one more thing here.
> 
> >  drivers/iommu/dma-iommu.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> Can we send this patch separately? It just complicates things
> if added in this series. Besides, pleasee add iommy maintainers
> in the Cc list. You can use get_maintainers.pl
I do not mind, if this makes things easier.

> 
> Andi

-- 
Best Regards,
Krzysztof
