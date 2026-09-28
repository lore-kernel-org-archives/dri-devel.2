Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FCDC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959FE10EA4C;
	Mon, 28 Sep 2026 11:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ALowrQ2q";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD6E10EA30
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9pEyUl4cihiexa90c8VbeAt4JyQqT5LQgr6HPBJ8g36GHpFb8yeOGwNohgLP9Vz3iyuGCSSBdZLptY+VMR5eY79nxWhFgVXPaUdoRHwU6aTBLfDyTpQfO/bLkXihB6HXxI0g71s5g6mZ/w1sEvGtoSToGZjtL+daK51eq6lv5bsCqUUgGnLT3jJ/ELDwdjKE7Mm/uR7xC8xWIoVztjQTihBLpjEh+zzaf0ItEF7zo9dfBfkEXfVYYd2Q7xuDC23orh7Os1ksOu8lrHjH7bB+2gsOT1yovs5T6q+/M1iy95CaLE8v1MnGYGsFoHuONjuVN9Fjae0X101z3Z6b4pOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ensLBHwlooAvgr45GOOUyswCZgis3giq9ERb3tOFYlE=;
 b=QaDP6UD8Ue+8zKlZ96dvs2iZHVze1nkXTbHRtZtE0kZ44vbEOC1YuzmdLSe2uRNX4TIX3q5UJH4YGjBEvok3/Ipu2cF6B06E4MzF0pfEBUtjbfRSdFe3AD4IXACulSIObb4h2wRE4Y+BuV0l2QmLNEI9oLSi57ERUsdxw5+5htWDicMdgWoZIvLuJXcfaTUZH4bJMykR4aC3P7ESAyGpcmrOfMs7oXye/Zre3v6zbOksBzu4npEmfEH5qWj9wrR4o9jImADoI9MWU/B+XmHEUFxOTQbn5i6O+tbmLsivrva0tzl9CCeAfSAlcoG/XeHYhSZPT4DtqwaV9dzFAG9YIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ensLBHwlooAvgr45GOOUyswCZgis3giq9ERb3tOFYlE=;
 b=ALowrQ2q9pjwD/lhn3TzUOKi0BG7vdsbPQdqEnjK/lt7IGUk114Q1BP1XcGUxBFpXWlNEnOutktjMqZ1rfobRDAsrtxn0WsPrG9hmprEqSayhDYa4n09u/uf/F7Xx7RyMCjUu7FTqay1lCrEJBXciHkt/LL+PY0aUMPzO+62W8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6859.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:325::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:36:41 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:36:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:36:41 +0100
Message-Id: <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <gary@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260927144417.1280385-1-dakr@kernel.org>
In-Reply-To: <20260927144417.1280385-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a6f876-afcd-4524-cd19-08df1d54c438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|260925021911599003|260925022911599003|7136999003|6133799003|10067099003|260925021311599003|56012099006|18002099003|22082099003|11062099010;
X-Microsoft-Antispam-Message-Info: QYi5NtnhoI0/7j3T31IydFrktlaKnsaGDDP4CCYD3aFeAVOxwKTXXFX+hZZtlppE9Sgq+gRFEbGk6LKgcV+lTSOn/tSjkSWS+E4yYIj/8F3ZFk3eowFcnXiBWidXv8PdhQ092H4CPP+aVYZdnYbdFVn7CtHaeFxMy60kGmxmIVBtKDOC5twMPnkkI3+MgJEQwcLP+eANPKZBrdsiEPF+8Yj1CtHzI8jFN3W1NabBkFl33LnpFrmwfE6nGEepqP11LiSVpV0keK8i8G7plq6GZLRtedt4HMhKHxWILqJGuV/tiZ9KXUoMjeLWYSUHqJwz45gaT0cdZkR8UQ4KC/iC6nkVezj9Hh3qQWHDfmmDRMZzIZWm0xObJlRh48DxkcTdPTEOueF5AsIk7e6nD+Sokiff32bZQYktbnGvmYTYcWOxtvoOHsd/eLVLuZvtYJcjHc7N+7uif+KCopQwyuZf2Yf1Y5QBP03ayX8E9X0R5LWup7jBswmrYQlKncfZ+TgcYAf+JfdOg75thR2CAe/njvGkzXfifDlwklRhisBUd9pId96olqtHG+4MoQXKW1kndKbz9YgXW3yBPoxaD/+1j5TpBGMy+0uQYU2V9vNw4/hzmoW55YMSCEt25h/cpT3UWbz4OJrE4HDnXb213+Au3NLCuFvUp1Mi0BDzwZjEBzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(260925021911599003)(260925022911599003)(7136999003)(6133799003)(10067099003)(260925021311599003)(56012099006)(18002099003)(22082099003)(11062099010);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTduK0pLTE9Hbm1raTlYbkl1TStaMXF0L2k5UDh1ZjMrT0J1bnRQc2VjaGUv?=
 =?utf-8?B?amFlSVhGakkvb1lmVEV3L2VrTktiWEl2UVpXTUFyenNFWW5BUVlORmlCUGhZ?=
 =?utf-8?B?Q3phWWwwQlJXYk5JemN0T2hLMlVoSmRBK0taRXpIb0libC9UVGh1MU5rZlFp?=
 =?utf-8?B?eHJUVkpuaXpEQlJ0eS9HLzIxalF0cUxyYlhoZk5uUDRmRStQUVZMckY4aVZQ?=
 =?utf-8?B?d1JLb0o3T0htelNuS2x6OWk5aXdwcHJXeVhtZHAycXcwMnNoNU43cmIwcEF1?=
 =?utf-8?B?d09jOTJhVG10empVZS96QVMrdEp4bk5jdytMUmtLUUlSalUzSnREQzhmOEhO?=
 =?utf-8?B?SnRZdGpkNktxSkIwck9yS1BqNlNnTXc0bFduOVBTOW9wUDNMOHZDbW1wQjhQ?=
 =?utf-8?B?QnZZckxMNUNVVU9ORytMSnJBV2Z6UmF5bStQekVhTlRsczNJc0ZZVVZUUk5v?=
 =?utf-8?B?eTkwcHlaSGVZR1JkamxBN0t4UDd2L3pTYW4rc2Z0NlJZNjRpVklJZVNzeVhy?=
 =?utf-8?B?TWVnRjRoSXFRaDV4S25jcnU1bDRibTNIcHg4VVEzTytzV3NrRnRsejgra2JZ?=
 =?utf-8?B?OXV3RTVrSlJibjlyc3hOVTI3K0ZrcTFZUC9tWXBic1RWR3ZNeHQ5S3dLSzh4?=
 =?utf-8?B?UWNCMit4Z0s4aTBNOHp5TlZPOTZNSm96T3ZlQnFrdFJzMUdLRGdMQU12WHUw?=
 =?utf-8?B?R3g4S0JnNnY1KzhRZmI0b0VFUmg0WERGUkZqdzhHaEZEdEFpNTV3b3lmd2Ez?=
 =?utf-8?B?Qjc2c3ZDUFdnVko4cXp0em1SdGRENHFKZE0rc20reUZNL2FZSGhUc2pFUnVZ?=
 =?utf-8?B?L0MvZVpvVTI4QUorMTZaZzM4aGd5UFU4ZWpDZ1Q0S1F6UnoyZ2FaUUc2OWsr?=
 =?utf-8?B?c2Z0YytLMklHREphVHRRZEt1VHVKRC96em9Id3djUDAzeDQ0Qm1uT29sU0NI?=
 =?utf-8?B?SU4yaGZ6dUtVd2ozMmowQmlUTXAvVnI4Um5MTlQ3QUFXNml1aHAyc2R5T0ZL?=
 =?utf-8?B?RGRjVnZqc0xXeVZ5M0Z6aE8vRXozU1ozREpGL1NwZnczaFp2NDNnS0ptd3JN?=
 =?utf-8?B?UFFvakRPdzRDQng1a2FCSHdUWFMyWmRuNlBnQzZxN0ZSUnJJQVdKbmVGL3BV?=
 =?utf-8?B?bllRM1hheldNdlZYek9UajV6QnFxRmI0aTVQdGx6emtueFhKVDFOa1FDM0o4?=
 =?utf-8?B?MXIyRk9OQzhTWGR6V2RNNWFGUUVCTUY5S20rUThSSElPTllqUEhnZkdVaTQ3?=
 =?utf-8?B?UFVRSWJBbWdNNGZFUzF4VWpoVXVnWUloa0M2OU1YVW5wVUc5dWJnejVKN1NZ?=
 =?utf-8?B?OTd1Z0FjMlp4bmpZNXR3MEM3QTE4cWV0eWhQbkRvV0VNTWs4T3pjSWdWbE5h?=
 =?utf-8?B?cUw0cXpNOTJvWmZpcjBZOW8xdjhvaS84S2NEVU5ETXh5ODJkRlpWbkhERk5U?=
 =?utf-8?B?SUpUUXNIWTFRckw1TkFTMEVnRXhIMG5UdGhTRkxNaGgwblZ4ZFkwbllTbEdn?=
 =?utf-8?B?OUg0VFkzRTM2dEdLZHpGbEpmVVVPb1hCYjhvc0VDbGJ2dVE0NWdKbnliYnZG?=
 =?utf-8?B?cXo4Y3psd25aTWpDYW40N1FRUlNVKzNLU2ViaFU5cnVEYjFqbTE4UkhnQ0xT?=
 =?utf-8?B?dVpNQ1htUFVTUjZVTHpUYkdCSEZXV1k0ZnBuUTh5NWlqVExFbVpsME94cHdP?=
 =?utf-8?B?eUs2R2JPNzl1NE9EVm1DcFlXelFOUVd2dDZPeWVFMDJ0YTM4Z1JHRElnL3Jy?=
 =?utf-8?B?UFM4eWFtQUlnYThVcFE3V01FK1JGVVdtOHBGeElqMUJLaC91WUEzRUh5Yllm?=
 =?utf-8?B?TVhydUdlVHd5MVI0cGZhNDhKb280SkxqbnBwVkVkUThvTlE0NGduMEhBVXht?=
 =?utf-8?B?bi80bE9sSGtVT3BlUE1vUFZiMFlGZ0ltTEJqVE13bWZqTko2dFFxWE9rNWpP?=
 =?utf-8?B?QmtGOFcwRENEY2krUVFHK2RFNHJKS1ZFcmVKa01MVmpRNlpZZmsrWU1tWGl1?=
 =?utf-8?B?OGE0ZW9tSEk2VmlhL2ZSUlBNWDJCbi9KRENjWE03TUdmUjR1L2dVcnZpdkdl?=
 =?utf-8?B?eUx4ZGVYVzVsbW5PSzgwUEM4NHhLOVRhYy9RYW8vUE53VDd5dVNaYlhMSXpC?=
 =?utf-8?B?Q1RwbEx3YS9wcXdzRmVZc1lmMFZZWEdtOUdGSzdzNFlNR2Nmc0cyRlBqU0Zt?=
 =?utf-8?B?WENmSTIvdTVkbUNGb0d6blpSbTJJZVEyMUVwcEVJRzZQaDM5d1VzS28zNXEx?=
 =?utf-8?B?YXEzTWx2UW8yN0NWZlhRb2FhVWJEazRKQUxOMUZNSXpqYXZXM2xGMzdWVG9p?=
 =?utf-8?B?amxnMW0wVlIyekhQdTYrOU4wUXYyUkFFRis2WUdlZ3B4NlpTR2ZCdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a6f876-afcd-4524-cd19-08df1d54c438
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:36:41.7552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTG2gELanMFQGNS8XKWlQiax+9M+0tFgDVkjjcpAJsKOkwHQQZKYHfZ5UKnAF2K9weD+dZOYPPmbnRb1WKW1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6859
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

On Sun Sep 27, 2026 at 3:44 PM BST, Danilo Krummrich wrote:
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
> +
> +        try_pin_init!(NovaCore {
> +            _: {
> +                pdev.enable_device_mem()?;
> +                pdev.set_master();
> +            },
> +
> +            bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar=
0")?,
> +
> +            bar1: {
> +                let bar1_idx =3D bar1_resource_index(pdev)?;
> +                pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
> +            },
> +
> +            // TODO: Use self-referential pin-init syntax once available=
.
> +            gpu <- Gpu::new(
> +                pdev,
> +                // SAFETY: `bar` is initialized above, pinned, and outli=
ves `gpu`.
> +                unsafe { &*core::ptr::from_ref(bar) },
> +                // SAFETY: `bar1` is initialized above, pinned, and outl=
ives `gpu`.
> +                unsafe { &*core::ptr::from_ref(bar1) },
> +            ).pin_chain(|_gpu| {
> +                #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
> +                _gpu.run_selftests(pdev);
> +                Ok(())
> +            }),

I think this doesn't need to use `pin_chain`? You can do

    gpu <- ...,

    _: {
        #[cfg(...)]
        gpu.run_self_tests(pdev);
    }

I know this is pre-existing but given that you're tidying it up this might =
do as
well.

Best,
Gary

> +
> +            _reg: {
> +                // TODO: Use `&gpu` self-referential pin-init syntax onc=
e available.
> +                //
> +                // SAFETY: `gpu` is initialized before this expression i=
s evaluated
> +                // (`try_pin_init!()` initializes fields in initializer =
order), lives at
> +                // a pinned stable address, and is dropped after `_reg` =
(struct field
> +                // drop order).
> +                let gpu =3D unsafe {
> +                    Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref(=
).get_ref()))
> +                };
> +
> +                // SAFETY: `NovaCore` is dropped when the device is unbo=
und;
> +                // i.e. `mem::forget()` is never called on it.
> +                unsafe {
> +                    auxiliary::Registration::new_with_lt(
> +                        pdev.as_ref(),
> +                        c"nova-drm",
> +                        // TODO[XARR]: Use XArray or perhaps IDA for pro=
per ID
> +                        // allocation/recycling. For now, use a simple a=
tomic counter that
> +                        // never recycles IDs.
> +                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> +                        crate::MODULE_NAME,
> +                        NovaCoreApi { gpu, pdev },
> +                    )?
> +                }
> +            },
>          })
>      }
>  }
>
> base-commit: 10a6623a24a85708650efad7be15182289403cd7


