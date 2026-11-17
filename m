Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E299606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VlA+jYUP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B214510F980;
	Tue, 17 Nov 2026 21:44:50 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493E010F979
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:44:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so3425025e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794951883; x=1795556683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOc7qs5gpmxDny1UvV4waZXrE2n/TMggor9dB+wdMFA=;
 b=VlA+jYUPzmjbKrTUARdcEPztuOpLt7jsAtDNreq5Va3VXdLNuOZFxeoIz9fq645hcr
 3snq0nfz+kVCY18kD6R4ZLwcZMnUcRplbIQ6l/mxWYBWdmGI5owLCXiZPQOzE8GIKm6l
 lnRATCnQIwSoEcRMc7SjSm/aoWTe32zWtpkobXPaJX3mC8LZ2SImfZXd7mkgda4DhBEW
 fkHyYmbIrwTB5k+M06eHEDvrfCsVYeGbWuP8ZljLLXnUjP4WLYbm6gjKsM5RUYYFTo3J
 5UUECQT/I7q6H0PQFuEQo6suwJbxOsW78VBQKTquyF+q4iUxOVhJpuyupcZs6Q6Ev4Bz
 DAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794951883; x=1795556683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DOc7qs5gpmxDny1UvV4waZXrE2n/TMggor9dB+wdMFA=;
 b=hiiXdu5USKgZ6JcQ2Sg+pYevuboA12STGXQ62WZK+mSKtmiSnr4TAuV0sF2KB//Uae
 3xaB9k5pXAoUPx/WoAIPn8DsA4ZVNBZP3TL5bswkDBdFZQ9YbQ8hA5Sl/JO9nEkuydVA
 KGNpnhWe0oe8uoCHyQ5XoAokJi6iC/RNsQsH2lwc2KytNzVRkasU+NWb9Z7CJD0ueaXr
 vjV5O/qdPeLOj9jFMRzJmVlLPN8BgxXBelIQB3RmhsLy0DtGcDH32kbzQh7itgLJIO3L
 opI8l01ncire36YHRzwpNNCRYkuWpfTSNHtXFpoyEI/ZcQ5jixQoCXTlu2ghYmbtw8UB
 sUfg==
X-Gm-Message-State: APuU4Z/6dYHHulbHZWQHOAlvDkAP7Cd4UpPtiMIjwaVu8ci7KQLrFSz/
 nWAm5GBUQs8W1r5IIoTVJ1bKSyfaG0Ws0qET4aNmr1dqmSNP7CZbQ5xU
X-Gm-Gg: AYBFou2LbVeQ97qXXVUj1DIe6+q7PkTJOya21YueSoqA2QuJSUU6TY7I6U3mYU9bMgA
 yINJ5SP9iN0zmIkXClAwFcFfBJUxmPCT6Kp5t1hK+935aKgx0OItUh+ohdoTTz3EX7Vytk3GVBJ
 tTj6vqQKD6wqQb79N/Ea4gSnC9rRxqaD1+793xIZR5uHwV+nAPdiLC24V3rgVBnHESRtfTadcJJ
 kKplaFkNfVCpNZQp1yYmMIVcjh4/BUK8dvXjjDqPmTtvR3c9h+uSub1I3xFgxFFb+PZ9jf9tu87
 Pf3UjJoL+JU8G/zIDM15oBhdW+Pz3WtNIG+V0yVdr3ki1aAfkWTwJO5s+nHzyXIhg7Ln84ggtmw
 MaXZKZJBW2WcwS/FbgjSqpckUWQw7sATzudAWtqGAUS9nugTF2WI1lLdVckHHxyWSSh1dc6/ozv
 cnc7FUB2t9qO0OYOGpHm3ZHZVqn1PDwFbT2h8dean+BIY4FgErccaYlUL5PCYxl8lmFjRT5fskW
 XZpP/MJCShg7xy2fbuoSXef50G6+JPUNwO/t/SzjtAtIU3e94aheTFVGIJ1KdUkQ8yNlmDZzhxf
 m6IPKmJShHCGj5HWjjmmxvhnnFCH7Mv/+IsHUaeNWfcXV2LPSC1A7S+gQfxCcw==
X-Received: by 2002:a05:600c:608c:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4bb7da44047mr9350665e9.28.1794951882663; 
 Tue, 17 Nov 2026 13:44:42 -0800 (PST)
Received: from fedora ([94.200.248.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm95069675e9.11.2026.11.17.13.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:44:41 -0800 (PST)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 Thomas Andersen <phomes@gmail.com>
Subject: [PATCH 3/3] drm/nouveau/instmem: map only the part of BAR2 that is
 used
Date: Wed, 18 Nov 2026 01:43:52 +0400
Message-ID: <20261117214352.337961-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
References: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
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

The io_mapping covers the whole BAR2 resource. With GSP-RM and with
NvBar2Halve the BAR2 address space covers only its lower half. The
driver maps nothing in the upper half, and a mapping that already
exists there would give the io_mapping its type.

Size the io_mapping to the BAR2 address space. The range does not
change where BAR2 is not halved.

Fixes: 34e27b90552a ("nouveau/instmem: use iomapping interface for instmem handling")
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Tested-by: Thomas Andersen <phomes@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index 1b4be4b1f0bb..1e7d439c2d59 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -191,16 +191,17 @@ nv50_instobj_map(struct nvkm_memory *memory, u64 offset, struct nvkm_vmm *vmm,
 }
 
 static bool
-check_io_mapping(struct nv50_instmem *imem)
+check_io_mapping(struct nv50_instmem *imem, struct nvkm_vmm *vmm)
 {
 	struct nvkm_device *device = imem->base.subdev.device;
 
 	if (imem->iomap.size)
 		return true;
 
+	/* Map the part of BAR2 that its address space covers. */
 	return io_mapping_init_wc(&imem->iomap,
 				  device->func->resource_addr(device, NVKM_BAR2_INST),
-				  device->func->resource_size(device, NVKM_BAR2_INST)) != NULL;
+				  vmm->limit - vmm->start) != NULL;
 }
 
 static void
@@ -293,10 +294,10 @@ nv50_instobj_boot(struct nvkm_memory *memory, struct nvkm_vmm *vmm)
 	}
 
 	/*
-	 * boot is only called on BAR2, if we can't remap the complete
-	 * BAR it's unlikely things are functioning well.
+	 * boot is only called on BAR2. If we can't map it, it's unlikely
+	 * things are functioning well.
 	 */
-	if (check_io_mapping(iobj->imem))
+	if (check_io_mapping(iobj->imem, vmm))
 		nv50_instobj_kmap(iobj, vmm);
 	nvkm_instmem_boot(imem);
 	mutex_unlock(&imem->mutex);
-- 
2.56.1

