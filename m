Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91229C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C542E10E45F;
	Fri, 28 Aug 2026 05:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SB4Au6RS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3142E10E45F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+ME4dHQVwd69O9U4O71hQ7qyYmszwpCG0YgsWERiqLMBL/pkYqeFQlLe/pvT57ehmZZSHO1r5TjlG0qlyG800N6gsBQ3FA/m6t9lqIVq2ySw5Zr/tc2JUJViMxdALTgp4eKl8XbfgmkuDoMOE0c8BWdbW0sbtYrFPhNz4mTRog3Nit1HH4ORZdUAwvv9kGLcDhYChHFvZ7KywcAtNmhFtkjc83ncDqntF7Q8x2w0Cu18ul08l9B/xSTIjb1ICWK9dlcQzGSJobARiJuhJzUwBc/7N0zgyV6G3rzpqXdM0UEKLJR3+M8gbGz62tuMJeWYVnih7QtzW4/WmN+ey5PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DMRMoBavp+K0RkBN0nbiOMeVGhPbJCMEvW171Ir5Ik=;
 b=rfSzYC4+TXxA/HkpBRjShNmeHakItZa7kyirM13rAy1qjC2T4lR+8js7ZLL9bhpeTyQFmmxad6XZosZn8AtjHO5opMp623OqsUiOUcqGH+IaIFLsPqQLOA8hki2JentBw1SvhOHNp1EKEJ5n0VNw8XMTzqnK8Nc5cx7s+StZadul45K4ITY3v2WJd36k4Cpu856U3mznkHSbB2s+MmLqtYod5XCCjw5jCfZ/hNwQx7SkepdmsfKBWqJPuYF+4dYUNudUrbBOG04j0Zcl32fiPNqlhqrteQ4sK7xzMlDD/RWUWTqNjnuF2yJUTiVo+ym7syR0YdeUTYgZnxFCs3NMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DMRMoBavp+K0RkBN0nbiOMeVGhPbJCMEvW171Ir5Ik=;
 b=SB4Au6RSEmv8p7UVtTtud6Xlmrm9yrlpxr1XJ+TWFEmYUtz1AjLu8Iy42oTE5l1OPxN6gy0C2qFaYPg6jVFtBdvnqcTlBvaXEGlAEoTKZbiaXcggwXWuZidJdO7UUB47kcPEBdSi0ousKZ3vOhvfVcBuqfxkv60blfPlfJVZVQYGoCEwHoA/GyNtKXI012BkBlMWBqrybMXsP+6qqdvQSkjYQe10Tbte7s3gCiuDK/cddbPlFMDLwP+7HqtOeRtk5YuPf/Hrcj946k2TYj63aBdXoUdGMjNX2MDqyrJoKTzpOe+XLcuj3m6EsVBAqJD8NVwS4BDwlkStl/l4YiCm0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:13:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:13:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:13:14 +0900
Message-Id: <DL0BIY2CGYQ3.TY18JERIWOUK@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 07/12] rust: sizes: implement SizeConstants for
 Alignment
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: cf19bb2d-6353-493d-bac4-08df04c3116d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|7416014|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: p086iJ5KtGhu0h/oHCFiPcs9YxETeH3hV+6Bbzliy7PaB4Gfm7KAzoL+tXPoUU9HlgBLrC1oab6U2xPCfjHxq7EktV9f50Rin/rPUqPZtbL51eFA53WKf7rNshK55l5+jsujOZRPDdBjYFz1MqMR9XuF2lA/MgpGzce9YzsCjWawgeDI/8Jk30FxPq1DVCXGXVhsSQJmq7ZQJiv7BCM9BjkJfHL3V/Agc7LFaKouSoe64xBntIlBGzsRlRQb2c/OFU89YCXdJlOScilTY9o0OlMKzEae8MD9HNrsGvbGsTWwyH/CUsHlVnG67zkd0q90A10frukK/Qh+geUPUo2AwQov/8aGMQ679GaiVk/F2GliWUEwEs4W17v+O+oqprLWM7t9ricrDKVHAsEGjvdXgU3HiXLRyKtFGXktvH3oTBh+1mwWamUX+Rae1vlw0GdK9llDbvJfz8jvZfKsFeF36VnA2kYRtvWiMele+VdN6NsrLPpBaLNlwwgp+Axvz2hMPWaEmdEir2vCIE4NAh4w9wM569tnofVnIwHVlGxxRVtfd/OJJx7aO+DiQVUwm4ZN9JZnc2gzQcOCCJmt5co2VGH8WvtFVyldrDltUDcU3kx9ztgPf2gg+ZbcEy+7DbhKKH9d5aJveFA8nQ9GoePv4zBSGWmBuOhEPi89lMtA5Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNBeDh6bTVsYjJld1hvSkM0MEV0akZVazJzTU82U08yMGxMaFFLWWN1WnVI?=
 =?utf-8?B?VVk4YWR4eFJZcDZZaGFxdVRIVktndGR0YVg5THJqRFhYNUdUMmQ5S2ovSkZk?=
 =?utf-8?B?WFA2elV4SjhEcVd0bWlyMDJzTXI5bjdZclExNXN4emtPTnpGQmJLWHFZdW10?=
 =?utf-8?B?Y0UyWnBmeFVIUjJBdjhOZCt4OXREVEtRZlowNWxwcmxhRitrT2RlOWx5N1R1?=
 =?utf-8?B?d3RiejIrM21DVGUxcXk5cE1iUkxtV1FKRWVFRG5SNDc0eisxV25lVnNkOGdM?=
 =?utf-8?B?Vis3YlVRY2ZUQ0lxRTQ3RUp3ME1Zc3pYeVR1dHlMVkhORUdSZENJVGhZZW1q?=
 =?utf-8?B?eDNIMFdQajUzcmlvOVlaSW5kYlFaN3p0ZkYrWGZ0ZW9yMVo5dzRJcHdHSVVp?=
 =?utf-8?B?SkRoTFlOREJ1V2FOaGJnMWtZWTJhQzNReTJmWVc3MGJqYnd4d2gyRFhHamV4?=
 =?utf-8?B?Q0JaRHViQ0hwcGUxdDAxd1pkcGMyY3BkNFJpUDdMUy9na0ltMkNvQThuZFlX?=
 =?utf-8?B?WldjY1pOc2xlck5LSC9Xdlh5VkM4blB3M3ZmcXdLV0FKaTdmQjJvTnRXVFFJ?=
 =?utf-8?B?K2dwVVlXUHdPRFpKMmQ5OWZwblhuUkZhOXErSnQ3U2w2ZkpkRmd1c2pnZ3l2?=
 =?utf-8?B?OTJjSTdNczYycWxUWENMNDZwUTFJK1dQbTljNG0zbXRsZ2IyNSt3d0ltVVFH?=
 =?utf-8?B?V0c3amlFUDJwSGhIdkZZWXdxSmt0cEkyUSs4RlJSQnVIT0cxSndwVHFzR3ly?=
 =?utf-8?B?OFlxeWNSNk9pKzVsWHBQMXVEWi8xekkxalpsakVxeDd4ZVJGZW94Z01aWERD?=
 =?utf-8?B?Vk1rM2d2YndkUUIxOEpJQzczcU4zK1daM25QcEhvR3o3Wmd6ZjMrUFNlUXNL?=
 =?utf-8?B?UEVHZHhwLzZHWjZhV0s5ZTJOdXE5Rk1MaEJXUjkrUm1hRTI2Nm8vR2ZOWUNz?=
 =?utf-8?B?bng2ODEzeWJhL3FYeXZFWEZUS01scEVsSmZjTWxFR0s5Z2dGaEJIczkrSlIx?=
 =?utf-8?B?MndqUUFnL0xYUDAzU1VIUnBYd01CMzFtNlhGTm93VHZZOHh2NzQ5dER6am5p?=
 =?utf-8?B?KzE2STl0WHRzREdRT2h4dWNJQVlQQ1pXdFp4M2kzaDFUendKTjRzZGtkU1Qz?=
 =?utf-8?B?TC9BYktRL3MyeG04STZEZzl0cVVsRWIvK0xjZm1SZnBxL3hjT0FRY25oaFNH?=
 =?utf-8?B?QVpLb3pkK1h3VWJmLzFqQUhTa3lodVBsM3pwbnZuOWFtdFVMOVc5TnY5VkU3?=
 =?utf-8?B?bS96NmFZYUszUXFYOTNLYkUvN3lSOEhkTktyYU1KTlI2OFYxNXV3dkZMWWlP?=
 =?utf-8?B?N29HVlRsUGRGOUpGRWNHVjlXTzN1cUkxMmp5VmFwSWdrOTVaSnNuRmtBbmts?=
 =?utf-8?B?VUZMQy9PaFdQRHBMdldVYUViR0YzT3duWHFNSHpTRFczczZ5YzBVYnBsbFA5?=
 =?utf-8?B?eUY5Qkp2ODJXZUYyS25OZjk0TmFmbEYzNzl6RzhQM2pHSTdXWXhpL1M3c0pn?=
 =?utf-8?B?Vld1dFBQT2xVZmkrb3lBRmZXUnJPaFJvUkJuZDdhTUN2VVlQN3NwOTJWWnQ0?=
 =?utf-8?B?VGdhWmk1UU5VTm0vSmFnRHc0OU4vWWtFSUNxb0JkMUJPMEF2ZGorMFd1MGZV?=
 =?utf-8?B?cEdvT2ZLMFUwSXpvUlI1ZkdCR2x5UjdFblBrTlhMSERtNWN5QnNQZWp1TmZR?=
 =?utf-8?B?dkFsS2JBWjhMdzJyamtqQTU5Zk9ZcFVYb2RXZmp0c2p5cDMzaWhKRkVwRmI4?=
 =?utf-8?B?ZERHZzh5eTRFK2pyS3NneHduZHdtS0dTMUxyaVNrcjRXTXBtYURsNlhhendM?=
 =?utf-8?B?ZC9MMTRuMTVWdU5ITmhpZ2ozcE1KS3N4T2hOaXo0VVRuVjJrWlI3VWp1UWtE?=
 =?utf-8?B?Q0k4bkJDTUJjWXRWdllXUm1CR3doeEpjcjl0TlcyMmxUOWNaVktIVFJtWVox?=
 =?utf-8?B?MjNVbEMyVGJEU3BqcXdiY09KdzNsQ2VmcFowblFIeVpDdWVoTDV0RkVuVmRx?=
 =?utf-8?B?NU1TLzV6MHZZdzBHZ3FycFU4RmxBQzlTdm9PRzZpWXROdVdjV0wrWVJxNzBR?=
 =?utf-8?B?UHRQdVdGQnV6amY5SjNaT2VleU1sWWJqcDNITEVlcG0xc21vZEtxMnRwSDRB?=
 =?utf-8?B?aXk2Z2V4d3FxSkdtbUo5Y0VGV3JzUzRvU1pIWkVjbFVVYkZzczRNelEzZlkz?=
 =?utf-8?B?M3ZaT1FsUHFHT1RqWFlTdUtwUnFDNUtFODlEQWNqL3FxVHJHbEhUSnhqaElC?=
 =?utf-8?B?NXdHeEFhVlNEUktQWEpxcHFSaDRmVUp6NU1iaTFtYnpRRzlZT2lyUzJ0OVls?=
 =?utf-8?B?TGZkOW8vaVduTVJvd25LL09jckRjVDIrWGp4bnliRkM0cXMxSm9iUUxCOU1N?=
 =?utf-8?Q?1jjacvC4dUq2JVI3RdOCGoRjIa6PB4fXfdwoBqFHDxeHQ?=
X-MS-Exchange-AntiSpam-MessageData-1: vZj56IfMPIUemA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf19bb2d-6353-493d-bac4-08df04c3116d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:13:16.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfJ18grIZVEgyLRY0JwhaWzKzIEjabYEw4k3BU8mMs68EvGfOPx9qni0K+WOW2Dy9jootTCMb7w5BJ5oleWbbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

On Thu Aug 27, 2026 at 4:28 PM JST, Eliot Courtney wrote:
> Currently, constructing an alignment is quite verbose:
>
> `Alignment::new::<8>()`
>
> It's unfortunate because it disincentivizes using it at interface
> boundaries. Implement `SizeConstants` for `Alignment` so we can write
> e.g. `Alignment::SZ_8` instead.
>
> Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury

What's the context for the link? Is this a `Suggested-by`?

> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
