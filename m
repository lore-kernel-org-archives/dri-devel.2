Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8211061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0BD10E796;
	Mon, 30 Mar 2026 20:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CLdGv/6G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD6610E60E;
 Mon, 30 Mar 2026 20:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774903694; x=1806439694;
 h=message-id:date:from:to:subject:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Qh0wZUkK4k+aLFwp6011IB190b194L50jhVaU5eanms=;
 b=CLdGv/6Ge5MVUneQisfjKR4t8YjlVKzc1GxZPwyewD0CLaq0qUl/FVIY
 yZsYaPjaBal5EtN128GIHQtvLd6g2gdCzLIgYgxtt4IiUWBR3Q501tcdO
 WepkMgYakj6GdvVTPfqLKrqpcI6W3LZNowQnYKJvkqmaJ/tUc5wIqJsDh
 Asa/T5nfYSBhH6dLp6gpANQYW4Ag1gWtn/Wy+iXdjcOrG8sVWV9xVK+51
 ZZc+e188ZsQkykUlel8p+HluTiNgl8IbQLfExBtbQe26eMdWKmbLeI5p8
 G8o142qHzW9zFEMcFhXqzTP2nggFgx+1Jz7W5xOoahQ/nH1FJILIBsW0c Q==;
X-CSE-ConnectionGUID: CfZZ75HNTouEbEg5KCDhfA==
X-CSE-MsgGUID: YZyBQqLgSW2XSyJfih/KlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87300781"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="87300781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 13:48:07 -0700
X-CSE-ConnectionGUID: cxwn6dMPSYyEAJ1kkJViqw==
X-CSE-MsgGUID: jBeU1rNzRC6Y9HP2QMZEdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="264093181"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 13:48:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 13:48:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 13:48:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 13:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMYfLcM66raE7318qazgNF5/wX65Kcl1sfkO+O9KEaYwuLnmH7aXOT5SPCVCnVTMbiu58prlETFfbfgXl3DTWneShY02HU5yV8vUKAGFYEkFwTVNCHdfc+4keORDfm3FJ6yD83irtpohJxr6WiUvS47vin7TX1D6BQbGtojjugxohM12EivqQ7GBavH96uXQ6kz3oXrcYI+XUhJbPmp2MdiWiHUJvLB0MucVLCxVlYXA+UMr826i27hwXf0fhIWkdIMdJBz6Zm2y+SBctcIn3xKrXd4CY7hQyaG4liUSmtrkEbClfa2vm7/l1tb4jAy6HpeDApAX+4ichzEU+YQiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC9/YWwzhgPCaKjhPp3TZT/K/NiTVd6g1b2qWVVMjQM=;
 b=h4T+JqTlJRBY1bIfOyUoEWvxFaI5FMwfnZAfpy5V4ba5Aqg7zmpuxU3Rji1MWNkE121E6xDbYTg57lg3ly13lhG0U/0XKIESKWlDgRv/7pHQIDHo22vKROuJVs6HGUQeln/Nu+DtnejbKg3Wmk3dPy9/NLmaF2RQWeEOWg5G/oyNGlmxA5swm3maxFR415nSCaYFMVVHF1H8/a6bqVqUszWFURPIHAUsQCGE/f67KpXelgdpY91KnNfAW6t9ZwMH8POWqe1/ZsHM+VUSussFn85+cy89qa6CoBxKoVB0YaRRp0KNUAgV20XnFs8BCzfSsuL8MJFY/Sx/dNGjtJOaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 30 Mar
 2026 20:48:00 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 20:47:59 +0000
Message-ID: <8bad42a0-74f9-482a-b649-9b9244f36477@intel.com>
Date: Mon, 30 Mar 2026 13:47:56 -0700
User-Agent: Mozilla Thunderbird
From: <anthony.l.nguyen@intel.com>
To: Yury Norov <ynorov@nvidia.com>, Simon Horman <horms@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 4/4] drm/xe: switch xe_pagefault_queue_init() to using
 bitmap_weighted_or()
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-5-ynorov@nvidia.com>
 <20260304114319.GI71509@kernel.org>
 <51b0f779-4070-44f1-b136-77737da6dbaf@intel.com> <achO43f7IA22uD19@yury>
In-Reply-To: <achO43f7IA22uD19@yury>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df2def3-f59f-4992-ccc8-08de8e9da0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: pXe/4dm6JKEl1IMfq1b0pnxeNaBnQQmBrDd87ucJvqrRMlTcP9mVehSdJvDiFSjEPKiISN9EyqIIVZCR+Bl5KkzNqbB120btK4jGGvwyUs8COFXpMYalW2TmJ4MjI//WAz1tUSO5Q1c1W9cESuDe8A1F2m2l96IOLmJsRwFLlHaaIGOhOr9FI1EihuYrWLaceDbmTrpUL8tuq3Flqjr/GqVKNUWOlG1vDbzPmsAP9lBH+6FwkdWymePuDMeCYepTvhucIJ4MQkyP+CowvmPnrY5hQWlrQB1yBFF51g8n4+Ac9/KbeG+fCBFJsIMzYnukbpwwDjIIT3Qle5R7MT4UXRm/vXT23gtayy+b5Inh13w613mz8HKDDzd2+cskw6buFxsjrc/TSy1DSAHb7Rag2vV1KA1b8hbbT7mO4Bzl0QmQqJnTP/DCNU+G+F+0cUdDJ57OUCz923RxPrrlpnqm3ExDrncahHMfHkDrXw3KC6t8/zmGuR2OH3hvkFQeyhkECKwc3HeAjlMD/dLFIMoxO4gCqrUoQRR96PFGt4s4Bj66qnmz6BBlihpFgEIhFfoB+eScHr8tXi3tewZsGxUQqL8SM12RwSjMZAbvG/4jM07G3Cegej2r86U6VYuzjfbw4UH/eKxkU5V1tyzX2FGLrME+TUP3Cz/h8QNL+GPu3ui8rrbQgH9iiVZ6UcwRifXl5Uj8TngRmtpAL37AN5QQ0gux7O5geMTZ357AVCX9S8ZQr9nxsJSOQkpSOjMBwcRWdOXY3OSryw0LP/MO83jE6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBJTDFiQ29YdmZZbDJSY1hnNnZOQUR3R0svRzdMb0NKbDJyWlhBWnZqR2xt?=
 =?utf-8?B?dmtqZExDcnpCT3NnZ050YVVmdWNXZjVhZ1BWNndmSHNLcTlRRzVkMUluYTlW?=
 =?utf-8?B?NlJIL0p0Nk1maEc4WDhUNUtZNFRBY1BnZnBjV3J6R09FZlNDZVhhQkk1QWZk?=
 =?utf-8?B?Yi92S0Z2TjlMSVEzN0xxSmQxRHlPeENqbURGSC9UUVhaQzRrYTc2N29xK2pJ?=
 =?utf-8?B?UEF5WEM2VTd0RGw3NHMzam5IRENwN1EycGRFdjZFVFIxZzRCRTJtQVNqNHpW?=
 =?utf-8?B?N1p5ajg1RElhWDhYcEJwUExJQ2l0UW40T1k1bmZaYVBiWCtuaEpJZGVLOWs5?=
 =?utf-8?B?UUUvc2FlUnRxK0FHQUZ6OXNpN1Z1ekZkelAwZm9VdElGUmtkcmlkci96Z1Nn?=
 =?utf-8?B?M0RZM0NDLzJqR2hNdjlhM2FiWFViSk5IamNGNTQxZFJYZ2gyaS9QRjR2bVF6?=
 =?utf-8?B?b0wzbWFvRzJGcGFEU2drcXFkRHFQUTVyVTBXOE0xUHI5eFpJRitRbUc4V3lh?=
 =?utf-8?B?Z211T3lJRHpBNzQxVERqSUV3OWJvR0ZGM01ueDNVS0xER3RCTzRWd2lzRzZD?=
 =?utf-8?B?TTJJYVRxenB1QjdTVDZuS2N5bTBNbnRiOTA4ZlJoQVlqVktMVDN4Zy9kVXVF?=
 =?utf-8?B?R0ZkVEZwYWdOR20zZ295T3N5TDlzNVV6dXZWNE9vOEliSzJrOHRrSmFXbExV?=
 =?utf-8?B?bnBVQndnSXNkYS9IeDBoL1FNL29BVlVQaTZadUhGTWpkcnFpYzhhQmxMMm9p?=
 =?utf-8?B?cFU1SE4wNFVFWGlpQmR4by9rZGVtUU9QcVZTSlRZWFBobE5vR0xVajJxNlFx?=
 =?utf-8?B?d0dyZTZBcmhvUXNjQTdkK29GVm11akJzeWxxTVpQZVJDQkx1b2EzR1YxckZP?=
 =?utf-8?B?MEY4Q3c5Q3ZKcGpNYnN3SUxlNW5LQmJ6eHdtOVFQazRaNFdORkhzbGpzZ0ps?=
 =?utf-8?B?Q2h5eEFza3VnSmRuWDFWYnFLRzl0dFpxaURHTVB5UHZMRGMxQW1SeHR5dzZJ?=
 =?utf-8?B?WGVBcTNNNXlzOUZFbjhhNWJ1SEhwZjFqWU1iZ1p6aGtWQWhGSzNJNXh2Qm9k?=
 =?utf-8?B?YWwyclQybTU0bFVqeDJqc1lQVEkzMWUrZnVaVW9HQUYyUmVHUXU4Rndub28y?=
 =?utf-8?B?VVZuZWxwaWFqOHl4OVRWemNLUmxqSkQ3V3V3NXJoZnYwOGIxSXh1YXo1S0Vk?=
 =?utf-8?B?OUZBU1puVWtoVWdYb2I3L1BNQWZNNU9PcTJKOHJwbW16aGMzeEZDNThxUHFh?=
 =?utf-8?B?WkZmVjNDZGc3MGhkdFFYMml2SUtseG82WUQ4MHduT0h4MnJkbGtyallucmdk?=
 =?utf-8?B?T3J3VldsN2s0TWUrVWJJTFNkSExnNis1RjlEaWpZbS9vYW1hNmx4ZUIzbUFh?=
 =?utf-8?B?STcxR0tIQk13VFhnamQvRk5sNkw2OVJ2MzBaNkdnQlBoRnhtcnB0VEtISHF2?=
 =?utf-8?B?NFR2RFpZUVNseis5bnNnSmVKNFVZeWtwQnlwOFFNaVpXT1pWZ3Z2dGdMZG0w?=
 =?utf-8?B?M25MTFdndWd1RXhsL25JV25LanJ3WjlKcHRlbzRHQmJnUTZrQmFKYzVMclZS?=
 =?utf-8?B?VkJUN2dPVXk5bUU4VC9HNGVvUEdKQU8yRHBUZkd0RkhlNlVHMzhXVVU4Z2RM?=
 =?utf-8?B?ZElLdWpVNms4LzFWR3RrdmJnRmJEbWRDNlVGRmtCNkN5ZVpBcjhsTVR6TEZm?=
 =?utf-8?B?M1hrT00xZjJQQXVWcHpiMTIvaXZsMjVBdGtaYVBQeXpQVCtXeVptSmJjSy9E?=
 =?utf-8?B?cCtuOWZoclgxcUlVYjFqQzJGNzhab3p2MjZXbG13a2RXdGZOcU81TFZpd043?=
 =?utf-8?B?SXFlb1I3cHFQZXd3WWhPSVFBekpVaEFlWWhOZjV0ZSs2T21CMWVadWhDWG5j?=
 =?utf-8?B?bnlreUMwdE9YRzdqdjJrRUw1dUp1UVA3cnJGcVdGUldsSUtONEM1TlRTSTlZ?=
 =?utf-8?B?WjBoQ3ppbG1tQjUwcjF2aWQvSkhLKzJzTC9YbE81bCsxZVFEVldJeVJLOTR6?=
 =?utf-8?B?WU9VbUJTZVJDNkZud2dVTTVkdnlyOEZRUEFsSHZzMVl4eTFyNzRsRzkzVmVi?=
 =?utf-8?B?WGNBRVVMamRPc2VFRHJzSlRWbGNVRzRuSTZ0djNmQVRLNGhNS3pwN2ZhUXhF?=
 =?utf-8?B?VGNKS3ByQTNHNXU3TjI5UG9SRnhIVkd6OVEzT3N1ZzM1VHhLVXBRc1FiWTFn?=
 =?utf-8?B?N3ZhakFOVG5VRTYwMWhCaURNN1cxWVFMSFpoZTYzK3dEcTRtSTFlSUdiQ2JG?=
 =?utf-8?B?aVVBemJodzViNTZCYmtaMkVLcFdHRHhrL2t1bzl3T3lZaTZPS0ZCczkxdVp2?=
 =?utf-8?B?UU1neFYxalQ2YlJFbE0xaGVlT3dsWm1pWit1MVcrVFNPY0xCR21ZM0RQdmVU?=
 =?utf-8?Q?yLS2DoLOsjIjcC94=3D?=
X-Exchange-RoutingPolicyChecked: ay0uCltdRBCvE7KmLQLrpiHxaS/JXcyTs3j5yEUzCnOCyRbPrVVMG+g68tZboaksuDHfZOcvSX09OpYE4lmvRcdHhEGM1kblVk1RmGpnflyBe3J/nstV6iBjqfT28lDA6NxGoYmRMuS+9WHxyg1cwMqBO+z5uAp4iSJl5tykyyGEW6qRngBoct4j1qqVal0N64dmubADZSVUYPcSUG2A/D4ThcNHrZUoTp6omlU4XwuKlkrq0FpHjH+pky8GqcJ8oYer2rYHVy4NUI1u1hOJiqHWx/pt5kFfhrMcO+lzQu9dCBkzr9zJXBdHmVZQfjgqoSUrCt+8CTaIIBrVeXnU8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2def3-f59f-4992-ccc8-08de8e9da0fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 20:47:59.8287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VlUdrAzJ6k9n19J/1GfS4wUcYoPCn5PqQP53WUKAm45N2NFtDtbQSEr0sdY38VcqCCLtJXoK2RSZr7wY1FQnG1T5nykS1TOBpoBDbT85rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
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



On 3/28/26 2:57 PM, Yury Norov <ynorov@nvidia.com> wrote:
> On Thu, Mar 05, 2026 at 02:40:53PM -0800, Tony Nguyen wrote:
> >
> >
> > On 3/4/2026 3:43 AM, Simon Horman wrote:
> >> On Sun, Mar 01, 2026 at 08:11:58PM -0500, Yury Norov wrote:
> >>> The function calls bitmap_or() immediately followed by bitmap_weight().
> >>> Switch to using the dedicated bitmap_weighted_or() and save one bitmap
> >>> traverse.
> >>>
> >>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> >>
> >> It's not entirely clear to me why this patch is included in a patchset
> >> for the ice driver.
> >>
> >> And it's also not clear to me why, but allmodconfigs - fo4 at least x86_32
> >> and x86_64 - fail with this patch applied to net-next [1].
> >>
> >> ERROR: modpost: "__bitmap_weighted_or" [drivers/gpu/drm/xe/xe.ko] undefined!
> >>
> >> [1] 2b12ffb66955 ("net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout")
> >
> > I'm also seeing the same error and no apparent reason. Since this doesn't
> > seem dependent on the others, I'll take the other 3 and this can get
> > sent/resolved separately.
> 
> That's because the symbol is not exported, and the driver is build as
> module.
> 
> It's already fixed in -next: 95d324fb1b484 ("bitmap: add test_zero_nbits()").
> Let me know if you want me to send the fix as a separate patch in your
> tree. Or I can take this patch in my branch, if you give me your tags.

IIRC there weren't any dependencies on this patch with the others, so I don't
see a need for this to go via the Intel tree. I believe this can submitted by itself?

Thanks,
Tony

> Thanks,
> Yury
> 
