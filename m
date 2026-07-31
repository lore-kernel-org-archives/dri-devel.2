Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86186C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC3710E200;
	Fri, 31 Jul 2026 11:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Ipc6bAWB";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654B410E200
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mj
 rd8bbwxSZ0QnBilVvAQFYg71SC/QaMqNrvLQDFIKk=; b=Ipc6bAWBpVPThOVMvc
 zuQTU/qc0A40dwNZv0WhstzbaInHCaRn0KPJ4f+DKaPqApgrFqn8TuwXcvfMKbK7
 MVBVYygwSb0gqbaT+P3FupoFQFOMLa6hMYJHknKADw18ramN/llPKCueN22BhiYK
 fU4PETst5arw6VYuZ/Bu43maQ=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgB39ZZLhGxqEmm3JA--.39364S2;
 Fri, 31 Jul 2026 19:17:31 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug
Date: Fri, 31 Jul 2026 19:17:29 +0800
Message-Id: <20260731111729.703116-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgB39ZZLhGxqEmm3JA--.39364S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Ary8Gw4UtFy5GFWfXwb_yoWDCwc_WF
 y0qrsrGrykJF1kuw13uFWa9ryakayY9FZ7G3Wqg393t39rX343Z347ur9Fvry2g3WxZF90
 v348KF4YyFn7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbxu45UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-Qvo92pshEu-VgAA3J
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The is_avivo() function has a logic error where it compares a constant
to another constant instead of checking the device parameter:

  (PCI_VENDOR_ID_ATI_R600 >= 0x9400)

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/sysfb/ofdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index 819aed466727..1d95df522ad5 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -238,7 +238,7 @@ static bool is_avivo(u32 vendor, u32 device)
 	/* This will match most R5xx */
 	return (vendor == PCI_VENDOR_ID_ATI) &&
 	       ((device >= PCI_VENDOR_ID_ATI_R520 && device < 0x7800) ||
-		(PCI_VENDOR_ID_ATI_R600 >= 0x9400));
+		(device >= PCI_VENDOR_ID_ATI_R600));
 }
 
 static enum ofdrm_model display_get_model_of(struct drm_device *dev, struct device_node *of_node)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

