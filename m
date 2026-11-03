Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C2606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKRGAJD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4547F10F823;
	Tue,  3 Nov 2026 20:36:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCA110F823
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E932601FF;
 Tue,  3 Nov 2026 20:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299B91F000C1;
 Tue,  3 Nov 2026 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793738195;
 bh=1PzoNEY95Hufbly4DdLFcx3DdEno6Bf+NZkMVmF/tZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cKRGAJD2dW/cXnj8gpR1f9tOyHEhyImyxDTkekQfMEILQ9cEcR9wlxt1VtvaLPU/U
 BRXhyiZxuzy2sKBY7VS4l7Pk3QaQ290u2z0qi39zAap9U4jsrc50X3pKelgg+bcTdW
 4ZW94OO034XA9BFL6Pwbp+2ABVH1ZfNdf3+MO9mYuulwJDoMLT9QTSsekz12v4253F
 Sy2Frnu3GVZ1TTcMyyP394LtaCehYY+5zNJk7CYlNMIEGG1vOnfvELvlJ6lcH37IlY
 crmahjfzopDN4gSURYK69OkwnDvnepCVcmg5tYDwwwzfwLpK+cLbFYh1XT3jAQ6OpZ
 z6COVOZ9Vb+pQ==
Message-ID: <sashiko-outbox-195994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/nouveau/dp: restart an active link when the
 sink reasserts HPD
To: "David R. Hedges" <linuxdev844@thelittleman.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-nouveau-dp-relink-v1-5-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
 <20261103-nouveau-dp-relink-v1-5-7ee88c7f1e8a@thelittleman.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:36:34 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/nouveau: uncancelled link_bad_work and irq_work in nouveau_dis=
play_fini()
- [Medium] drm/nouveau: async link_bad_work in nouveau_display_relink() rac=
es with hotplug
- [Medium] drm/nouveau: nouveau_display_relink() leaves BAD link_status aft=
er recovery
- [Medium] drm/nouveau: nv50_outp_atomic_check() fails drm_atomic_helper_re=
sume() commits
- [Medium] drm/nouveau: nv50_disp_atomic_commit_tail() enables audio on abo=
rted SOR enable
- [Medium] drm/nouveau: nv50_pior_create() does not set nv_connector->dp_en=
coder for DP
- [Medium] drm/nouveau/dp: check active and detected DP encoder before reli=
nking
--

commit 87d2a7cb9667f947ddf67914d19f058419e967fd
Author: David R. Hedges <linuxdev844@thelittleman.net>

drm/nouveau/dp: restart an active link when the sink reasserts HPD

This commit restarts active DisplayPort links with a full CRTC modeset when
the sink signals a plug or unplug HPD event and remains connected, bounded =
by
a rate limit of five restarts within ten-second intervals.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/=
nouveau/nouveau_display.c
> index c5e914602baff..a52db61299626 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c

[ ... ]

> @@ -443,11 +471,18 @@ nouveau_display_relink(struct drm_connector *connec=
tor)
>  	if (ret)
>  		goto out;
> =20
> -	if (crtc->state->active) {
> -		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] restarting link\n",
> -			    connector->base.id, connector->name);
> -		ret =3D drm_atomic_helper_reset_crtc(crtc, &ctx);
> +	if (!crtc->state->active)
> +		goto out;
> +
> +	if (!counted) {
> +		if (!nouveau_display_relink_allowed(connector))
> +			goto out;
> +		counted =3D true;
>  	}
> +
> +	drm_dbg_kms(dev, "[CONNECTOR:%d:%s] restarting link\n",
> +		    connector->base.id, connector->name);
> +	ret =3D drm_atomic_helper_reset_crtc(crtc, &ctx);

[Severity: Medium]
What happens if connector->state->link_status was previously set to
DRM_MODE_LINK_STATUS_BAD (for example after nv50_sor_atomic_enable() or an
earlier nouveau_display_relink() failed when the monitor briefly advertised
reduced capabilities) and a subsequent HPD event triggers
nouveau_display_relink() once full link capabilities are restored?

In drivers/gpu/drm/nouveau/nouveau_display.c:nouveau_display_relink(),
drm_atomic_helper_reset_crtc() duplicates connector->state via
nouveau_conn_atomic_duplicate_state() without resetting link_status to
DRM_MODE_LINK_STATUS_GOOD and without cancelling any pending link_bad_work.

Could a successful link restart in nouveau_display_relink() leave
connector->state->link_status stuck at DRM_MODE_LINK_STATUS_BAD when
userspace processes the hotplug event?

[Severity: Medium]
Can scheduling link_bad_work asynchronously in nouveau_display_relink() race
with the hotplug event sent by nouveau_display_hpd_work()?

In drivers/gpu/drm/nouveau/nouveau_display.c:nouveau_display_relink():

	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);

	/* The sink may now advertise less than the mode needs. */
	if (ret =3D=3D -EINVAL)
		schedule_work(&nouveau_connector(connector)->link_bad_work);

When a DP sink asserts HPD with reduced capabilities that cannot carry the
current CRTC mode, drm_atomic_helper_reset_crtc() fails
nv50_outp_atomic_check() with -EINVAL. nouveau_display_relink() drops
dev->mode_config.connection_mutex and schedules link_bad_work, and then
nouveau_display_hpd_work() immediately sends the hotplug event:

	if (relink) {
		drm_connector_list_iter_begin(dev, &conn_iter);
		nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
			if (relink & drm_connector_mask(connector))
				nouveau_display_relink(connector);
		}
		drm_connector_list_iter_end(&conn_iter);
	}

	if (changed =3D=3D 1)
		drm_kms_helper_connector_hotplug_event(first_changed_connector);
	else if (changed > 0)
		drm_kms_helper_hotplug_event(dev);

Because link_bad_work runs asynchronously in
drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_link_bad():

	drm_connector_set_link_status_property(connector, DRM_MODE_LINK_STATUS_BAD=
);
	drm_kms_helper_connector_hotplug_event(connector);

userspace can receive the initial hotplug event from
nouveau_display_hpd_work() before connector->state->link_status has been set
to DRM_MODE_LINK_STATUS_BAD. Furthermore, if userspace or an in-kernel DRM
client completes a valid modeset (or a subsequent HPD event retrains the
link) before link_bad_work executes, wouldn't nouveau_connector_link_bad()
still overwrite connector->state->link_status with DRM_MODE_LINK_STATUS_BAD
on the working link?

Would it avoid this race to update connector->state->link_status directly
while nouveau_display_relink() already holds dev->mode_config.connection_mu=
tex
in ctx?

> @@ -510,6 +545,14 @@ nouveau_display_hpd_work(struct work_struct *work)
>  			    !!(bits & NVIF_CONN_EVENT_V0_UNPLUG),
>  			    !!(bits & NVIF_CONN_EVENT_V0_IRQ));
> =20
> +		/* If a DP sink dropped HPD while we were driving it, it may have
> +		 * reset its end of the link whatever its link status says, and
> +		 * userspace won't modeset again if nothing else has changed.
> +		 */
> +		if (nv_connector->dp_encoder &&
> +		    (bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG)))
> +			modeset =3D true;

[Severity: Medium]
On Dual-Mode DisplayPort (DP++) connectors, both a DCB_OUTPUT_DP encoder and
a DCB_OUTPUT_TMDS encoder are attached to the same struct nouveau_connector
with nv_connector->dp_encoder set to the DP encoder in nv50_sor_create().

If a passive HDMI/DVI (TMDS) sink is connected on a DP++ port, or if a user
swaps between a native DP sink and a passive DP++ TMDS adapter while the CR=
TC
is active, nouveau_display_hpd_work() sets modeset =3D true based only on
nv_connector->dp_encoder being non-NULL, and nouveau_display_relink() calls
drm_atomic_helper_reset_crtc() before userspace receives the hotplug event:

nouveau_display_hpd_work()
  -> nouveau_display_relink()
       -> drm_atomic_helper_reset_crtc()

Because drm_atomic_helper_reset_crtc() only adds the CRTC to the atomic sta=
te
before drm_atomic_helper_check_modeset() runs update_connector_routing(),
new_connector_state->best_encoder remains old_connector_state->best_encoder.
When driving a passive TMDS sink, every HPD plug/unplug event triggers an
unnecessary full modeset; when switching between DP and TMDS sinks on the
same connector, drm_atomic_helper_reset_crtc() runs against the stale
best_encoder (either failing nv50_outp_atomic_check() with -EINVAL and
marking link-status BAD, or committing the wrong encoder protocol for the
newly detected sink).

Should nouveau_display_hpd_work() and nouveau_display_relink() verify that
both nv_connector->detected_encoder and connector->state->best_encoder match
nv_connector->dp_encoder before restarting the link?

[Severity: Medium]
In the earlier patch in this series, commit bef9030b7486 ("drm/nouveau/kms:
cache the DP encoder after it has been attached"), the find_encoder() lookup
for nv_connector->dp_encoder was removed from nouveau_connector_create() and
added to nv50_sor_create():

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_sor_create() {
	if (dcbe->type =3D=3D DCB_OUTPUT_DP) {
		mutex_init(&nv_encoder->dp.hpd_irq_lock);
		nv_connector->dp_encoder =3D nv_encoder;
		...
	}
}

However, drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_pior_create() also
creates DCB_OUTPUT_DP encoders for external DisplayPort encoders driven via
PIOR on NV50-family GPUs:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_pior_create() {
	switch (dcbe->type) {
	...
	case DCB_OUTPUT_DP:
		aux  =3D nvkm_i2c_aux_find(i2c, nv_encoder->outp.info.dp.aux);
		ddc  =3D aux ? &aux->i2c : NULL;
		type =3D DRM_MODE_ENCODER_TMDS;
		break;
	default:
		return -ENODEV;
	}

	nv_encoder->i2c =3D ddc;

	mutex_init(&nv_encoder->dp.hpd_irq_lock);
}

Without setting nv_connector->dp_encoder =3D nv_encoder in nv50_pior_create=
(),
won't nv_connector->dp_encoder remain NULL on PIOR DP connectors, causing
both nouveau_dp_link_check() and this new HPD relink check in
nouveau_display_hpd_work() to be skipped?

[Severity: High]
With nouveau_display_hpd_work() now calling nouveau_display_relink() on DP
plug and unplug events across all GPUs (which schedules
nv_connector->link_bad_work when drm_atomic_helper_reset_crtc() returns
-EINVAL), how are nv_connector->link_bad_work and nv_connector->irq_work
synchronized during suspend and driver teardown in nouveau_display_fini()?

Looking at drivers/gpu/drm/nouveau/nouveau_display.c:nouveau_display_fini():

	/* disable hotplug interrupts */
	drm_connector_list_iter_begin(dev, &conn_iter);
	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
		struct nouveau_connector *conn =3D nouveau_connector(connector);
		nvif_event_block(&conn->irq);
		nvif_event_block(&conn->hpd);
	}
	drm_connector_list_iter_end(&conn_iter);

	if (!runtime && !drm->headless)
		cancel_work_sync(&drm->hpd_work);

conn->irq_work and conn->link_bad_work are only cancelled later in
drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_destroy():

	nvif_event_dtor(&nv_connector->irq);
	nvif_event_dtor(&nv_connector->hpd);
	cancel_work_sync(&nv_connector->irq_work);
	cancel_work_sync(&nv_connector->link_bad_work);

This appears to leave two regressions:

1. During system suspend (nouveau_display_suspend() ->
   nouveau_display_fini()), neither conn->irq_work nor conn->link_bad_work =
is
   cancelled. If conn->irq_work was queued just before nvif_event_block(),
   nouveau_dp_irq() can run during suspend and re-schedule drm->hpd_work
   after cancel_work_sync(&drm->hpd_work) has returned. Similarly, if
   drm->hpd_work or nv50_sor_atomic_enable() queued conn->link_bad_work,
   nouveau_connector_link_bad() can run after drm_atomic_helper_suspend() a=
nd
   nouveau_display_fini() have completed, mutating connector->state and
   sending hotplug events on a suspended device.

2. During driver unload, nouveau_display_destroy() calls
   drm_mode_config_cleanup(), which destroys and frees all drm_encoder
   instances (nv50_sor_destroy(), nv50_pior_destroy()) before destroying
   connectors in nouveau_connector_destroy(). If conn->irq_work is still
   running during drm_mode_config_cleanup(), nouveau_dp_irq() can access a
   freed nouveau_encoder and its destroyed hpd_irq_lock, and re-schedule
   drm->hpd_work after nouveau_display_fini() already cancelled it.

Should nouveau_display_fini() cancel conn->irq_work before
cancel_work_sync(&drm->hpd_work) and cancel conn->link_bad_work after it?

[Severity: Medium]
In commit e5f61700807a ("drm/nouveau/kms/nv50-: reject DP modesets the link
can't carry") in this series, nv50_outp_atomic_check() was updated to reject
modesets when nv50_outp_atomic_fix_depth() returns false:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_outp_atomic_check() {
	if (!nv50_outp_atomic_fix_depth(encoder, crtc_state) &&
	    (crtc_state->mode_changed || crtc_state->connectors_changed))
		return -EINVAL;
}

During system resume, nouveau_display_resume() calls
drm_atomic_helper_resume() before nouveau_display_hpd_resume().
drm_atomic_helper_resume() resets mode_config state (setting
crtc->state->enable =3D false) and commits the state saved by
drm_atomic_helper_suspend() (which has state->duplicated =3D=3D true). If a=
 DP
sink was powered off or disconnected prior to resume (so
nouveau_dp_probe_dpcd() zeroed outp->dp.link_nr and outp->dp.link_bw, or
cached reduced capabilities) while its CRTC had enable =3D=3D true when
suspended (for example in DPMS off with active =3D=3D false, or after
nv50_sor_atomic_enable() aborted on -EINVAL), drm_atomic_helper_check_modes=
et()
sees old_crtc_state->enable !=3D new_crtc_state->enable and sets
mode_changed =3D true and connectors_changed =3D true even when
new_crtc_state->active is false.

Unlike nv50_msto_atomic_check(), which guards its check with
!state->duplicated, won't nv50_outp_atomic_check() return -EINVAL here and
cause drm_atomic_helper_resume() to fail the entire multi-CRTC resume commi=
t?

[Severity: Medium]
In commit 9c72b9cc42ad ("drm/nouveau/kms/nv50-: don't enable a DP output wi=
th
no trained link") in this series, nv50_sor_atomic_enable() returns early wh=
en
nouveau_dp_train() returns -EINVAL:

drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_sor_atomic_enable() {
	case DCB_OUTPUT_DP:
		if (nouveau_dp_train(nv_encoder, false, mode->clock, asyh->or.bpc) =3D=3D=
 -EINVAL) {
			schedule_work(&nv_connector->link_bad_work);
			return;
		}
}

However, its caller in
drivers/gpu/drm/nouveau/dispnv50/disp.c:nv50_disp_atomic_commit_tail() still
unconditionally marks outp->enabled =3D true:

	list_for_each_entry(outp, &atom->outp, head) {
		...
		if (outp->set.mask) {
			help->atomic_enable(encoder, state);
			outp->enabled =3D true;
			interlock[NV50_DISP_INTERLOCK_CORE] =3D 1;
		}
	}

When nv50_disp_atomic_commit_core() then runs:

	list_for_each_entry(outp, &atom->outp, head) {
		if (outp->encoder->encoder_type !=3D DRM_MODE_ENCODER_DPMST) {
			struct nouveau_encoder *nv_encoder =3D nouveau_encoder(outp->encoder);

			if (outp->enabled) {
				nv50_audio_enable(outp->encoder, nouveau_crtc(nv_encoder->crtc),
						  nv_encoder->conn, NULL, NULL);
				outp->enabled =3D outp->disabled =3D false;
			}

doesn't this call nv50_audio_enable() (invoking nvif_outp_hda_eld() and
notifying the ALSA audio component) on an untrained, detached SOR whenever
the connector's cached display_info.has_audio is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nouveau-dp=
-relink-v1-0-7ee88c7f1e8a@thelittleman.net?part=3D5
