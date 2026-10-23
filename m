Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2473606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MevWOUq3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BB110E76E;
	Fri, 23 Oct 2026 23:42:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B602B10E76E
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:42:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 380FA6022B;
 Fri, 23 Oct 2026 23:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CAF1F01825;
 Fri, 23 Oct 2026 23:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792798935;
 bh=Bwq0wI3Jav3cfwEHo6FDxKwWMpkYXSM38uH2+F8n320=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MevWOUq3XWCAg93YAcig8D5KQsCABxkQqKnpn8W6UvM/k2i7A8VUb4ZJ4Z8+QAAnI
 LKG2ZrE92ERRAcOukqnkK3n3tYnIdjPo6l0YtvprUtAKWfN47smahcm9GtAdoKRL/s
 6WQFU7mwpRxtmiwqVM6tLkWYM+ye0V8Jxa4Yufe/JPrT5JnhYSwvN+OpLIQuhm9xYj
 6pI1e+zQd11tSFN5qNQkYU8GtvSPJF5PQxe4Hdxce/pfX6Cfl0h6wCqMCUaWEnBN12
 ivCe1d+2ijdBxHSSdlFHnYGHNK56ESCxfwhC74Z3t6cDnhVODd77p7NRuvvDHQbQQW
 0YmvI688CXeiA==
Message-ID: <sashiko-outbox-183425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] drm/msm/dpu: clear the DSPP pointer when no
 DSPP is assigned
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-7-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-7-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:42:15 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dpu: clearing hw_dspp in dpu_crtc_assign_resources() leave=
s DSPP enabled
--

commit 1d1b56e93b802629a163cf47cb75949dc3b0cdc9
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned

This commit updates dpu_crtc_assign_resources() to explicitly set
cstate->mixers[i].hw_dspp to NULL when the new topology does not assign a
DSPP block to a mixer, preventing stale DSPP pointers from persisting across
state duplications.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 1f8fce366a1d3..2ff0dab33710b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crt=
c *crtc,
> =20
>  		cstate->mixers[i].hw_lm =3D to_dpu_hw_mixer(hw_lm[i]);
>  		cstate->mixers[i].lm_ctl =3D to_dpu_hw_ctl(hw_ctl[ctl_idx]);
> -		if (i < num_dspp)
> -			cstate->mixers[i].hw_dspp =3D to_dpu_hw_dspp(hw_dspp[i]);
> +		cstate->mixers[i].hw_dspp =3D i < num_dspp ?
> +			to_dpu_hw_dspp(hw_dspp[i]) : NULL;

[Severity: High]
Does clearing cstate->mixers[i].hw_dspp here leave the DSPP PCC and GC
sub-blocks stuck enabled in hardware with stale coefficients and LUTs when
userspace disables color management?

In DPU hardware, each DSPP block sits inline in the datapath between its
layer mixer and pingpong block (per lm_cfg->dspp in the catalog), with no
CTL active-bit bypass mux. The only place in the driver that disables PCC
and GC in the DSPP registers and stages a DSPP flush on the CTL is
dpu_crtc_atomic_begin() -> _dpu_crtc_setup_cp_blocks():

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:_dpu_crtc_setup_cp_blocks() {
	...
	for (i =3D 0; i < cstate->num_mixers; i++) {
		ctl =3D mixer[i].lm_ctl;
		dspp =3D mixer[i].hw_dspp;

		if (!dspp)
			continue;

		if (dspp->ops.setup_pcc) {
			if (!state->ctm) {
				dspp->ops.setup_pcc(dspp, NULL);
			} else {
				_dpu_crtc_get_pcc_coeff(state, &cfg);
				dspp->ops.setup_pcc(dspp, &cfg);
			}

			/* stage config flush mask */
			ctl->ops.update_pending_flush_dspp(ctl,
				mixer[i].hw_dspp->idx, DPU_DSPP_PCC);
		}
	...
}

When userspace enables ctm or gamma_lut, dpu_crtc_get_topology() sets
topology.num_dspp =3D topology.num_lm, dpu_crtc_assign_resources() populates
cstate->mixers[i].hw_dspp, and _dpu_crtc_setup_cp_blocks() enables PCC
and/or GC in the DSPP block and flushes it.

When userspace later disables both ctm and gamma_lut by setting them to
NULL, crtc_state->color_mgmt_changed is set (and msm_atomic_check() also
sets mode_changed =3D true when ctm transitions to NULL), causing
dpu_crtc_atomic_check() to call dpu_crtc_assign_resources():

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_atomic_check() {
	...
	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
	    crtc_state->color_mgmt_changed) {
		rc =3D dpu_crtc_assign_resources(crtc, crtc_state);
		if (rc < 0)
			return rc;
	}
	...
}

Inside dpu_crtc_assign_resources(), dpu_crtc_get_topology() sees both
crtc_state->ctm and crtc_state->gamma_lut as NULL and leaves
topology.num_dspp as 0:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_get_topology() {
	...
	if (crtc_state->ctm || crtc_state->gamma_lut)
		topology.num_dspp =3D topology.num_lm;
	...
}

While dpu_rm_reserve() still assigns the same layer mixer,
dpu_crtc_assign_resources() now sets cstate->mixers[i].hw_dspp to NULL.
When _dpu_crtc_setup_cp_blocks() subsequently runs in
dpu_crtc_atomic_begin(), it sees dspp =3D=3D NULL and continues early, skip=
ping
dspp->ops.setup_pcc(dspp, NULL), dspp->ops.setup_gc(dspp, NULL), and
ctl->ops.update_pending_flush_dspp().

A later commit in the series ("drm/msm/dpu: only reassign resources when
the encoder is reprogrammed") stops calling dpu_crtc_assign_resources() on
color-management-only commits where mode_changed and connectors_changed are
false. However, won't the DSPP sub-blocks still be left enabled whenever
ctm and gamma_lut are cleared in the same atomic commit as a modeset
(where mode_changed or connectors_changed is true), or when a CRTC with
active ctm or gamma_lut is disabled (since dpu_crtc_atomic_begin() returns
early on !crtc->state->enable and dpu_encoder_helper_phys_cleanup() does
not reset or flush DSPP sub-blocks) and a CRTC is subsequently enabled on
the same layer mixer without ctm or gamma_lut?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-fd-kms-fix=
-smmu-v5-0-a5b0b284aead@oss.qualcomm.com?part=3D7
