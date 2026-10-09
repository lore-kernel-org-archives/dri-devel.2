Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A8CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD2010FE3A;
	Fri,  9 Oct 2026 03:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DtlO+l2b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3AC10FE3A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:28:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BF7E41433;
 Fri,  9 Oct 2026 03:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5281F000FF;
 Fri,  9 Oct 2026 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516535;
 bh=KDRGUQEvleVgZ50NmhKARf7BLY4q08cxZc5+JRNScVc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DtlO+l2bCXmQzs700KOttxF6NiVzCd+YbiMyDuZ7QfLsqCqVutRLueMdlb72DXNsJ
 6utaRrTMijHxSkDouv1QegjVNjH0c8lPTpcOZwPzX5shlKvSlr5jsNV7vTjTdzL7Vk
 D0Vi11bqvPy/rTv7EsRKw3aGhogdLHu0qifVgjJdDxPyGU/g1QfXcyWKW4ZkWubFSY
 SrjCxKcAa2mUJBBVDCc8XCHfa7HX/RB2xLcT6EdU/7UqlLdKSZ4x+11E2e0ZZKOHeQ
 WuRJrwLDrdbU8r2ikJqTwYjnxtTSsTQVIDagzrpLXN2v6Lje5bUEcQRCES11b1YIKx
 3a3uTqiLP5GPg==
Message-ID: <sashiko-outbox-164763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/20] drm/msm/dp: Report stream enable failures
 through link status
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-10-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-10-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:28:55 +0000
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
- [Low] drm/msm/dp: mixing goto and scoped_guard in msm_dp_display_atomic_e=
nable()
--

commit 5389d76b8ea91b24082be0a6254cd0c780518e0d
Author: Xilin Wu <sophon@radxa.com>
drm/msm/dp: Report stream enable failures through link status

This commit updates the driver to mark the connector link status as bad from
a work item after unwinding a failed enable. It sends a single hotplug
notification per failure episode, allowing fbdev to retry the modeset
synchronously while preventing unbounded retry loops.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index b076d44b5118c..816f2dc11aea1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1583,6 +1633,11 @@ void msm_dp_display_atomic_enable(struct msm_dp *m=
sm_dp_display,
>  	if (msm_dp_display->is_edp)
>  		msm_dp_hpd_unplug_handle(dp);
>  	msm_dp_display_unprepare(dp);
> +	scoped_guard(mutex, &dp->plugged_lock) {

[Severity: Low]
This isn't a functional bug, but does it mix goto-based error handling and
scope-based cleanup in the same function?

The function msm_dp_display_atomic_enable() uses goto-based error handling
with the err and err_prepare labels to manage its cleanup sequence.

The kernel guidelines in include/linux/cleanup.h advise against mixing
goto-based cleanup and guard declarations within the same routine, as it
can create confusing ownership semantics.

Could this be refactored to use standard mutex_lock() and mutex_unlock() to
maintain structural consistency?

> +		dp->link_failed =3D true;
> +		/* Keep reporting BAD, but notify only once until recovery. */
> +		schedule_work(&dp->link_status_work);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D10
