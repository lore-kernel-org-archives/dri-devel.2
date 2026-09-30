Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B768CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC21D10F1DC;
	Wed, 30 Sep 2026 17:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="luSGv4O2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0DE10F1DC;
 Wed, 30 Sep 2026 17:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D348060252;
 Wed, 30 Sep 2026 17:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EC01F00898;
 Wed, 30 Sep 2026 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788460;
 bh=Zu+jvSbf+tlW8mW3tkzwUVpD015om4XGB6lPNSj3mw4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=luSGv4O2Jy0Srz2qfIM4aFqACV/FQ2xs4AV+vqV8zitQVHQ0/+7GQFMtw7Tpze6yS
 z7j1yJ0rqHenc/NF0fA5Z3RLO6mxkuhzxX2pNwVLt0yEFt9IelH3QY/oBN9R07riLj
 gCpAHKaCYOLT3m/g2F7NHBQ+XOzPtWm2wKjEWr0JPIaTSj7fqwatz4m3H7q7OrNdv/
 KEfAzST6QSna0HCu/p9J5I4flDD0Ab7Dm+q90l1O/ayKO0Ha+HULrUOkAo0CC6ta+1
 eju+ZPpnr91Ho0sIs1T8cWmksvwj76TlGQkescgePaDOw8hR25WIWSCre/IJXI0Obs
 6rpnaI43lHiXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for ADL
To: "Helen Koike" <koike@igalia.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260930170434.317671-1-koike@igalia.com>
References: <20260930170434.317671-1-koike@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:14:19 +0000
Message-Id: <20260930171420.53EC01F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] xe/lrc: Mismatched platform condition applies ADL workaround to al=
l Gen12
- [High] xe/lrc: Hardware defaults corrupted by hardcoded RCS offset for XC=
S engines
--

commit 6eb083cb06a370d43050c04bc2d40604dc4f058f
Author: Helen Koike <koike@igalia.com>

drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for ADL

CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
by inhibit+context save mechanism. Thus, at restore, 0x0 is programed back
to the GPU, which causes sporadic hangs on Alder Lake. Fix it by partially=
=20
reverting commit c9dfd66cb91e and re-adding the programming of=20
CTX_CS_INDIRECT_CTX_OFFSET for Alder Lake.

> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index bf5c2351aed3d..95285ae069290 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
[ ... ]
> @@ -1459,13 +1459,18 @@ setup_indirect_ctx(struct xe_lrc *lrc, struct xe_=
hw_engine *hwe)
> =20
>  	/*
>  	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
> -	 * varies per engine class, but the default is good enough
> +	 * varies per engine class, but the default is good enough, except on
> +	 * Alder Lake.
>  	 */
>  	xe_lrc_write_ctx_reg(lrc,
>  			     CTX_CS_INDIRECT_CTX,
>  			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
>  			     /* Size in CLs. */
>  			     (state.written * sizeof(u32) / 64));
> +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)

[Severity: High]
Does this condition apply the ADL-specific fix to all platforms with graphi=
cs
version < 20?

The commit message and comments explicitly state the intention to limit this
workaround exclusively to Alder Lake. However, checking for graphics version
< 20 evaluates to true for all Gen12 platforms, including DG2, MTL, and PVC,
during LRC context setup in setup_indirect_ctx().

Could this cause hardware misconfiguration on non-ADL platforms that may not
expect or support the CTX_CS_INDIRECT_CTX_OFFSET rewrite, potentially leadi=
ng
to sporadic hangs or context corruption?

> +		xe_lrc_write_ctx_reg(lrc,
> +				     CTX_CS_INDIRECT_CTX_OFFSET,
> +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);

[Severity: High]
Does this code write a hardcoded, RCS-specific default value to all engines
that have INDIRECT_CTX enabled, including non-RCS engines which require a
different offset?

If a non-RCS/CCS engine has indirect context enabled (for example, via
userspace configfs enabling context restore ctx_restore_mid_bb for XCS
engines), setup_indirect_ctx() executes and unconditionally writes
CTX_INDIRECT_CTX_OFFSET_DEFAULT (0xD) without checking the engine class.

As noted in commit c9dfd66cb91e, the correct offset varies per engine class.
Could forcing the RCS-specific 0xD on Video or Copy engines overwrite their
native hardware defaults and cause GPU hangs or context restoration failure=
s?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930170434.3176=
71-1-koike@igalia.com?part=3D1
