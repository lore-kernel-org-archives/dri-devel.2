Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F507C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A13B10EAF2;
	Tue,  4 Aug 2026 15:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PTb9IqO9";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6560B10EAF1
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:36:33 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so463829a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 08:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857793; cv=none;
 d=google.com; s=arc-20260327;
 b=BbC+nwrMiQOml5IytEYm/XJdG74ipeiSQC0cV3clS7A34m6EWwSB5ZHQu84jgjrxc2
 EPdHbs+yif+cxPh77l8vc3mk3OgUkCleuPtFXGS+MyGbHUSXEHF5mdZavDdIEHQlWFtk
 BGQZjjR++TO/bn+knCvajeJ0+0enc1ARMXook7S5SqgJ0IsMtJb7NBzGamUkkSFdaaP3
 RQgwM46F3I36F25ZUBYggBN9W/20p4Umsea1MPwJF0atq21Db44R40i4HpQ35NYD1zgq
 o6dtvOuWuD/XYDjnA4yOii7/qnSSNonhbOVNx8zRKcmILowj94hi9e+rR6S48WGRUIe9
 RODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 fh=bk12dmh4VbRVs4yr8of+jttyxb8SY4+EgfgR74fjoPY=;
 b=EOMwoYQaCChW0ZUbNT4EzuTw36ZgpYFlwsO4itSwdG6aEYlJSAnPICBZ/ZsLYtD9/+
 x0qt5gJMwLSJaPSDbd13jYYZ3NSVTthEIeMLHJ+pnSU/DnmbP+3S4X6BXensC3MyZIpS
 2aMCqaKWUTYMh2A/iygfqhAZwEUKP7BYeZuOVKbwM/7YOewtlS+SsjiU8/CqetNGPngY
 PSfHhPFPwHlpfttTqRKGlO83s7lv/cfP1MFCMJVfNFDZHYzkA7fUeY5rhQnmlvq8t35v
 vRve44LcHibWoD/XSQA5m6ivr8HckVCNn5V8/4TzdJu5sQUtwA17Yue2BT5Jr4SF+9Mb
 3fDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785857793; x=1786462593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 b=PTb9IqO9WXG8Fr17Ndn1RdS2SY4IrmhwGNNV6+6Azy//FR0+y2fwxfoQ6LZBoKnKSF
 mzuGPUNBAr/zYYmQEMgoZG2PKETm2zmRbOaGeVmbcRA8fsbb/2F6fWp/fae4qDx325JA
 NbUFo0n4tcEzX5zZJ+bCyY40vyH15cYH5cVoubsrcsvEMVruRXt5GPfn/t99RLNP5v+m
 sEWetE6O7GbhkleT0r/GugsrAcpdF+IIhDh3bmIxQbG0Az6c2taDHdzcWRWgJe0FK7C0
 3C5CgP86YLCizrGjPb/lyibrK2zraFkZh33dXlSQjQ2sMHCO0q9gYiIcE0J+8chl8d5B
 5DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785857793; x=1786462593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 b=CyFIeMNtfySIXfWSZqL2WCyt+xDakFdG50/jOJsq1i+jxxdNidNtjt0zdmAJhTpP1H
 01rLEEMPLb9SKpJbQqKxXEelAtqidrXn54zRY8XXIVXJNyHMArjBdW1mCZLqtvzeOa6K
 jOcIpTMZxxGX3+SfMzzXa10ACnIl4L+iYai/+/FO3W4tXFYscbmP0WXtC9Rpk+ZSxna4
 806LTc+d8zKvo239wxREBW7dXXnJhCOoX4uzOoBlIYvJsMgNJDvt/uGy+ZAbPbYxBcJ9
 7B4RdjUChgtIjgMdXmZlq1bhAe44o9YQ6lpk4BxEKK+UoHnh8eEvsJ+JTiFmtQV+EUwA
 4ZAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+JJlATYjFuAEwGqAMNqzOzQxCRzLn+fMgSPxb9IzqBI/03hqPf5fHQLmbuPbyeh8ZsxsLDmsPl7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9mDP2Am8kZPdSeuKSdHX9Zt1PDAndcLLwPSbeqVGBbrXvF9HD
 pLgc2NFJC7G3Skdpl0aC41Oj8ceKwdnIpgcCZREh/y6Uc6HuYGhTOs08CXTjsOWG6LamEc3mth8
 LbjPk/l5PEl+4A3xrJ2ecOhf8eiC2DKQ=
X-Gm-Gg: AR+sD122BYVyBMtYwrmSk/SWlqnv9rICTE6G2cd7fkSjiXmUVoh5xcUytcHthC2bpRI
 IrR0m4Pu1EfptZSfEEKmvGkGKpzAPftdb9fQfWrVB6D3SchiQoW0WCSHQgluESr5AKhoC705Vv5
 WHmTB7duTf04AK4ZWsfHNIexSePePQiUKkCtpYKmoCqo4YsXToj1H85Pq2sNAvA99VhfdnU49dQ
 PuaX7Ulrm9Zs+6d6TmXaAlRk5+TYV2pzKw6PfOP7U6TkHNDXEFn1ncTv7VlZcMwQNPnj8noCKQL
 QJ+MDYe+4C5OOKtAK4l++6IjOei2kU8f3M44Y7+x67lrUSTUpBSJGujxO1q4SAqU7lz+5ZgLy7M
 51US2rP25zQ0ywr98Wo0JBEJxRacA5o0=
X-Received: by 2002:a17:90b:278e:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3903c721be4mr43142a91.4.1785857792766; Tue, 04 Aug 2026
 08:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
 <20260617132835.12306-3-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260617132835.12306-3-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 11:36:21 -0400
X-Gm-Features: AUfX_mwVPZr4GXOgoFuQ6a4spUwYXFiAddJmOexwhtgA8LhfSz0efu6wxZC8MS0
Message-ID: <CADnq5_M+-sADczApmUUBtYXWpo97EXEcxZGApCiDeT1wU+4gBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: remove useless enable/disable of ttm
 buffer funcs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> amdgpu_ttm_disable_buffer_funcs and amdgpu_ttm_enable_buffer_funcs should
> each only be called once per amdgpu_device: at startup and teardown.
>
> Therefore the other calls are redundant and can be safely dropped.

I think there were originally issues where SDMA was attempted to be
used when it was not ready which is why we added all of these cases,
but I think that should be handled properly now.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 53150fe55350..6abcde8a1a00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3381,8 +3381,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_de=
vice *adev)
>
>         r =3D amdgpu_device_ip_resume_phase2(adev);
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> -
>         if (r)
>                 return r;
>
> @@ -4505,8 +4503,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         if (r)
>                 goto unwind_userq;
>
> -       amdgpu_ttm_disable_buffer_funcs(adev);
> -
>         amdgpu_fence_driver_hw_fini(adev);
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
> @@ -4519,7 +4515,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         return 0;
>
>  unwind_evict:
> -       amdgpu_ttm_enable_buffer_funcs(adev);
>         amdgpu_fence_driver_hw_init(adev);
>
>  unwind_userq:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6c6ab4dd6ea9..95f879e723ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2099,7 +2099,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         }
>
>         /* Change the size here instead of the init above so only lpfn is=
 affected */
> -       amdgpu_ttm_disable_buffer_funcs(adev);
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_X86
>         if (adev->gmc.xgmi.connected_to_cpu)
> --
> 2.43.0
>
