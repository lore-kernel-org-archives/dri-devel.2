Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8PZYMun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B36C10E80B;
	Wed, 18 Nov 2026 16:17:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF00210E81F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:17:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDEB66281E;
 Wed, 18 Nov 2026 16:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF10D1F000C5;
 Wed, 18 Nov 2026 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795018666;
 bh=I3euMsr0R3jsztb6tBx9FVmWbLkOv+l5VRxL2+eRjeE=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=f8PZYMunuilXaJTcx8ZrhLeWaXNaLQTyX35hbHY7pCCKA2Twh6JKaXBTb664lnEtK
 WZiRgXI5eYvyj6uEQS3ldceWXYXAB8DXU4dLpF1lw/VrmuqJfil64tbS/Tdjhk3iQm
 GDrk4Nqxl/xyO6Rfq/VXvCezB57ny7QdymCvlgWXvxd1z4ZoZlXQf+I0LRDGPvbMhP
 GagWO7vKstIVbcPAgEGfo9W8Ty4P2jKHP8oAZCiFG6IDK9XntLugEV48XLpuRqVTjv
 x6CvGQ21JzXWXxt6tZ1AmfJlNIfu8ODWussVNXSZwuJZCaC0chRrECTwuFUSa6h1ct
 0YeX5gjxMt/Jw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 17:17:41 +0100
Message-Id: <DMYH0CXPUTMP.J3AKN619TL34@kernel.org>
To: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: drm: ioctl: fix call to unsafe function
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Asahi Lina" <lina+kernel@asahilina.net>, "Lyude
 Paul" <lyude@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261118133232.48603-1-vishal.moola@gmail.com>
In-Reply-To: <20261118133232.48603-1-vishal.moola@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 18, 2026 at 2:32 PM CET, Vishal Moola (Fractile) wrote:
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 64af9eacc306..5a2e2f4f0e91 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -152,7 +152,7 @@ macro_rules! declare_drm_ioctls {
>                              // dev/file match the current driver these i=
octls are being declared
>                              // for, and it's not clear how to enforce th=
is within the type system.
>                              let dev: &$crate::drm::device::Device<_, $cr=
ate::drm::Ioctl> =3D
> -                                $crate::drm::device::Device::from_raw(ra=
w_dev);
> +                                unsafe { $crate::drm::device::Device::fr=
om_raw(raw_dev) };

I remember there has been at least one compiler version in the supported ra=
nge
that complained when the safety comment isn't directly above the unsafe blo=
ck.
Has this been fixed in the meantime?
