Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZCc1+1z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9215E112443;
	Thu, 26 Nov 2026 14:10:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268BB112445;
 Thu, 26 Nov 2026 14:10:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 604F1634CF;
 Thu, 26 Nov 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795702241;
 b=t1wKSk45+JTb9PkxTVdiABYR3ZFW0lmAPqWK/mksQuO1771v2cbzNeruoK3yYh7ldlKq
 IypZgkmcVKSfeMDoGg/o3WmgM73LeG4KDi68Fk4tWKOWV+tHA1tyrO790uEvy5sGCHsca
 a9KpoaTH7BerwwH5fzL873VNjhnWL+ymgcAXA6lbp+ePXYi5/VrFivJCvWy4629uQHVdU
 S5r1YWyGoXVoJGc6jVFdXDpTOhKyXhF+YvjL7QosY4RmaZANdW30/eyto1YcxiI4P1OOM
 xqvOF5amrFbxA/C9XGN2AAi52+PO0Hg5xqlaL+RW6bo9xlN6dqKGLfw+AMRT4af7d/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795702241;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=GoNjo7zO82uiqRrVrk44qVbcqzWxXgz1hi/dTwyiPlQ=;
 b=z0+ZCKlmklsk7AVbvS5wIEsJD/IteDLsUuPaiCMqOcRPby4OMI6hJ0PrcJ3H31OWJDF5
 ZBqOjaFsme02zhnw7fl8bVHY/VJqcH8A91L9w0QJuRUPk2sxkG3/Cw+OZW22gDqr+1WG7
 fh8xLAcKJfCKV6o3wehCDazJEorAN/ZDdujrL9XQJqkdQQ9l0CpPFltbUcymwAI0HVvP9
 tTk0rlRvAo+MKQQGH/pTGwI7vQ+HO+PyP6SMRR4PTYy7kpLAGnw321OcyVE5zyw4Jb+s5
 aMPfE1vhxDI20JPXXxmOMlbX+K0LjwfaN63UF6FDrdc99gczvfOIVf2VbbhQmVzf8RQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 925B11F0093E;
 Thu, 26 Nov 2026 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702241;
 bh=GoNjo7zO82uiqRrVrk44qVbcqzWxXgz1hi/dTwyiPlQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=dZCc1+1zZvYHfPrsF7i3I4nw/24SW63QXB+CcDYyh8MJUhD5UipD0GyDQJjTqIl8+
 MaJ2PF3kJd0EV1a5hhB25Eb/WXuQKXg3+X4+N1YIfq7trV1tH3mT6AoZNpvpnS15oK
 En0Qxx3HLBdNlrh3Fus4tFDXsZqG16Rwwog1YA5RUdcPIFaE0zK/osGKKjbliY55xe
 DJJz3itt2hO6iDelJDTAjdNars9d72IpA3Smvqzgdef/lk9AijhiL5C/6v5YWh3ZIs
 pCypOW1eR9gPP/WaF9z2qN78Xpo9+ZfAOa27eBGjkP54tx96XJH56Pw+aprhndPVcB
 k38LK4MqWRKKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1F7E24D574;
 Thu, 26 Nov 2026 14:10:33 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 15:10:33 +0100
Subject: [PATCH v2] drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable
 HPD_REFTIMER
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-drm-msm-dp-aux-resume-v2-1-3324420b6770@gmail.com>
X-B4-Tracking: v=1; b=H4sIANg9CGsC/4WNQQqDMBBFryKz7hQTqjZdeY/iIjGjDjRGkioWy
 d2beoHyV+/Df/+ASIEpwqM4INDGkf2cQV4K6Cc9j4RsM4MsZS2ErNAGhy46tAvqdcdAcXWE6q4
 GI41qbF1B3i6BBt5P77PLPHF8+/A5bzbxa/8ZN4E5zVDpW2mUrkU7Os2va+8ddCmlLy5yJV66A
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702232; l=5469;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=FMHRN2THdYibRltBgWO2LocqJwiTUr1V3I3IRhiEwlI=;
 b=7uXo/zsG6hR1nZagn0DSI8nS8NjF86wX/2doKC1ltKymWYkE3KUF2NhkpBj6TwcNsUiJYOoep
 JsjfT80SSRjDiXJIfRrznHDUXDhGNSJpExLRb8uHnBtCAYMZ/YraayS
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
Changes in v2:
- Move DP_DP_HPD_REFTIMER_ENABLE teardown from msm_dp_aux_hpd_disable() to
  msm_dp_aux_disable() so HPD teardown during suspend does not disable the
  1us timer while AUX transfers are still active.
- Reset the AUX controller on both transfer failures and DP_AUX_ERR_TOUT
  timeouts, falling back to aux->is_edp || aux->enable_xfers when internal
  HPD_CTRL is disabled.
- Link to v1: https://lore.kernel.org/r/20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com
---
 drivers/gpu/drm/msm/dp/dp_aux.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index b52393dcc067049529a51a9885990e5da663d802..9a996fe7dbddb61a76a732430ffeae33f70d33b3 100644
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
 
@@ -101,11 +108,23 @@ static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 
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
+	if (msm_dp_read_aux(aux, REG_DP_DP_HPD_CTRL) & DP_DP_HPD_CTRL_HPD_EN)
+		return msm_dp_aux_is_link_connected(&aux->msm_dp_aux);
+
+	return aux->is_edp || aux->enable_xfers;
 }
 
 static int msm_dp_aux_wait_for_hpd_connect_state(struct msm_dp_aux_private *aux,
@@ -412,7 +431,7 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 				phy_calibrate(aux->phy);
 		}
 		/* reset aux if link is in connected state */
-		if (msm_dp_aux_is_link_connected(msm_dp_aux))
+		if (msm_dp_aux_should_reset(aux))
 			msm_dp_aux_reset(aux);
 	} else {
 		aux->retry_cnt = 0;
@@ -432,6 +451,8 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 			msg->reply = aux->native ? DP_AUX_NATIVE_REPLY_NACK : DP_AUX_I2C_REPLY_NACK;
 			break;
 		case DP_AUX_ERR_TOUT:
+			if (msm_dp_aux_should_reset(aux))
+				msm_dp_aux_reset(aux);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -612,11 +633,6 @@ void msm_dp_aux_hpd_disable(struct drm_dp_aux *msm_dp_aux)
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


