Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22ED606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n5+Z9SLX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488B010E55D;
	Sun, 25 Oct 2026 04:02:14 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A3310E57B
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:02:07 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-157fe9d771bso2446317c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900927; x=1793505727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VU2DAJ/OjJ6m6U2gn3WXwMpKFJKrCfikczSVMn3jkTE=;
 b=n5+Z9SLXoQvCgu6SI8U8lCyug4xroi+3xv99hvGUoVUvJ3OlExhmM1A7QK/DXKJKsT
 U2S2TNSmTQxVDlI+aKZ91ZLGwQ+CFublImeFoT1A8LTVYBBm9JY4mRj+OGL8oR5M7R4u
 XXvxgxQlCKPD1+HRy2NZ0YeKy5mIdKMg+lhLcqFBlYy4GvkCrekMYX86aKvDoJm87ghx
 Jvv0+x5DAVtu0Ethk8e0Ts5OrCRaYjlxVW9VJz1T0sK/mNNxEAv9FxknWmS0Z4LqfkeY
 k+Q7M+a7hWOBVuG/ioAwfRu3c1nKKlv+XHPnsIM/ac73V2GViXzv9EISwO2G6X78X9UX
 qclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900927; x=1793505727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VU2DAJ/OjJ6m6U2gn3WXwMpKFJKrCfikczSVMn3jkTE=;
 b=eeyGw4xjutfYaJVWI/PGKPpxMSeq/goeXiGh/OMy67fiW01gBsE6yX2Ke0MvegrqRJ
 cOeJnjZTnRbho7U8y/ZBS7oDq1/QUPs+ujtYTaQYGSTyIxppoU0k8k+C0JHhEV64tnzR
 fF++ZOmzdptd08aV0l+hNjFPd0ybw0lsltkbczHcnUt7/Dc/hiqkQCl74Jgk9EGcRq70
 6l29q27YYMHb/NGWP3opcUvtbqY2pZSwpFqUeKNwky8MqwhCWvyV0YUqhKMaUZwvgDBZ
 1o0eZebaK1Ux7BPXS1fKsiZ+thdFedNKiKKMkiATxnQsC14fSApJdVs3TgCYMxJljwt+
 DQww==
X-Forwarded-Encrypted: i=1;
 AKwUvByz43EblCrTqni7IFkXfuXUciRIL+wPlHDzmrOMAgTHJgaFzanvescQGrqPnudmyG/o5p8J31h7U7c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwVVB8PEblnmwwxRDZG7Webj7vf8GCoiA/z28r3l5Tz+dUqIrJ
 V+qy3Fr9I8lXNez4UjV/3c0/nIwdrIhWbEu2E1Y83hAL3hliZ3MdQSo=
X-Gm-Gg: AYBFou3/mBl/IJXEhzmzR3xntrNTTGvjuGzMyyI5n5ZJ05emGF2HmQGlZaOfhpGtgmw
 5mHi/grBg8FGn/9xZWqQnUEV+4DjGdpYMoVYXE0itzZEbBonuCDOScvcplOcP62tInsmg6pbFgh
 SoKOnvsGt7bbpCbj38INV0Jfl+nBvhwaqxJf/HEGuzPoIZ1ZHQHvkNBUrzqjxAwKx8dCVICmPyR
 v/vyOiiZmSnQ6Ra5H0wR5xetQApWPHdkGnsFPYV2SrFOkWt99BoFA18KO9W6tT4b9li23l32vra
 GW0jhB7phJNxPHdv26YPI3YB/NDpjWYUFKzhOaztRSST9ftccru4WsWjclDBuJow1i1nPwLd2IS
 1bBoxnSp443PnRPqkooQ+HTGmkXcWzdKm6xxFGrGY2mm8kI0QffcrH8+ROjHYEF2Kco9X2y0IBO
 Ym280somF6qxN3JNQwH2KtUQTP5InLbAF/JCknjWAI01ZfG99SRYUfWkR1Mytka2VVMQ9cfyUOq
 v2XTbzVzB1jO1wcaYRhDeZ1ZvPN9/25A/lieAAQv5Ng9fVSeVJWRJdUtZCHsTYImO/NsLTX+f6a
 obQK8jQBg+wiOPM=
X-Received: by 2002:a05:7022:3d83:b0:194:23e7:b526 with SMTP id
 a92af1059eb24-19937024792mr4822317c88.27.1792900926860; 
 Sat, 24 Oct 2026 21:02:06 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:02:06 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
Date: Sat, 24 Oct 2026 23:59:39 -0400
Message-ID: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
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

This patch brings a lot of fixes to MMIO interface such as:
1. Using 1ms waits instead of 100us.
2. Checking if Timed out before reading and writing
3. Adding missing wait before gmux_mmio_write32

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 59 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 4e8786a5e..076ed7ba6 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -237,8 +237,8 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 
 	while (i && gwr) {
+		fsleep(1000);
 		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-		udelay(100);
 		i--;
 	}
 
@@ -250,12 +250,14 @@ static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
 	u8 val;
 
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
+		if (!gmux_mmio_wait(gmux_data))
+			return 0;
+		val = ioread8(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -265,14 +267,17 @@ static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
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
 
@@ -281,12 +286,16 @@ static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 	u32 val;
 
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
+		if (!gmux_mmio_wait(gmux_data))
+			return 0;
+
+		val = ioread32be(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -296,11 +305,13 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
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

