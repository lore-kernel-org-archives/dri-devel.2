Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D78CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131EA10F2E2;
	Thu, 28 May 2026 15:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bF0+VSRT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DA010F2E2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779981882; x=1811517882;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tN0Zox+zscVT61iQDrIe7lbRpNdsm02vvOAK4XvDPv0=;
 b=bF0+VSRTkD/NsfgwLksUDJvtlyC3mk5zrkOgk2wrQn1sETgUwmAIuk+a
 rAaBGIB4pBrgF1CqstKm+LlJXBqAbMTftcNFr40mH0TGgZoWL13IgGtjT
 oElJT9oXnFDZl35YZLqBz5GAnoTpzfl0r26HVtDuSX4uiXCTD39P6g4Yh
 ZwSJG2E2IUOOXry+V1Y7tUSCV0eae9phKH/0U1wkItTjx2YpJ60wB1xbK
 8nYWCOFT+x55/seWcJI8nlKqLYIp1eAtFM2yA7sLiYf9fCGSJAIFpl9qQ
 1V3dtKk555igStAI+957yigK2QEadBJZHvcINURQ0MyPLPy/XAfU052IL w==;
X-CSE-ConnectionGUID: 8XJPwGWmTvCsKRkBl6IFdQ==
X-CSE-MsgGUID: BepvgS8lTCqQSpRYub8SbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80888352"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="80888352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:24:42 -0700
X-CSE-ConnectionGUID: FbbBVO6/RsmTc3OOI2nHJg==
X-CSE-MsgGUID: GRM9A5YWTte7b0At2QBtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="241539346"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:24:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:24:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 08:24:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/i4Wp4QkYfR07FAYmSKcA8slBkbO/wAJFJnsUM5nTg5Z34iug5EL79LNFHm3LnVXqpkpCS2d7fN5qXkEM1eL4qCPsF/o31KxRWBUz8yermPBrL4bAmXKGI9vbikbwdvxRPDf/I8gDJtg+TYoGAbFoqqcRkjUqiCG4LqwB707jnXpjwIjtVgniXCabMSGyUIh8en7iJNDHl7Xew2ektnnzphdP9N5H2PTbGIo1v8B5Fh4h44IjGtQouogzWMtyhSk0IkFtQQ9HRolHyrcAe0uUmMnesaex4XJrns2KynPf0GaEOrxkagODjVkOxbDZcTfhMMWr1aDf41eRCaa8pFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFbP0KyXDwxoOAiWOCQaGNgdjGsuNpKUdm6qkxX4JuU=;
 b=WAT6lPZX9Y8/d40bzw25YPvUOcp1dINOrbLTVmUixyBoqmGCpkh1FnXUu4U1rk/V2KXQKKEG0EWSe0I345yETo8CmjlwBLH37ImeX+wcGRycbCGp1+INWBYvQkcwe25xkd7e509lNsysJuiSfOog+DnNqWnrc797q2IJnjTWOVN5IsFbX9qjqzld9t3trFbV1RnhNZRjruCYulPGB9FVU1HzpmOW0SeZuS5Fhnvgh/7CmzcZ2aJoI7PR4q8EI3X+wNLCh3DhDv9a3ydbdqPaRKMRSfMwFbcBd2WZu3oF0ppml6BaMHq1/JSMGJw90XGjf0IZ6tmbLqADh0+nKcbXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:24:32 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:24:32 +0000
Date: Thu, 28 May 2026 17:24:21 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH] drm: Set dev->registered back to false in case of
 register failure
Message-ID: <ednzkzzbdyabfyvgwkpwqttueqh5taaovhuidfkyc3e2tupnia@7a56amg3bmto>
References: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
 <c55da1fa43e00d755191520e8c03a7659c6e892f.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c55da1fa43e00d755191520e8c03a7659c6e892f.camel@linux.intel.com>
X-ClientProxiedBy: DU2PR04CA0192.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::17) To PH8PR11MB8014.namprd11.prod.outlook.com
 (2603:10b6:510:23a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 05629966-5824-422e-3a5f-08debccd372b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|5023799004|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: FT59Y1bThFvYI1Q45yJEsapWMy4e6h5bkVwWxu1JNGqXWuQ+EqTHEBJ+aI6eVb2To8/QF0v5+oZ1bqRFYr79QCv07glfevshthZhdFebgUgNUyqYIQWdCmwmnrZvfd4QeRUImQyL5yw7McpHxzvH1LBU4xicTbcnQIko9nHvdqoUbkErkKxtxBx5K2v6IU1pkHszZSQQHBgJh2GVfmi+/2tc7XitfbS4iE2z38K8eRhcg6YZB89MNEGAIfas5S/fczf2fjE0kvVjipALzB/4wYQY8pmOtbyP3amNwlPRubZ7KLF5H6S2MlCSaH3q0+ndQd0VeKyRkph/TMNXpqwPATKaHuz6pWpJeHjiBfzvMFxJD1U65Mj4nhfg4ExFoThYCvKqK5ZlrKwhG/QugfOmqN0zwbIYZzlCgsVLG+FjK4qxW8JzCV3e87ZVtzwhSalQK6DsOkO50wtt3R7iTbWVS89RIm+nYbtAly7kTybg6YIMPIWWyLYYI5hupcRElMX79ZqEaGJTkVPDYwBNTM6B0NMlWqyRtiJ2H41J+jLYagd1ycQJ4+ow1SbWseshtQsi04IRaIYQfU3E5lHXVkV7HFNN+K/46Xmuhs/s0UQzEaFvaaT6COEvZLIm3UfFthakOP17BoW2pwnb2w9rSgq3s/BC12VBeO+d6nLl9CTY1ESzCWNa5saerc9j31BvX5zk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(5023799004)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZVdGNScmZNU0NXaHdkQWNHdFFEeUNya0Z6c1NHK1lUR0YxR1J6bEl2ZUZW?=
 =?utf-8?B?Z1pVRk1ES2lmYk9NcktVOUV4aWNmcS9ta091eVRFQUZXaSsxZXNQeWRFUXFp?=
 =?utf-8?B?Z3IzRmRGb1VGZndCVXl1aGNBam1RdkdCdytFcndJejhnL3ZrZGpjZGpLWnlj?=
 =?utf-8?B?ekFQZTFkSElKdi9DTEJBcnhHcVByb3llVTdYeGxIL2dwWUdaUzZqeWpmQ0d6?=
 =?utf-8?B?MmpySXlYM0hseHA1UHo5bWlJMTVZNTZ0dDUvWnNzc1RTK3hsQUlMcTdVeXVi?=
 =?utf-8?B?aHJXc3NzaGpIYVZQRk9xUWIxVll1UVlrcXgrMjZLUEpad2RXUk5tcUFQaERG?=
 =?utf-8?B?akxXL3BjLzJacFROV0x5TG5BaEpva0VsVjJ0ZytaaFN6WnRoMUt6S1Fpb2FR?=
 =?utf-8?B?dzZOQjBnT2hHem1yNUlUeTdvNXdNMG5qRlcva0wyTmhoUm45dW5heHNWaFNr?=
 =?utf-8?B?dkM1WUMzbzI0anpLZ2NnNGFXQ1dnZW4wYm5Kdi9NU2w3QjZoQWZpTHN6enh4?=
 =?utf-8?B?U21naFdTQkFFRzVBZHI0MG1EbXZlKzZ2Q2dWWGtNVlBaR0tDODI4MW1hb1hx?=
 =?utf-8?B?Q29iQVh1OUt1Y3k3cXFmWW5jckpRV1FEbmRDYktsZnVaeS9TTXJWcG05bS9S?=
 =?utf-8?B?U1lTK2o0dDBRem8xSEFleVhIaFdlMkpNL3JndXNrajhLZHpIUElIbTQxdzho?=
 =?utf-8?B?ZlZiaVlJak5TYThIOEpLQllmYXNidmwzaWhpZ1JFMkdtdmdvdklZWFhPSk5O?=
 =?utf-8?B?Y2hCS1ZFbmVVUzNxeWhvNThrV094MXk3eFRUK01XeFVkbTR5WlE2NGJDSUl3?=
 =?utf-8?B?NHBteUJPV2V0MkVQTU1mc0h2dGpzMkV3ZGJhZzZiM256WHlKRUE0YU83Rkc5?=
 =?utf-8?B?OUs1Y2ZpQ3BuOFJjY2VpNTVOMHlZQzc0Zkx4T1ZObkNGaUM5T2FQSzNjNnpi?=
 =?utf-8?B?U1FUTFpHNzZ0QWNvWVgxaHdoZzczL3ZoUnhaQlJnL3QrVlAvYXVkS2xxNWdl?=
 =?utf-8?B?cThxZEM1QWhBdXJJRGY5YWFGTjZMbTNyNUMvQ2F4Z3FzeW9QbTJBNjVqNjVX?=
 =?utf-8?B?T1hFUnk3OTFCT2s1R3N1N2szUi9lWHlBaUVHSjdud0RBQzcxazBNZXJvd09l?=
 =?utf-8?B?RU5DVnNxQ2ZHWElMbUlYQ2NXTHlzRHhVV1g5VWRadEVBTEVFWS9FNVFxcERR?=
 =?utf-8?B?emxOOE54MExIU1l0NTViZ1F5V0I1ZTYyNHRuK1lqMlk5NXhIQ0pNcENSOXpn?=
 =?utf-8?B?YmhDTU4wcGRvQWVkeTlxcHZmYy85Q2NrNzl6N1FtZi9GOUU5UTdRS1UzNksw?=
 =?utf-8?B?T2IzaFYwa2tCM0w0RUNpT3ZSRjV3THEvL1doQ2tsQkN0N09jeFBzeUNPOUpr?=
 =?utf-8?B?Tk1nYmhRVlcwS05uVGNlZzlTV2xWbTU3TmxnYjhsaUVXdFRHeUFiZjdQT2ZS?=
 =?utf-8?B?MThxLzZsK1p0YitDWUsvNmpPTjAzUmRlbE1KM0ZIOUFPR1hUOWJuL052YzN4?=
 =?utf-8?B?YTgyQzNTdWorM0RtY2MxbWQ3OWpDeWpGUHFsaDhkVmdJYWVUaHpObkFBY2M0?=
 =?utf-8?B?M0ZiV2RRT3gxRjVwTDFCSHoveElTQUdxa25BalFOekJJNXNKempPN1J0UmVN?=
 =?utf-8?B?cDN2eGNRT1lGbGxWVG1id09CY3ovZVV0L3Ntc3IrUmVzZXhnTUNTMWdTUVRk?=
 =?utf-8?B?Z05iankrTm1zR2pGMGtLRUVhaDZaZGp2NkFLZ2tuMU9aK2k3MGYzeW12K1JZ?=
 =?utf-8?B?VGgzUWR5L1pON0JveWovR2M0QmxML1FGcjM0NnF5VFZIWWM3V3E3YVFOcFZG?=
 =?utf-8?B?Ukh5c29SQWs3MlU2UzVwWWZvZEFNTk9GeHNiR1hzQ1F5Q213Z0NKWGR5MUVs?=
 =?utf-8?B?Ymd3VHVkSmJiMmNJeFl6ekJXazZiNGZxVkpEOWtocEJWL05NLzlmU2JHT05Z?=
 =?utf-8?B?T3pJRVhyS2VvMVRGcTNEZUduVjhKQ3RsQjN1cWhoVE84ei9UTXJxU0pJT1I0?=
 =?utf-8?B?T1NoK1FVVDFVQklvTHNTdDFJRmNvV0UvTEpvcFNqdXp1YTBDT2twWGtsNjht?=
 =?utf-8?B?SmpNQjRiWDM4dC9VTTBLNmZxazV5WmM0NmV0WFMxZ3NGOG0vYnFOSCtKcVhT?=
 =?utf-8?B?TVhqc1pZQXJVNnVMWHJVSFY2cUFaMUcvc3pOUDVVS1FvaUk1WkpEOXJWcEtO?=
 =?utf-8?B?R0NFTWcrOUJ6S1VVUC9wc1dLMjFMYkduYXdzSHpjREI2N0JkcjRHZVdBSW1Z?=
 =?utf-8?B?MVJ0bkw0UTg3aHJvbFZwdkc2VmE2RXVFeS9zMndGLzhxSlVranlNQmJJNXBW?=
 =?utf-8?B?QndrNkloT2QwSUUwaU94SGFZK0lrZk4wMDlVVXhDVHg2Q3ZmVzlIUWFKT1lS?=
 =?utf-8?Q?t0UW+QVscOT7dgOc=3D?=
X-Exchange-RoutingPolicyChecked: tBVijGq/i9jbRAuMCnMuO4uShVSygbgbLEkunQ9g5gh3BckN0KxgVT1edqRez8LHOIqnnjbFl3DgouYQMFl4l95/PZv4KyAplDiDweR3VcipzuNxkcnl1LEuZ5yLwnELEvxCopvzd0biLU7iXz9zxC2DnEm5z1eo9byzWwo0PJaiHMr/ZiNhnQlav6ONy6RQCmmKLkPwCh/XqmVaElVvQDRQdwVM6zNOCQXhVyrauTrPKdaHXrN5nq6tHuS/iO9ZFNfKJpw4E98txTrWv/CiRwwysCdYQX9XFwScXuXknhUCBD6+kzdEFRRuShH9b2wEMYg8kpHMbP3XeSXpFvmKUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05629966-5824-422e-3a5f-08debccd372b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8014.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:24:32.5762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsbXUsh0M+kveIWmzhOqPh1X7D5rB0cAE3c4hOhGYyUy25Q97gzSv3LR1DsPtAIrTUEnzjaFCwPMp0Ps3vp8lpoNjYFN7Cw5OciQY2yMPfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
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

On 2026-05-25 at 10:16:32 GMT, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> On Fri, 2026-05-22 at 17:40 +0200, Krzysztof Niemiec wrote:
> > The dev->registered variable was initially added in such a way that it
> > is only set after all functions that could have failed have been called
> > and haven't returned an error. However, since then, the function
> > drm_modeset_register_all() is being checked for its return value, which
> > opens a possibility of failing the register after setting the registered
> > variable anyway. drm_dev_register() cleans up after itself in case of
> > failure, mimicking the functions called in drm_dev_unregister(), with
> > the exception of drm_client_sysrq_unregister() and
> > drm_panic_unregister() (_register() counterparts of which are not
> > checked for their return values), and the dev->registered flag.
> > 
> > This creates a situation in which after calling drm_dev_register()
> > nothing is registered (as the function entered an error path and cleaned
> > up), but the device is reported as being registered according to the
> > dev->registered variable.
> > 
> > This, for example, confuses the WARN_ON() in drm_mode_object_register(), which
> > is raised if a non-dynamic mode object is attempted to be unregistered
> > in between the drm_dev_register() and drm_dev_unregister() calls. If
> > drm_dev_register() fails - meaning the device *isn't* registered -
> > currently it still reports dev->registered = true, which triggers the
> > WARN_ON(), even though the usage is correct in that instance.
> > 
> > Set dev->registered back to false in the error path to prevent this.
> 
> While you've also submitted a patch ("drm/i915: Remove drm_dev_unregister()
> from the error path during i915_driver_register()") that adjusts i915
> handling of register / unregister steps after this fix, have you checked if
> other drivers are prepared for that and won't be affected?

I just did; there'd be a problem if in the error path triggered by
failing drm_dev_register, some driver relies on the dev->registered
variable to be true to do its work.

There are two main patterns of doing the error path in the DRM drivers
I've seen - one is just directly returning from the overarching function
with drm_dev_register()'s error return value. The other is invoking the
.unbind handler of the driver via component_unbind_all(), and most of
the time those call drm_dev_unregister() right away, which sets the
dev->registered value to false anyway. In these two cases (if
drm_dev_unregister() is called in the second one), the problem doesn't
affect the driver at all.

In the case of i915 not setting the variable to false on failure
triggered a WARN_ON() in drm_mode_object_unregister() because that is
invoked indirectly in the error path due to the complexity of our
init code (even xe just returns directly instead). If another driver
calls that function in its error path, it will just silence (correctly)
the WARN_ONs there.

The only driver that explicitly checks for dev->registerd in its error
path is msm, which does that to see if it needs to invoke
drm_dev_unregister() during unload. This patch actually fixes a bug there
because otherwise _unregister() would be called even if _register() fails,
which is not correct.

All other uses of the variable are outside the error path of their
respective drivers, so they should function as intended even after the
change.

Thanks
Krzysztof

> 
> Thanks,
> Janusz
> 
> 
> > 
> > Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> > ---
> >  drivers/gpu/drm/drm_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 985c283cf59f..92403d79bb64 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
> >  	if (dev->driver->unload)
> >  		dev->driver->unload(dev);
> >  err_minors:
> > +	dev->registered = false;
> >  	remove_compat_control_link(dev);
> >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
