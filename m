Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD2CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8F210F845;
	Fri,  2 Oct 2026 13:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SBMMQbR4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4484110F845
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=d0J+4iKLs3cVv9BKsWBHc07kp6YPJ9zrgVG+htvCSSw=; b=SBMMQbR45Qw2kbghhZ4ygjonO+
 ooEmVVgQlYEjWjqqr+F9zrgXr1anjAwP+U14aaC88/qPdG5SN62VaUblYci1xQAge53g08jvuNEfh
 ANpGjCQcQ/6uJk5UXOmnGTLgaggqyeyO7JvdQJNVPK6EaRfiboHuV6pl4k7b8YABoSrKahRxKXwDU
 MeJ5+0H5ydRDBARMVInQ/tl0pCM2qmIHiWRvNRK8DpBB8q/wJvp+dQsusKTCSSOV0tMZaWXb2lqnt
 txBsW9a+9DMMP0Gs6QgBFmwJdMlr8JttgKEmfw8dbENIhuDQ2tovM+XLsg9+7f9w8uFU6kZXbBJmt
 7xgbUhSQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCdRZ-00AceG-CZ; Fri, 02 Oct 2026 15:36:57 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 02 Oct 2026 10:36:44 -0300
Subject: [PATCH 2/2] drm/vc4: hdmi: Remove unused packet_ram_enabled flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-vc4-hdmi-packet-ram-fix-v1-2-3d73148096c9@igalia.com>
References: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
In-Reply-To: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ViziPR5S1C8Zxfjh0JDTR/RIDy3chkW/XCkjnWRkRF8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqv7NxShW1w8OylopbL6vSiiNyirVJvEDdjVIgW
 w3XzJt5ZAuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCar+zcQAKCRA/8w6Kdoj6
 qiH8CACh22+rvF4OTs1Om1RdPWjRicJeCH1tGgUyciBZdrmzs/PMjDgHgYlXWqIAIE13RqKJHSK
 8jRbn8wn4RAfAk+g0+KvwrHlTHBn9hmOtelTPIvFJ7LoTOiIKoxIqdJP8VoM+ZqhwtfWz01YgqM
 DfYxRgmazL4Alu6FD4HZs0v+nUy4vmiUkC75QMLrikecXTJLHZJE+6D4DA5EKBZhznma60bAWoP
 /wu4SvLP0nV8iKqdZ3J2MEJ0ItinN2V4ycDxNm2KwkBVNyxzSGnB9eXl+9gI+KriwFd58WV9B5a
 /LQQYnxb05l8VpB1oU+7u/L5Dm+nECBhCb8Wb2J8++fQRwl6
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The last use of the variable packet_ram_enabled was removed in commit
b47a72f30768 ("drm/vc4: hdmi: Switch to HDMI connector"), but the flag
itself wasn't. Clean it up.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ---
 drivers/gpu/drm/vc4/vc4_hdmi.h | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d4672aa81d85..939ec35527c9 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -887,8 +887,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 
 	mutex_lock(&vc4_hdmi->mutex);
 
-	vc4_hdmi->packet_ram_enabled = false;
-
 	if (!drm_dev_enter(drm, &idx))
 		goto out;
 
@@ -1682,7 +1680,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
 
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
-		vc4_hdmi->packet_ram_enabled = true;
 
 		drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 	}
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 29d461d4ee49..e4ad1889cbd4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -187,12 +187,6 @@ struct vc4_hdmi {
 	 */
 	struct drm_display_mode saved_adjusted_mode;
 
-	/**
-	 * @packet_ram_enabled: Is the HDMI controller packet RAM currently
-	 * on? Protected by @mutex.
-	 */
-	bool packet_ram_enabled;
-
 	/**
 	 * @scdc_enabled: Is the HDMI controller currently running with
 	 * the scrambler on? Protected by @mutex.

-- 
2.55.0

