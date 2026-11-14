Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1A606B5EE
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=B12y/U9Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C0510F09D;
	Sat, 14 Nov 2026 18:04:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1599610E6F2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679458;
 bh=owVPqFwaoXUU+Gcwxuroc+P7E9LF5U9XqHzH7kbz1s0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B12y/U9ZpAz20vm5D/hHAoJXT6bUWc70g2oxD7FJYj70lsjHuxYMk0KvXUVmc8Fei
 sj2Lol28GXfoqtzZ/DUXkdVS9FOY3M//CY3rjl7QCYHaUyxVv8fusKD3D5NPueCAbS
 EioT5ySwEncxK10qAQE1R1O5X5/Rvm5CaqO63kWxFO46HqaB1FDJpQB3AsXNpjRLm4
 K+7qDUM+TLAABHVc2VoIalm5nNucBNh5PRVxk2BjubXwq3KNzLf+L2HHWzAXjBGYrX
 hlDHzub9P2V7fUU19t4dEC9Vr/2Mckl1RU32SVMvf3ZMKI/CWonWN42wuXXX5YuxN/
 cvdFwRv/tqRtQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A669617E0BCF;
 Sat, 14 Nov 2026 19:04:18 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:26 +0200
Subject: [PATCH 02/25] video/hdmi: Define SPD InfoFrame vendor/product
 field lengths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI specification defines the SPD InfoFrame Vendor Name and
Product Description as fixed-size fields of 8 and 16 bytes
respectively.

Add defines for those lengths and use them in place of the related
magic numbers, including the payload offsets and the log format
precisions.  While at it, fix the continuation line alignment in
hdmi_spd_infoframe_log().

No functional change intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/video/hdmi.c | 20 +++++++++++++-------
 include/linux/hdmi.h |  7 +++++--
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index cd18121afa20..7eeadac2de69 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -304,9 +304,11 @@ ssize_t hdmi_spd_infoframe_pack_only(const struct hdmi_spd_infoframe *frame,
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
 	memcpy(ptr, frame->vendor, sizeof(frame->vendor));
-	memcpy(ptr + 8, frame->product, sizeof(frame->product));
+	memcpy(ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN, frame->product,
+	       sizeof(frame->product));
 
-	ptr[24] = frame->sdi;
+	ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN + HDMI_SPD_INFOFRAME_PRODUCT_LEN] =
+		frame->sdi;
 
 	hdmi_infoframe_set_checksum(buffer, length);
 
@@ -1284,10 +1286,12 @@ static void hdmi_spd_infoframe_log(const char *level,
 	hdmi_infoframe_log_header(level, dev,
 				  (const struct hdmi_any_infoframe *)frame);
 
-	hdmi_log("    vendor: %.8s\n", frame->vendor);
-	hdmi_log("    product: %.16s\n", frame->product);
+	hdmi_log("    vendor: %.*s\n", HDMI_SPD_INFOFRAME_VENDOR_LEN,
+		 frame->vendor);
+	hdmi_log("    product: %.*s\n", HDMI_SPD_INFOFRAME_PRODUCT_LEN,
+		 frame->product);
 	hdmi_log("    source device information: %s (0x%x)\n",
-		hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
+		 hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
 }
 
 static const char *
@@ -1642,11 +1646,13 @@ static int hdmi_spd_infoframe_unpack(struct hdmi_spd_infoframe *frame,
 
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
-	ret = hdmi_spd_infoframe_init(frame, ptr, ptr + 8);
+	ret = hdmi_spd_infoframe_init(frame, ptr,
+				      ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN);
 	if (ret)
 		return ret;
 
-	frame->sdi = ptr[24];
+	frame->sdi = ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN +
+			 HDMI_SPD_INFOFRAME_PRODUCT_LEN];
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 08922d5330d6..7d96821b486d 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -267,12 +267,15 @@ enum hdmi_spd_sdi {
 	HDMI_SPD_SDI_PMP,
 };
 
+#define HDMI_SPD_INFOFRAME_VENDOR_LEN	8
+#define HDMI_SPD_INFOFRAME_PRODUCT_LEN	16
+
 struct hdmi_spd_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
-	char vendor[8] __nonstring;
-	char product[16] __nonstring;
+	char vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN] __nonstring;
+	char product[HDMI_SPD_INFOFRAME_PRODUCT_LEN] __nonstring;
 	enum hdmi_spd_sdi sdi;
 };
 

-- 
2.56.0

