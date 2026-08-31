Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E169DC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56F210E7C8;
	Mon, 31 Aug 2026 10:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Tk8qz6VI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01A310E2C7;
 Mon, 31 Aug 2026 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171082; x=1819707082;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d3rZwQwstC5CQiE127QQsuHKovXFQT/ayeNrUmXmdv0=;
 b=Tk8qz6VIrdcAkMCQexHtTFofmLq0yqi6RhuuhSsz1HZFEgn9akKIG8LD
 1EFeW7IQ8e+driavlEBPWBMevbr6vR4CiDuCBKugHbxEgLs+25A9lxnTA
 Y0hx3E04RPelGb8nlesyxBIh/v2kXkz9vWA5oc99SiqPBhOHygnMj+OPO
 oXL8tbDm9GtHYL1R2sQgBqu1YMthS45HIyrLhwWi0hbXpf2ya2BlPpIjQ
 rOZwHINgEBpqGN97/yWSFrMmGk7MQJW3sc7uuFEZyOA23vN8tisYY2103
 /lgbHCuKa2h2u2ND0F4culMeGxb1Y29K1TE+XrvuvSzRA77vg73mgeh0u g==;
X-CSE-ConnectionGUID: NB7zTmELT5aI8ctb8Vs5Gw==
X-CSE-MsgGUID: DroUpjKRSH+b890C7ViNNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88502316"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88502316"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:11:14 -0700
X-CSE-ConnectionGUID: PPcHnwmUTFKKoEEYTmMycA==
X-CSE-MsgGUID: eDO/ZCo4SYG3jAfNWyoplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="272559171"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:11:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 03:11:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 03:11:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.13)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 03:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxXaqKh16extw4Wq82IcvA1kpDRZP4GUzUAvIetv0u7jYgZDUSneOrLe37M6kbzL9VfvNK/0yveWpL7f8mhu1XZ5nbgH40xIAAK1tNfd+2mTy9dVYxhyuM5WcxLxctIf5OfgNywZaZ6i/ky4jhnr6Xm4bv3oKmA10n7F9/AODrnCvHKmotDab9LPgcd2Au1eA+mq/s+rj8lEK97X2QDhjlH0iZABC5SFe7V/t6/sZsSI+5kQIXqU8LvsHXBbcW5wRp9Lwk1GheZxfjaGZz40u5tRpF2Pjg1tovZteYS9oA+49FgnnQSqPWo6HalGe8vs+lGP+tQmcZCb3cP4Z7xKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQH3oUDwScGTuVL41gs18F+JshR0eyV15nl3c2kHysE=;
 b=jz33lKLk1/iSPTmxJ9tMAJ2EprxvImV7KsLKfTb3C0XyWvTBwX8HN7BhBYBGChKPXStLIGCMKs9nF7fEsjx62uIIG1OOL7NWCDf3P7h8OlGNgMZem4C9K5SsSCYx4yg2Wq2KYbmHf/GqgjIZo8hcbLwQZSD4jtLNibA9+VVBZpStRGn0csPk0/EW2sZrXIB1W6yaJh/nEp/Wrp3M7FtMYIJCgQVeWXeJdqN4T806t3lmjl27B0KFW4LuNUOsGPj9zdLJngBRn9P1E+wAMTQhTwksh/okp4GSkZr5fYwyU22gRChTLMOv45kL9HA4NChfyuz5q5mipBK+5ecEVXkVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:11:04 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:11:04 +0000
Date: Mon, 31 Aug 2026 10:10:51 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
Message-ID: <nafxa7jcwdhzayjbismr77dsjcq4wl35alq6mkxcbxzz4pbavi@72emwhj2jvck>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-2-krzysztof.karas@intel.com>
 <aoWMcLMNCl0cjcLx@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aoWMcLMNCl0cjcLx@zenone.zhora.eu>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 5947a2ed-9148-4a2a-9caa-08df07482a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mK61UgWBzXCo5XLvesouFdqYPfCwYUPBmBJTwglDeTnoZ+Hhlk35F4BvnlAziku/KdUBelCaX+jutCa8XRSdlsh62e24xKNnLDYXgj5iG6d1xZw0XIsZhNnUOe7kwH4vYhr6dqclmIt4rv1Y4LX0wTKI/XCakGBCWsjOIYTBNklkQxgMOUyBK/ohL9TZMyaRAfWsewLAmiFiHDfMz++ozEOEQkRYSdzD/ZYjycknffacNc9XNatuNr/kLyHiXDkqWtJSvKwZC/MA07w+Jj8Qe9pHf3V8fL0iuYoFm9VUHbgm7be8YYDztyoy2uzwfqNrig1y+/7NWiTKosmCgXV7F/E51k/HGU+iXQrHf8TW4LMbKQja63OP/i6SqpXklX9WD2tEig8z7Wc0y5FiDeOZLWjZh5C6oXHUTfhh/rNZKeVigWOgTMDxVPjs4kyaVkqrCMtt27g4epfW2LI08+AMKjxYNAeKSxexOsFrJzMzFGhz6eb7lwj9RjoZLkGG3ILMag1xuPpiM/n9NOo3zvHwD18/nYANa/FYFfxxaUyqJj91n5hUwdbA1depmAhgag8F+2ZQExUkll+jc0BuP1DvosKMElF4OpvUJvmJwMgBeq5kYhYYSiYSxV9zKiA+2UPkG2ZvIqH9FPu8ukFOQtcZlwY0sDCXF6JIl1xhtGVzrb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJNRzVjcU1Pb0JjOThZaFh5K2d1VDB1UFh5Q1hkT2UzVWdNQ3ZIbVBEbkln?=
 =?utf-8?B?L0U2T3Jta2hlS3hQR1JWZ04rdE5xaVd5Um5hMWdnemtweGNtRDJka0N2aXdG?=
 =?utf-8?B?WmRNM29CamhpYzcyQ3JlUlRWSW4zcWJKT0tFclRuMEFXS21QRm83MjdCVTBi?=
 =?utf-8?B?QjU0TXJuNUw2WW54eGs2bVZEQ2RpWHRkRW1PNyt6alZkMlkrRWpQTzhiUE9Q?=
 =?utf-8?B?cll1OUFndDVNMGlYRzA5eG5XSXhHd08vSTVrZmhFOXE2SUJsU2M2Sm8zeEIz?=
 =?utf-8?B?RHJoMFVwaUJMMnhVa2dtVGU2MUx4Z095SEJINGpDZHRaWVBGVHNhWWhza0dJ?=
 =?utf-8?B?bkY4ZzhLakVIU200RTNFNzd4QkNSTlplb0NOY3h3WDNUd3NGQ2NkUU5NM0VT?=
 =?utf-8?B?R2l0dWcxaFBkUi95dWpVc0VSY1BpM1ZvQmZOTHAzM3puL2M2aVpTbXZSaEwr?=
 =?utf-8?B?V1FSNzJEUWxPb1o2SjZZM3JsdU94Um1iQkdVMTE0N3Q2K1hnQ0d3TGZTaSsx?=
 =?utf-8?B?TVhmVVNNZUxZUkFUR29mVktMZUcvQ0hKZElZbHVxaVVwcjJFSmxnSCtYc3dR?=
 =?utf-8?B?SWFlUVZjKytiRHI4SllEU0Y0NEZMUkhUUk53WDBSam5aaElUL1dTNTNyd0ds?=
 =?utf-8?B?ZmJHaGRxZFdwQTk0bC8rVHZZc3JRTS9aaXpEbUFQU2xxTjJERDd6b2UzN2tN?=
 =?utf-8?B?ZWwrWGpsOFR0aS85WTQ2TzhXSGFZaHhublN1ek9BWkJwUTd6MGhyNGc2NmRa?=
 =?utf-8?B?aWo2VlR6TXByUkhqTXBTZWFvTVU2OW5CQW1VMmFHemloUXA4Wnc4L1RaUGJY?=
 =?utf-8?B?TXlCVVgyam1TQ3JYbEdJRk56eVI5L1kzRDVCMFFXTUZaZnVHMy9wbGFKT0FN?=
 =?utf-8?B?NlgxVVVJVHU5S3EwUkRrU0lUUGRrbW5YZVYzMEgwYm40SGVUYUxuUkNWTCtU?=
 =?utf-8?B?S01LeXNxa3A5YVBNdnhidk5tajBDQ2hlNXhKeVhIYmFUMU4wVUphTEc0RjBJ?=
 =?utf-8?B?NVhDbThPRHVJNTBhWFNlZGVTamJ1T2QyTk1xemhwU1UweXhIeDZ1NWlyMy96?=
 =?utf-8?B?VnU5SXkxdmVUVCszTlpjd3Q2S0l2TkpqbXBLR0xOYkdHU0FVUEdlS3dmL28v?=
 =?utf-8?B?WG5OWTdnbTlrNlQ4RWpSak9lR1N6MWNSUXVlYWJVa3BicERqZGswOEh1TFNh?=
 =?utf-8?B?V3M0a1BQa0Q0NkIwck5YOFcrWmxJQWxhOVdpTmlpOTl4b2NzdTNUNjFJNWNp?=
 =?utf-8?B?SEZhOU9ZZCs4WjN5Y0s2Mm11b3ZEL21lMDNHUTErNVlhdlZGMlNVdWlNY2g4?=
 =?utf-8?B?ZVY5clZoWVNPSjVpTFMzdEM4WU9vbzg3RGViQm1XOGRLSGdBZ3hnNkpBbVYr?=
 =?utf-8?B?SnlGdkV5WlFIWEhaR2NDVS81WVE5eDdTbHQ0Z005NjJsYk1semJaeFI5elcy?=
 =?utf-8?B?dUxGbUVObHZCMGx0d1M4NWUvRXp4aWlic3dsVld3SEpHT01UT2VwZUtCaStX?=
 =?utf-8?B?bGVKU3V2czJJT2N2VERhcmpuQ0VDMnhNakk5VzRxMmE5SG9IeE5CcWdpL0dE?=
 =?utf-8?B?QW02OHBacXlKN2U0QVhtN2tDUy9TdXE4RnpaVHRQOWw3U1F5cytjN3dnc2xE?=
 =?utf-8?B?ZjdVOXJCMlJvWm40QmZVQzRXMmxlR1BZaEQ1OCt1N2pod1ZPbktkYzdrTFpB?=
 =?utf-8?B?WjEwT1Y5QXR3L04zVkNXcEJzZGdKbGdPOVBRUVJtZmdMaDRVcTRNK3MwTER3?=
 =?utf-8?B?MzczaUtNb2srd1BEOXB0emlQL0doZEsrUWhENlB4NEhEUFVrMjNpVjMzMno5?=
 =?utf-8?B?SG1KUHdyL3NNQ0x5a1pYakZWdEtOMTVYWktnU1o0WkdIeGtEQVBrVWxOUkFk?=
 =?utf-8?B?M2dYNFNNNTdrOVBZODlTQ2hCRjZzcWRaWmVOclUyR3R1RnlRUVFMaVZ6NVdj?=
 =?utf-8?B?ZmMrdlIxZkhJekhOWC92aGR5SzlwcGJnQU9KTXdaQ2NaVGpSTDdRRkhka2hN?=
 =?utf-8?B?QUdWK3lWZ2ErYnI2bkJnUjhGMkR0SGMyanNWRkU0UnR0R3dFQ1IrNFplWGdn?=
 =?utf-8?B?Vk5tU1VOYWMvTkZwMG91OTdMdlU0L0FMNFZGSWN3NFFyZ1RicnYvWXJvOVhB?=
 =?utf-8?B?WWowNTMrS05tR0VxRENSbnRFU0NjaWpOV052RmZpTTFzTTNoZmlJQnZrYVhC?=
 =?utf-8?B?ZXRxMUQrS0x0QkdZbGJLZlU4MGVqV2JTaHNFejV3TlJTbkpHQWY4cHB4amV4?=
 =?utf-8?B?aFlqQ2NabEw4aEFzZHVTQ216N1lkcDdvMHQwYlNsMm5xWURPejlvakt3TUtu?=
 =?utf-8?B?QmllUFNhMEJlcVNoRnVlbzYwcmVkNWcyQTYxRmYxNENuaTQ1OVNJM2JGQXVX?=
 =?utf-8?Q?XRpIS+c/2ydDeTQY=3D?=
X-Exchange-RoutingPolicyChecked: miO2ieHfxAStQlF7OtQ52CMbE66WmUYGKVMr4peUe5QkseUQLLi5qRNT8o2+DXWIphJt32srGGw+27Cef09KqoG9IHLRdrBkkUU+dLn+kAo0OHHYN01Xc62L+FUM/xIWmq4fU47dm3afF92ilZ5sxPAVDonWy2HhHrrBujbd8I70wCOZtdxta631+fuF6LaAVsiroRGe3n/7rhXam7OTAt1hzfet+lPUKG2UUQSfggowIHm9OJj40mkzAUspZwn47E+RoHzd6BCvFvuKKU5OhBGrGB/OsY0AAhHsTFOUeSy4JyXTD72GKMfKlgUIcHyvyWf2vLTm/hoW3KZcrkLnoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5947a2ed-9148-4a2a-9caa-08df07482a60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:11:04.1325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpPQcURXekiTpzV5T/emXcrltc/hQO6Cue41x/BJp9d/7xAl4i1cPLX4Spm5YaoMKdpFuBDZoAGmBLdKIPVRb7MhgL7+6bNbZDp31b8Zr7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
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

On 2026-08-19 at 13:56:13 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> your patch looks good, but it needs to be polished a bit.
> 
> ...
> 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index 06543ae60706..f338dc39fad1 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  			 unsigned int max_segment)
> >  {
> >  	unsigned int page_count; /* restricted by sg_alloc_table */
> > -	unsigned long i;
> > +	unsigned long next_pfn = 0; /* suppress gcc warning */
> > +	unsigned long folio_start = 0;
> > +	unsigned long folio_end = 0;
> 
> Can these go inside the for loop? Keep variables in the innermost
> section needed.
They need to keep their value between iterations, as folio is
acquired once, not every iteration.

> 
> 
> Besides
> 
> > +	struct folio *folio = NULL;
> >  	struct scatterlist *sg;
> > -	unsigned long next_pfn = 0;	/* suppress gcc warning */
> >  	gfp_t noreclaim;
> > +	unsigned long i;
> 
> Please, don't reorder variables in this patch, it's out of the
> scope.
Very well.

> 
> >  	int ret;
> >  
> >  	if (overflows_type(size / PAGE_SIZE, page_count))
> > @@ -85,6 +88,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	if (size > resource_size(&mr->region))
> >  		return -ENOMEM;
> >  
> > +	if (max_segment < PAGE_SIZE)
> > +		return -EINVAL;
> > +
> 
> the max_segment validation is out of the scope.
Understood, I'll move that to a separate patch to keep Janusz's
suggestion in.

> 
> >  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
> >  		return -ENOMEM;
> >  
> > @@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	sg = st->sgl;
> >  	st->nents = 0;
> >  	for (i = 0; i < page_count; i++) {
> > -		struct folio *folio;
> 
> Why are you moving this out of the for loop?
> 
> > +		unsigned long folio_page_index = 0;
> 
> This initialization is not necessary.
> 
> >  		unsigned long nr_pages;
> >  		const unsigned int shrink[] = {
> >  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> 
> ...
> 
> > +				}
> > +			} while (1);
> > +
> > +			folio_start = folio_pgoff(folio);
> > +			folio_end = folio_start + folio_nr_pages(folio) - 1;
> > +		}
> > +
> > +		folio_page_index = i - folio_start;
> > +		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> > +			ret = -EINVAL;
> > +			folio_put(folio);
> 
> I think shmem_sg_free_table() drops the folio reference already,
> right?
> 
> > +			goto err_sg;
> > +		}
> 
> Is this WARN_ON_ONCE() check really necessary?
> 
> >  
> >  		nr_pages = min_array(((unsigned long[]) {
> > -					folio_nr_pages(folio),
> > +					folio_nr_pages(folio) - folio_page_index,
> >  					page_count - i,
> >  					max_segment / PAGE_SIZE,
> >  				      }), 3);
> 
> ...
> 
> > @@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	i915_sg_trim(st);
> >  
> >  	return 0;
> > +
> 
> Drop this change
> 
> What I want from this patch is a minimal change, without any
> churn not belonging to the sole scope of the patch.
> 
> Thanks, Krzysztof,
> Andi
> 
> >  err_sg:
> >  	sg_mark_end(sg);
> >  	if (sg != st->sgl) {
> > -- 
> > 2.34.1
> > 

I'll apply the suggestions in the next version.
Thanks for looking at this!

-- 
Best Regards,
Krzysztof
