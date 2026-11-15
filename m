Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E1606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtKzJnvb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A53210EB70;
	Mon, 16 Nov 2026 08:58:47 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E71910E895
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:00:24 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-91f0b9f0b1cso32514056d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794700823; x=1795305623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=47yra+ALozbc0fVpexoyxbUMKoA6BWbtB+u45dbkO3Y=;
 b=rtKzJnvbNYWrSiFV1zeDJwl3Cpw1Q22ZWLsJkmVtP2vYE93BZcrguM1w0YPubN6Aos
 6dWAz+MlBmmW05iy/zm6sMwlmnFfM8f44rog8m3uqgaKwv8t557Z+ZBhLVs9lCXn2JBA
 XSFbj3aOcirky51X6XE+5kdBzLR1IQXsDBxBE4UvhigCavlwp0f5ycvUyZNNp2XrinNK
 eCkTAApBpey2nuvZstKz0lqOqsgPqXtY+HZxYp3Wc/x6sXhcUpm7tOIKMREaxHEDmAUh
 K0SuJ5hxW8uV0zOE429vRwcdWa9p2PBCUbWVx2ttLEmshrgoQOIu4fl1NZoOwe3tj3qw
 Jw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794700823; x=1795305623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=47yra+ALozbc0fVpexoyxbUMKoA6BWbtB+u45dbkO3Y=;
 b=H8kStrjzOCnvxmZ5sDpaf2MDBUiY5ldx51WOWhi9/ZUC0vZR6SehvJPUb2V3WoYq8k
 7eKBFEWQx7qDMVZJd2EfyOdbg2SZjugEuuuLqkogKUlq0hfHkrtwGGaiqgHEMA0gGjyC
 OaQBqt/un8aFgt/G5xP3IIu8e/fqJMVlcTrK6ZTi6RQPMd1/aydRFIrI65+vpqEDIOOY
 KG7wBDhJVH5kpZyP1qKVYmRkk8nLgoqq9MZM1jKshPYe0iie/LAgbygooa5Bi7SlrZHp
 UPCdVInFtHaYfRVZmUvHte02xAzQtZycDrSpcJUP1xCt6Ba/KLTHTZyk/tDXK/sBWwT2
 GSHw==
X-Forwarded-Encrypted: i=1;
 AL+hErHpgbHf1YyOwKZWAHzL6S8bpW4hKelLbDN1/TZzSQ194hF6CZhX1eBxav3WG14JOWNrZ7LAe/YkptA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PQcRIAnJ5B4iXwR2CDeG7+jJOYrr6zXqIbQ/vc/iIIB5TDcF/
 MfRvZawk2q1NhWqWZafwbFwgz/1kAWNg+0Q+d3Snicc2w8hn3FWm8+J2
X-Gm-Gg: AYBFou1D1g+TY3+AiBl97iqKFJZxpH5jTm/l2dn17zlACFD9dMhYz79MwBFS8VwZ4Ba
 6w3ti8haa7hngJWPWLSxiHyX4SZh99t1Mh1fY/N7Vm/L4nLL3fuHoNvhL6Ll57skkeCstgpgjkw
 oC4x+fprE3t4LQkE1TUWIvxn3MHGlf9XJU+Cqwyq+y4SaJIsNl75q5fkBhrWCERkkZL+iJnHUS/
 rrOkbmQjcejO7uqZuanoA232fLfBCBd3+SXag3Zgm9qGQINZzBuhk7eA9cEGrbVGmqLijsNlG6V
 3bYEoW77VSnTuZTa+TZua/jd9w9VsoIgKpwhHktZtstcYlRrYZImW0iU5tGsjKChy9ZWR0GZO8x
 fm/Oy395oirNxDixYt9xtWvQmH7oMSzN7x7VcFibP+Zn4UQSHHzGSWHBqWNtOKlA7sWY48Ew2Kq
 0nPR+mtyebh6N57JNwfVltP0Fu7z68dnIq3FE2vX4+KnLk/K6BLYQ9aR0uz9YPccbP9qwiE6oQ/
 vtqGvys3jO9XC/cwPZjghZC/X8QC2Dp3s9UzbwaooSEh9VRErWydQG13IYbdnLSmNpxUzw6QtjK
 JK1/XpnGkZqp5oUFA//rG3ygxday0VVeyS3zmKgMAO2tkWkBF3eWjAVEi7a9oPOVaGZnrdsJQml
 IoX0rzu+fmG4k2IHfIgEgn1l6nEAvgZtl3LYE1bhWMtCn34UkfJ9N/ZLnDxwqdoAEBMTiuOCG56
 fr9sTnJZ64tsyjUnCVnReuck7ELFcd50jiLYFjZUe03ek3gSY3aSKkURSqaqeHCqPAYL49C0j1T
 gpvbavIJD58gCW2roIpE8eD7diVk5XagJxtkBtyTMoZ2w==
X-Received: by 2002:a05:6214:5284:b0:91e:a38a:74e with SMTP id
 6a1803df08f44-91f241cd1f4mr112380336d6.28.1794700822815; 
 Sat, 14 Nov 2026 16:00:22 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net
 ([2600:4041:5024:4b00:2cba:4fbd:5596:d1cd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d70489sm52516536d6.21.2026.11.14.16.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 14 Nov 2026 16:00:22 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: don't fall back to a link that can't carry the
 eDP mode
Date: Sat, 14 Nov 2026 19:00:21 -0500
Message-ID: <20261115000021.78869-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When channel equalisation fails after clock recovery succeeded,
msm_dp_ctrl_on_link() halves the lane count and trains again. Nothing
checks that the reduced link can still carry the current mode.

On the ASUS Zenbook A16, channel equalisation at 4 lanes x HBR2 fails
on some DPMS wakes. The 2-lane retry trains but can't carry the mode
(17.03 Gbps needed, 8.64 Gbps available), so the panel stays dark
while userspace sees the output as on.

For eDP, check the reduced link against the mode with the same
bandwidth check as msm_dp_display_mode_valid(), and retry at the
previous parameters when it falls short. External DisplayPort keeps
the existing fallback.

Tested with 100 DPMS off/on cycles before and after: channel
equalisation failed on 6-7% of wakes either way. Without this patch
each failure left the panel dark; with it, each one recovered on the
first retry at 4 lanes.

Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index abd3dcd..261645c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1587,6 +1587,16 @@ static int msm_dp_ctrl_link_rate_down_shift(struct msm_dp_ctrl_private *ctrl)
 	return ret;
 }
 
+static bool msm_dp_ctrl_link_fits_mode(struct msm_dp_ctrl_private *ctrl,
+				       struct msm_dp_panel *panel,
+				       unsigned long pixel_rate)
+{
+	const struct msm_dp_link_info *params = &ctrl->link->link_params;
+
+	return (u64)pixel_rate * panel->msm_dp_mode.bpp <=
+	       (u64)params->num_lanes * params->rate * 8;
+}
+
 static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl,
 					    struct msm_dp_panel *panel)
 {
@@ -2383,6 +2393,9 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	struct msm_dp_ctrl_private *ctrl;
 	u32 rate;
 	int link_train_max_retries = 5;
+	bool is_edp = panel->connector &&
+		      panel->connector->connector_type == DRM_MODE_CONNECTOR_eDP;
+	struct msm_dp_link_info prev_params;
 	u32 const phy_cts_pixel_clk_khz = 148500;
 	u8 link_status[DP_LINK_STATUS_SIZE];
 	unsigned int training_step;
@@ -2420,6 +2433,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 		return rc;
 
 	while (--link_train_max_retries) {
+		prev_params = ctrl->link->link_params;
 		training_step = DP_TRAINING_NONE;
 		rc = msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
 		if (rc == 0) {
@@ -2472,6 +2486,18 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 		}
 
+		/*
+		 * An eDP panel has one fixed mode. A lower rate or lane count that
+		 * cannot carry it trains, but leaves the panel dark: retry at the
+		 * previous parameters instead.
+		 */
+		if (is_edp && !msm_dp_ctrl_link_fits_mode(ctrl, panel, pixel_rate)) {
+			ctrl->link->link_params = prev_params;
+			drm_dbg_dp(ctrl->drm_dev,
+				   "eDP mode needs rate=%d lanes=%d, retrying\n",
+				   prev_params.rate, prev_params.num_lanes);
+		}
+
 		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl, panel);
 		if (rc) {
 			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
-- 
2.56.0

