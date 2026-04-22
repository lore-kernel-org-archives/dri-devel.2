Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14EAFA1FED
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FD610EA54;
	Wed, 22 Apr 2026 20:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9eMqFFD";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A9F10EA52
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 20:54:45 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c373ee97fso248260c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776891285; cv=none;
 d=google.com; s=arc-20240605;
 b=XC8HYY6nBT7UJrlmXJnzPynJeUqWoMMi/KjUJruWMXcnlLBo75j2+zKggOGlbssVqM
 lWJRydxDAIV8q94E7RtYqZe7hvpVB6egHbZVqEUUecNswzMaQ7QPnzHd5B6Jhdn33DIE
 I+IHLI5V43XA9Qd9SiCFV5zv1dLr4UB0CaqW88LEoaV9UmXhHW8dWe1wbnraI73Rxk8p
 8t34xERXw13QulKH9sOJyU9BsOOhs7DjQIx5Sb7uvf5mqFprJtJmEuMcJ9Ok/uZWVksK
 5vjv62B6C5a6HTg+cQmv416SRmAdQ8JnJpNAPA4at828QEzvmh5vxGoSZuggIEKIyDdZ
 qWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 fh=p90MwSj2szdA8n/iZPLE6xYHJ1E+1iMEWR8sBgw9fww=;
 b=lJBg/Ja8cFcNtjtKpIcXuHePFJCyXqedSNZYpeMNTdzzVrhEvSkPBj1ivYg8v5o00Q
 H6Iro3mLovl0XhTVLnZpDo9uekwLljq+av5pTBJKrBM0fZ5wVpRxwtpc3QgtcQA7H2OH
 kQtnVapQXT0MBrusi9gse218x6euJ5Y587F//MItuVhmXM1x1hgmMAXHXb4NvrxW1Pas
 0+R6mfnX/gJeRdx99QlvlU3Jc9lnHHohvHlURw4T9l4UtO8HOLLw2PbGmMeMIEbkdE98
 bpmVJmckzICVTiISvaCM4JK1wDO3wcCDQ9nZNqIIi6llluj0Jr+GmvOlv4VhdQ5goU4r
 gMng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776891285; x=1777496085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 b=Z9eMqFFDgI9FzPKQXh23Vaemmd87qutOxWeaC+UKuuRvBMCa/tvIUNxccuWkPTN2gu
 HcMRpVL8SmCqHc4/mTcS17M43rUiV2VP6NjT3ygHQlIY3RWhjjWLsLT4oXeszGv4Xs3Z
 gb5Ky3sNFzacA2G9A2NYXAA13n4ydSJzI4NxBXEHldMwGnnYRIWFJtcLTCnezI7+F7lv
 Wa+fuorO9UU9nNdzgAKcHmME935lIQmp8zEWs6dv/lcbpp3WXKTjtTE3GcmlIQDBrwJZ
 GgeNFyUlE35MXPoIs3hu09b+8f0JNfTYHDJWL2O58hwilhTE2Ry/YoNsjez6dlGoP6KM
 1cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776891285; x=1777496085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 b=EjRwMGu5kUkZrL5M/gwlAjME+mE5un+WHQQlwqBPDzaV5TcLY6GxTZ44mvpp2ku1Wn
 /9E426OQJckY2CjAOOKSNNXyVeI4YzyuwRsF8+bqb7lEyG+px9L8/vv6b9loOvvEq8U2
 SYs7I+LR7KX+4doht5L4p5wTv9JHMhCjN08oI6dsUQVJ51yy/yTIbdaA3+raBEvVjWrT
 R5KuYRj/ZbWCRF8GJFS8Tzkfj8HLwuis8se8vKOleAHQcggQh1CGZz+J2WFmPbXEJxnX
 V/XrMt9nK0bgHnWquLCSJwkvi/EH3rVZb5Ik+6TOYfNLb6xCmKOvZzo161CVYMUgVjkT
 DdOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jnkNOBex8CTNEHVd6Dizdv0e3tC3OiVs4IqXcLzLbEOh1jsHe3l9oGcorT3DRcOqo4JWk73eUNe4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMn6vM2MznkKFEuFJV0enlpnf/9qMV9pAk6VFB2alH3vRYHjHc
 I+miv6h18C12a2MX/uOQGb1bxwPvpLvvcUFYAhu/ehIB+3JV0Mv6qmKYDSbnpkNvoe3ljNr6NWS
 qXrsEG/IgXdYoTi8PqX0d9/MgQPcRbJ0=
X-Gm-Gg: AeBDietGl8CpJl6mEHF04gHfW58NxuYvhDtF+fATbczrOIqon6aVTEVx5O1H+oY6oQw
 1hK1B+2m8mDKf+tGXrHSx9WXQBBZVtAslf/Le/bafaLqKrIgujYVrEAPHbt0eZgA7OvQRYepp6k
 2+DIDqPAmSIT+lJpTrsepwnAs90P9E1W6euYRgLNYO4b6+34L2PULLKHKVWgSVVp0IndkGOsOsY
 4QbDw/F32ZX2EorVIHxvcewkuE1nF/V5jBq5Rhr9nLaWEXHUu89vOLMc/EIeuYyp3mnWPB43JZe
 6Cora7xVeL6s3qOh9Ydxs3uHU9keLPU2+L9hNymTic7IVgkD1OwyEVqq2l3+GwqgDx+Vf9g2ALd
 cA4L0H9/4K7WUHUE=
X-Received: by 2002:a05:7022:b94:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-12c888baed5mr3761042c88.1.1776891284830; Wed, 22 Apr 2026
 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260421132303.GCaed6N9mDwutP6sEx@fat_crate.local>
 <CADnq5_POMAQyY1OtqE6v4-NwoN2ViUCTeq-RQp79UwpMeDZRYA@mail.gmail.com>
 <20260422203314.GCaekwikuCiHx8CK-S@fat_crate.local>
In-Reply-To: <20260422203314.GCaekwikuCiHx8CK-S@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 16:54:32 -0400
X-Gm-Features: AQROBzDPSGTMSo9mTABgs9UFcUZoFXPWDgchm7qsWhjnLAqqV3nYhfRa9VmG0pQ
Message-ID: <CADnq5_MD=88gWXFp_-sQ0qpj-xDbqNsEkofnaNqFkQbJL43hNg@mail.gmail.com>
Subject: Re: amdgpu: WARNING:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58
 at dc_assert_fp_enabled+0x10/0x20 [amdgpu], CPU#5: (udev-worker)/418
To: Borislav Petkov <bp@alien8.de>
Cc: Rafal Ostrowski <rostrows@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Wed, Apr 22, 2026 at 4:33=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Apr 21, 2026 at 10:06:01AM -0400, Alex Deucher wrote:
> > On Tue, Apr 21, 2026 at 9:59=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > Hi,
> > >
> > > this is latest Linus from today on a Zen2 laptop:
> >
> > +Rafal Ostrowski
> >
> > I think this should be fixed by:
> > https://patchwork.freedesktop.org/patch/718415/
> > Which is already included in my last PR.
>
> So I just tested:
>
> Merge: d46dd0d88341 a7756371e57f
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Apr 21 17:39:21 2026 -0700
>
>     Merge tag 'drm-next-2026-04-22' of https://gitlab.freedesktop.org/drm=
/kernel
>
> hoping that your fix might've landed in the meantime there but nope, it s=
till
> fires.
>
> Also, patchwork is timeouting for me so can you pls send me this patch in=
line
> here so that I can run it?

It's in drm-next, should land in this week's next-fixes PR.
https://gitlab.freedesktop.org/drm/kernel/-/commit/07598c76964a2c73702fa652=
bcd07ec21088c5ef

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
