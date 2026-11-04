Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E6606F2B1
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aX837uT6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A5E10E3DA;
	Wed,  4 Nov 2026 21:03:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF0010E3DA;
 Wed,  4 Nov 2026 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793826186; x=1825362186;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IgXdNokfn4BLIxJIiYSE6LVXlkPLxbh27RIw5ysAFlc=;
 b=aX837uT6hYBmZCiNXdgIXcLSx2nXQbDzNZ9uqFpznQTDYz2IGsG4C6O4
 twD7CSKHYT3rwQoKUaV/h2pifBtSfp1zC2Bvl00XYPS9A1zNQLIKiCbX+
 77QowWd+RRGlx2VOuytiFC9mDPx92u1PR3JHcRCq2qoPWGe2RHwWAsJIE
 qAhjKS3jWN8RRoOqQnoNPK1Q2QXmFUFtXNl1W7NxWjeq79qvuBoa8xBb7
 M3SZkr8T6WUlJY45ZLqvwWClmIf6GkN5FntFiM8cTOpqGFY4IaDu3yTGG
 IpSUvSoArCcitW9Ac5YxRaEGQvtUTebu70UR1S1DLPryoHyniX8Kx0GIG Q==;
X-CSE-ConnectionGUID: QArRxGo6SkGtIASyUdKy1g==
X-CSE-MsgGUID: YrKMpJhLTlOjqp3BnHIJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2615962"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2615962"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:03:03 -0800
X-CSE-ConnectionGUID: fyamYAPtQyGP9LMWsXH9GQ==
X-CSE-MsgGUID: ym98KGkySS2N57vbRLHu3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7361577"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:03:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:03:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:03:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:03:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxSI1gtR5IEALAlgpQfFpopQJ1LeUnGQcStv1ijoOcOQ3XNTL5R+D3SlW29qDJ9ePSqzUptZuQ17Ps55bvzxkITrMOR7wo4rDhFp5923MA+hhIUTZJav0M5BUi3wfyW5OYFyuHtN9RUKPi3W1VqcC91jk6tZJHqrP0TQ1PwCmBzPftp1L/7aZpzGp6WtqFFDiiKa7NS5emSBktH2eKJOt/8ZC1ACl7wkeNdgYDnwcJm/0bIz+K0kq09KyiXZPkNe3hv37QnJwDSLhvPBRE0jchSttA7SWcfL05n9C0M22OPRJRDdn1LtkMcDQq3/E7Da/hRETjF7gvA8qhRGKdW6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLrSPL9Fg+8q2cMcfmFt+4meVDSnzXLJxyz1CUcoNUs=;
 b=rHEqjoFbpRR2n27bbtHliYgjrFxmCNKJ8cgVyiXTAEJkN1QqNoz7y9F+Vntk/Ff0Avago3QzjvBS1jRbmzBwhVxbj3lgdRA9ynd2xFAF8KEBxFY4pc8JnPoF9uznEV60vaeWg/aCghoJ2CecXnGhN5nPWarPZXsB1It7hTyJaqNH4rsefc32CcIm2WMxkMrOvcmwgBBBjtiTSM+/TtkNHkWds01hZNv5def0C/tqj9Xdrcj9DiW+aypte9i34E+61RZji7/uSHR6v1aO8LL4buscUYY72i7RHdLCAx3g+D1zDCsrNnZ5cdv2b3iNQzQWoMXBiNP5WoSaxuYSsNSoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 21:03:00 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:03:00 +0000
Date: Wed, 4 Nov 2026 22:02:53 +0100
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 2/6] drm/i915/selftests: Use gt_*/drm_* prints in
 selftest helpers
Message-ID: <auudWWAI8wEUZin7@kniemiec-mobl1>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
 <20261104111104.946617-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261104111104.946617-3-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU6P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::8) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 65393f8e-a31a-4b32-4194-08df3ab70254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: SMhF/BWnIko98zOj0gaRNiPPc6stM5Rhc20874ZOGr0mw2/dXSixN7zWlYmnM3NBhKFJVrkcsuTJJ0ZMmkvZR1Pfd9oouxehbb6FRGDrH2Dc7/7Q2MzUw3s/Rfwt5Rr4wufCmTDDi1cnyq5dpc9saK0DA9aiM+pVEThEcE/sbFUiw24KSDPXQNWwS+HXWINo2spJFwFb/98rhhiH32huS+fatGqJ4OHnDWM9665F7rMu0YbWM/uozIHRDmezQX/VwLGVcTePQEgVX5tI9I7SX0usEaLhOh6kQ/cug60t6g2Q9r0T7xQEubZBZu2jRmRF5bDgZDees3x22K2sMxRYNdNjYt/6gcBcl07MqvorjFd79q2fxXxjLPBUW997dn8ZtwhKtuMlUm8mHyDPn03IaLkI9pJgH7adtiApjAMJk2+5q68SjAxLRZ5rrL0at+cNpgmI/bYH0y2wejrmaPLCm2blNg026oN3MUI/Ddb6Njaf5hroyu5MkSrdjTvBLK4fA8deP3dv3GA89EXOjhLm/pAdAWVibcGc005mhNLmLgtQqEzMjrFqmXDPh8pQp8v+dNy7rmMrG3xvsjSwumUggK69mufyxLmKsHO66lWPdgYPAChvZy6azKmfVYbaBxHbandNktlnvA3P+zr+vDZUetEnTSsAXAsB1MpxC0Q8sVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNsejJ5N1hvOVpsVkJNZlpaK1FxWWR3WHhhTVBzcHJBYzhEbEZhOXAzWG1O?=
 =?utf-8?B?OVNOMTBZWmNhM1FWdlozcU9pa2Y2K2JjMy9kd0hldG1ZM2ZMTmJPYkRrNTNx?=
 =?utf-8?B?N0xNcTNnYjZrRnZDbTZseHBXZnhraHhyNGdWU3hQV0Ricm43QTlpMGY0ZVQ2?=
 =?utf-8?B?MXJxcnAyMlh5YW9GdlRMemVFS1ZpVndQNDE2RWp4T1pRN2lOM2RkSTlSbFNs?=
 =?utf-8?B?N0pEWm05ODZpSTZJU2dTMnd4blVoQVlsNDF6SnZpM2JFRm03eUM4a1Q1eGNq?=
 =?utf-8?B?OThaNDdRNzVyWjVRUEROOFlaM2V2VTBBbm91K3JYS3psOGMxbWMvcjI5L0gz?=
 =?utf-8?B?ZFhZUWtMR2JlckdoU05RckJ0ZjZwSW85dTJaLy9keHM4K1dwVkxEVUo4bzVQ?=
 =?utf-8?B?ODNkeGJuekRTK2oyaDdVSGZkWStkeS83LzNwemwvcXB2VHFnODNaY3A4N2F5?=
 =?utf-8?B?K3hKMUg2UUllZDNNM2FuRkNGL2lJcG9vMy8vWXJDVnJLMnZsVURRRlJMdGVx?=
 =?utf-8?B?N2wyaHJ5SndZOUdBcWdPbzlxZzRCNzZ0RnVEVStTdzM0T3p5Q2tjRlFBbmNK?=
 =?utf-8?B?UTRrSGJlQzE0L3J2NWhjWlZoSWtoWDRSbXRxZ0RkejhLdkJBYTNqZjR6YUMz?=
 =?utf-8?B?VHVFclVORUQvSXN5YXdIb0NZczVScTl1MmwwYXN4UWRnSGpmNHIwTUJJdnh2?=
 =?utf-8?B?enZ2Y0pFbHpVUzAzZ0J1QmVLM3M4UEdCemFBRVY5RXlERWZCV050aDhhMjNr?=
 =?utf-8?B?N0UvK1FCWTVvZ3BCUEJNWTVhRm5HNk0rRFE5ODFXMzdYcHpDTDZNSHZiRktK?=
 =?utf-8?B?OXpjT0ozcXZuRmlSN0dKZm1RU2NJNXlFaTlYcDBMK3pSSGpZa3FvNk1GVnJI?=
 =?utf-8?B?b2RtT0NvOGFzRlBSUSsrY2R6TWpDWGJNVEtPeUtaTWxMK0pRaUlWSlVPOFRj?=
 =?utf-8?B?dXJrd2d5TXFzMjFZQ1Z0TnRLSEh6UEIrMU5wYk9FYjNPREVpcXVsbVZ5NUM3?=
 =?utf-8?B?L1pVTkFkeHBGNk9EU0drNEZKV0VtNjA3VGlTSjA1RVdZU0dCWDZRVnJHNzF6?=
 =?utf-8?B?Snp0QVFRbWtPc2l0V0ZnTVJabTNrbDd4NTJXWjJjNkd2cytnaDJ3Q2NnQXFN?=
 =?utf-8?B?WC9sTWpqUCtma2YvcWlhZ3FsZlFBUGF3YTRtbmtnL3VTS2Y2VG9tbUVyb1Ix?=
 =?utf-8?B?SXhob0tlZlF5eFV1QmdQMGZ6aHRpZUJrWnVkQnllbzBVQUhlQ0VFRmF0Y3U5?=
 =?utf-8?B?dGFSNFovOVQrWjU2c0lNNGRsbmJCVWwwRUlFWDkzbWU1Z3ZwMk1YWEpqWTcz?=
 =?utf-8?B?UHQ5czJ6YVlBTlhNdXdHTlRnUFBrVDZxUjAyT1NwQVJuazJhZjBKdjd5S3dI?=
 =?utf-8?B?WlU1SEJVZy84bHJka2tIMGFXR3VEMUt4eVAwQkZtanlNY0U1cTR1OGh1azBi?=
 =?utf-8?B?SFZFaVVqcGxHOFIrM0RFK2pReFRkNmJ3WFVPUnJkTmxDMHpCbUxkZ3hhblJE?=
 =?utf-8?B?TjRDYkFIeDJqYnZPTEM5K0tocVpiRVNnYVZKb29RVG9wczZvYU9EY2tzbWJ0?=
 =?utf-8?B?V2VrdXVzQ2M5T1ZqbWRoNVhWRFcvVGNIdDNJa3dFQzNHUkxuZEQyNVY5VVJr?=
 =?utf-8?B?UE1GSXVSNnpVRGhmdXc0WTZVY0hieVpIUXRQcFBvWE9KT20wOGdaWlFFNmcv?=
 =?utf-8?B?VnRxb0FMak14WnpKejRuWEpCMmlWRkRHYUgzZ2NwbHBncFFNMXQ2OVAraC9T?=
 =?utf-8?B?UjFmeVVQVnlCeEFYcG9YR1JhK1FGaEtuc0F2VlVabDU2aVFVOVozTmpVTjBM?=
 =?utf-8?B?WEV0eUNPcVZGdW9lekthT25TSzNhNjB4QkpCTVd3RFVBL0FBZHhoNFBkSVpQ?=
 =?utf-8?B?aVRJWlRtRVV6bFEwek1OQzNpL0hEaDYvVDh6cFFWRnFNcm9SUXg5RWhZSmxJ?=
 =?utf-8?B?Y1o2NXdrYk9US0FON2Y1VW5QMVBjbXRONTM3VEdZYmgzYWtsRmNhUUNsUjJn?=
 =?utf-8?B?cnVCc3BXQ1l3NFZXd2QxMXF5ZUlYdTVWQTRaMWprTlZudkErVWU0UHVFT1BC?=
 =?utf-8?B?RUdOL25PNnJDZUVjK2tZTjBGb0ovRk5RR0hHTzMveUNNOU9IbzF6ak91THVw?=
 =?utf-8?B?RkpOZjFvdlNYdlpTWWI3UEoxT0J4bERFY3BrZ2FENUNZeE1YZkVNRWV2UGpk?=
 =?utf-8?B?R2w5Y0xSd0lUYXRSc2NXN25Pc0VJZzVvemR0Uk00UnFRMFE3a1FKUnFONWlU?=
 =?utf-8?B?cE9CcWhDSXVkdEJydmM3UUtSRnRINVAyMDBld0YyUFhXTlY3TFJGc0ltRU9P?=
 =?utf-8?B?UXA4NXZiVTNpejZXaUJOTzZneWV6aS83RXNTWVFBVGRGcFBWcDRXQWxRekFr?=
 =?utf-8?Q?rCfH97pDnFdlMB8g=3D?=
X-Exchange-RoutingPolicyChecked: NCjs7S+z9wBSIOduYClF8xpBkQ4BhgoOiovWE2xW/51enOQC/l30G3hktWM0RUi1f4ILl9Gq2197zbfA8Bko8AbPMSkRFbJ5mYFa7JmFDr5PQ6326UA2d2mEW2rlqNI7ruODzqD3+LFZ3vIQ98IhB8Ze62PUoYX4ecvXLGz+0s5eezuZxTCljtz71RvRfO7xz5jR9K6PBFQ4pLIRYmSjpM4DB4fHFMmHrGffZicAG8QNM5AH4zaZ9iKm5n0MfGbu+G+OmMrMprVkOVZQHK4YUdvlQd5kxQsKILXB2YDGSH9I4M85fZb+ZcymuiRUnwMGDFgOoyLEo8TceYS8zELMPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65393f8e-a31a-4b32-4194-08df3ab70254
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:03:00.4217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3txFZq4dTBs8PEahEWmb8o8tusuq/5cbL0RHYAYTwnpwNG8m8iJ1USEm9GeFByhCzBPVEyupNEaGwzrOlfHA+ZIX4QYjGfYsLY8V9SZlZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-11-04 at 11:11:00 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to GT aware gt_* versions,
> which tag each message with both the device and the tile it
> came from.
> 
> igt_live_test.c and i915_active.c now use drm_* prints: both are
> driven by a bare struct drm_i915_private and have no unambiguous
> GT to attribute the message to.
> 
> For mocked device in mock_gem_device.c use dev_err() instead.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

LGTM

Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Thanks
Krzysztof
