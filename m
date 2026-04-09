Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72502E99040
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A498D10E8AA;
	Fri, 10 Apr 2026 07:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b="gIEy1+dV";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7770810E025
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 22:06:06 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-56e91f17a99so942376e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maestretorreblanca.com; s=google; t=1775772365; x=1776377165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UJeH6RtMb1r7hYjiCIqngsDZysBaqS4Men6MeG6eUjQ=;
 b=gIEy1+dV2ouS4pixgTK0zU9LHXlzeeHIec05ydyV3E/3tu42r/84bvyzjXiHcmR1Av
 JZDXdL4eTYCRwW8qSCEw1qHgvdf4YfszwyKPbmUTvTkdSU7B579pycuQJ7n7n2OMLO70
 ENcK1AYXd0kjj3rFVzt/wSw/xA+MVhfyQ7MhhW5XSqDpCS0Uz5VeI4cmdwoAYgokJ0Ro
 O8NYhUTNraSQULJ76cq8uHgZGvh60Ki9Qbwe27rbCdVAktrsh9er4KTT6CVBDQfVdiTS
 ESGmrEaeaDXjHmrxwFxdQz77c/kCYlmVTFqTK7AQKSJ4Qgt+riJ3Ju2EB76bRsvCHGlS
 g1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772365; x=1776377165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJeH6RtMb1r7hYjiCIqngsDZysBaqS4Men6MeG6eUjQ=;
 b=ZHgUFTOc8L/tQS8fb/tmkD3/Yjs7rmLn2cO5pTbqbVRbw56zi580DlwIgGnAY7XQZs
 f1AH4iTis1hKSaugKHOzlZjJLNBOJUk08KBzyi43Y5HWr7RhJgODJNph2GhDjEgxRp8n
 OD2HPCHjnigcDoxD5Kdw/CBpPzISuSqy1AHKSJFVP24NyCjF4hClwWslO7o2+GPIp0gE
 HAEfd41d+Zx9MQ+al0bj0zmrK3axCiaMxZFjrk4DwP2xYPd4uI2IXrhcfYiMYp8NJI6S
 L6KI/UPx8G4q3w7nC9XbyUV9M9xuKJaCQzV8X5TCeKCxCs6+2SlovlPC959e7wJoC3Gd
 DwzA==
X-Gm-Message-State: AOJu0Ywi9Rd7S/qEdIh68FX8SX5W+qgP/Z3Mj6vh5w5q3nES2UQP6Hx/
 uDwlDhVx4j1KRSpCc+tqo+KCspjZN36UTypF7g3eZBkoujgacK64VO5iVH2zAOHkzws=
X-Gm-Gg: AeBDietV/qT7kQcGS4hoqvXtRg8G4GCTPE7auIWe0EszSVRmAoJhoaCH+t6iWnuQJ5k
 4mkNdysyILmrxcadfdQE/ynCeYT9Kod+soWRI0kNMTyTMNK83kzu0y/pB+/KDIy2KSgXlnRvXq9
 ET8vIicKlIGNtZW7lFzTvSZAGkEjsEXYoohZfSgxymhJZyWX//7nd2M/YogtSUMqfQrkdFhuNLx
 9iS08nfgyAWPkevPXrCGjUjKk39KCjE7qgyOWSVhsfr9SjAtGlcBbVg1/VUA3ALDHxGDL8Ru7rx
 dk6zVJtrTNagjx2UTHel74MCjktEL2eJbq+sWZtJfIQrn+tQd9R+iXGJrg8WXZ4yrR4MzfVbIm7
 Snb1v+9mD5HJj3knRjWj0NQcMtpS0P4q71YpSvXUM1pgjv1WMh6h0RWTxOz+SxW4kmUky1PL4L7
 +cnCCjpPEpktuwpIIUUfkpNVa1oPiceCR/oUcL7Vl0x/dYP8a6cdA6q/OznmCHjd9IOq3YPRe9f
 L+RmJU6RFF8
X-Received: by 2002:a05:6102:441b:b0:609:4d86:77b with SMTP id
 ada2fe7eead31-60a00f39005mr322622137.24.1775772365160; 
 Thu, 09 Apr 2026 15:06:05 -0700 (PDT)
Received: from localhost.localdomain ([181.199.46.166])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-954e0c7acb1sm550786241.10.2026.04.09.15.06.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:04 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH 3/4] Documentation: gpu: todo: fix typo 'themsevles' ->
 'themselves'
Date: Thu,  9 Apr 2026 17:05:58 -0500
Message-ID: <20260409220558.98547-1-francisco@maestretorreblanca.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:49 +0000
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

Assisted-by: Claude:claude-opus-4-5
Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 520da44a0..e37113478 100644
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

