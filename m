Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC146C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0138A10E917;
	Mon, 31 Aug 2026 14:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bMoStvfv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945B310E917
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:33:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58FDB40655;
 Mon, 31 Aug 2026 14:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B011C1F000E9;
 Mon, 31 Aug 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186824;
 bh=ZL5bFu7CsTNzqvus3MEa0m6EG4X7lg8HsHo2/a5DEMQ=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=bMoStvfvvwN006vdgROgnRCHVv5olC01N//krxZXlxBtjZ7hc7zAOU0H96VgzAYhu
 Obh0HeH6W2ufSd2LuhWYA7aJU0JL4OYJeFOiWPCYnYUP8blGdS0fJ5rIu0H+YFf5dc
 aXAgoGsZYrEA3r4o+QnuZ/1MpcDijZd+UzhaKTFtZ/wUlFP61NzunD3pjPyzIZwALj
 qqzAEVKLn/WQh+qwM8vn4vD5k954/rlJx1uxjeDFFqwJN9LR5wp8yumC+mNO1JBAEe
 BchC3FAatMdskNmzumUMnYcKRo7tS6FW2sSQRju/pNkYMRc9gJRtr7s91Qlq6gfXfD
 wDqolbfbwZLog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 16:33:40 +0200
Message-Id: <DL37BOJC2I73.1BK0RELPBUPY2@kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 09/11] drm: nova: Report GPU name in GPU info
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-10-apopple@nvidia.com>
In-Reply-To: <20260828033531.1117754-10-apopple@nvidia.com>
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

On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
>  impl NovaCoreApi<'_> {
> +    /// Returns the NUL-terminated full GPU name supplied by GSP-RM.
> +    pub fn gpu_name(&self) -> [u8; 64] {

I don't really like that we have two separate accessors for this, can't we =
just
use the one we already have, which also does all the validation already?

The constructor of GpuInfo could look like this:

	fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
	    let mut info =3D uapi::drm_nova_gpu_info {
	        architecture: reg_data.api.architecture(),
	        implementation: reg_data.api.implementation(),
	        ..Default::default()
	    };
	    let bytes =3D reg_data.api.gpu_name()?.as_bytes();
	    info.gpu_name[..bytes.len()].copy_from_slice(bytes);
	    Ok(Self(info))
	}

Could also be infallible if we want to go with a fallback name, given that =
we
consider the firmware not providing something useful as non-fatal so far.

> +        *self.gpu.gsp_static_info.gpu_name_bytes()
> +    }
> +
>      /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registe=
red
>      /// by nova-core.
>      pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreAp=
i<'_>>> {
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index 6453184af55b..b8dc64808620 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -251,6 +251,11 @@ pub(crate) enum GpuNameError {
>  }
> =20
>  impl GetGspStaticInfoReply {
> +    /// Returns the full GPU name as a NUL-terminated byte string.
> +    pub(crate) fn gpu_name_bytes(&self) -> &[u8; 64] {
> +        &self.gpu_name
> +    }

AFAICS there's nothing ensuring that this is actually NULL terminated? The
existing gpu_name() method already does this.
