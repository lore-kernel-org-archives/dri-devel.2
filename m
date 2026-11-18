Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E89606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=tebb4fnq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D01EC10FBDD;
	Wed, 18 Nov 2026 12:47:03 +0000 (UTC)
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF41510FBDD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795006011; x=1795265211;
 bh=GnW0DGN9umZ2ZPe8NX9ttfPkdxxYQUm5WmzEN0TBkyw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=tebb4fnq7ardpOpgBaalbX31+XQmatsUrvMH59Fs0Wf43hxGnGhwm4fQSKk75kCY+
 rawfxzmwmf+rQIJ0sieEiXvU9I/ZYdrqdhQEAZ1LLtTd3FBGxPhYn//7PbQ2125ArJ
 kGc1CQvfT/46j0kJnGCbwjzhvdvVxAr71pf63QELdGC+Qa6Qj0+YatgrLVPHyaTkBJ
 nf7tJBAlKTPL2KsXqdauf/Iuyvn2YG8k59b2V7R+Co6akBg+zPP6Mp8QO3BgIfInpr
 7NLX5DigYhFJmYY64OHqharBJkTQTb/lyUA0jLn1rR0JRTRYpod84qr8GvfvXIXzie
 H1EvkfXVTzwXQ==
Date: Wed, 18 Nov 2026 12:46:45 +0000
To: Cooper Morgan <ext-github@cwooper.dev>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: Wayne.Lin@amd.com, oss@oysterdaisuki.com, harry.wentland@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/amd/display: Fix FreeSync infopacket refresh
 rates above 255 Hz
Message-ID: <HftAWPKURVjBtK_2BmUiLXOb8ghZxaEzAJSg0tlsmy5L3ckJyDWc6g65vrsVGdA3ZcytB6mPuyxaQbsPawfOZmdC1dyAo4lCbaK3Tj7Tm-U=@protonmail.com>
In-Reply-To: <20261117183440.552477-1-ext-github@cwooper.dev>
References: <20261113010529.11514-1-ext-github@cwooper.dev>
 <20261117183440.552477-1-ext-github@cwooper.dev>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 3e585c3816178facb6e494cafc8eb195ccbfea00
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wayne, Cooper,

One more difference worth knowing about if v2 gets swapped in:
ae60ec4dcfc4 ("drm/amd/display: Use FreeSync v3 infopacket for sinks
above 255 Hz") is missing the amdgpu_dm_connector.c hunk of patch 2/2.
The posted patch changes four files (92 insertions, 1 deletion) in both
v1 and v2, but the commit only changes three (91 insertions).

The missing hunk is the one that stores the AMD VSDB version for every
DP/eDP sink:

=09get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+=09amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_info.amd_vsdb_=
version;

=09if (vsdb_info.replay_mode) {
=09=09amdgpu_dm_connector->vsdb_info.replay_mode =3D vsdb_info.replay_mode;
-=09=09amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_info.amd_vs=
db_version;

Without it, a native DP sink without Replay never records VSDB v3, so it
never gets the v3 packet, and the DP side of the >255 Hz fix has no
effect. The KUnit test added by the same patch catches this on
amd-staging-drm-next 8dd68a79583a:

  # dm_test_fs_caps_dp_vsdb_version: EXPECTATION FAILED at drivers/gpu/drm/=
amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:9925
  Expected ctx->aconnector->vsdb_info.amd_vsdb_version =3D=3D 3, but
      ctx->aconnector->vsdb_info.amd_vsdb_version =3D=3D 0 (0x0)

The failure is easy to miss right now, because the amdgpu_dm KUnit run
panics earlier in dm_test_i2c_xfer_no_ddc_pin() (I've reported that on
the "Route connector DDC over AUX" thread). With that test fixed and
this hunk restored, all 1931 amdgpu_dm tests pass here. Patch 1/2
(bedad38a7ddf) landed complete.

Thanks,
Eren
