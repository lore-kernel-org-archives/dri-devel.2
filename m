Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D7C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BC010E0D4;
	Tue, 14 Jul 2026 21:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sd1KjvXG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3738D10E0D4
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D0E8601D9;
 Tue, 14 Jul 2026 21:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0397C1F000E9;
 Tue, 14 Jul 2026 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784064423;
 bh=SvXDW7J7jPIWH484T3DKZdikgboJXt22Q+eqUYK+3zM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sd1KjvXGxxmDRYEY5V+UBg9LGdr3KhOaL6QksqNy7xFtGoVj6vHN4DgFQplTMdaKH
 0igNY0zZ3BxruOY+gJF8qEoapnN4B0b+xuuSkiEjliZQxouFzqb8zoOErNtvVGO0Ar
 wjTMPQ7rO8LGYE7NDsTlTfjdZ8+iuJNEvvfehLjGaWCrcX/FI7Uv5y3EtroHZR7b2d
 bI+jfA5Q5m+krIaBA888/1vcoTVf1cEdJtC1G5vSntf2l9RhBXrabb7cJbtMQFOv3R
 OkA6gvccCQdiqONEl6Ejm6XlH3EFh8o6WECYLU0meiMwfQ4u3XvyHEi2DsS2BGdaI3
 IgTTypTJ2V0Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm/nouveau/gsp: add RUSD telemetry support
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714211429.238355-3-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-3-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:27:02 +0000
Message-Id: <20260714212703.0397C1F000E9@smtp.kernel.org>
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
- [Medium] Missing delay or CPU relax in bounded retry loop causes spurious=
 -EAGAIN on GSP-RM telemetry reads.
- [Medium] Jiffies wrap-around edge case causes telemetry group to be prema=
turely dropped.
--

--- Patch [2]: [PATCH 2/6] drm/nouveau/gsp: add RUSD telemetry support ---
commit e2f85d24749e78bb60d3f7f4d694be38a59b92af
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau/gsp: add RUSD telemetry support

This commit adds RUSD telemetry support for GSP-RM by allocating a shared-d=
ata
buffer and enabling demand-driven polling of sensor data. It tracks group
access and disables polling for groups that have been idle for a timeout pe=
riod.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c
> new file mode 100644
> index 0000000000000..d20dda07596a0
> --- /dev/null
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c
> @@ -0,0 +1,531 @@
[ ... ]
> +static void
> +r570_rusd_poke(struct nvkm_gsp *gsp, enum nvkm_gsp_rusd_group group)
> +{
> +	mutex_lock(&gsp->rusd.mutex);
> +	/* @valid (not gsp->running) is the teardown fence: it is cleared under
> +	 * this mutex at the very start of fini, while gsp->running is still
> +	 * true, so checking it here stops a read from enabling a group and
> +	 * issuing a SET_DATA_POLL to a firmware that is being unloaded.
> +	 */
> +	if (gsp->rusd.valid) {
> +		gsp->rusd.group_access[group] =3D jiffies;
> +		r570_rusd_set_mask(gsp, gsp->rusd.mask | r570_rusd_group_mask[group]);

[Severity: Medium]
If jiffies happens to be exactly 0 during this assignment, could it cause i=
ssues
in the idle worker below?

> +		if (gsp->rusd.mask)
> +			schedule_delayed_work(&gsp->rusd.work,
> +					      msecs_to_jiffies(R570_RUSD_IDLE_MS));
> +	}
> +	mutex_unlock(&gsp->rusd.mutex);
> +}
> +
> +/* Drop the groups that haven't been read within the idle window. */
> +static void
> +r570_rusd_work_drop_idle(struct work_struct *work)
> +{
> +	struct nvkm_gsp *gsp =3D container_of(to_delayed_work(work),
> +					    struct nvkm_gsp, rusd.work);
> +	unsigned long idle =3D msecs_to_jiffies(R570_RUSD_IDLE_MS);
> +	u64 mask =3D 0;
> +	int g;
> +
> +	mutex_lock(&gsp->rusd.mutex);
> +	if (gsp->rusd.valid) {
> +		for (g =3D 0; g < NVKM_GSP_RUSD_GROUP_COUNT; g++) {
> +			if (gsp->rusd.group_access[g] &&

[Severity: Medium]
When jiffies wraps to 0, this check evaluates to false.=20

Will this cause the telemetry group to be prematurely dropped from the poll=
 mask
until the next read cycle?

> +			    time_before(jiffies, gsp->rusd.group_access[g] + idle))
> +				mask |=3D r570_rusd_group_mask[g];
> +		}
[ ... ]
> +/*
> + * Copy one section out of the shared buffer, untorn. Every section star=
ts
> + * with a u64 timestamp GSP-RM sets to WRITE_IN_PROGRESS while updating =
it.
> + */
> +static int
> +r570_rusd_read_section(struct nvkm_gsp *gsp, size_t offset, size_t size,=
 void *data)
> +{
> +	const void *sect =3D gsp->rusd.mem.data + offset;
> +	u64 seq0, seq1;
> +	int retries;
> +
> +	for (retries =3D 10; retries; retries--) {
> +		seq0 =3D READ_ONCE(*(const u64 *)sect);
> +		if (seq0 =3D=3D RUSD_TIMESTAMP_INVALID)
> +			return -ENODATA;
> +		if (seq0 =3D=3D RUSD_TIMESTAMP_WRITE_IN_PROGRESS)
> +			continue;

[Severity: Medium]
Without a delay or cpu_relax() here, the 10 iterations will exhaust extreme=
ly
fast (in tens of nanoseconds).=20

Could this cause spurious -EAGAIN errors if the CPU spins through all retri=
es
before the GSP firmware has time to finish its memory write?

> +		/* Sequence counters appear only in sections written by the kernel and
> +		 * never in GSP-polled ones.
> +		 */
> +		if (seq0 >=3D RUSD_SEQ_START)
> +			return -ENODATA;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714211429.2383=
55-1-mohamedahmedegypt2001@gmail.com?part=3D2
