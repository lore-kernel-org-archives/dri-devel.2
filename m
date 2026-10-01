Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB858CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C299610F76D;
	Thu,  1 Oct 2026 19:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eIq2ceOR";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ECE910F76D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:58:56 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so52680045e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884735; x=1791489535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1937oKfIRQVCPoNo84DTw0NidOzq8BgSFZcKFKTUzSM=;
 b=eIq2ceOR+ZR8OnesRSDNBiWB/SWEITGu770BZdC0drvXxcLVR+eGgJ6XmHKwzhm8yr
 GvYGeqmzRMee3s0NgTpIxHIq/tR1mirNF9reSXLDAk+Bo5+x5NhrbnqXnWLJTu6nBXpw
 wGnsTFODwkIhIV+4w+M9QcsLkEYK/La/g5QZqHyiOAnOIftWEZdYUOHUnTn0gpu4cCP6
 oonOX+gYvzRiktEN2gz3XgoKD7fuNjhfwkgPGpAL7hp8N8uWaDnkLIieb8BDjeQTK1Rx
 1qfI3F1MCWg6uAjgVhVH9KHuUcgN0ErVxsK+vAhQUEFbcUvHw4gBQF1mCWeBAKe2OM/3
 6buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884735; x=1791489535;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1937oKfIRQVCPoNo84DTw0NidOzq8BgSFZcKFKTUzSM=;
 b=Yu4rlS1k0ueTM+Gs9kxVpqg1tEhna6QeNhb89Lb3aQbbgz9Jtp6Ly/LDUR22fL2lBe
 vJfO1QnpZeklw2GUJuB+E8CDyIg14nUSTZnzg8Ct/wXuyKYwf3/q8twSacQnnEFl2TBd
 WSe5H8y+fFy8CH6uFBdIx7dJhLlp5YEWPpiO1P7XHZuY57wDJpks4v8Y+R8Ra7+r7jSi
 Zr7Ce/JmxsJ82e+z94s+3Ha8rhRVC/lB441ygYMhIF2+GGF43OdesPWPGSlg6yODHWfz
 QCv7vmMz4SwGW7QTdsR+DF9IQV8oHmkIdWhW1Vb3lMo6WqpZYjhc49VNLS21v4BVSqOY
 bwvg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhWoLKG4ITvuLnyB0ut1jBdx1jgoOOkLPLxzK6vKS9vSxcL9XZk0DMBcsO+HGmJPaYNDpMwwPJKrs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTXj5WN8AVdbOheVhoVI80RniQ9LYNWNQVJqgV6T6JFMkCClP1
 qvI7ZvLxVurlt8PcVF7vux5S5BySWmuXjLTPrm0q3RE/vSD23uKKTCEh
X-Gm-Gg: AYBFou2Wmq5CyFFfBMKqEdX95mCEDMeCjMXAijaPX0h7OJoNCbew/kKkCZeFAFzWloW
 5wasaat8/sQ8ZGAZM4/SmpaPgf5guMh6iblLE0h44AuWI06R7YexIa9L/kMYOTv0ZBIoOzA5iuB
 91Q1+jxHS3VdwaCdJL262JLmcEZ2FLPeF+K8x2Kd95oK5fhzyGHTCbuRxwXgkfM164+HEWbaple
 m5i57QUSgAK225onQzHyqy9pSkML26E9G4LNl/D9cJdAl40H/txaE6FODajOdZaznrGl6hBoz8l
 XfUvGyf+b7PZjs2CSVFY4mExpcVmn9tsfWQ/zt3XQzrCZfB8EMXkZ2IG02UKp4xC/B41gZ8mumJ
 v9rvKH+2GW/foKCxHrgQ76JaJV15f0zbmEHb8ZQeSk1L3feR1dLv3/ESsiHNHWBOYxpAHbkaFaa
 YTzy0B2qcCEtEvFv9dRXrXM5jSYuI6j3iQKbvfXNZ4+FBYpcf8zx9QBPjiAdezCFufO/a2qyzop
 +oUt91PqnRhsCODx+xUBMHX5w==
X-Received: by 2002:a05:600c:46ca:b0:49c:edd8:ba35 with SMTP id
 5b1f17b1804b1-4a027590091mr11675715e9.6.1790884734605; 
 Thu, 01 Oct 2026 12:58:54 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:58:54 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 02/13] efi: bgrt: export the BGRT table and image size
Date: Thu,  1 Oct 2026 21:58:36 +0200
Message-Id: <20261001195847.141192-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The DRM splash client reads the boot graphics the firmware left behind
through bgrt_tab and bgrt_image_size. Built as part of drm_client_lib,
which can be a module, it then fails to link:

  ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bgrt_tab' undefined!
  ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bgrt_image_size' undefined!

Export both. They are filled in once, early in boot, and only read
after that.

Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b978696482@amd.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/firmware/efi/efi-bgrt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 1da451582812..746a8fb3a337 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -17,7 +17,10 @@
 #include <linux/efi-bgrt.h>
 
 struct acpi_table_bgrt bgrt_tab;
+EXPORT_SYMBOL_GPL(bgrt_tab);
+
 size_t bgrt_image_size;
+EXPORT_SYMBOL_GPL(bgrt_image_size);
 
 struct bmp_header {
 	u16 id;
-- 
2.39.5

