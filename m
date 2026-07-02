Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FD6C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95B410F3F6;
	Thu,  2 Jul 2026 14:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="B4xUsm82";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BFF10F3F7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003592;
 bh=E0gC4MANsuSpWJyHYxzHDJZ9tL8K1fxGS3Ks/UcaSEQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B4xUsm82C2Ng+wsCb52BFjCwhnkD5rchqc+1DCK+oXgPcysKrFIazxgBqVVFycnud
 9XoMy0iAxkcdVqTN2UXPFHAlv93u3+cqIyOynJjCWdO79+Uvn4luJUMNkomkPXV2K1
 Kg16w9sAc/jgusj/+WvuWmM49BYoqHoOctU/ZdHIVTeGSLbsLPlvFgA5dt3ydDm3dY
 FrY5M9qkqW0y1qHYVxo5ii0ju1gYirEeTImHp/6iMNNr/zg5jVC2TDzsFeLM+DRtae
 ehZfVFOMHQ3lBfBAYNIqgURylcH/8i8OsaAFgZFsxKmCdfO7TDrof05GTBhPYJyIbh
 EKAJvW9bN4Anw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 37B1317E0E9E;
 Thu,  2 Jul 2026 16:46:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:14 +0300
Subject: [PATCH v8 01/39] video/hdmi: Introduce HDMI version enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-1-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

Add an enum to represent HDMI specification versions.  This will be used
by upcoming changes to associate HDMI connectors and bridges with a
maximum supported version and to simplify handling of version-dependent
features.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/hdmi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 8dab78e1f61b..b80a5ee63bb2 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -27,6 +27,18 @@
 #include <linux/types.h>
 #include <linux/device.h>
 
+enum hdmi_version {
+	HDMI_VERSION_UNKNOWN,
+	HDMI_VERSION_1_0,
+	HDMI_VERSION_1_1,
+	HDMI_VERSION_1_2,
+	HDMI_VERSION_1_3,
+	HDMI_VERSION_1_4,
+	HDMI_VERSION_2_0,
+	HDMI_VERSION_2_1,
+	HDMI_VERSION_2_2,
+};
+
 enum hdmi_packet_type {
 	HDMI_PACKET_TYPE_NULL = 0x00,
 	HDMI_PACKET_TYPE_AUDIO_CLOCK_REGEN = 0x01,

-- 
2.54.0

