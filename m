Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846E110F0A9;
	Wed,  8 Jul 2026 10:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0TQZORo";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF14D10F0A9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:51:25 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so408372b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783507885; x=1784112685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4A/oLhgrzmAdBx1StZRZebeEK/bn7LhBiB+cKgJw7kc=;
 b=D0TQZORoBlk89qzg19zwMxMgh0xdXQND72MVGlWP9PtpluhmxqTEJYcdXK8o+4GlJC
 WNzUWa6Xjm2iCtgbZh9FOUu0oIDXeO7+bcVBH/huplLBJbWB2bkI/kijIfnOmmtvjzOf
 Uf+0xKQUiq39GaxevmG++oR05Zrs3KCchwc+3UhqcL5dtctT1h8sV6OVKtf+DZE5voh/
 74x9jOzBApMiaz9UxphQtWWQ6hfL9QQgQ94WeTQj6PaGIN/BET/A4p7zQ43cGUitM6lS
 tKVm9c8/2Fj1ZAOS98FbHxVENrIoL1QWt7zMhUemtnNvA/iPA0Flew9Ec5PipCyvp9En
 03jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783507885; x=1784112685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4A/oLhgrzmAdBx1StZRZebeEK/bn7LhBiB+cKgJw7kc=;
 b=Z7iXKXxNUx683nzPtqzcKW2/cnftBuWt3tKayqCi/kYMCDvZsTXQ2Z+wfmBCx8xqXl
 iaZxz8NcT08OFY98kP4qkxhOgi95kTz4x+vEFIScaZUC1Wu8mkd8SICxRt9WqgGV91Ky
 41TGxVdSBTnZQRmJGR2I67atZSeoGaQM0pGnRCYQaOKttUvOlNKcuAW4RGCLR6NJfKhl
 70pyc+qc1bhIFU8OJF/Q0NIoxqO26fFYMSFGYmCjie5RphjAOp86acShtRz2wWVzOQyg
 I8lpsbU4IORRN3QkDQoXtVWVUv/HYpztAgQd7PYGZr0y9i4plFDieqbXXD/yCEc0JAVS
 w1GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDQWaqLU/atsXTt7i2sA5jic/NVuXvduP998vI9OFAL/9bfWjrPvYXSWm/w3dxBWQxxWEnv46GGdM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxZVmL2tFWVXDsAhPC43uxQvv7gVCms1MDoIXx6l/9xUKiwsuT
 nfCnKSx8Ozwt45IO159dpLTwMRWU3gSAlURwYN85bVLafxmPeR7Bujdj
X-Gm-Gg: AfdE7cmg7XtrhgDykPYrAcjWLc+whep4kxD7BmKEkC7qYsordqP5ypuIeI9FiVosVnp
 xPocvFrMI+b4FYBiuI9X9r3bVD4pgf3uCkSo+fd9fcNsBteMkqvL0BAyRM3l+nLzJ9ecnRU+jDZ
 gzKsCiP6+u0cITJp/1CkTH9E1INKMKhibC2UoNQCslHygHhUesYs4ycsX8f2W7duAgjO76GqzEH
 RgS4F58+WgvbHQbJ5ttmXSbS4DU2YN+tsPAHutJIzm92HgIabDc4LTDGFgvblWeU+HuEEbibHlw
 noSgMoRPyyXr+l3f4DnSWMoVwYfP3DcL3wG6g/DT5F6GAsGGAWQrhTqwpW7KAONP7VYhjmVIU63
 Ph9Evhfks7AJ7+B1b5Q92jY/bxSZyeTKJQJmEkyNQovbVLavW8StAtPSAYlM2HXSfAnSiNtcjqA
 sjdQ==
X-Received: by 2002:a05:6a00:1795:b0:845:cb04:9cbf with SMTP id
 d2e1a72fcca58-84842fec8e2mr2316101b3a.39.1783507885324; 
 Wed, 08 Jul 2026 03:51:25 -0700 (PDT)
Received: from lgs.. ([118.193.39.24]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-848429d65fasm862430b3a.51.2026.07.08.03.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:51:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Oak Zeng <Oak.Zeng@amd.com>, Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/amdkfd: free MQD managers on DQM init failures
Date: Wed,  8 Jul 2026 18:51:15 +0800
Message-ID: <20260708105115.746474-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The change referenced by the Fixes tag releases the HIQ SDMA MQD trunk
buffer when device_queue_manager_init() fails after it has been
allocated.

However, the same failure path can also be reached after
init_mqd_managers() has succeeded. At that point dqm->mqd_mgrs[] contains
per-type MQD manager objects owned by the device queue manager. The
normal teardown path frees those objects from uninitialize(), but the
initialization error path only frees dqm itself.

Free the MQD managers from the initialization error path as well. This is
safe for earlier failures because dqm is zeroed when allocated and
init_mqd_managers() clears the entries it rolls back internally.

Fixes: b7cccc8286bb ("drm/amdkfd: fix a memory leak in device_queue_manager_init()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2e010c1f8828..be75fd3a9acc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3103,6 +3103,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
+	int i;
 
 	pr_debug("Loading device queue manager\n");
 
@@ -3231,6 +3232,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
 
 out_free:
+	for (i = 0; i < KFD_MQD_TYPE_MAX; i++)
+		kfree(dqm->mqd_mgrs[i]);
+
 	kfree(dqm);
 	return NULL;
 }
-- 
2.43.0

