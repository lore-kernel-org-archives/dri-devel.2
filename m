Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD04FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C3410EC1F;
	Tue,  5 May 2026 22:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="OmdWJaKN";
	dkim-atps=neutral
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com
 [209.85.222.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE2610EBC8
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:28:04 +0000 (UTC)
Received: by mail-ua1-f97.google.com with SMTP id
 a1e0cc1a2514c-95d0476492bso1740585241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020083; x=1778624883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eh3U9SlhYUGj63M8IEARCrtNxYnzXaqY5JKgDVp0rlc=;
 b=XD5/7tStZm53kN69iTlYxbrSLuEtmyTemJ/Fsa3OWRIdOjqAiNTO7t1fLyJJLQsfIO
 BzzqiO5Nwi+9Aa7zwIhKeAlp95gV5SZs09WGc3IQ8c/RGBx62vvXDIExKodnVpnT1a6a
 BIVp36a+y71eXbmvhm0k50GI/sDj6siSf0mIiKTJTIXxCXymPm8POygMKmM8bcxHkkF4
 chus9Tvw9W1UDx7FxEds3DvUPKCXM+MA6J4171oSwQ0O7520VRj43A+9sdrTYCoqk/QK
 yXYDEbq1U7+jaiGHoLZAHk4d+SnisT9q1hiCHmyxx5l2cKohVDiuL0JA9s8fUGzfgLO3
 1hLQ==
X-Gm-Message-State: AOJu0YwnSqpyUcrILtY6jcoxbaGuejLZptsxP+TdbAa6Xn5axLXUpDhF
 ptgUfLIg2SR5R/P3CVUe/6TrY3PU+VC6iz6t8LVo63hj1pYCWHj5OwTDerE7c5uVBK0EKwgzySv
 nblztdFf8oiWyExNBXHx/U/6k5yMGM3Xu5CbB8ZC9tlV40LeyoNnsLEC3NWVg0A1OEsd553jJCT
 swDz81f71b7HVV6PWTMtlDg0JqPaKPQrZRA+65u4f5N6yNSA48puTnlb1MjQ1qxL8wiBRpgPo+Y
 dXPnyhroEagl0tnwibn
X-Gm-Gg: AeBDiesENVQiffm1Ck8zAOf+ozA47u32te4xGvqpGu6C80fTpM4jIfP4Sm3jpBfcdcL
 6wwasAyw0G5r96u1z1NcIzJ5ikqDCA+XipFLbWfGMExtoShdpSaujYoukuKKXh93+jZln4rhqu9
 1C5fQUgGmSN+Io4jCmbefvz4WczMHMPdxIQ52VqHw+QI1JYDsU+Pg5Q9NocpJtvfdnTxooLNsZT
 1/eVYoei3x0oUKWxrhyeFzw81x9Kd7ZNAzenKEw6sEBkITGd5xUi2M5nwe/NPwcJV1HB7sqEh1h
 Gbo5M849GJZNIf9HiuoYFyWV8fH5cYxZpL1ouGY8fWFols2ZaowHpMUdWZKECvKqGwMTDzJrK30
 jxwY8XjcsWI7Ep1INglrdRunip/BDj5/LQwmK7O2OBZLEfD1xit1ymfdvUKyuIjsNJpOPIwL5Bz
 Wvw2Oxbp/bCcu5GyGlF9VnTOMu5wpMOA9wLNRJWX6X2joIGHvZsfjb/YSTf8Yaez6e
X-Received: by 2002:a05:6102:5f08:b0:602:ace8:f20e with SMTP id
 ada2fe7eead31-630f90187b3mr367794137.14.1778020082973; 
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-62bfe9bd244sm1105044137.23.2026.05.05.15.28.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b552610488so82734836d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020081; x=1778624881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eh3U9SlhYUGj63M8IEARCrtNxYnzXaqY5JKgDVp0rlc=;
 b=OmdWJaKN0neZV1vpAcS5g8AuF6L1M3mFGF/S48O50HadKC+9ctx4EpU1qbQcEyBdeX
 Wy53E02iQalH49kjrhM0qu7/KzhOwtCwzS7h4h7rsCV/Niys6b/bAbsYdM2gBI2f7md7
 yr8z77OnY0xgxVco5z+uu7tOPbLPKeKdlrISs=
X-Received: by 2002:a05:6214:451b:b0:8ac:800f:10da with SMTP id
 6a1803df08f44-8bc422a64abmr12547186d6.4.1778020080987; 
 Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Received: by 2002:a05:6214:451b:b0:8ac:800f:10da with SMTP id
 6a1803df08f44-8bc422a64abmr12546696d6.4.1778020080483; 
 Tue, 05 May 2026 15:28:00 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 11/12] drm/vmwgfx: use check_add_overflow for shader
 size+offset bound
Date: Tue,  5 May 2026 18:22:32 -0400
Message-ID: <20260505222728.519626-12-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_shader_define() validates the user-supplied shader window against
its backing buffer with

	(u64)buffer->tbo.base.size < (u64)size + (u64)offset

drm_vmw_shader_create_arg::offset is __u64 in the uapi; when it is
near U64_MAX the unsigned addition wraps and the resulting tiny value
passes the check.  The unbounded offset is then stored in
res->guest_memory_offset and forwarded to host SVGA shader-create
commands.

Use check_add_overflow() to detect the wrap and compare the resulting
endpoint against the buffer size.

Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index eca4e3e97eb4..39811cf19db1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -25,6 +25,8 @@
  *
  **************************************************************************/
 
+#include <linux/overflow.h>
+
 #include <drm/ttm/ttm_placement.h>
 
 #include "vmwgfx_binding.h"
@@ -685,7 +687,7 @@ int vmw_shader_destroy_ioctl(struct drm_device *dev, void *data,
 static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
 				 struct vmw_bo *buffer,
 				 size_t shader_size,
-				 size_t offset,
+				 u64 offset,
 				 SVGA3dShaderType shader_type,
 				 uint8_t num_input_sig,
 				 uint8_t num_output_sig,
@@ -739,7 +741,7 @@ static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
 static struct vmw_resource *vmw_shader_alloc(struct vmw_private *dev_priv,
 					     struct vmw_bo *buffer,
 					     size_t shader_size,
-					     size_t offset,
+					     u64 offset,
 					     SVGA3dShaderType shader_type)
 {
 	struct vmw_shader *shader;
@@ -768,7 +770,7 @@ static struct vmw_resource *vmw_shader_alloc(struct vmw_private *dev_priv,
 
 static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 			     enum drm_vmw_shader_type shader_type_drm,
-			     u32 buffer_handle, size_t size, size_t offset,
+			     u32 buffer_handle, size_t size, u64 offset,
 			     uint8_t num_input_sig, uint8_t num_output_sig,
 			     uint32_t *shader_handle)
 {
@@ -779,13 +781,16 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 	int ret;
 
 	if (buffer_handle != SVGA3D_INVALID_ID) {
+		u64 end;
+
 		ret = vmw_user_bo_lookup(file_priv, buffer_handle, &buffer);
 		if (unlikely(ret != 0)) {
 			VMW_DEBUG_USER("Couldn't find buffer for shader creation.\n");
 			return ret;
 		}
 
-		if ((u64)buffer->tbo.base.size < (u64)size + (u64)offset) {
+		if (check_add_overflow((u64)size, (u64)offset, &end) ||
+		    end > buffer->tbo.base.size) {
 			VMW_DEBUG_USER("Illegal buffer- or shader size.\n");
 			ret = -EINVAL;
 			goto out_bad_arg;
-- 
2.51.0

