Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224C01099B35
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A44210EA6B;
	Fri, 20 Mar 2026 19:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="MYweppZc";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020114.outbound.protection.outlook.com [52.101.195.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6872910EBAA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWUJHVJAz1tnLEHCQPXu+/zbj14jfzjrNYI5smg6PQAaSI68VPFWB4RVjzKgvbN8ZdqOu8H02SzgpjqgEobcfCdGD3XDFltuIBbFqTMgaiGm0y83zaZrQKT0VmTuV9pLuaYISBgjJWuk8A/ofJH0sD9VDLIKiaAs/gMG/bV2kUKkmle/HDsxN/tEfF/f61rdgk/wOwcL147MmlA5rQeAHJgMlPNs+Q3k7H53U/c8UjX9aMW5fF7vHOk90Up3MothuKEBrx4oMvBqdfCM+m5GOy0QEPHzVN53I6BJhQkFFPL+1yZZYgPMCj/ueQXHol0WnDTtL5PHonP4QAdaci5vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40s4oNuFk1bm9K15eTBat25beRXJkWc0PDbm0CkizuA=;
 b=Wn69IHeSbpXRFS/cOqJSHQdz3JcwsBHJYzqkAniZkDuU6nisQJG6kgkcyf2h+6B7xt8cDKLEsSfntZaJr+7RlBd0HpxiMqA5FCQ8GIhY+VyppvuayWBgYyT9vhGdENgjpYVUKCWg/uzptoIMmYJ8tJ67YTi2UpTr6gZwoAiKTTdY8PWJ2AhLj+jkemFXwwRsOh2sUour3/I4pwfz/Vs8qQL3wCKNqiG/1lFKNhb583Gyf735XxowzxmUYPxJiG0cGdePMeeaYKzS6v06B7+n5IX6/S2qpAJ+NMupOZHMznTUCa3ro53NjfNEz23MB1Dbj+7Fr22co0uMT06VudmaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40s4oNuFk1bm9K15eTBat25beRXJkWc0PDbm0CkizuA=;
 b=MYweppZcifYZ6dCAc369TumkGFCd+5jk5xiltZUt52Nv/pv8AXa/SI9f/R//oAJRaq4s4VY0vE+XXhm+GcrIpGLc1ojWPXlnU/lEOcj9+LKXWJ46A7RvjDTYNfNAu6vXqTlSFBE9NzMWSGhchmGC4RPSeYe+k3Yk2COzqi4kTJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6349.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 19:11:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 19:11:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 19:11:55 +0000
Message-Id: <DH7UJDWJ13W6.2UC9NH7XBAKMS@garyguo.net>
Subject: Re: [PATCH v2 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba955ef-eb8a-4873-207c-08de86b48da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|10070799003|7053199007|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: tGMXQSD4PADyhn2PIYQNaAaDWUvb3sg5DgucZ7AVvb6BCTuJBftmUkY823tBhaFGsgqkLIjYGgsKDdc5PqTSaEmGpla8SFNVbL8dy7UvtJidbKsTfjYJ6KrLf2c6iYZK410CKXHiuYP2UW4eGPpz0e2tfLSMmAdCxA0tNj6GFGvgcfxcr6yXsTsswrEMWfZeh6rMeOO2pzfRjVF65UdW8U/7TK8d8VQWgiANh7VOUR277SSeyMe4ONIOjSwdggenMKaBsB2iMH0ZjKU65QbIBsk51Zchh46XZTiHwxqjLFCO4N+Sb+0gfxKyla8D0f3Z/vXmtzhS5yFxRL25Tcj5IAz726AA56OPsLX8HjuFeMAP1DyrXEhbPnjhPG2/JYnEYWyTvT72drDUHnlU9Qwh4d6erWREcmRl0s3QnvaL5MZrFrw7JivkENUx16OA/rNo2EBQBBtqdiGtKdm1u+LcXwWir6rNf/Gf2i0o6OU9gUcF7BluqI0tp5ReoHImu2ehomO+aq1OWGgLDSW2thn06wIt5ovNJBLwmko6wUINwg2OyohLuLxWNYJmjWN/zZ4exmW+8YHQ9NsbLEBZBREUDvy6n06CJG8BOcA5mA3xZEpFagnrhXJIezg5kR4eYbGSpIyNn4YyDKoS4OqN2+ZeHBvcwvh8sQEG9wmvj6U+O0/6Lkb+DMfJEWSPNKtzrv/e9/dD66boRZRcvQTPiycxh+kbcmxM6j4PWu5smztrocU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(7053199007)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tHcldaZFN6S2dqM0lTLzA2REtiQzV4b25RWVorVFc3RWZobEpOZC9IRVlk?=
 =?utf-8?B?cTM0Ny9Sa0ZUVGNmdUdSL1A1aENLS0RkN2xNM3RuMjBWYUE3RTd6VjBSTE1I?=
 =?utf-8?B?OFFVVFVsdm41djFIM2xQWTZSZTBrQUtTSFNRMVVWQzlzanBmb1FBSFlGVDFS?=
 =?utf-8?B?Mm5FMUhyOU1JSHdmUlB1TmZqTzZDeS8wbzhBMExTcjdxaHBlOExCVUwwbjU4?=
 =?utf-8?B?dFd4UmNmSHVkREdDRlN0TDhMTkczcWk1QldJZXBpRWt2Mk1nNU1ueVFHVmVW?=
 =?utf-8?B?WXd5bHdURkVqbEFVMGt0VlB4NlpWTVBrMVdYeCtsN2tIT0lQbnlqNXFRamR1?=
 =?utf-8?B?K256NjBibk9LeFRmUDNqSllJR3hKNWxnbHZxc0t1NE5uZVpqMXRyeGI5cmtX?=
 =?utf-8?B?Y09QN0pWNU5UVW5UaWpkdm9sRmt2c0tYaWNqcGo0WXlxWDB0SnBvN25IUGNj?=
 =?utf-8?B?U3U3MGF3dzZwaEEvWUEwWFlidU0zVEw2UmVMWDByVlpBc1JRWmI0RnhHNXNT?=
 =?utf-8?B?MUV4cDlIbDhYVHk2UEpzSkRQZW9XS0cveGhZcXVkSVhPcTk3Y3Y2ZnNSQ1E2?=
 =?utf-8?B?S3JNc3RDdGlZNFpaNEtYTWprTGZKREYyUmkvbytOdWhQOU5xbGxhazA3azNh?=
 =?utf-8?B?bkREV2g4WWQ4WkJvY3kzc2pSTVhxQmhCZDM0VzRvald6OGtBTDdCWTg4RUZw?=
 =?utf-8?B?Nk82U1dHc2tnanNJOHBjZ0pXVWtmS2Zja3MvRDlWaGE3M3Fob1RHYTVFK1JH?=
 =?utf-8?B?QVBpU1ZjNVVzczZzVkxwUEMyWW9laWJYVkt4VlhseVFYcWttalJNd3JJSjlh?=
 =?utf-8?B?SHpObE5WbEtKNFMxcEw4MWM4eGVRa0xadUxKZnpBODltTktlcEhtWjc2MXRz?=
 =?utf-8?B?UEpLVTRZdWNGU3JZUXRGMkUzQ0w4WWpyc01XZGFCd2lML3VDa3JkbHpXR3VR?=
 =?utf-8?B?azRRZkFmd2xMeU54elo3bitTb0tucitHREphdkx5dHhwdWNpcHNuLzFVTHFG?=
 =?utf-8?B?eXFmUFdvZ3E0ZllBdGxSaFl5cCt1cXlIS3g5bUVJMGxkTmkrNEt3VkdOcGZh?=
 =?utf-8?B?ampnblZ6MWwyYzZVaW4yVnZoTElKMUNSOGQ4RnpIYll3Q1l5bVNFTWt4K3ZG?=
 =?utf-8?B?S253SjJJbXVaMGl6cE9NeGg3OFFia0RMQ1NEZmp6cmJGWW5iVUxFUmREeUVU?=
 =?utf-8?B?T293ZW93aGpjKzY1NjVQVGV1cS9iUkM2L0drZ3hNbUczd1FhSkxqVUhxQWNz?=
 =?utf-8?B?MFNTeWVVaWpoVlYrMHBaWVV2T2s0VDdzc2tvMGhsTk8yS2dYc2pHdGZjVTFR?=
 =?utf-8?B?M2RQRGI5S29YM1FJNERQYk51ZGJBMnkrajdPQjVMS0xiSmxkSG9adlQ4cW9j?=
 =?utf-8?B?SldiR1oxZ052enZTSTNZQkIwTEsrU0UrL2tuZXZDVU5hMFpEWURwR25ucTlw?=
 =?utf-8?B?bzNsTHVyQjErTXNFUTdVT3JiUkpsU2xkQnhGcUZmdFdyb3dmM1BGSndOcDZD?=
 =?utf-8?B?NTNncFhyWFI2NEF1MjhPbnJRUitzLzRKa3M4Ti92WVV2K3AxaXB4TTVVbEhG?=
 =?utf-8?B?dGs1TzBiZy95QlR0SE5oNkRZampJOVQyQkZHSW80a1NzUjd6aGo0U2Qzc3RW?=
 =?utf-8?B?TW5KYVM2a1Uvc1VvZ3NlOHZyRHRyeEcwWkc1Nm56ZUpCbUlNWlZrQ0p5SGNN?=
 =?utf-8?B?aG9JRHljQVN2WVNvSjFIbHd1WUh6Y0JzTTlmRTJTWmhmTW9nYlhUQ3hVaS9u?=
 =?utf-8?B?REFrT1ZuNHcvSmFFZ0N5ZHZoTi9tVm9UMHBjZWpFKzNBdFlwZHpETnMrTDBn?=
 =?utf-8?B?UUxQTXkxOEhveTV6N2ljVGNoMXZFYnR2dXZVTEx5djZ1VXhOZmN0bFdGTUhr?=
 =?utf-8?B?MGhqTmVlWVpDak5HRkVYMlFucG4xcThWZFQwNUpSbjZFNklxeERFZkRyL1hx?=
 =?utf-8?B?UzdSN2huQUpsSEZ3anNNanVhd0ZXdHNYZGZUZHRLN0hLUWFnM0lrWXoyQlR1?=
 =?utf-8?B?cUo2UTU1clVNT3JIRDRLL3p1K3dtS21xWTZWbENtTlZONjU3UFkvZEVxWVBp?=
 =?utf-8?B?LzdzcURiUUw5bXlpdm5GR3pPMEVxUk5taDVVZ3pVZGZmUjcyYVFKejZLTkdE?=
 =?utf-8?B?RVRqN0dCQTJZVmo2bTBzZUw5R1JEcTd0VmlzK0h3UkRjWGVwZmtuby9RL3lF?=
 =?utf-8?B?TGMzanB2WVkydHZjcURzR3hpZVRwdjhPOE83d21NZkVXcnpVWnpXM3JnWVR1?=
 =?utf-8?B?V0xxeE45SWxXbXpDVVZPMUl1emNMcWJ4TGVNdXlHcEVIb1pJTE1admdxVUU1?=
 =?utf-8?B?QTM3eldLY1ZMQVp4cGtXeFlMTmFDTFRiY1d1ZG5pYmwvbk1Va0F4QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba955ef-eb8a-4873-207c-08de86b48da4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 19:11:56.2295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tCe5qBtqj3+st296dWD+A02AHWf7u13IYjKK+UmHzwpFMegz75FpgMQIFSkbAJZla4DxXBmVXGNsh3lGa297Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6349
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

On Fri Mar 20, 2026 at 12:19 PM GMT, Alexandre Courbot wrote:
> nova-core carried its own helper macro to declare register types. Its
> purpose was to be temporary since the beginning, and to serve as a
> testbed to develop an equivalent that could be used kernel-wide.
>
> That equivalent has now been merged, so it is time to retire the
> nova-core local version.
>
> The kernel register macro has evolved into something significantly
> different from the one in nova-core, so it cannot be used as a drop-in
> replacement. All declarations and sites using registers need to be
> updated. No semantic change should happen as a result.
>
> All the patches in this series could also be squashed into a single one
> without altering their reviewability significantly. Actually I am
> leaning towards that option since it doesn't make much sense to
> partially convert the driver anyway. I'm leaving it in split state for
> now in case this drives more people towards review. :)
>
> I hope to be able to merge this quickly so we can rebase in-flight
> series to use the updated register syntax.
>
> This series is based on drm-rust-next as of 2026-03-20 and has been
> tested on Turing.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

With the comment in patch 1 & 7 fixed.

Best,
Gary

> ---
> Changes in v2:
> - Reorder register fields in descending order.
> - Drop `nv_reg` macro and use the kernel `register` macro directly.
> - Make `FUSE_UCODE1_VERSION` registers return a u16 directly.
> - Use `into_raw` instead of accessing the inner value of registers direct=
ly.
> - Use safer macro to generate the `From` and `TryFrom` implementations
>   of falcon enum types.
> - Link to v1: https://patch.msgid.link/20260318-b4-nova-register-v1-0-22a=
358aa4c63@nvidia.com
>
> ---
> Alexandre Courbot (10):
>       gpu: nova-core: convert PMC registers to kernel register macro
>       gpu: nova-core: convert PBUS registers to kernel register macro
>       gpu: nova-core: convert PFB registers to kernel register macro
>       gpu: nova-core: convert GC6 registers to kernel register macro
>       gpu: nova-core: convert FUSE registers to kernel register macro
>       gpu: nova-core: convert PDISP registers to kernel register macro
>       gpu: nova-core: falcon: introduce `bounded_enum` macro
>       gpu: nova-core: convert falcon registers to kernel register macro
>       gpu: nova-core: remove `io::` qualifier to register macro invocatio=
ns
>       Documentation: nova: remove register abstraction task
>
>  Documentation/gpu/nova/core/todo.rst               |  76 ---
>  drivers/gpu/nova-core/falcon.rs                    | 582 ++++++++-------=
-
>  drivers/gpu/nova-core/falcon/gsp.rs                |  27 +-
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  70 +-
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
>  drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
>  drivers/gpu/nova-core/fb.rs                        |   6 +-
>  drivers/gpu/nova-core/fb/hal/ga100.rs              |  37 +-
>  drivers/gpu/nova-core/fb/hal/ga102.rs              |   7 +-
>  drivers/gpu/nova-core/fb/hal/tu102.rs              |  17 +-
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
>  drivers/gpu/nova-core/gfw.rs                       |  11 +-
>  drivers/gpu/nova-core/gpu.rs                       |  37 +-
>  drivers/gpu/nova-core/gsp/boot.rs                  |  11 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs                  |   9 +-
>  drivers/gpu/nova-core/regs.rs                      | 601 +++++++++------=
--
>  drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------=
------
>  17 files changed, 765 insertions(+), 1513 deletions(-)
> ---
> base-commit: a19457958c3018783881c4416f272cd594f13049
> change-id: 20260318-b4-nova-register-6908b5118552
>
> Best regards,

