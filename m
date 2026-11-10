Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7760A3801
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6gvwHv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4722C10F7F1;
	Tue, 10 Nov 2026 16:04:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B175E10F7F1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 960E842BA6;
 Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1381F008A4;
 Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326639;
 bh=p3HyDQ76VwMGERXpn2Mi6+yyKmWxXkwcqgOUJdDA+nM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=n6gvwHv/zvuKwrCUGUKoF1PWU7tZVur2L1lleIqfnN2iRjrxAuPbAlHaGY+H9IRMm
 6wsvNPRTBBftnbiPhjfEkwpoDn58SzB3d548eG/7gUrUK12iGWZ2wqqruBpshrWphe
 Y3dTxCc1Os9V8PHUfxRRICqghlEGj3AZ5mC/7NLlk/77rIIJ+DrHcG+jX8bsnSq0ok
 ccXfi+2d6S3ufneyu/crSPAU19eDxuzd5IGAp9dBk1P0V5Ris8AqpQ6GyO0cgmXqGu
 t1t7Pa3zPeslaqqCX9DOV6ya8qq4f3MlU4YbvzT0TqFa14Wl7USUVCFOQqyGYSap3E
 tEK0pLVc4NwNw==
Message-ID: <sashiko-outbox-207337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/28] drm/panthor: Add AW assignment tracking
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-20-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-20-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:03:58 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/panthor: race replaying pending AW requests in
  arbitration_resource_init()
- [Low] drm/panthor: remove extraneous semicolon after
  to_assigned_sched_idx()
- [Low] drm/panthor: initialize __free() variable in
  arbitration_dt_parse_assigned_aw()
--

commit e073b116d1f4f953a3ab51f1f483486ff4942f9f
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AW assignment tracking

This commit tracks the scheduler assigned to each access window, initializes
assignments from device tree partition masks, and replays requests that
arrive before access windows are assigned.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.=
c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> index 48016d0d88557..6479a7602868c 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c

[ ... ]

> @@ -17,6 +19,28 @@
> =20
>  #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
> =20
> +#define DT_ASSIGNED_AW				"arm,access-window-mask"
> +
> +static int to_assigned_sched_idx(struct panthor_arbitration *adev, u8 aw=
_id)
> +{
> +	int idx =3D -1;
> +
> +	lockdep_assert_held(&adev->assignment_lock);
> +
> +	if (aw_id >=3D AM_ARB_MAX_AW_COUNT) {
> +		dev_err(adev->dev, "Invalid AW ID (%u)", aw_id);
> +		return -EINVAL;
> +	}
> +
> +	idx =3D adev->aw_sched_map[aw_id];
> +	if (idx < 0 || idx >=3D AM_ARB_MAX_PC_COUNT || !adev->sched[idx]) {
> +		dev_warn_ratelimited(adev->dev, "AW%u not assigned to any sched", aw_i=
d);
> +		return -ENOENT;
> +	}
> +
> +	return idx;
> +};

[Severity: Low]
This isn't a bug, but there is an extra semicolon after the closing brace of
to_assigned_sched_idx().

> @@ -57,42 +81,226 @@ static int panthor_arbitration_runtime_resume(struct=
 device *dev)
>  	return 0;
>  }
> =20
> +static u32 arbitration_get_sched_aw_mask(struct panthor_arbitration *ade=
v,
> +					 u8 sched_id)
> +{
> +	u32 aw_mask =3D 0;
> +
> +	lockdep_assert_held(&adev->assignment_lock);
> +
> +	for (int i =3D 0; i < AM_ARB_MAX_AW_COUNT; i++) {
> +		if (adev->aw_sched_map[i] =3D=3D sched_id)
> +			aw_mask |=3D BIT(i);
> +	}
> +
> +	return aw_mask;
> +}
> +
> +static int arbitration_dt_parse_assigned_aw(struct panthor_arbitration *=
adev)
> +{
> +	struct panthor_arbitration_dt_info *dt_info =3D &adev->dt_info;
> +	struct device *dev =3D adev->dev;
> +	struct fwnode_handle *partitions __free(fwnode_handle) =3D NULL;
> +	u32 seen_mask =3D 0;
> +	u8 seen_partitions =3D 0;
> +	int ret;
> +
> +	partitions =3D device_get_named_child_node(dev, "partitions");

[Severity: Low]
This isn't a bug, but per the Cleanup API conventions, partitions can be
defined and initialized in a single statement rather than initialized to
NULL and assigned separately.

[ ... ]

> +static void arbitration_retry_pending_requests(struct panthor_arbitratio=
n *adev, u32 mask)
> +{
> +	unsigned long aw_mask =3D mask;
> +	u8 aw_id;
> +
> +	for_each_set_bit(aw_id, &aw_mask, AM_ARB_MAX_AW_COUNT) {
> +		int ret;
> +
> +		if (!test_and_clear_bit(aw_id, adev->pending_aw_request_mask))
> +			continue;
> +
> +		ret =3D panthor_arbitration_on_request(adev, aw_id);
> +		if (ret && ret !=3D -EEXIST)
> +			set_bit(aw_id, adev->pending_aw_request_mask);
> +	}
> +}
> +
> +static int arbitration_resource_init(struct panthor_arbitration *adev)
> +{
> +	struct panthor_arbitration_dt_info *dt_info =3D &adev->dt_info;
> +
> +	/*
> +	 * If arm,access-window-mask is not defined or set to 0, assign AWs to
> +	 * PC0 by default.
> +	 */
> +	if (!dt_info->default_aw_masks[0])
> +		dt_info->default_aw_masks[0] =3D AM_ARB_MAX_AW_MASK;
> +
> +	for (int i =3D 0; i < AM_ARB_MAX_PC_COUNT; i++) {
> +		unsigned long pc_aw_mask =3D dt_info->default_aw_masks[i];
> +		u8 aw_id;
> +		int ret;
> +
> +		if (!adev->pc[i] || !adev->sched[i])
> +			continue;
> +
> +		scoped_guard(spinlock_irqsave, &adev->assignment_lock) {
> +			for_each_set_bit(aw_id, &pc_aw_mask, AM_ARB_MAX_AW_COUNT)
> +				adev->aw_sched_map[aw_id] =3D i;
> +		}
> +
> +		ret =3D arbitration_sched_try_start(adev, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	arbitration_retry_pending_requests(adev, AM_ARB_MAX_AW_MASK);
> +
> +	return 0;
> +}
> +
>  /* AW to Arbiter events */
>  int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 =
aw_id)
>  {
> -	/* TODO: AW to PC assignment */
> -	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
> +	int idx;
> +
> +	guard(spinlock_irqsave)(&adev->assignment_lock);
> +
> +	idx =3D to_assigned_sched_idx(adev, aw_id);
> +
> +	if (idx =3D=3D -ENOENT) {
> +		set_bit(aw_id, adev->pending_aw_request_mask);
> +
> +		return 0;
> +	} else if (idx < 0) {
> +		return idx;
> +	}
> +
> +	return panthor_arbitration_sched_on_request(adev->sched[idx], aw_id);
>  }

[Severity: Medium]
Can a request interrupt arriving between publishing adev->aw_sched_map[] and
arbitration_retry_pending_requests() reorder or duplicate AW requests?

panthor_resource_group_init() enables Resource Group interrupts and starts
the AW handshake before arbitration_resource_init() runs.  If an AW sends
VM_ARB_GPU_REQUEST before adev->aw_sched_map[] is populated,
panthor_arbitration_on_request() sets its bit in pending_aw_request_mask.
arbitration_resource_init() then populates adev->aw_sched_map[], drops
assignment_lock, and starts the scheduler before draining
pending_aw_request_mask:

CPU0                                  <hardirq>
arbitration_resource_init()
                                      rg_irq_handler()
                                        ...
                                          panthor_arbitration_on_request(aw=
0)
                                            set_bit(0, pending_aw_request_m=
ask)
  lock(&adev->assignment_lock)
  adev->aw_sched_map[aw_id] =3D i
  unlock(&adev->assignment_lock)
  arbitration_sched_try_start()
                                      rg_irq_handler()
                                        ...
                                          panthor_arbitration_on_request(aw=
0)
                                            panthor_arbitration_sched_on_re=
quest()
  arbitration_retry_pending_requests()
    test_and_clear_bit(0, ...)
    panthor_arbitration_on_request(aw0)
      panthor_arbitration_sched_on_request()  <-- duplicate replay

Because panthor_arbitration_on_request() does not clear aw_id in
pending_aw_request_mask when idx >=3D 0, a resent request (such as from
panthor_aw_handshake_handle() on ARB_VM_INIT) is queued once by the
interrupt handler and replayed a second time by
arbitration_retry_pending_requests(), triggering a spurious warning in
panthor_arbitration_sched_on_request() or an extra GPU grant if the AW has
already entered ARB_SCHED_PHASE_STOPPING or ARB_SCHED_PHASE_IDLE.  A request
from a different AW in that window also bypasses the earlier pending request
and is granted the GPU first.

Replaying pending requests under assignment_lock when populating
adev->aw_sched_map[] (before starting the scheduler), or clearing
pending_aw_request_mask in panthor_arbitration_on_request(), would avoid the
race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D19
