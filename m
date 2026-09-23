Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A261C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B161110E7EB;
	Wed, 23 Sep 2026 09:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="Sz14KmrQ";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CAA10E7EB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:48:58 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db1ca06a25so3032155ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 02:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790156938; cv=none;
 d=google.com; s=arc-20260327;
 b=Pc9EPZwo1HoqC4mtYR5u52Eqpn6sUGM/688x+n3vOCS1QZWZm+xNc4Jgd06CSbih+D
 jwIaS18nBvVeq+Ro9KkJJfSzLnJKvt3A0fB0+lRG22h1LW2AN/J+dYcnzU+42sglhYFK
 ad8Cq49+nAZc4QU+USYERYslUTczt4HKbggj+djUwdhV75nu/6evvn55+062bt30vLBg
 q+ufpGxCM/68Cwl8On7FHbHnQCZiIafqlw5RwY+v6i0NPMHmYCo/tT8ZkCd8JiNL86eJ
 07nVtQdDlCI7SRi+/+KuCQqHF9/sMdK1z+YwuU5WO6XWspQuRP73JWpiPnt2PkT8cMwD
 3LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wx4px2zkiHR2c6nwPLGSYtdbbt3JxOWVvjGhgsEZ98w=;
 fh=FEBR0O0bGr6sRThIAPX8pvyIQJQ/Bw9zd5set2Eh+9M=;
 b=msRPoQsiKk2ZSbbuh+hkELxsjo2q/u2s1XoZR0Vr4oiiaEbk55aLLFPHHu79vjNrWP
 FugZZ6+cWDmnhhUAA2kmRtPdu/dstdyPWpIEeIa8zt+EjOUEmF78lEemj6dJPEnwydeS
 xeYt+WaOD51BYwINHrzL+Q7De6XO5CEBYh52QWK/659X40rLszCOes9jiKMaXZ3fVrQw
 zvUriHAodCGb6Zm2Uw1eBepDWc5hWg0y9TXCMBJ7uvtgHu6wwSwpiXuSHESIr+q0HOe1
 Bc73bJs1+5C/sCtd4jjJGSBBYz/MVKTjiNlCi9n0PglA4ZZotmWblbuiDGvLHYhNt+DP
 xQZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1790156938; x=1790761738;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wx4px2zkiHR2c6nwPLGSYtdbbt3JxOWVvjGhgsEZ98w=;
 b=Sz14KmrQtrY1FtRoPZaM1qpL3s/UdsQ6gz7XGDEIWlu37qJNvvvN5JT4rnynsVzFZn
 aIxuIaCXgVNBA4XVYWky9J3eu7az/Z6Q2+zVxhncIrFwq/KGRAq02TE4c0vATN4wPj5K
 vDeFVkXgE2/Qfw7xV1aIovXaZ09yZ9Wkw69cMwHlZSrDXB77rmVO66+29rUHfw/uF+Cy
 yrpT8dyuicgc+MhDSlDLTKcVh5QTuHZOUv40mwxNpPppnej0VDuGHFM4tSSimPFxMpfe
 /fNJEu5ebEgNXqLeyYWGJHEWXGN7uicb7hAq41lcdtDoNE3Lb8Sb1KxDumLGCWMJ9Rkk
 ocfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790156938; x=1790761738;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wx4px2zkiHR2c6nwPLGSYtdbbt3JxOWVvjGhgsEZ98w=;
 b=Oo/SIuWZaHrRgQ769BGNxzRpC3puJmk/B9lAOyRoPHFeGBxC2dIOAOHJrIFyWqNnt9
 uoY4i5Rg6jlWYOyqReH75zoN/s2yAvJmL9F8CSFn8rw2Aw7fsxf2kd3XTD+PG+KAo/si
 sDqrvYJGprhAdQg1gtXnbE8eWhzT+N/h+an0F4tG/aUu2QO6tO35vKNTMiNIRfMA9NKy
 mcnlQDXMxW0f7NsbAl1tgMVR2TIeLoaqTUviiGEe62xTjvHi5nHE4u3IqYZVPTcpBg7I
 SXwwCDh21PrTJZINjPhdbccnCPYbilDGN1kveh1oNZIT/IeYyDpRdpw9lDil/lgGrZDX
 9mCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydt+c0YjBMDdE0yUf6KXfhcfsmVww1OPieRcrJJ5v+KbmOneuCvBt/xeg+jkCqo6HC68AJyMk4Vec=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l6F94L/gDH5eXo7TFucwQILYWzQ1YZeMUo3RTeTQIySll1FT//
 GF+YOPGZ4IrEhVD3ISD9jkQUf0pGEdC0BCp4xqyp8EhGShi3sK5S8v0RyjhsvakCvPsLu+Xgl3p
 aGsfCw7UFqjqHNwwTxzybKJitnbHQFbCpMo9a7/v37g==
X-Gm-Gg: AYBFou0QLgOoAzph4QxsnVKRo3wrevi0PlV1FGxketKPdsN00JsTZRH1XV2PbdTwun2
 136InlTjjddfThN4+Q0ZLE548Uibubb1mgBs6a3kxfgr3i7n+gFRlkRodZv9ud2VSARLNV+n4JY
 i1Qt1qcaT5D1QrwVO/Nm/ArV+VGEC9o9Aod9UgzQ+sQsnzD7+Kv18Z83X8ZabtEteLlcg7YE2Ix
 bG9nq+uNiEkIHrazlSnScIheUTSRtAdYHpv8eYBhrzs9poN5wiLcWOPQKoZh5lDjVp3OEb/5vJj
 J1RBjVMglfqPsUYPwf2MuDz5BRAgjhAYO5BnfsITr91jrdnUL0Gc
X-Received: by 2002:a17:902:fc4c:b0:2dd:c053:e0f7 with SMTP id
 d9443c01a7336-2df69ddf21cmr18272105ad.38.1790156937998; Wed, 23 Sep 2026
 02:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
In-Reply-To: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 23 Sep 2026 10:48:45 +0100
X-Gm-Features: AcwNN1WttT0SOIaLJgPj7L96LwZzDPPyCZ9AdYI_ydBFNIIRW4TfTa-aNf4h73Y
Message-ID: <CAPj87rMChKiJw3YbKcmb=3UWnu1Ccs5Me3R1tisDGMEL3aMDYQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] drm: Add DRM_MODE_ATOMIC_RESET flag
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@redhat.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Maxime,

On Fri, 18 Sept 2026 at 15:18, Maxime Ripard <mripard@kernel.org> wrote:
> Userspace currently has no atomic way to bring a display pipeline back
> to a pristine state. A compositor that wants to start from a known
> baseline must explicitly set every property on every KMS object to its
> default value, which requires tracking which properties exist and what
> their defaults are. This is fragile and must be updated every time a
> new property is added to the kernel.
>
> This series introduces a new DRM_MODE_ATOMIC_RESET flag for the
> atomic ioctl. When set, the kernel fills the commit with default
> states for all KMS objects before applying the properties supplied in
> the request. Properties not explicitly included remain at their
> defaults. This allows userspace to describe the desired end state
> declaratively, without caring about the current state or the full set
> of properties.

Thanks for bumping this - I had the original patch in my queue to look
at after the hackfest, but it got lost in an unfortunate tab
explosion.

I think it would be good to document more clearly that 'default
state', generally, means 'everything disabled'. Of course stuff like
colour properties and max_bpc and whatever will likely have different
values (where 'default state' means 'enough to get a basic 32bpp image
displayed if you don't care about the details'), but I think
explicitly calling out that planes + CRTCs + connectors will all be
disabled would be useful.

I can't find any holes in the implementation though, and I like the
uAPI. I'd do the same thing for Weston as for Mutter: in our
backend->state_invalid loop where we loop through setting all
planes/CRTCs/connectors as disabled when we aren't just issuing
incremental state updates, we'd ignore that and go straight to the
STATE_RESET path.

I wonder if we also want some kselftests along the lines of the VKMS
IGT test, i.e. for drm_atomic_helper_connector_hdmi_reset_tests[] to
make sure that the assumptions hold after init -> apply different
state -> reset state.

Regardless, series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

... with my reading-kernel-code and evaluating-uAPI hats both on.

Cheers,
Daniel
