Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3F606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gfxstrand-net.20251104.gappssmtp.com header.i=@gfxstrand-net.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=q2W+XIG0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B1D10E1EA;
	Mon, 19 Oct 2026 22:08:43 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE7010E1EA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:08:37 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1320864eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792447716; cv=none;
 d=google.com; s=arc-20260327;
 b=VE8d7XwStY5oFNnyDxnuVJtox16AVzMCNuJYQfzZHFhgFJFzosoZlK1VLG+kzS14s+
 Kl9lLZnLNx4oVCEn0MfaJ0hLp+7eIDj3RnY+sHzvAW7+xeA+vNHeHD/nYB6xHf6qHY8I
 8OlCXisMIqxjNWqa+LBZQmsJhLYIKVuKa0a+pRCJ2Xkw+gqRNCXu2Q6Py5RY8n8PDi/7
 rVWBJVBQ5QkqsUAen9KPjyFnYMYJue5h/XwIg4isbeC1GPO4n57vA5mXdpw6l1GSiuOL
 mmBcJN6VbAHCpzXN5Sd/yNdQJcJzmxdwsN9jxxOnKL7qvYeMfmZz1D2V9BgYHa2lAK5s
 +uOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3DPcsrrlKcBIHFVOp6oadvhLVxLBnBkXH0jtrDtGcjo=;
 fh=hQow7+skhWouKcc1tCa59SayLyoZmh509RYgujYiQbU=;
 b=loqy2IRtEsPYmMK2NeWsOqD7xyTV17A7NhF1PSJMjjFlpfqfnU3nak7N7dRUv8bwa4
 DSLrWERZnFAqNJa4008Yx4sutIuj3sh2vGM708GgXna/pts6rJzcdk/KtLRvnZlZSJ1K
 0I0q9JpNjxPVRMDLyWWu+nXa8OJEiHmHbkEInKZV9plD8DQeCefAqvqMYyGUrA7ShE1L
 +lFFN2WyyrWeDVxAIDInIez2gdFyW7lq0NMJkCB85D10N9q1OVuP5K//GYmCIu+GtKBu
 +ufethd3X1cNG6tfxPBXxHEl9drABwuu8EU+j5GP05FgDGjjqIqJ4hk7Z+XL7hP1Tf4l
 GZTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gfxstrand-net.20251104.gappssmtp.com; s=20251104; t=1792447716; x=1793052516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3DPcsrrlKcBIHFVOp6oadvhLVxLBnBkXH0jtrDtGcjo=;
 b=q2W+XIG0ReREyPDbdENyV9ixHkjQAOlYU3oMdpr8o842WSDfQv6+b1Wk7GtyQQgpLF
 Ehko0/iWGYNhLzH0OSPYAFH9bNxmD1rvM4t4M5xZ7n8IR76fFsl/iCO5oRA+Nxm4y3jt
 yvKBveV+48B7D0Z362tOvuaI68taEb8jDs4nPz5N7wCTbCuvNsOIEzINuu06XuucE2LM
 poOlZokXKu9BOivQ1TVnu+nXgMvMz7wpyvzxBIqACCz6XHn0hSker3FKOhwV18M49zpu
 sikIl+wELzhjVaHvMIyWv1Dv9HbWRDJdDl60966ZGx6RSW05UpggyPVPPFDiExqpjYcT
 4qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792447716; x=1793052516;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3DPcsrrlKcBIHFVOp6oadvhLVxLBnBkXH0jtrDtGcjo=;
 b=jWu+XLaQk5LJI8z+kN5J3OIJvvTbb9DPBcyskWl90M0q65gJ1BnLCf+zsCc3O05VUY
 Zt8/Rnvfs8b49XSxjaD+inTlZCZWlu6lIZtVakBbPsazd9NtIRRzWohpvjIq9Tz39PBi
 taUbga28JewwHlYUNEspWh0Mtymk1F2THFSNCVm5bfLfI02B2cWtMgvRpk+Bb/tg4BuB
 9V3/tDBrAvV56s+vwiuP4bXiAE4YKts7Y5eFgahckqQ9AJ/LFEY431Jmzg/pW2q4c10K
 TuXmuMTKYsEfhde4cHW8+wk8YvF+X2yHCbdiNXFf+Hk25QTHfv6uSF/lLmavk7JpMgxQ
 O5vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeDqu4aDwQwKjy9ZU91bcAuBmMlr/E20nhGGRnXd72n3bZ81Ggx7tKO9H3AAS6AbRaiT4CdJ63+H8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJaYhHHZGtzELcBAGdSwHnZuTGtm1eYBGfs7rKialFj3ffkLdXH
 bcyCOS3UjmJ/Jn8XPWCb6vSxVA/8wb6ua8zqLiQmLgF4qNswuZ4T6mAjjVQXNn8GYHywEIW6c2i
 1F0cpA59rj4cMg8pw0hnn6f+n/6HB8FJpT0fmJXU+5w==
X-Gm-Gg: AYBFou0n8OrtAAHiG+OMLa9nPxrRsh2pjewFjI5su/Uvy+bAaLxBJsa5R0WIquCFVRc
 VVaBZBjar27rO5CEUBSBt/tqgZU3NC62LHmOyuH4HKP+cxB8W7lnHFsKuBOyNtvhuE8TMScSI0G
 6rQf8oJsIFCp7k7XX0p2EInTbBNue80YsOEJJLqvJTKdeXAr5F75c+HGPXSUCQj4w/cqFioFQQG
 ZVw7w2A0qnvq4BP7CRZspa5WpUNkxad87TTS2FFpBKRTggvim5F/RU/TFMHY8h6sQYqn8kC97Up
 YZrZo7LxO3Wp2TsilxKXb77oaOTKnTVaU9AbXBF5We/tZZo2Hc8J
X-Received: by 2002:a05:7022:f512:b0:16b:fa6d:b11f with SMTP id
 a92af1059eb24-1850ce9b5a2mr12535516c88.6.1792447716400; Mon, 19 Oct 2026
 15:08:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212535.88390-1-dakr@kernel.org>
 <20261019212535.88390-2-dakr@kernel.org>
In-Reply-To: <20261019212535.88390-2-dakr@kernel.org>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Mon, 19 Oct 2026 18:08:24 -0400
X-Gm-Features: AclHuK-qE8LmEGdwibwHGL6oFYAXR5b0DqizYeAXVyUgVX--Coo1a8MpQKVbO6Q
Message-ID: <CAOFGe95z69uc802-DWwhBqED9VB9ZSts2GL3UZ93frgOHc0akQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/nova: mark the uAPI header as unstable
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
 work@onurozkan.dev, jhubbard@nvidia.com, apopple@nvidia.com, 
 ecourtney@nvidia.com, lyude@redhat.com, kherbst@redhat.com, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 5:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> The header already documents that its uAPI is unstable and intended for
> development. It may change incompatibly as it is developed upstream.
> Rename it to nova_drm_unstable.h and move it out of include/uapi/ to
> make this more explicit.
>
> As individual interfaces become stable, move them to
> include/uapi/drm/nova_drm.h.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Faith Ekstrand <faith.ekstrand@collabora.com>

> ---
>  drivers/gpu/drm/nova/nova_drm_unstable.h | 212 +++++++++++++++++++++++
>  include/uapi/drm/nova_drm.h              | 204 +---------------------
>  rust/uapi/uapi_helper.h                  |   2 +
>  3 files changed, 217 insertions(+), 201 deletions(-)
>  create mode 100644 drivers/gpu/drm/nova/nova_drm_unstable.h
>
> diff --git a/drivers/gpu/drm/nova/nova_drm_unstable.h b/drivers/gpu/drm/n=
ova/nova_drm_unstable.h
> new file mode 100644
> index 000000000000..3577dede15a6
> --- /dev/null
> +++ b/drivers/gpu/drm/nova/nova_drm_unstable.h
> @@ -0,0 +1,212 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#ifndef __NOVA_DRM_UNSTABLE_H__
> +#define __NOVA_DRM_UNSTABLE_H__
> +
> +#include <drm/drm.h>
> +
> +/* DISCLAIMER: Do not use, this is not a stable uAPI.
> + *
> + * This uAPI serves only testing purposes as long as this driver is stil=
l in
> + * development. It is required to implement and test infrastructure whic=
h is
> + * upstreamed in the context of this driver. See also [1].
> + *
> + * The uAPI in this file may change incompatibly. Stable interfaces shou=
ld
> + * be moved to include/uapi/drm/nova_drm.h.
> + *
> + * [1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/
> + */
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +/**
> + * enum drm_nova_architecture - GPU architecture identifier
> + */
> +enum drm_nova_architecture {
> +       NOVA_DRM_ARCHITECTURE_TURING            =3D 0x16,
> +       NOVA_DRM_ARCHITECTURE_AMPERE            =3D 0x17,
> +       NOVA_DRM_ARCHITECTURE_HOPPER            =3D 0x18,
> +       NOVA_DRM_ARCHITECTURE_ADA               =3D 0x19,
> +       NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X   =3D 0x1a,
> +       NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X   =3D 0x1b,
> +};
> +
> +/**
> + * enum drm_nova_chipid - opaque GPU chip identifier
> + *
> + * These values identify the chip a GPU is based on. They are otherwise
> + * opaque: userspace must not assume the values carry any particular mea=
ning
> + * or encoding, only that they may be compared against this enum.
> + */
> +enum drm_nova_chipid {
> +       /* Turing */
> +       NOVA_DRM_CHIPID_TU102                   =3D 0x162,
> +       NOVA_DRM_CHIPID_TU104                   =3D 0x164,
> +       NOVA_DRM_CHIPID_TU106                   =3D 0x166,
> +       NOVA_DRM_CHIPID_TU117                   =3D 0x167,
> +       NOVA_DRM_CHIPID_TU116                   =3D 0x168,
> +       /* Ampere */
> +       NOVA_DRM_CHIPID_GA100                   =3D 0x170,
> +       NOVA_DRM_CHIPID_GA102                   =3D 0x172,
> +       NOVA_DRM_CHIPID_GA103                   =3D 0x173,
> +       NOVA_DRM_CHIPID_GA104                   =3D 0x174,
> +       NOVA_DRM_CHIPID_GA106                   =3D 0x176,
> +       NOVA_DRM_CHIPID_GA107                   =3D 0x177,
> +       /* Hopper */
> +       NOVA_DRM_CHIPID_GH100                   =3D 0x180,
> +       /* Ada */
> +       NOVA_DRM_CHIPID_AD102                   =3D 0x192,
> +       NOVA_DRM_CHIPID_AD103                   =3D 0x193,
> +       NOVA_DRM_CHIPID_AD104                   =3D 0x194,
> +       NOVA_DRM_CHIPID_AD106                   =3D 0x196,
> +       NOVA_DRM_CHIPID_AD107                   =3D 0x197,
> +       /* Blackwell GB10x */
> +       NOVA_DRM_CHIPID_GB100                   =3D 0x1a0,
> +       NOVA_DRM_CHIPID_GB102                   =3D 0x1a2,
> +       /* Blackwell GB20x */
> +       NOVA_DRM_CHIPID_GB202                   =3D 0x1b2,
> +       NOVA_DRM_CHIPID_GB203                   =3D 0x1b3,
> +       NOVA_DRM_CHIPID_GB205                   =3D 0x1b5,
> +       NOVA_DRM_CHIPID_GB206                   =3D 0x1b6,
> +       NOVA_DRM_CHIPID_GB207                   =3D 0x1b7,
> +};
> +
> +/**
> + * struct drm_nova_gem_create - create a new DRM GEM object
> + */
> +struct drm_nova_gem_create {
> +       /**
> +        * @handle: The handle of the new DRM GEM object.
> +        */
> +       __u32 handle;
> +
> +       /**
> +        * @pad: 32 bit padding, should be 0.
> +        */
> +       __u32 pad;
> +
> +       /**
> +        * @size: The size of the new DRM GEM object.
> +        */
> +       __u64 size;
> +};
> +
> +/**
> + * struct drm_nova_gem_info - query DRM GEM object metadata
> + */
> +struct drm_nova_gem_info {
> +       /**
> +        * @handle: The handle of the DRM GEM object to query.
> +        */
> +       __u32 handle;
> +
> +       /**
> +        * @pad: 32 bit padding, should be 0.
> +        */
> +       __u32 pad;
> +
> +       /**
> +        * @size: The size of the DRM GEM object.
> +        */
> +       __u64 size;
> +};
> +
> +/**
> + * struct drm_nova_info - query device information
> + */
> +struct drm_nova_info {
> +       /**
> +        * @id: The identifier of the information to query.
> +        */
> +       __u32 id;
> +
> +       /**
> +        * @size: The amount of space allocated by userspace at @data. Th=
e kernel
> +        * will return the number of bytes it wrote, or the size of the q=
ueried
> +        * information structure if @data is NULL.
> +        */
> +       __u32 size;
> +
> +       /**
> +        * @data: Pointer to the userspace buffer into which the queried
> +        * information will be written. May be NULL, in which case nothin=
g is
> +        * written and @size is set to the size of the information struct=
ure so
> +        * userspace can allocate a suitably sized buffer.
> +        */
> +       __u64 data;
> +};
> +
> +/**
> + * DRM_NOVA_INFO_GPU
> + *
> + * Query GPU information. The result is returned in a
> + * &struct drm_nova_info_gpu.
> + */
> +#define DRM_NOVA_INFO_GPU              0x00
> +
> +/**
> + * struct drm_nova_info_gpu - GPU information
> + */
> +struct drm_nova_info_gpu {
> +       /**
> +        * @architecture: GPU architecture identifier.
> +        *
> +        * See &enum drm_nova_architecture for currently known architectu=
res.
> +        */
> +       __u32 architecture;
> +
> +       /**
> +        * @chipid: Opaque GPU chip identifier.
> +        *
> +        * See &enum drm_nova_chipid for currently known chips.
> +        */
> +       __u32 chipid;
> +
> +       /**
> +        * @vram_size: Amount of usable FB, excluding GSP carveouts and p=
rotected
> +        * regions.
> +        */
> +       __u64 vram_size;
> +
> +       /**
> +        * @vram_bar_size: Size of the PCI BAR aperture used to access VR=
AM, in bytes.
> +        */
> +       __u64 vram_bar_size;
> +
> +       /**
> +        * @gpu_name: NUL-terminated full GPU name.
> +        */
> +       __u8 gpu_name[64];
> +
> +       /**
> +        * @gpu_short_name: NUL-terminated short GPU name.
> +        */
> +       __u8 gpu_short_name[64];
> +
> +       /**
> +        * @gpu_gid: 16-byte SHA-1 GPU identifier supplied by GSP-RM.
> +        */
> +       __u8 gpu_gid[16];
> +};
> +
> +#define DRM_NOVA_INFO                  0x00
> +#define DRM_NOVA_GEM_CREATE            0x01
> +#define DRM_NOVA_GEM_INFO              0x02
> +
> +/* Note: this is an enum so that it can be resolved by Rust bindgen. */
> +enum {
> +       DRM_IOCTL_NOVA_INFO             =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_INFO,
> +                                                  struct drm_nova_info),
> +       DRM_IOCTL_NOVA_GEM_CREATE       =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_GEM_CREATE,
> +                                                  struct drm_nova_gem_cr=
eate),
> +       DRM_IOCTL_NOVA_GEM_INFO         =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_GEM_INFO,
> +                                                  struct drm_nova_gem_in=
fo),
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* __NOVA_DRM_UNSTABLE_H__ */
> diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> index d7017ed17143..ad362301e3b1 100644
> --- a/include/uapi/drm/nova_drm.h
> +++ b/include/uapi/drm/nova_drm.h
> @@ -3,207 +3,9 @@
>  #ifndef __NOVA_DRM_H__
>  #define __NOVA_DRM_H__
>
> -#include "drm.h"
> -
> -/* DISCLAIMER: Do not use, this is not a stable uAPI.
> - *
> - * This uAPI serves only testing purposes as long as this driver is stil=
l in
> - * development. It is required to implement and test infrastructure whic=
h is
> - * upstreamed in the context of this driver. See also [1].
> - *
> - * [1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/=
#u
> - */
> -
> -#if defined(__cplusplus)
> -extern "C" {
> -#endif
> -
> -/**
> - * enum drm_nova_architecture - GPU architecture identifier
> - */
> -enum drm_nova_architecture {
> -       NOVA_DRM_ARCHITECTURE_TURING            =3D 0x16,
> -       NOVA_DRM_ARCHITECTURE_AMPERE            =3D 0x17,
> -       NOVA_DRM_ARCHITECTURE_HOPPER            =3D 0x18,
> -       NOVA_DRM_ARCHITECTURE_ADA               =3D 0x19,
> -       NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X   =3D 0x1a,
> -       NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X   =3D 0x1b,
> -};
> -
> -/**
> - * enum drm_nova_chipid - opaque GPU chip identifier
> - *
> - * These values identify the chip a GPU is based on. They are otherwise
> - * opaque: userspace must not assume the values carry any particular mea=
ning
> - * or encoding, only that they may be compared against this enum.
> - */
> -enum drm_nova_chipid {
> -       /* Turing */
> -       NOVA_DRM_CHIPID_TU102                   =3D 0x162,
> -       NOVA_DRM_CHIPID_TU104                   =3D 0x164,
> -       NOVA_DRM_CHIPID_TU106                   =3D 0x166,
> -       NOVA_DRM_CHIPID_TU117                   =3D 0x167,
> -       NOVA_DRM_CHIPID_TU116                   =3D 0x168,
> -       /* Ampere */
> -       NOVA_DRM_CHIPID_GA100                   =3D 0x170,
> -       NOVA_DRM_CHIPID_GA102                   =3D 0x172,
> -       NOVA_DRM_CHIPID_GA103                   =3D 0x173,
> -       NOVA_DRM_CHIPID_GA104                   =3D 0x174,
> -       NOVA_DRM_CHIPID_GA106                   =3D 0x176,
> -       NOVA_DRM_CHIPID_GA107                   =3D 0x177,
> -       /* Hopper */
> -       NOVA_DRM_CHIPID_GH100                   =3D 0x180,
> -       /* Ada */
> -       NOVA_DRM_CHIPID_AD102                   =3D 0x192,
> -       NOVA_DRM_CHIPID_AD103                   =3D 0x193,
> -       NOVA_DRM_CHIPID_AD104                   =3D 0x194,
> -       NOVA_DRM_CHIPID_AD106                   =3D 0x196,
> -       NOVA_DRM_CHIPID_AD107                   =3D 0x197,
> -       /* Blackwell GB10x */
> -       NOVA_DRM_CHIPID_GB100                   =3D 0x1a0,
> -       NOVA_DRM_CHIPID_GB102                   =3D 0x1a2,
> -       /* Blackwell GB20x */
> -       NOVA_DRM_CHIPID_GB202                   =3D 0x1b2,
> -       NOVA_DRM_CHIPID_GB203                   =3D 0x1b3,
> -       NOVA_DRM_CHIPID_GB205                   =3D 0x1b5,
> -       NOVA_DRM_CHIPID_GB206                   =3D 0x1b6,
> -       NOVA_DRM_CHIPID_GB207                   =3D 0x1b7,
> -};
> -
> -/**
> - * struct drm_nova_gem_create - create a new DRM GEM object
> - */
> -struct drm_nova_gem_create {
> -       /**
> -        * @handle: The handle of the new DRM GEM object.
> -        */
> -       __u32 handle;
> -
> -       /**
> -        * @pad: 32 bit padding, should be 0.
> -        */
> -       __u32 pad;
> -
> -       /**
> -        * @size: The size of the new DRM GEM object.
> -        */
> -       __u64 size;
> -};
> -
> -/**
> - * struct drm_nova_gem_info - query DRM GEM object metadata
> - */
> -struct drm_nova_gem_info {
> -       /**
> -        * @handle: The handle of the DRM GEM object to query.
> -        */
> -       __u32 handle;
> -
> -       /**
> -        * @pad: 32 bit padding, should be 0.
> -        */
> -       __u32 pad;
> -
> -       /**
> -        * @size: The size of the DRM GEM obejct.
> -        */
> -       __u64 size;
> -};
> -
> -/**
> - * struct drm_nova_info - query device information
> +/*
> + * Stable Nova uAPI. Interfaces should be moved here from
> + * drivers/gpu/drm/nova/nova_drm_unstable.h as they become stable.
>   */
> -struct drm_nova_info {
> -       /**
> -        * @id: The identifier of the information to query.
> -        */
> -       __u32 id;
> -
> -       /**
> -        * @size: The amount of space allocated by userspace at @data. Th=
e kernel
> -        * will return the number of bytes it wrote, or the size of the q=
ueried
> -        * information structure if @data is NULL.
> -        */
> -       __u32 size;
> -
> -       /**
> -        * @data: Pointer to the userspace buffer into which the queried
> -        * information will be written. May be NULL, in which case nothin=
g is
> -        * written and @size is set to the size of the information struct=
ure so
> -        * userspace can allocate a suitably sized buffer.
> -        */
> -       __u64 data;
> -};
> -
> -/**
> - * DRM_NOVA_INFO_GPU
> - *
> - * Query GPU information. The result is returned in a
> - * &struct drm_nova_info_gpu.
> - */
> -#define DRM_NOVA_INFO_GPU              0x00
> -
> -/**
> - * struct drm_nova_info_gpu - GPU information
> - */
> -struct drm_nova_info_gpu {
> -       /**
> -        * @architecture: GPU architecture identifier.
> -        *
> -        * See &enum drm_nova_architecture for currently known architectu=
res.
> -        */
> -       __u32 architecture;
> -
> -       /**
> -        * @chipid: Opaque GPU chip identifier.
> -        *
> -        * See &enum drm_nova_chipid for currently known chips.
> -        */
> -       __u32 chipid;
> -
> -       /**
> -        * @vram_size: Amount of usable FB, excluding GSP carveouts and p=
rotected
> -        * regions.
> -        */
> -       __u64 vram_size;
> -
> -       /**
> -        * @vram_bar_size: Size of the PCI BAR aperture used to access VR=
AM, in bytes.
> -        */
> -       __u64 vram_bar_size;
> -
> -       /**
> -        * @gpu_name: NUL-terminated full GPU name.
> -        */
> -       __u8 gpu_name[64];
> -
> -       /**
> -        * @gpu_short_name: NUL-terminated short GPU name.
> -        */
> -       __u8 gpu_short_name[64];
> -
> -       /**
> -        * @gpu_gid: 16-byte SHA-1 GPU identifier supplied by GSP-RM.
> -        */
> -       __u8 gpu_gid[16];
> -};
> -
> -#define DRM_NOVA_INFO                  0x00
> -#define DRM_NOVA_GEM_CREATE            0x01
> -#define DRM_NOVA_GEM_INFO              0x02
> -
> -/* Note: this is an enum so that it can be resolved by Rust bindgen. */
> -enum {
> -       DRM_IOCTL_NOVA_INFO             =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_INFO,
> -                                                  struct drm_nova_info),
> -       DRM_IOCTL_NOVA_GEM_CREATE       =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_GEM_CREATE,
> -                                                  struct drm_nova_gem_cr=
eate),
> -       DRM_IOCTL_NOVA_GEM_INFO         =3D DRM_IOWR(DRM_COMMAND_BASE + D=
RM_NOVA_GEM_INFO,
> -                                                  struct drm_nova_gem_in=
fo),
> -};
> -
> -#if defined(__cplusplus)
> -}
> -#endif
>
>  #endif /* __NOVA_DRM_H__ */
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> index 489748ef642c..44fb6203c0ad 100644
> --- a/rust/uapi/uapi_helper.h
> +++ b/rust/uapi/uapi_helper.h
> @@ -6,6 +6,8 @@
>   * Sorted alphabetically.
>   */
>
> +#include "../../drivers/gpu/drm/nova/nova_drm_unstable.h"
> +
>  #include <uapi/drm/drm.h>
>  #include <uapi/drm/nova_drm.h>
>  #include <uapi/drm/panthor_drm.h>
> --
> 2.56.0
>
