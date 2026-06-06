Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88697CD8C90
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74A8112D71;
	Sat,  6 Jun 2026 07:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChlGX08M";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0A8112CF1
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:06:26 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84230ab8857so1152156b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780718786; x=1781323586; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MCpOoA7ZBka25eBQE3xrOCOU1NvVrWBs06gXA1dKzzE=;
 b=ChlGX08MeE8UsCKcIFDmB8h1i8ssde6kLUgIhK/ouKOiH8R+Tcd3aqa5xU3l5HaOYQ
 zBVKKTSlhCzSVdBgBICiU56oCrDMOoIFwS8MXjfnv9JVVOpYjo2yOJDnZ75W7E6UHu6l
 F7MUtSuAQRKmznlFcda649+2skS3ixlSMFHcD1WF5/Stosxxe7PAJYlnaw6AL9tqe6YW
 zTVj0Xa8GK3/5OwlnGthPsJC0dkeyKvbIDN7y31QaSp0ZI5UTzGoif6nv+rk99oFT+kU
 lBSgomdjeOXLUseSYdDh8nYotT6ySNu3vNEUblGjFRLGbf1njsnKf326iLkZbAH4rA/c
 oj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780718786; x=1781323586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCpOoA7ZBka25eBQE3xrOCOU1NvVrWBs06gXA1dKzzE=;
 b=B4fyK2Ndeu+HHhKoVeQeFD1ScDn7DNZs/YkJjJCkBNG1ra9Tg3suSKkGveNPRkNL8y
 UfxJ+/G55kCKnWtnC+4DDVNoPOucB6GHh6uk2NFotJ0tROO0uhOJYC0bBtlmW91QVAlX
 XdGUcavCmnB5AO2JvoIdCfFWO1Xn4kbQzEiEt9mc3uhEpl6dVNov1QwdFd/9I3BKKSu1
 yykGBFNsRRKcbGTImKBYm8nSWEOa5wrDewIqeixvySaFNuiva41LDO9VIL+iltrTtbui
 Fw45xqnfAdowS11PB0VvO19QaU7htmAxer0Gv9G1wN/KKId3acLBjnK+DVW+kCcXtSxv
 9DzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lUnp/KGQ8pTAKKEoZ7Zk07UnIX/pEnCbuyUxTIF4sBhoJLlv5zPSjtZ2BDYAGrMXjTsWEk6F3V2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDquZaTyGyhAtWmOELO2zkila8+wamZ1FJgzWUi69oHzPiuKrv
 d3pwqRaV9IeGwu7mNoHnEoFM6798JOnzHjRxBw73K1SLmT0nUlnQaEYU
X-Gm-Gg: Acq92OFBS95aQR+oxEj6lIOeOdDgxT4TWFyFdQF/ztvDjHiveWrQ+qjVgOyIy9xW7Vk
 ClUfHCiQlWqstwtCuUpfWf0RtWL4FFKsjWepFY69Zoc9hjpGO5nPC175T1F1INkFnrXekX7vFOQ
 pxsRm3SsC3+N/W+Kq77/c27oJVTjTz4u7YFhG/QLz9p0vI0uHw8k0Wrkdph2xWCbhvjCNE/rOUA
 YVE5FBe1aBc1yY6vk6dhDR6UVltw0Gn8qf9b5tawnrnOn8WikQsDFEArnkLXeUgeymuiJzmAOfm
 zQTBn/Rj5Y/3CSeIbmi8NfgYw+jG+Hk3syyRdY/h99W6hDUYGB0Vy2nSKAOeVC/O8Jiv1DJaqW6
 lIsEXqGjC0jIp9cuhs6Nal8Zd2l+xjH1Jq1TaeJ7ryrX0Jh9MbbUIkYcEYn6/5XRJSAIcHTHbBg
 NlolwiNj5UoPigrZzgdRm37vwW8Geah/70V96th9xko14B7V16J3YOkg==
X-Received: by 2002:a05:6a20:12d5:b0:3a3:171f:6aff with SMTP id
 adf61e73a8af0-3b4cccfdeacmr8589460637.2.1780718786106; 
 Fri, 05 Jun 2026 21:06:26 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0bd337sm9412553a12.29.2026.06.05.21.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:06:25 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/omap: check IRQ wait allocation
Date: Sat,  6 Jun 2026 12:06:20 +0800
Message-ID: <20260606040620.13-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

omap_irq_wait_init() allocates an omap_irq_wait object and initializes
its waitqueue and list node immediately. If the allocation fails, the
waitqueue initialization dereferences NULL.

Return NULL when the wait object cannot be allocated and make
omap_irq_wait() report -ENOMEM if it is asked to wait on a missing
object. No wait entry has been installed in that case, so there is
nothing to remove from the wait list.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index d0f895c43ee41..e0fa9617a3d30 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -46,6 +46,9 @@ struct omap_irq_wait * omap_irq_wait_init(struct drm_device *dev,
 	struct omap_irq_wait *wait = kzalloc_obj(*wait);
 	unsigned long flags;
 
+	if (!wait)
+		return NULL;
+
 	init_waitqueue_head(&wait->wq);
 	wait->irqmask = irqmask;
 	wait->count = count;
@@ -65,6 +68,9 @@ int omap_irq_wait(struct drm_device *dev, struct omap_irq_wait *wait,
 	unsigned long flags;
 	int ret;
 
+	if (!wait)
+		return -ENOMEM;
+
 	ret = wait_event_timeout(wait->wq, (wait->count <= 0), timeout);
 
 	spin_lock_irqsave(&priv->wait_lock, flags);
-- 
2.34.1

