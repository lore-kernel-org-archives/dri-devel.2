Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7036C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A3B10ECDB;
	Tue, 29 Sep 2026 04:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E8+60Tvj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F7010ECD7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:54:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACA5960210;
 Tue, 29 Sep 2026 04:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457491F000FF;
 Tue, 29 Sep 2026 04:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657675;
 bh=FPcw/mPFE0XjkmELhOOTpWiIqZikoXbr/bhxyeQ68y0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E8+60Tvj57bu+FaDfdbls0Hk8z+OmDIs6jNgplT1eeEc6QPtYFKHaEKyuzhe7DwdL
 4+FgAEXoghQ0/6VSm6boNc2bgL3XYMC1HFZx1fb3pLFcMA5zPy8pc1pf4ZQmhUH5iJ
 wXo9uClSsOgBYzGPzFWq6UVT5rNn5yeIMgWZ1h299kBytb045KAjpZVV/k5EsmwRG/
 pqV2WQSU/bEZz4fDyPbfmijYEmhWgqebBs3JjBar6xsXmcjJXryAIK7F+ay0f1rIkW
 iYNdaSheQvU6MKkodShXtbRkIb0vGJQ3TlUxbg1Ntyea3JrkNUqgy36zJEXCStKNgJ
 MBsawqzClCd8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 34/35] drm/msm/dp: order IRQ HPD handling with plug
 state changes
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-34-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-34-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:54:34 +0000
Message-Id: <20260929045435.457491F000FF@smtp.kernel.org>
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
- [Medium] drm/msm/dp: TOCTOU race in IRQ_HPD handling causes pm_runtime le=
ak for SST/eDP
--

commit 99b95a07a6fbe8a19b13f048313ddac554ebf859
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: order IRQ HPD handling with plug state changes

This commit orders IRQ HPD handling with plug state changes. It ensures
the link is initialized via the plug path before handling the IRQ, and
ignores stale IRQs if an unplug event is also present.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index ed0b93e3bd08f..94446bcf9448a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1818,6 +1821,9 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *br=
idge,
>  	if (status =3D=3D connector_status_connected) {
>  		if (hpd_link_status =3D=3D ISR_IRQ_HPD_PULSE_COUNT ||
>  		    event =3D=3D DRM_CONNECTOR_DP_IRQ_HPD) {
> +			if (!dp->plugged)
> +				msm_dp_hpd_plug_handle(dp);
> +
[Severity: Medium]
Can this lockless read of dp->plugged lead to a Time-Of-Check to Time-Of-Use
race with concurrent threads (like userspace detect or modeset)?

If msm_dp_bridge_hpd_notify() checks if (!dp->plugged) here and evaluates it
as true, it will prepare to call msm_dp_hpd_plug_handle(). Concurrently, if
another thread (e.g., userspace polling via msm_dp_bridge_detect) takes the
plugged_lock, gets a PM reference, and sets dp->plugged =3D true, this thre=
ad
will then call msm_dp_hpd_plug_handle() anyway.

Inside msm_dp_hpd_plug_handle(), we have:

    guard(mutex)(&dp->plugged_lock);
    if (dp->plugged && dp->msm_dp_display.mst_active)
        return 0;
   =20
    ret =3D pm_runtime_resume_and_get(&pdev->dev);

Because mst_active is false for SST/eDP, it fails to abort when already
plugged by the racing thread, proceeding to acquire a second PM reference.
This can result in a permanent pm_runtime reference leak, preventing the DP
controller from suspending, as unplug_handle() will only drop one reference.

>  			msm_dp_irq_hpd_handle(dp);
>  		} else if (hpd_link_status =3D=3D ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D34
