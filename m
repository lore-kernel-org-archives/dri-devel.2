Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A58C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266D110E12F;
	Mon, 20 Jul 2026 07:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kqWeKe14";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7B910E12F;
 Mon, 20 Jul 2026 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784532956; x=1816068956;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TzR2DGdHxA9B2030mHiVtH8izIA17Kjjq8qjkyaXNt4=;
 b=kqWeKe14nWawdaj9hAVZBV3d0ittDakpeNhAGdsrovqXXE7A8Wut+U+8
 L1D7rP7h1JhqoujCF2ImuYWZAzX/F8BP6OMefGDtv8QjbsyQ+mCn9q6yd
 BYE41NgyyC6zK44kvFELDk9PXr+HPB1azYxdOmPq3Y4vZqXAFTIOBwoO0
 BcnJRVzdLLt+lZLQ6w5qD4kR+fVszHRhxu0pKtskUAe1EL//nUpC8xdjE
 lwUkMd4F2OwLjuHrihiLNbs891MishMMXkpeqwNIHGm0gAQni2J4FnMla
 zm8dTAFKAPluFlymgD5pJHct2+EMEc5Je435Vs+wgVneSHXrFCztAgU7a Q==;
X-CSE-ConnectionGUID: WIl3paXpSGKHrCCv0bkKYA==
X-CSE-MsgGUID: M7nbtRl8Riqfgmp3QGeVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95465645"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="95465645"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:35:46 -0700
X-CSE-ConnectionGUID: LvRNm47FSwy6r+OIloMgAA==
X-CSE-MsgGUID: /zZA6fb/Tk+eo/E1tzQl5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253977134"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:35:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:35:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:35:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGRxhXkMVhkzU9nO/7lPqWiHG1qLYudZydmyXD4fj9Nuk2kSEAhLZwExU4YQVzMCjM4DDcaLvbhfI5buIXZBuK3nha5aVGnr2pD7YJz4wGgzkweMBzjLxmAYuhy9G8L/7lHgfk2F5x8AtdQVtYdJ9WU1RmIJBS6JfLR60u3SPx+tsCqp4JjIgCvIcGTi6qG2oDsP+C4plQFWqYQoY2HEnPDX+VjK3aVnV+LojX8M8bIG5MaWvj8HHQR+NQaj4OkWCD832FtQwP/Mv3zmaOho6bWVwZ4y2taZGXb2qcytSMo7DSBlMFaoMRi7McoioolRZdKbPPUDjlTEvf+0MKj8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmvEqijvY0jaGe+EZTtDaJwP9MxiV8/ueGr9K29elcA=;
 b=plrHo58qA3/zEUq/eF8piEwW+kHHY2pQO4p7NIM+JrMRGcHOUlTNxLRyoisMH3dy9VlpScC7y7u2ruELNL0b7gHVMN9/LkrlEkepb6YtYJnKZGQo18xX7TGW6k+FSlquFMNLw8h9D9VlSY29MfjL4Q0S1TGwvNNze58D1Mk2356/0mlK2ymYm8U/ribbiPpr+aTf5cpjLatDOJMqXjGRDqwZ/a3J22K4T0nMxTekEswcNinay3id0sAvAtPnTZO0PnhbSg3gNrzjriXNAQ2YvbidqTjSB2MNh9ogZtXi4HsJIv6MCpBNIl0KCwiUZnaWvjWNQ/2S3EtHGUJvQAkG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 07:35:42 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 07:35:42 +0000
Date: Mon, 20 Jul 2026 07:35:31 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <maarten.lankhorst@linux.intel.com>,
 <andi.shyti@linux.intel.com>, <krzysztof.niemiec@intel.com>,
 <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs in
 restore path
Message-ID: <bktfgnfim2qkguywsf3fze2uljs42ic5wjcfa372fldeige2vh@2wci3ejqp2mq>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA1PR11MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e2f2e5-aa8a-4369-f1b8-08dee63180bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3liUnmTry4qYvB/PdPUn4Bqh0nkiQ5AYCwak9Y5utMbVrfsftp4+Zeqzl/d89gT76oRX4Q071zyBVNbQOKq+a/ZuXpnVwp5ERN+D25N8+IuZo4eu7zWcDhKuBgNzNB3tJ/1+OSwEwhKppXLrg+KzjtEv3ctE1D+D+ZKkCKVAVBe7Ngo7FYgtfRmB8wjoOoVczmuDrVzV6fYscX7dueZxpc/mwW0A2b47mlW5R+5hwjFZW/6LTcVo311VYMykIKu7HPlpleXqOWPzSCipMmxFtDHjZBi1lfFmGaxzyA85ZXSgXqaeQbmHI0nopvuN9blU7Rwt97AGD2mjNK4CPbxsdH0JQptMbThCQ2fBGrq0rjCX2xq9A3Eb+QTIhEwVzS1PSU3qXUtw5XfoAFklpxCnfuouc2PM4Fex3Bh8Lln6xKi70pSQskaeBJPdxVL2YbW2+DHcmshmSgNzWptDnepwcAzAHfLhpfvoLZE0HODblvQ2GnTLkB3U48WexCaeTFSARX7PX6JtvDh2XjccWbPgueNCMF4KX3hEcjBaygeRRPdz+kMDzE35wCy8/13QwTku6tkbHoHjTh/RCcze/SwjYy0WdjaIe4ViJM/kKfWQ/nGV+uyu4/hmmORY9dMXv8o4yibR3wcHlc03PnBAIziI7+IiPUDSV4xX5bl1aXzTQHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVocjZtS3gzVUp6MGZzR21pYUQ5Q1RkaHU3WGtpdUdPVlZMd1Fjbm8reDdH?=
 =?utf-8?B?aG1BK2tFZlUyS1FwL1hYaWY1dEpIVldCNEp3NENXWTl4STdrYWxhaDNqVG85?=
 =?utf-8?B?LzNrNzdkaU5KL2JNMUV1UzNSeDBEeVhWZnlJWTdvK2VzYUdVNzhlYWx1amVn?=
 =?utf-8?B?cXZOcGlVYW5lQ1lMVU9mbzhlN3pHVDlxbXA5aDZHTWsyVHVCYzk3NG85Z3Qz?=
 =?utf-8?B?MVhpWnBRejhxbVBzUkhuaVZPa2J5V1oyc0JiU0E4MW1tc1R0ZUFaRXl5U24v?=
 =?utf-8?B?anlPTE1JRkhxREdJd21nRUR4OXltRDNzVEkxaVh2TitBVlhwMXZrUHIrOHR4?=
 =?utf-8?B?LytaSU5RM3laRjRFTXNTVlY4dmJVSW9vWkh0WVQ2c3R5Qzg3VVBnam95TTdq?=
 =?utf-8?B?aHZQdElSWWFqaXgrNVI5c28rdnpSU0h4QWJwNExXdHRtalkwMEdQbTdVK3FY?=
 =?utf-8?B?T2s3K1NTZmxkcFE0WU1hZEhvL1lIL053alNpOG1zM0dvVVFza08vUGU0Z1Ax?=
 =?utf-8?B?RnRJanc1UEVLZWYvcnhqS21RYnBxQm5nbXQyL0VyNTBUY0k3MTlxeUVXYXph?=
 =?utf-8?B?YVp2RkNtU00xQTlycWxuNVhFd1ZxeU5BMHBsSVNUOTF2Q1YvblJQTEJxbVVO?=
 =?utf-8?B?OGVwdVh6dTVJTHY5RlQzQnVxRlcvUFhDNkhvWGF3WnltY2pGelVJcDc0WEg5?=
 =?utf-8?B?dWRlcWcrdnc3ckNlNUVTQjdyT2JtMEJYamNJWWU0UmxoK0p1T1NiNm1haGNY?=
 =?utf-8?B?TG1RV1ZzYkYvdGNRMjBkdjNvVG56VTRjNnRFOFBrRGtMMURaUk1RUVhMaGU2?=
 =?utf-8?B?WkZDVndTYXZ1N0xwNFBjcWJrY2lBZVBUdXJwSCtlZytvcWVIem1tOFNmQ0dr?=
 =?utf-8?B?YUFKUWtjTU5DRWw1WnBIZzgwRDdyUVoyNThlVXJXZmNoTnA5WUIwcWZQYzky?=
 =?utf-8?B?WWppSnE2NlVLaUlPZ1IzemZ1VjVjaG5CZWNKY0o0Syt1OEFtY0tBcHZPV0lV?=
 =?utf-8?B?S3hEdUh0Rk5WcWtGYTJDVERLUk0zNkFMVEpIdmd6ZFV1RG1NRUpvd2ZpUmNy?=
 =?utf-8?B?amJuYUd2M3RuaWlPeTd2aTBoOEhvNzVWd0pUMVQyRDFlTERnNXZabGxNelNP?=
 =?utf-8?B?Y3FmQUZjMHAxQVBEUW1PeGlpb2FiK0cxQ1dtYUpWTmJiS0JNb3ZyalJJZGMy?=
 =?utf-8?B?V3FrbmRza0NHUGM5Tmw2a1NkdXF3bzlnVXhaWXJiclFvNHhZbkRKMUY2cmN2?=
 =?utf-8?B?Y0VWMEhocHdtUjFzMFFOV01GVGFYR2ZuM2pCWnlkS3BQTEp5SU1FRHF6SmRx?=
 =?utf-8?B?TE9UUUUyTVplZERKQUxldVZKMUpTZmwwb2l4a2NudEZNNkY2NTd5QzZ2ZE5n?=
 =?utf-8?B?YmIvc1UxZm8vbFpEWlVENlFXQThmSHJrQ0NuSVlWTFg5dEd0b1AybElhV1JB?=
 =?utf-8?B?WUQ5MGFlSmZpZ2lrZ3Vvem9Wem05ZG8vQW45NEFtb1JaaURvSEpJN2JRUW5w?=
 =?utf-8?B?VTZFem5CTGNjd2VGUkVPTlhtblpPelpUNENTR1FuVkk1cnpZSkZXbzB4V1Ru?=
 =?utf-8?B?M2JsY3hrRC9peHFlU1p6TVV6OVlQMW04emhCVE4xWUpFL2EvU3h3aUo0M0xO?=
 =?utf-8?B?UTg0WkpLZ1dSWXRMNWZiUVJ3VWFKQzJBL0M3OXNvV0FzdGNTS1FuMGZoTmNK?=
 =?utf-8?B?dFJ4RS9WS0tRWGQwTURTZ0hQd1lWWnhUK09XN21JeE1uaXkyV3Qxd0tyUWR0?=
 =?utf-8?B?RVNNOG9ab3VXZFByVDBWQ2N0TGxlM0ZjU0VKWDBwWlVqNVl1aUtieWYxam5I?=
 =?utf-8?B?UG8wOXpIR25PTDU3RVFiY3dCa2tRdEQwSjNIOStCWThPT0swTkhuYU9QU0U1?=
 =?utf-8?B?dkIxUEw2aHkwQS9NdlRSQWtSUFBTMWhJN0l5Rlp2d0pSWHJVZDcySVl1UGty?=
 =?utf-8?B?N2lpZnE2a0puV2JIQXZ4VTJwZ295S0xJTVVNRmp6VXpCRGIyZFpzVEdHeUNw?=
 =?utf-8?B?K3UrWU1qdCtvN3I0YW1zYTNvQWVrWWpyZHRpQmxLZVVsNDE3TVI0UmVtSWFT?=
 =?utf-8?B?akF1Y05nVTZLa2hYdVZoeDZ0UXVQMkRNUm13YUkxWjVLU2Y1aGRGcjNuNFBw?=
 =?utf-8?B?dEw5eTFrNU9tVExqWWVCcVdHaVhDZEhORzhoakFrdEFIVXhJUml0Y3VSc0Zx?=
 =?utf-8?B?Z2NHUGI0YmxqTnRHNTVZYzRla2c0Nk0xaTd0eWVueENFNUx6OGlMZWtPVEFU?=
 =?utf-8?B?Zmtja2tpYVZVZm1odHpEMHdsRVlLa3RhTDBaWmcyZCtSUTdDSFcwT2FuUkU3?=
 =?utf-8?B?SkNEVGpCdjRUN1l6WmRwOWNqSlMrM1NPZE4wakkzNjhvRFdjdHFQOEN4UWsw?=
 =?utf-8?Q?9Rg0+42yPtYt1dpM=3D?=
X-Exchange-RoutingPolicyChecked: Gipx5vbkD0o7hF7ZrnsMk1AsIFh1x/ntCUKp4XWiV7mu/+v3FeS6xVowlXI7pD9QvpAkeGnTU4s64px15AC6QBL2nUEMETrX4aI5nWc10asel5kqOqOTQdUdADS4Bx7lrymkLvG71WvcxfhPQPwQTgYiaXgLKDtaF6auPQkNjjwXQ4ZfiHwbefpED4zKGXkDFOipqNecPT2lQPXT45NYf0tvf+fbiNRNQTt7nWR2w5H1B1Cy4xPceSKCFGeHfYCvG/z2BefxPLVwEpKCuhdqb5KzeIS1704o2KawI/PDpUYY6nrMuCcg8jsUk5luqkM39x0q6xZqm+nqD96fl5rluw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e2f2e5-aa8a-4369-f1b8-08dee63180bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:35:42.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H+iad20ZdSKhVbLfPNXoXvwvPX6dOebrE2nFgpIL8tJZUS67pj1TB/Oo0hN7TgolW6e+Wo6TW88Zequ/Rv3nlyfeFqWvZeHzGm8FAa3zwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
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

Hi Sebastian,

On 2026-07-16 at 12:14:33 +0200, Sebastian Brzezinka wrote:
> When a driver's fbdev probe callback fails before assigning
> fb_helper->funcs (e.g. i915's intel_fbdev_driver_fbdev_probe() bailing
> out early on a DMA/GGTT pin failure), the fbdev client stays registered
> with fb_helper->funcs == NULL. Any later restore, such as on drm fd close
> via drm_client_dev_restore() -> drm_fbdev_client_restore(), reaches
> __drm_fb_helper_restore_fbdev_mode_unlocked() and unconditionally
> dereferences fb_helper->funcs->fb_restore, causing a NULL pointer
> dereference.
> 
> Guard the fb_restore call with a NULL check on fb_helper->funcs.
> 
> Fixes: 2ef5754c9649 ("drm/i915/display: fbdev: Move custom restore code to new callback")
> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 7b11a582f8ec..77ae9bd5ef3d 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -146,7 +146,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
>  	if (do_delayed)
>  		drm_fb_helper_hotplug_event(fb_helper);
>  
> -	if (fb_helper->funcs->fb_restore)
> +	if (fb_helper->funcs && fb_helper->funcs->fb_restore)
>  		fb_helper->funcs->fb_restore(fb_helper);
>  
>  	return ret;
> -- 
> 2.53.0
> 

LGTM:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

-- 
Best Regards,
Krzysztof
