Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C573FCA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E0610E288;
	Tue,  6 Oct 2026 07:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=laposte.net header.i=@laposte.net header.b="sax4tHbz";
	dkim-atps=neutral
Received: from smtp-outgoing-2001.laposte.net (smtp-outgoing-2001.laposte.net
 [160.92.124.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C896910E071
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:19:06 +0000 (UTC)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz4M14fDqznTV1","contextId":
 "2fe663a4-245c-43dc-8998-0ecf64d7475b"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
 by mlpnf0113.laposte.net (SMTP Server) with ESMTP id 4hz4M14fDqznTV1;
 Mon,  5 Oct 2026 18:18:37 +0200 (CEST)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz4Lz1wxMznTTg","contextId":
 "e075e3b8-9eb9-402a-8009-8a753cf064c2"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
Received: from PAR-95296130.bcg.com (unknown [147.161.232.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mlpnf0113.laposte.net (SMTP Server) with ESMTPSA id 4hz4Lz1wxMznTTg;
 Mon,  5 Oct 2026 18:18:35 +0200 (CEST)
From: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Saim Shujah <saimzst@gmail.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Subject: [PATCH v2] drm/display: let a bridge configure sink audio from
 hw_params
Date: Mon,  5 Oct 2026 18:18:24 +0200
Message-ID: <20261005161824.36445-1-jean-francois.bobier@laposte.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
References: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laposte.net; s=lpn-wlmd;
 t=1791217144; bh=v6DPDNRrDaVyxb0qN7svQjoUCTm07TUbnxtS/LM6MVg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 b=sax4tHbzSwQK/2XKFQviYJ4ybpXg3FXssmyOpCZDu//LETxhSX0S9N73/8wZ3Rf0t4HqH6mdZREJIwyONfaYL225AfinxPpO6OQAlUcfrVBwbJ4M1/mHSdAOPRLk/kX06E++ywamYcgsmco6L+NEbSZrosZGvOcGWTj7jdoR/+Fw7zaUR/tZFaNSeADj3iVxtnl3qE4j7b6hlZkZjc0DDnKLD/8BhFKCGWd6SK1SEV7IJhiUbMdxEZjh6eSSqRb0TSMYqNGwEACer6z7t+oUp43VUNG8ZGIwEkNo++W0hkrtnpPJ2neFeEMK8BexzI2QUHqxpUIJioGuM3Plowxjgg==;
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

drm_connector_hdmi_audio_ops implements .prepare and not .hw_params, so
every bridge using the HDMI audio helper configures its sink's audio path
from the codec DAI's prepare callback.

That is too late when the CPU side of the DAI link cannot start until the
sink's audio clock is already running. ASoC's snd_soc_pcm_dai_prepare()
walks CPU DAIs before codec DAIs and returns on the first error, so such
a CPU DAI fails and aborts the loop before the bridge's prepare is
reached -- the clock it was waiting for is enabled by a callback that the
failure prevents from running.

Qualcomm's LPASS is one such CPU side. On an sm8250 board with the
DisplayPort controller bound to the DISPLAY_PORT_RX AFE port, starting
playback gives:

  qcom-q6afe: AFE enable for port 0x6020 failed -110
  q6afe-dai: ASoC error (-110): at snd_soc_dai_prepare() on DISPLAY_PORT_=
RX_0

and an ftrace of the attempt shows msm_dp_audio_prepare() is never
called at all -- only msm_dp_audio_shutdown(), from the teardown path.

Add a .hw_params to the helper that runs the same configuration, and a
drm_bridge flag to select it. hw_params runs for every DAI in the link
before any of them is prepared, so the clock is up by the time the CPU
DAI starts its port. Both callbacks receive identical parameters, so the
configuration itself is unchanged.

The flag defaults to off: a bridge that does not set it keeps being
configured from prepare exactly as before. For one that does, prepare
skips calling the sink's configuration again only for the specific call
hw_params already did it for -- tracked per-connector, consumed on use --
because ASoC reaches .prepare with no .hw_params ahead of it on XRUN
recovery and on resume from suspend, and the sink still needs configuring
then. Skipping unconditionally would have left it silently unconfigured
after either.

Note that providing .hw_params at all means hdmi_codec_hw_params() no
longer returns early for these connectors, so it now runs
hdmi_codec_fill_codec_params() and the IEC958 channel status fill before
the (inert, when nothing needs doing) callback. Both are computed into an
on-stack hdmi_codec_params that is then discarded, and the one shared
value written, daifmt->bit_fmt, is set by hdmi_codec_prepare() to the
same value immediately afterwards.

One more side effect worth disclosing: hdmi_codec_fill_codec_params()
also writes hcp->chmap_idx, which is not on-stack -- it persists on the
hdmi-codec device and is reused by the next call to
hdmi_codec_get_ch_alloc_table_idx(). hdmi_codec_prepare() recomputes it
immediately afterwards from the same channel count, so the value itself
does not go stale. But hdmi_codec_hw_params() now reaching this code at
all means that a channel count the sink's ELD does not advertise is
reported from hw_params() instead of prepare(), for every bridge sharing
drm_connector_hdmi_audio_ops, not only the ones that set
hdmi_audio_prepare_early. That changes when a bad channel count is
reported, not whether it is, but it is a change to seven bridges this
patch has no other reason to touch, and worth a maintainer's opinion.

Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
---
Changes in v2:
- v1 skipped prepare() unconditionally whenever prepare_early was set.
  Checked against ALSA core (sound/core/pcm_native.c): .prepare is
  reachable from SNDRV_PCM_STATE_XRUN and SNDRV_PCM_STATE_SUSPENDED with
  no .hw_params call in between -- snd_pcm_pre_prepare() explicitly
  allows both, and neither XRUN recovery nor resume renegotiates hw
  params. v1's unconditional skip meant the sink's audio path was never
  reconfigured after either, which a full suspend in particular needs
  since the DP controller's power domain drops and the configuration
  .prepare would have applied is gone. Fixed by tracking, per connector,
  whether hw_params already did the work for the specific prepare call
  immediately ahead of it, consumed on use -- any prepare that isn't
  immediately preceded by a matching hw_params now runs the real
  configuration, same as every bridge not using this flag at all.
- Caught by this list's automated review on v1, not by hand.

 .../gpu/drm/display/drm_bridge_connector.c    |  3 ++
 .../gpu/drm/display/drm_hdmi_audio_helper.c   | 39 +++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_drm.c               |  8 ++++
 include/drm/drm_bridge.h                      | 17 ++++++++
 include/drm/drm_connector.h                   | 20 ++++++++++
 5 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
index 81f3e26f6..731ba4b2a 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1107,6 +1107,9 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
 						    bridge->hdmi_audio_dai_port);
 		if (ret)
 			return ERR_PTR(ret);
+
+		connector->hdmi_audio.prepare_early =3D
+			bridge->hdmi_audio_prepare_early;
 	}
=20
 	if (bridge_connector->bridge_hdmi_cec &&
diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_audio_helper.c
index 7d78b02c1..d4281cee7 100644
--- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
@@ -34,9 +34,47 @@ static int drm_connector_hdmi_audio_prepare(struct dev=
ice *dev, void *data,
 	const struct drm_connector_hdmi_audio_funcs *funcs =3D
 		connector->hdmi_audio.funcs;
=20
+	/*
+	 * Only skip the specific prepare that hw_params already did the work
+	 * for. ASoC also reaches .prepare with no .hw_params call ahead of it
+	 * on XRUN recovery and on resume from suspend; prepare_done_in_hw_para=
ms
+	 * is clear in both cases, so the call below still runs and configures
+	 * the sink here instead of leaving it unconfigured.
+	 */
+	if (connector->hdmi_audio.prepare_early &&
+	    connector->hdmi_audio.prepare_done_in_hw_params) {
+		connector->hdmi_audio.prepare_done_in_hw_params =3D false;
+		return 0;
+	}
+
 	return funcs->prepare(connector, fmt, hparms);
 }
=20
+/*
+ * Only used by connectors that asked for it; everyone else keeps being
+ * configured from prepare() and this returns without doing anything. Se=
e
+ * &drm_bridge.hdmi_audio_prepare_early for why a connector would want i=
t.
+ */
+static int drm_connector_hdmi_audio_hw_params(struct device *dev, void *=
data,
+					      struct hdmi_codec_daifmt *fmt,
+					      struct hdmi_codec_params *hparms)
+{
+	struct drm_connector *connector =3D data;
+	const struct drm_connector_hdmi_audio_funcs *funcs =3D
+		connector->hdmi_audio.funcs;
+	int ret;
+
+	if (!connector->hdmi_audio.prepare_early)
+		return 0;
+
+	ret =3D funcs->prepare(connector, fmt, hparms);
+	if (ret)
+		return ret;
+
+	connector->hdmi_audio.prepare_done_in_hw_params =3D true;
+	return 0;
+}
+
 static void drm_connector_hdmi_audio_shutdown(struct device *dev, void *=
data)
 {
 	struct drm_connector *connector =3D data;
@@ -130,6 +168,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify=
);
=20
 static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops =3D {
 	.audio_startup =3D drm_connector_hdmi_audio_startup,
+	.hw_params =3D drm_connector_hdmi_audio_hw_params,
 	.prepare =3D drm_connector_hdmi_audio_prepare,
 	.audio_shutdown =3D drm_connector_hdmi_audio_shutdown,
 	.mute_stream =3D drm_connector_hdmi_audio_mute_stream,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_=
drm.c
index c1e4147bf..52c90937f 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -327,6 +327,14 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display=
, struct drm_device *dev,
 		bridge->hdmi_audio_dev =3D &msm_dp_display->pdev->dev;
 		bridge->hdmi_audio_max_i2s_playback_channels =3D 8;
 		bridge->hdmi_audio_dai_port =3D -1;
+		/*
+		 * The LPASS/ADSP side of the DAI link will not start its AFE
+		 * port until this controller's audio clock is running, and
+		 * ASoC prepares CPU DAIs before codec DAIs, so configuring
+		 * from prepare() is too late -- the CPU DAI times out and
+		 * aborts the link before we are called at all.
+		 */
+		bridge->hdmi_audio_prepare_early =3D 1;
 	}
=20
 	rc =3D devm_drm_bridge_add(dev->dev, bridge);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a7..d208ba114 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1177,6 +1177,23 @@ struct drm_bridge {
 	 */
 	unsigned int hdmi_audio_spdif_playback : 1;
=20
+	/**
+	 * @hdmi_audio_prepare_early: configure the sink's audio path from the
+	 * ASoC hw_params callback rather than from prepare.
+	 *
+	 * Both callbacks receive identical parameters, so for most bridges it
+	 * makes no difference and the default (prepare) is right. It matters
+	 * when the CPU side of the DAI link cannot start until the sink's
+	 * audio clock is already running: ASoC walks CPU DAIs before codec
+	 * DAIs and stops at the first error, so a CPU DAI that fails waiting
+	 * for that clock aborts the loop before this bridge's prepare is ever
+	 * reached. Qualcomm's LPASS/ADSP is one such CPU side.
+	 *
+	 * Setting this moves the configuration to hw_params, which runs for
+	 * every DAI in the link before any of them is prepared.
+	 */
+	unsigned int hdmi_audio_prepare_early : 1;
+
 	/**
 	 * @hdmi_audio_dai_port: sound DAI port for either of
 	 * @DRM_BRIDGE_OP_HDMI_AUDIO and @DRM_BRIDGE_OP_DP_AUDIO, -1 if it is
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c5932..749eab1f9 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2184,6 +2184,26 @@ struct drm_connector_hdmi_audio {
 	 * The port in DT that is used for the Codec DAI.
 	 */
 	int dai_port;
+
+	/**
+	 * @prepare_early:
+	 *
+	 * Call @funcs->prepare from the ASoC hw_params callback instead of
+	 * from prepare. See &drm_bridge.hdmi_audio_prepare_early.
+	 */
+	bool prepare_early;
+
+	/**
+	 * @prepare_done_in_hw_params:
+	 *
+	 * Private state for the @prepare_early helper implementation. Not to
+	 * be set by drivers. Tracks whether hw_params already ran
+	 * @funcs->prepare for the prepare call immediately ahead, so that
+	 * call can be skipped without skipping any other prepare -- ASoC
+	 * calls .prepare without a preceding .hw_params on XRUN recovery and
+	 * on resume from suspend, and @funcs->prepare must still run then.
+	 */
+	bool prepare_done_in_hw_params;
 };
=20
 /*
--=20
2.56.0

