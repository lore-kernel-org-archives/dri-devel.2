Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB55CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5406D10E605;
	Sun, 18 Oct 2026 12:37:19 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB91A10E605
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792327031; x=1792931831; i=jan.claussen10@web.de;
 bh=CCCBgC3t202EBUvzUuRYpuK9FpeOT8mgidQb08HiPmk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JlGFgv2ugWH9HCrRU5m5INK24qAUbalH/pd8ZXEzN0clSNQZUXTQTCVYATNlJv+R
 tamnopJJs4FetepwwWLSJr+HMktvDrPeuE2VghKMHSQV1OsRmqYGRCNK444OZcFXM
 2bBX+rW5aWTtdGtS37eROEjJgWCCRCue9CtNMG9bqamxKBRXqKDPl1YTSoweSRjdM
 BEWSwNB3UwUUUnDuJr+0BgcWz9A+W8sIedgBUR1pvD7+g8qwjt+DVPz8MwihNgiYa
 zMGQZegoooXTkpqM+rJefHch7bWJP5c1DsaiNGKhIb6L2LSc4CNp0rKTnXj0SWlvu
 PeYJs1kT00WWbvCj4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1x6KBA2Kse-00YCln; Sun, 18
 Oct 2026 14:31:20 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: John Harrison <John.Harrison@Igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] drm/display: hdmi-state-helper: Force modeset on
 colorspace change
Date: Sun, 18 Oct 2026 14:30:12 +0200
Message-ID: <20261018123037.19560-3-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJkWQDAMi0YPgsmtgoYbQDFzo/V4hDdi3DUG1I78DCx39HWSl8I
 ut0a40aX6NYyD2TI4Za4d2AR9sBVsxpe+sfTj1x80yAK8hOo79I8GMpDmdHqCyRHpXXbZoa
 ZCfDp31Kn/2nbayYTo+jpf5O9ODaZI/pm2z6IRnWZa8GLS3UEH474Jvdyv8v9jChjmd1O0I
 msYIHnUxl0Xq3vwaoDkHA==
UI-OutboundReport: notjunk:1;M01:P0:D/ov6gbKkqg=;FuS+r5LBeO1iszMOBg0wFey4MmO
 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
 =
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

The colorimetry signalled to the sink is part of the AVI infoframe,
which is only updated on a modeset. A change of the colorspace
property therefore never reaches the sink.

Treat a colorspace change like a change of the Broadcast RGB, output
bpc or output format, and force a modeset.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu=
/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..9368e53c5945 100644
=2D-- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -925,7 +925,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_=
connector *connector,
=20
 	if (old_conn_state->hdmi.broadcast_rgb !=3D new_conn_state->hdmi.broadca=
st_rgb ||
 	    old_conn_state->hdmi.output_bpc !=3D new_conn_state->hdmi.output_bpc=
 ||
-	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format) {
+	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format ||
+	    old_conn_state->colorspace !=3D new_conn_state->colorspace) {
 		struct drm_crtc *crtc =3D new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
=20
=2D-=20
2.56.0

