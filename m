Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78B606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W2Iwltt9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC7010F095;
	Mon, 26 Oct 2026 18:26:05 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235B410E39F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:25:59 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-33bb5afa736so529941eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039158; cv=none;
 d=google.com; s=arc-20260327;
 b=DmQK8TaP29Jl+NtcSTd8QklhWwqh/gy5Wt8d2huH2iVRrR002YNLOgwp69BzmhaUx0
 re8trGc63Ha0c5mBfNb5+evdv1qm9SSVWQbWw+FsVDsijHzg/cfaWowNi6Z4w9cyiG41
 hKsp3nSIl8+ggFG8e+1s/JI5Wpt6GuOU44asYs8ODuCthNVYN2XHwHzBu5vAHkclvh+5
 SZvgBysXTfs02IqbkuFMuhymnEoU4VZmRXd9AyJu6DejsdJhcLj0PG1lWFlkh9QFuAL/
 9ROSmqfWkA//eJiF02l9cxrgxChDZOsNJa8XBiJydXYl1Oph6ifcjmigJPNvgJJNHPws
 MxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
 fh=xi40GYgnbjaAuGfsFPezbzqpgLvJldcT+2t8mnPiihI=;
 b=edVX2bxiGphMS/5IGLwGCx24WphgMjL7jiIiRhn5k70Xn0CZlnNp/8DMhD6KAi3DuI
 L2hyRHWae/vye6YvLrjFYfNukW+g/+uoQfh/W1yPNtWS6cpKvxgxCkFLUKnCQw3ZyfB1
 0JQsmITiJ6ngXMgq7nBqCi1BuXHcpJfscrv0t5C4pQAvwLbonpVgVA3dDE1BjUxGOAk3
 6WMMCGxn/rMWS8UgA2qs+5akDzKR2fQB8W+zV+Q6yURjNvrDnJ6o3UDLMkN0i0rXXz3b
 1RUnem8Goobtyte/4MwyVp0mr5i0Woq+fYfVnndYxckWyEtnMS02wXt3gdbaqqYjhHAV
 aQFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793039158; x=1793643958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
 b=W2Iwltt9vQ3lan/Un9edabuxkweHXx94/tBAqkDfYXcVATvlzv6XOOoGcTfbx+Ud8i
 8OS7U7oaMC34lxqQ+BfEyEMyz9EGi/HSAckEun8RLS571l5fUbZPy1ZYW6SKdKeMTvMO
 2xnaTFsPs9R7bofHsr21eDl54iyw1RHZDhlSTS2c3MmSI8GX/kQfpDjd2Muv7BV9qlbF
 QE0cyQ2BugSq8X3dBAmQt902tJqjs0WVnV24qJmTZV0oh2b+d+Q2oCTcZEs0GNFWFm8B
 I7bHWsIcV4vlVdUya9QiTjZPmxvEW/tHn5sEurdo994xF89Pnf1SLqzx2/ohUPMnD9Ah
 lCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039158; x=1793643958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
 b=ozz/NelpwVnDkGraY73ysPUTHCgRGcQ4yN8nalYxnBtrHm4Gg07ZdnKnZbMqsk+Mn1
 eHU8DYaKs4pkHc4Kqdc/L8H8bZUdAxoGJLqPHZgrTmDHmEagjMIk9AEVD0GVSVq9GY6u
 aW86jRI/ZwoGsdW3S608cgYHoXpJF8TcMTbov+5fjcMT5Q3o2Er1nG4qBawYxxFrmN1F
 T+k2wr7jCgdvnG2icg9MtMGVrzuH8NA46xAoMtxJ3f0Lj3pfAZP5G4wV8JLiPzdc1D7T
 WL7cfpUIpq9y2wha+JN4Sl33Jc/gYOEJwsvRO/GaX8EvBcOzMsnFmrebNQ2HpOz9030y
 Wzug==
X-Forwarded-Encrypted: i=1;
 AKwUvByheWN+pQwZrXmeodqCS/IhWUBRVpRaLxXsq6iM/bEUvy8LCDHcKcgYBZUxAqlHrLq72r/hg/JT/h0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKImT648CxpE4LL3YuybVLqpgM611uDCe1fqSZSjyi2FcUzlJAA
 6N4jBSKpSIaTM7TPg5Eyt79IhAcz1HtzO6rJHTaNtR3COLopljgp1EUNbfCf1mhbJPKAvQy07lM
 mP8awRbAQ2j9YgQOf/4xlQ40a3op2I3g=
X-Gm-Gg: AYBFou3O1ABeIE5d/hNXwj7URV92GIWJmI5cNJAKgCuNxI1JzJtwyQ+LG6Pa3deJWhS
 MpvFH4pf6rufCTF+88ayVUfn07B9aqOAU7gYlug9LZXnFZYhM6SMz7l4m+b08W2lzbyE/j4ScGL
 d1IOQTlGznFvaKrVBzcu6fxfyR2CE9K1UG2v+ZvWgsfCbz/+0VqfPw/R8z4qrjyB0tA8SJ4hftm
 M5d7zM3OdRdgdAHdB0RzaAGYgjuJFZ5lHG5e96bTnPcZo4tZoE0R2O7orR51eK+f/mVrRgFZFRn
 DSYb0HmHVZG7B7L0D+Xl5+kpiol7zHfGlUIcNVOnLacgKpH0F4+V7sZHbL1ikp2ODTXjEMG3NCV
 to3APMcnN8B7aa1EWGNqKOMUROpYTiBhfYZmgnhB2JRWyRb0kU7WkMkGa61+L7GlSS8gxUNIq5h
 IjulLpvnnsLQOrmky24atLkI0=
X-Received: by 2002:a05:7023:a46:b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1991b9e5d7bmr16987682c88.0.1793039158092; Mon, 26 Oct 2026
 11:25:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:25:46 -0400
X-Gm-Features: AclHuK9L_P-9DUQQyVR1q5n6RC6VuTR2frqkgDd6R4nvp8sd0RT2y__G1BnjdtI
Message-ID: <CADnq5_PRG_O7jy9P+mf7AQLerpfz6up=BejRSPMgYDh9xigm=A@mail.gmail.com>
Subject: Re: [PATCH 11/13] drm/amd/display: Refuse DP AUX while GMUX keeps the
 GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 12:11=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
> device holds no runtime PM reference, so the transfer touched registers o=
f
> the powered off GPU and caused a CPU CATTER.
>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7261317d4..b099bf520 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -24,6 +24,7 @@
>   *
>   */
>
> +#include <linux/pm_runtime.h>
>  #include <linux/vmalloc.h>
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct d=
rm_dp_aux *aux,
>         if (WARN_ON(msg->size > 16))
>                 return -E2BIG;
>
> +       ddc =3D TO_DM_AUX(aux)->ddc_service;
> +       adev =3D ddc->ctx->driver_context;
> +
> +       /*
> +        * User space reaches this through the drm_dp_aux_dev character d=
evice
> +        * without a runtime PM reference. Refuse the transfer while GMUX=
 keeps
> +        * the GPU powered off, a register access then hangs the PEG link=
.
> +        */
> +       pm_runtime_get_noresume(adev->dev);
> +       if (READ_ONCE(adev->gmux_off)) {

Nothing about this needs to be GMUX specific.

Alex

> +               pm_runtime_put_noidle(adev->dev);
> +               return -EBUSY;
> +       }
> +
>         payload.address =3D msg->address;
>         payload.data =3D msg->buffer;
>         payload.length =3D msg->size;
> @@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct =
drm_dp_aux *aux,
>         result =3D dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, =
&payload,
>                                       &operation_result);
>
> +       pm_runtime_put_autosuspend(adev->dev);
> +
>         /*
>          * w/a on certain intel platform where hpd is unexpected to pull =
low during
>          * 1st sideband message transaction by return AUX_RET_ERROR_HPD_D=
ISCON
>          * aux transaction is succuess in such case, therefore bypass the=
 error
>          */
> -       ddc =3D TO_DM_AUX(aux)->ddc_service;
> -       adev =3D ddc->ctx->driver_context;
>         if (adev->dm.aux_hpd_discon_quirk) {
>                 if (msg->address =3D=3D DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
>                         operation_result =3D=3D AUX_RET_ERROR_HPD_DISCON)=
 {
> --
> 2.55.0
>
