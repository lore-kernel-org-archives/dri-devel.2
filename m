Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB0606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN43YXUc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011310E60F;
	Sun,  8 Nov 2026 19:40:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF98910E60F
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70C9F4130C;
 Sun,  8 Nov 2026 19:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF61F0089F;
 Sun,  8 Nov 2026 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794166796;
 bh=KvT7UD0TY7pM+NqDjQi7TKsy48RFSdcPwnsFPTeFHlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LN43YXUc4cT+etJwtLpHNAIvm/t2pV9FWw9/Yu6ezMZOJlKNfFvAIJ4DNXMG41+wf
 aogunAYN8sei+zV+tkM7TfWhoIEU5kNEfeqKsvubplY9+Qz3DaPZT7Bx36tIpZkj27
 LuGOh8uhgeY8/7SKlmSXQ3acVAnt4lh3pVVl11WtNwO+jcK3aDPnTSVqJs63nMYrKa
 PrrwtM24iJc/ohjo+ataR3/Jz9c8kHYfaJ/u1Qlp6V5BMuKobvnMAqjFhNHi7TVpsG
 HZTWuhHD1f30GpPbvB06wxVJTsQEOX5tjcJhVNwXVunGqy42rAhBQMO3HIBwqATjUU
 k2uWcvtJburbw==
Message-ID: <sashiko-outbox-203984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/vkms: use the gamma LUT of the state being
 composed
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261108-lut-v1-1-f762d70ae4cd@gmail.com>
References: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
 <20261108-lut-v1-1-f762d70ae4cd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:39:55 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/vkms: race condition publishing writeback job in
  vkms_wb_atomic_commit() [1]
--

commit e2d912779c4a80188eb9913ca9ba97afaaba49ac
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: use the gamma LUT of the state being composed

This commit reads the gamma LUT from crtc_state->base.gamma_lut rather than
crtc->state->gamma_lut in vkms_composer_worker() and clears the LUT fields
when no LUT is present.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 0fc915a954bad..1d5658bbd493b 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -609,6 +609,7 @@ void vkms_composer_worker(struct work_struct *work)
>  							  struct vkms_crtc_state,
>  							  composer_work);
>  	struct drm_crtc *crtc =3D crtc_state->base.crtc;
> +	struct drm_property_blob *gamma_lut =3D crtc_state->base.gamma_lut;
>  	struct vkms_writeback_job *active_wb =3D crtc_state->active_writeback;

[Severity: Critical]
This problem wasn't introduced by this patch, but can vkms_composer_worker()
race with vkms_wb_atomic_commit() on crtc_state->active_writeback [1]?

vkms_composer_worker() reads crtc_state->active_writeback before taking
out->composer_lock to read crtc_state->wb_pending, while
vkms_wb_atomic_commit() publishes both under output->composer_lock before
queuing and initializing the job:

drivers/gpu/drm/vkms/vkms_writeback.c:vkms_wb_atomic_commit() {
    ...
	spin_lock_irq(&output->composer_lock);
	crtc_state->active_writeback =3D active_wb;
	crtc_state->wb_pending =3D true;
	spin_unlock_irq(&output->composer_lock);
	drm_writeback_queue_job(wb_conn, connector_state);
	active_wb->pixel_write =3D get_pixel_write_function(wb_format);
	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
}

When a writeback commit runs while the vblank timer and composer worker are
already active (for example, with CRC capture enabled), the two contexts can
interleave:

CPU0                                  CPU1 (kworker)
vkms_wb_atomic_commit()               vkms_composer_worker()
  spin_lock_irq(&composer_lock)
  crtc_state->active_writeback =3D ...
  crtc_state->wb_pending =3D true
  spin_unlock_irq(&composer_lock)
  drm_writeback_queue_job(...)
                                        active_wb =3D
                                          crtc_state->active_writeback
                                        spin_lock_irq(&composer_lock)
                                        wb_pending =3D crtc_state->wb_pendi=
ng
                                        spin_unlock_irq(&composer_lock)
                                        compose_active_planes(active_wb, ..=
.)
                                        drm_writeback_signal_completion(...)
                                          ...
                                            vkms_wb_cleanup_job()
                                              kfree(active_wb)
  active_wb->pixel_write =3D ...
    <-- use-after-free

Depending on where the worker interleaves, it can also read a NULL or stale
active_wb before composer_lock is taken, hit WARN_ON(!active_wb->pixel_writ=
e)
in check_format_funcs(), or call drm_writeback_signal_completion() before
drm_writeback_queue_job(), which triggers WARN_ON(!job) and clears wb_pendi=
ng
so the queued job never completes.

Initializing active_wb and calling drm_writeback_queue_job() before
publishing active_writeback and wb_pending under composer_lock, and reading
crtc_state->active_writeback under composer_lock in vkms_composer_worker(),
would avoid these races.

[1] https://sashiko.dev/#/bug/linux-420d0359-9fcb-45d5-af1b-74704c78f447

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-lut-v1-0-f=
762d70ae4cd@gmail.com?part=3D1
