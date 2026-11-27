Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C79606B199
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YacuCz0C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E7D112AF7;
	Fri, 27 Nov 2026 14:27:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF34112AF7;
 Fri, 27 Nov 2026 14:27:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E069444DEC;
 Fri, 27 Nov 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795789638;
 b=UVCLGf1sCmVT5bRVJ3uhD2JpCAn+XR2Bt5QuhUFzT8jzKdurui6dZkDqEAzQTbLB6yW1
 ZyvSN4Wcz3F2sYOtu0itE/BMY/UFf3uvU0aerlGJ0L61BKsF7HszVlS7adtXUvoMAwhFu
 qFBRby1N5IVA0Q8IkWrd7FMVO07HRtrslXdeuvj+znnrMSaM4RN1hU9WA6ofd1BQiC/LV
 C35++lRvSBbgeuUOVR6K+lB9AgjMDbqxs2wVeCYOQA+M/tHHRLpoV9rR0mmidXdW0oHsU
 P20iQRgmln9X4/yH/7BBZsoDyZYyx9FsuiTuEZz6lFxkcRI1PE0l8jEPwSePkM/Drkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795789638;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=8T2WrUhD5VMaLDjgW6RdRPsPFa7clOAjaLGtAnotNlw=;
 b=aIvvxEJEhWouNdyNlUVPU8Eg8zGnlq/RV2XKsRlVaV5cvcS1jBCRYa7wHALFDbncAb3q
 Bee/+BZ1gFQH1EF1K2LiuZxHwwlHHMrvLAlPHu+/45NsTubLEL8eBp7qiJVDllSBTojCa
 F9xnPV4rS12er+js9IOjRH+UfYBFxuT03xHFWUoiT7Glq2rxEk8VpG6sRb3kJN/Oop0o5
 VRQ01DmQ/V3674lZIeP00yq+hKkbSFX+eosoGXMh1m97sznly3y0XJPaVk3qUTEMLoO20
 dHFBCB16MD/BhMLCwXLpAu2jSZ22MLHRSya5lTNvnEjsyJL/cO/F1r7rnmp3zYl2TjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 550FF1F0089F;
 Fri, 27 Nov 2026 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789638;
 bh=8T2WrUhD5VMaLDjgW6RdRPsPFa7clOAjaLGtAnotNlw=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=YacuCz0CoBToebx+Y05qKUYKO4znll6REOsi8cn66Hw8WE8WKnhtAqydGCbcjZzy9
 92Z1K6ruEkZISyjGcYUpnDSpVih+pYhKnj5iku7GMZv9JyZ7fdSv7odYOYCEhgvlFg
 nrbmXC8oKPDIZDrMDb9CJMNJTfNnm4r29r8UWRCVlT3dqJtW3DRmAgKR7grEbxg+4Y
 ypZI8SdY5VGi0GaaQidTf53RPOm4SfeCh3DWkJdTElZ6sBDtReGfu/xjilTOp0LqH1
 HtwbjGF+N0FMsXXnBV5javKmj5eYaVxb1rD9UUnryg8pOLqPE15/xBjRc0kTddDsbr
 zjVRwXivL5JwQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CA9A74B83A;
 Fri, 27 Nov 2026 14:27:05 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 15:27:06 +0100
Subject: [PATCH v3] drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable
 HPD_REFTIMER
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-drm-msm-dp-aux-resume-v3-1-2db151decaab@gmail.com>
X-B4-Tracking: v=1; b=H4sIADmTCWsC/4XNwQ6DIAyA4VcxnNcFqsLYae+x7ACCSjKmgUlcj
 O8+9ORlWXr6m/TrQqINzkZyLRYSbHLRDa8c5akgTa9enQVnchOkyBnDGkzw4KMHM4KaZgg2Tt6
 CvMhWo5bC8Jrk2zHY1s27e3/k7l18D+Gzv0ls2/4TE4M8oq1VRbVUnN06r9zz3AyebGLCo8J/K
 ZiVssSqQqq5EPSorOv6BYK0QgwAAQAA
X-Change-ID: 20261125-drm-msm-dp-aux-resume-989fb2b97d65
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stephen Boyd <swboyd@chromium.org>, Vara Reddy <quic_varar@quicinc.com>, 
 Guenter Roeck <groeck@chromium.org>, Tanmay Shah <tanmay@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789625; l=5862;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=sRsGGoT4oc+ruJceG2OpF//eZLcBXDogIygLd/WOPls=;
 b=QSL/XC4Fic9RnpIvrlxQ1tx4uuaRTwphqscP7yWjbJhesa0eBK73i6suw88rAqY3Kfqo3yPtS
 ydZgXAMInXIC8/gbHPCLKOEbOo23KXN10e57aEe4DzqbdlOVIUdt72b
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
Across runtime PM or s2idle suspend/resume power collapse, several AUX
controller issues prevent reliable link re-training:

1. msm_dp_aux_reset() does not clear REG_DP_AUX_TRANS_CTRL before
   pulsing DP_AUX_CTRL_RESET, which can leave a stale transaction bit
   latched across reset.
2. msm_dp_aux_enable() relies on msm_dp_aux_hpd_enable() to set
   DP_DP_HPD_REFTIMER_ENABLE; when internal HPD is unused, AUX timeouts
   can stall after power collapse because the 1us reference timer is off.
   Move DP_DP_HPD_REFTIMER_ENABLE teardown symmetrically from
   msm_dp_aux_hpd_disable() to msm_dp_aux_disable() so disabling HPD
   polling during suspend does not stop the timer while AUX is active.
3. msm_dp_aux_transfer() gates msm_dp_aux_reset() on
   msm_dp_aux_is_link_connected(), which reads internal HPD status and
   always returns 0 when internal HPD_CTRL is disabled, and also skips
   resetting AUX on hardware DP_AUX_ERR_TOUT timeouts.

Clear REG_DP_AUX_TRANS_CTRL in msm_dp_aux_reset(), manage
DP_DP_HPD_REFTIMER_ENABLE across msm_dp_aux_enable()/disable(), and
reset AUX on both transfer errors and DP_AUX_ERR_TOUT timeouts when the
link is connected or transfers are enabled with internal HPD disabled.

Tested on Microsoft Surface Pro X SQ2 (SC8180X) across s2idle suspend
and resume.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Ensure AUX reset clears REG_DP_AUX_TRANS_CTRL and msm_dp_aux_enable()
enables the 1us HPD reference timer even when internal HPD is unused.
---
Changes in v3:
- Check aux->is_edp before DP_DP_HPD_CTRL_HPD_EN in msm_dp_aux_should_reset()
  so eDP boards without internal HPD wired still reset AUX on errors.
- Route hardware DP_AUX_ERR_TOUT timeouts through the ret < 0 retry and
  phy_calibrate() path alongside msm_dp_aux_reset().
- Link to v2: https://lore.kernel.org/r/20261126-drm-msm-dp-aux-resume-v2-1-3324420b6770@gmail.com

Changes in v2:
- Move DP_DP_HPD_REFTIMER_ENABLE teardown from msm_dp_aux_hpd_disable() to
  msm_dp_aux_disable() so HPD teardown during suspend does not disable the
  1us timer while AUX transfers are still active.
- Reset the AUX controller on both transfer failures and DP_AUX_ERR_TOUT
  timeouts, falling back to aux->is_edp || aux->enable_xfers when internal
  HPD_CTRL is disabled.
- Link to v1: https://lore.kernel.org/r/20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com
---
 drivers/gpu/drm/msm/dp/dp_aux.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index b52393dcc067049529a51a9885990e5da663d802..2513f788fb0900311869de987cd00ace62a76984 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -76,6 +76,8 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 {
 	u32 aux_ctrl;
 
+	msm_dp_write_aux(aux, REG_DP_AUX_TRANS_CTRL, 0);
+
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 
 	aux_ctrl |= DP_AUX_CTRL_RESET;
@@ -88,7 +90,12 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 
 static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 {
-	u32 aux_ctrl;
+	u32 aux_ctrl, reftimer;
+
+	/* Keep the 1us AUX/HPD reference timer running without internal HPD. */
+	reftimer = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
+	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
 
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 
@@ -101,11 +108,26 @@ static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 
 static void msm_dp_aux_disable(struct msm_dp_aux_private *aux)
 {
-	u32 aux_ctrl;
+	u32 aux_ctrl, reftimer;
 
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 	aux_ctrl &= ~DP_AUX_CTRL_ENABLE;
 	msm_dp_write_aux(aux, REG_DP_AUX_CTRL, aux_ctrl);
+
+	reftimer = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+	reftimer &= ~DP_DP_HPD_REFTIMER_ENABLE;
+	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
+}
+
+static bool msm_dp_aux_should_reset(struct msm_dp_aux_private *aux)
+{
+	if (aux->is_edp)
+		return true;
+
+	if (msm_dp_read_aux(aux, REG_DP_DP_HPD_CTRL) & DP_DP_HPD_CTRL_HPD_EN)
+		return msm_dp_aux_is_link_connected(&aux->msm_dp_aux);
+
+	return aux->enable_xfers;
 }
 
 static int msm_dp_aux_wait_for_hpd_connect_state(struct msm_dp_aux_private *aux,
@@ -405,6 +427,9 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 	}
 
 	ret = msm_dp_aux_cmd_fifo_tx(aux, msg);
+	if (ret >= 0 && aux->aux_error_num == DP_AUX_ERR_TOUT)
+		ret = -ETIMEDOUT;
+
 	if (ret < 0) {
 		if (aux->native) {
 			aux->retry_cnt++;
@@ -412,7 +437,7 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 				phy_calibrate(aux->phy);
 		}
 		/* reset aux if link is in connected state */
-		if (msm_dp_aux_is_link_connected(msm_dp_aux))
+		if (msm_dp_aux_should_reset(aux))
 			msm_dp_aux_reset(aux);
 	} else {
 		aux->retry_cnt = 0;
@@ -612,11 +637,6 @@ void msm_dp_aux_hpd_disable(struct drm_dp_aux *msm_dp_aux)
 {
 	struct msm_dp_aux_private *aux =
 		container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux);
-	u32 reg;
-
-	reg = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
-	reg &= ~DP_DP_HPD_REFTIMER_ENABLE;
-	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reg);
 
 	msm_dp_write_aux(aux, REG_DP_DP_HPD_CTRL, 0);
 }

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-drm-msm-dp-aux-resume-989fb2b97d65

Best regards,
-- 
Robert Ijtsma <robertijtsma@gmail.com>


