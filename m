Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2B8C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 12:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288D910E078;
	Sat,  4 Jul 2026 12:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ab3TqV7x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F40F10E078
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 12:31:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D32360052;
 Sat,  4 Jul 2026 12:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF6D1F00A3A;
 Sat,  4 Jul 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783168274;
 bh=NF2Fzp3nYSBPFD4eFrO1eIf8FCPhoS3eD0cTfaK8fTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ab3TqV7xRNW45/Q3hy66UjMVicuBFRD9o5Dr9+0sCXJksL9IpCXYgk16X4ant6JLd
 gj6ltb5uJMerIEQYcj1PaUdSROOG6kxPVKVuHFMYFXBPbF93J6BwlhZJsuio043IzD
 znXF+GTfAMHeIW9Z59ua7bDHoerVfoImHgPa6MQXvzOSJA3LRaz0Hnp6hynzmye6dD
 78meKXNa//QPwJqTS0CsK2OIxvHp+uwYiKVNtPZgFesFMWZIPQBVFtZapDc6qpXWB3
 0DUjE063y5BYV3/WoASgwymA5NQJWAnFl2ChVHiXrJ4XUkcGKvjJbpifGBO/sekab1
 M8y7awF+mkRQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/v3d: Refactor perfmon locking
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260704-v3d-perfmon-lifetime-v3-1-fd26dfdc2153@igalia.com>
References: <20260704-v3d-perfmon-lifetime-v3-0-fd26dfdc2153@igalia.com>
 <20260704-v3d-perfmon-lifetime-v3-1-fd26dfdc2153@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:31:13 +0000
Message-Id: <20260704123113.DAF6D1F00A3A@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Perfmon hardware counters are permanently lost if a capture (via=
 ioctl or stop) races with runtime PM autosuspend.
- [Medium] A global perfmon is incorrectly stopped and silently disabled if=
 userspace sets it to the same perfmon object that is already attached to a=
 pending job.
--

commit 8ce781eec267bf896e263ac16cfc79142b7af5ee
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Subject: drm/v3d: Refactor perfmon locking

This commit refactors the performance monitor locking in the v3d driver to
serialize access to the device-wide active performance monitor. It
introduces a new device-wide spinlock and centralizes state transitions to
protect the hardware counters and software state from concurrent access.

> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_=
perfmon.c
> index 48ae748247be8..3ad0f022753c8 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c

[ ... ]

> @@ -288,6 +300,21 @@ static void v3d_perfmon_capture_locked(struct v3d_de=
v *v3d,
>  	v3d_pm_runtime_put(v3d);
>  }
> =20
> +void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *pe=
rfmon,
> +			     bool capture)
> +{
> +	lockdep_assert_held(&v3d->perfmon_state.lock);
> +
> +	if (!perfmon || perfmon !=3D v3d->perfmon_state.active)
> +		return;
> +

[Severity: Medium]
Could a global perfmon be incorrectly stopped and silently disabled if
userspace sets it to the same perfmon object already attached to a pending
job?

If userspace submits a job with perfmon X attached, and before the job star=
ts,
calls v3d_perfmon_set_global_ioctl() to set X as the global perfmon, the io=
ctl
succeeds, setting v3d->global_perfmon =3D X and v3d->perfmon_state.active =
=3D X.

When the job completes, its IRQ handler calls v3d_perfmon_stop() with X.
Because the job's perfmon matches the active perfmon here,
v3d_perfmon_stop_locked() clears active to NULL and stops the hardware,
breaking the global perfmon while leaving v3d->global_perfmon set.

> +	v3d->perfmon_state.active =3D NULL;
> +
> +	/* If the device is suspended, the HW has already stopped counting. */
> +	if (!pm_runtime_get_if_active(v3d->drm.dev))
> +		return;
> +

[Severity: Medium]
Can the hardware counters be permanently lost if a capture (via ioctl or
stop) races with runtime PM autosuspend?

If v3d_perfmon_set_global_ioctl() (with the CLEAR flag) executes while the
device state is RPM_SUSPENDING, pm_runtime_get_if_active() returns 0.

Because v3d->perfmon_state.active is set to NULL just before the check,
this function returns early without reading the hardware registers.

When the driver's suspend callback subsequently calls v3d_perfmon_suspend(),
it sees active =3D=3D NULL and also skips capturing the counters, resulting=
 in
lost counter data.

> +	v3d_perfmon_hw_stop(v3d, perfmon, capture);
> +	v3d_pm_runtime_put(v3d);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-v3d-perfmo=
n-lifetime-v3-0-fd26dfdc2153@igalia.com?part=3D1
