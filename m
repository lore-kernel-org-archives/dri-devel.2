Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A005C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 19:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB48710E032;
	Sun, 27 Sep 2026 19:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hI4AaC92";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7561610E69B
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 19:26:58 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-3427977d677so167210eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537218; cv=none;
 d=google.com; s=arc-20260327;
 b=p2dP08qvCX/3SFrep0ut9Cw/1mkIcblWg3fQChvQrxFLHOLBdDdkmU3MKsIM5PNve3
 f4CYGWoD4HEGPh7s6ko/9t6QUkTK/K3m/AouqdJgcM4aYJOeS+FJz+p5ue0Fp07gPchU
 67lZ4VR0nfMuiD4J56xsn1neKa2Ce/P4jLRyuLIY75io9gUMdvDQTOPURYhmdtrgTedj
 V8H1Udj+bYRveVw7NSVbBoTxTS8k4ptPc1dH1805FXTAG+vVQwfIBzWV8yiQCZ1ePB4d
 +mqD+fsPJWViehQoCyKvpOspxT32Dz1zaNrCEJD8QZP1SGdyuUYfEmCTlXyd0NuvVzDh
 +fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 fh=p7ru+8MhPJgr9lDG/SJJ16/INMN1iIqQVItprRRRHV0=;
 b=PzdzEWvYv/banlDwV72Jtm8lxwv2p7c3pW+HT7yYBOinm5+k6YP4RiZxBYiXY6o08w
 Rpsv4jvMinQyvunGVBlKhnq9IwbgWARedyMdHl8ii0CLW9z/JLFP69A3N/cPyVewe7ON
 AZUI2cNXzNP5eiFRrNxLTqVpvun7mI4x4BAXF5uiHuPuWFUw8ULiV5eFJ0XE2WVz9eHi
 YDxTR7ckS957pcM0XQtbSBgY+2jcUGXlEzGtH2b3SSxku35F5gYQRhv09P7QBSsKTxrr
 5uwJhgQ09bVvs6Pb+2bkmOco4MfYZjVpkV4n8TnKJhjiSJEj85wcu6k7LxjXxhtLiLJf
 TFfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790537218; x=1791142018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 b=hI4AaC921+ZrtA1BntM3zL+ZCbY4/B6h8Lr2Mz9JJWxwtfglmN3LFBDpuLyrwQ5pV9
 UwLkm9UKeN/7f0fFd1nqaRwqS333HHDMrPsG+mKKQzgBpVlEuwfXpqjRdwe+7MwLr4HQ
 ZUML3UUNo8LqK6A4wBy9OAsdX/5IAavSfjtFxU+hFWs9GmwdYq14KIkZltBgMmZ/IpId
 go2b41sp7E7Lx3ju32VQdEmGNGbEnH2p81ZsyhFso+OaPxidl8Mc47bjc7kTvj2riLPA
 35ROB/zsxXbgE2+3nU1wUZ1yG0nUCmOiIZXFb31DyXBSOprHKeCctq8ttxeAPSmNPoK6
 j2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790537218; x=1791142018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 b=emJYbly/YziJB8f9rdP+4yNhJI+9MQpcxZcu9f++biMZJBxeT1rbaI2NozxtRZuqBS
 hN1QpWeh6ZydWNFsf23aINfnNmY8s6a0MoV6ksZw2znoLNIBEtthKpdmLtw9rn3NtsJk
 b0c48kRW5x+pujjJ1HyqW4+XsRBPCEzhbmKUzaViGIcNoHDoWZG3f5X0zjPf2RVybCe9
 clXKMr3cfJi2MWtgxLsULGdO544cVedo/MUK3/Nhuc4gwhXAQYgfTXXh4GVI85VSYI8R
 tTplkT6+vlwFYRHaavJyscDjsVtC6V+CYFLrGO1TFAmj+sw5L0fl1JFVHEnZSzyS1YMl
 UZpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypzYcldGOh1j9TwG2OQG1Ec6HpEUQqYJs8J3RhvNDzWvSjtB3kxSOpfsAoStpob4K/Gj1erKlx2tI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++knIvkVkpZHEQIO62/Vby+kd4RvuMOmg+Xna1ixCvA5Y5w2fuWs
 lgcZxEi30QF6JI2OXtWhCpHS1rUCTgIrFiHfuMI3m9kjzq9B8GlqEYBZb3GddG7QbF/OOw0B67Q
 8H69yYkq+0LWU93Y71u+9qhpxme6VHSU=
X-Gm-Gg: AYBFou0E3cq2b5Ea+jeUg4cQD9eXA7O0g5z9EL2a2+Gm3M9mVT9ef3FutyRC5Y3sjRc
 VLRwxKt58cdfWviLqrqayVOjHfNcjZ2SP/BBSpdo65h5Xe1DDlTfH7AJbDMEggV1O2q3BSZev42
 pkw4/uSZme34f3PiLGZwqPwotxlJOpfxG94WYGIhi0sI9PZP4pvCxYfnG05blrEDpi8fn/rk/Zk
 ICM1WQwUZGLT7C5Czjmn7RPbZZsHt9fUwqdJFRpIdPYAOfTuGshs0eS1uF0NVYCW5Y09q+1eOZM
 plUU+R4SkZ+OdJ9vBNHLSs2CK0RPk71qen76wopRU94aihLWkXrahq3v9npKB+UehBDAEGiy16T
 b+xhPW6TKgbY8RE9iEmPdKA5HWBPT3JkOGjMAnmZ74w==
X-Received: by 2002:a05:7022:29c:20b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-146cfdd1a65mr11563219c88.2.1790537217579; Sun, 27 Sep 2026
 12:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260927145505.16883-1-kaloz@kernel.org>
In-Reply-To: <20260927145505.16883-1-kaloz@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 15:26:45 -0400
X-Gm-Features: AclHuK-CrK0NLf-dOyv1g22nCfXksI0ZY8rCmFNjK9n1wbeXqCSPRlaJ6RVXPAU
Message-ID: <CADnq5_OB21LmvT-J2Ou_v1cNPNwQHz9wapwgauNzuDthRHcMiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/radeon: Sun XVR-300 support on sparc64
To: Imre Kaloz <kaloz@kernel.org>
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

On Sun, Sep 27, 2026 at 11:06=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrot=
e:
>
> These two patches get radeon KMS working on the Sun XVR-300, a
> FireMV 2200 PCIe (RV370) board, in sparc64 hosts.
>
> Patch 1 fixes an Oops that any posted radeon card on sparc64 hits in
> igp_read_bios_from_vram(), which dereferences an ioremap() cookie to
> check the VBIOS signature. It is tagged for stable.
>
> Patch 2 adds a legacy connector table for the XVR-300, which has no
> COMBIOS for the driver to parse, so both DVI-I outputs are found.
> The XVR-300 needs both.
>
> Tested on a Sun Ultra 45 with an XVR-300.
>
> Changes in v2:
> - Read the signature with readb() before the allocation instead of
>   checking the RAM copy, as radeon_read_bios() does (patch 1).
>
> Imre Kaloz (2):
>   drm/radeon: Read the VRAM VBIOS signature with readb()
>   drm/radeon: add a connector table for the Sun XVR-300

Applied the series.  Thanks!

Alex

>
>  drivers/gpu/drm/radeon/radeon_bios.c    |  6 ++-
>  drivers/gpu/drm/radeon/radeon_combios.c | 51 +++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_mode.h    |  3 +-
>  3 files changed, 58 insertions(+), 2 deletions(-)
>
>
> base-commit: fe2ec83746e501645709761605c2464a44fd2929
> --
> 2.47.3
>
