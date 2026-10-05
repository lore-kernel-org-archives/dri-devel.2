Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FECCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BEF10F20D;
	Tue,  6 Oct 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=laposte.net header.i=@laposte.net header.b="a6MViysZ";
	dkim-atps=neutral
Received: from smtp-outgoing-1701.laposte.net (smtp-outgoing-1701.laposte.net
 [160.92.124.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675BB10EE17
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:56:34 +0000 (UTC)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz3sS6DMDzqSH4","contextId":
 "90f4a32b-cbfe-4189-b0a1-58d616b54880"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
 by mlpnf0108.laposte.net (SMTP Server) with ESMTP id 4hz3sS6DMDzqSH4;
 Mon,  5 Oct 2026 17:56:28 +0200 (CEST)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz3sR2SsQzqSGl","contextId":
 "8a3d06ee-337c-4c05-85ec-a235c964273a"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
Received: from PAR-95296130.bcg.com (unknown [147.161.232.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mlpnf0108.laposte.net (SMTP Server) with ESMTPSA id 4hz3sR2SsQzqSGl;
 Mon,  5 Oct 2026 17:56:27 +0200 (CEST)
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
Subject: [PATCH v2 3/3] drm/msm/dp: validate modes against the trained link,
 not the sink's claim
Date: Mon,  5 Oct 2026 17:56:15 +0200
Message-ID: <20261005155615.32923-1-jean-francois.bobier@laposte.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005131432.22840-4-jean-francois.bobier@laposte.net>
References: <20261005131432.22840-4-jean-francois.bobier@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laposte.net; s=lpn-wlmd;
 t=1791215792; bh=gDxUmxHoNp7TvHschBrvNpRlgNaZU4P148EUX7aMDIk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 b=a6MViysZIaHv2M4v95j9dsNojE552L2plJltw9BoqG3yHIq0ZRSzUF+GTbOqBYfqunXUqmLr2t7JLhakpkRmbTdJ/97uh7G/6CgS7FWwSVRK/c20bpyXrMfCFIqKDufFAGcU8QI4yYML/eIWOhQ/MybwOErk9xPIbUWOCO/mZZ/ae5dlu1KMtI6gV6UHliGRluyEoaLzZQrTq6zO2YnBsEXwlawaFqo3ZBXt5y641KXhHmyvGXolXOrfIQNrr3XwUsh/rInEw66Yw8MZAMcD+W2b4kQlMQohUu/RSZhOBy7H3CTR0xf+U7+0iGcsP7fnwvYERGPUXtMCBNT8BLC2Uw==;
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

msm_dp_display_mode_valid() sizes every mode against
panel->link_info, which is what the sink advertises in DPCD. That is not
necessarily what the link carries. msm_dp_ctrl_on_link() walks the rate
down HBR3 -> HBR2 -> HBR -> RBR and then reduces the lane count until
training succeeds, so a cable with two unusable lanes trains at half the
bandwidth the sink claims.

The validator does not know that, so it keeps advertising modes sized for
the sink's maximum. Userspace picks one, training "succeeds" at the
reduced parameters, the mode does not fit in them, and the sink shows a
black screen -- with nothing in the log to explain it, because from the
driver's point of view everything worked.

Observed on an sm8250 phone with a 4K monitor whose cable only carries
two lanes: the connector offers 3840x2160, the link trains at 2 lanes
HBR2 (8.6 Gbps after 8b/10b against the 12.5 Gbps the mode needs at 24
bpp, more at 30), and the screen stays black until the user picks
2560x1440 by hand.

link->link_params holds the trained values, but is only meaningful for
the sink that produced them. msm_dp_hpd_unplug_handle() now clears it on
disconnect, and msm_dp_ctrl_on_link() resets it to the new sink's own
maximum before training, so taking the lower of link_params and
link_info is accurate once a sink has been trained and a safe no-op
before that -- never the previous sink's leftover values.

This does not by itself make userspace re-probe after a fallback -- that
needs the link-status property, which cannot be set from
msm_dp_bridge_atomic_enable() because the modeset locks are held, and is
the deferred work the existing TODO there refers to. What it does ensure
is that any probe after a fallback offers only modes the link can
actually drive.

Also log the rejection at debug level; a mode silently disappearing from
the list is otherwise hard to account for.

Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
---
Changes in v2:
- Clear link_params on disconnect in msm_dp_hpd_unplug_handle(), and
  updated the comment in mode_valid() to say so. v1 reset link_params to
  the sink's maximum at the start of training, but never on disconnect,
  so mode_valid() for a freshly plugged sink -- which runs during EDID
  read, before that sink's own link has ever been trained -- could size
  its modes against whatever the *previous* sink's link had trained
  down to. The num_lanes/rate =3D=3D 0 guard already in v1's mode_valid()
  now does what it was presumably meant to do from the start: treat
  "not yet trained for this sink" as "don't restrict," rather than
  "not yet trained since driver load."
- Caught by this list's automated review on v1, not by hand -- credit
  where it's due.

 drivers/gpu/drm/msm/dp/dp_display.c | 53 +++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
index bce641d7d..d0613ef98 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -460,6 +460,19 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_di=
splay_private *dp)
=20
 	dp->panel->video_test =3D false;
=20
+	/*
+	 * Clear the trained link parameters along with everything else this
+	 * function already resets on disconnect. msm_dp_ctrl_on_link() does
+	 * not run again until a mode is actually committed for the next
+	 * sink, but msm_dp_display_mode_valid() reads link_params to size
+	 * the mode list as soon as the next sink's EDID is read -- well
+	 * before that training happens. Leaving the previous sink's trained
+	 * values in place would size the new sink's modes against a link it
+	 * has never been on.
+	 */
+	dp->link->link_params.num_lanes =3D 0;
+	dp->link->link_params.rate =3D 0;
+
 	msm_dp_aux_enable_xfers(dp->aux, false);
=20
 	drm_dbg_dp(dp->drm_dev, "Before, type=3D%d sink_count=3D%d\n",
@@ -750,8 +763,10 @@ enum drm_mode_status msm_dp_display_mode_valid(struc=
t msm_dp *dp,
 {
 	const u32 num_components =3D 3, default_bpp =3D 24;
 	struct msm_dp_display_private *msm_dp_display;
+	const struct msm_dp_link_info *trained;
 	struct msm_dp_link_info *link_info;
 	u32 mode_rate_khz =3D 0, supported_rate_khz =3D 0, mode_bpp =3D 0;
+	unsigned int num_lanes, rate;
 	int mode_pclk_khz =3D mode->clock;
 	int link_pclk_khz;
 	bool is_yuv_420;
@@ -789,10 +804,44 @@ enum drm_mode_status msm_dp_display_mode_valid(stru=
ct msm_dp *dp,
 			mode_bpp, link_pclk_khz);
=20
 	mode_rate_khz =3D link_pclk_khz * mode_bpp;
-	supported_rate_khz =3D link_info->num_lanes * link_info->rate * 8;
=20
-	if (mode_rate_khz > supported_rate_khz)
+	/*
+	 * link_info is what the sink advertises in DPCD, which is not
+	 * necessarily what we managed to train. msm_dp_ctrl_on_link() walks
+	 * the rate down HBR3 -> HBR2 -> HBR -> RBR and then halves the lane
+	 * count until training succeeds, so a cable with two unusable lanes
+	 * ends up carrying half the bandwidth the sink claims.
+	 *
+	 * Sizing modes against the sink's maximum then advertises modes the
+	 * link cannot carry: training "succeeds" at the reduced parameters,
+	 * the mode does not fit in them, and the sink shows a black screen
+	 * with nothing in the log to say why.
+	 *
+	 * link->link_params holds the trained values. It is reset to the
+	 * sink's maximum at the top of every msm_dp_ctrl_on_link(), and
+	 * cleared to zero by msm_dp_hpd_unplug_handle() on disconnect, so
+	 * taking the lower of the two is accurate once this sink has been
+	 * trained, a safe no-op before that, and never a leftover from
+	 * whatever sink was attached previously.
+	 */
+	num_lanes =3D link_info->num_lanes;
+	rate =3D link_info->rate;
+
+	trained =3D &msm_dp_display->link->link_params;
+	if (trained->num_lanes && trained->num_lanes < num_lanes)
+		num_lanes =3D trained->num_lanes;
+	if (trained->rate && trained->rate < rate)
+		rate =3D trained->rate;
+
+	supported_rate_khz =3D num_lanes * rate * 8;
+
+	if (mode_rate_khz > supported_rate_khz) {
+		drm_dbg_dp(dp->drm_dev,
+			   "mode %s rejected: needs %u kHz, link carries %u kHz (%u lanes @ %=
u)\n",
+			   mode->name, mode_rate_khz, supported_rate_khz,
+			   num_lanes, rate);
 		return MODE_BAD;
+	}
=20
 	return MODE_OK;
 }
--=20
2.56.0

