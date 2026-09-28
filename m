Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B618EC9830E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 00:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23AE10E4D8;
	Mon, 28 Sep 2026 00:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BccpRyYo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B3C10E4D8
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 00:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZOpwOLJetXEcwvtSh/3ze3Ri+gCyfbisx0prW3izsHCuR0GCK3f8h1IlWg0ztOuEpmXV9NG1WyEKPaL2G0hUy1OdVLisQBBHgvGNXMA0vlNANyNx3/yMyayVNWSxoZYPSI8WqyCdFmcopIRKHLb4dwMwjroIjY2amGAEDb80Mvv4fb4qk6UZtSwZVowG+CewIBLW02RwQOUQCsEv4pGF2ZtxNs5ifjUzH1/ztNPhCPEYeZ1d260K8WG7h1LJKoA+xrKW54T3IS6JTU0AzUIo0H05ceAT2/QHyyax+639LppU4cLc5JDmWq7cTXmEAaTzRWlMrvaaiEzXlOUTNDRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgYtBHIE6RlIxjnh2ac1O+tqYkVfZ1kotdbW/8mZ2zI=;
 b=I2HlS7iZF4jx8RQda0l52/uuwILU84iQtQrmpTq8B25I1fU3cQ9p592ARZAYTyroK7LIFAxO1XjodPPp5h3wunZZhqwL3zATxoq4QqIR7wmDJDFDhDAdFa9TU2syJEZmxGeAEy91jVA2QTJgnd0eG/u0Ze+fjOLi8oTSkzvMZG2Fqa4Lg5FekK4uckMeD6yuCHbXdJ+ShWwx8aMXaIpRacPXE4zov3/9mH6d+UwAdTZNeRxZ7n9TYl5+78hwyP5+WrGf94WXlmqJE6sdvpj+ZrJSsvT9ioPTMkzZGOvB3PtvcWy805AxZdSK2/ROkLv3R6NOssENDTKLjEgCB5vOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgYtBHIE6RlIxjnh2ac1O+tqYkVfZ1kotdbW/8mZ2zI=;
 b=BccpRyYou6tAIfeG2p1VfsVK/LDJyNfdeP2dwNDqRMLARMY6zKEQXNUZC4kOVG+copiC2EiN/JZQglkfO1M4ne4or9HDy6bkeQQo3J+ORJ+WmY+KlyROV5/DDsykRt/eJnGRcIdTzoLqd9mCUC6wjJOMzxJRjBjab1rVbnkxOsJwt0Pnp5Udi7/jD8AW10KRorNu4rUll1svhxc0JvJzxZdkYkfV/q9e5iKGuXpqGHNfErJs8Tn+eb01zomcxxxjP1O4hqYm2YiwZVozMYmfox53pi/G00Qy05+xumNWmaDHa2G2hH9T7p7JqZPbVTa1Tuxy7SN3/GuHAInOxYb7oA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 00:23:21 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 00:23:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 09:23:18 +0900
Message-Id: <DLQIRUGZ3L4S.2HUCTWWXHIDII@nvidia.com>
Cc: <aliceryhl@google.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260927144417.1280385-1-dakr@kernel.org>
In-Reply-To: <20260927144417.1280385-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a71b34e-4e38-4f0e-771a-08df1cf6b376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|23010399003|10067099003|11063799006|7136999003|6133799003|22082099003|18002099003|11062099010|56012099006;
X-Microsoft-Antispam-Message-Info: /bTD93OG8FvtdaoKFU/O5twHFQ1HEtLbbTUCWUQveTs781vLgejQN600pAZqC2pxOCblm4VmUdul79r1GkCvWr/G/7vcSWu3ly8GmzIEeMH0SM2qhSP+Qxq0P0UwSZqztUeTCQMA1hm5lHN/t/5H+Y/lX2FEDGb7RDjhnZMz+6kywfwPPQx1DQBr3SOVI7/REiw4XkG5m2ja4T/ARsgaoWhuVo80gVNWzpF/CZvN7+7V+d2cJQfCgWA1uDCGGvlHXYQXS55i2ZEQU3PVZw4MLIjDKCYo8IkUEgdeGwgDC4EUQMupZN6/kO5Hrdb/ep+j/5rmJxkA5Jj4Xml9MrSMfVUMLSEenCcnf7m2uFPUGm1MFXBz7fRYSNTixL2SVYk0pTlfASzqvsU2KtAHOsptmeEIj61qeXsRr0aI2mvxgXlHonh/g7eYTBb9ut8TXrM0JkA1MSbubTOXuy1AT17npP6XlIuyF797sVqlVL+/d7PomnsL8PnyJ+bmMRqcSkHRlaltOz9YGs6QUPpQ9qlqP2SpCD6QDHqv2Lk8/9J9OJ8fKVB2QJkXhb8wxQ+XxF64diqSIZ/lrCklBqo/DkfRjkmiwrjwfUy1CofXZQEUxyyusFQpfqFZxswncVYJvxzjLDu5ePVF4KEuZTLe0nnBIe52PYAx2EGmMylekZsde8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(10067099003)(11063799006)(7136999003)(6133799003)(22082099003)(18002099003)(11062099010)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNRS2QzVm96Q3ZRMEd0QlVqVHVBMlV4c292a2JkNnd1UlVpWG9aSTRhUDZC?=
 =?utf-8?B?NXRQcFFvekF4QWpFM1FhaSs3WFJqM0g2dndyb005YmdxUTVrd1FYb1BaYm1R?=
 =?utf-8?B?d21ySW40Y0d0aXFHLzBkMHV4U25PdkV5U2pBUVRJbVNYWW5jZEhuM3ZjWDFx?=
 =?utf-8?B?RnNaelhRaUxyYnJ1SnZNa2ZTbUlhYnhtUWZleHdmdEpoRGZmbWNTN0JrVWRa?=
 =?utf-8?B?VG9jV0ErUzBqWktqd2pxSjNRU3B0K3Fmb3JTaFlGV2hKMXBnUDZYZkRoTy9W?=
 =?utf-8?B?UEwySjlNZzVvQ1MwVjRIdDh5N3phc01UTVhmWERJVlltMkpPcTZnVlZjSmp1?=
 =?utf-8?B?WkRUbE5ZL2QwVG1LSkF2dUJXbHVMM2dsWkN1UUVmeDZVcUVMbG1xZ25mUzZM?=
 =?utf-8?B?Wmt0NVVqVWdyMVdGcmtQZGJINnJNVnZOeVNLSWV4cHM0VDRJZlprNk9vWjZL?=
 =?utf-8?B?RW54TnEvT3U1MUtQQzNIUkpkUmQ5Zldkd1JEck5rUHFwYmhQOWJwSUoyaUdW?=
 =?utf-8?B?eFZBVWhCU0tjWElEZGtHK2tuNEIwZDBhOHU1bGhSb016RlJYaURJK0xlQ2pi?=
 =?utf-8?B?d29mU0hJZmxPMkxpY3NvZkdFTmZ4QkU1VWlaOS9UVDBtUkVVaStvQk15WTZv?=
 =?utf-8?B?eFFOZVZvN0swdkpXUEZjWTdHYXc3cFBtN2hUQlR3bEJRSTBkM1VuSmlOWGpL?=
 =?utf-8?B?SEswK0VVR2hsWWJ3cllzTGlSWmFuQzZiVFNxWU1ZZVZNZkxEKzlUV0gwZi9X?=
 =?utf-8?B?T0duZjhPOTI5SGcrRGszTEZGUlo5bHFCcDVHd3d0YWc1OXhPQUlDcnNRaUpD?=
 =?utf-8?B?TW5IWjNoWEo5L3oxdHdpdGtleE1BVmE2RVE2K1duSm4reWFjbTVYaldkclNo?=
 =?utf-8?B?L00yMVMyWTNhYlRnZUJUUFJYSzh6WFFheFVjbEUrc05wOWk3L3duajcwbkZu?=
 =?utf-8?B?TTlpbVYrRGZNLy9Ncmk0SU5yMStlUU9mRFRrVTgxbDdFNnloWEVEdWlqend4?=
 =?utf-8?B?QmJ6UDl6dE51ZGRURytmVlhTQ1UwalhDSGkwY1Y4b3cxMURmWnVaZVQyelUy?=
 =?utf-8?B?b3NlcHRjWVBlQVRGWjNWd2t0L1k5Wm9GaWFVeS9rWENldkFNSEw5TkNKWnBr?=
 =?utf-8?B?dE44UFd4eE5qT0dPTEMzWURjNXc3ZjBJRGYwbzl1dURmUDN1V05FL0hzSVlq?=
 =?utf-8?B?aUJaemZhZjNhTzA1RGRCV0tFK2dubUpkeFhnU2I1TzVYSElEbjlnQ29UWTFn?=
 =?utf-8?B?M1pVSXFMNzdEMCs5N1o4dERwWEQrMUpyVzRZLzNpSFdYSVlNaFJrSFg1NXcw?=
 =?utf-8?B?TG5zZFBoWDgwT0hvMWxDUUxjQ09RZ0JQdjNzTWZiRHVyL0duZTZMckdkenA0?=
 =?utf-8?B?M2llQWdQczVrSzgzY0ZTOHRYQzlsWmJZdHVyUVFudk9lZjZFcUw2VVR0Q1pu?=
 =?utf-8?B?cWJaYkh0M2Y4M0kyY1k4bUpoWUNpWEd2OFM4Yyt4bWpSL2FjZmxhS3ZEeUNC?=
 =?utf-8?B?V3VJSGtKc0JvbFp2V2JVY1dBM0M2MUJ1Wld0TWh2MXVLUFpTOXM4VndCcmdO?=
 =?utf-8?B?LzZJSTZsaDFNTXpjby9OSmJTNVBXdmx3d3BINHIvQ2oxYjFZVVJNV0lHSDQw?=
 =?utf-8?B?Wlc5VHVKd2l6SDluZVRrZDZDV21UTEpKWWkwUkkwM25TR29oOFA2UUV1cmZ1?=
 =?utf-8?B?b1lCSnZkWXFTSkVJa2laNVJUbUlhL2tubkgvbmp1L29YUk9uMTdXbFR1ZUlu?=
 =?utf-8?B?ai9TRFBQUFRwdmRoYVZ6UVVjQ2JXaEM1RTR5NUdzeTQzR2NtdFhnbVhGeUcw?=
 =?utf-8?B?L0xxc1NtZmY2QmZxZm1hM3BRaGw1eHBweUlJSmJ2aVBMdkdoM3hwY1g0bHUw?=
 =?utf-8?B?SHZkZnZBNHAwUFdJbzE3azRvR0JNN2FxWkVaQXlOeXFlTzFyUHYyRlpsSWxt?=
 =?utf-8?B?UTNGalA3VUQ3dlZXaWVrR296WUdLUlZKVzZHM1o2am14SmJtSXJMTFJvOVdm?=
 =?utf-8?B?T29CSUhrNzB5NC94a2VrR1BjbzErQlp6cDlmM1BtazBvMUJUZ3R4cnNHcStT?=
 =?utf-8?B?dWVnN2s4NjhsL0RPaFhUa2lzbDI5Z1pxcDV3ekxQb2orUjdydXFhenU2b0JU?=
 =?utf-8?B?SkFlSjkyeWU3N0V3N05MWk56MW0reVJnc3kwR0N0SEMwNzBkelBJcjVxWmk0?=
 =?utf-8?B?VWNYdkVTVlFsMlNwRkNKc2dBSmRhekhnVHhJK2lyRzlzb3czemM2U0k4YjlD?=
 =?utf-8?B?NWI1UVJMVXA3dWpQY0pwc0RvbllnOGNyL2t2b1NrNzJVZjNnTk5MZUhPcFp2?=
 =?utf-8?B?RUFVbmRENll4akJueDlxaHM2aThyWmFTb0V5cm9ZcW9zS2h5UWordTRhVmhp?=
 =?utf-8?Q?zCWVba7A5bHEb6Uq+8zKNuyfQF4RZIjgGO6xO5qo2R+oF?=
X-MS-Exchange-AntiSpam-MessageData-1: R34Kf/gEqweP8Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a71b34e-4e38-4f0e-771a-08df1cf6b376
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 00:23:21.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmNn3lLHh/6YLSWo/ONACwvRN+6fOEZEAWa6ZQrJqJZtJOJ8gDiLq5yiSzNVXsslCiUJXVE/F1lpaNI7VVW7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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

On Sun Sep 27, 2026 at 11:44 PM JST, Danilo Krummrich wrote:
> Just like in Gpu::new() a single try_pin_init!() block makes the code
> more readable.
>
> Besides that, it prepares the code for a proper PCI device enable guard
> that we will get soon.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs | 105 ++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index bdaed5408a00..623d59dcde6e 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -100,57 +100,60 @@ fn probe<'bound>(
>          pdev: &'bound pci::Device<Core<'_>>,
>          _info: Option<&'bound Self::IdInfo>,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> -        pin_init::pin_init_scope(move || {
> -            dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> -
> -            pdev.enable_device_mem()?;
> -            pdev.set_master();
> -
> -            Ok(try_pin_init!(NovaCore {
> -                bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core=
/bar0")?,
> -                bar1: {
> -                    let bar1_idx =3D bar1_resource_index(pdev)?;
> -                    pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
> -                },
> -                // TODO: Use self-referential pin-init syntax once avail=
able.
> -                gpu <- Gpu::new(
> -                    pdev,
> -                    // SAFETY: `bar` is initialized above, pinned, and o=
utlives `gpu`.
> -                    unsafe { &*core::ptr::from_ref(bar) },
> -                    // SAFETY: `bar1` is initialized above, pinned, and =
outlives `gpu`.
> -                    unsafe { &*core::ptr::from_ref(bar1) },
> -                ).pin_chain(|_gpu| {
> -                    #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
> -                    _gpu.run_selftests(pdev);
> -                    Ok(())
> -                }),
> -                _reg: {
> -                    // TODO: Use `&gpu` self-referential pin-init syntax=
 once available.
> -                    //
> -                    // SAFETY: `gpu` is initialized before this expressi=
on is evaluated
> -                    // (`try_pin_init!()` initializes fields in initiali=
zer order), lives at
> -                    // a pinned stable address, and is dropped after `_r=
eg` (struct field
> -                    // drop order).
> -                    let gpu =3D unsafe {
> -                        Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_=
ref().get_ref()))
> -                    };
> -
> -                    // SAFETY: `NovaCore` is dropped when the device is =
unbound;
> -                    // i.e. `mem::forget()` is never called on it.
> -                    unsafe {
> -                        auxiliary::Registration::new_with_lt(
> -                            pdev.as_ref(),
> -                            c"nova-drm",
> -                            // TODO[XARR]: Use XArray or perhaps IDA for=
 proper ID
> -                            // allocation/recycling. For now, use a simp=
le atomic counter that
> -                            // never recycles IDs.
> -                            AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                            crate::MODULE_NAME,
> -                            NovaCoreApi { gpu, pdev },
> -                        )?
> -                    }
> -                },
> -            }))
> +        dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");

Don't you want to put this in the `_:` block below, so it printed at the
actual initialization time instead of the time the initializer is created?

Not that it matters much, but it sounds slightly more consistent.

Regardless,

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
