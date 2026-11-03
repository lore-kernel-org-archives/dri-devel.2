Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DA606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpHyMZOk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBF610E0DE;
	Tue,  3 Nov 2026 20:27:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D13710E0DE
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9EF542155;
 Tue,  3 Nov 2026 20:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F86C1F000C1;
 Tue,  3 Nov 2026 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793737641;
 bh=4Gr30hD69v+Y48w8nPX0RP2CV/BQjw2OgObIdnaaAXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QpHyMZOkv2wWX4a6f6eS6FXaxO6uThSPw6+zPXAg305Kk8QKiERjcLN43clS6CDKI
 Xq1SQCyWJE5eIhljQ1wu8kKGngWcPU3T1RJuE/wctkcHog1ULUXydsolyZs08kjCXo
 btuSM6yLwk3sP2/8ak8uV+K9Kimb2YRARNmAzJXHs6+yKDxi19EfQ3+tbOnOCPucO3
 Sz78E5nej15mCKZi7ZO2MndtNugjo6HXwVSk4GFyU4GB9CoOg4YzyMgSDPB/gHK/pJ
 6ZuZgyMJiRm59Gx8xeTNyDauQd5OVQhtOIcZrksk2BmN9ShckXwmfVXTLZg2+ud9AT
 v9eyaLqPxr8mg==
Message-ID: <sashiko-outbox-195991@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/nouveau/kms/nv50-: don't enable a DP output
 with no trained link
To: "David R. Hedges" <linuxdev844@thelittleman.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-nouveau-dp-relink-v1-2-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
 <20261103-nouveau-dp-relink-v1-2-7ee88c7f1e8a@thelittleman.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:27:21 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/nouveau/kms/nv50-: nv50_audio_enable() called on untrained d=
etached DP output
--

commit 9c72b9cc42ad5c2146710feb85347fdc8865d8f1
Author: David R. Hedges <linuxdev844@thelittleman.net>

drm/nouveau/kms/nv50-: don't enable a DP output with no trained link

This commit changes nouveau_dp_train() to return an error code and updates
nv50_sor_atomic_enable() to leave the SOR detached, mark the connector
link-status as bad, and schedule a hotplug event when no lane count and
link rate can carry the mode.

Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 8af01de822d52..7f55c016d8465 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1843,7 +1843,15 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder=
, struct drm_atomic_commit *st
>  		nvif_outp_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);
>  		break;
>  	case DCB_OUTPUT_DP:
> -		nouveau_dp_train(nv_encoder, false, mode->clock, asyh->or.bpc);
> +		/* Attaching the SOR to a link that hasn't been trained can hang
> +		 * the display engine.  If the link can't carry the mode at all,
> +		 * which atomic check only rules out for a modeset, leave the
> +		 * output detached and tell userspace the link is bad.
> +		 */
> +		if (nouveau_dp_train(nv_encoder, false, mode->clock, asyh->or.bpc) =3D=
=3D -EINVAL) {
> +			schedule_work(&nv_connector->link_bad_work);
> +			return;
> +		}

[Severity: Medium]
When nv50_sor_atomic_enable() returns early here on -EINVAL, does this still
end up enabling DP audio on the untrained and detached SOR?

Earlier in nv50_sor_atomic_enable(), nv_encoder->crtc is assigned and the S=
OR
is acquired with hda enabled when nv_connector->base.display_info.has_audio=
 is
true:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_sor_atomic_enable() {
	...
	nv_connector =3D nv50_outp_get_new_connector(state, nv_encoder);
	nv_encoder->crtc =3D &nv_crtc->base;

	if ((disp->disp->object.oclass =3D=3D GT214_DISP ||
	     disp->disp->object.oclass >=3D GF110_DISP) &&
	    nv_encoder->dcb->type !=3D DCB_OUTPUT_LVDS &&
	    nv_connector->base.display_info.has_audio)
		hda =3D true;

	if (!nvif_outp_acquired(outp))
		nvif_outp_acquire_sor(outp, hda);
	...
}

In the caller nv50_disp_atomic_commit_tail(), outp->enabled is set to true
unconditionally after help->atomic_enable() returns:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_disp_atomic_commit_tail() {
	...
		if (outp->set.mask) {
			help->atomic_enable(encoder, state);
			outp->enabled =3D true;
			interlock[NV50_DISP_INTERLOCK_CORE] =3D 1;
		}
	...
}

Then in nv50_disp_atomic_commit_core(), the post-update loop sees
outp->enabled and calls nv50_audio_enable():

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_disp_atomic_commit_core() {
	...
			if (outp->enabled) {
				nv50_audio_enable(outp->encoder, nouveau_crtc(nv_encoder->crtc),
						  nv_encoder->conn, NULL, NULL);
				outp->enabled =3D outp->disabled =3D false;
			}
	...
}

When a DP sink with audio in its EDID has link capabilities below what the
mode needs (or cleared after AUX stopped answering while HPD remained
asserted) and a commit turns the CRTC back on, nv50_audio_enable() will call
nvif_outp_hda_eld() on an output whose link was never trained, whose DP str=
eam
was never configured, and whose SOR was left detached from the head.

On non-GSP GPUs (gt215_sor_dp_audio, gf119_sor_dp_audio, gv100_sor_dp_audio=
),
that triggers DP_AUDIO_CTRL on the unattached SOR and busy-polls for up to
2000ms waiting for the new-settings trigger bit to clear. On GSP-RM
(r535_sor_dp_audio, r535_sor_hda_eld), it issues
NV0073_CTRL_CMD_DFP_SET_AUDIO_ENABLE, NV0073_CTRL_CMD_DP_SET_AUDIO_MUTESTRE=
AM,
and NV0073_CTRL_CMD_DFP_SET_ELD_AUDIO_CAPS (each wrapped in WARN_ON) on an
unconfigured DP stream and notifies ALSA that audio is active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nouveau-dp=
-relink-v1-0-7ee88c7f1e8a@thelittleman.net?part=3D2
