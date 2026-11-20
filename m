Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A660A3835
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=DAZ019Ko
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6C1112901;
	Fri, 20 Nov 2026 11:12:12 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB03310E6E0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:12:06 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b4b9ba815bso4678647b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:12:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173125; cv=none;
 d=google.com; s=arc-20260327;
 b=Ye5s4gU5/uBxdWj6R8L0SOYqvmjeIsxCQXBTSiWqheotRY7+pR2wYRDeD9bOpsYYqC
 L7DW/zgyR1JZ3mS+rWZlIkV8qJndUz4EPA9FoYypRXeok1iVb8nyPKpyzlNO1qxfzzxx
 WbhLBMMk26/9gNKTeBPZZ7OZ4/kLah7BALroO+vVbCbKTb6n5tktZrl9tXRFxxbK8fh0
 wfHbcVaA+ZW9B0RbNrNph8Q7ftPbxhnUOFy6oNViALQh7TDfb0UV3soo39LUv9S8TyY2
 SKSFwaIXhnzkFHwCW2aGasA/awD1h4rvt+nZ1R/kuqdZcYKUYkBffOSmIP6d1wlK+AAi
 ZGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ctvd1E18LBT1bm/OVmwtHp7EJOxWtY2oUhWq4p20dK4=;
 fh=RLSrZhYlieLluM84kee7yqTRg+638A1zAyZzURKdLb0=;
 b=RTmC0A3jsKz0nzu6b5UbC3+yGyPUy+0Pq1rx2PDqNQ9jIlESi/xjaBdFE5askK7QCn
 K1UUejxM3uKzIaz5Nx0RW6mKGnhEs0jHyitJVMzaTIx8eJmcYmVLYSiUfdB61LjmRBYU
 WEcyHBpc7tpu4EmgMsoP4mMuqmytzptZ80XVJ2aOBaPAWy4yFf73htSY3tft1ZCBjvVC
 UxsN8d20AUnymSCqDrjK/ExW9aj24KKR+xPpBvTC5E4KskTYLJdZ/GfaeQAIywLQjmTp
 q8AgBmKFiUPcP8Vs5qwc364fkTmm1ypn78Gh5pJuROEvTUzGn2CCBQEKBJlG3u6Z3mBN
 xvhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795173125; x=1795777925;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ctvd1E18LBT1bm/OVmwtHp7EJOxWtY2oUhWq4p20dK4=;
 b=DAZ019Ko0WfNb96sqV2DfjKWgD3/JesGbWTyCJtMEqTZ3RBo+kQqywfBIXAn+l3/dA
 gsHR+8wwLvA0rFnrfy0XyjsdkglhTKhsaeI5CY8gCm8omU2Z8mv19GM0IAciX0PQog2f
 uPs5T10xpzAXjhmLIUQyRdvhAAYtyZ4JZFOKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173125; x=1795777925;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ctvd1E18LBT1bm/OVmwtHp7EJOxWtY2oUhWq4p20dK4=;
 b=uGcCf84vmQKwJxa9uwQmXopT1YGjcwKMv3l+DOP95wiT+zg267hVRhfz8IkOsFeybk
 BDBWoLprZCoQKr3tM03j/+70NKHvSk436NIwBXt9W5Sv9WO8r4RbRUHoDXhXdJ8it6ny
 NAM0yTmPcA9REqLmAmQOkyhFI2DqpKAYBXX1E/Tu5xg9otghcMJkLkhHAeR3OV724UvH
 7ktUhkcAqqQnJL45LJLyDALQaH9RCiAXh7uXbliDOpRbhovyZVlN8O7w+BmjisFuaXdn
 gdCRK3GJe557KWWnnom3s5NoFkwxJHhT2rcpzhKfB/HINMp+QitvdN1bgm3KE61SaXOA
 8VGA==
X-Forwarded-Encrypted: i=1;
 AL+hErGX6Q9DQcju2SNcAc6EDW9Zzrdc92WZdO39aLca3vH4s4KSIy/fCzpMRqiqWIsiyDdr/Pufu8kiHaI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/xdlJPV8BcZJhFHSHT3HIBweI0eGsaRYnYp361M2mhCWvh518E
 FJwkuZdVu2/MsPRm7mXxPh6mk0xF7kxNI4I7wGIXKivL5xgc3SQ0F6Z87vr0b3SUFqkMIStsC93
 6YHzRpfLmFzCMcGsVq0pXpwu1hKkYX0fo/5GdXVwRJw==
X-Gm-Gg: AZFdTZeiEZrfynAf6OAyOEmmW0di1wrhlVsZqnQqTJdgVNzdEETqnax4700FjDD1sPk
 bHcl0Bbiv9C9NEH00G4968wzQ/NyKizrZTVtffXoC7lVt+I4IHDVBESbKR8bSdp6NAFWbAwwjG+
 0NLHOWKBIJuDflo/vBpi1eN8N24orfwRf1lgr9+pLiDux6ftMf0POZLk5R+rL4Hy2ZQtnF/DRqb
 PzRsHhj4AXFl4HiDpZ14OyUgAMuFQp5ziSL8XtEEs0vZic1ePZRhQvfNCO4bSd5a2Ij3ItU69QL
 /rGi2loUTEe+h+5JAPHQVPgHBUgsYeWjGKHw152Hcf+dhZH0HLeoh4z4EyfBIY1B3rebpv7elNL
 ptEwDXnSYIrs+qbdeTJaoh0QDdUJMPGJ/JAQOXzJv90KekGromW4UZ8JD64jPbti8YO4=
X-Received: by 2002:a05:690c:e908:b0:8b3:3956:6f7e with SMTP id
 00721157ae682-8b52043cdd0mr12064397b3.12.1795173125445; Fri, 20 Nov 2026
 03:12:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028131823.2649142-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261028131823.2649142-1-dario.binacchi@amarulasolutions.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 20 Nov 2026 12:11:54 +0100
X-Gm-Features: AclHuK-5tDXHRBDyzoy4ZajDKym7P3SzWGspe7yU6ZZCvGx7SKszxQtXGhkPNm8
Message-ID: <CABGWkvrPMDAq2s5msic8y=Ds7uNgqC79BLMzZNFmez7v9DVJMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: create blend mode property
To: Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yannick, Raphael, Philippe,

Gentle ping on this patch.

The warning has been there since v7.3 and is still present in v7.4-rc3
and in next-20261119.

Thanks and regards,
Dario

On Wed, Oct 28, 2026 at 2:18=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> After commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed") we get warnings at boot:
>
> stm32-display 48010000.display-controller: [drm] [PLANE:37:plane-0] pixel=
 format with alpha exposed but blend mode not setup. Please fix.
>
> The LTDC blends the pixel formats with alpha by straight alpha, the
> only mode implemented in the driver. Create the blend mode property
> with DRM_MODE_BLEND_COVERAGE only.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format wi=
th alpha exposed")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  drivers/gpu/drm/stm/ltdc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5311e0b3e8dc..3b6e680c1c61 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1642,6 +1642,7 @@ static struct drm_plane *ltdc_plane_create(struct d=
rm_device *ddev,
>         drm_plane_helper_add(plane, &ltdc_plane_helper_funcs);
>
>         drm_plane_create_alpha_property(plane);
> +       drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_CO=
VERAGE));
>
>         drm_dbg_driver(plane->dev, "plane:%d created\n", plane->base.id);
>
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> branch: stm32-ltdc-blend-mode
>
> --
> 2.43.0
>


--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
