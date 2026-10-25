Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E1606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cklDkuek
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB62E10E57B;
	Sun, 25 Oct 2026 04:02:55 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495FC10E66A
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:02:49 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3550c917fd3so3059831eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900968; x=1793505768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
 b=cklDkuek544JNBsdVjqKZNR+BcqNtDeXfljxkJfM7QB2XCy4arHVLqLdwWKDBr3sRd
 DWnPb958f7BxaL/AiNkUlJ7rYa58gJ4L8gQg53C7G+tm2dBXuiQp0H6UIMajCBeRbsi7
 74N4KbFty5BZbaW19dR1JAcMrRf/CmtXUpzlR9AZnHs2kkuDu7TMBHYDxFwxEtQO8ajw
 Yz0ERBkPFVY2hWxzTU+5khvyI0DdZ1KLe+L5bMroTZjABrMEH6NpPkF0UvCGySQOoXTd
 9JP19r6cywPv/VEZHmSf6IrZVKpJZ8jzkxFl3CCjgG2qn0rE+LcQvw/V7DCrq+fapXo7
 vVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900968; x=1793505768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
 b=SAkmS1eIaTFkrDXl1nvAkceQHTZE+T4W/KvcYs8zwItfjmcWmy5jkr3N1BXrTcthOk
 j2Zlvy+9RrqRzTk70xWD9wS0129NdAYEKZ3kqitANhbIiIq7T8MB9kE/ex85jyzmdQcA
 dMHgmCBcA0xvVJUAPJk77Xgyn4zooO9/fFXUN8mDYhDZsen9wXuPHeqemHS0JPuVlZOQ
 B9+Z8h2zXWsVTUxIQyJ87RAkekDMyygFmEFjnP1comt89S5lQBY/geGn6Gtz/0ASjZuI
 k1n6/LGyVpSzPBQqb8Tg8A7tKUqWRMKsz4cvdW5/XQpHuIUgtFfjJpM9C393RkeUOm6E
 HOpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnr76AHT4odHUZ5Vfwj04S9tfKDsshqbvz3y7NR4w7jfqT19Lo8nP7/mRJk7T8Bc7Lk88mISfq8ys=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZnLIwYPM+XgPkKPnhevwxAbjsUbxin9wUbCUVhODD84Tm8idp
 7B/uOo2I9/3eIfYJAZoEn27rb+pf8Fy19faG9adWK+VSU12yLMCdhY0=
X-Gm-Gg: AYBFou3E+znhEVJDQ99QyrT0nxKeSaa4yalrYV+RUvNDy4aIA52SlcKMK4zt9A/eM+f
 FXmuYdrKF6xTnVD4QStMKi92KddAXVJ4tWKs5qqwBlFYO+srz7iAyhnnrGhh1nUTdRZRynuSGG7
 0uZZmQB8tTKrnyA66zq7evWESvO6kNNiaPbIT4QdeqHX8emDCZILW7OLd+pAZoSwDlH+0ozVVuK
 766nsZOxnbyz/MUEyHxiUwks7JGi0EuQef/KFC+Du8fQfAaeQHZNASNcltHm+9bkYS46XRwxmsc
 9ggin7qA0g/vdqVo4TaIGAFGAvfMo1Ex+QyhqX1WNEyz1CxLibx51bJou46JpxbKk2dgCegx8Iz
 NSwxeriZFpFZQRTcYKYETEz4C0Xh5RDI10SgQldp3IZprQDCTWPrjTvyq+x+0hLGS+FlqjAFE5h
 YoXX4/zJMVkw6s7Y3l2cM0qdAAbZ7J5t03t+nAyl/7LZ44uz0lqUX3elgIACWWZ8K9rilH4TW4q
 02UF+IjmR+BH4+v5Y6K5STQR3sqMBjUjeMTXZE505yyTMZR/pM2qnhhXpeeBEDakCpp3O7Z9a6Z
 20dlNZp82LOkuRX8
X-Received: by 2002:a05:701a:ca0b:b0:17d:7b45:f91f with SMTP id
 a92af1059eb24-1993580fcd2mr5442774c88.32.1792900968114; 
 Sat, 24 Oct 2026 21:02:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:02:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 06/13] platform/apple-gmux: Add parameter to configure boot gpu
Date: Sat, 24 Oct 2026 23:59:42 -0400
Message-ID: <20261025040046.1602-7-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently on Indexed and MMIO systems, the system can't change
GPU's on runtime, as the display is not trained on the secondary
GPU, to combat this, we add a module parameter to configure the boot
GPU, so users can change to iGPU or dGPU via reboot.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 637b3b216..6a9580f27 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -109,6 +109,10 @@ struct apple_gmux_config {
 	char *name;
 };
 
+static int boot_gpu = -1;
+module_param(boot_gpu, int, 0);
+MODULE_PARM_DESC(boot_gpu, "Configure the boot gpu (-1 = auto, 0 = iGPU, 1 = dGPU)");
+
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
@@ -1215,6 +1219,11 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
+	if (boot_gpu == 0)
+		gmux_switchto(VGA_SWITCHEROO_IGD);
+	else if (boot_gpu == 1)
+		gmux_switchto(VGA_SWITCHEROO_DIS);
+
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-- 
2.55.0

