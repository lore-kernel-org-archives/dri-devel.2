Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=BfUl9h5r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FDA1124F3;
	Thu, 22 Oct 2026 11:09:05 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853FD1124FE
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayog2pDuLdB+6T1JozSOxeT7+RUG2lBZXLzcRZJaJ8ft5J8lkFrmnlYMA17E4TQW1LKLLQIN6FIC8zL0fynwZuh0Z7SjzjZ0zu4/csM4tAmAen7qCIoFRmFDxYHzpxuvS8G5ZQcitVnhvVRhZ+eyeue/XW5H+sX3BOSIA26Sbss1WPiRhtxgNxD2yLl+tLPGUy4f8z1ApKgNeTulpLQhTSS2VJ7q+PW+orb0EujaIey+dda1Gn+VXrdeFteOjzD6uPf+LXEl8ZzqNG6JFlFfTkNGrYih1JsSXT1beWbzXLBkSj2dLUYv382G47RS2pJxCCm/plmdHH1NOCWu5hT/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIKto4+F+SjzqPhm/ahhr6UKBUu6T1rxQEpd7KramGQ=;
 b=JefKBEGE4rCK3VqGuYOyGxHuN9Gn/uApDe+u9uxUUc25+a1gGUW7e/vXpcfDepXx3oRXRkw3cPOP9MCaQPm/GT7VPSIpr3yjPc50sVLzqGcZ1tW9KXYRlW6m8oqyx6y9iSqdbtE+vlS5oOvpBlj9WrkNnVDZaTQAyFbA30q1JaTX9q4L1oCgySz4nrqwq/e05tTdHv81wwTbBVvbVIRLfOPeK5SRG+jC04+baZCS8NI2S0ACUOOcoNTIcQ0znuvrdvqf+wy06EaZ061ADMfF3K7tQQkcpnV1noRDXGoP0cEi/BRbiDM1tAE0bl+nmmKmfeq+sMsXCA3Y5nGeZwRFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIKto4+F+SjzqPhm/ahhr6UKBUu6T1rxQEpd7KramGQ=;
 b=BfUl9h5r4C/f7pTvxEEOM/dRSL0m2k6NK4lxSAWKd8T6mgdXVBfdrp2GEsIs7RYh/Ulbrzi9oXFJxaegPL8gSbQzR5KSifUZwcaW5W64xnbyUGH2c5jhMrWLsCKFHqNAb3eYu4OqS4fW5LssJvDgjIXBHQjE3+GY0ZlH8MvnqBc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB6863.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:08:54 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:08:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 12:08:53 +0100
Message-Id: <DMBBJ7OF8PY7.2CDELE2RZZJZ8@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: add kernel taint abstraction
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <apopple@nvidia.com>,
 <ecourtney@nvidia.com>, <lyude@redhat.com>, <kherbst@redhat.com>
X-Mailer: aerc 0.22.0
References: <20261019212535.88390-1-dakr@kernel.org>
 <20261019212535.88390-3-dakr@kernel.org>
In-Reply-To: <20261019212535.88390-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0d3e90-29fe-4121-52ad-08df302cdbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|23010399003|366016|261021121427099003|921020|56012099006|261021135927099003|4143699003|261009223027099003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: JxKvlTQ5imWwV6ZfXLUwt6PVRy9OjLuVA42W0SSsKnsdUgOPhE5wSOMwJkKYrwN5453M7IL0tASfDlqOAUo7uhMqs43i4koUMY7TLYhSlTUIjJb+/2nJlzk04/O+6bYX1o/zIzAOjpbPRk5IfwT7a0s4Twr+a9GoDgiDUmUUIGTOJR6y3Cz/e5A5rKMJ5mRE++Sb6Snfn4txau4eWQy8tDJYxgcUPShLoWbpDrdIjWmY0rfW5Lpo4Puvb/KeA9kSAITb0/CMFmuYjzTyt2S3c20V37xogF5vzbvM86At7AFdhX6+jxKfHNulVtRRVdfzxiiGnmLY+Dvu5vAyDbq94+/EOKPuJaVja1fdJxftmKw3nlubp0amy9qsoqT+3mabXLUtK9qPzLCuz+czZAwXN4nJASM5eLrG6wofaEhdocRlBA6Ji5JmMrRHxoiEi8AmxZ1TaVT8RzCegzCzP7cvuoek4jid4xc7nGIfq/PNHMzOUZoMMM+mQLG4/S2gMmF6NkYc/S/2fqppegAIzWVckBrO0ITQk1Nd9AGn9EgUZhrpKhk+DLD0e1gEhhyez+Cx9PhD5fG1JbdQkGy5DiC1YOVElWd/d+gb9zFLjT+a6H5syFMokA+SbP7quo2a++bO7HTxlSuYjGnBPVaLraFbF/HQX9OaHN+FGD+s7Yivazw+j14elT0DYLAwmo0sWrhkTqCzWIq3w5lQoBJxRidwog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(23010399003)(366016)(261021121427099003)(921020)(56012099006)(261021135927099003)(4143699003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVpUHJsNmV4MHhJL2tnY21CTWV6dkU5ekNiNFNUL0JRMmdJQ3R2ZDNIRitT?=
 =?utf-8?B?YVhrM2VjeXllWjYxeWoyNjhLUXRJemJKUC9jMW50MTFpQWxFbnZHNGdyVkJ4?=
 =?utf-8?B?TVRIT3d6ZlBLM0xjS01OZDVFbFBBY1BGQTBza3R2Mkt1ODFyTDRHdm9sVjJn?=
 =?utf-8?B?cFBlOGFZRTlPNEJSS21GTUNDT0F0UzVUR0xhMmo4V3lmRjE5UllPNWVoNzBG?=
 =?utf-8?B?TGZyVFIrb21FUTJ6MnBlRWlRanZVdDA0UVE1UGI1VmljMk15SWJDb2hTMjFS?=
 =?utf-8?B?eFdWQzJTME53OWxJQlNuK2haUmkwR0lieTlzZDBkL3JxYnVJODVqZHRNRlZW?=
 =?utf-8?B?VVR5VGdUeVRhOUE4UTkvbWVhNStLUFR5S0dFM2VwaEI0M0J4SWEvMmNnZ09Y?=
 =?utf-8?B?Z2NiZjRzN3M3WDlVaS82NmFiT2UyR0hzd0FTVUhaeHBIaXV1bWtYVmhRWlhl?=
 =?utf-8?B?Vng1MzJNZ0hJVHllOTN4U0huV0N1MzM0VVpFbTFQOGpmSzlGeVh1T1NaMnZz?=
 =?utf-8?B?RWZDVWNWYm5nb1JmNTkyWDZ1NS8wR0FsVDh5eFFZempKOHJjdWZGMURoRW5j?=
 =?utf-8?B?VTFiZGRiRElnWGF1Ynl1TEpmaUUyQkgzczRqTFdoYWhqNFpkRVAxb1FyaVQx?=
 =?utf-8?B?WmhDNXduNUgrR21iSDZOVWlpczZlWUtQMUNFVjlxUEcreUFlTUdKUG4xVXpt?=
 =?utf-8?B?OW9rWkpqQkx6amswajJxYkU0MHVlR3FCcGVhSURNaTRVWFVyWUtxSmNJWTVt?=
 =?utf-8?B?Y0ZFd3VmdEtpNDVGTFFZOWdHZS9ndFdFL3JQYnE4bHlWRUFpK1ZYMVJMT0xG?=
 =?utf-8?B?a0czOTE0UVhJM1ZmaGFSejFRaFVIbm5PYnJVQTFWVVVzT2QreGpqSlpFUHho?=
 =?utf-8?B?TmU3ZTNrNmRLY2ZxS3owTExWSURYUlJHeTE2UDU2VWx1N1hkVVZzZ2NURjlG?=
 =?utf-8?B?OXp0Rk1YQVQzWnFDTGNyZUVzL2d5NXNnSW40UFUyWlR6Y0o5aWMyWTVxMHRD?=
 =?utf-8?B?aFFWalk0VVRsdzA2T2RjTmVTVmJ0dHliaVAwWmp1VHBrR2JXZWNMTWl0b2Fq?=
 =?utf-8?B?ckF1Q2VMeGw4UFVMMXo1N042VllEcDlxREhleFphOUp5MWs3WGhIeFVmWHd6?=
 =?utf-8?B?UC9iTHcvQXRRd21nRlR2aDJLNlk2TnJITjd5RExNVkZIcG56VVVjTVRHMG80?=
 =?utf-8?B?a2VWeDlkSzk1MTQ5bWtlN3Z4Nzg1VWxrdTRvQkpaUThPU0JhWGd2WmNaS1Rp?=
 =?utf-8?B?a1B0NG9EWU5aZ1Jqa0Vkc2Urd0VUUEl1c1JyN0RsNnJvRDAzM0dnTzdvNVR2?=
 =?utf-8?B?Vm9wT3ZFZVhmZkEyUEZDSGk1TFRQVXFselZMWEE4U2RJQldkeGx2cmt0L1BK?=
 =?utf-8?B?cHdhbjhxYWFPbXVHZ01HWlFud2lHRXZCZUFTbk5YeE5vTWh6d0xiejcramFF?=
 =?utf-8?B?T242YjNBajhpTUM2Q2dNaUl1bjNKRTNING11cUUwcUFoSnhSc0dNa0NoNUpo?=
 =?utf-8?B?ZXRpRGpleGtyTURRQUl4UGk2TnlObzFFS0lFODAwY1ZQemxSN2d5Q1Qyd2Fi?=
 =?utf-8?B?cW1QdEp6b0dnNGJaM2wrZkk3SzVnRWk4YlBJcDNrNitSMXN6UkhnclUvblBC?=
 =?utf-8?B?dThORUpyWGZ5RW1xWnJHeHRnS1pWYmNnelZ1LzYveFdzTEVjRnhFaElqdFVU?=
 =?utf-8?B?WGloTnlpU1V6azF3d25HVGh3MDFEd0VnUWc5WWI1ci85Qml1ZTF5bEUweGhp?=
 =?utf-8?B?N3Q2RkMrZ2ZvMEYxYjdDVzFINDMzK2FrdUZ2MzJVcjl0L3dmV2NwQVV5aUc2?=
 =?utf-8?B?NkFkUmVmVlZtazV5bllDQUNkaXk3SFJiVnZZMWpRZldoUjMzLytrUXdkSlA0?=
 =?utf-8?B?bkxuWnV0NktJSnBpM3hpYzJ1cFdDaXFqaWV1dDJuWkhTb09VaG43SWxxTXh6?=
 =?utf-8?B?dG9XWGg2bG42UFFYWHdRQkFaMnBaZ1lqam1jbVZ1U1dPaHBFZlB6d2ZESjFD?=
 =?utf-8?B?WTgrVGtyNm5oaEhNekRXMWNSeE5RR0VuQU56Unl3dWlTRTNLb3RuQWlVV3N6?=
 =?utf-8?B?QU9KTnc3S202SVMvUFRhRWs2Z2d3K205T1B1Q09rSzYyNU9YWVR0M3ViaGJr?=
 =?utf-8?B?cmo5VUlwU205RUt6K1JtbFdiNTF6Z3JSUVFOY2ZkNzZET2Rqd3VyRUpLR3E2?=
 =?utf-8?B?RExhamhZTXhvUTI3VkxPQXpnTHZwNFhGa3Izc2FFNGpQQ1I4S05VdmR3MTlo?=
 =?utf-8?B?TGo2MW8rbGgrWkY3QTZvdGJkU09hcVFQekxHaUFqMy9sZ0hrOXkzc1ZVNVZ5?=
 =?utf-8?B?UmhvYm5WWXhvK2hLaERqL1Q3TThrcW44RTgweFNRMzVMWEFSbzU2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0d3e90-29fe-4121-52ad-08df302cdbff
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:08:53.8906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlXtKfCsespQWm/wRdouS/gbaKdF4k0RL1BPxYi1AMd+M8nYPt0qNfZkLRjb7DU61xTHYMlFE6RPusePGg2gBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6863
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 19, 2026 at 10:24 PM BST, Danilo Krummrich wrote:
> Allow Rust code to taint the kernel to record conditions that may be
> relevant when diagnosing subsequent kernel failures.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/panic.rs            | 50 +++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 rust/kernel/panic.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 930e63290cdd..bc248918c99b 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -74,6 +74,7 @@
>  #include <linux/mm.h>
>  #include <linux/miscdevice.h>
>  #include <linux/of_device.h>
> +#include <linux/panic.h>
>  #include <linux/pci.h>
>  #include <linux/phy.h>
>  #include <linux/pid_namespace.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f9ef36217bb5..fd8fe9373401 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -112,6 +112,7 @@
>  #[cfg(CONFIG_PM_OPP)]
>  pub mod opp;
>  pub mod page;
> +pub mod panic;
>  #[cfg(CONFIG_PCI)]
>  pub mod pci;
>  pub mod pid_namespace;
> diff --git a/rust/kernel/panic.rs b/rust/kernel/panic.rs
> new file mode 100644
> index 000000000000..8a78591dfb8a
> --- /dev/null
> +++ b/rust/kernel/panic.rs
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel taint tracking.
> +//!
> +//! C header: [`include/linux/panic.h`](srctree/include/linux/panic.h)
> +//!
> +//! See the [tainted-kernels documentation] for the meaning of each tain=
t.
> +//!
> +//! [tainted-kernels documentation]: srctree/Documentation/admin-guide/t=
ainted-kernels.rst
> +
> +/// A reason for tainting the kernel.
> +#[derive(Clone, Copy, Debug, Eq, PartialEq)]
> +#[repr(u32)]
> +pub enum Taint {
> +    /// Tainting was explicitly requested by the user.
> +    User =3D bindings::TAINT_USER,
> +}
> +
> +impl Taint {
> +    #[inline]
> +    const fn as_raw(self) -> u32 {
> +        self as u32
> +    }
> +}
> +
> +/// Whether lock debugging remains reliable after a tainting event.
> +#[derive(Clone, Copy, Debug, Eq, PartialEq)]
> +#[repr(u32)]
> +pub enum Lockdep {

The plain "Lockdep" is too confusing I think. I think sticking to the C enu=
m
name `LockdepOk` would better.

Alternatively, we can consider just calling it `TaintFlags`?

    struct TaintFlags { ... }

    TaintFlags::lockdep_still_okay()
    TaintFlags::lockdep_now_unreliable()

Best,
Gary

> +    /// Keep lock debugging enabled.
> +    StillOk =3D bindings::lockdep_ok_LOCKDEP_STILL_OK,
> +}
> +
> +impl Lockdep {
> +    #[inline]
> +    const fn as_raw(self) -> bindings::lockdep_ok {
> +        self as u32
> +    }
> +}
> +
> +/// Adds a kernel taint flag.
> +///
> +/// Taint flags persist until reboot, even if the module that set them i=
s unloaded.
> +/// Use [`Lockdep::StillOk`] when the tainting event does not compromise=
 lock debugging.
> +/// This may panic if the kernel's `panic_on_taint` setting matches a se=
t taint flag.
> +#[inline]
> +pub fn add_taint(flag: Taint, lockdep: Lockdep) {
> +    // SAFETY: `Taint` and `Lockdep` restrict both arguments to valid C =
API values.
> +    unsafe { bindings::add_taint(flag.as_raw(), lockdep.as_raw()) };
> +}


