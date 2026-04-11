Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80732F45A1F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 06:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C556510E06B;
	Sat, 11 Apr 2026 06:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TBRxtZxc";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDBB10E06B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 06:29:43 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4888375f735so26036835e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775888982; x=1776493782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Mp+f+a+GerC2oFr3qxw4PkE1viVQhwuT7MAD4+L/Nw=;
 b=TBRxtZxcvax85SXqM7Sv/EVIPeFsXL8EhHAIllaiYbCQT6NcMgoddcbHZmF4+imoaD
 T6JYqN9G2rilcyk8isyNcC/H24wSebNPV0k0VhFy24TBhEJFhS8NkVAaMSKWBtXCz2Mx
 of9+BePnFucfjiEwwxyAz+kh8BKH/RwNgjsa1QrIcipabr8fSctHxHIDMRNGQ0LqLiyy
 b2UOaDgCgcEt/ia/67i1dXnhfYNRfFUydJTY/6ijUR1mSHfXPKdx0h/qECc3EcFJgJgW
 XHBvi6VmdBzDo+DPvv5yWcoUGKJnxK9KCa8dxc/Ef39buSk+SyHk6G2FqCn13MLh2P8n
 Z0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775888982; x=1776493782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Mp+f+a+GerC2oFr3qxw4PkE1viVQhwuT7MAD4+L/Nw=;
 b=I597KqbfIQ6P5ZaQ/H2CWg9+1yUmWEdgzNDv1dnSwxGzmdYhJOTrm17bR2I/oaT/x3
 HBSqMPouAyzI9MrAEpNdtIX13hwDkxtlqFztn1v3+vUmWKVH+n0NRv6bvsworZBKQ6WY
 dmwieMJ9/uapLBDQhcKCJGZ28ZKQcWp0aPqnBCwi7mWJZsyqQ9G8dozPgfDct7JwCUbZ
 eV9K+vhzUZyQ+X3iRpOhvoL292bSCA2rO0LyRglNALsKZBkrvC+GWuOxyeqa5ApIguWY
 i2BJUzijT60+KV2jgP10V7iN7rQCYZ4krLKFNsXP3b7y50TWl87bnOO7i/aTQV+qmrWC
 nJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGdKCgqn8EOdzeO/ojSXx7vBYdmnwuwEDW5AtNW6Gw2kLFFZBrliA49+19CtbWk5xf3DgAuB5LZwk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwmwnmmprnQkue0jXLcjXCc7dBT4emYq8wjUoHwqXTZNC5FLu1
 ASBrKhnQab7OoAHfkqfIOuGVXdxK1zSKVmraTAc3oj2hDqjG/8fPtwTk
X-Gm-Gg: AeBDiesTiiJGI2dc1IjKnU54Ymq5veYQvQXUUxECRVeaBmO1C0flC1RRmS7dqM619V5
 Sqno2Rxcmd8M3x//24Q39S8BkFzZAW4bTZJEA3NjXRjYAON2amzMAyZG0GPgaxgTDd7nFZKe/w/
 O4pvyDV5jNdPBdAbvIUD4IXRnNtYn5m/cSY6uUUzy7hJVXL2bE9zuPjOpKUMyvRSLYnd7ijzniO
 FwLGtQhG2MM/W0PtPsyYZ6NcptN7dT4U3Nm7K+y+NoZWnco+1oFZFvgfRttfhe9YTc33zVdGxcA
 CfGmROgNjxSnLErZyqquFyYyGCQ9DrDJNXd8Ne9oUa4GkF52KTMy9eYWcVd1YVerlu8wq0mpd/E
 L8PfvrSBp7r3CmUGz75HPWwDx/KoGG6uXvcxJ8O9vyoEm2HGFftOabit8YllMApm7B0pgbgdLhG
 gEbtojP9Dba9uymptCxRqtjYtDCKzL39J6Z2/mS9+qcmQQfnIsg9U1xGhcI9IBP3YP+FZ5tBgaY
 WSNfglV5m/V
X-Received: by 2002:a05:600c:45cf:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488d67b8dddmr73834715e9.6.1775888982043; 
 Fri, 10 Apr 2026 23:29:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888a97sm149666695e9.2.2026.04.10.23.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 23:29:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: dakr@kernel.org,
	lyude@redhat.com
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal failure
Date: Sat, 11 Apr 2026 07:29:38 +0100
Message-ID: <20260411062938.22925-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

When aperture_remove_conflicting_pci_devices() fails during probe, the
error path returns directly without unwinding the nvkm_device that was
just allocated by nvkm_device_pci_new(). This leaks both the device
wrapper and the pci_enable_device() reference taken inside it.

Jump to the existing fail_nvkm label so nvkm_device_del() runs and
balances both. The leak was introduced when the intermediate
nvkm_device_del() between detection and aperture removal was dropped
in favor of creating the pci device once.

Fixes: c0bfe34330b5 ("drm/nouveau: create pci device once")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5d8475e4895e..517ff2c31dce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -875,7 +875,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	/* Remove conflicting drivers (vesafb, efifb etc). */
 	ret = aperture_remove_conflicting_pci_devices(pdev, driver_pci.name);
 	if (ret)
-		return ret;
+		goto fail_nvkm;
 
 	pci_set_master(pdev);
 
-- 
2.53.0

