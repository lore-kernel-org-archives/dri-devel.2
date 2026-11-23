Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DE606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyXrNYNb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF3D10EE78;
	Mon, 23 Nov 2026 14:30:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE7610EE78
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:30:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B907E62182;
 Mon, 23 Nov 2026 14:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550541F000C6;
 Mon, 23 Nov 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795444217;
 bh=Xk+YmOAj17ouxN58iXvXBAeD0739dTcsavlOem5Yt/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YyXrNYNbNfmc1B1/OADraryvbgraHG+NG6SejeYbAGpbANMj9SjHusrtqegNSSE00
 vgEunIaExPv/Y/G1kJMFK+aeXNvMXO8WICP1BX6WCKqPETZZAbPD+sLiYMgynDkis/
 lfovQ/w7/8DPcUcJwctGsZlJ6Mc6wdoZtVzanJ40A8h/l4R+ssG6N+d1yPzSTZzLnK
 UlemCinffCIgVhr0a7eDursDcnuhN3lnW0cLS9aDe3MRcNm7QM4IQaa5wDxIijiKUE
 WeFRsWbHeRDoYo15qMKWl1mcoDRIDhEUppqOtjhd05MQmnHqPthlacxDXKwprmL28v
 NsuiDY1vwo+WQ==
Message-ID: <sashiko-outbox-229398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau/dispnv50: reject DP modes that don't
 fit the link
To: =?utf-8?b?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261123101659.600247-3-frederic.mahe@cirad.fr>
References: <20261123101659.600247-1-frederic.mahe@cirad.fr>
 <20261123101659.600247-3-frederic.mahe@cirad.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 14:30:16 +0000
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
- [Medium] drm/nouveau: incomplete DP mode check condition in
  nv50_outp_atomic_check()
--

commit 943220be5958f2da589b892e0f39c0caa93bf128
Author: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>

drm/nouveau/dispnv50: reject DP modes that don't fit the link

This commit rejects DisplayPort modes in nv50_outp_atomic_check() when
nv50_dp_mode_valid() indicates that the mode exceeds the link capacity even
after reducing the bpc.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 98a5188f65234..d7582ed8026b1 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -423,6 +423,21 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
>  	/* We might have to reduce the bpc */
>  	nv50_outp_atomic_fix_depth(encoder, crtc_state);
> =20
> +	/* Reject a mode that does not fit the DP link even at the lowest bpc:
> +	 * link training would fail and the display would stay dark.  Only
> +	 * when the link capabilities are known, so that a sink that is
> +	 * asleep or still resuming does not make every commit fail.
> +	 */
> +	if (crtc_state->mode_changed && crtc_state->active) {
> +		struct nouveau_encoder *nv_encoder =3D nouveau_encoder(encoder);
> +
> +		if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP &&
> +		    nv_encoder->dp.link_nr && nv_encoder->dp.link_bw &&
> +		    nv50_dp_mode_valid(nv_encoder, &crtc_state->adjusted_mode,
> +				       NULL) !=3D MODE_OK)
> +			return -EINVAL;
> +	}

[Severity: Medium]
Should this condition be (crtc_state->mode_changed ||
crtc_state->connectors_changed), matching the bpc check earlier in
nv50_outp_atomic_check()?

If connector routing or a connector property changes without changing the
CRTC mode, crtc_state->connectors_changed is set while
crtc_state->mode_changed remains false.  This check is then skipped, even
though nv50_disp_outp_atomic_check_set() tests
drm_atomic_crtc_needs_modeset() and still enables the DP output and runs
link training with the out-of-range mode.

Also, struct drm_crtc_state documents that atomic_check callbacks must not
consult crtc_state->active to reject a commit.  Gating on crtc_state->active
allows an out-of-range mode to be committed while active is false; a later
DPMS ON commit only sets active_changed (with mode_changed false), bypassing
this check as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123101659.6002=
47-1-frederic.mahe@cirad.fr?part=3D2
