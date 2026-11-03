Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE9606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vNHssJDq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F9B10E173;
	Tue,  3 Nov 2026 22:15:37 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E24110E3C2
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:15:32 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a070b3f44aso43554b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793744131; x=1794348931; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J2v88Y67fGvqGhiKg//IWeUpnVROIgGcFJFgELfIJIY=;
 b=vNHssJDqlD+deeJKmXerxaZs1XLqk07QNPW2jqiBwEtOcHPquW8l0+s7olv/hJrtb8
 dB2KGQJjVKqOrPgl8zii+H17D6S8eu7u0B7L5HfW00SZOtL4wmrSubTKaKsc5j8/hHmN
 L+ouwL8Mdr4pTRaavArZWTjGjcKyIDLcFGtDVdueZ+gkTXI5BVjtOCP0Q0PZySO5Mbxs
 XKkKepe7fZiJVHaaI98UhqiXZZ5lI6apFKeorau9MaPAOntKG/bVzQh4YWTkn4779RjI
 /CHu8h2BQH834i8KNA4PfjVO6QrGxDmq3h6OR4xNghDBMZgQo/DcYxPAiU+QvlMIeaPZ
 0tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793744131; x=1794348931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J2v88Y67fGvqGhiKg//IWeUpnVROIgGcFJFgELfIJIY=;
 b=bqv3jEWj2iQJOPZRZBwhpfG2cecmJDq6lzkOv1MOEiRqLaWvuqnQQ5L9kiyJHONxsF
 4OxiVQOFVSclxgnYX7nCsQDNtGPH8lDrMtcIMcrwepBDOgvLEieFJVtUNMWV0L+LmXoJ
 XKRfjlRBR2Bi2jYE4Vxyrz927mbROrvyn1gdlblp/cruuaC5qYKJJRBi9ws1LbaJR6dt
 Z39ZGT/Smi2LiF1v94hFgjg7au0CqUPyHlcG3S/4BT7HD3lHXkTj1elyA2V6MaU6xJyu
 VMCQw38aisrhTu6L75sS0KwOs/YvisiPUM7479z+NU8rvI6x5oYchPFMtnqQAT5XOyCW
 r+CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZp6E/WyjkXL8ifRyZ5YrIlwFRdkL+e/zop0M6X2mVNlkWp0yUsZ7nw2audR5Lj0CJAhfXFfYnKbM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FaiUbq8d5bcyk2Jr2Ya0qMPYL7bW6XnxI2CxnuTg3SVzHau8J
 U51v5NLH9OvEbWom54VtLIz0f2HfmKrgI5kllg6kTuJaTjLpX15xT+rs/LrwmA==
X-Gm-Gg: AYBFou1ESku8P5W1eZKBZrnsfdrD4HSqHQHpm484+CbhgwZh0HDP7h/nrWDH2sWHvwb
 dyPZnIppl9oJo0n4rfqiYbitxUgcHgkts+aQZx9MH/9sfriE/CStAONiczSkTiuJxEDhPA5NWWH
 RoFZa2SHDDZYjzM+jpXTtnMZCUwMKjW+3g3NlV/EH22q3wK0Lbt9itj6h8rq205tGcf5wuffkKQ
 4XP/9HRRf3l9U7lZDH7crEP5lpSDIobsVfPkc3JAuAo0PHkBnDlNigGAg+RFc2ZUCW/PtelrodI
 UPZArdpB0MhxS/C/OJWAcrGMXFKaMX4mhC+Yk/Vzu+sWr8Ni7UafmmOwYyYhCtyqxx2ypuNI1xy
 z3Gm0PJja2jtk+QEFNtRmrBDuk1u0Jdskqgt5sTza9OBidOLlIvbInJOyEZQ9Vin7DBqal7A1PZ
 C3sWSvZe5I3Y4Ws1q5+4ZpgoekPxwEj/8klxtt7ggRrvTaWb+e7+gV0/iSUsYHivAVFGoy+kUdN
 9JiejaqWcT3rdxEtKvq6p60/qwC3ZHCgpMFND5OEEQg02cvN9fYbRATGzyy2u1niwJIyMOqyrp/
 Ky1Nv1XcXEKn/VrzIXitfYqfJZXLbm+wtPcZiwWA0gh8AZqpJkvEY9IVg7LsHdAI34JLEd4zW1V
 gxB2ikw/2bCVBQKmm7DZFWGRFC37Aqn9ys86CdmP6jHYKt7a8R62UqbZhLdd1iJT4SL9c+SuBtT
 UMWQ==
X-Received: by 2002:a05:6a00:4395:b0:89d:a947:9d58 with SMTP id
 d2e1a72fcca58-8a9beb64f99mr10595946b3a.25.1793744131486; 
 Tue, 03 Nov 2026 14:15:31 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b097fe1076sm143036b3a.3.2026.11.03.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:15:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/fifo: map Kepler video engine contexts
 non-privileged
Date: Tue,  3 Nov 2026 14:15:29 -0800
Message-ID: <20261103221529.585436-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since the engine context rework, gk104_ectx_ctor() maps every engine
context into the channel's VMM as a privileged page.  The MSVLD,
MSPDEC and MSPPP falcons on Kepler fetch their context with
non-privileged requests, so the first method sent to any of them
faults and the channel is killed:

  fifo: fault 00 [READ] at 0000000001050000 engine 10 [MSVLD] client 0d [HUB/MSVLD] reason 05 [PRIV_VIOLATION] on channel 9
  fifo: fault 00 [READ] at 0000000001051000 engine 14 [MSPDEC] client 0b [HUB/MSPDEC] reason 05 [PRIV_VIOLATION] on channel 10
  fifo: fault 00 [READ] at 0000000001052000 engine 11 [MSPPP] client 0c [HUB/MSPPP] reason 05 [PRIV_VIOLATION] on channel 11

Before the rework, gk104_fifo_gpfifo_engine_ctor() mapped engine
contexts without the privileged bit.  Restore that for the three video
engines, and keep the privileged mapping for everything else.

Fixes: 8ab849d6dd4c ("drm/nouveau/fifo: add new engine context handling")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index 5655eda52a7b..912eb6c3a13d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -180,6 +180,19 @@ gk104_ectx_ctor(struct nvkm_engn *engn, struct nvkm_vctx *vctx)
 	struct gf100_vmm_map_v0 args = { .priv = 1 };
 	int ret;
 
+	/* The video falcons access their context with non-privileged
+	 * requests, and fault with PRIV_VIOLATION on a privileged mapping.
+	 */
+	switch (engn->engine->subdev.type) {
+	case NVKM_ENGINE_MSVLD:
+	case NVKM_ENGINE_MSPDEC:
+	case NVKM_ENGINE_MSPPP:
+		args.priv = 0;
+		break;
+	default:
+		break;
+	}
+
 	ret = nvkm_vmm_get(vctx->vmm, 12, vctx->inst->size, &vctx->vma);
 	if (ret)
 		return ret;
-- 
2.56.0

