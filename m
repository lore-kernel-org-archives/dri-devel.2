Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D677CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BA010F1A0;
	Thu,  7 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JnStE8qJ";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC3110F2F6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 08:44:20 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8296d553142so327524b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778143459; x=1778748259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yzgFngjfsKygSLsXg6rWfkZ9Vqa6LDc2D4netmtnYM8=;
 b=JnStE8qJ0wjwDfcDBp0Jv+LXO+BeTO6ja5iO8UbRa42cOINImbkUininMmmU8wcEDY
 WKwH1t1iMt3yEhNIBL693GR6AGHVl1tbRSa3b0PdIuz7mZwSqUf+iKQi3zq9VKyd4npL
 I0CpE3r8YNlQ7sXmLgAT4lA0DeB3IFWHxThuyIr/5CGoil9m8AwS7SLDAJv/Dt/OTbzy
 4iY6QvUPTI8deWGfss1BEqBxUYzzSA079VLRC/UIn0XEQGB2utUlRjslp0IG6QjLPx++
 iQnIg9NtKEPqjJOWlfQkBx/wUY0ipGBCGEWKCywONqNmzuUl6bZeiZgj5FmwJ3bfF6JI
 jtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778143459; x=1778748259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzgFngjfsKygSLsXg6rWfkZ9Vqa6LDc2D4netmtnYM8=;
 b=bvgFOSEiTnLfjDkgmw/gp7HiSCEFh7cAkmYB7xosY560/ctbhezA8Z5DQDIPz3dE0B
 4owFr6fy0fIUAGLDVxkBbHDtnXkXTgEEeNhtBK8u334SSlaEKAEuOAW2leMtw5ExKQlj
 DahkCw0rc9fKfHj6p6G46G/UZezwq47IKBH5Gx3XKxPbanT2+aqzRbrJ9gjG2KvB333z
 3t8o/MpJyhVGH0YqvMnviqG0p/8C9NrVVOyxFYvuBHSQua+Odh1z/cybjYKjT7xVlXUM
 C7c7HAKso9q6L5rnAhrp/BQGdLsI94baSO6Ydj/+NCY/ws/KVkodD65C9eagt9ovmHHu
 sooA==
X-Gm-Message-State: AOJu0Yxgfd5XvshHK3qqLQPJpBW6WCywx1DDEu3rUlo1WZvtIYJP/+Dk
 lzoAVFwN2r7fRAMsV1Fng4OLX636g1agxBOHjFn8k6zYuKV1Z27GqZbiC7BZeMs=
X-Gm-Gg: AeBDiesYO82RZs6Rw8PYt8yRrnF/2pJYS391d4Uu9b2O6Tq8YdBI/DCq74dgpAjDQig
 Vmm5s8uAcyJI1p3l7JgAIlX4jpvaCwyVUcTP+WFyh6+H/bgEWbEYn6xWFcUPZVVYc6xL8w+mM9r
 nK5StDea7VaCwAGHQLWBsMP4Y/oWuUJ0vBS4FmGgE6u2OkjnAn4jqVEe01ekiI8HtL3Jl9HZVRM
 GK9oNcyAdoQiO+4ffJJ/I2qA4DBYVSCmsivzkzg7rS7CVShVDx2rSL1tLDARhFW5nBQNAcmBsc3
 8kutiiTKl9owrhElNXj9T+3eoRSjC4UIsvL/zxwTegKnjfTSRIBWmSxm3UuyP6XJxjvN2FeUPJU
 mKoWmkHo8Ggk4WpyUeO7AQc0Of5uPXeWpRwTaHhBD5EjjuV6bneFO+aXra/uO+QaVrEqzJtDQW3
 aWKLYsh5me/QyJHA6EJn5PavjqcjU/YxQ3RQDj8S/lXIVKokZju53vG6S01i2ETWcOvg4GPjxU/
 6IRZCR4qv+xUg==
X-Received: by 2002:a05:6a00:4193:b0:781:2291:1045 with SMTP id
 d2e1a72fcca58-83a5b2d34damr7200606b3a.8.1778143459390; 
 Thu, 07 May 2026 01:44:19 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbcf36sm9989625b3a.41.2026.05.07.01.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:44:19 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, kraxel@redhat.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org,
 Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] drm/qxl: Add bounds check for relocs_num to prevent memory
 exhaustion
Date: Thu,  7 May 2026 14:13:53 +0530
Message-ID: <20260507084353.78071-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 May 2026 14:49:02 +0000
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

The relocs_num field from user-controlled struct drm_qxl_command is used
directly in kmalloc_objs() without validation against the driver-defined
limit QXL_MAX_RES (96). This allows userspace to trigger large kernel
allocations (up to ~8MB) and prolonged kernel loops (up to 200k iterations),
leading to memory exhaustion and CPU starvation.

While kmalloc_objs() prevents integer overflow via size_mul(), it does not
prevent unreasonably large allocation requests. The QXL hardware and driver
enforce a maximum of 96 relocations via QXL_MAX_RES, which is exposed to
userspace through the QXL_PARAM_MAX_RELOCS parameter, but this limit is not
enforced when processing execbuffer commands.

Add validation to reject relocs_num values exceeding QXL_MAX_RES before
allocation.

This is similar to the recent fix in the Xe driver (commit 6e61a2df9ad
"drm/xe: Add bounds check for num_binds to prevent memory exhaustion").

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026ceff..aae9ca636ae 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -164,6 +164,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	if (cmd->command_size > PAGE_SIZE - sizeof(union qxl_release_info))
 		return -EINVAL;
 
+	if (cmd->relocs_num > QXL_MAX_RES)
+		return -EINVAL;
+
 	if (!access_ok(u64_to_user_ptr(cmd->command),
 		       cmd->command_size))
 		return -EFAULT;
-- 
2.43.0

