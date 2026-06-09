Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067F5CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BA210E21A;
	Tue,  9 Jun 2026 10:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wocpg+w+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F8810E21A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:05:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F93F43F43;
 Tue,  9 Jun 2026 10:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FADB1F00893;
 Tue,  9 Jun 2026 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999519;
 bh=CNoAJeHoW2ZxmfjoBssqeejhGe8Iwc28cbcWvs0EaEE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wocpg+w+aCyq8MPJ+F1eQNbePmdte+v+BPf994mt1ZUFiopqOiJUuRW3qKFKgBvOU
 ieM8WX3WhsTypsMkuXFZbrgL2zClm8dqeWcni8nG6PilUxQ9smA1oONToTFCuo+WH/
 I4Fua8jlVxnU9B46wABPJtotV7wIRr5UcLozxm0uEbLna209n9gOlqIN0Wuhl+c9rv
 cRixWvwo4x2Dfi8LC+EbxVXZO2M5J9WHDwoCWQ0KxRVmuYESacQ4+QH5NIJqeFzXTO
 /DEP/qSwA5yhQzejS6rnMR7Q6D/FIeJ7QuXkY4HUd3SqtLM5lr1DWzKqh7dqbJD4+U
 OJp2Xr2mrag3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/15] drm/msm/dp: split link setup from source params
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-6-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-6-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:05:18 +0000
Message-Id: <20260609100519.2FADB1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Link retraining erases active stream configurations due to overwri=
ting shared register
--

commit c62d46d098f37a3918af36fbf87cf140b8d49f60
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: split link setup from source params

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 71d45b2c4daf8..1c2eccec6ec6d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2551,6 +2547,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_=
dp_ctrl, bool force_link_train
>  	 */
>  	reinit_completion(&ctrl->video_comp);
> =20
> +	msm_dp_ctrl_lane_mapping(ctrl);
> +	msm_dp_setup_peripheral_flush(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how link setup
and stream setup share registers, can msm_dp_ctrl_config_ctrl_link() wipe
out active stream configurations?

In msm_dp_ctrl_config_ctrl_link(), the REG_DP_CONFIGURATION_CTRL register
state is built from 0 rather than reading the existing state:

u32 config =3D 0;
const u8 *dpcd =3D panel->dpcd;

/* Default-> LSCLK DIV: 1/4 LCLK  */
config |=3D (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
...
msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);

When msm_dp_ctrl_link_maintenance() triggers link retraining due to a sink
request, it eventually calls msm_dp_ctrl_config_ctrl_link(). Because this
function overwrites the shared REG_DP_CONFIGURATION_CTRL register without
a read-modify-write, does it erase all stream configurations (like
DP_CONFIGURATION_CTRL_RGB_YUV or DP_CONFIGURATION_CTRL_SEND_VSC)
previously set by msm_dp_ctrl_config_ctrl_streams()?

If the maintenance routine then resumes sending video, this might leave the
hardware outputting an incorrect stream format. Would it be safer to use
msm_dp_read_link() to preserve the existing register state?

> +
>  	msm_dp_ctrl_configure_source_params(ctrl);
> =20
>  	msm_dp_ctrl_config_msa(ctrl,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D6
