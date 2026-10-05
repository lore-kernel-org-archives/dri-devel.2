Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA16DCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A165810F20B;
	Tue,  6 Oct 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=laposte.net header.i=@laposte.net header.b="SkEGoMHf";
	dkim-atps=neutral
Received: from smtp-outgoing-1802.laposte.net (smtp-outgoing-1802.laposte.net
 [160.92.124.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6B810E243
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:15:18 +0000 (UTC)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gv1kZfz10MQR","contextId":
 "775944a0-e23f-4087-bb77-5e4c87d0348a"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
 by mlpnf0120.laposte.net (SMTP Server) with ESMTP id 4hz0Gv1kZfz10MQR;
 Mon,  5 Oct 2026 15:14:47 +0200 (CEST)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gt4y5Cz10MQN","contextId":
 "407ccb37-f746-4378-8a4c-0d794e65b55c"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
Received: from PAR-95296130.bcg.com (unknown [147.161.232.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mlpnf0120.laposte.net (SMTP Server) with ESMTPSA id 4hz0Gt4y5Cz10MQN;
 Mon,  5 Oct 2026 15:14:46 +0200 (CEST)
From: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
To: linux-arm-msm@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Saim Shujah <saimzst@gmail.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Subject: [PATCH 2/3] drm/msm/dp: don't log an expected link-training fallback
 as errors
Date: Mon,  5 Oct 2026 15:14:31 +0200
Message-ID: <20261005131432.22840-3-jean-francois.bobier@laposte.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
References: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laposte.net; s=lpn-wlmd;
 t=1791213316; bh=vQgNfaifqJBfWvhAJLZYmdCmSToBEbMrsQb5xsLkevc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 b=SkEGoMHfx4iXME3kup16D4NvPELxSMo3k6+2QaSUDJMTnct6+U8sjO9qmvCZeN/xqN08wySgiIjRrLwyLdjmwsRgHgQXYTyriBUPvPvTl04vh4KD2eMtJ6o+k9BwVcgUcb7PBNxlumdr5S+qbekQRFQtAcoUYG/JGF+Jfs94Go4gA3g03HSK4iHP09bdhLd7gDipO3JGU+v+1StJ0lyCvGTPqS0YtteDJ0dljyH/hrVEZW5CTpBnyOH3vkyq44CYGmTLHHGGUXKqzLG1bME+IR2Y/Qd2I9JnDXEw+Opei6dm8okuNZplMeqa4PE29DnUM1IrpiMFIvXByjgiKeLwsw==;
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

msm_dp_ctrl_on_link() implements DP link fallback: it retries
msm_dp_ctrl_setup_main_link() up to five times, stepping the link rate
down HBR3 -> HBR2 -> HBR -> RBR and then reducing the lane count, and
breaks as soon as training succeeds. Every step of that search is
therefore expected to fail before the one that works.

Each failed attempt currently logs at error level, from four places:

  max v_level reached
  link training #1 on phy %d failed. ret=3D%d
  link training #2 on phy %d failed. ret=3D%d
  link training on sink failed. ret=3D%d

A monitor that settles on two lanes after three attempts prints nine
error lines on a completely successful attach -- which is how a cable
that merely has two bad lanes looks identical in the log to a sink that
never trains at all.

Nothing is lost by demoting them. When the retry loop really does
exhaust itself, msm_dp_ctrl_on_link() returns the error and
msm_dp_display_process_hpd_high() already reports it once, at error
level, as "Failed link training (rc=3D%d)" -- which is the correct place,
because it is the only one that knows the search is over.

Demote the per-attempt messages to drm_dbg_dp() so they remain available
with drm.debug, and keep the final verdict where it is.

Also demote the unsolicited AUX interrupt message. msm_dp_aux_isr()
returns IRQ_NONE when no AUX transaction is outstanding, which is the
whole of the correct response for an interrupt that is not ours -- the
AUX block shares its interrupt and sinks raise AUX status asynchronously
around hotplug, so this fires twice on a normal DisplayPort attach.

Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
---
 drivers/gpu/drm/msm/dp/dp_aux.c  |  9 ++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_=
aux.c
index 3825a2fb4..2c0bc719a 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -458,7 +458,14 @@ irqreturn_t msm_dp_aux_isr(struct drm_dp_aux *msm_dp=
_aux, u32 isr)
 	aux =3D container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux)=
;
=20
 	if (!aux->cmd_busy) {
-		DRM_ERROR("Unexpected DP AUX IRQ %#010x when not busy\n", isr);
+		/*
+		 * Not ours: the AUX block shares its interrupt, and sinks
+		 * raise AUX status asynchronously around hotplug. Returning
+		 * IRQ_NONE is the whole of the correct response, so this is
+		 * a trace point and not a fault.
+		 */
+		drm_dbg_dp(msm_dp_aux->drm_dev,
+			   "Unexpected DP AUX IRQ %#010x when not busy\n", isr);
 		return IRQ_NONE;
 	}
=20
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
index d6219d87d..ccc6cf63d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1534,7 +1534,8 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_c=
trl_private *ctrl,
=20
 		if (ctrl->link->phy_params.v_level >=3D
 			DP_TRAIN_LEVEL_MAX) {
-			DRM_ERROR_RATELIMITED("max v_level reached\n");
+			drm_dbg_dp(ctrl->drm_dev,
+				   "max v_level reached, retrying at a lower rate or lane count\n");
 			return -EAGAIN;
 		}
=20
@@ -1681,14 +1682,16 @@ static int msm_dp_ctrl_link_train_1_2(struct msm_=
dp_ctrl_private *ctrl,
=20
 	ret =3D msm_dp_ctrl_link_train_1(ctrl, panel, training_step, dp_phy);
 	if (ret) {
-		DRM_ERROR("link training #1 on phy %d failed. ret=3D%d\n", dp_phy, ret=
);
+		drm_dbg_dp(ctrl->drm_dev,
+			   "link training #1 on phy %d failed. ret=3D%d\n", dp_phy, ret);
 		return ret;
 	}
 	drm_dbg_dp(ctrl->drm_dev, "link training #1 on phy %d successful\n", dp=
_phy);
=20
 	ret =3D msm_dp_ctrl_link_train_2(ctrl, panel, training_step, dp_phy);
 	if (ret) {
-		DRM_ERROR("link training #2 on phy %d failed. ret=3D%d\n", dp_phy, ret=
);
+		drm_dbg_dp(ctrl->drm_dev,
+			   "link training #2 on phy %d failed. ret=3D%d\n", dp_phy, ret);
 		return ret;
 	}
 	drm_dbg_dp(ctrl->drm_dev, "link training #2 on phy %d successful\n", dp=
_phy);
@@ -1739,13 +1742,15 @@ static int msm_dp_ctrl_link_train(struct msm_dp_c=
trl_private *ctrl,
 	}
=20
 	if (ret) {
-		DRM_ERROR("link training of LTTPR(s) failed. ret=3D%d\n", ret);
+		drm_dbg_dp(ctrl->drm_dev,
+			   "link training of LTTPR(s) failed. ret=3D%d\n", ret);
 		goto end;
 	}
=20
 	ret =3D msm_dp_ctrl_link_train_1_2(ctrl, panel, training_step, DP_PHY_D=
PRX);
 	if (ret) {
-		DRM_ERROR("link training on sink failed. ret=3D%d\n", ret);
+		drm_dbg_dp(ctrl->drm_dev,
+			   "link training on sink failed. ret=3D%d\n", ret);
 		goto end;
 	}
=20
--=20
2.55.0

