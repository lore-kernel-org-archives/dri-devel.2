Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC0CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E1C10FED9;
	Fri,  9 Oct 2026 06:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="cwEnNaKn";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CEB10FED9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529046; bh=uQ1vwsvHl67hTLk4Q4nVASCB9QPOXRM4BjtgGk5V2ao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=cwEnNaKn0vLYgk1E9qG4dWScEJF6TfegI7lq0e4KU8nqBqbo9WUnZncI0ev82v2JGYJjC1YGrYHxbhKolVZwMGccqNeSUL0r4EAXnZ7jn15ZnofRVcvLAcvu+LEyAn6Zb+MHfBFv+wh9M5BVYj2J8YjHmB2nH98Mvqh4eDfmZTjCexjNwIDgZiSd9lPmYsdgLhH2fOdGaLa81oDe2ECktdPNiyfQdn0HXZKAiCY2jLcfOkOpCqDdZUOKJWylIVK403bpSYYUWucuZDOYyC8NvAK6adQy10Mx0ZZfzqLb4cCJBdbWlSL8CCV00Iikcq6ISHgHkaFe2GLjKZ1b8O9KtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529046; bh=pqaUa9TkGIUKHX1X/2giD4TCArASpk8VxErDQdVuH1X=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=WAfcU+gwz4APfn2BThuKw8LPuO7/MkzQPyLOKznLRuKID/DU966sl5qwrI9T4Fz4dYGWFdpAZNae0/kIuzeTZ/8zBNeojHnAFGRZ9IR4fWpPMM7TsF9JmF6XWgfr2UHaGMVzRnCRipnOT4glIEweT2yCp88mEUp6/S4/Q1lhy/O46jb6q62J+ktDJMv9Sie36I4USp9bVY2hoo2m6T7zyzxA+OCw5FZhIJtjn1v7jT8Vuv5kUCrEh3zqfUc77xGEYj8ykCEn6FzndiufmydNLaZKgVrJ/3lweBK11MO3kMwYkET0IDZwdEub68geNqLOJICZoOUMn6K2rN77/IfAVw==
X-YMail-OSG: nXtQTQAVM1kSItMlniOwAYGth.lDbZ6WojfMSO1Ro.Jlyk1YqmbgAsZ82PLqeCU
 kqT_JlYe4VAdfZXP3XbqwShMlk7szwLqhHgIuAZMNWpO8hSo.HlHZXxxKDMVEpyrj4ykkOPsyG0r
 co.8ieZya8nkswS3wiAljgsjh1nP5XbnqN2Fsbqpy.Awvth3_eJjudFCgzwuQv9BWpMmncOPgx3X
 7cQT0loeAcGDQvvpiUTTa7zPEc2T6docx.PhPboIePigmaNTvX8e8L2m2lwAWCsuY505.AXoeRZ3
 kuSBShEGqMkbi5deE6UIB.yX7jl_v8SSvlqHHf43jb1VBtB2GuaJ926Y.JEShrmHQHuK9p9AEQWO
 slD3t0ckx1.o9sillhXa8aA4LEjTGEowaHQvZIQgBG7LBy_hO0LynJTRvNXFWh7pmdADV.PSE8mX
 xG_uhkwtHXwAHnZNZGJaUdhqHtUxtM8svmmSfYP7QN5bC0MFEdx1ZLpy21CRQREXnj8d3xL7DAGL
 7O6pVqYUg.gyMfDnZo9IzmGJOuk1kaSsG3_GphVb0Z.2MKv6F82XlTnfCJshZkHM5vWtmt8p7ly3
 zfJs2BEz90bIKv8.VZffe__f4Bl8A38WT5yF1ey59ju5jKh4BejjobXve.HXosLYm2OZCkKGaCFJ
 WgxaSHx_hiMEugP57JRzvt92MlHAg8PeP1k0mPFYIHANQGUaqvX53ecdnLqTQnAqQhjzPqH7oogB
 6FRtBk8.U_iA_V3wn4j9XChx9TrmcH1qsXy0Z2n37apmn7c1HOS8mF6Le0qBwgZ4Vxhh2xvzM_6c
 3j8caXstGCeJU_XWwgCTPyYR44nPkMAg6j4olWmGIpogYHCct2REajkahuzvR03zhpc1..zLSp.1
 hNwCkpMNa4q5rfMuk.mCGMruefyfXjLPdeIJBJ9Sc8rxLY2MnJaGNdgRcJuwqnPz3sCq_htITLQA
 G2AKiVVwapBdJ4gvPcQEqNUNJKX3nKN.an40ICwka3cEDOe9spcm7x92gUb2.Ra3mlL_ETKNBiRA
 BQWTy5zhfZE1xVolC5TseD6q9KFg_qT6Z.Ws_6bJ9ASYvKxHmpFnN7HE3tUSBzncaxUy7q7fPn8b
 E5gh4ItqSo.HzrJ3zBjnZKoTLOZrNHWuZaEaBoH0wlcDDw3mVva_THBgF063e6RfXiU9UguYy9w2
 GFWJ3vjOYNFmv3uWJgeTlys1uDd1KUf86V8_GuvfzOviOfxb2cwf6ISluUOVBRJnhNH_j3k89wuj
 CWxVbh3AG5pplukeNz2XiGs_hYFtSj5NHudll.F0lBVzA5CuhLrDsTeTF6KmqZLAYPXv0F.AYOkh
 OcDv2cJAu7L.9Cne1T3k5BILUvDgupL4ut2Absk1apD_NUdGzpIV9zAm4WoKb8QBEwB1_S.Bnc4l
 _HSt8OSHVm8GXY5fJZc5LAbHV6_L8ds7lPYfNz0HRFgMbQMi7GSNMErVsR6ptlATZOT.1mTcfAR.
 UUnKNi_qJ9fPuIDGmncdO8lWvBI4aQuY6_lyQzVWy1Bk1vNV293_g9H526WurJTn.pjuMRO0._.j
 NR1sOe5Camst9t36Hlzi19ffcYukb_O4dUZrAKqctkDyfaOnv7C_WJfpRmmqukvvzwFfBW.eM817
 QJmcARMCqUfkpkjPloaaFOwMgOYEdenBIsSpudq8dptUkvr3btyutes6yVY_e1pfX9naizbBcnMu
 a_LocfrA7IhQlRwPNA_D7fV4EprHMaBKx71tlFL8ha7et_ow48GS9vDQfEd2Va5s0bpdo.oc0W6g
 DBfzVyj728qqmEl17SWv7hlQ_.aSpVdE0ViizAZ6MSk2GpWDKYtRCCExMzu65aXmysdm5Qk7bTN_
 WHlRfOs5evehuwhUXoNNOS79FDu_gOy6vaSuvYVEdFyNzz8OhewMcxtCnpI4nmSjSprn2ua5_UFh
 pWDp0DNV2Z7VAb3Zlssud_7WXqxeAMrERuv7s6xI4CHys.R3dI2VXOeKG.MMm21ruBCSELGQZ1Tv
 pZPfN9UJaRS0_UtTBS_S6M7XAV3KpEepViokdNjWUoGekw3T6
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: e337ad8e-fd33-485d-9c2d-8eafb8f1f79a
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Fri, 9 Oct 2026 06:57:26 +0000
Received: from dip57.lsn.bf1.yahoo.com ([67.195.177.66])
 by hello (SMTP) with SMTP ID 3a94e920576243f56fa5ced650a33faf;
 Fri, 09 Oct 2026 06:57:22 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] drm/vkms: Compose the frame of both eyes for stereo
 modes
Date: Fri, 09 Oct 2026 03:57:18 -0300
Message-ID: <179152903816.1726604.3266640931303698561@yahoo.com>
In-Reply-To: <179152903254.1726604.8785647683993800694@yahoo.com>
References: <179152903254.1726604.8785647683993800694@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
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

A frame packing mode describes one eye: hdisplay and vdisplay are the
size of one view, while the frame holds both views and the vertical
blanking between them. drm_mode_get_hv_timing() returns the size of
that frame, vdisplay + vtotal lines for frame packing, and the atomic
helpers already clip the planes to it. The composer still stops at
vdisplay, and the writeback connector refuses a buffer taller than one
eye, so the right eye never reaches the writeback buffer or the CRC.

Use drm_mode_get_hv_timing() for the composed area and for the
writeback buffer. Modes the helper does not enlarge keep their size,
top-and-bottom and side by side (half) included: their eyes share the
frame of the mode.

Assisted-by: LLM
Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  |  9 ++++++---
 drivers/gpu/drm/vkms/vkms_writeback.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085a..751b7373c0 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -484,8 +484,9 @@ static void blend(struct vkms_writeback_job *wb,
 		.b = DRM_ARGB64_GETB(bgcolor),
 	};
 
-	int crtc_y_limit = crtc_state->base.mode.vdisplay;
-	int crtc_x_limit = crtc_state->base.mode.hdisplay;
+	int crtc_x_limit, crtc_y_limit;
+
+	drm_mode_get_hv_timing(&crtc_state->base.mode, &crtc_x_limit, &crtc_y_limit);
 
 	/*
 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
@@ -545,6 +546,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 {
 	size_t line_width, pixel_size = sizeof(struct pixel_argb_u16);
 	struct line_buffer output_buffer, stage_buffer;
+	int crtc_width, crtc_height;
 	int ret = 0;
 
 	/*
@@ -561,7 +563,8 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
 		return -EINVAL;
 
-	line_width = crtc_state->base.mode.hdisplay;
+	drm_mode_get_hv_timing(&crtc_state->base.mode, &crtc_width, &crtc_height);
+	line_width = crtc_width;
 	stage_buffer.n_pixels = line_width;
 	output_buffer.n_pixels = line_width;
 
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index ecf29a2c0c..40ee142e0e 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -38,7 +38,7 @@ static int vkms_wb_atomic_check(struct drm_connector *connector,
 		drm_atomic_get_new_connector_state(state, connector);
 	struct drm_crtc_state *crtc_state;
 	struct drm_framebuffer *fb;
-	const struct drm_display_mode *mode;
+	int width, height;
 	int ret;
 
 	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
@@ -48,10 +48,10 @@ static int vkms_wb_atomic_check(struct drm_connector *connector,
 		return 0;
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
-	mode = &crtc_state->mode;
+	drm_mode_get_hv_timing(&crtc_state->mode, &width, &height);
 
 	fb = conn_state->writeback_job->fb;
-	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
+	if (fb->width != width || fb->height != height) {
 		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
 			      fb->width, fb->height);
 		return -EINVAL;
@@ -132,15 +132,16 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *conn_state = wb_conn->base.state;
 	struct vkms_crtc_state *crtc_state = output->composer_state;
 	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
-	u16 crtc_height = crtc_state->base.mode.vdisplay;
-	u16 crtc_width = crtc_state->base.mode.hdisplay;
 	struct vkms_writeback_job *active_wb;
 	struct vkms_frame_info *wb_frame_info;
 	u32 wb_format = fb->format->format;
+	int crtc_width, crtc_height;
 
 	if (!conn_state)
 		return;
 
+	drm_mode_get_hv_timing(&crtc_state->base.mode, &crtc_width, &crtc_height);
+
 	vkms_set_composer(output, true);
 
 	active_wb = conn_state->writeback_job->priv;
