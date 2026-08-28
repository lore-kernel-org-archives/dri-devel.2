Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12CC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AD710E472;
	Fri, 28 Aug 2026 05:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BMXpEn8r";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BFD10F251;
 Fri, 28 Aug 2026 05:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2yzi7nPP9UDYCnqQegO3SRMGV+HsPHvD1iEq5hnYGibKLbp8lt4uiZC56tgNkMoV5OfWMl4rX3uy3pq3TI5WuqbFcrQMwzhyfEMTKeJZ3RO1fCXmDaar+7JhxHdH1yWR4D8Xyb1k2QlS1qhyTg/XboVd5vBf87cAIBIKy6CRa7pRj7ALowPYSSF4SfChphXAbVN/PIQJTJr+CqcPjsMd8mynJjcXKmnbN5K6MlawYriLn0GDPlp5sQvXB2AUcGUOrzIJ8/XaKvTUyhuCL6N9IPYricv54OAgsGmMNgnXsIn3YGAdcLOIoFY+IBxNvazeGJzUkyo0oQoOfZlCq8B9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs7w2aPXKkB/7X4/BinvA5TERQPjGxUixIKmGwO/Ygk=;
 b=iZuppoBi1KQ8zfJJUKwr/xKkRHNk+lBYSX3nOpSFtBcd32oCVlGAlaJ8LsemJthVmTv42RvxBbdAEmajTJ/WeIXm/LUjBeh4plUE+FCZq3NAxJqNu0fVM83PqzsJHfb0HgrgHlhVrlZmxaxRc5wiGSODH/m+DbSgxFKt0xKaHszYnTNgMLqV1Yw0uRS+2k5Z8jOrLBH7hqF878d24to0G6U/Ric9H6YW3DOqK7cPQ/vC70J1rvDqScYTCKi9lukOx9mcEGn9fSaHGgQfbBFOWa8iLrleAP/iJzWv+P4PegXL6zxF4YaFKvUONA/YQ5KS6M8XpOkO8gSM81K1V64tkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs7w2aPXKkB/7X4/BinvA5TERQPjGxUixIKmGwO/Ygk=;
 b=BMXpEn8rX6ILlFPFAszpUQe1Ek2a/oFG9KAr0LNOmf318q1LKtnNHlu6vHgTAju0iV++1o3C/+ljo/HyvCKG3YSm7+5MtBJnVPhUZ7DGf77vJ/t+wJx76YPpC5YSBB0zP08+l33PHuvjeizWO6ZIdtwcmzfnjnIiBG4k+VBkSfFOxT8ps1g+IkB/V03eamMlANwSyqjE9xM6ynHJx3TgRsEEkHYa0ygNrY69Z4Pu6zE1PzBg6OCxDpBqRFj80MBA2gtx99rNIkT51s4A07Da0/QBgjfVMa18VsxzgLV8xiTwECPPi6kAYkoHzrngkz+ywUv+5hZ+z1Qm+Ynv3HkAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 05:42:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 05:42:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:42:12 +0900
Message-Id: <DL0C54Q4WSWP.2ZAYB42N8VWGT@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: use FromSafeCast wherever possible
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-2-e21f17ba4127@nvidia.com>
In-Reply-To: <20260828-nova_num-v1-2-e21f17ba4127@nvidia.com>
X-ClientProxiedBy: DU2PR04CA0277.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: be4f3b53-155b-4715-9779-08df04c71f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ejR2f4LECbzd7LCfOuchraeKW2uMhPjoVzrZ1qgUTwXmwy/y+b/R3LkTTsyC706b/CSYGqKPntYIYnzYxgSKDkA1lQ/kMgf6Pcyysi94ABIKurrB1HKv3v0M1SLJ0yp49ZM7cfOugI41cJUWdu6hiExlj3G/eU/HX0uUX99dlegXxN3J6BApfNaJYsrvPr06PBbqvanSfefrxLxhZzTo4M3kAZu/O4LND1lRQN8kj5ki9IopGazvd2pZ+rHBO6FVGlDe6LDX6/hLqTWpz0/BAxAMJTxVUxQa71VSy9GhyWY67gYWQn5syqCdirpAR4Tlbss+5qm/0Q4nN77ggHOQnwfLqn9641dKkbMhnHg74o0uwp7qA/jlbUQjGmSCmB2opvWJ6s/bRjvnzAA6ytQSBVWOU0dhlz2KZ4xs3gjAGmnVuvH2xjgmG3b3u90q7jTclQo57xYVqZ3uIJ0fkal4O2Z3Rfo5wZmxOO+3tVCTvhRunMKt8kWgDWPzEfhAGctlB0hrAxOLJwt33umrHBheQjC+1b0ohIytcgXRhar9AEdTaLQZf7XgE9IwgA0bdOUmL7nOIbxqJ7AHSOn00BljFq655PC012RSSA0O/HirsfwPmmIp6dS/Vi67/MPAykYsuVhZZTQVytCdmHmBOCrSacARVOPzFI+HEw+9UZoSu8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBGMnlvcERETXhpOXRuMFMrTVRqbkNPaTR0ZGZCVVJTc1RKNnFXb0lpTHQ2?=
 =?utf-8?B?cHQwbDRMVzBjeXlGbWNndC9PUkVQbVNqVnJwOWZ6VkxMWis5NXpYakl2cWM3?=
 =?utf-8?B?TlN6YVc0elpKa1l1Vmx1TWJyM2luK0ZlbnF5VHFSL2tRV0NxN0RrS1NPcWlt?=
 =?utf-8?B?WmwzdGlYNVJJVlNvZVJZRjlQTm5TUzNsUm1PTVJtUTVtVE9rc2tQMjBWWkI4?=
 =?utf-8?B?MVBZKzdBdTBaRTVaRkdEcFpxOExCcUFkOFJGcHhqTERlRUNoZlA5UmlqQXdn?=
 =?utf-8?B?NVo3RFZsZHVzQXF4WTdJaFAzNjY3R0tTcGxqbXVwM2xzdWErV09PMUNPbGxD?=
 =?utf-8?B?Ky9nLzNKQ292d3NTVUxEK3AxSFZlZzRjcTlzNWpDKzNEODd5cWxhc05IbXJo?=
 =?utf-8?B?MmNtYkdrMGN5VldFZ0hyRnFoQmg2N1FwMnVCK2FyUDVOK0lnREhiMmFvbmtP?=
 =?utf-8?B?aFlWS0VXcUhCOWNMckhUOFNFWkVtaWt3WFdpQVdjditaRzRJeExnRnN4Rmpx?=
 =?utf-8?B?MDB4OUkybWNhTER2YnUvZGNrYUVyZkZpVEQ2ZGlObk5jenhWNjVPRlpVb2s1?=
 =?utf-8?B?aDRHQ0NtekZqK1NJLzJUbmZvOGEvRThuUXFtUDU0aXphc1g4c2hkb3V0Z2dv?=
 =?utf-8?B?K2c1cjFKRlQvUDFlNVQ1ZUFhQnZxeUpGZGZVbXcvOVM0NFRoYzIzMjcrbVI0?=
 =?utf-8?B?TE1NUDl4ZnlObzZZb25VY2RkSWpseVFPWjUzMXlCcC8vZ3BxTjBad0RTYUF5?=
 =?utf-8?B?Z1RwdUJUQ0ZZWm9zMENhQ1cwZUNDSGt4bVVzT2VmcmkvNDBMWWRQT2xGMlNj?=
 =?utf-8?B?QWUyanc5ODNoOEIrWnpOQy9JUnBBeHB3S0U1MGxvWndSazNyeWRyVkhxb3pZ?=
 =?utf-8?B?bHhPTm9VWnR5U3FlcnArdENSS0lmQ3F4N1dFZ1pYUnNTV2hod0gyajR1REJK?=
 =?utf-8?B?UUVBM1htMVZBM0dUajZwNW1RcWFlcVNpaFlieEVlWmR6enl3c3NzK0JoTTNM?=
 =?utf-8?B?WXh6ZGVDa3M1YTM1SG1XdXl1TWt1Qm1nN1dtRGI1eUV5UFZINXM0VkoxLzhD?=
 =?utf-8?B?MXliQ0RaajFSK1Z5Z2FNN0hoY0xWbENvOVVXYzJUUnFITGYyRnQvM1piYXdE?=
 =?utf-8?B?Y05odHVrbTFCK3Zwb0lVMGZVQnB6NFArbUhxYnNEMnltQnBmQW5kcUNTUzFE?=
 =?utf-8?B?QjYyRktCQ08zZlk3ck8wQ1B4WHU1VDM0YzRXaFRzbWpEMHZpTi9TVHFVYitR?=
 =?utf-8?B?R3pHWHNmd2dtaFZvMk1UeVpXT1RQeTl3WEpoaWtmaFE4alBab0JQOWFoOS95?=
 =?utf-8?B?eUREOGhaTzlodTMzNXh4bGJiSmhBekJSOHVIc3NEMTJNWS9FL1JHNmZ2Qy9v?=
 =?utf-8?B?WXljN1JycTA2RThKUERuZWMyWThzUm8vaU1pc0VnUTI4dEk3L2poeWp3bVFP?=
 =?utf-8?B?S0QxTVc3aGFldkV4MmZRV2tTOUhMZHN5eThmYXVTQyttSGpTM09WVlhMQWsr?=
 =?utf-8?B?TWRlNDkzNkpjU1VPZ3JzZGYyMWxrUkJBaEN4SkhHWU1saTVYRjcxY2FtKzdC?=
 =?utf-8?B?eTcxWDFTbzZ5akFDOVdFczhQaFIrTldMVUVRQlVjcmlUQzFFamNKVFNGZVNu?=
 =?utf-8?B?eHJvK1NrcVhnZ01pMzJlYk9lSEt0TW13REEzczB0N3VFU1BrRURrQTBSVWFy?=
 =?utf-8?B?N3Jha2RtenhXQnlWeXpyUXltL2p3QnZWc0tOYngxTW1XV0dMSzdDaEN6cnlV?=
 =?utf-8?B?VnFVQ05jUVVlY0dVYlZIZmJmL1JwZlVqZ3dIb1JkZjhsT1Q0amowNit3WmJi?=
 =?utf-8?B?QUxLc2NPUnBQWXdSak5XN3lhV2lPWnQ2cy9Rem1NeDl1dXJjMlVNRnZFMUc5?=
 =?utf-8?B?NXVBQzR5Yk1MdUw2eVhiOVZkTjVMeDc2cTNRdlJKUjBzTXhLalRVdUhiTGEv?=
 =?utf-8?B?bzFLTldkbStVY0tFRUFZSkR5dXRDOVR1QUZjVEMwTGVLSGtYcldQVHhxbEFR?=
 =?utf-8?B?SGpzYVd3QmJHTFo4OFl4RVB4aUc1YWxtTTI2SVlTQlY3VUdNMnBhVlZtMTht?=
 =?utf-8?B?c0MraDA3cjdMWkVyQzMzQTdLVi9rNzdkdFpSb2RncU1VdUN0eWxDWTA5RHZX?=
 =?utf-8?B?dlptN2phd0ZXc3pnSVZzTmZ3L2VBcE05Y1BaRDMweU9QWTBjV3dIenczRWtJ?=
 =?utf-8?B?elRLdDNENXpiYkZkNkRzUjRqdnRERmFrVElVdE9Oa2VKNXZINWJhSkJ1VVdY?=
 =?utf-8?B?VU05Zm40M1dxMXR3THhEY1RpNUVwOTMzR3U3N1dKUEtXQVliT2lrR1dDZkhH?=
 =?utf-8?B?cjJSU3k2Q1lVeGduOWRNZnJ4Y1VURVNCYlFHWlBwa0JCRit5M3cyd1NHRVNh?=
 =?utf-8?Q?1auoa3omNWgy6bJAiro6ri8NxemdCZI2ekQ6njBM1Hs7z?=
X-MS-Exchange-AntiSpam-MessageData-1: pV2TU9h6eAIM2A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4f3b53-155b-4715-9779-08df04c71f54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:42:18.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFpmu0xucYbotPeok0opDwp+W8QEVMimadQNvimxsduht7iJpxyAqVYByqxcT3arR6t/THUV8T955gxqNhmTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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

On Fri Aug 28, 2026 at 2:33 PM JST, Alexandre Courbot wrote:
> `FromSafeCast` should be preferred to the `*_as_*` family of functions
> when it can be used (i.e. in non-const contexts), as it requires a
> single import to perform all valid conversions.
>
> After this patch, the only remaining references to the `casts` module
> are those done in const context, which means the `casts` import can be
> removed once these are converted to use the `cv!` macro.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

