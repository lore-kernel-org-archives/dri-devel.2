Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOKVdqgB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BA410F040;
	Tue, 17 Nov 2026 20:23:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C75110E65A;
 Tue, 17 Nov 2026 20:23:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE81D601E4;
 Tue, 17 Nov 2026 20:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E741F000C4;
 Tue, 17 Nov 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794947016;
 bh=67LIrgW+BYkG/Kvd8ju6zckOBu92xjrCO4VUL00hC7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nOKVdqgBLI4TsLawCUa/CSyYFYNgnrGIGhCzwCEmM7LLQdDB/4Gz2S1wvidmBAA4x
 Ig2KXDt9oXCpybu478ETBtvkyQ2JURSliRX8Z5+sx/ts4kAFSWPqDF5vVS19EInOY1
 138dH1CqRyWdPMV/K4MxsBaOrqBICA+vop+pCmlRIAUcFvQjEDkQ8DVJ2MLNa9GupO
 b9Fhm5g7JDIc68QGKI96VSQ1443tj+IonoWMcg5dxLkGZHG6V2c/nwCH2KsU4M2ame
 cPGlAprBQe2IvcRxihbfWGOpGVYgGsrrueHXel0vGpOPE91qw0jS+xKD/nSqZNn0Fv
 +yML05VuRq/lg==
Message-ID: <sashiko-outbox-219593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] drm/tests: Test limiting the run-ahead of fake
 commit only commits
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261117200253.27078-7-ville.syrjala@linux.intel.com>
References: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
 <20261117200253.27078-7-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:23:35 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/tests: race on inflight counter in
  drm_test_flood_commit_work()
- [Medium] drm/tests: premature inflight dec in
  drm_test_flood_commit_work() causes UAF
--

commit 6c86373dc620a9330ac1f7518a644a35a7fe6819
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/tests: Test limiting the run-ahead of fake commit only commits

This commit adds a KUnit test that floods nonblocking commits touching only
an unbound plane with swap_state(stall=3Dfalse) to verify that in-flight
commits stay bounded and do not time out waiting for hw_done.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu=
/drm/tests/drm_atomic_commit_test.c
> index 593e1842fada2..247b5a916b585 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
[ ... ]
> @@ -495,6 +496,88 @@ static void drm_test_fake_commit_not_busy(struct kun=
it *test)
>  	drm_modeset_acquire_fini(&ctx);
>  }
> =20
> +static atomic_t drm_test_flood_inflight, drm_test_flood_max, drm_test_fl=
ood_timeouts;
> +
> +static void drm_test_flood_commit_work(struct work_struct *work)
> +{
> +	struct drm_atomic_commit *state =3D
> +		container_of(work, struct drm_atomic_commit, commit_work);
> +	struct drm_plane *plane;
> +	struct drm_plane_state *old_plane_state;
> +	int i;
> +
> +	for_each_old_plane_in_state(state, plane, old_plane_state, i)
> +		if (drm_crtc_commit_wait(old_plane_state->commit))
> +			atomic_inc(&drm_test_flood_timeouts);
> +
> +	/* Pretend to do some work */
> +	msleep(2);
> +
> +	drm_atomic_helper_commit_hw_done(state);
> +	drm_atomic_helper_commit_cleanup_done(state);
> +	atomic_dec(&drm_test_flood_inflight);
> +	drm_atomic_commit_put(state);
> +}

[Severity: Medium]
Can decrementing drm_test_flood_inflight before drm_atomic_commit_put(state)
cause a use-after-free on dev->driver during test teardown?

CPU0 (kunit)                      CPU1 (kworker)
drm_test_fake_commit_flood()      drm_test_flood_commit_work()
  /* sees inflight =3D=3D 0 */          atomic_dec(&drm_test_flood_inflight)
kunit_cleanup()
  ...
    devres_release_all(dev)
      /* frees dev->driver */
                                    drm_atomic_commit_put(state)
                                      __drm_atomic_commit_free()
                                        drm_dev_put(dev)
                                          drm_dev_release()
                                            dev->driver->release
                                              <-- use-after-free

__drm_kunit_helper_alloc_drm_device() allocates struct drm_driver with
devm_kzalloc_obj(dev, *driver), while each drm_atomic_commit holds a
drm_device reference via drm_dev_get() until __drm_atomic_commit_free().
Because drm_test_fake_commit_flood() only waits for drm_test_flood_inflight
to reach 0 without flushing the work items, KUnit cleanup can unregister the
mock device and free dev->driver before the final worker finishes
drm_atomic_commit_put(state).

> +
> +/*
> + * Test that a flood of nonblocking commits that only touch an unbound p=
lane
> + * can not queue up an unbounded number of commits, even if the driver d=
oes not
> + * ask swap_state() to stall. Otherwise the work items would all wait fo=
r the
> + * hw_done of their predecessor, and the waits would add up.
> + */
> +static void drm_test_fake_commit_flood(struct kunit *test)
> +{
[ ... ]
> +		INIT_WORK(&state->commit_work, drm_test_flood_commit_work);
> +		queue_work(system_dfl_wq, &state->commit_work);
> +
> +		drm_modeset_drop_locks(&ctx);
> +		drm_modeset_acquire_fini(&ctx);
> +	}
> +
> +	while (atomic_read(&drm_test_flood_inflight))
> +		msleep(10);
> +
> +	/*
> +	 * The previous commit may still be doing its cleanup when the next
> +	 * one is submitted, hence 2 rather than 1.
> +	 */
> +	KUNIT_EXPECT_LE(test, atomic_read(&drm_test_flood_max), 2);

[Severity: Medium]
Can drm_test_flood_max exceed 2 when workers on system_dfl_wq are preempted
between drm_atomic_helper_commit_hw_done() and
atomic_dec(&drm_test_flood_inflight)?

drm_atomic_helper_commit_hw_done(state) completes state->fake_commit->hw_do=
ne,
which immediately unblocks stall_for_fake_commit() in
drm_atomic_helper_setup_commit() for the next commit on the test thread.
Neither stall_for_fake_commit() nor drm_crtc_commit_wait() waits for
cleanup_done or work completion, and system_dfl_wq is an unbound workqueue
that can run multiple workers concurrently.  If more than one worker is
preempted after signaling hw_done before reaching
atomic_dec(&drm_test_flood_inflight), drm_test_flood_max will be greater th=
an
2 and fail the expectation.  In addition, exiting the wait loop as soon as
drm_test_flood_inflight reaches 0 without flushing the work items allows te=
st
teardown to race with the final drm_atomic_commit_put(state).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200253.2707=
8-1-ville.syrjala@linux.intel.com?part=3D6
