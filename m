Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B3CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B47410E429;
	Tue, 16 Jun 2026 05:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oJCa/UQd";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C92F10E429
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:38:06 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-13809223fd4so4415254c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781588285; x=1782193085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=h9Hy3tDOEo1WyPKfqS6KI+ShJZyzd2h8DxHBmApwqwI=;
 b=oJCa/UQdEIxIpCjIELEsiUvndc3ZNAgssgvlKYSrvtvH51YGR0PCcVJjbQk7Ciio2l
 VwhFZI3aqYG3X/Wvj7oOFvBLVYlqlscYsc7ujyBeeULu1dJ1PWljs2SO2LTPq9EPH9pW
 hp3ReqptqxWEmGFtRI+dWWudJH2zyn71aDPHtuIgPpqsJaDCmk/61+Gupfe6V/ucYnvx
 zAMfAxMy0WgRruxBt0JhgL+ivvSe/kTkX2UUpFYort5uE2Lkj02s89Cne09sMTS97y3w
 6D20/DNKdRrzH5WtFcfOGJ0C1rWTirYENrn1ewGpfheA9MA1MMoh6qeOkFhATLHaBjCc
 /8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781588285; x=1782193085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9Hy3tDOEo1WyPKfqS6KI+ShJZyzd2h8DxHBmApwqwI=;
 b=TmQi9UuSv/huYn1GTCLn/TVl1ypDYLsjDrgoK9m505FB5QHWEp7GCQC7SflzuylWP3
 4Df5IqGSzMySuZbr1OtuGnLZlIE5PvsCwwITJtjHDyCAoSpuBxrVoqyLbsKXTjs5fslW
 3jTRjcMIe8rvvmy5accbzjkHrHk0GGs6QZvqpPK/vhZcOHS26bGLnJKKaMi060v8PK35
 8whZEq7cbkYr0XiiydfxElhflVFDEwGy5rCYvOtA1pMuZrvoj6I791p8NkqLBU1l5T3n
 dE8I9sqh+wZIAMkihTI2z6HN2vvvZ/j/KL8/d+DGGSmM3+ziNy6Tq1REjELsrBIQ3OEv
 Shzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2PhnOBhmBscFPqtWiS77HJTBcwcP/BXMHz56MtQG9BV2C4EDUQPzXJTl3je6YI30ETb8KggPKWnM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyutCkLIuq9SGGthKP4CFAjIEhXyhF7COUyNnS7PcdaceIfX+uG
 SfP1qPzaf1nJ36hISBp+uGSX2MQ8bwNYT4zsouYlbG3f/jFumKeaVRFU
X-Gm-Gg: Acq92OHHT8hvgEleUYvVv3V6ZEvan2ulpQ+Adyi0AFpTJQjpyNWRp8lchbM7yyfb8eC
 eEfr5N/PMjGkUs8yfUZ1BvAydRrCqLsprZEKcW1uzjP5WedFg6lnD6kmqIts8HucYMqG3y4WWix
 586rAw08+4vqvV+FiKQXiTTh/kdbEBd5A21J3+JfWdCeJDooiaoGV/5MktkzxHCkRtFqmBTt6Tw
 PUUNhmLsLLwf5O30786/ld2xz7N4VGlRjjyyn6mIH+gFMF+KC3BAhzTpSQICVIWHqb73suS9qGc
 a0h9bXBZl+LJxpXC0G+/HmXyPztv36UdmAtmroXre2oZPugyOhU9AmYgtZcKXMgYVXJ4VeojfKr
 tmagqaA/03CV4hyx5x05gRiQ+zzvwwfnC5QQMag9+w8/UCuIuU3z7qMxWCxYJHgiL1GKgTO4RkF
 ZY1wdLnbQx1aQC7EEbyZORizzvrhVEmKwxyiePCa6VP0/Uar9RdnLTMQjNbZ6HKkk=
X-Received: by 2002:a05:7300:7b8d:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30ba596ab20mr1343852eec.4.1781588285239; 
 Mon, 15 Jun 2026 22:38:05 -0700 (PDT)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43bc7sm17208123eec.22.2026.06.15.22.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:38:04 -0700 (PDT)
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>, Imre Deak <imre.deak@intel.com>,
 Arun R Murthy <arun.r.murthy@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: Move byte-by-byte AUX read fallback to
 drm_dp_dpcd_read()
Date: Tue, 16 Jun 2026 13:38:02 +0800
Message-ID: <20260616053802.1673782-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Move the workaround for USB-C hubs/adapters with buggy firmware (where
multi-byte AUX reads timeout but single-byte reads work) from the
high-level drm_dp_dpcd_read_data() helper down into drm_dp_dpcd_read().

This ensures all direct and indirect callers of drm_dp_dpcd_read()
benefit from the fallback mechanism, and restores the original clean
semantics and layout of include/drm/display/drm_dp_helper.h.

Also, avoid using drm_dp_dpcd_readb() in the fallback loop since it may
return 0 when the underlying transfer returns no bytes, which would be
silently treated as success. Instead, call drm_dp_dpcd_read_byte() which
goes through drm_dp_dpcd_read_data() and maps a short transfer to
-EPROTO; check err < 0 to catch all failure cases.

Fixes: a8f49a004301 ("drm/dp: Add byte-by-byte fallback for broken USB-C adapters")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 21 +++++++++
 include/drm/display/drm_dp_helper.h     | 57 +++++++++----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9c31e14cc413b..d14a8b40a1f17 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -762,6 +762,27 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset,
 					 buffer, size);
 
+	if (ret < 0 && size > 1) {
+		size_t i;
+		u8 *buf = buffer;
+		int err;
+
+		/*
+		 * Workaround for USB-C hubs/adapters with buggy firmware that fail
+		 * multi-byte AUX reads but work with single-byte reads.
+		 * Known affected devices:
+		 * - Lenovo USB-C to VGA adapter (VIA VL817, idVendor=17ef, idProduct=7217)
+		 * - Dell DA310 USB-C hub (idVendor=413c, idProduct=c010)
+		 * Attempt byte-by-byte reading as a fallback.
+		 */
+		for (i = 0; i < size; i++) {
+			err = drm_dp_dpcd_read_byte(aux, offset + i, &buf[i]);
+			if (err < 0)
+				return err;
+		}
+		ret = size;
+	}
+
 	drm_dp_dump_access(aux, DP_AUX_NATIVE_READ, offset, buffer, ret);
 	return ret;
 }
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8c2d77a032f06..0126fb8080ab8 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -555,22 +555,6 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size);
 
-/**
- * drm_dp_dpcd_readb() - read a single byte from the DPCD
- * @aux: DisplayPort AUX channel
- * @offset: address of the register to read
- * @valuep: location where the value of the register will be stored
- *
- * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure. In most of the cases you should be using
- * drm_dp_dpcd_read_byte() instead.
- */
-static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
-					unsigned int offset, u8 *valuep)
-{
-	return drm_dp_dpcd_read(aux, offset, valuep, 1);
-}
-
 /**
  * drm_dp_dpcd_read_data() - read a series of bytes from the DPCD
  * @aux: DisplayPort AUX channel (SST or MST)
@@ -590,29 +574,12 @@ static inline int drm_dp_dpcd_read_data(struct drm_dp_aux *aux,
 					void *buffer, size_t size)
 {
 	int ret;
-	size_t i;
-	u8 *buf = buffer;
 
 	ret = drm_dp_dpcd_read(aux, offset, buffer, size);
-	if (ret >= 0) {
-		if (ret < size)
-			return -EPROTO;
-		return 0;
-	}
-
-	/*
-	 * Workaround for USB-C hubs/adapters with buggy firmware that fail
-	 * multi-byte AUX reads but work with single-byte reads.
-	 * Known affected devices:
-	 * - Lenovo USB-C to VGA adapter (VIA VL817, idVendor=17ef, idProduct=7217)
-	 * - Dell DA310 USB-C hub (idVendor=413c, idProduct=c010)
-	 * Attempt byte-by-byte reading as a fallback.
-	 */
-	for (i = 0; i < size; i++) {
-		ret = drm_dp_dpcd_readb(aux, offset + i, &buf[i]);
-		if (ret < 0)
-			return ret;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret < size)
+		return -EPROTO;
 
 	return 0;
 }
@@ -646,6 +613,22 @@ static inline int drm_dp_dpcd_write_data(struct drm_dp_aux *aux,
 	return 0;
 }
 
+/**
+ * drm_dp_dpcd_readb() - read a single byte from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @offset: address of the register to read
+ * @valuep: location where the value of the register will be stored
+ *
+ * Returns the number of bytes transferred (1) on success, or a negative
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_read_byte() instead.
+ */
+static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
+					unsigned int offset, u8 *valuep)
+{
+	return drm_dp_dpcd_read(aux, offset, valuep, 1);
+}
+
 /**
  * drm_dp_dpcd_writeb() - write a single byte to the DPCD
  * @aux: DisplayPort AUX channel
-- 
2.53.0

