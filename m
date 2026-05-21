Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2D2CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B88610F632;
	Fri, 22 May 2026 14:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eda3QdVS";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54D610E4E5
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:35:42 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so2950849b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779370542; x=1779975342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIK/4TSUzg+Gt9duY3olQGpqAgCO2S6UZFsGeUBiZ8Q=;
 b=eda3QdVS6rlW6+i2X7zCdlDaDzztXkjLC8OQpnJDYazmI2Mon7IKMSV9TnRhKs0RVT
 9UVxMYNFeJFMrB5j2M6AS7aEk8UHBEV+iUeFfIZvItbyJ4hP0xtDnjpTB4twO9R9npei
 2QSw8HesKg/swV1wOweczJcNrFQcGIySBenJufJXPP/oRzkNCP3elIcGs7uwXv270U1N
 c8ybHarWK9vOlr/5oY+ckEH8kkwx0Pe+F9zQd4bOAE2NzFfmGvIDeqYiWZ9rPy1vrf7o
 ZRbfvaPVQJ9vyhDdA8K20UbMUvNY1usrwBrBGGV+XXSm5KKorBJ324Mz+ZwrgQTwU9di
 q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370542; x=1779975342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIK/4TSUzg+Gt9duY3olQGpqAgCO2S6UZFsGeUBiZ8Q=;
 b=RYNWHIWkIGc86T1j7AkpoJVyX76US3BrJWlmm2qmb8I+iC3t/p0R12Er4phibMQVTh
 zyF9btggeM4PWy3LIopjDkyiDToAgf/saZ3egVEgJwv4xFlbc+nNWRQ8DbI0QX5+oNbL
 GUflP7kIAbDk2KsMtj7hnOCXeGDmjgSoM6nETTgCzkfGh2vnCxiNu5Y/EQ/xSxCoy+Bl
 4RyplMwWxFrmLzr1VILnW7pH0np67cWIo9APODtQKJzxOoxNbUcsljUhri/MzKHVycPa
 Mgbu47PpSVMWWZryGfUef2WlnBfuoTHMMK6IyykyakoB9DQHkp7GTncEMmQ5Ljc+akZ+
 AwmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BculTk/nYgEnRnREWUDfdAzIXSEyb3KfJprN4EA6phoo/kxb4mNe6qhG4VAuo4NNiAj+JLBo5XLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW82Lhyx/8Yyq6mzSAtqVRyLqbpIqULofdD359b8jc9/ePOUMR
 nKSbvaYSLuP0dKJ18M9n3gAywdAReduxf55w6RJdddJJaYqmUt6SQA7T
X-Gm-Gg: Acq92OGBoLQj0/EoeeR/UfzQE+I4WacZP64fYFtYqW60V/ws27qlsv5MruJRGgvDA+c
 YBfOs6yLyshzhQYo/ym/c5vE8Sv/ZflO6M1gYORDVH0GAFeCZbTCApFIY8gSzrR7VvOyElZjntR
 Jncgfd3s8oxpUMaQvQPfuF6MGgP3aF8HzYa1pNm8/+ATbSWwwz8jfUnBZx0Vvf11Qge4FvtWYp1
 i/C5lhHXl5U5ul7H7j8GuLwC53wZiftIiF4O0LurEMgaRpVBFJfAlcu3kH4mmZ2bShjJkEVHF1k
 aRE+oI5zQAwRJ55FxiaONUFYQa1ng6VWAvu5cBsuEo94Ldzje/fk1fNa9VnfvD1HA/4/4hO8p+I
 0XMeKY8i6WLV9I9T04iaigkxkWlbsMQ0MZ853SlQL/4Fdj7KmhEaBylXtiEU0mn6L22rg9/oaOC
 Nvm/a4X+wb9N7gwPYn04V6Ab6S9YOAcC+XSqvSK7CnGTtfaDYsN1NMP5wor1g=
X-Received: by 2002:a05:6a00:950e:b0:835:3f51:72fb with SMTP id
 d2e1a72fcca58-8414ac893c1mr3157356b3a.12.1779370542273; 
 Thu, 21 May 2026 06:35:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84154b1bfc1sm1286174b3a.26.2026.05.21.06.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:35:41 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: remove dead empty checks in ring_mux
 ib_mark_offset and end_ib
Date: Thu, 21 May 2026 21:35:37 +0800
Message-Id: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

amdgpu_ring_mux_ib_mark_offset() and amdgpu_ring_mux_end_ib() read
e->list with list_last_entry() and then test the returned pointer
against NULL. list_last_entry() never returns NULL. On an empty
list it returns container_of(&e->list, struct amdgpu_mux_chunk,
entry), which is an aliased pointer derived from the list head.
The "cannot find chunk!" error path is dead code.

These callsites run on the software ring submission path, after
amdgpu_ring_mux_start_ib() has linked a fresh chunk into e->list.
By the IB API contract, mark_offset and end_ib only execute between
start_ib and the chunk's removal in scan_and_remove_signaled_chunk(),
so e->list is non-empty at the read. The defensive check is
misleading and never fires.

Drop the dead block on both sites. The list_last_entry() read stays.
If a future change broke the precondition, callers would crash on
the aliased pointer, which is louder than the current silent error
log and easier to debug.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 6e64a96fa285..83d62d9f76d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -495,10 +495,6 @@ void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
-	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
-		return;
-	}
 
 	switch (type) {
 	case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
@@ -528,10 +524,6 @@ void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *rin
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
-	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
-		return;
-	}
 
 	chunk->end = ring->wptr;
 	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
-- 
2.34.1

