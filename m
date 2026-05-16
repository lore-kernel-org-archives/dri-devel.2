Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11F2CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBC110E6E4;
	Mon, 18 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hdx+K08H";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9477B10E1EE
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 20:30:32 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so243557866b.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778963431; x=1779568231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A2SnpYX99cRNTw4ZpHBuGZFwe81HvPv2StYkxx5LEus=;
 b=Hdx+K08HLbgH1l7ESSfPDtqFMzfGXiAnQTUAto9ISagP2lI8R5kee7zjdD/XkfJAWx
 ruE71z9M+xgS0W+244215POd+uElKxIqu7XB/dlJABNCP4D+iOIA/bcpiXFlF3Iwuk7P
 KGcDUz4/Zq4PUtJPOpYKqVfKVDqz9SZFbE9LC9xWqor7EXQ50m5VO1ZKmTpz+s99DMTL
 S1/ZY6tfHZNjZkVwmt6orGDjz/9IHC3b8f2lGmRMem57IE+mhQ+MZ/DOhCKCDqrJUg2a
 JLdRtokM+8BBbpAhd4j8FT+maJnsJTTXxEByooVDJRU158HpuhIIZl0EoUI70/5SCWa9
 CKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778963431; x=1779568231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2SnpYX99cRNTw4ZpHBuGZFwe81HvPv2StYkxx5LEus=;
 b=aryhBQS6gN6YM7e8QH3q+wfNHvmNaMnUwrgwQUuokTumIj5gvLFY3Xlc9xBeJJEQyS
 F/o/HqevMxERaA5x52hTzYRVYs2HhdF/F2eCUMPRMba+gkrjEeq24E3gfFspzttMUFf0
 mYMEGZDsFn3SF3hHPCE5pHpN37AAxiVc5Y/kr7GVt7Rhk8m5d/QtqReO3zBjd0HJg0p/
 sxvJh046ZpFNobMepvh+60XdogUlWcIY95/8WoS0ncEwhj8nXBfvsAa89kUcdkDe990F
 f291t4dCaXO5kGxU0vVGtGnKFZsrkpeGpoWQlsYaIFzVBMuAIVhWnGrbhABwA26YurWc
 RGlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0amezqOKijPlS6mh+LK5NgOmnvlr3qAPEzVW8JjTV86WSpd3ycj+pWxZ4yrFo7VBWTxYYzGyh03E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5Axbc66AklIVVo2JhzpeqIl6L/DBzUPHy65IYC2GKHJ9J5isd
 CWMLwU5uxiWZ+HB0z+gO9B2f62olubKA6htYx3FLkwWnMLlwqK7ClGao
X-Gm-Gg: Acq92OEOqIBKrRIJCs338l5Vss+hPd/dPEzWbi9XwRhspMg8wzGQ3HIExPFrOnJlHNG
 Sy5MiWgWSNcXDV365vYHtTMXhloHphW6+VoR8QHIRpUEAwoPdkqElM1/ESaPEVsFnM6JTd58Nu4
 2PyTYZ3Nl9W5NFPl9C3oPZhROX08KhJfEHDDHFpmnz7cSn1AzJVrF8NP5e6aP64uWAozwbx0Xua
 NUQOLAooUOs8TXDPQcrECD+MYw4LL9mSK7kfSZoh/ilorECeW4Ts+O/Dw3Bz0DLn7jNNq29kf3d
 QAwkLyS+gl8DrVgxSCYgwJr2TLtVZrgi9hZ/dMc5nDftcMytywY4eoooc7F3BhoeH1SD3MoHvEi
 eHzWrb1IRu1e7Vj8DiXJPAPIvVphg8Qu9r20vLE396Z3oBOXQmi4bHFOq7sG04LWSHqCX4fpzqO
 JnGi59WMNQOqil
X-Received: by 2002:a17:907:388b:b0:bcb:cc44:e144 with SMTP id
 a640c23a62f3a-bd517967f9cmr421444866b.24.1778963430906; 
 Sat, 16 May 2026 13:30:30 -0700 (PDT)
Received: from Godswill ([102.90.99.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bcf492sm382423766b.6.2026.05.16.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 13:30:29 -0700 (PDT)
From: Godswill Onwusilike <onwusilikegodswill@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Godswill Onwusilike <onwusilikegodswill@gmail.com>
Subject: [PATCH] docs: gpu: drm-uapi: fix spelling of "unprivileged"
Date: Sat, 16 May 2026 21:30:15 +0100
Message-ID: <20260516203015.33466-1-onwusilikegodswill@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

Correct the spelling of "unpriviledged" to "unprivileged" in DRM uAPI documentation.

Signed-off-by: Godswill Onwusilike <onwusilikegodswill@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 579e87cb9ff7..8717744f0fec 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -568,7 +568,7 @@ ENOSPC:
 EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
-        this when called by unpriviledged clients. There's no clear
+        this when called by unprivileged clients. There's no clear
         difference between EACCES and EPERM.
 
 ENODEV:
-- 
2.53.0

