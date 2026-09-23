Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD839C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8F410F058;
	Wed, 23 Sep 2026 13:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m10cbIsh";
	dkim-atps=neutral
Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com
 [74.125.227.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5C410F058
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:50:13 +0000 (UTC)
Received: by mail-vs2-f40.google.com with SMTP id
 ada2fe7eead31-7a4fb331cc0so372436137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790171412; x=1790776212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
 b=m10cbIshIcaniJhtrPXmgH5N2loPm/n1AIFgjs0IngXebtC4AdJrRU/D6ApiXCbeWC
 xlYGIbITHh5e/JH040wh0cyuSsfwTrqv7LFeKvw2QxkJxa9LsybXVWqnCkhM6QigonQH
 GqtvzOcLHcIZAm8e2jzYJHcGOI6JeJWul6RdrLd1fkMqZ7xWaDJ68VgA3cp12WAE3kCo
 Sv8/VsjPPgSXrjiX3n/uowgNdPIPc/rfwUEQ/xHSGZG6CPPrY7Lafnl0wmtTK0oYTvjp
 VZZLm+rybogteqzYwDShJ2BGDncVIkvqYNwfE7AFhiyi+ZJLGAgPOiKnqV5XeszFjo4h
 GrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790171412; x=1790776212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
 b=kCe9/xwVlBic4SV0z/uBuBCInX1vr3YCDUzStAuYnTCrcBqNwas61J9JpNW464tXIk
 Zfhmb+LfEnkb1zHCAK4KcvX+PB7CR9PM96rWotY/H2g6lZ0eKBgGMU0HpPmjkb0zjQZj
 zypbfwLP8SNPPBxZ8w0JDikVWWyVZXMoK/DElYZF255b8yL2iFQc14adlCA0WCNP/bBj
 c7yDLDF3MxZYHKrxtSetZKHksbHDpgjA0vU5p7D5nnxlYpsIrCRoQUlv6wV86aApeRUT
 Y3OAhPOXHHUiiO2fq3ti+my0gmP4sr9Qyt+94x+I/hQYFumvN+srOgWROJVz0azjIIWX
 LL7g==
X-Gm-Message-State: AFuF++nmgZ2eNlEVyEWHg6d4WfWM8mfJMj9PI0Qa7d5Ufu3RtfZ9dv99
 46zUtWkILJ1a4A/cxxOfBQ+2dRDez3qjjNuCmxYBbeoKgynIAoHcA0ao
X-Gm-Gg: AYBFou0Q3xaxkEZYQQOD5dwBZPd6slI5w5CwscohEN3kkt/WFbTC+pW9argy8osoand
 iIMDnFKYjDISWk9DS2VAssK28V6PYnbok9xK3PeeM6UjfJ9dDt3tH8U6M5nYxxKfbw9i4dY+5Ev
 Dnri8MEp3AO8CSAwIy6/FKzYWgQ6jzur/yx5IYTDvLhgRJIDP72KUXbM59s7fDLKMgJYxGHTnWL
 jjfTohxgcKlAxQZtDQvTW7D04It11K61jZg2U0xVDbaKlyE/QPgH9xn8VxFUuEOHz31CNgPeoTP
 UaXBeap/sN20UeiZzf1C0cj32egEkiznV6bdGEnJmBxPTacukv0BEiaNJHU1+gxPIS9glPnheza
 y3sOw/I4PkMe3rcVGQrIja2kRpjXdTaaAxzsNZk+bNu5HvwhMHts1cqzrm2e4cd2BjTvF8Mfywn
 GZHQgwb+SQ8I1xbg/36YyED8qZg8VnMS2r+buZIjjvnOLEusSX4xcyuxIalpuqpl8=
X-Received: by 2002:a05:6102:291e:b0:7a7:ad9f:53c6 with SMTP id
 ada2fe7eead31-7ac1bb4a3f7mr2276292137.13.1790171411528; 
 Wed, 23 Sep 2026 06:50:11 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9852407d1f2sm113126241.6.2026.09.23.06.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:50:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/qxl: remove double page-size scaling in kmap fallback
 paths
Date: Wed, 23 Sep 2026 10:49:52 -0300
Message-ID: <20260923134952.1750600-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
compute as a byte offset aligned to a page boundary:

    reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);

The VRAM/PRIV path adds it directly to the mapping base (both in
bytes), which is correct:

    offset = bo->tbo.resource->start << PAGE_SHIFT;
    return io_mapping_map_atomic_wc(map, offset + page_offset);

But the two system-memory fallback paths multiply it by PAGE_SIZE
again:

    rptr = bo->kptr + (page_offset * PAGE_SIZE);

For page_offset = 0x5000 (page 5), this computes
0x5000 * 0x1000 = 0x5000000, a 80 MiB offset instead of 20 KiB,
producing a massive out-of-bounds access into kernel memory.

Remove the spurious multiplication so the fallback paths use the
same byte-offset semantics as the io_mapping path.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 	return io_mapping_map_atomic_wc(map, offset + page_offset);
 fallback:
 	if (bo->kptr) {
-		rptr = bo->kptr + (page_offset * PAGE_SIZE);
+		rptr = bo->kptr + page_offset;
 		return rptr;
 	}

@@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 		return NULL;
 	rptr = bo_map.vaddr; /* TODO: Use mapping abstraction properly */

-	rptr += page_offset * PAGE_SIZE;
+	rptr += page_offset;
 	return rptr;
 }

--
2.43.0
