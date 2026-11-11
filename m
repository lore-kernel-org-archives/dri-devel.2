Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E9606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI0tclDK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C0310E334;
	Wed, 11 Nov 2026 02:52:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2103C10E0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:52:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA0D0460ED;
 Wed, 11 Nov 2026 02:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649471F0089F;
 Wed, 11 Nov 2026 02:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794365520;
 bh=0qo9JWcKrHd5VOxs1SG3NqbAClUQ9IDDKCBiFqXMI14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MI0tclDKM0zdIn7oF+C1SWOV0P4RL5Z/Q3mrZGOiR4QCCaE0suKpMplofHpsIA0jg
 g0G7GqGDcB8Ksh63Fy2M6DsKgAQ0lXfyFikYdYi8u6xUCdjk604e7H8dy6OtEMY43o
 YyAHPTTkgWK8ySdap/hiiWSQsaC0LeyXvqqTXtmxqsnCa9QWPhw/T/C5lKX3Fgj53v
 FVSSRzggfZg0WCpTCPvwyiRH+DUyQTXnicKAevs0MWrSyxvWWLtHCt4F7Mn7Hb7Hn3
 UrAh0e6Z9c5K8CrZH4RWi16rT6tXX7Dt3waYvLk8mZIfebVmcNzALqoSctXXOmgjsT
 zXB3qeUrA6FXA==
Message-ID: <sashiko-outbox-208122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/sysfb: Copy damage outside the DIRTYFB ioctl
To: "Joseph Telaak" <joseph@telaak.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
References: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:51:59 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/sysfb: busy-spin and livelock in drm_sysfb_fb_dirty()
  flush_work() loop
- [High] drm/sysfb: race between drm_sysfb_damage_work() and PM
  suspend/resume
- [Medium] drm/sysfb: lock inversion holding drm_dev_enter() in
  drm_sysfb_damage_work()
- [Medium] drm/sysfb: concurrent frontbuffer mutation and lock stall in
  drm_sysfb_damage_work()
--

commit 092a1b6cbfb2ea4259c79aad2c25c2ec9f2a259a
Author: Joseph Telaak <joseph@telaak.dev>

drm/sysfb: Copy damage outside the DIRTYFB ioctl

This commit defers sysfb framebuffer damage updates from the DIRTYFB ioctl =
to
a workqueue item that merges damage rectangles and runs
drm_atomic_helper_dirtyfb() asynchronously.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/=
sysfb/drm_sysfb_modeset.c
> index 13df0925163a5..e77f0c0ffc272 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
[ ... ]
> +static void drm_sysfb_damage_work(struct work_struct *work)
> +{
> +	struct drm_sysfb_device *sysfb =3D container_of(work, struct drm_sysfb_=
device,
> +						      damage_work);
> +	struct drm_framebuffer *fb;
> +	struct drm_clip_rect clip;
> +	int idx, ret;
> +
> +	spin_lock(&sysfb->damage_lock);
> +	fb =3D sysfb->damage_fb;
> +	sysfb->damage_fb =3D NULL;
> +	clip.x1 =3D sysfb->damage.x1;
> +	clip.y1 =3D sysfb->damage.y1;
> +	clip.x2 =3D sysfb->damage.x2;
> +	clip.y2 =3D sysfb->damage.y2;
> +	spin_unlock(&sysfb->damage_lock);
> +	if (!fb)
> +		return;
> +
> +	if (drm_dev_enter(&sysfb->dev, &idx)) {
> +		ret =3D drm_atomic_helper_dirtyfb(fb, NULL, 0, 0, &clip, 1);
> +		if (ret)
> +			drm_err_ratelimited(&sysfb->dev, "damage update failed: %d\n", ret);
> +		drm_dev_exit(idx);
> +	}
> +	drm_framebuffer_put(fb);
> +}

[Severity: High]
Can drm_sysfb_damage_work() race with system suspend and resume, causing a
use-after-free or NULL pointer dereference on plane->state?

All sysfb drivers use drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume(), which do not flush or cancel
sysfb->damage_work, and system_dfl_wq is not freezable.  During resume,
drm_atomic_helper_resume() calls drm_mode_config_reset() before acquiring
modeset locks, which destroys and reallocates plane->state unlocked:

CPU0                              CPU1 (kworker)
drm_mode_config_helper_resume()
  drm_atomic_helper_resume()
    drm_mode_config_reset()
      ...
        kfree(plane->state)
        plane->state =3D NULL
                                  drm_sysfb_damage_work()
                                    drm_atomic_helper_dirtyfb()
                                      drm_modeset_lock(&plane->mutex, ...)
                                      plane->state->fb  <-- NULL deref / UAF

If drm_sysfb_damage_work() runs while the device is suspended or resuming, =
it
can also blit to the hardware framebuffer while the display is suspended.

[Severity: Medium]
Does holding drm_dev_enter() across drm_atomic_helper_dirtyfb() invert the
locking order between drm_unplug_srcu and modeset, dma_resv, and dma_fence
locks?

drm_dev_enter() acquires a read lock on the global drm_unplug_srcu, and
drm_atomic_helper_dirtyfb() then acquires modeset locks, takes dma_resv_loc=
k()
in drm_gem_fb_vmap(), and waits on GPU fences in
drm_atomic_helper_wait_for_fences().  Normal atomic commits acquire modeset
locks, dma_resv_lock(), and dma_fence_map before calling drm_dev_enter() in
drm_sysfb_plane_helper_atomic_update():

CPU0 (kworker)                    CPU1
----                              ----
lock(drm_unplug_srcu)
                                  lock(&plane->mutex)
lock(&plane->mutex)
                                  lock(drm_unplug_srcu)

 *** DEADLOCK ***

CPU0: drm_sysfb_damage_work() -> drm_atomic_helper_dirtyfb()
CPU1: drm_mode_atomic_ioctl() -> ... -> drm_sysfb_plane_helper_atomic_updat=
e()

If the rendering GPU is unplugged or halted while drm_sysfb_damage_work() is
waiting on its fence, drm_dev_unplug() on the GPU will also block in
synchronize_srcu(&drm_unplug_srcu) before it can reach the fence teardown p=
ath
that aborts the in-flight fence.  Since drm_sysfb_plane_helper_atomic_updat=
e()
already guards the hardware framebuffer blit with drm_dev_enter(), the outer
drm_dev_enter() in drm_sysfb_damage_work() can be dropped.

[ ... ]

> +static int drm_sysfb_fb_dirty(struct drm_framebuffer *fb, struct drm_fil=
e *file,
> +			      unsigned int flags, unsigned int color,
> +			      struct drm_clip_rect *clips, unsigned int num_clips)
> +{
> +	struct drm_sysfb_device *sysfb =3D to_drm_sysfb_device(fb->dev);
> +	struct drm_rect r;
> +	bool queue =3D false;
> +
> +	drm_sysfb_damage_bounds(fb, flags, clips, num_clips, &r);
> +
> +	spin_lock(&sysfb->damage_lock);
> +	/* Pending damage of another framebuffer is copied first. */\
> +	while (sysfb->damage_fb && sysfb->damage_fb !=3D fb) {
> +		spin_unlock(&sysfb->damage_lock);
> +		flush_work(&sysfb->damage_work);
> +		spin_lock(&sysfb->damage_lock);
> +	}
> +	if (!sysfb->damage_fb) {
> +		drm_framebuffer_get(fb);
> +		sysfb->damage_fb =3D fb;
> +		sysfb->damage =3D r;
> +		queue =3D true;
> +	} else {
> +		sysfb->damage.x1 =3D min(sysfb->damage.x1, r.x1);
> +		sysfb->damage.y1 =3D min(sysfb->damage.y1, r.y1);
> +		sysfb->damage.x2 =3D max(sysfb->damage.x2, r.x2);
> +		sysfb->damage.y2 =3D max(sysfb->damage.y2, r.y2);
> +	}
> +	spin_unlock(&sysfb->damage_lock);
> +
> +	if (queue)
> +		queue_work(system_dfl_wq, &sysfb->damage_work);
> +	return 0;
> +}

[Severity: High]
Can a second caller with a different framebuffer busy-spin or livelock in t=
he
flush_work() loop when sysfb->damage_fb is set before queue_work() is calle=
d?

sysfb->damage_fb is published under sysfb->damage_lock, but queue_work() is
called only after dropping the lock.  If another thread calls
drm_sysfb_fb_dirty() for a different framebuffer in that window, flush_work=
()
sees that sysfb->damage_work is not queued and returns false immediately:

CPU0                              CPU1
drm_sysfb_fb_dirty(fb1)
  spin_lock(&sysfb->damage_lock)
  sysfb->damage_fb =3D fb1
  queue =3D true
  spin_unlock(&sysfb->damage_lock)
  <preempted>
                                  drm_sysfb_fb_dirty(fb2)
                                    spin_lock(&sysfb->damage_lock)
                                    while (sysfb->damage_fb !=3D fb2)
                                      spin_unlock(&sysfb->damage_lock)
                                      flush_work(&sysfb->damage_work)
                                      spin_lock(&sysfb->damage_lock)
                                      <-- spins forever if RT thread on sam=
e CPU
  queue_work(..., &sysfb->damage_work)

In addition, because drm_sysfb_damage_work() clears sysfb->damage_fb to NULL
before calling drm_atomic_helper_dirtyfb(), further DIRTYFB calls on fb1 wh=
ile
the worker is waiting on fences will re-populate sysfb->damage_fb with fb1
before flush_work() returns, forcing the waiter for fb2 to stall across
multiple fence-wait cycles.  Calling queue_work() while holding
sysfb->damage_lock fixes the unqueued flush_work() race.

[Severity: Medium]
Does returning immediately from drm_sysfb_fb_dirty() allow userspace or the
GPU to overwrite the frontbuffer while drm_sysfb_damage_work() is copying f=
rom
it, and stall non-blocking atomic commits on modeset locks?

When userspace renders into a mmap'd dumb buffer with the CPU (where no
dma_fence is attached) or submits the next frame's GPU job to the same
frontbuffer as soon as the previous fence signals, drm_sysfb_damage_work()
reads from the framebuffer concurrently with the new frame's writes, copying
unfinished frames to the screen and removing DIRTYFB upload rate-limiting.
Furthermore, drm_sysfb_damage_work() runs a blocking commit via
drm_atomic_helper_dirtyfb() while holding plane->mutex and crtc->mutex acro=
ss
drm_atomic_helper_wait_for_fences(), which blocks concurrent
DRM_MODE_ATOMIC_NONBLOCK commits behind the GPU fence wait.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-sysfb-dirt=
yfb-v1-1-8571d455ccbe@telaak.dev?part=3D1
