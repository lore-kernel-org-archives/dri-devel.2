Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C0EC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280BF10F057;
	Thu, 27 Aug 2026 13:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljoK22iK";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFFC10F03D
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 13:34:37 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-7834131b9e4so82260137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787837677; cv=none;
 d=google.com; s=arc-20260327;
 b=jQkp2lLGyIkO79ch8l7O5Gr7+ZGq2B95hjOKRaqwBxnWX3NZ4qE/Krg1Bio87i8PgU
 snwLahCcr+e4e4SXHVEG1NtRU/+tC4CMsCejk91LoqjHY+R4VkyouQgBJAm/0NnbS8Dh
 thay7JS5anPB53KmlaneSDRMqT9p3ilvmuTC2OPWXLtWQ0QDqfgBe7eNUuwJHgBa3K3V
 xnW+Jj8OX+7f132l5XacNhFoQ3g/Oh7yQFTMtvGFmxC8yEU68BpSvuZOxGoRAxiAP24M
 qZcfC6SuHJazEnnjDEtvL4yHqIak76WycnJi0FDhQg473zF0yyRZBIj7ED1SGlBbyg6K
 D/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q/xFuvvGcAZ70QQRUMThtljUbHehz3bTzLGv7QaKgts=;
 fh=f/0Ya6vkvzG2vKZGC5cd2VOvja3eU+mSahZpmMLi8nA=;
 b=prV34HbJneqK0zmU4ptCThnbjio/M1UbtVi0tYis1j1v5i5/mOktaNSuhXhCzEICRG
 oq9SPalRbSRUUcK/GXlpT5xvJqBvpCK+exsU6+9haJ31zIXMtBIOePoVHs/pne+qRR3C
 p9czciSkMj4bYk7T4zOJvlh7fyAQG5TpBA808mx5D8qdrMvWnRRiAzgevobvE/0BRjnj
 yLQ7Suo4Ui0xXFbA0BGBE/UNyGSkN1sSyThvi6G9qfAjAzpBsNsLhXzPVg5sJAojNNqn
 E0+x3dhFlWKrAh+mt9Jow1WNKlkaPXD5aJzSP0iOW3jE3H3FLUWZWx7obNDSwROOsNCD
 HS4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787837677; x=1788442477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q/xFuvvGcAZ70QQRUMThtljUbHehz3bTzLGv7QaKgts=;
 b=ljoK22iKS29D1Cbqapm/t+FxuWyEZlRWOh2o73K28Wrh7GndtaXEUFI+NQomkz73rf
 XfE9MT4IGDKJGQH4PFMQRY2J2147Tsu8StO0cKAmdSUv6HbXSYAr2wll69gMRBfy0z+R
 lPSS7CbiZs06xGa+faVl5RIuhXH57wrOPAIAATq2RDVUPcsN6iv55wE4qLXUU666w0lF
 LSCxdHbfHOhP+3hSR4uydmS5DOY3ignw20Eu2hwLUUIeFYoyRk4U9gbpEN5OE1ir7l2J
 8qNMfld1HZkhrIEFLABiAJJOvCMj73hSeqV99ROdgdLvFb0uLqa4uJOfbYl+KnCgzsu5
 w1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837677; x=1788442477;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/xFuvvGcAZ70QQRUMThtljUbHehz3bTzLGv7QaKgts=;
 b=W5nwmEHGuBs2l4rrRQKUELHHvoAiGlHuKP1USrSiTHD0da0tDanU2uFeK3kGkXNs49
 Tz10Iwu1WfHDpRxt/Uafioqg209/dOhI6EIqypYmTJD0a/uZcoBHcNXbjxvDvRAzCVdK
 fFUQ7D0ehk/tXxXXrJI/AfSYbRatDfpBhvK87Q9jHfy+of4DHsWOJEIhEd/UvnCKs8zK
 XrL33r9qon28RrNwO53RPgQt9H+5tXeE8+7dWSo8d14jfzSHDBSuyeOfFid1f2bVFmhf
 4j5zRxeLKkIK+BnAhN48m5FkXVE2JD/PNWML0cYHTO3UzMzifuYzFhu1KtL0JTQY0Aoj
 fr4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHMRq3Iw/XkZjX7rbJr0PJfb0y4HFwlAhOZq2KfZIdvwxESgrtdkdkqjQpVt1mrIy1GfJVWASfG9Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l2OBvjus4gWKkTTVVwNTuuwDxGg69RF+YP0vB9m7u0yw2Gw5YE
 6UG/WFzRn+GVxj8k5prsJ1Yjg5gA/8XtCsFp/fqJJNGh+jCBJc5LAkRU48BA9duosX2jlW8oXA6
 PxG2oaDVt8KF1W/OyrCex1ZBteWlPTr0=
X-Gm-Gg: AR+sD10AIdxhag1nq4MG41NhJ45Uxo3f5u7NwCVx5NWp+OIKC58iBtLS99q/aTJ75S/
 B5wT3gH09MLrD6cCVWiiCx/mQKmZPaw2zquNpbFvmaDM8d49F4Wd9YDvYUwQx6EsIl4wtBWkNQl
 HMjHUh6w3fIBroAROyGErX+HUHsSYSLC6UkykfeCjl5yiKAyuuCd7DRnfUpT+DRhdE4gE8iINvu
 pAiE0qRjndDVqivhe7AWA2PJ6jVb5STHoI/G8udlneh5ncq98k/gT4IGhfj4G6BfcXjzBGEC3O1
 3Pe5e5nuC/gEQTmLDBy6FJNolzK7BHD0+9zO4C5ye7wx4J2UW1yuzxnJs11y2A/2Ehp1Cs67w+8
 OPIeS87BrbzjgWXIXPRALKhiRqQbcXHA=
X-Received: by 2002:a05:6102:424c:b0:780:3ec2:c52b with SMTP id
 ada2fe7eead31-783fdf6c9f7mr1359108137.2.1787837676576; Thu, 27 Aug 2026
 06:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260826104143.39077-1-mwen@igalia.com>
In-Reply-To: <20260826104143.39077-1-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Aug 2026 09:34:23 -0400
X-Gm-Features: AcwNN1Vqe019ayF98MZSfbf_I8wkRb18N0QGqeHrSaq-s6gt5KbPCtNS9t1EH28
Message-ID: <CADnq5_MEBLriK_M_atX6FKR5618fiB5DmAWOvxE_e+6nd5FdDg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
To: Melissa Wen <mwen@igalia.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 daniels@collabora.com, harry.wentland@amd.com, leandro.ribeiro@collabora.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com, tzimmermann@suse.de, Alex Hung <alex.hung@amd.com>, 
 Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com, 
 Lyude Paul <lyude@redhat.com>, 
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Aug 26, 2026 at 7:20=E2=80=AFAM Melissa Wen <mwen@igalia.com> wrote=
:
>
> PREMULTI was the default DRM blend mode until 9813e158d13d
> ("drm/drm_blend: allow blend mode property without PREMULTI") introduced
> the possibility of exposing the blend mode property without PREMULTI
> being supported. However, __drm_atomic_helper_plane_state_init() still
> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
> mode in this property. In the same series, 860e748bddcc ("drm: ensure
> blend mode supported if pixel format with alpha exposed") starts warning
> drivers that supports alpha formats in a given planes but doesn't
> support blend mode property, which includes AMD primary and cursor
> planes.
>
> For AMD DCN families, overlay and primary planes support the three blend
> modes, and therefore PREMULTI is still the default mode. So the warning
> can be fixed by just creating blend mode properties for primary planes
> too. PREMULTI is the default/unique mode for cursor planes in DCN and
> DCE driver. However, looks like PIXEL_NONE is the unique blend mode
> supported by DCE-generation driver. I don't have the hardware to check
> it out, but looking at the code I understand that, even if the hardware
> can do PREMULTI or COVERAGE, the way it programs registers doesn't make
> these other blend modes actually available.
>
> Bearing this in mind, this series is organized as follow:
>
> - Patch 1 fixes the pixel_blend_mode reset when the blend mode property
>   is advertised without PREMULTI support. It's needed for AMD
>   DCE-generation (patch 3) and I think with this we can also remove a
>   workaround in nouveau nv50_wndw_default_state() caused by the
>   hardcoded PREMULTI default value [1].
>
> - Patch 2 fixes the missing-blend-mode-property warning for DCN primary
>   plane and for DCN+DCE cursor plane. The alpha property keeps only on
>   overlay planes because looks like this is not supported by AMD primary
>   planes and it doesn't affect the blend mode warning we are targetting.
>   Enabling alpha properties to primary was also causing -EINVAL on IGT
>   alpha tests because it started testing primary planes and disabling it
>   (which is not allowed by the AMD display driver).
>
> - Patch 3 fixes the warning for DCE primary plane, but I detached this
>   solution from the previous patch because I don't have hardware to
>   validate if my assumption about PIXEL_NONE-only is correct. Also, I
>   added PREMULTI to the list of supported blend mode to avoid uAPI
>   regressions since it was the required/default mode for many years and,
>   without overlay plane, PIXEL_NONE and PREMULTI are equivalent for
>   primary on top of a black blackground.
>

I presume you are planning to apply this directly to drm-misc for 7.3?

Thanks,

Alex

> [1] https://lore.kernel.org/dri-devel/20260720215058.398210-3-lyude@redha=
t.com/
>
> [v1]: https://lore.kernel.org/dri-devel/20260722183240.626522-1-mwen@igal=
ia.com/
> Changes:
> - new patch for pixel_blend_mode default value other than PREMULTI.
> - remove DCE11 which supports per_pixel_alpha but doesn't support DCN_UNI=
VERSAL_PLANE.
> - new patch for the primary plane blend mode on DCE-generations
>
> [v2]: https://lore.kernel.org/dri-devel/20260804140758.107683-1-mwen@igal=
ia.com/
> Changes:
> - keep alpha property only for overlay planes (looks like primary plane
>   doesn't actually support it) - alpha prop in primary planes causes IGT
>   test failures with RX 7900 XT on a 4k60 HP U27 as reported by Daniel
>   Wheeler.
> - improve readability of if conditions (Alex H)
> - add Leandro's r-b tags.
>
> [v3]: https://lore.kernel.org/dri-devel/20260813143605.106104-1-mwen@igal=
ia.com/
> Changes:
> - add Daniel's, Mikhail's and Viktor's tested-by tag, accordingly
> - add Alex H r-b tag
> - add PREMULTI to the DCE list of supported blend modes to avoid
>   uAPI regression reported by Viktor.
>
> Best Regards,
>
> Melissa
>
> Melissa Wen (3):
>   drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
>   drm/amd/display: fix missing blend-mode-prop warning for DCN
>   drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE
>
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 +++++++++++++++++--
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  7 +++++
>  2 files changed, 35 insertions(+), 3 deletions(-)
>
> --
> 2.53.0
>
