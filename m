Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8367EF5A8AA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A5910E19B;
	Mon, 20 Apr 2026 19:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UW2bnJsA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527D610EB31
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776712237; x=1808248237;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=hvLFW+nW63ArnDGCfm1gOovWk3EtFU1b5lIBHBqdJ2Q=;
 b=UW2bnJsAZFvP/8O29AHTDefhs90c2/WFB64QIWOoUV3X+JVqieSVGXNc
 SbqDptTGxc8k9Nv1mJnWYUvCYHaUwEsFxPvSHhStLZZu7Xou+H9FX+DMv
 Ut0bguFH7G2iYWWB+IDJda09PTtWiijcQ+8sraOBbNiutLJV/qIy029Ek
 T8w4yp+HAIHn6f7zOp8fC2oRwiEkX46FJC446nxWqUf9zPDeGUW9dnNwp
 gThFA5u6HygTFMUE3OeVJSXZ4Vj3fVfB4mC1+M/2rPmwhOy2pHQ/ucNzE
 Uz1Gh6kFPO2daeJEeW9dOtKH5kmMjuX64JMRi7R2fI08QdqkQyrCZn71o Q==;
X-CSE-ConnectionGUID: m+gqq8VVTJChs2O9m8QhPg==
X-CSE-MsgGUID: 0D9qVuTeTJajrWTJT9kEvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="65172487"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="65172487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 12:10:37 -0700
X-CSE-ConnectionGUID: GFZbaH6FR/mYbcVMpCasTQ==
X-CSE-MsgGUID: QR1vylOqSFufB3Bb4pDhFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="233568448"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 12:10:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:10:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 12:10:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDGta6i5lm/acgrdoocf7r0zsORw7cCjAamCbZqzvqht9fO8wpnvS8bYute01PDKfuFaKdmujUvlaheu5jwyr5mitujslBrSWiM71MhYJkdOWDVFZTSO17I3dIK5rkUBedBJG40gsyTQuxPRI8uU7FzZ7XpipP1N9Am2DLV6aYcBs6e3oem2ImZYhkTlq9u8/Ddz0Q1OSJ0ft8PBHfyeHwTuNmK6fODmhv1QbDHMZkzozyg1R4t/4ZV4x4glNfgaSX5FTuT5y+7u/DNO80C5PgiSv+fueVshCrPSNC/JZcKJunIGTLYUnYrO2sFI9HNoi/weptSLQkpSELpXC16iTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DnLv7RavFSBJUqgCy8PQrNHA5nEj4OxGP55g2wrEtU=;
 b=eCjZzq4aheAlY4wrPRwKhfquHZHfGQ74Uhe7TiHNreezv/7kLwFUw9GhBBG92LJSFU5n9VioQ2gkGC3SkmFwL1A+x+08f7MLvhF9+SqAaygdpaJ7twpCUajwnMbYVXCu8FEwucA3tPr7sOQ5jHWtpjhY+L7Zf/wIzGLPRHnjVXebiqjtPDGpviGgv7ppuDnM24IexxusnwSeEb4JrqKQNUY133Sqo/WDNMz+U+v974LuuME6tRRndEsG0SUpF5tx8ZZUcrWQOl3CuWl1eiHXx3wNAmcj+h7gP9kr3b+K5vmZWohxad/tzhuXrm0fb/Q0uRxnRsyFqxHhujhatVpy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 19:10:33 +0000
Received: from SA1PR11MB5900.namprd11.prod.outlook.com
 ([fe80::d294:7b1f:a7a2:e803]) by SA1PR11MB5900.namprd11.prod.outlook.com
 ([fe80::d294:7b1f:a7a2:e803%7]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:10:33 +0000
Message-ID: <97d3d711-1e59-4c78-ba1b-e7ad7087523c@intel.com>
Date: Mon, 20 Apr 2026 21:10:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/auth: Only drm_drop_master if it exists
To: <dri-devel@lists.freedesktop.org>
References: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
Content-Language: en-US
From: Maciej Patelczyk <maciej.patelczyk@intel.com>
In-Reply-To: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::13) To SA1PR11MB5900.namprd11.prod.outlook.com
 (2603:10b6:806:238::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB5900:EE_|IA0PR11MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dffb6c5-fb90-447c-fb8c-08de9f107eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: omLuqaqMiJn/8zn3vNDfF9QZpw/u8Y7gXgAZNAiyLKwex4WF9dzL5Ih0BhGtXUgYgaa55IVbspRp3v3E5zELmN0ci7LVRNq/8bEcwo6q1IREcT+fNQKh1cgUPI/EIKKSWgfAIC2vfCeUXoaCkDIVCVeH8dy1LUxXtI/2xlyy1bq/oZPGqu1UoY9cvrhYo/oUp36ptaeYwg1SKyaXAy8cfRsROur6gaBEzQxFQkBjY0/sx/au0X2azUq0eklrq+vo/YfyXqphSfehylnIXmHNQ038HsLBKN481e/XrMCGtf0bnnTw9VYno0crLWTb3S9Fp13xfl5Q9Ook9asgj74MUQVBTuOL6qL1b+O9iJU8AGMO+m3sxpeh10poRE3YKY9AEWks+3lglRdVn9Sx80AccSuKy6MgL8QUIKnQF6NfJu5OofwOrOYxbNG+go3l6vR6B8SDMR5cpS4Bd9M1cQ6AJozpfVV/7b//2pbs1GQBy67/n2+NvrHPP3BLj1RcReO8/A/ObwQ/8Xk+xs3Fxg+asLdR3vQXEDmcGjJASZwj0JX+9tsNEWc6E2nNHGcMJ5Dy4NlPhVNJcRY067nwJ/FBDWpTOezm+x+PSSy8l2KBQp9AbJwOYXszgqA1IOOSKZPiqvQGaLdCEmun4GpW1RO498jxcQsoU1NxeHcydV2z16neRm46GzcMcZ6sL7XbvY4lJyQja9aEj7IKtpIngRwsVw4qrredtZ0HuDBy5u/o5YE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB5900.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdMSDVPZXRVV01nNjVHVkxCODNsNzBUbHNFWHQ3MHh5enk5eFdwd3lYMUww?=
 =?utf-8?B?aU9aVklPbXF0clY3V25FMUJNeHF2Nkt5Qm02MUJVUzBvalNHbzQyTVFiSk1m?=
 =?utf-8?B?eXlQbGtaZ3d3TjI0RlAwQUoxWjIxMEd3V3lYOFptMnFMd0E2Q08wN2ZZUWE5?=
 =?utf-8?B?Wm1qZWZFYWt1OU56TTRUdExhTVJxRHMvNHliZEpyOVNvL2I3TlVzbnAvUW4x?=
 =?utf-8?B?dXRCQjcwUE1TNDRLd01ZSk1HSXJiY0MvNEpqSTU4cDM5TDhBNXQwbW1mczR5?=
 =?utf-8?B?RklaNFNtMnJmVjhha2FkN0dLYnFpTWhwczg0alN2K2ZzVWNPeEc4S2ZHZTl5?=
 =?utf-8?B?VFpValFjejVkYUJONFJtbGlCV2JZQWNzNU1MRStPUE9GZW9JQk80d1hzVDI2?=
 =?utf-8?B?ZmY0a3lLQjJ0aEkvNWFyTDVHaGhKK2lrL2I4T25kY09BV0VoSXRzblBQdUo1?=
 =?utf-8?B?VloxV0V0Z0dId3NZVWprNjR1d0RJWUw1MHk2NVpiZG1hamQwS3NaMFlzTzJ1?=
 =?utf-8?B?Qm5WUXZTTTdjUnlzRDVkbzNVQjMyZ0h5ckxyOHZ2NHlJRFpRMVFaYWtwbHM4?=
 =?utf-8?B?M0M3VlJVV1c4NjNRU294eVQ3ekRtTUxERXdHZWVZeWd4QzZKT3NnR1crSXQy?=
 =?utf-8?B?YU5taE1LZ2E4dWs1b25NZU9FcTZ0elM4TVcrMCtyd2N1QXZkeTd1YzZMSnpE?=
 =?utf-8?B?NW9oQlJueTA4SVNqYy9SR0pXbXl3Q2l6WUl3cmtXM2dYZTA5cC93NEhZd0pG?=
 =?utf-8?B?MnhKUUpPSXRVNGRhRWhKQlB4cUlLQ0FMWGRCWnd6anplSnU1Qi9mc3A1ZURo?=
 =?utf-8?B?Nld2WVNrWkhUekNYUTNTTXpiWDZ1YTF3Z09wVGNmSC9qQ2tGQUxUeThNdUw4?=
 =?utf-8?B?dGM4T0hTVlEwYzJ6Z3pJSVkzTlM0S2VWYjZWYnlaeXpaUGxadTVYd1hOZjM5?=
 =?utf-8?B?dnRvK2t0MXdBeDJVQ0JRZlJmL3pybWtVUmM2YU12VDczNE5DNjNTSkRNdmVW?=
 =?utf-8?B?NTgwd1pHSThyNnExSExvOTJ0bTIva2ZvWjVCYkdRbmJrZ25Icndwc1NQaU9o?=
 =?utf-8?B?aWY0SDVhblJ3S1M4UU9nSHB5b0ZFQStmVDYvWGlEVGhuTmMzRk5TSmxiSXN1?=
 =?utf-8?B?LytzNytZUmJITDVXTG8xdXNEK2xFTDV0ZWZnTW1MM1VVbnYzdzU2YU9lTzdy?=
 =?utf-8?B?WXZyZmExOW00Rm9RUVI5RTR1ZHVoMU0xRWVhNVljWmhPU1hTNGtZS1pmNUhh?=
 =?utf-8?B?Z01zUUUxWlhqYW5UWU1Uc0t6OTAyOWIrZzlkVmhBQXRRTi95MTdGVHdjUjB6?=
 =?utf-8?B?aUM3a09SQVMxRWw4NjZJUXM5UzV0cHd2aUpZak8ySnQ2K3ZZOHJJbmd0dHdI?=
 =?utf-8?B?NjRZeHBpNW4wY2RWU2l2OXNqL2VpVzAzMURsek5DQ3NUMEEwTXA0S1kySFhX?=
 =?utf-8?B?YWUzV3hLTHJEY3FlV1ViZnRDVUtvNkJqWXEwRWErV1Facm5BNzc4YjgwMXNI?=
 =?utf-8?B?c2tKYnVldmRqd2JWMFhWMlVMcVFzMDEvWUZnV20vU1BqeC9vS216cmhBbDV4?=
 =?utf-8?B?RUc1TktCRlJ6cDQvZWlzNElnWGpvK0VhN0ZtZEc3ZUFwT1ZWMTYwcm1zUEsv?=
 =?utf-8?B?c2VWR2owRGZXMjFCT3Y1OURCTmNEMEJLVVlEZVhCdjMwdFJqVHhwbzRzaWxD?=
 =?utf-8?B?YS9paWtCaFN5a1lZUi9HTUNDMFZpOXBJQ0xML2RDdTBEZ3RnQUJxL2cyUThK?=
 =?utf-8?B?V0dFY0tVUTlCM3ZHWmFqUlk5ZmlCV05KdVZpSCtFd21wUUhka0Z3b0pvTTBr?=
 =?utf-8?B?SlVYbHZpUGhLTkQrbEpXdnU3a1ljTUdFbTZoNWduRzMwWnNTaDhsalRISUlr?=
 =?utf-8?B?S1ZiT25rV2ZaYkhYRW5FZkl4MXFtMWozV2JJYm9sQ3RhdjhwZmpTN0NHZ3Jm?=
 =?utf-8?B?emo3UzZRb2ZsK0ExcW5ZZ2xMRGlNVGtpV3Y3MVBlQndPK2EvaG84MVAvWTFu?=
 =?utf-8?B?dktINHErU1o1cXpFc3RnWHBOeXhnSUREVzFyTU5VaHF5UU9hNElERU44a3lQ?=
 =?utf-8?B?bzU0Vm5jYlNHcjlOWlgwVjJGd0NyOWw2alViZHlMT0ovVDlkK202bmxuQ2Zn?=
 =?utf-8?B?ZkJlK25DR3p3NkdpUzQ0azBGT1cxSkM4bE9wV2Q1ZVpkNWxobUZnOFBadVQz?=
 =?utf-8?B?ZVNzWlN3ZFhGVUd3ZFlhQ1Q2Nmo5UUQyeDhHQnFESU0xREJvcTdsL2ZPUG9R?=
 =?utf-8?B?WUZlQ200Z1g5VnB3VFV0S2t0YkErV2Rad3hKNWQ1cmFodkFXNUh1Tkc5TzIr?=
 =?utf-8?B?LzcxUVRjTlN2OGNBMVRGV1B1Vnl3YldqcUY2cjBmWGtvWWk4bmZvSnFvbGVI?=
 =?utf-8?Q?WMFlZkKwi/ylzj1M=3D?=
X-Exchange-RoutingPolicyChecked: lREEvTBHaeJzSIrPNwpcTmedvlKHp3k72P89S26JI+gF3LUc7H4tmZc0uBZ8LDwyHEY7Dc05Ami953TqRIdQAUm8VTNAq2SK5/qgMTDtqXdydSRXPi2mR8JIP8aK3k/hXps+cAjHoN5k3xEbVG3beDNCfPLPmnYjsWtqBGuoZ79F2/HgrfOqmBhP7Kihs+Bw932KTXlsjEYAvuxuI7D3/fh0hIR6bwNfb8nk2/NQ4l5wjI7Qa+AdJYb6LIB+PK98A9kXzi+IKkHRUPRb43zVktqzpebhceCZBvZzzRmK4PBYtBy64nPCeKmuoPMOUxvw9NBT70SroRmX+7Y43ulJJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dffb6c5-fb90-447c-fb8c-08de9f107eda
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:10:33.1154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7xQO2gtWVz2jpZvOwY44wuY3GZdOdfZiK9gRgMdcw1D2l/6U07ESBqjyjJwMnz3oT/6Veo+pXlZIGG/BzYrg5ad3DU/sKGm8/S3p1rz8U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
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


On 16/04/2026 23:00, Jonathan Cavitt wrote:
> It is possible that both dev->master and file_priv->master are NULL when
> passed to drm_master_release, which would result in dev being passed to
> drm_drop_master (as NULL == NULL here).  This would result in a NULL
> pointer dereference when passing dev->master to drm_master_put in
> drm_drop_master.
>
> Only call drm_drop_master if dev->master exists.  Also, make sure the
> original calling requirement is maintained (dev->master ==
> file_priv->master).
>
> This fixes a static analysis issue.
>
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>   drivers/gpu/drm/drm_auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index e17bb0f1f9e0..e5013b870ba0 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -347,7 +347,7 @@ void drm_master_release(struct drm_file *file_priv)
>   	if (!drm_is_current_master_locked(file_priv))
>   		goto out;
>   
> -	if (dev->master == file_priv->master)
> +	if (dev->master && dev->master == file_priv->master)
>   		drm_drop_master(dev, file_priv);
>   out:
>   	if (drm_core_check_feature(dev, DRIVER_MODESET) && file_priv->is_master) {
Reviewed-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
