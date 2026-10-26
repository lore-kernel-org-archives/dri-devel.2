Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E6606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyONEJhz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF3A10E398;
	Mon, 26 Oct 2026 19:29:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BB710E398
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:29:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6952403F0;
 Mon, 26 Oct 2026 19:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEECB1F01825;
 Mon, 26 Oct 2026 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042963;
 bh=y9pqkVqBLHTAFE1kT38MetMXgHPlXzJ9k4cGnQNqIIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XyONEJhza4yI7/X5WVxO9rvhF9mKBu6F783RdKNp9qfbLC6CjPUuYLRfrI/+HdmC3
 IeZ0n5yVk3GszJUp99Hesnk7pEzX97xqF6/OWiDFqcOjO68Hs4ywmft5lkti+QTOYK
 8VM6/FgVWgxMzB/NJ+umu6qxonWbEBaybaFYTKuOyDhxCqyQxZgFWc4BNz9RkUdqQ+
 iHEJAxx/KG7h+CN4w6ohao+xKEgJmnWLyTd2AaMSo6DGsoxyWkpMSd6InzX2TkCsb2
 jjzL/fDsKdwg2KFMW6QnDEMlGixWRVNHH5uzE1+uc0C/fb+t75ygOJcKXssK58xNz9
 iacCqKnSS1kMg==
Message-ID: <sashiko-outbox-185674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] drm/msm/dpu: save LMs in encoder mode_set for
 cleanup use later
To: "Xi Zhang" <xz.ca.cn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-msm-dpu-res-clean-v1-2-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
 <20261026-msm-dpu-res-clean-v1-2-f46130a8a717@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:29:23 +0000
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
- [Medium] drm/msm/dpu: incomplete blendstage reset in dpu_encoder_helper_r=
eset_mixers()
--

commit d3a43e897b19cb72f6d34115067a2c68f2bef217
Author: Xi Zhang <xz.ca.cn@gmail.com>

drm/msm/dpu: save LMs in encoder mode_set for cleanup use later

This commit caches layer mixers in dpu_encoder_virt during atomic_mode_set =
so
that dpu_encoder_helper_reset_mixers() cleans up the previously assigned
mixers rather than querying the post-swap global state. It also removes the
ctl->ops.setup_blendstage() call from dpu_encoder_helper_reset_mixers().

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 8d2b4d2726f27..09afc0681248f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c

[ ... ]

> @@ -2183,42 +2194,34 @@ void dpu_encoder_kickoff(struct drm_encoder *drm_=
enc)
> =20
>  static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phy=
s_enc)
>  {
> -	int i, num_lm;
> -	struct dpu_global_state *global_state;
> -	struct dpu_hw_blk *hw_lm[2];
> -	struct dpu_hw_mixer *hw_mixer[2];
> +	int i;
>  	struct dpu_hw_ctl *ctl =3D phys_enc->hw_ctl;
> +	struct dpu_encoder_virt *dpu_enc =3D to_dpu_encoder_virt(phys_enc->pare=
nt);
> =20
>  	/* reset all mixers for this encoder */
>  	if (ctl->ops.clear_all_blendstages)
>  		ctl->ops.clear_all_blendstages(ctl);
> =20
> -	global_state =3D dpu_kms_get_existing_global_state(phys_enc->dpu_kms);
> +	for (i =3D 0; i < ARRAY_SIZE(dpu_enc->hw_mixer); i++) {
> +		if (dpu_enc->hw_mixer[i]) {
> +			if (ctl->ops.update_pending_flush_mixer)
> +				ctl->ops.update_pending_flush_mixer(ctl, dpu_enc->hw_mixer[i]->idx);
> =20
> -	num_lm =3D dpu_rm_get_assigned_resources(&phys_enc->dpu_kms->rm, global=
_state,
> -		phys_enc->parent->crtc, DPU_HW_BLK_LM, hw_lm, ARRAY_SIZE(hw_lm));
> -
> -	for (i =3D 0; i < num_lm; i++) {
> -		hw_mixer[i] =3D to_dpu_hw_mixer(hw_lm[i]);
> -		if (ctl->ops.update_pending_flush_mixer)
> -			ctl->ops.update_pending_flush_mixer(ctl, hw_mixer[i]->idx);
> -
> -		/* clear all blendstages */
> -		if (ctl->ops.setup_blendstage)
> -			ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
> -
> -		if (hw_mixer[i]->ops.clear_all_blendstages)
> -			hw_mixer[i]->ops.clear_all_blendstages(hw_mixer[i]);
> +			/* clear all blendstages */
> +			if (dpu_enc->hw_mixer[i]->ops.clear_all_blendstages)
> +				dpu_enc->hw_mixer[i]->ops.clear_all_blendstages(
> +					dpu_enc->hw_mixer[i]);
> +		}
> +	}

[Severity: Medium]
Does ctl->ops.clear_all_blendstages() completely cover what
ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL) was doing here?

When dpu_encoder_virt_atomic_disable() -> dpu_encoder_helper_phys_cleanup()=
 ->
dpu_encoder_helper_reset_mixers() runs on DPU hardware with core_major_ver =
< 12,
ctl->ops.clear_all_blendstages invokes dpu_hw_ctl_clear_all_blendstages() in
drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:

static void dpu_hw_ctl_clear_all_blendstages(struct dpu_hw_ctl *ctx)
{
	struct dpu_hw_blk_reg_map *c =3D &ctx->hw;
	int i;

	for (i =3D 0; i < ctx->mixer_count; i++) {
		enum dpu_lm mixer_id =3D ctx->mixer_hw_caps[i].id;

		DPU_REG_WRITE(c, CTL_LAYER(mixer_id), 0);
		DPU_REG_WRITE(c, CTL_LAYER_EXT(mixer_id), 0);
		DPU_REG_WRITE(c, CTL_LAYER_EXT2(mixer_id), 0);
		DPU_REG_WRITE(c, CTL_LAYER_EXT3(mixer_id), 0);
	}

	DPU_REG_WRITE(c, CTL_FETCH_PIPE_ACTIVE, 0);
}

By contrast, dpu_hw_ctl_setup_blendstage() with stage_cfg =3D=3D NULL did:

	mixercfg[0] =3D CTL_MIXER_BORDER_OUT; /* always set BORDER_OUT */

	if (!stage_cfg)
		goto exit;
...
exit:
	DPU_REG_WRITE(c, CTL_LAYER(lm), mixercfg[0]);
	DPU_REG_WRITE(c, CTL_LAYER_EXT(lm), mixercfg[1]);
	DPU_REG_WRITE(c, CTL_LAYER_EXT2(lm), mixercfg[2]);
	DPU_REG_WRITE(c, CTL_LAYER_EXT3(lm), mixercfg[3]);
	if (ctx->mdss_ver->core_major_ver >=3D 9)
		DPU_REG_WRITE(c, CTL_LAYER_EXT4(lm), mixercfg[4]);

Without ctl->ops.setup_blendstage(), on DPU v9.x through v11.x platforms
CTL_LAYER_EXT4(lm) is never cleared during mixer reset (leaving any staged
SSPP_DMA4 or SSPP_DMA5 bits set), and on DPU < v5 (where
ctl->ops.reset_intf_cfg is not implemented) CTL_LAYER(lm) is left as 0
instead of having CTL_MIXER_BORDER_OUT set.

Should dpu_hw_ctl_clear_all_blendstages() be updated to also clear
CTL_LAYER_EXT4(mixer_id) on core_major_ver >=3D 9 (and preserve
CTL_MIXER_BORDER_OUT if needed), or should the setup_blendstage() call be
kept?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-msm-dpu-re=
s-clean-v1-0-f46130a8a717@gmail.com?part=3D2
