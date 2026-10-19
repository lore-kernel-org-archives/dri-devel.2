Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12084606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q3DOOzh4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F15810F30F;
	Tue, 20 Oct 2026 07:36:43 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3587010F2C2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:35:51 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b127f1cc8so219868f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792427749; x=1793032549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=koWQk9IFmwWKNpZkYe74gKtLy4Xq+ageqFKT3LrEOyk=;
 b=q3DOOzh4lQ6/FcNNTZulEfvA3daMdFOA3b6cRTzFo4P4oaHLGreJMS/oLbeeMIxhhW
 UVm0XrmjCsej34YYHVCFf+dCAb3FWv8tjIZK1KdMil6eRj9JeKDiiOYPxnLXXTY9yIPr
 81YrvldgfYRwehBUnwxyXwBUA8BHKmTwc5AqOHgq6xl6aX6ShDXP4mJHntCWcjgo6vG1
 TSdm++Nlg4ebOsoux4VqVrW4ScYn224qz8p4DUh3qwpiZfuSsNtRHSBzb1TEO5CCbchl
 zwEu3OS8nx30Gx98awSyRQP1XGs3jV5Xm3cabDC3bbOaMglOkyKzUjmsTZAc84fTZDbK
 ZI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792427749; x=1793032549;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=koWQk9IFmwWKNpZkYe74gKtLy4Xq+ageqFKT3LrEOyk=;
 b=j4qfOyxsW3IX3XdcwGQws02O+HQT1dzsO8s/njnHEAjA7SuMft/jnriN4LVQCJOXu7
 xKJVTSYp6AC7mBizbozR1TbbWt2sanDjLX+X+/o4CrV0STEQiNXNEIgUVJJKtbJe36hh
 LlwYEuN3Ch4Feou7sAjRmnyJOZ/wZPFnjPyYj0RtDdMr8/TTuTBJzkadJFEjo86gHKgl
 ay3E37H1BXkh/4RlFBdU9vVhDS9+JSDJRTOjS+8GzRcUcpTD8Ieb4XeKAFO8W6dCfP1e
 nbAMK5zfqdA+PJfJopWhcaucbgVvL44V/sAPQ4dbXNjCt7KS8h4uVx2+Z2rcZKhcxl/3
 todw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWR/8wsfnKKty7YpkjM3Ijy1QAt6i68QxcW7nw0TZcOpBZFRKh68iXGFJTunuWYUGMfwTim02c+3k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLRb2tFkk9nskTfu3KJoTmZpT6nRZHXppGZH9+Q9uUCIQnqaSnM
 vczpSd1jD0Ivc4TXFv9GvXiERKtj/e6MBbUNMV/oe5y649HKjnEG7qjl
X-Gm-Gg: AYBFou1s3bo7p3qbslWsyXC0aIGvHK1YdlQJfIp5NCjNn4cfvz7XQbu3Ccc/h6KkuMW
 p9kck3GrBUPWRfZQkbOaYprzECqc1YMVYMg4VC/+DLX6uvbOHZRzMcf4sKK0NXa4j6lZYJKpFVo
 WxqFOvbj1AuyAyn/0BUy2OWp74ChOU5aATWOBCqCJ43sjk+aPtpR5Fm9fF7vNmd0QKFENBz5+Mj
 9hvhESdC9cncd8vd2Mii4waJyv2kWtuwkqrcKZCAitj7Dg6fqjLiOgei2I/NnpwsdPpFRYGAmW5
 XQLxSzvgo45OXAYROUGRsRUjH7+gYPvg7P3XHglhSvMcupnNUgC4s4Nf5ekICGeeHrB4AdERjHi
 uEVmlFcMGzPaSExODx3JVkKOJfrfhtJUIqwNc8mMobISJJ3Un02aT1KvMYwSDK5w516uL7je68X
 jVWCM/vwyajK+jx5l5P2Du5Gx/Qh54hf+1XIwm91HizJ0C0m8ojmIpGNmn/Bwp1/u4apP/vHN6K
 SBe36+/DIWnK5zmSvk=
X-Received: by 2002:a5d:588c:0:b0:48d:fb3d:bf28 with SMTP id
 ffacd0b85a97d-48e07ba797cmr17862050f8f.3.1792427749215; 
 Mon, 19 Oct 2026 09:35:49 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5008e7sm23860300f8f.43.2026.10.19.09.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:35:48 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org,
 skhan@linuxfoundation.org, Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH v3] drm/amd/display: remove unused cgs register accessor
 typedefs
Date: Mon, 19 Oct 2026 17:35:38 +0100
Message-ID: <20261019163538.28793-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017130047.42080-1-emmaonana18@gmail.com>
References: <20261017130047.42080-1-emmaonana18@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports prototype mismatches for the cgs register accessor
typedefs, e.g.:

  drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
  for cgs_read_register(). Prototype was for uint32_t() instead

Each of the four typedefs is used exactly once, as the type of a struct
cgs_ops member, so they are merely an unnecessary layer of indirection.
Drop the typedefs along with their kernel-doc comments and write the
function pointer types directly in struct cgs_ops.

While at it, drop the unused cgs_handle_t and cgs_get_firmware_info
typedefs, and document the members of struct cgs_firmware_info.

Suggested-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com/
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Tested-by: Arnaud Bonnet <abo@medichon.fr>
---
added kernel-doc comments for struct cgs_firmware_info

 drivers/gpu/drm/amd/include/cgs_common.h | 74 +++++++++---------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.hZZ
index f40b6a03fe63..79522e1bec4f 100644
--- a/drivers/gpu/drm/amd/include/cgs_common.h
+++ b/drivers/gpu/drm/amd/include/cgs_common.h
@@ -63,6 +63,14 @@ enum cgs_ucode_id {
 
 /**
  * struct cgs_firmware_info - Firmware information
+ * @version: firmware header version
+ * @fw_version: firmware version reported by the IP block
+ * @feature_version: firmware feature version
+ * @image_size: firmware image size in bytes
+ * @mc_addr: GPU address of the firmware image
+ * @ucode_start_address: ucode start address (SMU firmware only)
+ * @kptr: kernel virtual address of the firmware image
+ * @is_kicker: whether this is a "kicker" (k) firmware variant
  */
 struct cgs_firmware_info {
 	uint16_t		version;
@@ -78,45 +86,6 @@ struct cgs_firmware_info {
 	bool			is_kicker;
 };
 
-typedef unsigned long cgs_handle_t;
-
-/**
- * cgs_read_register() - Read an MMIO register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- *
- * Return:  register value
- */
-typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
-
-/**
- * cgs_write_register() - Write an MMIO register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- * @value:	register value
- */
-typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned offset,
-				     uint32_t value);
-
-/**
- * cgs_read_ind_register() - Read an indirect register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- *
- * Return:  register value
- */
-typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-					    unsigned index);
-
-/**
- * cgs_write_ind_register() - Write an indirect register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- * @value:	register value
- */
-typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-					 unsigned index, uint32_t value);
-
 #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
 #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
 
@@ -133,18 +102,27 @@ typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs
 #define CGS_WREG32_FIELD_IND(device, space, reg, field, val)	\
 	cgs_write_ind_register(device, space, ix##reg, (cgs_read_ind_register(device, space, ix##reg) & ~CGS_REG_FIELD_MASK(reg, field)) | (val) << CGS_REG_FIELD_SHIFT(reg, field))
 
-typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
-				     enum cgs_ucode_id type,
-				     struct cgs_firmware_info *info);
-
+/**
+ * struct cgs_ops - Common Graphics Services operations
+ * @read_register: read register value
+ * @write_register: write register value
+ * @read_ind_register: read indirect register value
+ * @write_ind_register: write indirect register value
+ * @get_firmware_info: get firmware information
+ */
 struct cgs_ops {
 	/* MMIO access */
-	cgs_read_register_t read_register;
-	cgs_write_register_t write_register;
-	cgs_read_ind_register_t read_ind_register;
-	cgs_write_ind_register_t write_ind_register;
+	uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned int offset);
+	void (*write_register)(struct cgs_device *cgs_device, unsigned int offset,
+			       uint32_t value);
+	uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
+				      unsigned int index);
+	void (*write_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
+				   unsigned int index, uint32_t value);
 	/* Firmware Info */
-	cgs_get_firmware_info get_firmware_info;
+	int (*get_firmware_info)(struct cgs_device *cgs_device,
+				 enum cgs_ucode_id type,
+				 struct cgs_firmware_info *info);
 };
 
 struct cgs_os_ops; /* To be define in OS-specific CGS header */
-- 
2.43.0

