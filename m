Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D7C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6249810EA46;
	Sun, 13 Sep 2026 22:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9U60X9l";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0129910EA46
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:31 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f55efebso214549866b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338630; x=1789943430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=quQ1ROjqXOesVl7wNiBN30U4SehH2NXzlCj3tCS7Nn8=;
 b=k9U60X9lNcxxBu7jNXqZ6zar1sk4qFZFEstYd2Lrtii704IQOApqvH7aVlNfkJgDnD
 A0Gu4CMcuTCs9cNHGfvCJztAkPEQ+mP/JuSZYJHImxH1+jzeXAnQ0Pe9TJBFUEBXnq+N
 MQajc9CF/InmXi7mSv/3IEnzow0k7MQvfgyxfY+Bplm5dburVWogyBmHfPlqF7OqLSkp
 V5YrsCYBce+/Yh4x/SjvqMp/a4V3KvKh78swFekNFB5G1WkhpYcX/beeODYMSnEQndq4
 5157j+8WjQt/zQ5NvGdH79Q3QRAZnlSmuMqGWGpioEI8PFdqLYvWBsshXbf0IHznU2bm
 Vodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338630; x=1789943430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=quQ1ROjqXOesVl7wNiBN30U4SehH2NXzlCj3tCS7Nn8=;
 b=AJ8ja0ffm+QHboKIWMSujE/zKsshhNcUDFzwS9uBHJTjGM4SeNmSVtxB0VgLYHrg3K
 maugvxdXwDTzISoX8CgPHJmvi7UfwEvbXDVtTEZDGEqkBvMVxd1mQg1aRW0hw9SuAeFT
 C3RTAuAUBtQtC8j7iedpuIx3AdfLH4udF5gocU/NL2H8MSTRj+aCyVZYklyPAmctGUq5
 FaGqh5r8FsUQx5SuL8UMlAE7YpBrUVN9k9GlpkYWjnla2V59wJKpnTdrelDv3B49SYjO
 1hy61DBkqDQNPTo3fNWDLOxb+uV5emH+6A1+NPGBxkG7XAn8sNuQM8husF7Nwv09HhlC
 Lj8w==
X-Gm-Message-State: AFuF++lbse8lSLnckNx1J4/MB87xrYNVGcq7BSzS+ZT4Ah4dfplJ9HtC
 rX/cWHYb6c/Mw45+s+uySE/0WkvEShOCrSK4nx7nF3YWdzlBq00hMhZS
X-Gm-Gg: AYBFou1vEWet5/jqZqwtRQ0og4ByPcHqa0J+EEQplfG/u8wuicHwboBV7VXpNvKgpco
 0BEPgyiBAWIKTwMjeAk2zFcuhm/9dtN14nVVTGqGYPEoKYpc7fbi5rB6t5I7NkpY7Ugy4wSVlok
 Hhh/hjbih4eC2KfsaFXN/J8T5y+GC8+wDlhki5+pxyFd2JSRPMqt4s9kaptl9JBPz1Oy6axXSRX
 Ti7KXjBXpHlmmkMI4kSZF9Ll5PCAVq2BGJhwKL9N6SLxhVTcXR867/uRXYt8aN/NZ3eJ99515fb
 aEbW1Wmf2zRmaIHH5r44OoWtgPQykMxwVVqR4saJS/uw65VJVVksscDzYxQccig57b4HfaDLJE8
 Ts7HGyEqgm9q82FWdtNWP9W6zHw/gjNlIV5cks0XIgurE9pStG9h9WEDYdR6zf0kYOIEieuGaIK
 fCrXyyqIOyvDDxXH6YnBndwVBZosMkntAm/+fncBlKVL+ulS9y+Nazitr1UBhuV91R5cLCpRpoM
 HA=
X-Received: by 2002:a17:907:7281:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c29b85f7454mr6110166b.11.1789338630318; 
 Sun, 13 Sep 2026 15:30:30 -0700 (PDT)
Received: from beelink.. ([186.247.78.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:30:29 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 4/4] drm/qxl: validate relocation src_offset and fix type
 truncation
Date: Sun, 13 Sep 2026 19:30:00 -0300
Message-ID: <20260913223000.695299-5-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
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

The UAPI struct drm_qxl_reloc declares src_offset as __u64, but the
internal struct qxl_reloc_info stores it as a signed int.  The
assignment silently truncates the 64-bit value without any bounds check.
A negative or very large truncated offset is then passed to
qxl_bo_physical_address(), which computes:

  slot->high_bits | ((bo->start << PAGE_SHIFT) + offset)

generating a physical address that points outside the source BO.  The
SPICE virtual GPU then interprets this forged address, potentially
reading from arbitrary device memory.

Fix by:
  - Changing src_offset in struct qxl_reloc_info from int to uint32_t
    to prevent sign extension.
  - Validating reloc.src_offset against the source BO size before
    the assignment.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 9fba6e26d..6559ba7d8 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -75,7 +75,7 @@ struct qxl_reloc_info {
 	struct qxl_bo *dst_bo;
 	uint32_t dst_offset;
 	struct qxl_bo *src_bo;
-	int src_offset;
+	uint32_t src_offset;
 };
 
 /*
@@ -259,6 +259,10 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 						 &reloc_info[i].src_bo);
 			if (ret)
 				goto out_free_bos;
+			if (reloc.src_offset >= reloc_info[i].src_bo->tbo.base.size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
 			reloc_info[i].src_offset = reloc.src_offset;
 		} else {
 			reloc_info[i].src_bo = NULL;
-- 
2.43.0

