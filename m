Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B913CCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2B410E636;
	Mon, 15 Jun 2026 20:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Roh7cAoQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A7A10E636
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:25:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0716360172;
 Mon, 15 Jun 2026 20:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3AF1F000E9;
 Mon, 15 Jun 2026 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555145;
 bh=qAJv3DU54/a00xN2tX+SKEevGqy1Jq11gjUPRl7SarU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Roh7cAoQ15otl8hvGYVmnnnMx/WnbGQgc4ww0TL7tiRN5iGXWJTDTLLdsz3qYfljc
 Bt0ANdGf91WOPUEXSOXRX/Fw6+A3+QUzIk4hMJybUV8cK/bicxx/pYVYhGOzSK8jbH
 4AhlfnESrmdJyW8Hax4+x43Zhl6H4LR18mhwJSGaytygCO6SDsuJd6AmDgled461Oy
 sUaTlNdiYWy5jX+6RBrCLl4dWuPqQVXZZdvWVt9o1EeBGNsfcLXCNNVAWDrbhjXjW4
 AJp9y9dotg8YTZTT0efb3FR3J5qiv+byD3bIBwpKOxvD0D7FBkdxnrE8K2y04gbmug
 /UGYrZf1rnaJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/27] drm/i915/display: Move vblank put until after
 critical section
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-6-dev@lankhorst.se>
References: <20260615201846.307297-6-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:25:45 +0000
Message-Id: <20260615202545.8D3AF1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling drm_crtc_vblank_put() before drm_vblank_work_schedule() =
drops the vblank reference prematurely, causing an unnecessary hardware vbl=
ank interrupt disable/enable ping-pong.
--

commit dab5c95932db89533ab47f96a5f94a420c7489c9
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Move vblank put until after critical section

This patch moves the vblank put operation out of a critical section to
prevent taking locks during time-sensitive code in
intel_legacy_cursor_update().

> diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/dr=
m/i915/display/intel_cursor.c
> --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> +++ b/drivers/gpu/drm/i915/display/intel_cursor.c
[ ... ]
> @@ -939,6 +940,9 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
> =20
>  	intel_psr_unlock(crtc_state);
> =20
> +	if (has_vblank)
> +		drm_crtc_vblank_put(&crtc->base);
> +
>  	if (old_plane_state->ggtt_vma !=3D new_plane_state->ggtt_vma) {
>  		drm_vblank_work_init(&old_plane_state->unpin_work, &crtc->base,
>  				     intel_cursor_unpin_work);
> =20
>  		drm_vblank_work_schedule(&old_plane_state->unpin_work,
>  					 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
>  					 false);

[Severity: Medium]
The commit message notes that we might not need to disable the vblank
interrupt if drm_vblank_work_schedule() takes its own reference.=20

However, because drm_crtc_vblank_put() drops the reference right before
the if-block, could the reference count drop to zero and trigger an
unnecessary hardware vblank interrupt disable?=20

If that happens, drm_vblank_work_schedule() taking a new reference just
below would immediately re-enable it, creating an unnecessary disable/enable
ping-pong.

Would moving the drm_crtc_vblank_put() call below the work scheduling block
better achieve the optimization mentioned in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D5
