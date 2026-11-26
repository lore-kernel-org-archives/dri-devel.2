Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B411606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJjoiENa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBF11123F1;
	Thu, 26 Nov 2026 13:40:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964361122B0;
 Thu, 26 Nov 2026 13:40:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F14B4238B;
 Thu, 26 Nov 2026 13:40:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795700445;
 b=poMb1yHev/0Nc6orFimpExlK6f4aNpz9zbPWGguZfEEdA5QgxBRznYwKkgpv87uD8bI1
 wUsT4DoWcCWn4iqWuINEYOBTRODz29jB1fsqFNGjbFHghYUsyMMZ11V0h+Qero82GvVnw
 x27kFfJdmpmEccQue+KTMxv65nVx5nwe0D1y7znH1/sKBVGDelc05QJPEtLPEbvrV8LEO
 R35+YhxXipd9U0c9ejmY2lCqwPhMgF0O265/SFzODZ5vt+syP4DAEHwrjCIHR7K/zSu2j
 VZCVDHrvFcGEigqmG/K7C0i1lGO6bqQ2K7ifk6jLk0ATEGBLNdcB4f0SisSrWfKj0bg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795700445;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=OEaCfs7whJ/kv2kXbGbo7ngeXWLk7In6aesuC/e3XvU=;
 b=SkriUcpSwRR0rRwiNgj6hejYzC18fwB8O3jQM7BR/h2WzV7/k2AgaWqY47EZq/UVI0KF
 XgtaGnnT+NJR4l4BLTzhLqmtX+QBcAHKZEtTbC/BqI2E98DzbG2OMqxh7FlT1bBeeIsBM
 0Otw+7M2MM4cy/6POjWQ780p+YEsi7fEd9FN4nn17ExwQTJ+PF3Yg8ynijFzl4Ugpy1Uk
 FIPbLtBzds6nP1q7ttXabLpHzO/4u+OxZoQpklwem54BIe5QuNG71j+ObByTGiwDdobik
 QLL9s3n/3AoIdRv+E1KAwc9bVBAIqisENBgl/PLq+7O6TIcFcvRQDTuVRqxCjZ5i22g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 33F8A1F000C6;
 Thu, 26 Nov 2026 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700445;
 bh=OEaCfs7whJ/kv2kXbGbo7ngeXWLk7In6aesuC/e3XvU=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=aJjoiENaOqqlmr/cVPBa+4oGQA1OZB9ay+E10155IfzfOVfcqNS+hfYyO3hxdGwdR
 /FkXku9+y3F4qurZEkxyu90C0yfx7CHVKA6UWgUkGL6+7oZ88K2Rl27znJi3q7RL/8
 WMyqRks2OZ5ZpkVyI1urnjENHjFl+zLMK927BdRTxHz2ae8qFO548LSOFpp7HDGTFP
 S7hPVsV9QvFLpUS45zQGf8cRx+P2hsahPkwGCHHBOwQ0maTSx2u1eVjzy8NRlZImh+
 9JUP14luYyiiT42l5WVBWh/iqoPppzIsuvXfnRtDz/QHpYc83fF+jVS9nPSCA/XHqg
 X0QMNwuLElUnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BD68C4D51A;
 Thu, 26 Nov 2026 13:40:41 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:40:40 +0100
Subject: [PATCH v2] drm/msm/dp: clear AUX_TRANS_CTRL on reset and keep
 HPD_REFTIMER active
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-drm-msm-dp-aux-resume-v2-1-120ccb6e0578@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RjaCFhX3MOwaOkANRZIBwiGc
 HcLHsD81Uv+/28DpuCI4ZFsEGhx7IY+grwkUHe6bwmdjQwylbkQMkMbPHr2aEfU84qBePaE6q4
 aI40qbJ5B3I6BGreev8/qxzybF9XTcXY0OsfTED6neBFH759jERhTNJm+pUbpXJSt1+59rQcP1
 b7vX21rY1TMAAAA
X-Change-ID: 20261125-drm-msm-dp-aux-resume-989fb2b97d65
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795700441; l=5787;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=s04v/WtSg0tv9DLmYm8Y+6H4r+tdC+2uw407I62fgaE=;
 b=IMT91Cheu9fHm1pgb9cPPpSaIlpsgmg4JNnw+EcW80eAr9j9z3tz5toURXd6ZZ6IOhOHZWnZv
 CUODVQxvgEXBGQ5tNnnYK43Fnsp3olg+vXWQpeOT2hvTB0GseOOz9Ac
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: robertijtsma@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Ijtsma <robertijtsma@gmail.com>

On boards using an external HPD bridge (such as Microsoft Surface Pro X /
SC8180X), internal HPD_CTRL is never enabled via msm_dp_aux_hpd_enable().
Across runtime PM or s2idle suspend/resume power collapse, three AUX
controller details prevent clean timeout recovery and link re-training:

1. msm_dp_aux_reset() does not clear REG_DP_AUX_TRANS_CTRL before
   pulsing DP_AUX_CTRL_RESET, and msm_dp_aux_transfer() skips
   msm_dp_aux_reset() both when internal HPD is disabled
   (msm_dp_aux_is_link_connected() reads 0) and on hardware
   DP_AUX_ERR_TOUT completions.
2. msm_dp_aux_enable() relies on msm_dp_aux_hpd_enable() to set
   DP_DP_HPD_REFTIMER_ENABLE, leaving the 1us timeout reference timer
   off when internal HPD is unused.
3. During suspend, msm_dp_aux_hpd_disable() unconditionally clears
   DP_DP_HPD_REFTIMER_ENABLE before active displays finish AUX power-down
   transactions (such as msm_dp_link_psm_config()).

Clear REG_DP_AUX_TRANS_CTRL in msm_dp_aux_reset(), allow AUX reset on
timeout when internal HPD is disabled or the link is connected, enable
DP_DP_HPD_REFTIMER_ENABLE in msm_dp_aux_enable(), and keep the reference
timer running until both DP_AUX_CTRL_ENABLE and DP_DP_HPD_CTRL_HPD_EN
are cleared.

Tested on Microsoft Surface Pro X SQ2 (SC8180X) across s2idle suspend
and resume.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Changes in v2:
- Allow msm_dp_aux_reset() in msm_dp_aux_transfer() when internal HPD is
  not enabled (external HPD / eDP) and also reset AUX on hardware
  DP_AUX_ERR_TOUT timeouts so stale REG_DP_AUX_TRANS_CTRL state is
  cleared on both timeout paths.
- Keep DP_DP_HPD_REFTIMER_ENABLE enabled across msm_dp_aux_hpd_disable()
  while DP_AUX_CTRL_ENABLE is still active, and clear it in
  msm_dp_aux_disable() once both AUX and HPD are disabled.
- Link to v1: https://patch.msgid.link/20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com
---
 drivers/gpu/drm/msm/dp/dp_aux.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index b52393d..fb35cc7 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -72,10 +72,20 @@ static void msm_dp_aux_clear_hw_interrupts(struct msm_dp_aux_private *aux)
 /*
  * NOTE: resetting AUX controller will also clear any pending HPD related interrupts
  */
+static bool msm_dp_aux_can_reset(struct msm_dp_aux_private *aux)
+{
+	if (!(msm_dp_read_aux(aux, REG_DP_DP_HPD_CTRL) & DP_DP_HPD_CTRL_HPD_EN))
+		return true;
+
+	return msm_dp_aux_is_link_connected(&aux->msm_dp_aux);
+}
+
 static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 {
 	u32 aux_ctrl;
 
+	msm_dp_write_aux(aux, REG_DP_AUX_TRANS_CTRL, 0);
+
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 
 	aux_ctrl |= DP_AUX_CTRL_RESET;
@@ -88,7 +98,12 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 
 static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 {
-	u32 aux_ctrl;
+	u32 aux_ctrl, reftimer;
+
+	/* Keep the 1us AUX/HPD reference timer running without internal HPD */
+	reftimer = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
+	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
 
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 
@@ -101,11 +116,17 @@ static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 
 static void msm_dp_aux_disable(struct msm_dp_aux_private *aux)
 {
-	u32 aux_ctrl;
+	u32 aux_ctrl, reftimer;
 
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 	aux_ctrl &= ~DP_AUX_CTRL_ENABLE;
 	msm_dp_write_aux(aux, REG_DP_AUX_CTRL, aux_ctrl);
+
+	if (!(msm_dp_read_aux(aux, REG_DP_DP_HPD_CTRL) & DP_DP_HPD_CTRL_HPD_EN)) {
+		reftimer = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+		reftimer &= ~DP_DP_HPD_REFTIMER_ENABLE;
+		msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
+	}
 }
 
 static int msm_dp_aux_wait_for_hpd_connect_state(struct msm_dp_aux_private *aux,
@@ -411,8 +432,8 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 			if (!(aux->retry_cnt % MAX_AUX_RETRIES))
 				phy_calibrate(aux->phy);
 		}
-		/* reset aux if link is in connected state */
-		if (msm_dp_aux_is_link_connected(msm_dp_aux))
+		/* reset aux if internal HPD is unused or link is connected */
+		if (msm_dp_aux_can_reset(aux))
 			msm_dp_aux_reset(aux);
 	} else {
 		aux->retry_cnt = 0;
@@ -432,6 +453,8 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 			msg->reply = aux->native ? DP_AUX_NATIVE_REPLY_NACK : DP_AUX_I2C_REPLY_NACK;
 			break;
 		case DP_AUX_ERR_TOUT:
+			if (msm_dp_aux_can_reset(aux))
+				msm_dp_aux_reset(aux);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -614,11 +637,13 @@ void msm_dp_aux_hpd_disable(struct drm_dp_aux *msm_dp_aux)
 		container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux);
 	u32 reg;
 
-	reg = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
-	reg &= ~DP_DP_HPD_REFTIMER_ENABLE;
-	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reg);
-
 	msm_dp_write_aux(aux, REG_DP_DP_HPD_CTRL, 0);
+
+	if (!(msm_dp_read_aux(aux, REG_DP_AUX_CTRL) & DP_AUX_CTRL_ENABLE)) {
+		reg = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+		reg &= ~DP_DP_HPD_REFTIMER_ENABLE;
+		msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reg);
+	}
 }
 
 void msm_dp_aux_hpd_intr_enable(struct drm_dp_aux *msm_dp_aux)

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261125-drm-msm-dp-aux-resume-989fb2b97d65

Best regards,
--  
Robert Ijtsma <robertijtsma@gmail.com>


