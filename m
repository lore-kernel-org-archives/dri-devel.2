Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E860A2624
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EELn0RdZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833E310E1EE;
	Fri, 20 Nov 2026 17:30:49 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B482112C03
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:30:43 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-533202fe429so372561cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:30:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795195842; cv=none;
 d=google.com; s=arc-20260327;
 b=NO8MBTnbbzZLCQkIFqQ2+0O7M33dDQOFTHzkE6P2ORX0DOUzlIvY3Ya5n+RsIlsHkk
 m8lsVy3GJD0JJ3lg5Vcb3PNgAe4Ek9881CIS4kqhdtDbWKMIBJMFpp89v2DsA1qkEsGV
 6GRtd+TtcDQZcOtb5AXVK+Tvs70MVaC7g9FSzrVpttWDq+7XVMDnNES5La5ZWFolTJxt
 dbwayJniNchFbQ5Ensri1Bf6LZVdTTYxOOWcBC+zsFbJllbYhHPLgg7QZ5JwFZcCSxbn
 dvBK5+NMPtavzPVICWf5AkB9Mas+sUrrLoWk2rURHXMrhBt4pPhnmD5uWEt0uH0xXfL3
 n25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YNjONpgW3BzEnvATPOG31tZu3+6J6bJ+/wDP0A0YD9o=;
 fh=cdFsVEVgfomCRrMPWxic0A7DWALViPhtHp6qb13XY6Y=;
 b=ZUSgnAhe0gNLLueLVQLhnzXeGJpbp+W2BsvFgemO7DSAEjLo0sW3KpdzA97cgLyMf2
 M0FGWiZFtoxdE9tXhZsXv9Kcv8270h1P4i8o2ENoWtKmQG6ra2jKfOFUg4YLF/NXHcJe
 C+DZtKdGJk7YjijZ4SQ/k6WHnX0XaaotAGuy0DFuF/nqljGwYMELZgspAZcVAVJENsDf
 bWmT5kncHutoz3f0cszgaUztv3QAuxVtZQat+H/2xBVB6pFNAIX0m17wmR6dOq6mp0rn
 XG0jXnVz3LJQ4ewU4oSVVZQAnBvQxT5LNHFc7i+IEKA4Sva2iOcxFdIh5Hr5SAQnUN4N
 GYZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795195842; x=1795800642;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YNjONpgW3BzEnvATPOG31tZu3+6J6bJ+/wDP0A0YD9o=;
 b=EELn0RdZsnPxF2RNX9AWMP9k6hMX944qJEG0u/bDvKlWLOPtbwT16sB1zp3EFvlSZe
 iAhH+woyVIJMGtrJfIOhK5SgTHoGjBoHjcmL4jkZBA5KkRa0e1qwpq2bT1SJReGPKP53
 WtTsCaXka0FararjOwFtAClf/okEdxekb4QBOwOAyLi8bmd0DxDm3s0qEMaoiMqPKATf
 Vhd5bt4o2hQD9+7A2g4+j5jCdKk/g/rnpkCE4vS4dwySVaTNJFSVQbA+hHYJnk3EOOh6
 PVN4ksqjIOqeOgBS0H36KO1ylWf0KZHynZl6D2zTv4HA2c1PKzJN/6ptADi8c33FOcz/
 0t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195842; x=1795800642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YNjONpgW3BzEnvATPOG31tZu3+6J6bJ+/wDP0A0YD9o=;
 b=o7NR6TAC33/bhd6GnkG83XtxYi8xuphF3cI52Xn8zM2+c0AzJMZjrrVza0kctWLFAo
 fxFj4IkUZj9HLHkOV3wH/yhxxDha/RxVmAnmjzIFAWRMhg/OXlUXmr6CdRhM4rB11j84
 ED2pidNc4GADCKOE5hu2xymlkzmN/XW6L+oIyJu0pwE7Nu/PkeAZ4XOXyq7cLhi5UUeb
 t6AEkksfNqbCi5a2Kum88nr0Qn8Qz9OPdqyud/G7MfKjoS9QV7pk0MGDpnJ+nMKajjdn
 7zF5g6utOdK9bfiDUVAk+DMa6o0GD2QVyhkXYAlc/eYj7vA+dWHiM2nBqZLfeB0a7OlE
 X/Ig==
X-Forwarded-Encrypted: i=1;
 AL+hErHL28AzjMtv+T55PLUmMhFGeMFfVnBzFIU2UtyogyLkea0OtTzkPVShKdUo3gGNbWlvG58U5NfsfBw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9WHHIBOcXN1DzDX2r1xUBwFz/1eK7Udg0eYrWnIb1SvkQfwnfQ
 E95OzH84EZO5CwkMOkRL59pl8IO8xQlh5JUIqzJ5JORn5sRMuw+9Ks9NO7jRAlxPy+vwCxUOAuh
 aGAYXOqGfeZXWD0cDBZfTGppvYbRcah25ifvljImOC+EdIRinPZhjCrFBU2Y=
X-Gm-Gg: AZFdTZcEw4pCVwqe/OSUUzPvkwyohxE47rIt63QgMOZ8wqQbjcwDq7GQSK8OwFOZy57
 WcqtYxouD/1evqRAgVj/P3DIK/89QotrUPORxjD7ycxczZttGYXKUdnFMzXfBD1/ZY/QVaGEBiI
 DJkHw9WnopZFHEwWp8HgpDjG5RQSVYcdzskE2ysPcWr45hyPS1NZcF/EnHEkNM9Jt22KPsI1h8I
 nkltjCPqHDbZ6W2GF8ggiuAaaZHflBQGu8c9qvlGDx16ROopXGZgEZU+2FJGFg8cLz+Sda/CJfq
 TdJ/NeAUSxeA88nW29p9RJgVDSGBT3hMU82T6ZLGbU/oWPnFy/0FX3ZQbo3f39GL7na1TNmgk6Y
 vzh5cIDiOEXQwMRMC+a5iGU+BUzcYu9wiM4t4
X-Received: by 2002:ac8:6102:0:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-55d7914f377mr24269751cf.6.1795195841498; Fri, 20 Nov 2026
 09:30:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795106955.git.irogers@google.com>
 <e8d983aa6f81be52ea1bb9afc9c0f47d4632c1db.1795106955.git.irogers@google.com>
 <5fb8ce65-923e-4714-946d-ecaa4ecad399@amd.com>
In-Reply-To: <5fb8ce65-923e-4714-946d-ecaa4ecad399@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 09:30:30 -0800
X-Gm-Features: Aa3M54oXyhu70SenU9J6OYKtnIDShLY5qmJ7ZZxuUaXwxMEM1-bkb09kjVtb0h8
Message-ID: <CAP-5=fWBN0=KCJcF52-1MrAQjXZBgyZ286_qQtfjN0JzDASFng@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: initialize r in amdgpu_vm_bo_update()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 4:08=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 11/19/26 18:07, Ian Rogers wrote:
> > Commit bc566781845b ("drm/amdgpu: stop syncing PRT map operations") add=
ed
> > an 'else if (!bo)' branch in amdgpu_vm_bo_update() that does not assign
> > 'r'. Because fpriv->prt_va has bo =3D=3D NULL and is updated on every c=
ommand
> > submission, userqueue validation, and KFD VM restore, calling
> > amdgpu_vm_bo_update(adev, fpriv->prt_va, false) when bo_va->invalids is
> > empty skips the mapping loop and returns uninitialized stack variable '=
r'.
> >
> > Initialize 'r' to 0.
> >
> > Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
> > -Wconditional-uninitialized enabled; fix and changelog drafted with an =
AI
> > coding assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and
> > -Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.
> >
> > Fixes: bc566781845b ("drm/amdgpu: stop syncing PRT map operations")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 82b9b2d5d0cf..091589b2c524 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1303,7 +1303,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
> >       uint64_t vram_base;
> >       uint64_t flags;
> >       bool uncached;
> > -     int r;
> > +     int r =3D 0;
>
> Good catch, but please don't initialize return variables a default value.
>
> That is often seen as bad coding style and often hides problems instead o=
f fixing them.
>
> Instead just initialize r in the if branch where it is missing.

Makes sense - keeping 'int r;' uninitialized at declaration avoids
masking future missing-assignment paths. I'll set 'r =3D 0;' inside the
'else if (!bo)' branch in v2.

Thanks,
Ian

> Thanks,
> Christian.
>
> >
> >       amdgpu_sync_create(&sync);
> >       if (clear) {
>
