Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CB606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhO3oAH7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAACF10EB42;
	Sun,  8 Nov 2026 22:44:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88DA10EB42
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:44:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BAD936190E;
 Sun,  8 Nov 2026 22:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA9D1F0089F;
 Sun,  8 Nov 2026 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794177850;
 bh=Q62lzv/FVmaxsKfbsDfw9U7/+P1ZjOCcmvv7DA5s72o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EhO3oAH7Ml2KF/4yH7+emqZuEcHcSwWm8AZj4ic2M9aWW6DKHppejIKboiIWr1p1W
 wC1wlfec+nX1j07k7bv66Gz4CTLwdyj+ML4BOHQVKBv+P7j4flM1B6hvgn1bAGNIKN
 ckDzm5+vYFjbnXdYp17XEzC0fw2Y3ks5Tw+hsc/+ZtAt4ba00iUD9DKIturDUhV6nc
 vym8msLIjrmWUpWLLa9wlGa5elz3wXumIjyD381rNdUV/ZyEPq+x16BwJEX9mhRj0c
 S/PsuSqO7QtPHuJrvFy90AgOeyNYQxeGEdaSmEmuq0RoS4+7utTvHEd1nbwNcw1P/9
 ymnanMtB4loqA==
Message-ID: <sashiko-outbox-204125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/atom: do not dereference NULL vbios string
 pointer
To: "Noah Weinberger" <NoahWeinberger2003@proton.me>
Cc: =?utf-8?b?ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw==?=
 <dri-devel@lists.freedesktop.org>
In-Reply-To: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
References: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:44:09 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdgpu/atom: broken BIOS_ATOM_PREFIX fallback in
  atom_get_vbios_pn()
- [Low] drm/amdgpu/atom: missing Fixes and Signed-off-by trailers in
  commit log
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/amdgpu: buffer underflow in atom_get_vbios_name() [1]
--

commit d8195d5b6067da759e75cbe7469c7a841f107f37
Author: Noah Weinberger <NoahWeinberger2003@proton.me>

> drm/amdgpu/atom: do not dereference NULL vbios string pointer
>
> Hello,
>
> In atom_get_vbios_pn(), when the part-number string is empty and
> atom_find_str_in_rom() cannot find the ATOMBIOS anchor, the fallback
> computes NULL + sizeof(BIOS_ATOM_PREFIX) - 1, i.e. (unsigned char *)8:
>
>     vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64=
);
>     if (vbios_str =3D=3D NULL)
>             vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>
> The subsequent range check is false for a near-NULL pointer, so the
> value survives and *vbios_str dereferences address 8 - a NULL-page oops
> during probe with a malformed VBIOS that passes the magic checks. The
> recent hardening of the neighboring date/version/build helpers closed
> their OOB reads; this fallback path was left intact.
>
> Simply leave the part number empty when the anchor is not found.
>
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670b=
d (v7.4-rc1, 2026-11-07), drivers/gpu/drm/amd/amdgpu/atom.c:1491-1503 (atom=
_get_vbios_pn).
> Pointer-arithmetic-on-NULL is pre-existing; this window's hardening serie=
s made it the sole fallback outcome.
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07);=
 every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
>conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Low]
This commit is missing a Signed-off-by trailer from the author, and the
greeting and report disclaimers belong below the --- separator rather than
in the permanent changelog.  Should it also include a Fixes tag for the
commit that introduced the inverted check:

  Fixes: 29b4c589b43d ("drm/amdgpu: Add vbios info ioctl interface")

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5cf6a5c..7598606afaef1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1493,8 +1493,6 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
> =20
>  	if (vbios_str =3D=3D NULL || *vbios_str =3D=3D 0) {
>  		vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
> -		if (vbios_str =3D=3D NULL)
> -			vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>  		if (vbios_str >=3D p_rom + ctx->bios_size)
>  			vbios_str =3D NULL;
>  	}

[Severity: Medium]
Should this check be inverted to "if (vbios_str !=3D NULL)" instead of
removing the pointer advance?

atom_find_str_in_rom() returns a pointer to the start of the matched
"ATOMBIOS" prefix, which in the ROM layout is followed by a NUL byte and
the part-number string.  Removing the advance leaves vbios_str at the
prefix itself, so the subsequent NUL-skip check:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_get_vbios_pn() {
	...
	OPTIMIZER_HIDE_VAR(vbios_str);
	if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
		vbios_str++;
}

becomes dead code and the copy loop populates ctx->vbios_pn with the
literal string "ATOMBIOS" instead of the part number.  Once the NULL
pointer arithmetic is gone, OPTIMIZER_HIDE_VAR(vbios_str) from
e5f7e4e0a445 ("drm/amdgpu/atom: Work around vbios NULL offset false
positive") can also be dropped.

[Severity: Critical]
This problem wasn't introduced by this patch, but can the space-trimming
loop in the sibling helper atom_get_vbios_name() underflow ctx->name[]
[1]?

drivers/gpu/drm/amd/amdgpu/atom.c:atom_get_vbios_name() {
	...
	name_size =3D strnlen(c_ptr, min(STRLEN_LONG - 1, (int)(p_end - c_ptr)));
	memcpy(ctx->name, c_ptr, name_size);
	back =3D ctx->name + name_size;
	while ((*--back) =3D=3D ' ')
		;
	*(back + 1) =3D '\0';
	...
}

If the VBIOS name string consists entirely of spaces (or is empty and the
preceding byte in struct atom_context happens to be 0x20), back decrements
past the start of ctx->name[] until it hits a non-space byte and then
overwrites the byte after it with a NUL terminator, corrupting earlier
fields of struct atom_context.

[1] https://sashiko.dev/#/bug/linux-ad8886ee-341a-464b-9d34-3723f5f4a62e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4VYoOFUjYIK--SKrUsi=
jHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8=
Zdk8sX_rFaZIA=3D@proton.me?part=3D1
