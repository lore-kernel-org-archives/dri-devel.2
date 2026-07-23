Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230D0C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF9910F218;
	Thu, 23 Jul 2026 22:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d7b0vxFx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F4810F218
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=nmwrLXq7/O7Hbu3rbvXMqYcBqfxPK2sVzyBnuhEyf1k=; b=d7b0vxFxH6CIzC+fn3pEpOxuIB
 +v/T43SE3mTY+TFmygMh2nuq33QxvD94qmljHx0ST925XUXCMympXEhV08pUSs8vxurhLF5MtZmIO
 Lp0NmGQguc8BtrHx8ctdiARkK+FeHJI8VtZM0Mk5eQszpY1LEzjFFud9K8NsGpCMBDbbMVHPB26vZ
 24zZTGQsI2JwvEUsX2oId7Jc1MidPtypDhcpDjQg5qyIHHMrmEtQCfHOuDbZBB5I6j0pTbHF5Cbc2
 URk+wG18yVx4Tq9jhkhF7gOQt5XqoSMcJdncX/mRgWPXK+D1QoUBd9r7YFqk5/vrtX+CNkbwZ0Mp3
 LqRx9jvg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wn1aR-003ck8-V0; Fri, 24 Jul 2026 00:08:16 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/connector/hdmi: Fix out of bounds memory read
Date: Thu, 23 Jul 2026 15:06:52 -0700
Message-ID: <20260723220652.533345-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A helper function was copying a given audio infoframe into the
connector's copy but using the size of the destination (a generic
target, sized to accept many different data blocks) not the source (a
very specific type of data block). Thus, it was copying 60 bytes of
data from a 28 byte allocation.

Fix that by using the source size instead, together with a build bug
on the source size actually being smaller than the destination.

I hit this running KUnit tests under KASAN (while debugging something
else entirely). In the real world, it seems unlikely to cause an
actual problem. It is a read not a write so it can't corrupt any
memory. However, it could potentially fall off the end of a page and
cause an accvio bug.

Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: "José Expósito" <jose.exposito89@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce17eeefc2da..d6669e36ca1b 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1142,7 +1142,8 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
+	memcpy(&infoframe->data, frame, sizeof(*frame));
 	infoframe->set = true;
 
 	ret = write_infoframe(connector, &funcs->audio, "Audio", infoframe);
-- 
2.43.0

