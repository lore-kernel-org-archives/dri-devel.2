Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBJJqyXI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973131122DB;
	Fri, 27 Nov 2026 06:14:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED5A11240F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:14:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 296B142DFE;
 Fri, 27 Nov 2026 06:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5CE1F0089F;
 Fri, 27 Nov 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795760079;
 bh=rX56/inJmgf8JLOp0I5Y4QJPY/lm7zJuIBNd96yQzN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GBJJqyXI6XqrWGUkEq6IFDHX/G3VU1jl34Two0ks0Cc5w6blytj4k8cuMMfo5qE7+
 NeH0+C+B7cM8M8CP8RAKnkZpECuNKOZj+j+F1ya3vanhW3r/6T0LawKKDLNFCyR3g/
 MHGHD58Tfneda5Klv352j7EadIDjChL78yMlibsz/9SKqUAdtxf8jIkSG6GDqHRPRD
 2NMHqpg4dDXPGRlLu3CLlD6x4iLTbiCM56H9YlFV9zsDr3pa79fQQqVcNAYyqyCTzn
 83a6LF2u+VrmfntTp/RW2dJMM8EWSUE4sLowFvPhWLz/QMO5kS5HFa8Xf9nhHtdsPg
 smc3WJePtc6Ww==
Message-ID: <sashiko-outbox-236697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] drm/bridge: trilinear: add the DPTX core and
 build glue
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261127055807.109667-5-Luo.Liu@cixtech.com>
References: <20261127055807.109667-1-Luo.Liu@cixtech.com>
 <20261127055807.109667-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:14:39 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: trilinear: wrong link rate units in
  dptx_mode_configure() downshift
- [High] drm/bridge: trilinear: suspend race in dptx_prepare() and
  dptx_unprepare()
--

commit b3d05377faa95646f17c1b45523d133f49a7ccb6
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX core and build glue

This commit adds the Trilinear DPTX bridge core implementation, including
probe, system sleep, hotplug handling, and link training, and hooks the
driver into the DRM bridge Kconfig and Makefile.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/d=
rm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 0000000000000..bfe339afe5873
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
[ ... ]
> +static int dptx_mode_configure(struct dptx_dev *dp, int pclk, u8 bw, u8 =
bpp,
> +			       bool downshift)
> +{
> +	int lane_cnt;
> +	int bw_code;
> +	int link_rate;
> +
> +	if (!downshift) {
> +		bw_code =3D bw;
> +	} else {
> +		link_rate =3D drm_dp_bw_code_to_link_rate(bw);
> +		if (link_rate > 5400)
> +			bw_code =3D DP_LINK_BW_5_4;
> +		else if (link_rate > 2700)
> +			bw_code =3D DP_LINK_BW_2_7;
> +		else if (link_rate > 1620)
> +			bw_code =3D DP_LINK_BW_1_62;
> +		else
> +			return -EINVAL;
> +	}

[Severity: High]
Does the downshift branch in dptx_mode_configure() compare link_rate against
the wrong units?

drm_dp_bw_code_to_link_rate() returns the rate in kHz (162000 to 810000), so
link_rate > 5400 is always true for every valid bandwidth code.  When link
training fails in dptx_train_loop(), downshifting always selects
DP_LINK_BW_5_4 instead of stepping down to 2.7 or 1.62 Gbps, never returns
-EINVAL to terminate the inner loop, and can upshift a 1.62 or 2.7 Gbps link
to 5.4 Gbps.

[ ... ]

> +static int dptx_pm_prepare(struct dptx_dev *dp, bool shutdown)
> +{
> +	scoped_guard(mutex, &dp->lock) {
> +		dptx_irq_off(dp);
> +		dp->state |=3D DPTX_STATE_SUSPENDED;
> +		if (shutdown)
> +			dp->state |=3D DPTX_STATE_SHUTDOWN;
> +	}
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		if (!(dp->state & DPTX_STATE_SUSPENDED)) {
> +			dptx_irq_off(dp);
> +			dp->state |=3D DPTX_STATE_SUSPENDED;
> +		}
> +
> +		if (shutdown)
> +			dptx_stop_streams(dp);
> +		if (!dp->active_stream_cnt)
> +			dptx_host_deinit(dp);
> +		dp->state &=3D ~DPTX_STATE_CONNECTED;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int dptx_prepare(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	guard(mutex)(&dp->lock);
> +
> +	if (dp->released || (dp->state & DPTX_STATE_SHUTDOWN))
> +		return -ENODEV;
> +
> +	/* The controller's resume commit can precede dptx_pm_complete(). */
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		return ret;
[ ... ]
> +static int dptx_unprepare(struct dptx_dev *dp)
> +{
> +	if (dp->active_stream_cnt)
> +		return 0;
> +
> +	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
> +		return 0;
> +
> +	dptx_core_off(dp);
> +
> +	/* dptx_pm_prepare() may have run before this suspend-time commit. */
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		dptx_host_deinit(dp);
> +
> +	dp->state &=3D ~DPTX_STATE_ENABLED;
> +
> +	return 0;
> +}

[Severity: High]
Can an atomic enable racing with trilinear_dptx_suspend() leave the host
initialized and dp->irq enabled across system suspend?

CPU0                              CPU1
trilinear_dptx_suspend()
  dptx_pm_prepare(dp, false)
    lock(&dp->lock)
    dptx_irq_off(dp)
    dp->state |=3D DPTX_STATE_SUSPENDED
    unlock(&dp->lock)
    dptx_cancel_hpd_works(dp)
    lock(&dp->lock)
    dptx_host_deinit(dp)
    unlock(&dp->lock)
                                  dptx_bridge_atomic_enable()
                                    dptx_prepare(dp)
                                      dptx_host_resume(dp)
                                        dptx_host_init(dp)
                                        enable_irq(dp->irq)
                                        dp->state &=3D ~DPTX_STATE_SUSPENDED

Because dptx_prepare() cannot tell a suspend-time commit apart from an early
resume commit, calling dptx_host_resume() after dptx_pm_prepare() finishes
clears DPTX_STATE_SUSPENDED and re-enables dp->irq; a later suspend-time
dptx_unprepare() then sees DPTX_STATE_SUSPENDED cleared and skips
dptx_host_deinit().

Even when dptx_pm_prepare() runs its second critical section after
dptx_prepare() and reinstates DPTX_STATE_SUSPENDED, two issues remain.
First, if dptx_bridge_atomic_enable() fails in dptx_bridge_mode_set() or
dptx_core_on(), neither DPTX_STATE_ENABLED nor DPTX_STATE_READY is set when
err_unprepare calls dptx_unprepare(), so dptx_unprepare() returns early
before checking DPTX_STATE_SUSPENDED and leaves the host initialized.
Second, while dptx_prepare() has dp->irq enabled during
dptx_cancel_hpd_works(), an HPD interrupt can re-queue hpd_event_work or
hpd_irq_work after dptx_cancel_hpd_works() returns, and if the racing
dptx_bridge_atomic_enable() completes dptx_encoder_enable() before
dptx_pm_prepare() re-locks dp->lock, dp->active_stream_cnt is non-zero and
dptx_pm_prepare(dp, false) skips dptx_host_deinit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127055807.1096=
67-1-Luo.Liu@cixtech.com?part=3D4
