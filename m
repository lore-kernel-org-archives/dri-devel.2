Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BF6082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=mFTHf5TF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259A710F135;
	Mon,  9 Nov 2026 09:31:43 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B11C10E111
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794177067; x=1794436267;
 bh=hrR6uj82ahGfQqaO3EwipOvU/f/xUlTfwnwZhxjl76c=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mFTHf5TFf7pz7nD7JJqYXcJfFZV7+IWxpkOnDapWSq0S5T6VlsdsYlgwuX29P8n3/
 jIoM6KCyqtl39W+9Oz7k5xIMzWxxUHO/T20keouB6FoEiNOYXe0W9SFzDEeLQXH14J
 LbGjG3S4+be9QmGGI51K6hDRcn8+QiEAYHTnpB0959bc/GRsjd3tPhyhJPiy2zZJCB
 mPhFmxFIJ4aUwsqLgrk/XhDnTwydTqsAc2mQDWKP6E+YNgHI0DPyobfVsQbS3hDtzO
 j8bB7D+D0V7d2BoJL/pz+//it5/2OHEQZrbSRkBJtCxUBMOkaV2LHjfmNh4fzlJxZB
 GumiUYx0oAzMw==
Date: Sun, 08 Nov 2026 22:31:02 +0000
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.com" <simona@ffwll.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu/atom: do not dereference NULL vbios string pointer
Message-ID: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: adc73b7730ce65d5d72be26e93817641b3bd221b
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

In atom_get_vbios_pn(), when the part-number string is empty and
atom_find_str_in_rom() cannot find the ATOMBIOS anchor, the fallback
computes NULL + sizeof(BIOS_ATOM_PREFIX) - 1, i.e. (unsigned char *)8:

    vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
    if (vbios_str =3D=3D NULL)
            vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;

The subsequent range check is false for a near-NULL pointer, so the
value survives and *vbios_str dereferences address 8 - a NULL-page oops
during probe with a malformed VBIOS that passes the magic checks. The
recent hardening of the neighboring date/version/build helpers closed
their OOB reads; this fallback path was left intact.

Simply leave the part number empty when the anchor is not found.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), drivers/gpu/drm/amd/amdgpu/atom.c:1491-1503 (atom_g=
et_vbios_pn).
Pointer-arithmetic-on-NULL is pre-existing; this window's hardening series =
made it the sole fallback outcome.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index 1a599d5..7598606 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1493,8 +1493,6 @@ static void atom_get_vbios_pn(struct atom_context *ct=
x)
=20
 =09if (vbios_str =3D=3D NULL || *vbios_str =3D=3D 0) {
 =09=09vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 6=
4);
-=09=09if (vbios_str =3D=3D NULL)
-=09=09=09vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
 =09=09if (vbios_str >=3D p_rom + ctx->bios_size)
 =09=09=09vbios_str =3D NULL;
 =09}

