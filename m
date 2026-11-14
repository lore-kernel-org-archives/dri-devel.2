Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EE606C316
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pMEc2GoT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8771D10F0A6;
	Sat, 14 Nov 2026 18:04:30 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5653C10E5D7
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679458;
 bh=TxqmposBOHXdDsrH5e74JfVT2uddDv95gdLnKGzzKc8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pMEc2GoTmGBOglomGtdfytnpNJTkCk4lOsXjoqMlh0Xp+qJwK8gwEQ6egtuqVAY1N
 lX2qK+lCZvoqSc4MJVsc5h7EAP1zkDnroorLGXK6Qpn1dWmXWf6CuOUc3DFSzH8t+N
 N5RdSzNaM0+VSQT4wWhdD42QeIgU8OXLENaKnBuO8nj5wGgu+NnGL01W/PktKwmEiu
 tKgHfWOEnuFmNdDMofAr97wd93mZW4ScHsx3hTat1Ti/EGwaidTk84nPD8n8f72fLa
 XC9cFn7ZnWZ/XLkYPpzRHc7VagGJCffi39KQ/7IDegAT0XlNIgtGKOVXNc816aT5v9
 kGt34JSdeveKg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DD9D317E0B1E;
 Sat, 14 Nov 2026 19:04:17 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:25 +0200
Subject: [PATCH 01/25] video/hdmi: Copy SPD vendor/product with strtomem_pad()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

The HDMI specification defines the SPD InfoFrame Vendor Name and Product
Description as fixed-size fields, padded with zeros and left without any
trailing NUL when a name spans the whole field.

Mark the fields as non-strings, so that the copies can be handed over to
strtomem_pad(), which implements precisely the required semantics.  This
also bounds the reads from the source strings, whereas the open-coded
strlen() could run past the end of the buffer in the
hdmi_spd_infoframe_unpack() path, where the names come straight from the
wire and are not NUL-terminated.

Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions for InfoFrames")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/video/hdmi.c | 11 +++++------
 include/linux/hdmi.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a750..cd18121afa20 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -217,23 +217,22 @@ EXPORT_SYMBOL(hdmi_avi_infoframe_pack);
  * @vendor: vendor string
  * @product: product string
  *
+ * Both strings are copied into the fixed-size infoframe fields,
+ * truncated if too long and padded with zeros otherwise.
+ *
  * Returns 0 on success or a negative error code on failure.
  */
 int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 			    const char *vendor, const char *product)
 {
-	size_t len;
-
 	memset(frame, 0, sizeof(*frame));
 
 	frame->type = HDMI_INFOFRAME_TYPE_SPD;
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	len = strlen(vendor);
-	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
-	len = strlen(product);
-	memcpy(frame->product, product, min(len, sizeof(frame->product)));
+	strtomem_pad(frame->vendor, vendor, 0);
+	strtomem_pad(frame->product, product, 0);
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index b80a5ee63bb2..08922d5330d6 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -271,8 +271,8 @@ struct hdmi_spd_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
-	char vendor[8];
-	char product[16];
+	char vendor[8] __nonstring;
+	char product[16] __nonstring;
 	enum hdmi_spd_sdi sdi;
 };
 

-- 
2.56.0

