Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8F606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjJsJ2PF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20D410EBC4;
	Mon,  2 Nov 2026 08:04:02 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AA810E032
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:37:25 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso23605355e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793576244; cv=none;
 d=google.com; s=arc-20260327;
 b=fUZJpHThbM1UX0ctmo6yebkzcjFGTvW6mHLWTlcE4PRQGJak2MmU+yErm5TNUoPtsj
 EzIp1tvRzgTDifK6FfYTDbPAb9I/dcT1gis/B/6+2TbWB3PEOrDxxtyk4VIX2SoG0/4K
 EZv88VbmMx3ugFLtU+3h7dKNNBREbKbveSs0yq5u7UmQKQT8zK9QrQsBvXEBKWJyPhSI
 gWxQLfBiRihtM3wnDLSc+CgR01ehWpc9CTZzG03oxMM7eQbtQEFGoJJUEd3OchG3ok67
 4+0lIW5A2qtF/ilV0f/sDxaLKyF51WagIBrqZGULW9MV0di2Ou0Ye8lFV1bWdvZTtp9q
 2vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 fh=v7y54melwGR5zJ/m8CmQBpCEi2F8Ooyw8NXM7WTHqQc=;
 b=QpEYnuueDPVW7nSqOzo9yMityJ+VupaH8v4aylk3W+xxVamykvOICPJxG4zW/J8GZk
 3zvhBAd0nVO98UhLrHIjUZx6e8QicM1jjp159i1bHKtlGUGZCc/OpLr3fFln5LPudEhX
 9QsX/u+HrnaeUH/gvua9l8oonLtdUubqQZJwmE2CuitTm9B6910LfLk0Z/Zt478zLx65
 YQad4/YQ0EQZPMW7T+M3xvQ3Vix9/lZvUDEck2YBnE1kjnzRuyysa1ENw/oromMh/Jgj
 haUhRp6SX+Cfz1+CHelRCvGUipdPVKIP1ilyo/nViQTk/za2shF4fv3s3ksE8+h0jAAy
 CnFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793576244; x=1794181044; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 b=SjJsJ2PFQa5Bcv7PUbUgpRE0t60QeXfn1ClzbdhA9Qi9Tl0KDw2kpv9ua9eo0ZdxNz
 sKxOuYKr1iXhy6SrOY/W2yI3nHaxl3S1ivM8gXRo2SgrwkRMBfTaJ0hlAo8HmlCVWLYE
 gSZljv0oZMaxQXlCqVPsUlYorrm++nL5di9aYZfIXPuPTwIVItUaP+KnXTb1UhR8vPx0
 SKK7wECon7WtmwzfOToZvckIV0BLTBkpqP1lcbghV0/LxseKw46R5Sb+K5/fbdvrnrXr
 HH8yeSCkJXd4Cnmwqd/m3f5itOl+gkCUgzkjuR6Gn+u02GDot31FssMjfE/NwtDaDxPa
 bDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793576244; x=1794181044;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 b=I9+FzWlkj6w7Gs5mp/5/VPAignKV/TIABiUB87UMW+zxFjiAUaOVcJ+RP0Rcv7SHDh
 p0vDW0q/8KXJP0M9M3pdYMQYQIn25dLjquYR2Sr0rtPOvUhqnSyPNxGhpHglMkgRsP0P
 wUSx4rXtUGt+BBl2yH1hWf4OzWiBWSxj9RP2OHDhnNEuu/H7EzYU/GLMuEzG4k0Dh3Wm
 jVkpNz0yHqiqCc7i5H/fcvXrC3wCInyQU0QQfX0L/6GXDilttsZt9QprEMECifyzWIM4
 guxN1gK4RZ7CeSD/SIisQDSy52OUz3p0XgeUF4BgpfnHtIA8VQtvmATgpI09GhA0H8oT
 UMkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHIAGbO1i9nqS5u70Nme7VIWZyxzMt123i0u0OaoqrumQHwPxDHI5x7564kYaLLwqHuMnhUS8Iidc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/qRZgucZ6U79I1R1X3UtdtvlwvMof06kRpJXT4EWFM4EtB7wQ
 GIh5ZTWJtEzXixnqqG/UwzxmFi3rYfSVWss+EV6QwQTc3INfrK1pe63p5Uh+jFFuquchQKQgF2v
 oimTd17lh4MOodhjWKZyx/iF0wXOzZPA=
X-Gm-Gg: AYBFou37gTNuBT3Iu6RIcA0DkqfD0jplibm1uvqhrGRIlbJuG7hgDLA8v0Fdb7kJt37
 4xrJbks6DwU6EGir1SOUbORrqH6SmZqmcSnVJqo48V20R0TZ7C3xXVYTKTbd+BmOTUEcPqwkW+J
 +kkvWq+qE85ucGSEp8uPX/sDyjAifdX6s2uWj1m4OP/tceSzhEYtFruOnOs9cslBDeQ5BanOfVI
 f++MCLdSH4ujV3CsG9+ASAJdk3pVuYk496v24YGdAxoub6+v8btnNvNYcTLfxWLYG+2aB81g9Cw
 MwG5LYwnljsjTkpOv0x06qaexqrdNnfgghiAvaCSili+hCYMnEvrP+ZXCxE0ga9tzE9Y7srU1tw
 H0WZ9rcqGF1RsFAvAFusFQWKQYHBh6VjUvvFczr4=
X-Received: by 2002:a05:600c:6089:b0:4a2:a8c:22b0 with SMTP id
 5b1f17b1804b1-4ac14ec75fbmr185544245e9.1.1793576243659; Sun, 01 Nov 2026
 15:37:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Mon, 2 Nov 2026 00:37:11 +0100
X-Gm-Features: AclHuK9ns4XBGZ7zNo5bqw4a_9l2SxlgD9VWWmJ9YT0QG78bE9OgwzMy8CJwXYU
Message-ID: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Oz Tiram <oz@shift-computing.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I have two dGPUs : a Radeon RX 6800
XT and a Radeon RX 6800. They both report the same PCI identity
1002:73bf and each has a different VBIOS.
I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
outcome: on my machine the device-identity fallback actively breaks the second
dGPU.
I patched my kernel to remove the fallback, but I would like to have a
better solution for my use case.
Would it be possible to apply the patch only to APUs ? That would keep
Oz's APU case working but a dGPU with a stale bus number would fall
through to its own ROM, which is the source that is
guaranteed to match the card in the slot.
I can provide more details if needed, I am out of my depth here.
Thanks
Arnaud
