Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A16C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA3310E44A;
	Mon, 17 Aug 2026 21:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hVVnlp3r";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D039D10E94B;
 Mon, 17 Aug 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=JOdEnDPQG70atwX6UwnG6mi3Usldc7fzPlg8dJlEHuk=; b=hVVnlp3rDmJq9ATDk4+473BzSd
 MaYjIYHj3muZlCmGUwR8zmQoJVZVMPP3hTn227m5ZR9DunBcOuQhMc5ioltBjC1YYPfUM0Jr7k/ak
 zh/3INxb3stEX5I13eE2B9MTwo9d06HEUAAOvXQMV2NINxL45r0S3sy5AYudeDr832Q25S4GaQPhN
 J7/OW5ijjP5TKAIEA9xVnOfEvSXnXx/Tn/Wd2HSDJ/s7xIB9dvFvjotf0wAc3z+GMfkLL9U3q0Rrj
 8Bxi4F0VG9udLVMFUZUl0Vdnsli1kWi163m6LWyJdCNk1P/a80/9vuPiHXjfBJnJuf7M2EiemFUuy
 XOs7vSGA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4XO-00504Q-I5; Mon, 17 Aug 2026 23:06:30 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:46 -0300
Subject: [PATCH v2 6/6] drm/vc4: Use drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-6-73052b669f49@igalia.com>
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
In-Reply-To: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=6SdIesJwo2rWJks6lF/ReWhhuuB2IJ1mkY2yW7OSC2Y=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eq05LK5reYtUuqBNlSdTpAtV7F+0oswm2x6
 uVSsSwseVaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qpXvB/4teituWpU8b2Xvi6/EslifsLnsv3/hMH3ArKzRRVnc5oTPhnBDnza1SzYByt/qpjfEP2V
 r1U6JvyEyW2fgdVh2EpycdrMlv8SHPFSJN4XdcZH6OX+YYCzzp/SlNR7NDtbf72k9gAX2z/XHbh
 WiCiFdJGbILIVoWm7Pb9wz0WsCbC/1LgCMrfaYqvXzi2utHbBXHS4qaGqg796VgQPPxOWIpk3Ag
 ervjUAyFlMY+UhMRjDgq8aIl5LxsuEC62qZw0vBbQRfCgg0vF31HYCWtGxbNZe9QzCZIyaLoYdZ
 ygq4QK3Ovw7mrqN/RcxbJu9TU1VxrL0Xa0RaBmYAcfGEc7FQ
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

vc4_wait_bo_ioctl() converts its timeout with usecs_to_jiffies(), which
takes an unsigned int. The microsecond value derived from the u64
timeout_ns is narrowed to fit, so any timeout above UINT_MAX microseconds,
around ~71 minutes, wraps into a much shorter one. Unlike the equivalent
problem in the other drivers, this one is not limited to 32-bit.

Use the shared helper, which takes the duration in ns and clamps the
result to MAX_JIFFY_OFFSET.

Fixes: 21bd85f82ec2 ("drm/vc4: Use DMA Resv to implement VC4 wait BO IOCTL")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index e231c906709c..781aeb8967b1 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -32,6 +32,7 @@
 #include <drm/drm_exec.h>
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
+#include <drm/drm_utils.h>
 
 #include "vc4_drv.h"
 #include "vc4_regs.h"
@@ -970,7 +971,7 @@ vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
 	int ret;
 	struct drm_vc4_wait_bo *args = data;
 	unsigned long timeout_jiffies =
-		usecs_to_jiffies(div_u64(args->timeout_ns, 1000));
+		drm_timeout_rel_to_jiffies(args->timeout_ns);
 	ktime_t start = ktime_get();
 	u64 delta_ns;
 

-- 
2.55.0

