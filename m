Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B888C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 22:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F80F10E0F4;
	Sat,  4 Jul 2026 22:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="V1HGJERf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1954710E0F4
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783204280;
 bh=/v5THKShPWIciiFZT93U3dZzMsB1ErKVThLGUlgIcIY=;
 h=From:Date:Subject:To:Cc:From;
 b=V1HGJERfAq2ZC2qnOryewFpR7iiAbUzyZQygxKyxwpJHr9sxHDPtpnHrohwhCfQgt
 Uig9MlgxeCYcj8TGQ7ZxFIw4/nRP+qqLZ445h77jjGzNtnesJxfHkYhBWzsiHrFh17
 nmTNop7Gn7SjlshVuZGHS8fWDy0VJ4YYER5hneaW496ic6Xt6uMYlGJI6yAX5BwAzl
 opEMEO4tkVVoWK7Z5+/qHh4qmsrMUicUYN15KUr4C4SdtYIYhUcXNnrOYTm8nEPpxO
 WH5JTOJH1dwgpJdQcFuisbBBXj2clNH3ta61F0Gk55I8iJWUadPDErpiG/GejuOBL5
 uQDqmibIV4H1g==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DC3117E018C;
 Sun, 05 Jul 2026 00:31:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 05 Jul 2026 01:30:56 +0300
Subject: [PATCH RESEND] drm/vkms: Remove completed task from Plane Features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-vkms-todo-upd-v1-1-d090015244a1@collabora.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

Since commit 0b9eff726d56 ("drm/vkms: Support setting custom background
color") the related TODO item in the 'Add Plane Features' section has
been completed, so remove it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/gpu/vkms.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 1e79e62a6bc4..792eaeb43c82 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -217,8 +217,6 @@ Add Plane Features
 
 There's lots of plane features we could add support for:
 
-- Add background color KMS property[Good to get started].
-
 - Scaling.
 
 - Additional buffer formats. Low/high bpp RGB formats would be interesting

---
base-commit: e88b5cc6d6e5b1ba257f00e5c186ba137e6e8bc3
change-id: 20260327-vkms-todo-upd-1e89d39284b3
-- 
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

