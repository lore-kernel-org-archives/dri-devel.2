Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA88EC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E31E10E05B;
	Tue,  4 Aug 2026 04:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vw+YXfI/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3799910E0E9
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbuJCP64Tiz2poT2XTNldZRNkVZgYN4yBpkLhiLhQNu2/xP+dTGDsa3x5b35ICHpjvsAVEDMcx8RXE0ngSzJ7pFdw3h1rtDPOd8bjKl45xU0f7CGVafjGD9qXPNSLAglms67SI4u2Sf5tVMLUfkkEU/TBOXsL/ixfMJc9V5bYVvwBUeH9Rk5RhmHdN2lUXCQqRr8nYyxPAkQQF9QI0kHxbIqPyIK6IfVbHpGQi8kUxTtU0OLqQYcLqOrT02fCVOaT2P8hWYZ4dUIr3sFrZhk7+JBFLnvaCuxzi8UzBAw3OFksc22eFeasIpITd0KG3v6hv/InETIgaw0tWoPFFH6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bma62/wUyB9rEyVGTLQAwnEhUM1zrffmLdwMyG1F/So=;
 b=selQOiLrqfmzCCJHrgO7UnQei4VWf7iWuY+jVRdmKQGy/5DmWyGUroAFzuGN4OSjOm94Xl+a2lxo3/krRDn0snScKLtEg3d71+3qr/H0Of0wuCQySKDcQp2LJ1JqR7Mi6v5gdVLelHiBOpbi5AzsY0Wa/kNmCS+I3y3sj5OzctJPRcjw/v/ynqtZjiWAfe0GSKQ2mJed2uapQ+iJ6E9M75WR9hOfzqNEmmKDW9ZlvWt8nRImNGAC9ybg+fff8iaXCWl4DZfSwZjufAB+QcdvVlbyQ3AF7uKuzFnuKrbriuA2Pwq0/1Ed9fgC3mMoff67FMKMMAJdmbMOHSravwmZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bma62/wUyB9rEyVGTLQAwnEhUM1zrffmLdwMyG1F/So=;
 b=Vw+YXfI/MRTUVYdnDRyTVkUWnUX2vJeKhnNzyUNLxjyr74jovfPdYHbJQj+Q/P7YpB11LumdHxy9y5I1DMbuARvW/bMOX8kX+WrGVeb5/1K9heohytolRLAZwpKCw17iaLn3mMigHANba+/u/E2x3aJ5IUsohF+0WyvLJBFPTXE4R0Y1jaQXJtAn8TuNnipztMmMrlGWPgjYkbNnJDH1qzab+ggQaJAdkkfUHlkMTqV3WvfyTrPlqOxqSpk5TD+WXS3UB0W4f/I8OWXs1ZL1fkPFOSSNd2OcbOWZSX6lNtZiiLpbl5W76eO/6VXZn6VQT9n49h/Cs1T6wAeLDTadFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 04:03:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 04:03:53 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 13:03:49 +0900
Message-Id: <DKFV0QE0ITFR.32W3KLYUQ897T@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-4-01aa6a54e3fd@nvidia.com>
In-Reply-To: <20260724-blackwell-fixes-v3-4-01aa6a54e3fd@nvidia.com>
X-ClientProxiedBy: TY6P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: ed51c01d-9141-42b8-7e1e-08def1dd65aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RNEXOOeCDth9DupSDXp2BMKja3Isovb4Zf2Cr1AWBIT7/JOBc364hDO/EaqRH11KVOcgxtJ6MWF2INShVu3qlg/eFgQ1S2jTg/Ep+9Df1Nvu/id2ceb7t+DR2PMoalFDu9609tA2alM9Lcods1sqcNjATmPDSedG1OI4oyA4tu7oC6IzF7QZz2p8Ktowv7xgxTLYn8xLrzwbVMXJhagoNjddnqfZP/AQlJ4xZxEmpwZir+27ipjNrJBWgmQch4gJiaLskvihBEQEmOAgget5get/2Q68t2BdXidQRxNshhCq2QzcBhYOf4UPF+IF1WPqQAxtNYKhTBR29MRVRD0tNAsgJ21GiTo04jg//p196SFAnmJdJhhuqMV11Wa2TGLkqCBP6QGBL5vD/EDJB4rikC2LmTWcZxHMvYriKdWsIxw95ICBtvEpZIAxqAlVA6+xkTHbIu5xbpK8an/yGSBMOcyiYircQN++FpLH0c1HidOYBUl6yZXqy8KCrPoFIK84aX7WpeKgz83ghDM/wdUrN099X7sBaaZW+maLfkI54uz4YJGtUzE96pjm2GcCTCn16AoxYPujE5QZuVBXfHa6XgTqtgKcJ0zMvFPiUOZQm6eeypAX56L7rf4xTdIE1Nqm++q4T4s0lMmRBqZL3k1VQVdObJeOSZr7nRO4RGwM/CA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXM4QXp5OW9XSXpSSE5OUUt5ZGd0SWxXSXJuSFNKVVNMVmh0SVYwNU1OUXB6?=
 =?utf-8?B?U1h4Y1ZwUU1JR1E2VVR0WXJTRTA0czc0MEdlZ0p6WHJRTTFJRGJYaWJqREEw?=
 =?utf-8?B?Sm5xL3VkMVh4SGlUMUxiUXdSV2RwaHRlalJidHpNSWZWcEFVR1FOSnBKalhw?=
 =?utf-8?B?SWt2Rm9yOHoyNjYrSU5ZRnZSRjdYdk5mV3lkMzJRWHgrTEExY0RBL2xxcElP?=
 =?utf-8?B?QU9pR2JBaXdGSUE2SmlZZ2ZFanJBTm0xVkhIL2N2OWZ0MXhab1UrTzV6U1pK?=
 =?utf-8?B?U1VFc013Y1haSEVFNE1OSUtSTTVoTTRoeWlCamZkaWU4c0RKNjZUc0JlL1h3?=
 =?utf-8?B?MStPdlM2MFpsSGNmM243N3FwS25yRzM3Ris5TVJCUjl3MGxVMW15SU9DbU1w?=
 =?utf-8?B?NHd6QWVrazU5T0lsMXdRQ1owRGlteGhSMkt6b3loMzdJZnl6alhXV0N6Qkdl?=
 =?utf-8?B?dGVFRXVLVUhIam5iYVRidFpsTGJiVnk2TkU4amU3dXRuVU4vdkMwZ24ycTMz?=
 =?utf-8?B?dml4bkVHNmJuRHlLY1ZuQjJoS1JoaFk2dmtuT3J5eEhOV2Ivem5hNWdXMVBy?=
 =?utf-8?B?eEEvUnZOcjNrREJySEtvbEFmdVpRQTdOMkxaa3FMVUsvYmkreDY0ckN4SnRQ?=
 =?utf-8?B?NCtqRTUwRGRrTEUxSitUN0c3ZGxYNUJkMmJiME56aUxQZGRuQ0FxZkcwNUVE?=
 =?utf-8?B?V0pCUy9aYk05WW52NFl4b2o3T0JJcThwbW5kaWltR1R6WjlkR1h3VmsrU3cw?=
 =?utf-8?B?WXQyNURCTllKZlRGSE4vV0srY1JCNHE2VFBpamxFZlN2SjJPcW5ITGlyTHJW?=
 =?utf-8?B?d2R0WkhRdjVNekZXUG5sbUNuQStzMlVTbm1qUWs5TWFyU1owQ3lTL1pocy9C?=
 =?utf-8?B?NXFCU0ZBRjVUdHhvVktrS0pYQVp4Wk1qZXBnRktOamovR1RHZkJxYzR5WWty?=
 =?utf-8?B?VEtTOW5BTWFJdm45bU5Dand4Um1RRkZ2Q0JvQysrQjMvUHM1eFRlVktOSlJ5?=
 =?utf-8?B?Mk1GTnp2UFVacjZ4V2NvTnlPTndVRlU3TU0rN1VjTks4cklCWWQrZkxqOXJn?=
 =?utf-8?B?WmNCR3VKOXdNSUtvdi8yTFVqMllseWI5b0g1Z2pJWk5KdEhVM0E4MHFnOUda?=
 =?utf-8?B?d2NCNXBKN0ZnY1lYNGZmeWJtMWxkbkZENzVHbXRaaU14Qjd5SFVkRStlV3Ar?=
 =?utf-8?B?MlVPaExJdkx1cnF0dGdkaDU1aU1TMGxkZzd6b1J5US9rV1ROUEFOWkY0Z1Yz?=
 =?utf-8?B?aU5OTnlSOUhlWVFzWEZNSWJLUDhsN0xjRytaNFY3T2d5ckF2S3J4TnBYYndQ?=
 =?utf-8?B?MGgyQkNqcXBhdXRKbSsrU2FNeGluNVN0MXh5YlRzZWkweGEzQ01UOW1PdVND?=
 =?utf-8?B?RGxscTBZWUx5enF4YmNybDgrZEt6WVYwZDJObTZkV3cvRFdwZkpJRGJ3bmZ3?=
 =?utf-8?B?LzRjbDlBNkFpVTZobG10WWZwWk84Y0FrTXM1Ukd2b29sTHkrVVV5L3JZb1Vw?=
 =?utf-8?B?NEpYanN4Ny9JbCtLMzhNaEpSbCttS0F0N3BvdEovYm9ZRnVzV3lqUzdsdTZw?=
 =?utf-8?B?SDdWbkltV3crS0VnUGxrdVZzbnVaSTNmZVhhaWZpVWFxRTY3UXVjS0c3emtq?=
 =?utf-8?B?TDhjVUpYUTJBRFpVVHh3M011WjVyL2tqRVc4RUpBd2I3bHNReFdKV2RhaDZn?=
 =?utf-8?B?bGpMZlFVVEVVU3hVWEZjSHlncXQ4d2s2MVU2S2xuOHk3dzJvNVZ6aS8vemlm?=
 =?utf-8?B?SElhRHJuTThISWxvd3VHOE9XTDR1RlJlMjNZd1FoMG1xd3RXTFI0Z2Q4VkhQ?=
 =?utf-8?B?eXRVY0hVODBOMnorOGtySitBU2tacnJub01lTnBwVUFhUFZsa25JeXMvOWF0?=
 =?utf-8?B?OHdneHNlOWVnNk9zaEVHOGlwakhzVUVRY1N6OC9HNFNONUtMNGFiYi96MmpN?=
 =?utf-8?B?Z01oK0p2R0lZT0lzS2h0YkdCcFN0RmNLL2xRV05hZlB6YktYdi9TVUZpT3JN?=
 =?utf-8?B?b001a0R2U3dsZnVYWFg2TmMrcWRCVGlvbFhma3FhZzdadUl6NGs4NzJhNlZs?=
 =?utf-8?B?YTZIdldwSVV4NlMwRWdoR0RJekJabXVRUWFla2ZQNnJ5ZEF6bjN6Q0xmaWkx?=
 =?utf-8?B?NldPSGlxdExKOWJQY1JtMFhyUjdWdlFvTjBIRnRwK1Rvc2JJM0VqTHVtdDkx?=
 =?utf-8?B?V0NOUUhnTk5CNURUUUJ2RHUxcFM2RFZkVkxBUXkrOGVoRGFNWk1FQ3UyYXE5?=
 =?utf-8?B?MXJzWlhMNXdDVHZKdGlxdm56MnFSeXVDbGREZTlXSUE5LzFuN1JRbFpsQlVr?=
 =?utf-8?B?Z21kOFNZY2duQzFsYnZjUmZpZXk5UU1QSVg5YzBULytxcW9FSnExcVpiWmF2?=
 =?utf-8?Q?M0mnSf+MTAoPf3qwH9IrT6VXsmH6Cg/KAQecChipE+ui1?=
X-MS-Exchange-AntiSpam-MessageData-1: 3D1qo82RQxA8aQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed51c01d-9141-42b8-7e1e-08def1dd65aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 04:03:53.3661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njX4tKmlwFfFAervE3HGfOGWyCrgw1fn7TkVmhk4oGAsZSSSedw5N/GSvSWGX7dmqdo8KAZL/tukpJj3TYtYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

On Fri Jul 24, 2026 at 3:56 PM JST, Eliot Courtney wrote:
> `FbLayout` is currently used for both pre and post FSP architectures. It
> contains ranges for each region of framebuffer, but on post FSP
> architectures, only the size is actually used by GSP. The offsets are
> not decided by the driver. So, for post FSP architectures `FbLayout`
> contains essentially guesses for the offsets. Instead, make separate
> types so that we only store the information that's actually needed,
> rather than keeping around offsets that may not be correct.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

This one doesn't apply anymore after the vGPU series; rebasing is not
too difficult, but I prefer to let you decide how to do it. I guess we
will need a new function to compute `(vf_partition_count,
wpr2_heap_size)` that is shared between `FbRanges` and `FbSizes`.

With this and Danilo's comments addressed this looks clean and ready to
merge. Thanks for reordering the patches!
