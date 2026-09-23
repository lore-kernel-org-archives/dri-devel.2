Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C568110E8F3;
	Wed, 23 Sep 2026 14:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SNlPCIbe";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A143C10E8F3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:50:28 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aa8d881so1126676d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175027; x=1790779827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eD0K6ebb1ULiIBLcq7FlBP1Yj38L0of+tai0gbVPhVQ=;
 b=SNlPCIbeyQybgB5PooT6y6zpU5yx9Lsw8YpTZMitZpABskI4ttvLXMmPmAPhYzf06H
 j7wWv4/KbnpmV9dw7uMdyMi4FBc7xrXv3lG9wj+P8RHrbXkMdIuSABXXOTG+Dl1shNYI
 NH1JExo9f8Tq63EwOrWpSKAkoAjem7kEI5OQSK0V0Z0vcGNMqgD4r21VDmPEFsezUWZP
 hHnIZgAUsO3UOmzRXg611GabIuI1KQpbn5UMu7FLSMhgoAJUmky6Bh0uGFzGiibG6C84
 huyTnBz2+Byam/s8vDo+CQ7xNL6wFyfDxgOjspcxmqNjvW6Gq3p2HQpaBDSw6cksOuau
 CZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175027; x=1790779827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eD0K6ebb1ULiIBLcq7FlBP1Yj38L0of+tai0gbVPhVQ=;
 b=CGu2uLa2/x6G8psNj4qWB+D88SAXxsCEJv4WcBXZBIIwAPzV4kdyDfjYSzBXgXxF3X
 qk6nrIoEniaJfz/oqI9CFTXgocB015lHZHQlxx7gY/PsD1MikaTED6k/HvXmhxLBLJLg
 sbY7R4+wDv3IcAiFT3+NiEb6UExA6jKKa/40YrpFSadYjtj1BFRD0mM4Q11/TLCJo/gn
 LhFPGfBlCxKbajiUr3N1Cc8OPsXaY60f8LdHCHJEn85Ennq7tPIuEQo6dCiW9F2gu576
 ejv43mdzkfXHZL26deiKxibNWsjmTMlizK0v+C+FHPygys0sSD4RjoV2l4KFIWulRKmd
 Cdqg==
X-Gm-Message-State: AFuF++m3WbVOZfMJOTJ2jXyCOooxXGbPdFhfcrTzi1fpT+AtobIkdMzD
 yZOXIUC308AxgxemlfNq9ME9JG5FFg2yak/G3tuBLR+wLud/NvsMVhI+
X-Gm-Gg: AYBFou2SxlAzc+1W0U5eJYDY/qUSV3i4+8yTgs1ubKRgFvdEmun9es7Ghjkj/FgvQLC
 yYYnUXspxBFgBiIIcpQ96INyxiCAS7Jyl3PyBRkXWI58jxt6ds4famYsH1pkHTjp29ue8/c++k4
 lUhh28zm2DtcGHEzDfUHZ5L1RRtEuhW9jo9Qn8plq1d4KP1in/WXmLY8fMVdByc5fVuLgN232Qo
 2dQQlzoE7KvEYVwrZ1/IfOALe93cM0Y+PwK76VDwIk20zibML8wl9wdg5obMmD3wbB5iehXbPJu
 Fu+63F8WtWlfFRy8bZ5pE4tc9CZ3asgIXmUoBKNg33rnU/FzHNBOfvBmze3mZSudxPwiCwxf5Qk
 RnECvt9jnf8cTMQ2r8LmhxPYG10b1Lvd8sBGExgQ6bI+RSRcyMz32EP4ko4VJYi47gYMMbYm8LJ
 FWr3LHbmdUsyxtTDqbb0uLaec2wIapcWWET+Oyn0XQQ69e+NvGRmlrfBZqh/Jk5/8XqulA31mIy
 A==
X-Received: by 2002:a05:690e:b89:b0:66f:c1bc:4028 with SMTP id
 956f58d0204a3-672d5927cd5mr1726179d50.85.1790175027355; 
 Wed, 23 Sep 2026 07:50:27 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d6ab6720sm1056729d50.0.2026.09.23.07.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:50:27 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/qxl: use correct offset when stamping drawable mm_time
Date: Wed, 23 Sep 2026 11:50:18 -0300
Message-ID: <20260923145018.1244740-1-qwe.aldo@gmail.com>
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

qxl_process_single_command() maps the page containing the current
release slot and copies the userspace command into it at the
release_offset within the page:

    fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo,
                (release->release_offset & PAGE_MASK));
    copy_from_user(fb_cmd + sizeof(union qxl_release_info) +
                   (release->release_offset & ~PAGE_MASK), ...);

However, the subsequent mm_time stamp casts the page-start pointer
directly:

    struct qxl_drawable *draw = fb_cmd;
    draw->mm_time = qdev->rom->mm_clock;

This writes mm_time into the release_info header or whatever sits
at the page start rather than into the drawable that was just
copied. Apply the same offset so mm_time lands in the right place.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026..e7594d1 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -188,7 +188,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
 	{
-		struct qxl_drawable *draw = fb_cmd;
+		struct qxl_drawable *draw = fb_cmd +
+			sizeof(union qxl_release_info) +
+			(release->release_offset & ~PAGE_MASK);
 
 		draw->mm_time = qdev->rom->mm_clock;
 	}
-- 
2.43.0
