Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E93C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1DF10E4CF;
	Thu, 13 Aug 2026 13:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dS47RINb";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8E710E04E
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:53:07 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so346499a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786629187; cv=none;
 d=google.com; s=arc-20260327;
 b=HwjeEms+Icn0pw1u7xzv9Y966p5PYEWCalucgQHlAySoMExwX3FaUYVGD+K+fvjldZ
 rnMql0VXPzVuL79feKhQjEBd7TvfrRy+lAJsec+JhTMXWctl78aGVGu9avgDjZfi6rW+
 BTnc39ZSVezHhg8h5O55PDH00VKCSuKR1/NKhzb/9S5fANKA5ek9dPOEOSawERgMOgkZ
 PIkJebmsu6axF224pio8fknL4WYva3HDVzpmkfpsU3PgoLo5uHPAn1GXcApVnqKcPKji
 zCxJXAjWf5QmT9r9MEwmg4ST8VAShD2cl+XtxQK0t5Ohk47HrRh19O0SiZxejuyeavsZ
 kUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 fh=kwC1erqhNBADwIxN0zEJNRdZI7+DsJrswMUN4ud14lI=;
 b=VKxz6eI1ThTXwTpDWsXX65dB++Zwv3jnbsetBKXeQDfH3yhZdx5HNb4BBuogArurps
 h4HEDVl8j1p+HEvP4jin0A6TqraK2HG1wfMPBGSaYW2B5BGR1PO31hcoLudopGTmEmQR
 wUaKA3LVnpODCH2d1Oqas+WZO/q9PhaiV+n7OCYvrKCI9BtLaDKOZizXGdymZ8iiSU5r
 uuBnJjsP0SoXZQg2f+zL49RwqjuXnaXuWSj80MA509Kjb1vSKKQVksuQHZHFEblIPRAW
 eScGOG/fiUmBSFkyMusyg4An7YVMqJZm82NsHv6Flcdzf8tA+jOK+ZaaFhMN5GsOtvuY
 BjOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629187; x=1787233987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 b=dS47RINbPCP4AeDzUwqADKwejfZydo0rPFDoQVXXHJL/EGQ2LIphG12nMdwF8fTLFt
 7oHykr3sGlX4RYxTIRjQXmIks2mFNkxJAafhsxoxSsDOtNFc+/ovbrbOdwSoVViV6/T1
 SRdPDjed8DL7xdWmyNf/buJzIdilBCfYXx9H0JdmmYISN2jHTT/BcMYqtvVkCj8Kj+BG
 8CTdQ0M8FB0GIveoq6iw2AaZTUZ/WoGJhx2kqMSbSg6/8RtIKsiClPTbSl82w5WbWNXo
 bIfv8JTuNJGS4ZMkGOPvboQA436K8CQXu6DsLUKOL2Al4AWlVLE9dDyPD61ZbY+7i0U0
 WyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629187; x=1787233987;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 b=ONyPsMoOPq0f5wsecg7FwqXUI6uTE32MxqctdYhwAiXcAqvra9J7v2pEzeeBcZA8PP
 PtJN+V4efOJvjJCRhpkwjz/ooxS3Z4dl265F0t94zQP/jxMNBgQxFyU3rVRkpAttIwNo
 tRvOXPw/p01yEsNNm2Z4ahY+ed5jx339IRWsaVNM+uRwSrtV7Z/U52CZCq6zv2p0aH9Z
 Ps1RyYUzRbbxVgrk9mZ/sMMb+s5K9kVbUNwnYHVvCXYPf1ROYg9TcdGl2zPDQNJqXphT
 pHRxd/D4fn+BkdqZUdRYioaXOjAfuizjxFjKv3h4sOAHC1BDTPi04PQupveq7qGNphmr
 SEVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rojo/h1n+YPfBQdBfcunL1l23UPhBNVkwCqu03CtJerxg6hLcVEKM6gDeaDix6y1PNOGaxVOn5dsVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ1PhPSRv1zbGfigl3o0l36/MczGyXQROz4bfmDRpBVStqFBX2
 dIO4McGuKqL7b02k61IYbCFufPsT8fraFYfs94/6d9h9iZgCRWuuq7mw3EIllL5M4w3NQuBZBcB
 aHL2WAetbth40j0QLAl20XOJyaU06mPQ=
X-Gm-Gg: AR+sD10/D67Z31qlBuvp4wCq96a6561rjMzprM0bLBK063pCcc3NJ7QQE/zNXSPv6Nf
 t/yMN4ggikK8gEuOUoc9OfvKeZ7jn9qiF6drNQus8q4FtJK4qvTmtCA1/5DjwG5HvHIM+qAUGQv
 myZQuqwsbPu8AUiEPvPXgNSzZaV4FKINtzfz1FY2hqsJc7A9cZSUvmNhpWGAwO84Wg36ZrQYpzc
 Kr7HM0jPa/UxV4MgXfzNth4jH5Tlzg7jTfzMrjhTrmsDcEjcLh2vwDnodLptIIkFQqBpvSHV59W
 pVw9uF3+bQvZZqdmuWkG4ujhDGNUh/N/v47URYy6d0QbIdZj6y57lGIQqfbTGqkiX+e7VfOZKdN
 v2AvvKTQJZbLV4phOZPb0qAej0DKqP9s=
X-Received: by 2002:a17:90b:3951:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3932336b482mr4411037a91.4.1786629186910; Thu, 13 Aug 2026
 06:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 09:52:54 -0400
X-Gm-Features: AUfX_mxUv8FpJEmmmjtvZKvLNzlI_tgl2Eg4UmY85dPwI8YNliSZSzf5oAx2JVM
Message-ID: <CADnq5_P6Uz6aRtKrzbd82-rxY2OozNKrz6P0L7x8JVNbc4hXrw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: remove useless enable/disable of ttm
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

Series still has my RB.

Alex

On Mon, Aug 10, 2026 at 8:03=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> amdgpu_ttm_disable_buffer_funcs and amdgpu_ttm_enable_buffer_funcs should
> each only be called once per amdgpu_device: at startup and teardown.
>
> Therefore the other calls are redundant and can be safely dropped.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1ec3162cb175..e966e6f7d2fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3379,8 +3379,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_de=
vice *adev)
>
>         r =3D amdgpu_device_ip_resume_phase2(adev);
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> -
>         if (r)
>                 return r;
>
> @@ -4511,8 +4509,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         if (r)
>                 goto unwind_userq;
>
> -       amdgpu_ttm_disable_buffer_funcs(adev);
> -
>         amdgpu_fence_driver_hw_fini(adev);
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
> @@ -4525,7 +4521,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
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
> index 5bcb6a966941..ba99edbfe3a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2137,7 +2137,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
