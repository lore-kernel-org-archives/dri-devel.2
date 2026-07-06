Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26951C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3372310EA38;
	Mon,  6 Jul 2026 18:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZVG5UHda";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567AC10EA38
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:17:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07B8843D3B;
 Mon,  6 Jul 2026 18:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9349F1F000E9;
 Mon,  6 Jul 2026 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783361820;
 bh=93KArN1LqKTGY4T4BrpyuyWZ4ZD/QeNQn4N6asorlBU=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=ZVG5UHdaMVsLnpvJBAxJU1I8fsdezqMsaLNg/QQWX6K9QgQAThV0CvKIHZN9qC0E+
 tJQkHnR6YxPN6p1AlkbVK2YaJPTlfa4Kxx8V9/Z3RLBhXuwA1roKSCxCIEWupTQ74E
 jxY/NjUAWdmsDbx6E18tsA9GuEZrHxYDUKACNWbnySkonegoWO1yh4gFbxnTzyPH2r
 wzDO7S4utW4j/F/pQM6M4rLjcNJMwDSQnHZo66Amwc3/L404ng/og4vynksNxp4a3+
 0a9J0UU07X0Uo9abSNpcC5GgO4UFi/Z0+O8XtwWJJdTAWCZOitmZoQWnjff+Uz8BLW
 fFbtWU8/oud4Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:16:56 +0200
Message-Id: <DJRP04MWOO7Q.3DD6YF37RS5K2@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
In-Reply-To: <20260706053413.154135-4-apopple@nvidia.com>
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

On Mon Jul 6, 2026 at 7:34 AM CEST, Alistair Popple wrote:
> @@ -31,7 +31,6 @@ pub(crate) struct Nova<'bound> {
> =20
>  /// DRM registration data, accessible from ioctl handlers via the regist=
ration guard.
>  pub(crate) struct DrmRegData<'bound> {
> -    #[allow(dead_code)]

Forgot to mention that in the previous patch, please use expect instead.

> @@ -12,11 +12,11 @@
>      types::CovariantForLt, //
>  };
> =20
> +use crate::gpu::Chipset;
>  use crate::gpu::Gpu;

Vertical import style.

> @@ -25,6 +25,13 @@ extern "C" {
>   */
>  #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
> =20
> +/*
> + * NOVA_GETPARAM_GPU_CHIPSET
> + *
> + * Query the GPU chipset architecture/implementation.
> + */
> +#define NOVA_GETPARAM_GPU_CHIPSET	0x2

We could provide an enum for the chipset values and use it in the definitio=
n of
nova-core's Chipset type, which guarantees a single source of truth.

	define_chipset!({
	    TU102 =3D uapi::NOVA_CHIPSET_TU102,
	    TU104 =3D uapi::NOVA_CHIPSET_TU104,
	    // ...
	});
