Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5E3C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D2310EA29;
	Mon,  6 Jul 2026 18:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T52Otafp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CF210EA32
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:01:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18E79600C3;
 Mon,  6 Jul 2026 18:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF21F000E9;
 Mon,  6 Jul 2026 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783360874;
 bh=6rBZf4+GxWCnL6lksT5Jo1d6nii+Ri7wOm4ClVQQA2E=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=T52OtafpclOFU4htSze6fYPynLauHBze8Ttb6LKkdmwwX1AlNLlSsMlNB/w3OILbX
 tOjOOCGYSn3ogge8mHqjS1s6YKe9HVO4kXybDGb8JwnKcU/WopUybpHLIuFQ1VK3VD
 MWgHSkrQNGqgQ+KZPoqWjnwtkuG2xIl1N15gF9SyDNJg3Db65eZ4LVXOtpURug2X5c
 hr+ynrKjPQbe7fgEN1qPuXirl8V5kR4oq6E3CJ4To3DWogJpgE39CC+JAxb/1YkL43
 cAxjUv3481Fk5UMwNIsFbNGsjAZuBONjGQS28b/K+dWpgtnU91augxTfAq6t0FRI/5
 Ze8iCZk6fiqEQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:01:10 +0200
Message-Id: <DJROO2091YJ9.2O9BMST1L8HQX@kernel.org>
Subject: Re: [PATCH 2/4] gpu: nova: Add DRM registration data
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-3-apopple@nvidia.com>
In-Reply-To: <20260706053413.154135-3-apopple@nvidia.com>
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
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 298c02bacb4b..855b6ffe696f 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -1,11 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -use crate::driver::{NovaDevice, NovaDriver};
> +use crate::driver::{DrmRegData, NovaDevice, NovaDriver};

Please switch to vertical import style.

>  use crate::gem::NovaObject;
>  use kernel::{
>      alloc::flags::*,
>      auxiliary,
> -    device::Bound,
>      drm::{
>          self,
>          gem::BaseObject,
> @@ -30,12 +29,12 @@ impl File {
>      /// IOCTL: get_param: Query GPU / driver metadata.
>      pub(crate) fn get_param(
>          dev: &NovaDevice<Registered>,
> -        _reg_data: &(),
> +        _reg_data: &DrmRegData<'_>,
>          getparam: &mut uapi::drm_nova_getparam,
>          _file: &drm::File<File>,
>      ) -> Result<u32> {
> -        let adev: &auxiliary::Device<Bound> =3D dev.as_ref();
> -        let pdev: &pci::Device<Bound> =3D adev.parent().try_into()?;
> +        let adev: &auxiliary::Device<_> =3D dev.as_ref();
> +        let pdev: &pci::Device<_> =3D adev.parent().try_into()?;

Nothing for this patch, but now that we can call into nova-core we can obta=
in
the information from the pci::Device via NovaCoreApi.

The advantage is that NovaCoreApi can store the pci::Device<Bound> from
nova-core directly, i.e. we get rid of the try_into() dance to obtain the
correct parent device type.

Subsequently, we can remove this TryInto impl entirely. :)
