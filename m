Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FDCC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677C010E380;
	Wed, 14 Oct 2026 03:04:46 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0011210E380;
 Wed, 14 Oct 2026 03:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEoy11phK4tzjcPs7mrwjr1Oe0bbQaoFs63m3cGAWL2CBwIu+MrKNvZdEbxkP5Nw4u+9C6ODD3DlBz/0w5PL+XHMBMhqL8gRblF2HHSjWdEDT9CIOFdb/td8rhf8CcAThf6ldywi7W5p26YUmqsl9FijmYBuiU5qMIbfAgXEWoixbM5MprCuzhiQLHWYFaWNaYf6CLZGgZYG/xmvielyKiYwtQMlppYN4hLzKt3nH2iMpPq0rfl6rrjWy0ch5/ishtojNrVyQHF0fwJv0XrNXShT8B1EtH37i98NaXD/+9XbVtvTRy8rGlzIKresAuwy8rR460b/+HtFfecXm6jXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvTAL6FuTv3suZflKKTjx67qfWh5DxeNY1ndT86NFPs=;
 b=JS45of7K8YIPjLgP7OitSi2VvT9Y4C2N1fkW4MCfTqD6k5DuleNS61WLrmYV66gxnNeozoI8SuVvLlytSUlGHRz+7secoaS/R+ZEwjAE7llN+E/frxZuiX+LJY5G+q3ZRIe18p0K9U120e6SzbpGGmeLiNU9qd04XZK7+BZLua2U81+F+MCHf/KsGZAUwnMbRDdFNqrzVwNBiLPjTndM7IpgYr3YywPYrYZhiNqE8u2wELB4Nc6vIbQULN+WaGYRU6bskQmTkHWP0tsQXtm0UsYrGKuGy+/vP4iwtV6VtXzXjcuw2ND/Ehn9qCXb70XlGwZnFYUAo8nbZti8JeYshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvTAL6FuTv3suZflKKTjx67qfWh5DxeNY1ndT86NFPs=;
 b=s0lH6/9apYdgr5RfUaqsegEN0PkxPi3il/ErVk3aqbMlGEtsnopj+eO2I8sw45U5CNMq9MoALmYRAjglkiX1lbRTgzLKBEoHR6hIZMD7lwR7QZp4hyfDXTv/5cwsZpcg9Skcr+qp99Ti0k0L/2FgAxNIhHWDIAJEB1sYMnTscu8UBjTE7T9+1MV6TtlW7D5lJLI3VSv+18Eakc9C/AXnoq6P/YPaQjl5dvgchGQmby04BkU44LZ70yAMfR2RuTXxMltTfFNuPlDeJEGxzPvBqnE7gBBt4e7l/QmMPd/0DxM/ryj7XkVACtqf5CIK9VwzRg12hwr/xgBjWehg540WfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH4PR12MB026689.namprd12.prod.outlook.com (2603:10b6:610:506::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 03:04:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 03:04:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 12:04:33 +0900
Message-Id: <DM4880YV8LEF.3PF4IXDIEUPLF@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 05/10] gpu: nova-core: gsp: cmdq: split RPC parsing
 part of the receive path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-5-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-5-c9ab8de1d3f2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH4PR12MB026689:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c49d772-f6fc-47e3-83f1-08df299fe13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TqBdH229GwGKC5IOyeoOuKLnEDzOh6R0MsMtTNXcDpVmI2sP3vz38ECzArVJICf9PGFtez+mBnhLosFt8BSubjpoZWH3++UjhJU7fNSTS9C7tbFr49vuyFA480PaMUqjtulJCpObkEs+3D8kXI8LfqmfOLL+W7aOb2+4ti7UTFgb5ZEMXENkSMhSmqKPDsoX4aKSyOZDxg+rinOvVwIfblbDjVs16i0o+drTzJbeMCk+LE2SoRrSDpH5BtBGz7Awft9yIGmiTVcEC7bbQXN1zyuX7IVHysCbi9P4cXPPP+lhPNuzEMMz9sJbcPKBQHZVNy53xxHpkBaUaBkAKaevZaasWBoyfRZh8XWWSLzCMb75aPVm8RaoVJ9CkKJUCVGQORWDwzgqnjifadsuPs4mC3GioA397L3Yl31Biym0E9oilUVXLe84p6yXGGuCT4hN48Oa2JP1gZO+A8dH47DyY/uaR6ygfuMLRZhhJSbm/iZiUsge+G7XaCwhUg11FJqZZpcbeYwfGAkoS2d2KrO50/dOP0ygWYBsnBd6BTtMA/9mF+pMKD6bNX2TTsHEQfGeD0juH0nr8jMuIbvFxvgHu1bbx2UiApEQSEk01opU8QqIAdZJ6xBZp0yccePNPPe5Ukh/zL4EwxLVsSdJ/Dp10ClaIMv2JSOKkXDUMTCffLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVzZ0ppL1BBLzlrM1ZwWU5MZW1NSGt4dWxqSHQrQXVZK0hkQlc2c0lRZCtZ?=
 =?utf-8?B?YXF1YWlFR0xRcllNcXhaVUZCaUhwZzEzUVVOT0RvMVJpSGZJMTJxUWEzbnZr?=
 =?utf-8?B?UVl1Rm1rSFhKNlVNVnFrYnMrMU95ZTIvOTRKdG5QdTVPd042dTNUMTJpSVlN?=
 =?utf-8?B?QmVLK0tRUUE2RGx5bU16NDI1L0NPRTBOZUFpM3lGM2thUnd6NGdhMlpWQzNi?=
 =?utf-8?B?Rm5mcU10ZnRZNmpQcUtsWFVmc25kNUhjdGpLWWFUam5FRlFMNHlXazk1MDAx?=
 =?utf-8?B?L2E1K2MwT28vc0tseStYRVpnMElvS25WNWNYWUkrT3RhSFZxUTRhalpvZWJQ?=
 =?utf-8?B?TjUvU1NpUk9XSWdrMGwvdGdXeEZUUHV0eEgyVTdzam9HTGxlTitXY3kvYS8z?=
 =?utf-8?B?U1lKQWJUZUpDYzlxb2R5UVdJaU56NXRHcWFLL2xPRGQvRTQzZ2lGLzhNVHBm?=
 =?utf-8?B?OGoybU03OHdObEJPb0tZallWNG9tVEpScEx5TjdGVENpSVVUd012azZDNC9p?=
 =?utf-8?B?NWsxNjFiUU5KMnUvaC8xNzNOVVhEdkphZ3M1eGY1RjBvL1pEY3ZKcnRMb0JW?=
 =?utf-8?B?UUVMMElMTnROMCt6Y1lhMWZDTWNQSkdrN04xWW1LSXFLS1lkMmVPY1owSGQw?=
 =?utf-8?B?T2JWMVZDbVh6UUZMZm9neGhKdkhaS3N3cmNNby9CZ2pkU25tMDkxWGtJbUNY?=
 =?utf-8?B?VktGUm9PcW9IdmRKdTRkQ1ZVMW1uR2pIMWV1WTh3RUNSVDY2MnA2MXAwSFB0?=
 =?utf-8?B?elJsM2RHcEpSMVFSemJwUG9XbG9EOVRWdmtWdXJ2K001dy8zWGlFUDdabTV5?=
 =?utf-8?B?RElGMEZIVFoyOTBMaVNHQUJXZUxQNUxScEUzMy9MZUt5ZUhIb0VHaCtmRTRE?=
 =?utf-8?B?V3JXT1VIUWRISlJSZERlcVNSZnUxK09NMjU4cG0xd08vUkNaa0JVMEJjeGtP?=
 =?utf-8?B?aDZJNWM2bVozZE10Y0F4YURpQk8rMEhXYjRYdHM2M0FDVnhDNzZTb3RYOTlh?=
 =?utf-8?B?VSs3Z1NlejRORGtOcXI0SUp3WjJDd3dPN0ducHA5a1MrT2s4WlM5bjU0SGN0?=
 =?utf-8?B?MDJUVzFOcHAyUC9aSlZ2UFRaOUt4TTU5b3ZyTXRiV3ovMjdGRDJvVGpTVVRV?=
 =?utf-8?B?cUZ5VmpQUFphN2llcWR0clJadDZWMzRXeTluK2JWS3Y2TDVxUlRBMXZCNjFq?=
 =?utf-8?B?c2JUK1JtRzQxS0NCTG1yOFlvMHp6SXlsRU1KT3cwem5TZXRvWEwzOG85Rkgr?=
 =?utf-8?B?Nkc2bVlxeFM2YTZvaDg4NDllb2QyczBtK3VCRFpwUmlpR3M1ZTEzaUJXenQw?=
 =?utf-8?B?MDBMNGJ4akpVdmlXMWR3NWJSVG5lVkpqdkVnQ3hsN0hQTWh3M3FZQlI3NnV6?=
 =?utf-8?B?bXVJVTdtdmxNQkxqTlZLbld2TW1CUUxXdzVhNjg5Qm04UVBzZE5SMklVRVU1?=
 =?utf-8?B?THRKS0o0MndTSjV6T25oTDVuVVNLMjAxdHhqNFp4MTg3VU5UQjN3dlF1QnlM?=
 =?utf-8?B?aTRUb2FYVCtkR0lWWUw4QSs4RmNLNkJBYmRJdFVRcDJZK1N6djhrb2dXTTcw?=
 =?utf-8?B?MVBDQTlyRlVtNXh0SEl5T0ZMdVBFWkwvcitJVjMxQ2JtanpubVNIU0c4aUI4?=
 =?utf-8?B?QzFDN21iOUZWS2J0bzBlYk1uejN6ekxXN2FCTnBZeXJZTTFRL0FGOTBqZUgx?=
 =?utf-8?B?RGZ2K25WSldrT3MxR3Z0SkQwbktuSFgxTmpDUHB5MHJTaE0zTFBOVFErK0U2?=
 =?utf-8?B?TnVNNGpRRmJWL29rUmNrekdWVGwwbm9nMUx2NjlXTFFLOHJ0R2pCN00xWlgw?=
 =?utf-8?B?UUgvY0FGMFRZZGZFbWU4TzdtVS8vY0dEaFBmUDY4ZllPbWwrOHAzaUlzK0dh?=
 =?utf-8?B?NFUyM1hPSm02SzIyd3czajl1WWFFWmFsU3hveXNPRWhBUXBMWjNPbHVkR0ky?=
 =?utf-8?B?aUFXZmk2c2lydzYyUXFHUWVCWm5qZTBqaFAvL0R5NHowb09veVlBRldKTkJi?=
 =?utf-8?B?MmczQnRNeVRPaG5FQjlFZytGWXdWeVlCcjU0T3IySUJTcW9kZWlGM3E1L0lF?=
 =?utf-8?B?T1I3dUd2ckFFRXcyRzNSTEtqTEs4OWV2NHFhdUJncDE2azhoTG9vZDVYMEtK?=
 =?utf-8?B?dmNGRFBkSHlBUjZydjhBc2tzOGhQN0pBNCttR1VtUy9Pd1U4V3h2MW44R1lO?=
 =?utf-8?B?dkxvMFFpdWU1cmlqYVQvdnYyNmoxb1N0MHVTZVFPVmZKV3AyR0IvNmhla3Zj?=
 =?utf-8?B?UENjdW91T3ZKdTZOZnpXU2lmTytZMUJrS1hjdHozMllWZHRybEtIR0IxWlh3?=
 =?utf-8?B?Zk5KUnpzUUQ0Q09xMUd1Z1hScG4yZHdCdGpTS3FJV3puYm1hUkJkYUVGQnlG?=
 =?utf-8?Q?lzMjOOI4TMVW6PjBO51/K2RB85S46W5lTcr9l5IMEubO8?=
X-MS-Exchange-AntiSpam-MessageData-1: 8h80zSZX6MPdRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c49d772-f6fc-47e3-83f1-08df299fe13b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 03:04:36.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfH7iK29VjBybeS53+NC+OZq3LtePQzGIFFrldzKx9/q8ewHED5x4dskyhljR/tgCsyNcTdPliaJtkdSkfZIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB026689
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

On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
> The RPC parsing should not be done in the same method as the transport
> header parsing. Split it out and introduce a `RpcMessage` type to
> indicate messages that have been successfully parsed as RPC. This makes
> the code easier to move around into its new destination.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

