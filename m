Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5629CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3003B10F09E;
	Mon, 12 Oct 2026 13:05:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DBB10F09E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:05:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 495C6602CC;
 Mon, 12 Oct 2026 13:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64E91F0089C;
 Mon, 12 Oct 2026 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810334;
 bh=YSM/pKBAZ4NqE8mj0WfTLZGjxlyv0bu9j6h7z5ebO6c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oMjT/isDKv4SFnjAs1+bzF5GfcP+9TVrhYQg47lUBPlXhoNCPeQ9+l3exSA8qoLb0
 U/SyuP1TaYopYJy26mDCZBPS+Sx1TaYOJoq3QyQUgp/z7o2gwMkwhdDgmpoS0h/khg
 YVtiDZ0zfXRkLojYGI1xri2Kf/nFVKYryBN+ybVEVj+/S/nlUU85jaAhx+EGTvjs/3
 EEbrGLLGmWjH9QIeClBnlYa7hWLNXFWCjVW1HsgPWgZsCuvQQJU8Y3UaIcIoC2h16F
 UV7I+p1EGgNI33QnZmxNW3Yl6c50sLCM1/8CdDe24ji1PXLWaRLsQzlEn/CRg2Wk9f
 N8gnR+GM0nQ+w==
Message-ID: <sashiko-outbox-168138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] drm/panthor: Minor scheduler refactoring
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012125940.3291951-3-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-3-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:05:33 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unassigned return value from csg_slot_prog_locked() causes dead =
error path
--

commit 7eff0da835de3ef4c810c3a0eb36aa6ce221f295
Author: Florent Tomasin <florent.tomasin@arm.com>

drm/panthor: Minor scheduler refactoring

This commit refactors parts of the group scheduling logic into new helper
functions. This change simplifies the addition of the protected mode feature
and removes redundant assignments of csg_slot.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 0493858e55d76..68425fe561d1a 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2345,12 +2345,85 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
[ ... ]
> +static int
> +tick_ctx_schedule_group(struct panthor_scheduler *sched,
> +			struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			struct panthor_group *group,
> +			int csg_id, int csg_prio)
> +{
> +	struct panthor_device *ptdev =3D sched->ptdev;
> +	struct panthor_fw_csg_iface *csg_iface =3D
> +		panthor_fw_get_csg_iface(ptdev, csg_id);
> +	int ret;
> +
> +	ret =3D group_bind_locked(group, csg_id);
> +	if (ret)
> +		return ret;
> +
> +	csg_slot_prog_locked(ptdev, csg_id, csg_prio);
> +	if (ret) {
> +		group_unbind_locked(group);
> +		return ret;
> +	}

[Severity: Medium]
Is the return value from csg_slot_prog_locked() intentionally ignored here?

Because `ret` was successfully checked after group_bind_locked(), it is
guaranteed to be 0 at this point. As a result, the `if (ret)` check will
always evaluate to false, making the error handling block dead code.

If csg_slot_prog_locked() fails, the failure is silently ignored and the
function proceeds to queue CSG_STATE_START hardware requests for a slot that
hasn't been successfully programmed, which can lead to hardware timeouts or
undefined behavior.

Should this be `ret =3D csg_slot_prog_locked(ptdev, csg_id, csg_prio);` ins=
tead,
matching the patch's stated intention in the v4 changelog to handle the err=
or
from this function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012125940.3291=
951-1-ketil.johnsen@arm.com?part=3D2
