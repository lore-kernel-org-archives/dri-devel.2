Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33994C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5571F10E299;
	Sun, 23 Aug 2026 09:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6FG0TVh";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B785810E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 14:31:24 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso326622966b.2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787409083; x=1788013883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pUYxeQkkOydFxi90Wl+h19lQoxgRcddBRZaaP+r9C1s=;
 b=j6FG0TVh9TexgG6HTr7MX8yhGdCvEmffiHcaPPPLkAOlT85+4fFyCotsGl5cR5v014
 kQ7jA77ASVV3PYeceGcwMkCU1vZOw+Q/KHZkGu60oUF+f9ZoYh+S7PLBhMpLNQPDy3be
 IZR3QAfgHNADbJdH5h7t/PumBV5aqPewhvxQSH9Skq6rxZfnsqTXiCpVyAzKlnbM8mHo
 oCvtOKLk86YdAL1e6MvisFzWQksQv1WsUI4n69SiHpyqV05Tmn3YEAbt8pWXON8CJHmA
 QrSNBLMoeQJjjOizMWHMt7MJQtliKX6HXuKEW0E7AOPkX6y60LUcfRkKPU6Oo9NK4CBl
 VlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787409083; x=1788013883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUYxeQkkOydFxi90Wl+h19lQoxgRcddBRZaaP+r9C1s=;
 b=ZwS3ZksaYViAUzy9CiEpy8KWpqtq2i5Bpo+XyeFAISmdVhIkPRUBci2hNDW61dzISm
 goErQ2ARMb3BgXWZy8lDJ2b6OkCNLEmJ7otYAbX1JNiV6RGLI/R5KzHNUnyblUzXh1ke
 10RKDucJIZ3YQUE5/hj8JHcm7PMs/fiJgjLt3vbXinKKe24GlWeK8QUWgE8muaQYJx8Z
 NlXWb1ZbOVh4PFB5EIrhYMbH1CUDkbtVehiBohYK6qjejKk6PQWJ5tqzgX0l4useK3vs
 TN86odT4bKQNrbyX4+FI5g9DUD/Gv57g8x/012+eyTVblq1sRkN4S/5iPNg3f0RT7Zp3
 H9QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAELymxwdtv5HirttrcWjqFldC/M1sqEifamQ7bqXv/F7G4FN9pwl0XZ3qXkaVs5QWex9x53Kcm2w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7K2TwIChnJRq+ofFObMz8pDgR0lun7q0LciiQpMk2XB5SzcfN
 sLNaY9p3/PdW6agvQWfETEfuYa+JU60WHiYq1HNIiujs//Nd5ipG2lu0
X-Gm-Gg: AR+sD101k4U84VHLM4Kas9WeBYP6DLfNtNtzH/Wkh6ex9XU2nfZP6moZkUBL4fHv31G
 +R6rm+eF6XlK/ULjsH+l3Xi+XJEyCImoh09ighlELaz429Qqa94C3vwIALJvO2ZxDKf89osDnq9
 35yAifZS/xAiUNOJOSmJ8Ksjn8SZt+rzicIAMAT57zcCLxGPfHlAlGKTvGFtoSm2WZt6Fik+5OI
 DD2iMmAYKJ+YsuhYhOknl5V1tJZMK3lmKehIdXYRsjjUTYxkd+uY9yiee+F1WIWZoOFtkc3ODrm
 cMJfXrLb2cfo+z+mZS4/Deb/kxyOYS5Dz5Y6vLETkBO35dWZvBqsAcWMOvp3GXF1fnuoET0mmHP
 rdijVWSep/jfJn01cnj2Aj1alDseH1T+RPu8HlZQXSmkLmhoZWKseCZbm/+jWeD3Vagx+yPvZB/
 TmsZPapgERgRnt+zKZ8rWT19n6cJbqTMmzvHiLM9ChMWvMi+BIOshNu6WMTmwB2yLIiEd8VHS3g
 VuVVPhDokihKfbmbSXC6Gh2HfTmmoV1q+YoTIrP3B/mu2i16nVLLLVm8DqM3lRzhJqBMbL44rO2
 IbMuuG+cSijkHK1q2q/2wtWmPv2jgeYoUYhbxksDyVSb1ujMmQQ/hnEjuVlWbUOc1C9B
X-Received: by 2002:a17:907:1c27:b0:c21:382e:9a38 with SMTP id
 a640c23a62f3a-c2491c2a110mr673395166b.2.1787409082801; 
 Sat, 22 Aug 2026 07:31:22 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de.
 [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629a901sm383818266b.25.2026.08.22.07.31.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 22 Aug 2026 07:31:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: Use managed KMS polling to fix UAF on unbind
Date: Sat, 22 Aug 2026 16:31:10 +0200
Message-Id: <20260822143110.68594-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

vc4_kms_load() calls drm_kms_helper_poll_init() but the driver provides
no matching drm_kms_helper_poll_fini(). The output poll work stays
scheduled after unbind and runs on the freed drm_device:

  # modprobe vc4; rmmod vc4; sleep 10
  BUG: KASAN: slab-use-after-free in delayed_work_timer_fn
  BUG: KASAN: slab-use-after-free in drm_client_dev_hotplug [drm]
  Workqueue: events output_poll_execute [drm_kms_helper]
  Allocated by task 171: __devm_drm_dev_alloc
  Freed by task 262 (rmmod): drm_dev_put / component_del

Use drmm_kms_helper_poll_init() so polling is finalized with the device,
as other drivers do.

Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on a Raspberry Pi 400 (BCM2711), v7.2-11658-g26260251022f, with
KASAN: report gone, rmmod/insmod loop clean.

 drivers/gpu/drm/vc4/vc4_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index b17e73bce384..82a7f2ac4c7e 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -1188,7 +1188,7 @@ int vc4_kms_load(struct drm_device *dev)
 
 	drm_mode_config_reset(dev);
 
-	drm_kms_helper_poll_init(dev);
+	drmm_kms_helper_poll_init(dev);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)

