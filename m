Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5061BC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEBE10EB95;
	Tue, 21 Jul 2026 22:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aw7t4jKw";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14AD710E64A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:00:39 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-caf707e3a70so2814702a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784620838; x=1785225638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EUoxqHLdj+77vde6cXsx3VoHDs2jRtpNGWuadNMVcE=;
 b=Aw7t4jKwELGBQ+wp1a8mIeKtpePTk5pkjVhbFe0td7vpEEmqT7aVgkG6IMWkYnFYqZ
 lp5xlvymTVcGNb2sAc98Cfs+NzdEgAL+UM5J/QtK21kayZqM+3M23HZIEYoCj8rRe85Y
 NTxFPFfi0qopNTjfga4p5CXGph3vU3BS1yNAnC8184rebIz8xe6IFO1qgTeJsxe11Sm5
 fE8Oq7YHC5BxMNIs+4/KaS0pM+b6OhsnV8MCMJWjK/JRsOXKP6QroR7CI55TqseGXNs5
 rIiHixrE/x13G3XYt7lJOBhZjlYoXzV81HEQfPic8T8C/meGGfTBH0tx7qa6ResYvLWq
 sPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620838; x=1785225638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EUoxqHLdj+77vde6cXsx3VoHDs2jRtpNGWuadNMVcE=;
 b=LMrPrm7S2uVo4hwU9/2ZCMkWCIat6jVauYK+gXrasIvqyHaAc7yhmSVnhXIfW2IyQP
 D5+gO2nKBRgPrj9OBjvLmDRpr2u5ohTL9/+c34HqrY4irYsZg6n8SVEuRXdJ3by/oTaB
 cnvy6ChozTkz75bjM9BIhOLMcpn6dqKRfdWdiRUukHoyoXIKZuHfBORqmKZyneFWZqBp
 i00MtH5BiAIUZFDk27fEB8Zsu2Nqb1lFrfS1TCIFujj9rVxGUqwtJGWLdYD+24ofFH83
 zY+Xn2VKoi0VVjnPkDZdmFYNyDRs+JEqOD6MAYCqeaPs5n7kXvDwy7W5CHDFO13GKT02
 Gneg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3a02/x+66mnqCmMkxMTFcWNBJZwdRsmUUJnOzIQCNU2XvbDfmEupwvgh7jzXe3EFPsa8LlRow0A4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyP3HMQSZZ4o8wF+HamKKbV+XZKRrvmN07ybQQcrTfUkPZv0DxO
 p8MkCwaL9DbaEQ30qiynXclXu4T1ZWfd4t5twHZGTkaWRD24Ft7iAwyh
X-Gm-Gg: AfdE7cmrcKGTaG08P84HBHSx13wya5cIkHIECJpEx2r785cU4Kag0bVqLgt+b8vr99V
 15XyxXyQWfh3YSnyKd0lVHuo6lv9RzIBYfSNwGLsJ/8fYmHg/Fq+V6ASG4J2r/fv3bLZiJzSsxh
 dcsjO/UabbdS2vRIJ8hQgCXQncgAGSSpxL0qYhpDysaKzf7L8N1U5wzhB2ueKbDqqFlnlTru78T
 MWPi/tH5KCUwxqngq+CmN5NoOX8squUr0QCRf0r0VXzpaH/ucf/65+AvJRy0DS9z9xTC6meDCmY
 0jR+6dR8pqMigx1wcdYu77zXi+wDJ+D0eJ6Dnm43YA7OymHsTrdyVao7vY4vDJA7Bi2hA+RuTCs
 lDQHY/qMSAhX51CAmCrZsv4L4duA82mWEusSkLfWYZgkgY2v34O5afVeiT4LjwUCE1bT3Tmj7fE
 X1738igV+2o7m7HgzHFMRc+lOtdQLhSMlzEEoOiNSKNYWE+qvmf4Ccmw==
X-Received: by 2002:a05:6a20:d52b:b0:3b3:ccd0:cf62 with SMTP id
 adf61e73a8af0-3c38dc16e15mr21552249637.36.1784620838417; 
 Tue, 21 Jul 2026 01:00:38 -0700 (PDT)
Received: from SaswatPC.localdomain ([45.123.221.191])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d093bd8f6sm2891921c88.4.2026.07.21.01.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:00:37 -0700 (PDT)
From: Saswat PC Ubuntu <saswatjungkhadka@gmail.com>
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Saswat PC Ubuntu <saswatjungkhadka@gmail.com>
Subject: [PATCH] drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove
Date: Tue, 21 Jul 2026 08:00:28 +0000
Message-ID: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

vmw_goal_waiter_add() and vmw_goal_waiter_remove() have had no
callers since commit 'db6a94b26354', which removed their only
call site. Their sibling functions vmw_seqno_waiter_add/remove
are still in active use, confirming these are leftover dead
code.

Signed-off-by: Saswat PC Ubuntu <saswatjungkhadka@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  2 --
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8aba..d84e077ed 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1026,8 +1026,6 @@ extern int vmw_fallback_wait(struct vmw_private *dev_priv,
 			     unsigned long timeout);
 bool vmw_seqno_waiter_add(struct vmw_private *dev_priv);
 bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv);
-bool vmw_goal_waiter_add(struct vmw_private *dev_priv);
-bool vmw_goal_waiter_remove(struct vmw_private *dev_priv);
 bool vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
 			    int *waiter_count);
 bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
index 05773eb39..88c77226c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
@@ -273,18 +273,6 @@ bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv)
 					&dev_priv->fence_queue_waiters);
 }
 
-bool vmw_goal_waiter_add(struct vmw_private *dev_priv)
-{
-	return vmw_generic_waiter_add(dev_priv, vmw_irqflag_fence_goal(dev_priv),
-					&dev_priv->goal_queue_waiters);
-}
-
-bool vmw_goal_waiter_remove(struct vmw_private *dev_priv)
-{
-	return vmw_generic_waiter_remove(dev_priv, vmw_irqflag_fence_goal(dev_priv),
-					&dev_priv->goal_queue_waiters);
-}
-
 static void vmw_irq_preinstall(struct drm_device *dev)
 {
 	struct vmw_private *dev_priv = vmw_priv(dev);
-- 
2.43.0

