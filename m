Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C622606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlF3ob4Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC82710F441;
	Tue, 24 Nov 2026 10:16:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE9D10F453
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:16:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C19344722;
 Tue, 24 Nov 2026 10:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234B01F000D0;
 Tue, 24 Nov 2026 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795515404;
 bh=jHPJOc/q0o6KEmj0ydWjNR9DwC5/BwEdm54tMJEhsrs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SlF3ob4Z1D4pYaf+kKCZhHHuk7InJAXYul3sSL3TdKBVsauHXo6gL/eyr2cmM15xu
 7HqFzgwPeYQRfN3NSHGyIw+VAAzCzHbPWqcH+3CkLo3bkN4Hz2s6z+ThRd7KSNKFqe
 9c6r2LJiApp6jM3/oxpDl64c/5aRYNMcARyJmMP7Hn9cvKb1lsAZGqHNwvk/HOy5hv
 fS0Pt3t/HyYTL6++yQAzH2OaMcdCi1SpMEXYCEIFZX5+ksWHQ7lfJ/iTLc53jOQ39s
 Hxy7u2Ha2rE7NNRS0N10x9FnOjqDvFdmPvMlRlp88U/202Q2tvtzyQvm4WBdn46hHH
 rbOa9zlJW5FoQ==
Message-ID: <sashiko-outbox-230957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] drm/bridge: tc358762: Support VTG
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-tc358762-fixes-v6-8-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
 <20261124-tc358762-fixes-v6-8-bd38fed6460f@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:16:43 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: tc358762: missing select VIDEOMODE_HELPERS for
  tc358762_init()
--

commit e89c5a10c43147502d01b30bb7357df0b928ed52
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: tc358762: Support VTG

This commit adds support for the TC358762 Video Timings Generator (VTG)
and enables it by default to program DPI output timings directly into the
bridge registers.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index 59323f26b2d28..3ccb5aa404461 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
[ ... ]
> @@ -155,9 +163,31 @@ static int tc358762_init(struct tc358762 *ctx)
>  	tc358762_write(ctx, PPI_D1S_ATMR, 0);
>  	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
> =20
> +	if (ctx->use_vtg) {
> +		struct videomode vm =3D { 0 };
> +
> +		drm_display_mode_to_videomode(&ctx->mode, &vm);

[Severity: Medium]
Does DRM_TOSHIBA_TC358762 in drivers/gpu/drm/bridge/Kconfig need to select
VIDEOMODE_HELPERS?  drm_display_mode_to_videomode() is only built when
CONFIG_VIDEOMODE_HELPERS is enabled, so linking fails if nothing else in
the configuration selects it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-tc358762-f=
ixes-v6-0-bd38fed6460f@ideasonboard.com?part=3D8
