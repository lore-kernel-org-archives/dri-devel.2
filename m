Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNnTUGZH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038F910E9EE;
	Wed, 11 Nov 2026 10:58:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B157210E9EE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:58:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3632963000;
 Wed, 11 Nov 2026 10:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976761F00A05;
 Wed, 11 Nov 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794394706;
 bh=EnYsD0a4kS9tzKhB3SVsnrlBjDBKM5vQ4H4Ua+5YLj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fNnTUGZH3kNBBlcSvUFzsdLEtP49pw8PhNxevKvkQ5CXCprjHJ1PvZqzJKcPh9JoD
 RnHUOu7qeglC9i2vbF8hWALSkcr86SUoJARkSk3xHzksdQqgSx8zQArqmZzkrPQocU
 LJcAQ/Nv6ThcwdkYH44cQWpVPjawuGZtlQi/59DoOOd02sXR1UOk2iaokLZ+sscu5S
 j4OGucudyztwg1oBXSXbO9un4QJQjCRbh3bjjQoA9qpb7379af/OhVtLPheFxu5o/e
 Vm1iG9Kb0GimiDuzPBGUmqaCo44rX28YDYXH6NrajfVZxVtxnXuZm4QodSXOHQXXsK
 CpCqgCq9b+BFw==
Message-ID: <sashiko-outbox-208838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/msm/dp: continue link training downgrade
 when cable is still plugged
To: "naidu nama" <naidu.nama@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:58:26 +0000
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
- [Medium] drm/msm/dp: pass-by-value plugged in msm_dp_ctrl_on_link()
  breaks unplug abort
- [Medium] drm/msm/dp: uninitialized link_status read in
  msm_dp_ctrl_on_link()
--

commit 03d6b22aa9378458ab94c6193f79ad69b24cfe32
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

drm/msm/dp: continue link training downgrade when cable is still plugged

This commit passes dp->plugged into msm_dp_ctrl_on_link() so the link
training retry loop only aborts when both msm_dp_aux_is_link_connected()
and plugged are false.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 6b9d9a76ba059..f8a6bd7b0d107 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2377,7 +2378,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp=
_ctrl_private *ctrl)
>  }
> =20
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
> -			struct msm_dp_panel *panel)
> +			struct msm_dp_panel *panel, bool plugged)
>  {
>  	int rc =3D 0;
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2427,7 +2428,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_=
ctrl,
>  			break;
>  		} else if (training_step =3D=3D DP_TRAINING_1) {
>  			/* link train_1 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>  				break;

[Severity: Medium]
Does passing dp->plugged by value into msm_dp_ctrl_on_link() prevent the
retry loop from ever breaking out on an unplug during link training?

At both callers (msm_dp_display_prepare_link() and
msm_dp_display_handle_irq_hpd()), dp->plugged is true when link training
starts, and msm_dp_display_prepare_link() also reads dp->plugged without
holding dp->plugged_lock.  If the cable is unplugged while the retry loop is
running, msm_dp_hpd_unplug_handle() sets dp->plugged =3D false, but the loc=
al
plugged parameter in msm_dp_ctrl_on_link() stays true for every iteration,
so !plugged is always false and all remaining downshift retries and PHY
power-cycles still run on the disconnected link.

Also, the commit message refers to msm_dp_ctrl->plugged, which does not
exist in struct msm_dp_ctrl or struct msm_dp_ctrl_private.

> =20
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> @@ -2452,7 +2453,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_=
ctrl,
>  			}
>  		} else if (training_step =3D=3D DP_TRAINING_2) {
>  			/* link train_2 failed */
> -			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
> +			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
>  				break;
> =20
>  			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);

[Severity: Medium]
When continuing past !msm_dp_aux_is_link_connected(ctrl->aux) in the
DP_TRAINING_1 and DP_TRAINING_2 failure paths, can this read uninitialized
stack bytes from link_status[]?

link_status is declared on the stack without initialization in
msm_dp_ctrl_on_link().  When the AUX channel is transiently disconnected or
a concurrent unplug disables AUX transfers, drm_dp_dpcd_read_link_status()
fails without writing to link_status, and its return value is not checked
before msm_dp_ctrl_clock_recovery_any_ok() and drm_dp_clock_recovery_ok()
inspect link_status to choose between rate downshift, lane downshift, and
abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111104434.2222=
182-1-naidu.nama@oss.qualcomm.com?part=3D3
