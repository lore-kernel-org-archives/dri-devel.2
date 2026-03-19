Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B3E1088E58
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 01:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615BC10E08D;
	Thu, 19 Mar 2026 01:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoau60UE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA0D10E08D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoDK5a4CIFX3f7/DyT9UAaDrrohoU8wcGUuHjs4d9aPmBKV/7zwrzIOrCQrmhWKJ1PcjR3q9ZwoIU5Hcw7fW2mLW7QUF69HxLs0z182tRxj0Ggfr32WBKKWzxQbS57LCssDB+I9P+fPDVd/cKfOUXaxEBFkB1uWusZ9OhEnPXZUF/W6w57uW8vOyiBCDqXPmOnikIOo2kP8PEzyzrRFWoMhiVJge0NvRX7kQsU/dST2AToZt51h+egiX6iD+46GaSFJeMLa0ucH6HaMlA8tCw1zLHaU0LUCnfG/fRYKr4RGkxhh9Ch58ZFeZoIA3AErLQ9exrMSpHEY2dYEuGXVZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0uonCWgtjDXKqUIOD4y1zte9jP8SFM/7rKIXujiimM=;
 b=e5/kC8rKPqn38v5v9SvIFyx7YJCWEKxpMoQcWifbdxvOFJfMYobD7VMlCnu/oSz0n30nWoK9gt7BUChR2pA4EnYhaiJ4aT7fGb1u0uCSOEooBUfRYljSPmgEmVN6kSaQGLng5SaiQz+ELSTkKliKjSvjpHw2+8WoWblyfov5GSSli8NmkAY03WHpCokTYPMXU//F6J+z2uwkqtPZrwF1UZEuIODNchQB6a3HFL1tZqARSQJg7c5TCv4GTVQF2snYue9nvCxV6evNISJgNBxb9OLsXruqyJsTsuhMcHTfVrPMun2loivMtY5W+pnLn32XeZG10VhWOVoOi0E9IsTXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0uonCWgtjDXKqUIOD4y1zte9jP8SFM/7rKIXujiimM=;
 b=qoau60UEwUiZPPrcvI176ZtGF++p9jUn34CdzgfFwYkx8Bd7sKys1MKyZoJhJI/SQVLnvdG8zugj+BnK/x3cUBBTqR7ZpD5W93qhve8o2qabmU6IPss7437XdT4K5c4BgnK2b9uWf0UGe+lYh6cNdv6pjIX6j2AjX0U7B1PpLcr78o5vXBUfbf6cXRE5j5TS+2JI480jxbL8pxyADslERxgJ/S/DdOyVbNFubU2RwITSPVJvlVKp/KJ0N7NbOldnIm8/CMPDs7/HUo55nSV+017Nc7j6IpGHsa003fYcph9J4JAYMW46fchz4VAFNjqCCCHkAYDTQeogTl4euHzpsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 01:51:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 01:51:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 10:51:13 +0900
Message-Id: <DH6DS0ZKTIF8.37KJVY85DNB24@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/8] gpu: nova-core: convert PFB registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-3-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-3-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0103.jpnprd01.prod.outlook.com
 (2603:1096:405:4::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2ca343-9998-490d-57b3-08de855a02ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: xlhzJrE/4F+fwGwZ4P1FdtiL1EsZhdJQgn1/kYX06dckUgzRD74qxEkZQphdWC1Mix/PXE1dTejxLXqnDEBioUArOCRQ71SnOkebY2Lan++JZR4vNBSfsLdR1J3wTrZCX5sxH8OSdHZUGxBqva2RXPnm8VyuD2TAmSgXY0NqS0chbB78NsgfFi3zVptNgi0mVL3XO3vxG+8xCTM2IHDhWez972RiYUUOwIA4aGii3c08Htq6aI87a4uE/1wCo9pQnnfDAWfTQQyK+ddfwtzAs4dNw2Q6zIKcm9kahIKDMmH1maxXQBtnLZyvqMW04jbl8GQCf0WvM9rgFZ4vdM18iIRItOYa/JqYg1TmYgqVIzUeWI+Hd3OOOC3NAvLtwOWfXl90U+oZ8hYq1lNpXDQsdQanTw/W2XlFp9Sm3GIVNohLpKY8kdfqehNIrr/BwDipFvJ3wPOVFe++1JnNoKW2w0LXCeQcJLR4mox/ovF5oDDFfKo/R6HNEuLCVlcWd8LEWpm8SdBPafKX9+CU6jaLVmsnv8Bssx7kahxvgVoLx9FhHsJSpWklR6BPu570+a/9NmqeDaD/yvuTw9nWOt1qudznrQMRuE69L/WMMcHOHq+AeXvZEtCF2H3+PQdSnzPDrMHe7JEXRw92cm6XMxw2yBwzgV/R3bONJHS2h7ObnobVgoiQNf9oqRWhMny/ytw5IMpru9Y3QBkc6SSQixXQWEx3XzzxNQQczuEsoQ3R3+ytfjCHvGMIMKSvxOUArnJg8Di8bzj24UE7YYjfPWZsqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpiVkxFOGlpSUErZlZ6MktiTFJkTS9XNml4dnVJaXZaT3JoQVJHRmMyQUI4?=
 =?utf-8?B?cUlsTXFHdGFXdGlqTDZvdTdYRjM2Y0lzb2ptYnlXRGxGNHlQNkt3U2dkdU1r?=
 =?utf-8?B?QjgyZ3AwSXFQNnpSMG9xdERPZjdJbHdSc3dZOXpueVhITWtUTE82MHRMbGZy?=
 =?utf-8?B?ZUU3Z3JhMWRHQytGUGRuZTV4MjFUeXU0Zno1K2tDSTk3SHpDSTd3ck1hUTg3?=
 =?utf-8?B?R2xjZ1lvS3EyTERYOEpmT2g0bERSVG5wWWV0V3BMaVEzc3Rpa1prQmg4a0dt?=
 =?utf-8?B?bDF3UnVWdGtFUjhZRlpFcGoyNm1EaDBCRTVpSVQ5N3d0SnFsdXBhVGZWREow?=
 =?utf-8?B?cnE5RjlNRzNPQUx5UUFSNnhQWE5GWXJjTk1vTmw1eFcxWmMreVRMZXRHYTB0?=
 =?utf-8?B?YUNDRU9tM2hYcG9mZkx4SG8yc1g1N3p5aVg2UmFZdzR5NzREeEtWOXFLY2F2?=
 =?utf-8?B?QXhOWEVaQ2FEajY1ZEhxcnM0OTM1K1RYQUE5T1NOVjhNSk03LzhSNUxOWHVC?=
 =?utf-8?B?VzJWNU4wWXM3M0xhVlMyVTIzVW9TVVRDN3J6c3NReVlzalBESndnOGp4bzhz?=
 =?utf-8?B?K3MyVGpOaDZYSjRsTTg4MnFMWFBsRFRuOEo1dUFyeE44bGE1TDVWZ2NYb2R0?=
 =?utf-8?B?dWZmQ2dzQWNOcUpJTEQxcVM2VDZaS05lVU5WcWZNQThoVXZSVENZRGIzREVV?=
 =?utf-8?B?MXlUSEdzY2F0Ry9wR2hiQzROMXQ0OGVKRy9TY3dlQjhObUhzM1o4d0VVRWNL?=
 =?utf-8?B?Z3hYNGZES291c1JFZFNZWmUvR3oyWUtNeXdrNGY2OUR6ZkFHUTFDWnUzaVBz?=
 =?utf-8?B?b1g2SW9MOHdMeHNNVncyU2plR3lIajk3ak85MXpCZTdwMEJMZ3k2SVliWGZp?=
 =?utf-8?B?N2dnYWt4K0lKSkZtZGlDTks0Mk1CUG1MYjR5aGpia3A3a0RnNVNvK0dVcGhn?=
 =?utf-8?B?QS9kSEYvR1B2NXVEcmtKeWhKblNRR042Q283Zm9qRU9vYWk2QjZuOTdzazRN?=
 =?utf-8?B?SmJqYXdvZDA2UmZWdDZtVkNHdmJ1ZVYrRnhCK3NzaDVWRkVnbS9BUjFUM3hs?=
 =?utf-8?B?M1JNTk1TV3dSQzFjYTRNSE1qUk45SDh0blJtblYrSEZvSE16cUtvakZGbURn?=
 =?utf-8?B?Q2I4dUhUdmYraVEwck5BaUV1Y1M0OHhncVVuMmVMQzZid3NkbzZpeSt5cTE3?=
 =?utf-8?B?TlBSazRJRk9vTEpYUjdoamxBMnlYMFFHelZzRmZxMkJxck0zN1B6TDQzR1lH?=
 =?utf-8?B?WlRmZXFKMDNUN1lRaFpzNFdiNXkwRXZQV3VrQTFiZXFnNDhqUFpPdWk2ak1S?=
 =?utf-8?B?OGxMN2JhV1dOSW5QK1dQekZTQUtkcWd1V1RodUdYWXpRVThuVnJENmV6V284?=
 =?utf-8?B?S2ZtME1zUSs4aWFSQlVnYkluQSs5NDhKOEo4TW5NZTM4bTBKdnk5RytkdlJs?=
 =?utf-8?B?NUhWNjFxWTBaVHhJNVpiTitOc1pOYXEwdXZKcHJ3L3p6d0tzTmhTZDBpNFdl?=
 =?utf-8?B?WnJsYnFXOWV0UG9yUzJIRlpUWlF0YXczL0N5MVdHcW1URXZYVzUrSzZkZmVa?=
 =?utf-8?B?Ri9HNzg4d0w2d0ZwQjNyZ0kwUkdnNTV0ODYxQlBMaWEvUUVrMVp1S0FyVXJS?=
 =?utf-8?B?cHpEa2puQWp4Z2R3ZEFnTGs3NmZtRFpnL3lmeHk3YVBEd00yZTdHWHpzbnZC?=
 =?utf-8?B?eUx2ZEp2K3lCSUN4TTBGREs1L2ZLd0w0L3ZwTGlhQlYrVmI1aURhREdwYUlu?=
 =?utf-8?B?QmhpYjNDTWVGTmJQQ3d3VkJtVm5wS00zV2EyN3JVZjh5Q0c5Y1Jyb2IxSlZu?=
 =?utf-8?B?Ri9nU0lzMEU4RWtydXRLSVI0RmtHZGFTMnkrbW92NE9ZbjRyc0lJMDcwbzZU?=
 =?utf-8?B?UzJZQ3cwbGZvTkR6RG13bWJZbk83Z2VXR0hwNjlCNlZ2K21nWW03cnBVQWNE?=
 =?utf-8?B?Y3RPenpmeGdIMVZkeWg1Q3RmdElhTmtTM0xpcGkxMVBLR3BHUkhEbmE3OHNG?=
 =?utf-8?B?aDJpZTVJZGNiNnNFejlGTkVpZkVvT3VVazd5bXdZTzZ6d21ZOGpiMUhreXVu?=
 =?utf-8?B?UEI0MFc5TzA2aTNyVVludXoxYnQxbWZtY3ZHUnBJZUZXZDJUUldtcWloUENV?=
 =?utf-8?B?QUlORG5ETDBtZ0xoSnNaOEJEc1FjWUVHd3EwYnNPZzJNNFFaMzZEaWFlUzNn?=
 =?utf-8?B?MnVDWUp2OUFyUEdhaE5lKzcwUXA2Sko4SVhYaDIyeS9Eb21vYmRhNTRvVlRI?=
 =?utf-8?B?bXEzUnZVdzNSaHlhZzVzK0EzOEFnN09LMVNXWDV2WG9DcWxNWnZZQVYvcWRY?=
 =?utf-8?B?bWJ5M0ZUaFU4U0ZHYkFUVmZjQncvZTBOdFdrUWpZTnZiaW5VczduTlA5OVdx?=
 =?utf-8?Q?x+MqK6Isc8a2Ty81oLYuOR5eCHw/0bZydW6vJuZmTz04w?=
X-MS-Exchange-AntiSpam-MessageData-1: S8ASAkCEkuKLLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2ca343-9998-490d-57b3-08de855a02ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:51:17.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiO2TeY8zzlHH8L/wzX7XVLR+BrNYA5WcVX2GcxLLdbAa0toO9mk/WBwK5hhDdCGXaGyNxaL2DBLSYs1rXqpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all PFB registers to use the kernel's register macro and update
> the code accordingly.
>
> NV_PGSP_QUEUE_HEAD was somehow caught in the PFB section, so move it to
> its own section and convert it as well.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
