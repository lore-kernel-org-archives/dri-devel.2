Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85568C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A348210F0B8;
	Wed,  2 Sep 2026 08:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofUQybu/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEB210F0B2;
 Wed,  2 Sep 2026 08:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6Il+dQ2Zq7afWL73vtMTOS5Nt5AsRMa9VjdApKxvaDpnaf1TkRXAiSUKjbQyntiZFozqZfRzZzXWGbuyi0V0B6uQl2ICaBgmajuaAqX+Re18/nMazPU68orQx6VRj2RKeFCcpOVerZgJYHshTwKDPwZwuZOxKP3aurPtRSQwYAm9BjPC7X6wam/369gYsdRtQN32rYTwJSj02aE2GlGEBJbp5a3RZwTOM7diqVgjw4/hrjU3u65MqlTG+UGTfOxWGIuo+ARq+He1uOpPVqD/ugqNOUxLThM1J7leOME6zktX6uPprD5Cc1T/wBDbxzucFTK1wy8ygRvRSyqFBkiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo0ro/i5n3VyE2q62+ofX459fKY/fQ3BE+yoMVMq4oA=;
 b=MUD1nkYAal9iYKx/g1/2ZiMe6Y+AWvwpvH1dVd+rG69nC7znf+UUJc3phz5m0rNiEOn3XGzUCbYi32SCbaOeYe2QHBpVtCKoM9sVbwHoUSFfFub2kGJdlH4KtDMQnGVfe0c+KTd8Cys6ZoCCjqEsPAl/ui2/4KY2svelUl6w6P7usuKKbVkKQGqPz7Jv0E8kX+ojqVMuYLP5QzyzqZk1aYLEg9nvKEPsnDMmYJvrELPGLZWQpRHSaBHsffIWzPKwbHkm10Z98swNXPU0WVq+LAkyCEWkBGSC94EDQYqNuLaIsF9peqRooHAz5XfLvogClBAkfmRYNtWEukj9dwte5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo0ro/i5n3VyE2q62+ofX459fKY/fQ3BE+yoMVMq4oA=;
 b=ofUQybu/ksLr+gNBVoX++5ZC9ref3rdE3CergSIxjzkV4Wb69lOlMPQQTYFIMTCPL8HTL4509gfJMqw8yUTyXNX4535YByeJPzZhbG5NFX0sDAt2C/4j3pH9xPiPVtqUUNP2GwLJxlsXla4lmXdFPYirpJzTvBtui4B+MK0h6x9zyUGGarajvwIBJY/eaMnsJFa7S+yIsn23Pd3cu+yvh0WVeiM9L15egQpZPqAYxxoydMX4FgppIBQmUnQbjoQHYnKHtiC27FjLdkWdaC0VvjBgL/am4rSMSCLkF51zi9wPzmIMPwFrPGsmQB1iaok/zNEcBP+7Vsl6vCzvFHkWEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:46:55 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:46:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 17:46:50 +0900
Message-Id: <DL4P77QG2MDW.2MHDXZVI4AESC@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 00/10] gpu: nova-core: add PRAMIN window support
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a41b89-4bbe-4ff6-96b3-08df08cebd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|23010399003|366016|921020|10067099003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: E4BwYdvXiFEH8vD76JlOAt6149zy0pB+MQ1ztY5bpPZjCaKxH+9UH1k71Yv/SuksGdg4ri5ct7s9e9UBLxnLASH6mYBerEnUARKBHwYJ9AE7RgrKe122uLC5ph8K6UZXOzSOWJjrwHg4vZREQEupvb3ytiYVa3/0gQtwLkNlVIvVGToouRsAcIEAUXm3YpKXby6sn0dJdL+YVXEWZ2vwfWRjLU+ZP2gExJ9RIwwMcbgQ7hashWrQc/T3Kd/No0YWfrHxzKQMAes145AqeU01gCcsmCUNCh/zj/WUalvDF6B+4fH9IiKhMoakpxTqGqqSRqKJX308mRc6SodrfBXszXw6NHfIh3nLn6VNEEpnvtZvMOWSYlCIRtmPMB0EDjxO51U3OQNVY/14b38zRwbNTPyBwdAFlFE7cICxJwNRR3w+XBjBx+Mn0VYML7UKLZx/ArkijsBh4HS272yjxy4lTZ/GO7A1X76ePJL41ozWCWb2BZQ/hq6mToUeDFlBY1EEiICeO/F0xPCRynURPfyhBD1b58grLeD8smiuoB6npr0pV1cYqDux57UdgW1gYHDGWtu1DY6Y0nq9HTdcqWZ1sgO3PL+5S34uJPQjtNGC91ktUIovsA6koMNAdeC24FK7vIVBtCkfXzrjsM6AOfzsiq05ZYMQe9mDosNs4l//TQet+UFIGk3PKHC+HD4d+Di1ZWvWGpOnkrS3bIsRoFxc7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(23010399003)(366016)(921020)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFLc0pIK2xZTit6eEJ0TFphekZnajdpZW9kRlpxdk1EQXJkczBoSk9hOHlr?=
 =?utf-8?B?Z0lxNkV2VjM4L2hFald4ZUlsUFFmVkNPUWlsb0lBSEdwLy9nZkdZelJpeVdu?=
 =?utf-8?B?ell5U1crV1ppd0h0UWhnS0owWWtlTVFteGwrUVZpVzZ6QkhtanNENXZ4d0tj?=
 =?utf-8?B?Ny9taU4rZE00dG5nN0F1SVArTlo4aHRTMDhSb0o2bTgzaEJwMm04bzlpZ2l2?=
 =?utf-8?B?KzlzUVJqcktxU0ZscVBEemxoMWx4dmo0a1RZUVJ2b1p3Vk1lMmdIRUo3NVFD?=
 =?utf-8?B?bVFyZWVFOTBxQ1RmTHE0QXk3UitOWmNPd1o1VXJadHp2c2NEbXdOUjVSaVFz?=
 =?utf-8?B?ZWJTR1dqOUlQSHZITGJVaUdWZE80UDJ0d3ozRHEwNnFSa1Rjbzh6R3lPeHRq?=
 =?utf-8?B?anY4YnA3ejVxS3c4eitqdXZUWFpGYXQvajNBbWV4dVAwc2FRQzhVLzRLV3NP?=
 =?utf-8?B?d0pEREs1d3I0TUtlL2IxM0c2bFJiYndhRWw2RW44WlFsUDZOR2ZLc1JpRUM2?=
 =?utf-8?B?TWNFVkFMNDlnWWlmTlNkVGRCTTBYcE9qZDI1VGJ5RFZCNUVKbmszeUZBUlJq?=
 =?utf-8?B?MVMzRnJrbExhQUk1Snc5MkorR3hsNFJ3UTVhbHpMYVlSSG5zNmJFYmwrSmRR?=
 =?utf-8?B?VVl3TnhMcjBqKzd0Z01yZXJML1dpQjQvODlpRVZUSFQ0QXRONmk1K2RQemZw?=
 =?utf-8?B?K3hiQStrcS94bzlZM0R4Q20xOXVHcDF5bTRHNmtoQnpTQXdYUTBXaDNldTdG?=
 =?utf-8?B?YXJUV0JFZzZqaHdhRkRKWE5odHByNGxpT0xwUkp0bk42cmVyZnFzcXZtOFVB?=
 =?utf-8?B?QzlrUDV3NEg1bVE0RlBCbHJYUWh4MmhqRE9nOUZUWFNXeFI4RkhSYmFrNUtp?=
 =?utf-8?B?Nk1XQjdwU09jcW1oUjFlRCs0aW91ZHZJajlFcUc0czBVWFpGYXVUR3RoMldt?=
 =?utf-8?B?L0FWS2xHaDgvQSsyeWE0T3ZkU09wV0YrUENIQ2hwMXVZWnM1N1VYTVdZQ3Zt?=
 =?utf-8?B?NEJWUlRvYjVaN05CYXo5YXFWR2V0NDNkRFc2cTQ0eDVmd2wzUlJzYTZIbGFa?=
 =?utf-8?B?Q1VPQVgxcTZiTS92VFU2U1lxN1hBcUR1TFNKZHRYSzBtdkZEdkx5bXdaNWZt?=
 =?utf-8?B?Q1psd0k1azl4MnMzakxkOWFWRFVUdGpnaklqaWpkOWgvaGJORnBOdVdLRFZt?=
 =?utf-8?B?cHVxM2J0L2hHalViUzUweEYyb0s4bTVYRkszZG9Wb2ROU01xSy9IRmZrL3g2?=
 =?utf-8?B?eHhwMHY5UmwxcDdFVlFHSlJEMytjeVByaDhIWHJ1K05oVDNka1ZONnpndDB4?=
 =?utf-8?B?eHFwdU8wQnlqd3IvcUVwSGhWWlByRDdUczlvQ3JKTjM3R0pZRm1uNEsvTElo?=
 =?utf-8?B?MnF4RktCMFdxMXJMNzJBMnFSc2VJeU5JZWF4RGxMc3lJWXlRUnlmUUdCTnhJ?=
 =?utf-8?B?WHRaRVV4OFJUT0pBUjZZNWZoUExKbVk5OUkrYVZlT0dkRjRTam1jMVVIVzFQ?=
 =?utf-8?B?S2xmZUFKaGk0Qm9Nek5UVXc1QWkzZXBxbXhtZ2RnRkRnMWlBbS9SQVN1bjZn?=
 =?utf-8?B?b2huZXdGQWJXWTdwcnRZLzRCYWZtS2JzT2s5QlhtZE80SkhWZW13M3F3bVc3?=
 =?utf-8?B?MWhoYW9TVC9VaStTYk8rWUM3YS9ucTZFS1BETkdCVTZyaWhTRDFDdDRFaUZP?=
 =?utf-8?B?Y3ZhWis3a05oZGcyUk8yVytVUTVWRzdwUHIrdTBPbGxRQUNVMUwwVzRPRmx0?=
 =?utf-8?B?QmhTTEhxN0pUUTV1ZmZDLzRhUlJlWlRJbmhiV1o0NXNrelJFT1NvSU1wL0x3?=
 =?utf-8?B?akN5OTYxd2hBVVRMYW9KZ3BYU2RCTVdMLzVobkh2UnJUSm42OWxadUlEWE1o?=
 =?utf-8?B?VUhJcXZBRkQ2b2ltSFlZV21xRCs1SmdNa3RYY0RIcmg0aE1WN0Q1TjdFaEor?=
 =?utf-8?B?ajVQRnd0dE4wSmJxRGxTMkFuWTNhWkh0TVhhNHlkcnFpU2FYRnRPUm40dGw3?=
 =?utf-8?B?bHRyVklHeWt2YTJWSjlZV1NudXlKdkxnTXJlcWJubWdPWFBkbkhCSWhFRXBJ?=
 =?utf-8?B?c3BaSTFLOUhUOVQrRU82Y3lJcS9oSnJhYVlHS0pNdWN5S1FHZVloZkgxZENm?=
 =?utf-8?B?eHVlYzZDcSt6U2J3U01JdlBKZGJ3WkVRakNXTEcyWnBsUnJlcE1TaXdMU0FG?=
 =?utf-8?B?NTk0ejk0SHBvby9ia3FpUUJJS3BUSEpEd3JWTGppVEh3YzhGT2dlUk5YZXJo?=
 =?utf-8?B?NXJRcEVYZll5dzQwblFXMkE4MU1VZ1ZwM1gra3VpOG5Wai9BRTJIM2tjdW8z?=
 =?utf-8?B?L3Y0NkhMcFRvdzNQWis1Z0M2WjdvbDArdUZLcDhCTjQrTjBCNk1tZWU4R1pH?=
 =?utf-8?Q?lB52fZrvUgNmcIWxl2J1Uh0Ik9QFZYfbATm0PhQDSr00e?=
X-MS-Exchange-AntiSpam-MessageData-1: gKckEfNHq90jpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a41b89-4bbe-4ff6-96b3-08df08cebd1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:46:54.0874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKDm6ujJ3mTNU5TC9wY2b/BwGrVyhGl7TmhVXpIfJ3mYf/OiR0tkFjpc2t+lZisQLUa1+9N/Zv+1o1BnJdBfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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

On Thu Aug 27, 2026 at 5:51 PM JST, Eliot Courtney wrote:
> This series adds support for the PRAMIN window, plus some documentation.
> Some of these patches were originally written by Joel Fernandes [1]. I
> have updated them with changelog notes in each patch. For example, I
> updated them for the newer IO machinery from Gary Guo.
>
> This series adds a Pramin structure which deals with updating the PRAMIN
> window and handing out typed MMIO views. The PRAMIN window is a method
> that lets arbitrary VRAM be written over BAR0 by configuring a 1 MiB
> window through GPU registers. That 1 MiB window can point anywhere in
> VRAM. This is useful for bootstrapping e.g. GPU side page tables.
>
> The Pramin structure hands out typed MMIO views to do writes through
> rather than letting callers write directly through it. A follow up
> series will add support for GPU side page table entry writing through
> this mechanism. This abstraction is important for later since we will
> eventually want to write the PTEs via BAR2 not PRAMIN - using a view
> that we grab from the Pramin structure can abstract this out.
>
> This is based on next-20260817 (e6664f2b33db), with Gary's register IO
> projection  v3 series [2] applied on top.
>
> [1]: https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvid=
ia.com/
> [2]: https://patch.msgid.link/20260819-typed_register-v3-0-3699a75fadf1@g=
aryguo.net
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> Changes in v3:
> - Dropped first three Bounded patches which are merged now
> - Rebase on v3 of IO reg projections

Looks like this series still applies cleanly on top of the v4 of Gary's
IO register projections.
