Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B74FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CA810E53F;
	Fri,  3 Jul 2026 02:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGcbSTcl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BAB10E53F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 02:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsDSk6jAPzz5S0EEndLk0PL9ChTVtUNm9nAfiKs8whH/BzpEsaj9uLvv+x3D/OwcnXKWXEGv8qi4dARwn+Ea1UMoaagZ4xURkIeFn0POv65QLXzQKnGjEaLmidhmbPih5IIIZVbPesw9MKtdE6lAxWzjEWH9LFZCdPKtLXjWMcAsuP6mi3d7UcnTjwDrbPO+aIJ7xogbyEMucHWLFToJj+XwndNsPqVIzPMIl4ZRGc0D1Kl9FUmTBZFDcC9d8j7D/RPkygKCOjfXFgvQcS9pvg9a9SMv1U3fvwukkmOC8YTk7mZD1lGKG1xseFnvJnVKIge55WmiNU9vSWzN/MSL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBI/fYfbJST4BHaKjOIPg7Fl9EBNvjosMpmJVlU4+mo=;
 b=yVFbxsQD5jEom5uz/UZGv7YHn69ENcNhh3QPDCgCX/mmX3pOHWOrzh2eqXov2C05hP0GWSxy7u6G7dgI+Vj2mCY0F4ssf1q42e+HS8bT81eCkwDfUJEp9ZXuC+HgEDvixGfliKKJ/J+hh3x66SuhdD0/WLZVKCSJZLrUv6+1cqeP6TPmqLiA1AaKwEhJdPMa7RxKeOYbIF2d+v18rBzHJO0V8smm0m3tlWmBaUCXo2mqieWi/4UFnZtvyivbWJTWdXgwHsDI4lF18BO7YGFLLwUh7uyP1qaSVQ7zJomSPK0gI8LNtF+qmzl52RAknng/mPH/FhT5vgOakQE1JD5rHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBI/fYfbJST4BHaKjOIPg7Fl9EBNvjosMpmJVlU4+mo=;
 b=rGcbSTclN2/GMOAK2bCjW7muieSCnAZNT4hp5R6QtGd0qUvf0lXsGYLTKj16mYS8U0xOfI8WzGAThQsXPBQ5Wht9TMOV/DIhfqeWSoeA/nJrRJtLvzY4P8Lr1gMZHlk0es0EBwyVg4npIogo5KTekdIbczMUMylHHm4c2Mq8cV1H1LC1rdblL1HZeFX0RqVSFBEBOg094XB7aLSdJYMwF6XPDC52BT+szZDX69b7URUxKhgM8H2Kj8ZdPULvMuAof6xTfh9BQ65o5M+Y4kJaOyxGQPHBL/HYmLKOhAb70uBhgcSV5QY1sazeiwjKhovLoot3DN8dHqbZ9wBB8NO/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 02:47:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 02:47:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 11:47:34 +0900
Message-Id: <DJOLCWQUUZBS.VWTI1G4DTZ3W@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v2 0/2] gpu: nova-core: convert to kernel bitfield macro
 and remove local variant
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
References: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
In-Reply-To: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
X-ClientProxiedBy: TYCP286CA0167.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: c31883f9-6bb3-4b30-d98f-08ded8ad711c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Rv06tSV/iJSzvRTmn06MrIxIGwIoR7YPqN2OFIPg5/FKr6zyiG2rxF2j9G8vdvxl4XV6+Nw446jj03kHWrlFTBHaUXj+qacvdn3wDvc5rA1jlJnTvANlopy9m73ctHRWAHRuACjCjdEOe8GjbeisBhHXM5lQnh/z4PBuFHfd5yT1b1dExOBftNTa25Ekmfo4yBFA39638QURKwdEdcBdVxC+eKOCZBABpx6nU0AsglGMXfuqIwq/jk8nK7Sfa5sTsj740Bhx2EE0NHS81juPxcnzsep9fDpkwEXK9WZc2VAs/iI8SLNIcJCr3YC3hohGgV7Tun5ICcEoeAQz5XDaQSAFmxCIgAyVBBZQaptYgplIYahli8w4dwAyPNAgBoCsS0qMET+FkKp++TyfUgrJe1ff65lGcJ2eECbRdIob++lCHAh4DPnNXRfGJT2Yn+eQq0+YZi+fnyIiiL5roCM8ivN2ZXwelPWyXH52tds30OZnEWZMFvJw6vBL3+p285TCzoCeURRfVp+zus5/mj7LXH+jSXv/+R52Ae51MZFy2SY5OpJHNq0zjuWBHromz7AHMtWGshJzGgrCt5YlbVFARPBgmIXd2Pr9/QqcBSwOXCFwHXys8bSIiVbwYhUv49ZHfbP5IaACLm1KE+FFvEcFmxeZGN3elWZ0OdDBfikAZxSmjPjJbimoZc8u16f0P5d0wf+ktwSg6fS3Gj1NRBjptg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWI2QzM4b2lOUUhmZzFhL3k2RXg5YUZ4Znc3TFB0YnIxYmduRkFNUDJwb2xG?=
 =?utf-8?B?V1pocU5nQ2FCbXd5QkdxemU4R1pIUVVOa0hKKzh5Q25WdEFqOTdNN21QTUhI?=
 =?utf-8?B?VzEwTWFialIxRXh6Ujk3M0pOQ2Nhc2JKVXJML1NPRHd4WU5zTUlwQ055WHVR?=
 =?utf-8?B?ZUphM0szY3dlRTR6Qm1WZldvd29lVXpWd1ZySFNocFBXMU9ZU01PRDg0N0lm?=
 =?utf-8?B?OE4vRkIySDVqTmlFamdvT3pIMVNlcm9wZUxRMG1VS1dPSm5BbmYybDZXZUJM?=
 =?utf-8?B?am5qTVNzZ3hHVkJsdVZNdTVqK3NlSDMxNU83aFIzNXhNcXVvdkZjNlA2QVVP?=
 =?utf-8?B?ZUZscGRHUzV0dXdjcmdnUkN5c0FkUFEzNXFVVTRQUndxTHNDWi8rMFE0NEor?=
 =?utf-8?B?SVBNMi9OZ1d2RlpRZzk2Y2IzMzFMb2cxdkJ4NFlDbG96SnlWVndaRVJlUU9m?=
 =?utf-8?B?Z1VXWmhoMDRkWStVT3pzaytvazlKZG5Yd3dpU3BsM3dadnhWQzFzNDVROWNy?=
 =?utf-8?B?ZFY0YmFEbzRwSnJwYlYycGM2ZVltY08xTTcvU25UVmRNZkpaOC9wT0dGOHhy?=
 =?utf-8?B?bFJKenNoY3RZNXpicThaOHVPdUVnRExGRWhNVDgycnc4OGl0RkxaZk5RbWxH?=
 =?utf-8?B?RDZXYTBtdjFuL2V5Ti9OZ1lHdVZRZjQvWVdOU0FOY04yKzFyZWZJRjBEUmJS?=
 =?utf-8?B?TmFNa1U1eGxTZFVCdGEyUm1KNnZiTldxa29oQjdCRzhPQ3RtWDVzdjlScXRk?=
 =?utf-8?B?YW9tSjlMdlVXYURUaDZZK3JSZmZ6UXRzYi9kNytJSzVwSE12bUVQdlhkZVpT?=
 =?utf-8?B?K0JiRXJIRG5MZHFTQzRQd24rM0Y1WGtHZzk5MmVLbDBEWDViV0xOVm1hYzJN?=
 =?utf-8?B?dXZVRjlZMVYvYXNRZ0VUTEJuQXVGQ0s3UzVKcmJpaytUczdtVjR6VWJZUWJ1?=
 =?utf-8?B?TWd2S3dZeERoS21NSkpIQ1VkdEhxOGdmck1OZ2J4eEo5ZGlPOVJId0hkMmty?=
 =?utf-8?B?Sjk5clVGdlJDejhOYzNwTm1CMU4zTXkwZnU5bFE5Qm9tR3I1N3F4Rm1SQXVa?=
 =?utf-8?B?Ti9iUkZ5Yk80QTVKZzgzV1JONXpteWhGS1h1dmo0Q0VncHJGTW9PbEgyOUxu?=
 =?utf-8?B?cUNPOFBIcVJxcDE5ZWgzek40L21JTXB3Sk1xNlp2Szdva1ZzUXV2c3hPQlQ1?=
 =?utf-8?B?cEpWUCtkcmcxd1hsakhjRDRkTUxjS08rNGR5S3ZXZVB4NDV3MVRkeE5ZNU4x?=
 =?utf-8?B?QU1FWXNLWld1MTNKUlpOZFBqVktJU214NllCc2pkckMyY1c0cUw5RDJ3eXhE?=
 =?utf-8?B?ODhIR1l1bHQxMUpVbUNoaDdvMVA3UlZtUk4zUWpCTU0zcEwxclJITThDZnpM?=
 =?utf-8?B?QTBnMUlrektWOWFNb0RaN1pKN2RNRC91OEMxTXIyaXYrWGJRNnNCemRaS3g1?=
 =?utf-8?B?SUwrT3IzWXRvN0pUbjZ5bkRiWXdZOWYzNEdOekdDUW54ZkhUb0crbitjaWFS?=
 =?utf-8?B?MzlmK1BqL0owQXZsdFJiUmdzWVpWSFVuNVgrWnVETTZlTzB2dUNQOEZmWjNN?=
 =?utf-8?B?ejREd0NlV3lWUVcxWVNVOTNPSFljMFpVMldoUDlKVG0ySUx2V2t4QVp6Nms1?=
 =?utf-8?B?TitMNzV2WFV4dUt4UWR5cllVbXZUbVh3ZkFpWGxIUkNXcVVIQzNqOUprQVNO?=
 =?utf-8?B?WXRKZ051RXZtbTFsOHArbTZYSUUxdUxPTzVZTFoveGIrM0ZuTWJBKzNyTHZz?=
 =?utf-8?B?clNlczlPbVN1ZUk3UUFmbGhmUnpMUERET2wyLzZoMlF3S1F2bG9ZMjVKT3NX?=
 =?utf-8?B?Y1hENis4VzJPbHR6anVhMzA0UEpWN1VSN25sTTBqUWw5VFZhdEoyQ1I1V3kv?=
 =?utf-8?B?RWwzcW42WVlOZ296LzBLcTgxWTZ1cm9FQnh6RmdMdVNrYyt2S3I5cXJlN2x4?=
 =?utf-8?B?MTFRb0dyZ0NDdG91TEIxY3FYRDVCakg2M0hWNmpyQVZXcVBIa3ptaURpVXln?=
 =?utf-8?B?VkFpK21kbzNtaGJBUDF5bVhkVVl1aURuSmovNlErVVBxSmo2YU5SeUdmb0pt?=
 =?utf-8?B?UzRyVFphRUsrMGQvV1hVOVgvTmJURWxrS25ta1BOWEFKRXZ6azROY2dvTEVW?=
 =?utf-8?B?ZFozVVpRRVpNWm83T0tXbnA5THkrWGpneEVVSnNIdjhnQkdwZWQycjhmVEdu?=
 =?utf-8?B?MzhIbmN3VGpEREUzZFh1SDJPVlJEeis5MzdSNFl4WUQrZDdBdHFSZ2pEeVNH?=
 =?utf-8?B?cGZRdUdPdFp2K2IvUWNjRXZRUUhzWFNvSm1mUFlWS1dSLys1VFN5ekQ4bkhi?=
 =?utf-8?B?RDZVdWRaU1QrS2p3WXNvdXhuNzhwNTU5V3ZKZXpJOUFzN2FGNW5welMvV281?=
 =?utf-8?Q?o/cjy41eKFISIlNQUaYlGTFS+0dtoHQbRpHtaM897Lppg?=
X-MS-Exchange-AntiSpam-MessageData-1: JzivR36wWhMsqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31883f9-6bb3-4b30-d98f-08ded8ad711c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 02:47:37.9610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OFfdJ1y67sHrGy4/Fh1lVAAQ4INMqjh9LMHFwio2LIV9cw8fn5HtoLvbcUHnuh8pm6Yz/JDZEqJVl9VksOkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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

On Wed Jul 1, 2026 at 9:15 AM JST, Alexandre Courbot wrote:
> Now that the kernel-wide bitfield macro is available, it is time for the
> Nova-local version to be removed.
>
> The first patch converts all uses of the local macro to the global one.
> This involves redefining all bitfields since the syntax has changed, and
> taking into account the use of `Bounded`.
>
> The second patch removes the now unused Nova-local bitfield macro.
>
> This is a follow-up to [1] containing the Nova patches that have been
> dropped after [2].
>
> This series applies on top of `drm-rust-next`. Since it has been
> reviewed/acked I am planning on merging it soon; this revision is mostly
> to address the Sashiko feedback of v1.
>
> [1] https://lore.kernel.org/all/20260606-bitfield-v5-0-b92188820914@nvidi=
a.com/
> [2] https://lore.kernel.org/all/20260527-bitfield-v4-0-e8821d4efbde@nvidi=
a.com/
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to `drm-rust-next`, thanks!
