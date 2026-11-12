Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owVW342x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB52C1121D9;
	Thu, 12 Nov 2026 15:52:33 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6A31121C3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:52:27 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3acb1224533so174758a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498747; cv=none;
 d=google.com; s=arc-20260327;
 b=fMj8X7pd5r+ReKwHJxA7hFZrJkbMO7YaiBnyjEnCW/kvHSDc7cBUxELSGOGQ6qO6ml
 3/1GXG2dmsR8NbBuO8dDtE58pGqwECq1mu8BAKDR9xeLD4+oWT4xv4/KZ7mStvHIIG2w
 lRbK6d0BAIARsQMhRIE0WopEOSN8opaIyq8cuXd/HOj4rauqUIXMSlpzFNHxZIoZ0e/x
 h9o6e5Pz3rgckOhlBd6DEIMcKnhfhdvjwmQbEBA0dpt+sAqnRFqGCWO7loRSp8IUIPLM
 TlhHVmwX+aaNSoEKV07xvP8IUr6WDXcXDLTQM0QW2D21lTqB3UWEaj4HYmpMr1YyWfil
 7JbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pFkKfIywj/ZyBZbX5KkOiMNv3xL2LHNwZUtS7p196fg=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=EgWUDQoVm1qZW0uBQtzYPMtF2GgBX/R+QDWjV5ko5NAWpxWPsEf+TEkkf2DxjDxUZX
 o0QCSfXm+RpVRrjgpKvHlgIK/5xs+K2IzL3HdPrkEW6CszbeLnE6D5s2p8gDIXh1smu7
 krOd08l2vR1yk0ItDPMQr2Z1bWtN1xdaxvZIYwKt1ZGEvz2rO0ZNb9Eerfmob23RLWH1
 ODg/tSDO/pATe1eFoRO/iFUK2eZwwdFyVM4URuSS8v+JhuwyJD+d1WXXM+X3u34v2yj/
 bp8Qnoxq3hBYjbh6w0uz9J0hMbbGY2QIds5rngMl12faXvO7XihlhyoFdIzxHeRc5fBV
 83Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794498747; x=1795103547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pFkKfIywj/ZyBZbX5KkOiMNv3xL2LHNwZUtS7p196fg=;
 b=owVW342xVgmGfVwp5KmKoKfG9h3Bh+8bJXYnBe1IT6kdWScOhVRw7QWwAsDGuy3H7g
 PfMm1wKf80aNdd6vI8ArKwiV/Bb+OU4kWrvm9/5qEEY/+rcbRzwx1JZ16RHH/d43D8o/
 btcxbpiHsun43/cu8ewHKSJUnJ1Zl/vQ/ZXqCVgVbXbqHZUZTcikmiXcWouBHEEgVBBm
 gzH4fWRxCQeDP5/++d1vW+9+EcCv6ZLNbuz2Az5PkglZfVcL7OOsAwg1TtQYSAoFm5Ou
 n0hOVGQxbLKss7HRgZjkkbbNWDhQae8hUqEgpVKZTKsf3FKA6jcfPGY0d9kBD+JG8sYl
 /iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498747; x=1795103547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pFkKfIywj/ZyBZbX5KkOiMNv3xL2LHNwZUtS7p196fg=;
 b=luxwswHKhS11gpQgcMa+/MapSS5wQsF7hQdXYWHqUf2ztQLGdQ/s0ui3l3bSx2rCcJ
 S/iUgiLRmyJizvv4avrDlxQpT5m46pFYOD/9ufnO6eoUxukQik3l9TT3Bfad6f66E8xY
 UNnZtlBwY0DTnpe6qKGVXkM4dSM3It3Pp4Qlz/RqENYTugWZvB4xNLOKEwO1P6japHCY
 PRWWTZxDeCLStw1vvy9x30HR+I6RS/74RUzPxhWu/XJ5ubx4a5kx+6swiJLzUk3WkFrB
 8P394SX4yKVc11qvrxMk58DUaqbMMPJxSJf2KLAb0Lz4wegN1YgvCSCQPXuIfIh48gOf
 y4UA==
X-Gm-Message-State: APuU4Z/YupZSvOlJKzHC7pFWMC3YU0C1eAHkJc+ibqWTIz2odjZfJBx4
 AqxuZpOqWwBkk01jMyPV6QpPnagEm6iW2uHgtq8FcI8nz7cLAMypPmUx1R3A6W7hB6yszicGXbd
 Nt2BYNbuVh8zfuE/HCGcpOVqwHJyKTCwsqZLL
X-Gm-Gg: AYBFou1F1m27E3ZJBHYlSwGnxQP23CSteC5+P5FGOuy0DVdchlwkUKdSP10hkHtdq4j
 BiMe4IKiuXpNLH4AmFj+Lw4mjAQ10FpVAd/HikKt8mUwzKKkXPzFmuia9h9Qc0Mjz/OmNKCMx6X
 kZQx7K0TnRhlhdwHTdPSDnjsVJaSbVU2PepLrAriewt8I7QVCx+C79pi5iUvXF+4ghAqtEn6ZAq
 UWDv4/xwmhTj9IJYK67Dk2jVf5h2jbbl+UI1eUm/9j0SiaL7M29+X62bJxRPodYV4nMRvDL6I4t
 EoJdrm1SzuA2g3VgD+nvjkwbZXE8n7r2OG/jd+5vzh9MeJMKIBSU82OfcSqHxxKaAzESLEDC7Fh
 zDhIr1av49MbJog3ZQGlj9J5xFood8xbh4+LEtg==
X-Received: by 2002:a17:90b:134e:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3b182d6a766mr9385950a91.0.1794498745885; Thu, 12 Nov 2026
 07:52:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107165303.13508-1-lui2012qwq@gmail.com>
 <sashiko-outbox-204751@kernel.org>
In-Reply-To: <sashiko-outbox-204751@kernel.org>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Thu, 12 Nov 2026 23:52:13 +0800
X-Gm-Features: AclHuK-DW0Wyf1thbDSXO7RLTdFK8837q2tulUfBni-HUsH0xnhsu0BaucfkLqE
Message-ID: <CAE=Q7=5M2XXqWpO4SXL4uSzBL5Yvt_Tg6o2nDTpZak281w8keQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 5:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [Severity: Low]
> Should this commit include a Fixes: tag for the commit that introduced th=
e
> leak:
>
>   Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper=
_prepare_fb v2")

Thanks, v2 will include the fix tag.

On Mon, Nov 9, 2026 at 5:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/gem-atomic-helper: missing Fixes trailer for commit
>   1ea28bc5542d
> --
>
> commit b6d9ff23bfcc702d784107d5026972257646c1fc
> Author: Chengyu Liu <lui2012qwq@gmail.com>
>
> > drm/gem-atomic-helper: fix fence leak on dma_fence_chain_alloc() failur=
e
> >
> > In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
> > singleton fence) and "fence" (explicit or previous plane's) exist, they
> > are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
> > fails, the error path runs before dma_fence_chain_init() adopts "new",
> > and error: only puts "fence" - leaking one fence reference per failure.
> >
> > Put "new" in the allocation-failure branch.
> >
> > Found by static analysis.
> >
> > Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
>
> [Severity: Low]
> Should this commit include a Fixes: tag for the commit that introduced th=
e
> leak:
>
>   Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper=
_prepare_fb v2")
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107165303.13=
508-1-lui2012qwq@gmail.com?part=3D1
