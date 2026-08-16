Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874ECC5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7525F10E2D7;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5PAhPxV";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D9210E296
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 08:52:50 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbee3777e1cso1283303a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786870370; x=1787475170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3t5V5/D+/g818Z3TQJ3FpKYZkU43EH6Jl8hrdpQWuYI=;
 b=D5PAhPxVSKOp/h9b+7CoQLtFbHPzA7jXH7at8EUP2LlRUG94Y6EXLtro/yYvaIFFul
 BXOmmW8V3F74J1u/O0AXzGsKE6R4Z+dOlNpF4yaHt11xvD7OnLoYJFXSHRvB78ov/6o9
 vW+Ve14BmbLK/wLtM++GKERRsWZjh+gtuyugUTnqu3Yu0Hu35st3vgRyZ7+zmedBS82i
 c2HZiEcV4/2H2DVB5SM+Hz7LlYnktsHDMutLMGUiVuMmTUWwvUE4bVF+DX1hZv9K01V/
 g5Kv+FiqvpnfJo//RHckk6D6Dt4rKzPvEbwNk+9WLr+c4KzR+bsIeaYOMji2Dqx0XhYS
 J/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786870370; x=1787475170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3t5V5/D+/g818Z3TQJ3FpKYZkU43EH6Jl8hrdpQWuYI=;
 b=IEDKOFjz3RtIeCfFbLuQhYE+73Id2m+IBzDV39q78mMXOBwYtXVYtKwdicDwvp6sH4
 43Y8iBlKCEe8NkzmaXjRW12IL2Td9QxR6ZKC6Q118yOgSvaT/KwHJO5wiTjUa2XbJ1GR
 yR5cX5n0+eUzudStCmvcPZYAEdtKGXJruWjY6VOR2Wu+dEMmuYBnita+XMrecOVYNf1E
 e/Lr2oajY+HhTb9M3vKSsAicv1fYw6rIPJd7a33EJnBdcyraiVNekIhTRtgMNMRVL6Y/
 nNMq26ovKFkBmgapM2ef7svuGg+bxwwIxUypA+M48CK7Q24CL3lB913zx6KGDIpbMDn3
 VdaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV7QKkxzVk5s6FZr2WxlNzbol1FSAY8wVjO59fcATpe9qiGaIV+kC6o6enuyuWImvmhdOLGbWSAOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgWqmXHZkIpt0oiV4vp7Y2GM2QbkarfqBP7SaUHVf3F5yBGev2
 6CMvVCsYcai9Kz1ZRLjjJKpEZ0dZmr0e+yICTyHkmoNXGSMyZEP3+BcX
X-Gm-Gg: AR+sD10KNcJLGxnKqxDU8Hdk7FQcgzMMU6/Hg5XxSGjmctUf9IZcRdrxSXNrz23ETSg
 82e6PdiGdSMa2P09G6v9fWEKFvAIPK6HRWggyxSbUodawNmUIHhDoEZUAfwh6267OwRMDw7pJw3
 KcYXEtkfgJITWm55jzm3GPcRoUJnqtORVPRjkMuk2+PXoW3lKAoaAHmAdmBFK1TeJP+0KUZq05c
 3W+D6+170Gt//dLxXt9b8CjGvLJWLCV3VKW1nM3CgVLGSewl9C8Nf3Dpjv2JU5x83kHfmzyz3rI
 6tIAA9FMBaHU9JN/cMmewd6tqYHXnx5iv39/BH7FSxWafYMKDB6hk4+pCFA6Yxk7TxIyuNgZM97
 KarW4OqY/whJcVvJDaFxscJJeAmyRnrMdH2+9AoMkQru8e2kTU/cGYm+hYbr5+Vp8nACoWqX3Id
 QRWk1l4scGpf8SoyAnMpV94zO9TjEQqHlIkx6Uwp7mg5KvQHyjsBDBwZUwYOe4yLJWkqji3Z13Y
 feVn14dI5z6MVk2rvl1RsFznI5S8AJYUVAUUVvRkwFx8CKTlSNzhruU/NYp1wH1
X-Received: by 2002:a05:6a21:7702:b0:3b3:d0f:7883 with SMTP id
 adf61e73a8af0-3cc7196eda5mr21211407637.7.1786870370284; 
 Sun, 16 Aug 2026 01:52:50 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10..
 ([2405:201:682f:383f:3194:7c7d:e0ca:9186])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388b2554sm40425821c88.14.2026.08.16.01.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 01:52:49 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rubenru09@aol.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: peter@stuge.se, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Subject: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
Date: Sun, 16 Aug 2026 14:22:34 +0530
Message-ID: <20260816085234.22053-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

gud_connector_add_tv_mode() reads a buffer of fixed-size mode names from
the USB device and passes pointers into it to
drm_mode_create_tv_properties_legacy(), which calls strlen() on each one.
Nothing guarantees the device NUL-terminates a name, so strlen() can run
past the end of a slot and, for the last mode, past the end of the
allocation.

Terminate each name at the end of its slot before use.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=916c888ba5f1a54c9526
Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/gpu/drm/gud/gud_connector.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ea0cca58b7c8..5c0065c876a7 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -396,8 +396,13 @@ static int gud_connector_add_tv_mode(struct gud_device *gdrm, struct drm_connect
 	}
 
 	num_modes = ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
-	for (i = 0; i < num_modes; i++)
-		modes[i] = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+	for (i = 0; i < num_modes; i++) {
+		char *mode = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+
+		/* The device is not trusted to NUL-terminate the name */
+		mode[GUD_CONNECTOR_TV_MODE_NAME_LEN - 1] = '\0';
+		modes[i] = mode;
+	}
 
 	ret = drm_mode_create_tv_properties_legacy(connector->dev, num_modes, modes);
 free:
-- 
2.43.0

