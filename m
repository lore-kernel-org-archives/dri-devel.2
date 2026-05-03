Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D94CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7C010E963;
	Tue,  5 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b="LKVcKCFL";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F80910E153
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 00:35:49 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-56efdc96b05so1980544e0c.1
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maestretorreblanca.com; s=google; t=1777768548; x=1778373348;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FsEMKzfoD4c133zpx8hGdf13q8ngaH5mIvb0VTrDGQ0=;
 b=LKVcKCFL2urJaftfPDeC9/p/d0T8pHeBDkiyzUriEZiNNx4/vF2KKOs0+EYH+6PmNS
 2eivLkTvNduha6Zn8c58+W+cyZsB7mt2MscoAXB3laRfY7WoeY5LSjMKtI4ON29Z1bpN
 BtZlIyEFQtmkYohYOGC7R9aJdMYbCpqu7EVcH5culNWuFHF4r8xC56qL944ry1mdts3J
 BoCw2PkXkTO+V4e57h5kptpRPZEw2XJzqFGQ9AkpTfT4NpK0l8iJEnptVBB9pE7JcreC
 Ehj9H6PI6KOSk0gB+OLBRMiP5EN8zCnTLawAj/RB/+myUZ3HLcYI5lG1f2dZP8Gkf/Mp
 usMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777768548; x=1778373348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsEMKzfoD4c133zpx8hGdf13q8ngaH5mIvb0VTrDGQ0=;
 b=ajLjCim/90rgqTc+p2sOQ14VfXKXj7p5q9EdgxhH4JBWpEoTM7ma/9Sey1ZT/1vN/S
 +393k5OJnLIYz31SNqNU3hK3y7t53BWK216rTJkide3RBVrwKHwiDKSQYhpCJVhvH2cM
 gpXnU5KJLFZs2/OyTIdvJc84XrIudMbrRpebkUXwuV/fJ7yqvZTCL51csGmQ9wAUuclu
 FXoJjcMIOTGfDi4gDc5kjToWYDgw444bt/sGCyDUBE3eouD8PHQm50i3JR3bKQorUbzS
 BSr+YU9Y6/iDoGwHWoXDqEgEVtTrLkN1O/5PLJlUiIdhIjUPT+H8Ai7vXTJrbxpZ7PvA
 G9Lw==
X-Gm-Message-State: AOJu0YwTZcmVjK8rrXFnQh5JbOGbw2gF3kz0BqrbdEoGkBqyFJ7RSE8U
 OZjCMV4tXuBf4+qnRbS0enotWANzQg/QeF0UBe1WypFv8G38vb7AQ+fgsgiviMvXcGA=
X-Gm-Gg: AeBDietweUeDHx+Jd7Z+bkUdZtpPDoSXLmoiM8NdjWuSeAWaFUnYS4ZO/QcTq4FOUgF
 QElncwE2R7ui7szWVujOLWeO5LAlu/n0O4+JwnAzouk/a9MO77Bln+HbtvMXfm7K9PUr5EKO8os
 eh+LjwRdRMYxN7CmtXpKOy6UMMweKrmEA0av4nornhKG8cLP65PsTblsojrYiaPnxyZyrNCi36N
 5IWw2aGl7k2d82aPp4yg9FAS2biKsTxqW3+4Ngz+5zWqa+IFoadrdLCAXR5f4nnomUe4PXAnqw3
 oo6WvoJ7w0SF/BI7JqJK6PD/Gamuu+rsBT1A7PY7of4ktXGb45rBWMVPq2myRrWipDURZu9JS7l
 dmVQ+/vRf++TsANqxZWnsyPxSS+NtOE6lVP6rlsOQgZK+CpVEfXpWPSqX44IBGXVfYAVWgiL2Ob
 0RCgDIWdDRbnCZQRXitGtzPLV046ztqDW96QqxznnYXKlJQaJc1ffZG37xIUZKFpx1d7BlNGsUL
 jNApX2kyS41U8oSsPhG1JY9CpyEXvCAf+M5yA==
X-Received: by 2002:a05:6123:4202:20b0:575:22f2:a22 with SMTP id
 71dfb90a1353d-57522f2184fmr73280e0c.10.1777768547972; 
 Sat, 02 May 2026 17:35:47 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-574970ee582sm4201834e0c.0.2026.05.02.17.35.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 17:35:46 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH 3/3] Documentation: gpu: todo: fix typo 'themsevles' ->
 'themselves'
Date: Sat,  2 May 2026 19:35:41 -0500
Message-ID: <20260503003541.62584-1-francisco@maestretorreblanca.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

Fix a spelling mistake in the panel-simple/panel-edp TODO section.

Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 520da44a04a6..e371134782f8 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -456,7 +456,7 @@ be turned into a WARN_ON() or somehow made louder.
 At the moment, we expect that we may still encounter the warnings in the
 drm_panel core when using panel-simple and panel-edp. Since those panel
 drivers are used with a lot of different DRM modeset drivers they still
-make an extra effort to disable/unprepare the panel themsevles at shutdown
+make an extra effort to disable/unprepare the panel themselves at shutdown
 time. Specifically we could still encounter those warnings if the panel
 driver gets shutdown() _before_ the DRM modeset driver and the DRM modeset
 driver properly calls drm_atomic_helper_shutdown() in its own shutdown()
-- 
2.50.1 (Apple Git-155)

