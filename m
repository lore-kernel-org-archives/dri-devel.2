Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01169606A32D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3DsQs/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F0210E290;
	Sun, 15 Nov 2026 00:19:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CEE10E290
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:19:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE93C41FD6;
 Sun, 15 Nov 2026 00:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797981F000C4;
 Sun, 15 Nov 2026 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794701948;
 bh=LDEh9MmxxEwNpt9FNNEfINnMriOnR79U+IZ/tvBg0V4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T3DsQs/BKF7t4hHTBwt9Y1/qiP4eH9san02gSmqD2CZ9bCD7k/RXUMCrpCQXuYgmj
 8tRyr3us+FiPTSS1mQAEdHphFt4t47fXFxwMIIZJDCsvOzSez7JdwNPif6UfOhzBIK
 QswHWiS4/wJJSoVSHn3Hklp0lcO+preoEsT+kvHa4CLw1npJ3JhIkt3VGvOleyHymg
 VrZ6f3o5ZJb1DVAuAMTTKMzBgf/jmPaGin2Jd3uCR+0wpDYHTPotZq9JQbIpU1vSo8
 icxGHw9amkYBLxbmMSnLtlpk91IKOLX5s8BwzRj1cNshNL1c5oguq4ABKzA6FXL5RX
 6vSQYhrhUOCzg==
Message-ID: <sashiko-outbox-215142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: don't fall back to a link that can't carry
 the eDP mode
To: "Jesse Casco" <jesse.casco@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261115000021.78869-1-jesse.casco@gmail.com>
References: <20261115000021.78869-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:19:08 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/msm/dp: unpropagated eDP 1.4 link_info fields in
  msm_dp_ctrl_on_link() [1]
--

commit 2e586911d41c02809032afda8e106d6b81011527
Author: Jesse Casco <jesse.casco@gmail.com>

drm/msm/dp: don't fall back to a link that can't carry the eDP mode

When eDP link training downshifts to a link rate or lane count that lacks
enough bandwidth for the panel mode, this commit restores the previous
link parameters and retries training instead of training a link that
leaves the panel dark.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 47647fdec9de5..c77427aadcb46 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2420,6 +2433,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_=
ctrl,
>  		return rc;
> =20
>  	while (--link_train_max_retries) {
> +		prev_params =3D ctrl->link->link_params;
>  		training_step =3D DP_TRAINING_NONE;
>  		rc =3D msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
>  		if (rc =3D=3D 0) {

[Severity: Medium]
This problem wasn't introduced by this patch, but does
msm_dp_ctrl_on_link() drop the eDP 1.4 supported_rates, rate_set, and
use_rate_set fields from panel->link_info when initializing
ctrl->link->link_params [1]?

Earlier in msm_dp_ctrl_on_link(), only rate and num_lanes are copied into
ctrl->link->link_params (and msm_dp_ctrl_link_lane_down_shift() likewise
restores only rate from panel->link_info):

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_on_link() {
    ...
	} else {
		ctrl->link->link_params.rate =3D rate;
		ctrl->link->link_params.num_lanes =3D
			panel->link_info.num_lanes;
    ...
}

In addition, msm_dp_ctrl_link_train() copies only num_lanes, rate, and
capabilities into the local link_info struct passed to
msm_dp_aux_link_configure().

Because use_rate_set and rate_set remain zero in both places,
msm_dp_aux_link_configure() never writes DP_LINK_RATE_SET on eDP 1.4+
panels, and msm_dp_ctrl_link_rate_down_shift() bypasses supported_rates[]
and fails with -EINVAL on intermediate eDP 1.4 link rates.

[1] https://sashiko.dev/#/bug/linux-bd6dd9b8-1fc3-40aa-82c1-7f5b2c6afbc1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115000021.7886=
9-1-jesse.casco@gmail.com?part=3D1
