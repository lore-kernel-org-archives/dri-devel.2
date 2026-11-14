Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E36606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eP8KdGWX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587FF10E722;
	Sat, 14 Nov 2026 14:01:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3467910E876
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA19B4342C;
 Sat, 14 Nov 2026 14:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97D1F000C4;
 Sat, 14 Nov 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794664863;
 bh=wR2ILgnUIsqRqNoOCM29elUeP8W+lyv9jFKYCF5am7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eP8KdGWXgNu7bZDera+U8qY7lh8dW8HZobIRxjqntlcga9nMga4tSEg3UnQQ+/D8C
 uSZ0xMD8wT3tKVrTINfV/7jC16pd8Zcl0tD0q/NFoTSf75a6k41aQHFevenIhe4s/s
 u1LO3UJ77lRjomwrG68I42cUniN1lS4PxMIsH3Ryn/zS9p9VSU50V4hRIafMjhTNPo
 VAbMlwVqyFjU5Jv7Sz0+eX7yI29YzuPqmhXk7FxaLaELIhdP46sJJR3jaO1bRwah8m
 SV5wuXU6Qtwou0nAQvQcidKplYW7rkd7Z0VTh5bYq7UwNBaio09vG1568gSBOPjw8G
 ZIfy/iIsfJ7hg==
Message-ID: <sashiko-outbox-214599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: newvision-nv3051d: Propagate init sequence
 errors to prepare()
To: "Archit More" <architmore303@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114135251.32775-1-architmore303@gmail.com>
References: <20261114135251.32775-1-architmore303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:01:03 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panel: newvision-nv3051d: missing Fixes: trailer for init
  error fix
--

commit 99328fc94545f2992a1fb5b8fdaa4985cf1f91dc
Author: Archit More <architmore303@gmail.com>

> drm/panel: newvision-nv3051d: Propagate init sequence errors to prepare()
>
> In commit 3944ca3e6b7d ("drm/panel: newvision-nv3051d: Use
> mipi_dsi_*_multi(); fix minor bugs"), prepare() and unprepare() were
> converted to use mipi_dsi_*_multi() helpers, but
> panel_nv3051d_init_sequence() continued using its own local struct
> mipi_dsi_multi_context and unconditionally returned 0. Consequently,
> errors encountered during the panel init sequence were discarded and
> never reached prepare().
>
> Convert panel_nv3051d_init_sequence() to take struct
> mipi_dsi_multi_context * directly from prepare() so all DCS commands
> share the same context. Referred to panel-elida-kd35t133 to solve
> the issue.
>
> Signed-off-by: Archit More <architmore303@gmail.com>

[Severity: Low]
panel_nv3051d_init_sequence() started discarding DCS write errors in
bfbdf72d6c14 ("drm/panel: nv3051d: Transition to
mipi_dsi_dcs_write_seq_multi"), which switched it to a local
mipi_dsi_multi_context while leaving the trailing "return 0;".  Should
this include:

  Fixes: bfbdf72d6c14 ("drm/panel: nv3051d: Transition to mipi_dsi_dcs_writ=
e_seq_multi")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114135251.3277=
5-1-architmore303@gmail.com?part=3D1
