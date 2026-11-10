Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42917606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEcnIXoF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971BC10EDCA;
	Tue, 10 Nov 2026 05:25:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71B710EDCA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:25:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B3B36123A;
 Tue, 10 Nov 2026 05:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C01F0089F;
 Tue, 10 Nov 2026 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288345;
 bh=P1N9xAVhds+O9wb4WTriyPNBUP3WPAIDoxZfYdFVWBQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LEcnIXoFhVa/+tY5Ihy7qDC0UqV960te0swxhSUQOiv4AJ5AvV+TO3aT2PG4oAcrK
 VN08Sa5LFdSG7JM4X0GMnoSjsWf5gintIz8HWNu7hZz/0j3B/Opa7x3mpDs0+iz1At
 luofccJndzzuBOyTt3nO+uBsN8RNAeQKffw+ZsmImUQMoOfEuOwxQsCgSPxRhvwVOB
 tyCY+yIRnmhfY+WP6U1SqLPlzlj3pqGY8V19ZF1XFpGzeaczk6G9OMrSAv5s6CwJ/x
 FZMXmEG3Nuf6CEqA5r/PtB/xCeHUYH+cqQidhtLOrQq8RLecgoEdRTitPyjZNbk5Xv
 zLyM/prNbImGw==
Message-ID: <sashiko-outbox-206288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/29] drm/msm/dp: mark the SST bridge disconnected
 when mst is active
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-23-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-23-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:25:45 +0000
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
- [Medium] drm/msm/dp: unlocked mst_active check in
  msm_dp_bridge_detect()
--

commit 485c09f4556b36ae4b303173f11055d3729894af
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: mark the SST bridge disconnected when mst is active

This commit returns disconnected from msm_dp_bridge_detect() for the SST
bridge when dp->mst_active is set.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index b4e788d1f611d..f87eea19c4f58 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -976,7 +976,11 @@ enum drm_connector_status msm_dp_bridge_detect(struc=
t drm_bridge *bridge,
> =20
>  	priv =3D container_of(dp, struct msm_dp_display_private, msm_dp_display=
);
> =20
> +	if (dp->mst_active)
> +		return status;
> +
>  	guard(mutex)(&priv->plugged_lock);

[Severity: Medium]
Should dp->mst_active be checked after acquiring priv->plugged_lock, as
msm_dp_irq_hpd_handle() does?

drm_bridge_connector_hpd_notify() runs without dev->mode_config.mutex, so
priv->plugged_lock is what serializes HPD plug handling against concurrent
connector probing:

CPU0                                  CPU1
msm_dp_hpd_plug_handle()
  mutex_lock(&dp->plugged_lock)
  msm_dp_display_process_hpd_high()
                                      msm_dp_bridge_detect()
                                        if (dp->mst_active) // false
                                        mutex_lock(&priv->plugged_lock)
    ...
    msm_dp_display_mst_enable()
      msm_dp->mst_active =3D true
  dp->plugged =3D true
  mutex_unlock(&dp->plugged_lock)
                                        pm_runtime_resume_and_get(...)
                                        ...
                                        priv->plugged =3D true
                                        // returns without pm_runtime_put_s=
ync
                                        // <-- leaks runtime PM reference

Once msm_dp_bridge_detect() enters the SST detection path after MST has been
enabled, a successful DPCD read leaves an extra runtime PM reference that
msm_dp_hpd_unplug_handle() never drops, while a failed AUX transfer clears
priv->plugged and causes msm_dp_hpd_unplug_handle() to bail out without
disabling MST.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D23
