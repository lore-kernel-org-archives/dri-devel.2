Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE7606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm8FOXnu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CBA10E64B;
	Sat, 14 Nov 2026 16:08:49 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5140B10E64B
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:08:43 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-37000e7234bso92327eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672523; x=1795277323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
 b=Cm8FOXnu6korQovECplv+zE760xep6JOxhQnurMkU8l7Kt7Ri3Zx0vzMcooBI04Yu2
 21bYMjhXTueBJfvEVovmOM+kXrA6g/7KJl8C5qZ2H5rAS923AcKbooVFBXdo3saRdxFi
 ag7E+5EDxdxE9RzS5NirpMzDEc+4ym1hhm+3zKL82HDRhgEZWjFD1b5kL8i9cgpKg8Gs
 Pqj9xkcLFdp7lPU+yee8FzNkloCOCtfWVDCv0QkFtSjDoCagcRw+2go/cCA9A+l48CxS
 EP49+Jv3M4czK7otG88q4fNP2gxp1S+xi2iZju5vi2z114/J1yfrv5brT+xQUXG4n9xY
 RG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672523; x=1795277323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
 b=NKOEF6YyhXXXCZxVKqP2L1673so3olzm4FurDdkfyztrkv7t2LdUM5S5Lz9nURwAtR
 1j0RR5Z8cKfukQajxwN//nKvB4NdU+F3S7K9GWWloxdl/9w91yhX8IyppvVndAwvMvm8
 QpuWlneV01IFXPE4qAwiAdLyMACtA+nNWYt8I7qjM1lt2fAz3dFbBCc2cUtTNGgNqms9
 KrtjlAHA3TjkTozdoQGgDgmBvjY4OxMswPsqvkReF0mXFv2ZGQGflgS9ST5+ty7D/hrh
 EmK8uc3xMpHeIESzO4PKcM9DZgvrLGkwZEcaXqXwbsQdbr8TWj0Z5H0jMcIRA7ryrtEP
 J2SA==
X-Forwarded-Encrypted: i=1;
 AL+hErHzGKFwHSMieAUM88Vh6KudDWJDXDiaahYdgL30zYyF/Cc/8uhhhZIOBz6D/xEkOhBAA9Gjg9aMnRU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+NSH6CupTaORsBeaogrovnMqyGqzVxYNZWlj8vcjIlrC8FBP0E
 XL8b4ey5dJcxIi4zY8pt2fri/q7wbfIIVPaSAskdtRwGF/J1/DQobUM=
X-Gm-Gg: AYBFou0fFCYdO9x0ZfsAMf/lbRKXcblBdbnwIxO8oms6k9+UYh9BLms+YAE0poCgOmE
 Z6EnpiIQtJZsJhXjzIwh2soksJArEQQ1ytEG0N3UPpWI8E0/YgqO8MJh3sYo9X50Sy876EEIwfW
 Xw0IbDSB6mmj9hK2wdhsawZO4aP5Jmd3Ufb0KhIRx30p2Jno6xMDJnTPPT1lfSbOOduDEfKI+3F
 4uOXhS/wTZMSMxziOMqNji4pwCRaNS9HI/jax4m1Q5okyCY94PmC8C5cUvtef1ov12Lp9PO2Wcg
 Stfp6XtqEI0dzETPZMzRgV8ynRg5NArTeKwWi83s1RUBLVUvIvEu8MI7ZTuTmZciw7BG8DrGy3i
 99aHlDmKhFVtVbC5yjpNItB1wJgBhkrRWMckuVH+kBpmHVtEsQU4zqyyhehb7VUyuNYMARdJbfx
 e/O/h1mAprPZcZDHDNRImsuBkwT4H/+L6DTy81CtcXu5Yf7VFbUKc7cEBUEQciWGgvt/X9mZeVd
 STT3VZ6XO+N1BDseKwDdq76VtGL2QSpMRPNbBE2u5YBcVt4M8mLda4dKKxCcGlfE1N7LaCQ4csX
 dcsCdk7HvE+ZK1tTf5LQhdaJEI8aC82GHFtkBd62vFn4yiE/yPw0Badri0cBsaADw8VjO5f0qRG
 eoLG3RS2J5zI=
X-Received: by 2002:a05:7022:1081:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-1b503112e3amr4894890c88.8.1794672522574; 
 Sat, 14 Nov 2026 08:08:42 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:08:42 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Andre Eikmeyer <dev@deq.rocks>,
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
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 03/12] platform/apple-gmux: Fix MMIO interface
Date: Sat, 14 Nov 2026 11:06:27 -0500
Message-ID: <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch brings a lot of fixes to MMIO interface such as:
1. Using 1ms waits instead of 100us.
2. Checking if Timed out before reading and writing
3. Adding missing wait before gmux_mmio_write32

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 60 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 34e94f2b2..9625551e5 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -235,8 +235,8 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 
 	while (i && gwr) {
+		fsleep(1000);
 		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-		udelay(100);
 		i--;
 	}
 
@@ -245,15 +245,16 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 
 static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
 {
-	u8 val;
+	u8 val = 0;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread8(gmux_data->iomem_base);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread8(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -263,28 +264,33 @@ static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
 			      u8 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8(val, gmux_data->iomem_base);
 
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8(val, gmux_data->iomem_base);
 
-	gmux_mmio_wait(gmux_data);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+		/* We already wrote the value there is no point to check if timeout */
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
 static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 {
-	u32 val;
+	u32 val = 0;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread32be(gmux_data->iomem_base);
+
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread32be(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -294,11 +300,13 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	iowrite32be(val, gmux_data->iomem_base);
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite32be(val, gmux_data->iomem_base);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
-- 
2.55.0

