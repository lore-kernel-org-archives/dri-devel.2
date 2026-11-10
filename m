Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F6606A335
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OasEJ3Tu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE79710E1AC;
	Tue, 10 Nov 2026 17:30:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AA910E1AC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:30:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32D1A40B3F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C61F0089F;
 Tue, 10 Nov 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794331809;
 bh=Rps9zD0Jyiwr4ERHcSDqjDIJzBrZb2Y23nJxD0sk648=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OasEJ3TuzK97NyqYP+AJk7d/7Roqo8JJbMX2XIYehC2nvaGu1Zwjx/crZVYRIVGl/
 jER+n6NJVrKKbf7d722RztDb0uG4I0SHLOZaneRjn29WgOPmvW12waD88ra4fPs2jD
 /EXXapwEsZuAJlKJoPkyFtVlfAt04agYMec35k+aKud5K1zZRe5Vq+e9SNTnj0PRVV
 HcVy69KbSXIBAS0wv3xKc+vNaz8r6w0TCWGBn0cM3jGJ5Mnax+nX6lJu/vqk2Ns7bf
 jYqC6Zx2IO2ASiDtyekiLdv+wi1+9lHYPK/pJaZkG2WCYi8TLvhIEOWIPCrp1Q7spk
 3yXHI/k6G52mA==
Message-ID: <sashiko-outbox-207478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/10] drm/msm/dpu1: Carry the mixers over to created
 CRTC states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-drm-reset-state-flag-v9-8-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
 <20261110-drm-reset-state-flag-v9-8-ddb0e26324a0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 17:30:08 +0000
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
- [Medium] drm/msm/dpu: stale mixers and dead CTLs copied in
  dpu_crtc_atomic_check()
--

commit 1b109324be16b20d23b18d888d3626797044015c
Author: Maxime Ripard <mripard@kernel.org>

drm/msm/dpu1: Carry the mixers over to created CRTC states

This commit copies mixers and CTLs from the old CRTC state to the new
CRTC state in dpu_crtc_atomic_check() when the new state has no mixers
assigned and no modeset occurred.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 77a2d1f6700d0..97deadc976ed7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1540,6 +1540,27 @@ static int dpu_crtc_atomic_check(struct drm_crtc *=
crtc,
>  		rc =3D dpu_crtc_assign_resources(crtc, crtc_state);
>  		if (rc < 0)
>  			return rc;
> +	} else if (!cstate->num_mixers) {
> +		struct dpu_crtc_state *old_cstate =3D
> +			to_dpu_crtc_state(drm_atomic_get_old_crtc_state(state,
> +									crtc));
> +
> +		/*
> +		 * A CRTC that keeps its configuration keeps its mixers.
> +		 * A duplicated state carries them over, but a state
> +		 * created through atomic_create_state() comes with
> +		 * none, so copy them from the current state like a
> +		 * duplicated state would, to make sure the checks and
> +		 * the commit see the mixers in use.
> +		 */
> +		if (old_cstate->num_mixers) {
> +			cstate->num_mixers =3D old_cstate->num_mixers;
> +			memcpy(cstate->mixers, old_cstate->mixers,
> +			       sizeof(cstate->mixers));
> +			cstate->num_ctls =3D old_cstate->num_ctls;
> +			memcpy(cstate->hw_ctls, old_cstate->hw_ctls,
> +			       sizeof(cstate->hw_ctls));
> +		}
>  	}
> =20
>  	if (crtc_state->planes_changed || crtc_state->zpos_changed) {

[Severity: Medium]
Can this copy stale mixers onto a disabled CRTC state when
crtc_state->enable is false?

When a CRTC is disabled in an earlier commit that uses
dpu_crtc_duplicate_state(), dpu_crtc_assign_resources() releases the
resources in dpu_rm and returns early on !crtc_state->enable without
clearing cstate->num_mixers or cstate->mixers[]:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_assign_resources() {
    ...
	dpu_rm_release(global_state, crtc);

	if (!crtc_state->enable)
		return 0;
    ...
}

If a subsequent commit built with drm_atomic_commit_fill_with_defaults()
leaves that CRTC disabled, mode_changed, connectors_changed, and
color_mgmt_changed are all false.  This branch then copies the already
released mixers from old_cstate into the new disabled cstate, where
consumers that inspect cstate->num_mixers without checking
crtc_state->enable (such as dpu_crtc_set_crc_source() via
dpu_crtc_setup_lm_misr()) can access hardware resources that may have
been reassigned to another active CRTC.

Also, cstate->num_ctls and cstate->hw_ctls are unused fields in struct
dpu_crtc_state that dpu_crtc_assign_resources() never populates (CTL
pointers are stored in cstate->mixers[i].lm_ctl).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-drm-reset-=
state-flag-v9-0-ddb0e26324a0@kernel.org?part=3D8
