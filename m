Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7DCA6004
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F8510E0D8;
	Tue,  6 Oct 2026 07:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=laposte.net header.i=@laposte.net header.b="duGDkalV";
	dkim-atps=neutral
X-Greylist: delayed 7210 seconds by postgrey-1.36 at gabe;
 Mon, 05 Oct 2026 15:14:58 UTC
Received: from smtp-outgoing-1901.laposte.net (smtp-outgoing-1901.laposte.net
 [160.92.124.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FAE10E243
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:14:57 +0000 (UTC)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gs5yTCz10MQR","contextId":
 "27044b9d-1598-4d46-a58a-ba86be668f3a"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
 by mlpnf0120.laposte.net (SMTP Server) with ESMTP id 4hz0Gs5yTCz10MQR;
 Mon,  5 Oct 2026 15:14:45 +0200 (CEST)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gs2Jckz10MQ4","contextId":
 "26652990-d7c9-4d0e-87f3-0447723efaab"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
Received: from PAR-95296130.bcg.com (unknown [147.161.232.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mlpnf0120.laposte.net (SMTP Server) with ESMTPSA id 4hz0Gs2Jckz10MQ4;
 Mon,  5 Oct 2026 15:14:45 +0200 (CEST)
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
Subject: [PATCH 1/3] drm/msm/dp: don't gate link-training fallback on the
 controller's HPD block
Date: Mon,  5 Oct 2026 15:14:30 +0200
Message-ID: <20261005131432.22840-2-jean-francois.bobier@laposte.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
References: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laposte.net; s=lpn-wlmd;
 t=1791213296; bh=hxdoK/QE60X045d9V3Aagp/V0lSogdtRHJj5+cb5NH8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 b=duGDkalVPqcRaZoIUNevzuxViGcw17p15P+R60bZpmRFuxRnSGkbhmo8t0rfaLJcGEtpyB1yuL7K0mlnLqefegnsdSzUZ0je9I7TXuzK5SJUmj3VQXVwDdHX/ia0RirQEwn6WZGKo7hwG8kR8U/J4ClPOqUason82Hm8F8UNoU76h63nCLsyllmaGIIyz/RO3P4tu2ykG+SF72m0mGkTbIm0riIYvojFcrS4Wh+b2ftTcUAq5uu2toKTyBCb1B/KQtbBWXAFNxXyOoEGUEUPscM6Arfb0wpFLuRHfYc9W+J/2YcOeyoTLzeGnkhwYot6lyMvYPqPfhQ7sISWw/e2sw==;
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

msm_dp_ctrl_setup_main_link()'s retry loop is what implements DP link
fallback: on a training failure it shifts the link rate down HBR3 -> HBR2
-> HBR -> RBR and then, if clock recovery succeeded on at least half the
lanes, reduces the lane count. Both failure branches guard that with

	if (!msm_dp_aux_is_link_connected(ctrl->aux))
		break;

which reads REG_DP_DP_HPD_INT_STATUS, i.e. the DP controller's own HPD
block. That is only meaningful when the block is wired to a real HPD
signal.

On a USB-C port it is not. HPD arrives out of band: the Type-C port
driver owns it and hands it over through a drm_dp_hpd_bridge, and the
controller's HPD register reads DISCONNECTED for the entire time a sink
is attached. msm_dp_bridge_hpd_notify() already shows this, logging the
register beside the bridge's own verdict -- on sm8250 (OnePlus 8T) every
attach reports

	msm_dp_bridge_hpd_notify: type=3D10 link hpd_link_status=3D0x0, status=3D=
1

So the guard is always true, the loop always breaks on the first failed
attempt, and the rate/lane fallback is dead on every Type-C DP board.
msm_dp_ctrl_setup_main_link() then returns -ECONNRESET and the mode set
fails outright.

The cost is real. With a 4K sink attached directly (4 DP lanes, no USB3),
a board that can only carry two DP lanes to the connector trains lanes 0
and 1 and never lanes 2 and 3:

	v_level 3: DPCD 0x202 =3D 0x11 (lanes 0,1 CR_DONE)
	           DPCD 0x203 =3D 0x00 (lanes 2,3 nothing)
	link training #1 on phy 0 failed. ret=3D-11
	Failed link training (rc=3D-104)

A fallback to two lanes would have trained -- clock recovery was already
good on exactly the lanes that remain, so
msm_dp_ctrl_clock_recovery_any_ok() would have passed -- but it is never
reached. The same sink works through a dock, because the Type-C alternate
mode negotiates two DP lanes up front and the first attempt succeeds.

Use the DPCD read the loop already performs as the liveness test instead.
It expresses the intent directly -- a sink that has gone away cannot
answer AUX -- and it carries no assumption about where HPD comes from.
drm_dp_dpcd_read_link_status() returns 0 on success and a negative errno
on failure.

Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
index e1614bc49..d6219d87d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2426,12 +2426,22 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_d=
p_ctrl,
 			/* training completed successfully */
 			break;
 		} else if (training_step =3D=3D DP_TRAINING_1) {
-			/* link train_1 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			/*
+			 * link train_1 failed
+			 *
+			 * Use the DPCD read itself to decide whether the sink
+			 * is still there. msm_dp_aux_is_link_connected() reads
+			 * the DP controller's own HPD block, which is only
+			 * meaningful when that block sees a real HPD signal --
+			 * on a Type-C port HPD arrives out of band through a
+			 * drm_dp_hpd_bridge and the register reads
+			 * DISCONNECTED the whole time the sink is attached.
+			 * Gating the retry on it therefore skipped the entire
+			 * rate/lane fallback on those boards.
+			 */
+			if (drm_dp_dpcd_read_link_status(ctrl->aux, link_status) < 0)
 				break;
=20
-			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
-
 			rc =3D msm_dp_ctrl_link_rate_down_shift(ctrl);
 			if (rc < 0) { /* already in RBR =3D 1.6G */
 				if (msm_dp_ctrl_clock_recovery_any_ok(link_status,
@@ -2451,12 +2461,10 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_d=
p_ctrl,
 				}
 			}
 		} else if (training_step =3D=3D DP_TRAINING_2) {
-			/* link train_2 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			/* link train_2 failed; same reasoning as above */
+			if (drm_dp_dpcd_read_link_status(ctrl->aux, link_status) < 0)
 				break;
=20
-			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
-
 			if (!drm_dp_clock_recovery_ok(link_status,
 					ctrl->link->link_params.num_lanes))
 				rc =3D msm_dp_ctrl_link_rate_down_shift(ctrl);
--=20
2.55.0

