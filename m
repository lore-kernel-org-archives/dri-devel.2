Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD1C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7784810EB07;
	Mon, 14 Sep 2026 10:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="jIZ7wzXB";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AE110EB07
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx9ItE6GZV4nCJFJpPbaKLWq236NxDItvbcG4KCNt4em4JW6P68gzksdiAgVe+fgsZ52JKbLG7lDltlumffUS1KOcaqLn3v7jhX4yjoV0Hm13vfGa1wKfNKZpLR9aKs4P0uhx7+/XN4Evx2q2paJzJKa3AAQXh7ZYzNUDNiLEVzrxJXoJL7NFxAsj+WKRpew85kqmExb4CZ5o/w86B3h7RDr4BPxD0EYiuE78IovXUwdLDwYd0xwircA9ZPOkkaT90XXVE3HlOTQAsRe4XHxAvhUjqkzJlSz7wAYVw9Mpdwcobymsa0F+RKCC1qgSiS1US3RuLxQYuxd1a7q0TJRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9VLJp97/b4QW+Q1vQ/tpgXjKD2GiMQHvMiK4f75BpQ=;
 b=gRvyFnXd0BQZtcNfu3QSeyy3PXkQvTlQpknOh15vmUXSeU2+xMGQ/OTQVShRWOff6XQ0k2IAEnVNAq8jdl3/1SbbYtOto2Wxu3Dh8kX4vNFVGThcaP9h/tQRCS3Rmr2prMlIzgl4NXEgX5zK4q9DZSBQOKd0cHgyxBpSfo4+geupvz9guTzkEAH+fKYEaBI/hUH8hy3enOxpAsbPKP2w2yPPyrh15akjP0mNv49xvEAWC4OfJ+h4pnRsSRD3lYMCqXHxjL85JrZ7D+KLA4RCOCWFIU3DWUE9iGHin1gkpwpgfostQcnU9LwV8f23t2ZLsnfB6ES6m8FOEwft1to73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9VLJp97/b4QW+Q1vQ/tpgXjKD2GiMQHvMiK4f75BpQ=;
 b=jIZ7wzXB8EXDc5r3EW9kAoppQh/zji/d1Dj6ZzImiEYhywTMSxdcln+u+eR+VyrdBI2hJJFU50cUXJvEFGxApc0WokcFFP2SP59i+rqvHwbt5CD4EKdZKR1SKP+6lyrIZALNvxWeyWYzARYH4YBY/CPWQR5YifP+zVXOPU3uDCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB2777.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:15:31 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:15:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 11:15:30 +0100
Message-Id: <DLEYLN2TR8J3.36YPC0TEBVSAJ@garyguo.net>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] gpu: nova-core: move the debugfs root into the
 module data
From: "Gary Guo" <gary@garyguo.net>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>, <dakr@kernel.org>,
 <jhubbard@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
 <20260913183734.134307-2-vladazaharova2018@gmail.com>
In-Reply-To: <20260913183734.134307-2-vladazaharova2018@gmail.com>
X-ClientProxiedBy: DUZPR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB2777:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d5f10f-65f7-435b-8d2d-08df12491b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|23010399003|1800799024|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: vFaoqn9nfsyd79qqX3G/xQ1w/QY8WFEvfX1NykIb1PrTWbyZWZppLygs6GPOy4EC+9EowbDbYsvQUQDqibCM7drywL3HdYhcYVTkNBWmL+3mn1ef31BGdFecs4BdGHBilVUk06GdvVMUkWhCQK6nT8SEqFhHU+W7O4dUkV4a7SDaea/Z9Lb355k94BKEchI1op92WQXSIxeRRomF0YlGXQHXa4mKukfCvtQSt8k0z5KYF8b0cbXudds18i+YWYCGOOef9WFDf8UHjW0H4jGy2+dAcP9lmRvcj4MKlu27LO6+9WOVFIBxJ0XfyyV3MTgLwpgnDafAO1Ex1DGT9mg/rxTFZwRifaKI3/MGVajnScpEfFsPz7IkLTje5vrd+5yuGMuYwv5KLVLvBUoGWQJD+bEV2CSZzeDdVjxLmekgw8NJXDUUxVdIESXhMdWehqndXX5ntMwXEyKwqW4BEQeQkdKPETA09tGk7gI/6IST/wKgSynj2JMQMz0TqkZbiJyyTWL7GM/qfuS5yQN6q76v8Myk2tkDI8DR8HNd9gEPEaDvO23qFSvfxJ0UMwq5XznugBRtld+YX7IfhYQYhvAu9BDmOTmvC9CRkwHiKHXQJBk8bPrnM2En4RuWCaytQiYfPhZAu9x0187w/f8blyWx9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(23010399003)(1800799024)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2V0WGdncmhuamJyWW85akU1MXAzQUV5cC80ak5rM0U3UlczNC82TmR3V0M5?=
 =?utf-8?B?cDk1RFFvTThiMXJmME42KzFNS2Yzano1blNzMTBMSDlmOXFiYm1sOXEzaTZo?=
 =?utf-8?B?cDFSb1VRZ2Z5U2lxYko3dEtEUHUyUlhqdkhyVEVqWk1jMTdLWWdvZEUwOWZH?=
 =?utf-8?B?TmJsdHRLZFd0RnNHcFpFbmZoYVlpMm9sNHZrc21aMmNPZEVnb2RpTUpLaWFh?=
 =?utf-8?B?UHRxUFk2UzVOQXlTdWtFMVJnOXh4L3IxWENrNEQyOWwwekpLa3pVVGNBTndO?=
 =?utf-8?B?anh3YnB2Q3NiZFhuQnZBTG9GdWE3eHNZbTRFUm96VmtCNmR1UU9UZXFuTytk?=
 =?utf-8?B?dkZ5aUYydXMyZ1lCVmU5NVBDcWtPaldIZFQ3eUNaV1VUU2JpeURVTWljTEtN?=
 =?utf-8?B?bmUyYUthOXlqYmdJY1kzQmZiK242QVBpVjRsdGZDZ2pMbjB6U1Z4M2oyMVNY?=
 =?utf-8?B?bnJucEh5OENaMFhMdTVLU2haUy9tMHlvVUtYNWlBTm11cjU0UVBjM2dRUVlx?=
 =?utf-8?B?cHdHZjFSMFJocUJaTVRVb0hwSENKTVVVbUNWYlUrRUpvdmphd0NiQ3NGSHhC?=
 =?utf-8?B?TU5aMHVxeUh1RWlnRDhnTFREcUdtcWxNSkVpV1FlN0svMGtBQ0dnbko1UXBF?=
 =?utf-8?B?TmJpU3hxSk95K25teTEwbFdHbERZeUs5UnZsU1VxZ1h1aW53TjFzSWpFMHkz?=
 =?utf-8?B?L211TStKZ0pDQkRlK1FwcldOY3c2NWtPUzc2REo1Q0NhS0ppRXRpM0lBT1BJ?=
 =?utf-8?B?ZnNCc1N6Y2tNSjY0aVZlS1FLUGdrMUFXZkFyQ3gwcWwxb2R4bStoTUNzWmJp?=
 =?utf-8?B?ZXIrdXFuWjhhVTI3NGZ1R3VTa0ZZZWhwSitHemdpaHpYY2wwTnBRRCtrZEs4?=
 =?utf-8?B?Vmp0RmY1UFNsZHB0VTlqM2o2T3kyZCtmaUhYbWl2SFZod0JSNXFWUURIdlk5?=
 =?utf-8?B?dHU5QlJ1S1JEYkQvak13NE9INFFRdkhVTk90bXFXLzVvZ1RTczM3TUlPeFhr?=
 =?utf-8?B?elo3dG1CdGM3ei9tdExjUUN4Y0I3T1kyTlFhYXhBMVBFY2plQkIzd2RRQThC?=
 =?utf-8?B?bUIvQjRtVjdyN3hwU0tHVm84c0c0NXU0b0p1a2RqSDNFbHljcnJZOStqTXps?=
 =?utf-8?B?Y1hUaHB0dE81MEJBU1lXU2JJc2dqbjZhTzJBQUdiRys5UUFHVTBUN0Z4dUJZ?=
 =?utf-8?B?NUhoS21JckhQNjZJZnI1eFZZelMrUG1seW05ZUYya2s3dXdDNVllamZML2lq?=
 =?utf-8?B?QlViOFJGd2NHU2N2cExQZmRGYXdTN3ZjVnEwV2RqeEUyVjU0MnZ6clpBWWE2?=
 =?utf-8?B?clo3eThOMjRPRzRBMVJwelBNWFZTY1JoQW95SVpnQ1lPbmZGbXpBSUM3Y1di?=
 =?utf-8?B?S0RHci9QOTlhSHNlbGdnVUR5alB5TXJHY0g0WFo5VjFLYXJjRitnZnAwaXZu?=
 =?utf-8?B?R1h2NHJ6dkVlemZhM3doYzhxNlI1QkN4eWhFWHdOVksvWjRjbWdITmxtejlF?=
 =?utf-8?B?SHV4YVpQVjFab1dGYW8zTlV2Q2pnRlJBRTVKdzI0a2JoTzk2cStCYkZhUDRy?=
 =?utf-8?B?NG9GbldKcnZFbkRxcm1pY1lnL0NWWjJVRHppdlVTNVdTTVFYeERvT1prU3ds?=
 =?utf-8?B?R1k5RW1GcFpCeDBYYzg4WVBEUjR2Q3pKRmhXTXlQbVJZYUd3RHJJS3JZQi94?=
 =?utf-8?B?cDduRk5NZ2xaTmhhRjVNRUE4T1hYTEFUcnhCVmNoeUxWS2xGUk5nTGlHcnhj?=
 =?utf-8?B?YkROOGMxdFpmZmVPRUJyVkx4TnFQdmFkc09wZkZJdnFhRjBmZ01Jc0F4VDE5?=
 =?utf-8?B?RUZGd0ZXbDJaZktPNUhKSTA5M2creC80dFJWUEtLYVM5M2h3UVlTbERhOXE5?=
 =?utf-8?B?cWpSR1JKVmJlNk0wVDAvK2RIN3U2N01CcTdUaG44TjAzWE80cm8vK3p5SHF1?=
 =?utf-8?B?M240ZnBuWFE1ZEd5T0EzQlRRMXlIMVNzL0twVWErZng2Q001Q1IxMUxaaDl1?=
 =?utf-8?B?ejlKbHBFSjJPWno3Nm5qZFpYRFZneXlNSnFTMjM1V1pmWlpLcTJhc2IwOTdM?=
 =?utf-8?B?THYrU2kxUUdxbitMY2E4WGVFanhCeTV1VFNWVnF6Smtkd3pNUmt0bHNGOWF3?=
 =?utf-8?B?YithQkN3YzFxaEdhOW03NmN6ZkFMRVp6ZHR5T2drQW56dGE5WW9XTUlTYU5t?=
 =?utf-8?B?ZG52UHlZQm02L1NnazBzQXNXVjB4dHFWR1ZiTnZ0QURWSTJCMEd6TkswN1dw?=
 =?utf-8?B?cVEzNkRVSzI5TVNRcEhDVDRQcE44WjRCWlNyRnBlZ21ZRENnQWROSWlodnZL?=
 =?utf-8?B?VGU3MHNuTkt3NE15dDBGaHpOYmU0cmloRUdRcldJWUZCR1NOTUN1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d5f10f-65f7-435b-8d2d-08df12491b54
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:15:31.1744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xixYY9jNf3ZsR3N3ZxQ3ybwb/H9v7NVh0dRFIE2fdJkiCrj1SBCYwYCxbyMeBIJ9VW6CKbXUf8lOlxMAZ/Un/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2777
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

On Sun Sep 13, 2026 at 7:37 PM BST, Vladislav Zaharov wrote:
> The debugfs root lives in a static that init() fills in and a guard
> field of the module data clears again. That costs a `static mut`, an
> unsafe write on each side and a guard type whose only job is to undo
> the write.
>
> It also leaks. try_pin_init! drops only the fields it has already
> built, and the guard is written after the Registration, so a
> registration that fails leaves the guard unbuilt and the static set.
> Statics are never dropped, and the module is unloaded right away, so
> the directory outlives everything that could remove it. The next load
> then finds the name taken: debugfs_create_dir() returns -EEXIST, which
> Entry keeps as it would any other pointer, and the driver comes up with
> no debugfs at all until the machine is rebooted.
>
> Have the module data own a DebugfsData instead, built before the
> registration and dropped after it, and keep only a pointer to it in the
> static, for devices that have no other way to reach the data of their
> module. What is left is one unsafe read for the users and one write on
> each side, with no guard type. A registration that fails now drops the
> data that was built before it, and the directory goes with it.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
> ---
>  drivers/gpu/nova-core/gsp.rs       | 15 +++---
>  drivers/gpu/nova-core/nova_core.rs | 82 +++++++++++++++++++++++-------
>  2 files changed, 69 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index 1133c6ce5c55..0f8501c26e05 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -30,40 +30,84 @@
> =20
>  pub(crate) const MODULE_NAME: &core::ffi::CStr =3D <LocalModule as kerne=
l::ModuleMetadata>::NAME;
> =20
> -// TODO: Move this into per-module data once that exists.
> -static mut DEBUGFS_ROOT: Option<debugfs::Dir> =3D None;
> +/// Pointer to the [`DebugfsData`] the module owns.
> +///
> +/// A device has no way to reach the data of its module, so probe() goes=
 through here instead.
> +// TODO: Drop this once devices can reach the data of their module.
> +static mut DEBUGFS_DATA: *const DebugfsData =3D core::ptr::null();
>
> [snip]
>
> -impl Drop for DebugfsRootGuard {
> -    fn drop(&mut self) {
> -        // SAFETY: This guard is dropped after `_driver` (due to field o=
rder),
> -        // so the driver is unregistered and no probe() can be running.
> -        unsafe { DEBUGFS_ROOT =3D None };
> +#[pinned_drop]
> +impl PinnedDrop for DebugfsData {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: This runs after the registration is dropped, as the f=
ields of `NovaCoreModule`
> +        // are dropped in declaration order, so the driver is unregister=
ed and neither a probe()
> +        // nor the teardown of a device can be reading `DEBUGFS_DATA`.
> +        unsafe { DEBUGFS_DATA =3D core::ptr::null() };

I think we can drop this. If we're still accessing it after registration is
dropped and just before module unload, we have a bigger problem.

Dropping this would allow this pointer to be completely uncoupled of the st=
ruct
itself (it really is a module-level mechanism and not coupled to this type)=
.

>      }
>  }
> =20
> +/// Returns the data the module shares with its devices, or [`None`] if =
there is none yet.
> +///
> +/// Only ever call this while the driver is registered, which is to say =
from probe() or from the
> +/// teardown of a device that is bound: the data is built before the reg=
istration and dropped
> +/// after it, and nothing else keeps what is returned here alive.
> +pub(crate) fn debugfs_data() -> Option<&'static DebugfsData> {
> +    // SAFETY: `DEBUGFS_DATA` is written while the module data is initia=
lized, before the driver
> +    // is registered, and again when that data is dropped, after the dri=
ver is unregistered. Both
> +    // happen with no device bound, so a caller in probe() or in the tea=
rdown of a device cannot
> +    // race with either, and by the type invariant what it gets points a=
t live data that outlives
> +    // the device it is used from.
> +    unsafe { DEBUGFS_DATA.as_ref() }
> +}

The `'static` signature would be lying here. And also it is not ideal that =
this
returns a `Option`; the user would be always unwrapping it.

Instead, you can do this:

    pub(crate) fn debugfs_data<'a>(dev: &'a Device<Bound>) -> &'a DebugfsDa=
ta {
        // SAFETY: `_debugfs` field of module data is dropped after
        // registration. So it must be alive while a device is bound.
        unsafe { &*DEBUGFS_DATA }
    }

See? This way the `=3D null()` becomes truly redundant because we use lifet=
ime to
restrict how long that data can be accessed.

> +
>  #[pin_data]
>  struct NovaCoreModule {
> -    // Fields are dropped in declaration order, so `_driver` is dropped =
first,
> -    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
> +    // Fields are dropped in declaration order, so the registration goes=
 first and no probe() can
> +    // still be running once the shared data is torn down. `init()` buil=
ds them the other way
> +    // round, as the data has to be there before the first probe() reach=
es for it.
>      #[pin]
>      _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
> -    _debugfs_guard: DebugfsRootGuard,
> +    #[pin]
> +    _debugfs: DebugfsData,
>  }
> =20
>  impl InPlaceModule for NovaCoreModule {
>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, E=
rror> {
> -        let dir =3D debugfs::Dir::new(c"nova-core");
> -
> -        // SAFETY: We are the only driver code running during init, so t=
here
> -        // cannot be any concurrent access to `DEBUGFS_ROOT`.
> -        unsafe { DEBUGFS_ROOT =3D Some(dir) };
> -
>          try_pin_init!(Self {
> +            _debugfs <- DebugfsData::new(),

The pointer should be set here instead, not part of `DebugfsData`. `pin-ini=
t`
gives you initialized pointer of `_debugfs`. So something like (untested):

    _: {
        unsafe { DEBUGFS_DATA =3D _debugfs.get_ref(); }
    },

should work.

Best,
Gary

>              _driver <- Registration::new(MODULE_NAME, module),
> -            _debugfs_guard: DebugfsRootGuard,
>          })
>      }
>  }


