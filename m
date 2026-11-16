Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18D606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lNtFZTcQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E0110E102;
	Mon, 16 Nov 2026 10:07:50 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D16410E102;
 Mon, 16 Nov 2026 10:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCHDcqXn3b4oZxpIOGB/9xf6MilVtEbRYt6RMu0rIVjRWLGwfuCtb2nGp6AouSB408nQkl/z5Va1xmR2A8TMY/h7Hwct60KUN/ygCQOjq2uwqbQK1DXg6E9sT5KI8czKwgvfGCM/VxJnQqUgXGMNZ+MFik4vBipGtanlTfKSbeDiAxsgu3AY55Llu8bg5ZqDnipeuk2t0w4K0/MwEoE+gGxeJYCITDwS5SQki41R59Pt3qRTrsSRqkPk4MxmPo879lqipmUqAMktLDudiYA44kgxSloTadhkwj1gez2jVvZsxHBIkMh0KSTOa+RpFMtnFk8jYw9MiHaLnrc0Bb5/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1fonDRRlSZo+abA2u0Et4iHaP8Nnq/5EYtsqQJNKCk=;
 b=Mv9GhBk6+yieLUA5tzf6Sj0/Pf7ju/bxyqHPuPe8kLmlKkFeqT+oQUMp+D79ZdGYHsXiCKplqPRzr35s86B0xf3JcFgndMeo9imHbf+Qy8L7+wVHY7ENeOxOqX98tfHHQ/36xDc1XBB/kM4Uw3xoZXp76M/Vh+rrlTSeifJWEQMkBPKOEqvrz1vvr3XePbwJfO/natYOqiZ9jJb8CZa9tpNl0esLtK/TnTX8Q5hNzZogpeLP85qKoSh+pB0U9/iy7ads5ium4UDiWXvVLKTcMpIOW4m9sq8hZrlHXblQSYgA2q5xykGWviys2ljC371H6RHNO05gfbiMgnPu4S/A6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1fonDRRlSZo+abA2u0Et4iHaP8Nnq/5EYtsqQJNKCk=;
 b=lNtFZTcQJXMNYD3NJ5X9nslqf8UARJqCytelZYMsVHBzQ48hGZWWbWkM+MVMbKQ+5gmS/O2o6txxZqhfWBgZ3ldZkYY6wjlL7y8F1HjSABXGYiq2XN9Sp110NxrdrpGvt+6FZLzEhaClPotRupRgxM26QxWYtc5p5hOi+e2FFOY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:07:40 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 10:07:39 +0000
Message-ID: <481e5381-d9de-4bab-9995-a43637782b06@amd.com>
Date: Mon, 16 Nov 2026 18:07:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Avoid modeset for ABM changes
To: David Weber <weber.aulendorf@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Hugo Sales <hugo@hsal.es>,
 Alex Hung <alex.hung@amd.com>
References: <20260813112634.11455-1-weber.aulendorf@gmail.com>
 <20260813112634.11455-3-weber.aulendorf@gmail.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20260813112634.11455-3-weber.aulendorf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: d8431d83-e560-4862-7066-08df43c97262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QklA9SZrovaTFgJxsJsaKNDMLEsnc0dlGNhfCOMxaC8q+8QiNBiuNXlCUyY+QV//8rviCsr2bgkUhzO7cft6/2xJ6rKdsO5j8YK72qFhe9H7hziZWf72N3eAUw2fejuQuCHbdD3bfG2rljVlm+n6qK69UC1F8iGTwS9WaUrOUnuzrhh0UdgJMiCUwnTddzrT09iRH1Iah9Ij633E+uIyigHpM0wxZsMjylrEmLNUzgBx11gOsSHMy/TJwB6lula0Glq0gG1m4l/yZj5ftlAiKr0T8ZevGQCJP+cO21tDfgOr46c8d5HxPz0pUR79bNx7fSuSjEBsvYlJuwmE1bj2N2gPN/4+y36/c4SVtxREWlRo+wDgQH4dVxNfiJvF/r7hYvp08HddtQAbzFkzN0IRNsWpzaKFS956HGGXJCicgoqW61ehn+BrUG2tectDDZwroQAJDqFJhhKcFLkiceharJcdHL+25k6VLYmVy98jC2LjwjOW8JF+X0hBfTFL4UjQdsJxKB0xWIPL24/Kkf5eMEeibBBAfgqRIULGAG3Yqpt4TM4H+/x3CuyXSF87WePx1bfN+OYToi/nPym/Dm2i2qITlXLwDpiqdwIXzxoX2Eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm1McHZYaFNDczJ5U0xIS3Q4NHd4cEVyOXVOVEZ1NTNwUjM4Zjl0ZTFmYkxR?=
 =?utf-8?B?d0R1YVRJS1VZM1FORmdJdGxOdUxGcmE1OHgveDZRWGhSaTFxc2pYdXdHUzJv?=
 =?utf-8?B?SUY5RTlqai9GWWdYV3VGK3lkNXpDZzBWeWptNXQ3MVNxZEdZR0x1TE1oYUJq?=
 =?utf-8?B?eHhWckorVFR1M0Z2ZEhSUzFzZUk1QWsyNHFiWDMvbkh1QUZlNzViUEh5Z2Fs?=
 =?utf-8?B?S0R2WTRweUZhWHNxb1FPeHhLN1VIczhVS2MyUWwyR0J0SVQvMk1TWVhNcktv?=
 =?utf-8?B?TjIySFVVNURXVVFSNTVFUTlOWDRzSFhDTlJDMExsUk1pcDdNbHVlb3dHNDdz?=
 =?utf-8?B?WU1XN3VZSkIrV2xsYzE1RVNRYjJjODQ3dHloeXlnNXMreUhJbkQ0QVY4dFFX?=
 =?utf-8?B?QXZXVExJMHA5UHRDUUJjN2RoaFBuZzkvYyt0KzFsZlRNYXU4VG9YL0NCWTVx?=
 =?utf-8?B?ZGFza0tiV3RUbWtOd3YxbnhSQ3hkazZaQ3N0cExFak44Wkd3SzBaSUQ5bXJY?=
 =?utf-8?B?eVpTUklKS1Vadld5d2hweTc2VG15cURPSm1hKzlJeGltVVpRL3lVSzByYmJH?=
 =?utf-8?B?bnFEVWZJVXBiQ0FrNzl6Q3JhWXBZbks2UnJmcmZTZDhsaVhFQWRPcEJzN0J3?=
 =?utf-8?B?OWh2K2RSRTRUOUN4TE5iNndDVlFlem1qOFBXaHNWRXFLU2s2elpNMzlubTlE?=
 =?utf-8?B?REJHdnR1NjAwQmR5N0c5ZXVkS0NyMmhyb2JhNmphWUlqTDVvS1pDcE04VGFk?=
 =?utf-8?B?VTN0TUdhOEdXMFE4TFdoZitIYTFQT1N0UGNJcytEL3dCMksyWUJqODFSRUg4?=
 =?utf-8?B?RjlUNlFGNDFZaGo5T3NGVkhBR0FYMXhOL0Jkd0tGblNoOVRHZCs5dXFZUVp6?=
 =?utf-8?B?clV6dnc1V1AzQ2xtVW9jajR1Sjg2Um5pVENndWR4RFhNTnJRS1NuYWE5Smxv?=
 =?utf-8?B?dG9FVEFhNVhtY28zNmZtYjVCVEszRkVMcCtNTUl4QXFvbFRmaWthcFZxbDcy?=
 =?utf-8?B?UkVaM0MzSXN6NU45NFcwalljV2pBMktUbFdBUWxXd2hyZy80QzZaRTh4ZWFC?=
 =?utf-8?B?T2xjOEVMTDdrTzJ2dmQyaU0yL2U2QkJONEhsVk4rTG1LRlpTZlIzeUdyaDkv?=
 =?utf-8?B?SXV6amlJWFBYUXZDWXhtTEljelVQd0tUQXd3WlBOWUZZblFOR3AvQlhDaTQx?=
 =?utf-8?B?R2Y4N3JBQW5XS3VBMHR0c1BLcGxLZkZRNGlUZjg2WlNTRXJPMktlYzUyYVQ3?=
 =?utf-8?B?Vng5RWNpczhORVhjaHhkREkxby9lS3R2MUo4a0tmRFN2VFo5TkVJdDFreDl4?=
 =?utf-8?B?SHNGTVh3QUdNc1djdlBKbVY1UFRCZDlzT1d4amtFZXVhd1l6d1B5blJleEZw?=
 =?utf-8?B?QlhzWkV5czJPZW5yZitxblk4Ymg2cVJmbzJON2hGdm01QW5hMFZnYXY5RVYz?=
 =?utf-8?B?U3BJMGF0WWl1RGpBRFBCcnNqcmZmaFZZdmhNREJDeC95QkdmV2RodXpmNnNm?=
 =?utf-8?B?OElZKzZxMjVnZHRka3JENWUzYm1EU0FuOE5lM25zd21RMCswMUhNMThESFhT?=
 =?utf-8?B?OGhVUEw5ak5iRlRJZE5sUURHUTRlTnJRVitaWE5KckNiR0FLTjM5a1A5TCs0?=
 =?utf-8?B?aWRPeEFHaUJveXFzM1h0azltaXorMzAwWVZrR0IwOVB0OS9RY2JLdTFGeSth?=
 =?utf-8?B?WW1VVnM3NWllTXhiRjVhSWJ4L1Z0anpKL2NPT2ZpbE90ZnJ2NXN3bVpiWFJD?=
 =?utf-8?B?SmgrMjNsU29oQThNclBpUVMvdUhLVU9vcisvcXArRzF0NHRTZHArbWNjYk4r?=
 =?utf-8?B?UFhqVmRDcXAxcUxGUHVjbnJkUWhBakEzc05CV0F4RWpJNVhxODZLVlFQaG5m?=
 =?utf-8?B?U3FJWTc5ZG9OR1BzU09wajlSMTZKRlVYTTM5cmp6UUFYbVRlWjFUUEQvRm9K?=
 =?utf-8?B?OXFxOXpuY2sxR2RpOFc1V21qMzZBd0dUWjI2OGRVV2RnU0Qza0dtMWQ5Rmpn?=
 =?utf-8?B?OEdqL1g3Tm9yTXBzQ1RrK1lrd3N4U0hiL2ljVE9XYWNacTJZNFVKcFZJY3hi?=
 =?utf-8?B?TE9xdFFlTGxoWlluMzNocWs0MHVmOGlWYktGQTU5dWZQV2cwTkVmT2x3Tytq?=
 =?utf-8?B?NndzNUg0L2JHSDZ5NEdEb29kV2Z3c2FNYWNuckVPTVlJSGJFUjNQdlJnSkdm?=
 =?utf-8?B?R2EwYXFsM0l0NlNlM2tNSlJEa1kvaWJEWXRTZkd3V1RLVS9YVVpOV2MwbEsr?=
 =?utf-8?B?Ym5QL0haRURnRVAxdytrRjAyVmpXVmRwOFpFbUh4TmtodnMxNFE4SmRoL3lZ?=
 =?utf-8?B?U3VrV3Z2ODdlTDVyYzY2R0RhbXNnMUkveUc1d3lubEVJK3ZGbWF6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8431d83-e560-4862-7066-08df43c97262
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:07:39.8941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf8mIs8narKTuAWxIs14Ke4quhZ8r19T++LG2LBATFPF+hxkNGJ475vRH2HeRDAqUX5IU6YrCoa6jDznyl05fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

Sorry this sat for so long. Hugo's series [1] carries the same change
as its 2/5, together with a patch that commits panel_power_savings
writes from the kernel, and it's going through our promotion testing
this week, so it might be easiest to land it there. I've asked Hugo to
credit you.

Without the forced modeset, an ABM change goes through the fast update
while the panel may still be in PSR, and on DCN 2.1 that hangs DMUB.
Hugo's other series [2] takes the panel out of self-refresh first, so
this change has to land after it. For the same reason I'd keep it out
of stable: the PSR events that series uses only exist since
3c108046e1d6.

[1] https://lore.kernel.org/r/20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es
[2] https://lore.kernel.org/r/20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es

Regards,
Chenyu
