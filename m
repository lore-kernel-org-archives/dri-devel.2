Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3F1F55811
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2A510E935;
	Wed, 22 Apr 2026 08:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="woRjzRCe";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37B610EDFD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:40:30 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c7212836bso12788714c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776818430; x=1777423230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=woRjzRCe5cxc5Z3U1exLZlycnkLjMPXrq4F+qhL9HF7J3YBmmRw7z9+zK2HLj7A3cO
 gehCmg9TBRqYYRqf0B+17n+3Vh+Nr48l1na15tAntjlPVNnx+tm4mDLcXU1NFGNtltQZ
 7gr3+OvwG0/UWDjXQVGgG1LTaQrVn3/Bf1SYWwzp+NPIYvKQV+KgkyVezDuW1m/JoeJl
 UCnkyY+LsUxYRwRKsZhytshZgAIagqCFpZNRcvolFZXe/r+TkKUP8uUJE2QsyhTNfF7F
 YqzRQyUO/ZNdVUE37d8J5bdtlz7pzKLmCs8oFNUy9MauFQzVs+PEveQ7J2wyv3wxYJWG
 snVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818430; x=1777423230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=ci2INbbZs21k2Erk850zfYnHOza6djO+Fz5s2xrZ5FGYxD53UtKOBNLEGGTMTynQUZ
 FGdaUPkdi9eCRC4i6zQwqC9+k/QMyBASChdNnyl1hBUUdTfGoMGAkgR07wF+4KBGVYUd
 a7/ZQuQ0G7qna5JQPlvrrtAjnm4BLFT0XtwM/Vz7Gfg/3NNnWwbTYXtJ+evGoUR07Bfw
 1AuvoRsU2TM3YAbVhcHarf3oLKPdzajZS+yOrOLuazFxIEXPQiTgZ49g7yKRfe4U9EP6
 Ym6CCeyvCMUyyomST4e+uCLIIOL8E4IgNxLlNaT5BAa3UGcASxMfojWqmfNY7F6DELWJ
 N3Ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WmyWcfahJNMryec+r0jgucVK6otfTdoWsVEukebTZA39g6yFz0loiAmaqD4RY7bZqx32EHgpRA5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAN8rQa54NNPshUuvdSwu+vZyXrw3XUF0TdKTQ4zDm5h0kbJ5f
 FL3JVyMgqEhsa+AjHEMCgcGJ1vueoMt1o4GP2lYorQfZsj48Rushj0B9G+nOHINSteg=
X-Gm-Gg: AeBDievhBlt4v00lViQUoF/zvbNVrH+ZKBfk7gHtaxV+i/OLtroJ4w94vHhXPJUqvIl
 O1kRrOype9drTzbVn4u+BjXOGBCut4/K9aDGHG72BjcYlMuQa2RJZR+Wh1QNnYTTeqXAi5ZDPNL
 EGvMuVYPuhmUsVslr7xhvZgdaVbc6dUMIlqIetVisAiRuAovV1wPmOHDhmItjp9J3Lh+zhJxPc4
 Z2M3Ux7gOcpU/qDRzy7B/r381P7f4Tl3x1zrlJkbqLJjDBe69TGpuNy7VUD9B5bPSNHXTg0Noqx
 PmdFxe+ZWtEw02tCte9LALcRt75UaZRk6L8rXSgbPX8Z06NQmX+AQ+0uu7Rvjcnqpj6IulRf2U7
 HXNhr8k9JWkqVyljntP4GkRgZT29S0j1P8T43A0KMrBOw2Qx31m9uq/jGoLyfYbPOoD/7lMHe9e
 M75zgUi7/xrJyxLpMN7vKq1tLjXiIS+egQSD557eWEzr0aBg0MMnzJiZWCnPYcnE3AqjrkXI8KK
 DBVWQt7mol+aEk2xfs=
X-Received: by 2002:a05:7022:12b:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12c73f996d4mr11348980c88.18.1776818429938; 
 Tue, 21 Apr 2026 17:40:29 -0700 (PDT)
Received: from voyager.. ([191.251.25.148]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm552462c88.6.2026.04.21.17.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:40:29 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
Date: Tue, 21 Apr 2026 21:38:44 -0300
Message-ID: <20260422003911.33841-2-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422003911.33841-1-tiagodourado@usp.br>
References: <20260422003911.33841-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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

The jpeg_v3_0_process_interrupt function is identical to
jpeg_v2_0_process_interrupt. Remove the duplicate implementation
in jpeg_v3_0 and reuse the jpeg_v2_0 version via a macro alias.
Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 ++-------------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab..9006fc57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83..4f400fb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
+
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
 #endif /* __JPEG_V2_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622..5010dafc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,6 +34,8 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+#define jpeg_v3_0_process_interrupt jpeg_v2_0_process_interrupt
+
 static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
@@ -539,25 +541,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
-- 
2.43.0

