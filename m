Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB1606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaKsTwoO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22A310E715;
	Tue, 10 Nov 2026 08:33:30 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F90510E8C4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:23:42 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-37000e7234bso1727403eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794255821; x=1794860621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/uS6sRi2Na5F+QsA+DIJ23tM8TuIrLzNxUdRjZ4yZs=;
 b=QaKsTwoO6ontYtMazS6eJ2yxvTzjMZC0f4/dt76pRCLROfAVr4dwEkN8ybm43GsRk8
 jvfD/WwqZPXHCQfKoAh1LqgM8MCz1uIXTqb3x+19uOOhW0oW9E7vhgnyQYG0+gtyahFz
 JcE4Ky65ker6XEi29QGBsvETSvvP/5fZGll9+7ZsIXNL+NrG/JctQ5VImt2YcjXdQ1El
 pN+2f0axvROsIroDhFAqZwOQhq/UlgQz+J7oo6A0vMpRjeieVXYlC+uHLPFJ3HaO8Tho
 wdko2oySO7/lvfz6hue+0fBABrfM/TacoXF+9ePzaN5oiWFARFji69GLSepziMsBhoha
 HFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255821; x=1794860621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/uS6sRi2Na5F+QsA+DIJ23tM8TuIrLzNxUdRjZ4yZs=;
 b=r+fXdtV9M5BQuxxKk6qkL66o+SfMQZgp285JeJpMwOmW9VPYeFv21dVtaVM4NlwRdq
 vlYjC2a8dY1P/KsnOg/xgFt+E261GKV8HbrLOcVps/7zaAw27BYNOPvO4Kwwyp8Kcmjx
 0S+DixlPTmm61pQpIS0u7THWLxvchOC1b5lleQPuggXzE4BaeUCX+Jo4ubR+nuSnCylO
 8LeBRXc9TKf+N871DaRBcF5J/zOo87PvrnITTq3B1GGfBViAoYtHwORsgNjkzTM2KjfG
 ecIIi7Zejip0Zi9arwWcgFFX28wxpSP3vxHHNfwpzH/cSpx0lWF9kDdL+cJOsye8mLEg
 FX9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGfy7GX7Bry9aHXXM7ioftyVfsyFocT6Vhq7vr/M5SK0YUNoUFuRVXSUemg/547EMzm789SZK62yvE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/fGtcv3M8fQxSfKEut9Y8uq8M+eZJS5pfYzJqc7SBXJL2v/QdU
 hIMmAom5oDQv+t/YLSYuNyXw3nek8yorKExa0JAJ3PZG1CByqvGbwZBX
X-Gm-Gg: AYBFou1ieYNXEgiTrsLJhbTncsGPq6g9Z8nelvNLz9dkV+g7G8nBT90ke+VGQX/COtS
 wpWuyvrLWmNqIq1FBsyEkCZQjfaC8Mszkc69dkgnnnyR4zPpySHtf0GgGAolAvvWjgX5NNEkcVw
 0wUt+vF3bIVrXVpQGTKdQxD7cJdN1JKfKNpBDeMUy5bVBleRxRNxAbxhlwdIhRtxCBO/LKDmPd3
 77VdeVYd7IZh2lHa3HpQWoXF0RtX9K3cHibCioba6ALyOSfVbGUSCN8hBFvWsGkjYuctUp4fxNx
 rknfRvt8kWwv4CR8sZkjeWh48nkzZAoj40d1JMBSrgSYcrT9PDxcGe3NAwI1AlfvnNrHs70ZH+z
 9UsSxxlZoCH9L1JagEqb2+AFm3FHOm7/Hk6p2sBMGAC/PM8t0V5AucFiVUYyh9OoEWzV9R7gb4X
 qXgGZUNyT4Wfw2j3bIqFGMReGuzXU79VSxcTs2Xfw/mskOt7Me9rGhzXaV9i24VBnTTiBowX7QG
 qGEyVW7ZMyDYYMicuXN+FmQxq2xk2hEJz2nwe3jlpZrQpfxl2P3WPLWHt2q7Q4/EijoT05YzMhM
 qMBO11VCFWbjeyGmwjhj94eRMp10voEFPsytp64ZaQ0ngyAVN/9Vag==
X-Received: by 2002:a05:7022:5f0d:b0:196:aa86:fcf3 with SMTP id
 a92af1059eb24-1b3b5fff1femr636103c88.26.1794255821257; 
 Mon, 09 Nov 2026 12:23:41 -0800 (PST)
Received: from DESKTOP-6A237H8.localdomain ([106.219.176.229])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890584sm1520455c88.3.2026.11.09.12.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:23:40 -0800 (PST)
From: kaii-k <harshicon28@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: ckoenig@amd.com, thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 Harsh Parmar <kaii02ctf@gmail.com>
Subject: [PATCH 2/3] drm/ttm: check for NULL resource in ttm_bo_vmap()
Date: Tue, 10 Nov 2026 01:53:29 +0530
Message-ID: <20261109202330.1816799-2-harshicon28@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202330.1816799-1-harshicon28@gmail.com>
References: <20261109202330.1816799-1-harshicon28@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harsh Parmar <kaii02ctf@gmail.com>

A buffer object can legitimately have no backing store: a driver may
call ttm_bo_init_reserved() with zero placements, which leaves
bo->resource NULL. It can also become NULL after the backing store has
been released.

ttm_bo_vmap() passes bo->resource to ttm_mem_io_reserve() and then
dereferences it (mem->bus.*), causing a NULL pointer dereference when
called on such a buffer, e.g. via dma_buf_vmap() ->
drm_gem_dmabuf_vmap() -> drm_gem_ttm_vmap().

Bail out with -EINVAL if the buffer has no backing store.

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Signed-off-by: Harsh Parmar <kaii02ctf@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 158f0df..01017e8 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -508,6 +508,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 
 	dma_resv_assert_held(bo->base.resv);
 
+	if (!mem)
+		return -EINVAL;
+
 	ret = ttm_mem_io_reserve(bo->bdev, mem);
 	if (ret)
 		return ret;
-- 
2.53.0

