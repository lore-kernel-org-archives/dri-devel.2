Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xly5Ija0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0999910E3C7;
	Wed, 11 Nov 2026 15:12:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6674C10E3C7
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:12:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20E644774C;
 Wed, 11 Nov 2026 15:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD62D1F00A0F;
 Wed, 11 Nov 2026 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794409946;
 bh=KYtdWxiUOY3NoWj4ohA1ZhWHiKv1IUh6MVIFPxexPec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xly5Ija0Y1fyehz3o8UY86YpQMS5jh+NygFEdaE0sgtOWuXPAzeBKSRy39G+16eND
 h/wqiJHDTJ59lX/KL2l0gzdkcjXbbtyNlG3sU0VjddAnCJJ8caLd41sphAA3OkMJ2L
 0qje1kpgvAtdRmVMnsJFJMoMy0wxzVbjIdL9DGTTabZMY+z0AhuU16+6R2hL6mE3QT
 qz+gnckfCgC6Ow5mK3lq/n8b494+LXEzSfbNaJpEvDcOQhR/cWWVwQQXFMkZslOlZ7
 v+fBB/qgc4r8lk/ZzzR7+OCPAphUSsd0pF7jC89lpEpKwJy+d3hBgfuOKZPbLQVJft
 FbF1xqBUvMm9w==
Message-ID: <sashiko-outbox-209217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: use a bitmask instead of a bool for composer
 users
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-composer-v1-1-9d5fa94656f8@gmail.com>
References: <20261111-composer-v1-1-9d5fa94656f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 15:12:25 +0000
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
- [Medium] drm/vkms: vkms_wb_cleanup_job() clears VKMS_COMPOSER_WB for
  pending job
--

commit 881f833de91536e1dc29f1f083a56309194fa1be
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: use a bitmask instead of a bool for composer users

This commit replaces the single boolean composer_enabled flag with a
per-user bitmask (composer_users) and replaces vkms_set_composer() with
vkms_composer_get() and vkms_composer_put() so CRC capture and writeback
do not disable the composer for each other.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 0fc915a954bad..59f1dd50b5bd5 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -711,19 +711,34 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, c=
onst char *src_name,
>  	return 0;
>  }
> =20
> -void vkms_set_composer(struct vkms_output *out, bool enabled)
> +void vkms_composer_get(struct vkms_output *out, u8 user)
>  {
> -	bool old_enabled;
> +	bool was_enabled;
> =20
> -	if (enabled)
> -		drm_crtc_vblank_get(&out->crtc);
> +	if (drm_crtc_vblank_get(&out->crtc))
> +		return;
> +
> +	spin_lock_irq(&out->lock);
> +	was_enabled =3D out->composer_users;
> +	out->composer_users |=3D user;
> +	spin_unlock_irq(&out->lock);
> +
> +	/* Another user already holds the reference for the composer. */
> +	if (was_enabled)
> +		drm_crtc_vblank_put(&out->crtc);
> +}
> +
> +void vkms_composer_put(struct vkms_output *out, u8 user)
> +{
> +	bool was_set, enabled;
> =20
>  	spin_lock_irq(&out->lock);
> -	old_enabled =3D out->composer_enabled;
> -	out->composer_enabled =3D enabled;
> +	was_set =3D out->composer_users & user;
> +	out->composer_users &=3D ~user;
> +	enabled =3D out->composer_users;
>  	spin_unlock_irq(&out->lock);
> =20
> -	if (old_enabled)
> +	if (was_set && !enabled)
>  		drm_crtc_vblank_put(&out->crtc);
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms=
/vkms_writeback.c
> index 858df1f89f660..7e2f82e44b392 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -118,7 +118,7 @@ static void vkms_wb_cleanup_job(struct drm_writeback_=
connector *connector,
> =20
>  	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
> =20
> -	vkms_set_composer(vkms_output, false);
> +	vkms_composer_put(vkms_output, VKMS_COMPOSER_WB);
>  	kfree(vkmsjob);
>  }
> =20
> @@ -141,7 +141,7 @@ static void vkms_wb_atomic_commit(struct drm_connecto=
r *conn,
>  	if (!conn_state)
>  		return;
> =20
> -	vkms_set_composer(output, true);
> +	vkms_composer_get(output, VKMS_COMPOSER_WB);
> =20
>  	active_wb =3D conn_state->writeback_job->priv;
>  	wb_frame_info =3D &active_wb->wb_frame_info;

[Severity: Medium]
Can vkms_wb_cleanup_job() from a finished writeback job clear
VKMS_COMPOSER_WB while the next writeback job is already pending?

drm_writeback_signal_completion() signals the job's out_fence synchronously
before queueing job->cleanup_work on system_long_wq:

drivers/gpu/drm/drm_writeback.c:drm_writeback_signal_completion() {
    ...
		dma_fence_signal(out_fence);
		dma_fence_put(out_fence);
		job->out_fence =3D NULL;
	}

	INIT_WORK(&job->cleanup_work, cleanup_work);
	queue_work(system_long_wq, &job->cleanup_work);
}

Because VKMS_COMPOSER_WB is a single bit rather than a count, a second
writeback commit submitted after out_fence signals can overlap with the
first job's deferred cleanup:

CPU0                                  CPU1 (system_long_wq)
vkms_composer_worker()
  drm_writeback_signal_completion()
    dma_fence_signal(job1->out_fence)
    queue_work(..., &job1->cleanup_work)

/* userspace commits job2 */
vkms_wb_atomic_commit()
  vkms_composer_get(out, VKMS_COMPOSER_WB)
    /* VKMS_COMPOSER_WB already set */
                                      cleanup_work()
                                        ...
                                          vkms_wb_cleanup_job()
                                            vkms_composer_put(out,
                                                VKMS_COMPOSER_WB)
                                              out->composer_users &=3D ~use=
r;
                                              drm_crtc_vblank_put(&out->crt=
c)

Once out->composer_users is cleared to 0, vkms_crtc_handle_vblank_timeout()
stops queuing vkms_composer_worker(), leaving job2 uncomposed and its
out_fence unsignaled.  Wait-for-fences interruption or prepare_fb failure in
drm_atomic_helper_commit() after vkms_wb_prepare_job() also runs
vkms_wb_cleanup_job() without a matching vkms_composer_get(), which similar=
ly
clears VKMS_COMPOSER_WB for an in-flight job.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-composer-v=
1-1-9d5fa94656f8@gmail.com?part=3D1
