Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD991CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006CB10E215;
	Tue,  9 Jun 2026 10:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g9ryf6ET";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6026210E216
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:04:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F9074018B;
 Tue,  9 Jun 2026 10:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45DF1F00893;
 Tue,  9 Jun 2026 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999474;
 bh=rPRNwG4L7REI2VHQgEgUWNn2agrCepQO6MhT9+iFf5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g9ryf6ETzw6kUQHs6m5Hhco+l6ZNbEd1IUwpobWXW9X+TMgm34e2RW+8EiVSygBly
 Fxduk8Ys2iUMtR/HzCBdAfmmnDE6l5giy+gayVQ1QyepBK5tpJdtvaqAyCPxajnEFp
 R9qDb4LHniAYlZ85r5ndnHqX80k+jIgAmyhMsS0XTErEsydLIl5hWuyG88AmOvnQH3
 b3WkWd7V6GSZTb09mz/oafPHaCCgsF2shyGE5/Lzeov55jQrG7/ezorsz2wUOUDdFq
 T+DheRf9CtiCxywhS1l1g8rTJ2lEJh6BVfmh/e9kBHBKFtn+vVJP3wTUAD02HN3VLO
 GNlPCm+x9v+ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-4-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-4-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:04:33 +0000
Message-Id: <20260609100433.E45DF1F00893@smtp.kernel.org>
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
- [High] Splitting `msm_dp_ctrl_config_ctrl()` causes stream configuration =
state to be permanently lost during dynamic link maintenance, leading to di=
splay corruption.
--

commit 83fda55d30fe1cd098ad8cc76e151a0398a09b6a
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
   =20
The DP_CONFIGURATION_CTRL register contains both link-level and
stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
all of them together. Separate the configuration into link parts and
stream parts to support MST.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 86ef8c89ad443..ed2ba47881fd0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctr=
l)
> +{
> +	u32 config =3D 0;
[ ... ]
> -	if (ctrl->panel->psr_cap.version)
> -		config |=3D DP_CONFIGURATION_CTRL_SEND_VSC;
> -
> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=3D0x%x\n", config);
> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=3D0x%x\n", config=
);
> =20
>  	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>  }
[ ... ]
> @@ -1628,7 +1644,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctr=
l_private *ctrl,
>  	u8 assr;
>  	struct msm_dp_link_info link_info =3D {0};
> =20
> -	msm_dp_ctrl_config_ctrl(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);

[Severity: High]
Does splitting this configuration cause the stream state to be permanently =
lost
during dynamic link maintenance?

Before this patch, msm_dp_ctrl_config_ctrl() programmed both link and stream
parameters. Now, msm_dp_ctrl_config_ctrl_link() initializes config =3D 0 and
overwrites REG_DP_CONFIGURATION_CTRL, which erases any existing stream
configuration.

While normal initialization restores stream parameters by calling
msm_dp_ctrl_configure_source_params() after link training, dynamic link
maintenance paths (like msm_dp_ctrl_link_maintenance() calling
msm_dp_ctrl_setup_main_link()) perform link training and then transition
directly to DP_STATE_CTRL_SEND_VIDEO without re-applying the stream
parameters:

msm_dp_ctrl_link_maintenance()
    ...
    ret =3D msm_dp_ctrl_setup_main_link(ctrl, &training_step);
    ...
    msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);

Since msm_dp_ctrl_setup_main_link() eventually triggers
msm_dp_ctrl_link_train() which calls msm_dp_ctrl_config_ctrl_link(), will t=
his
result in the DP stream coming back up with critical parameters cleared (e.=
g.,
0 BPC, no VSC, incorrect color format), breaking the display output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D4
