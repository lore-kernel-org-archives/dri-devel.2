Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D4606B9C8
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yov7ds+T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DA710ED9E;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3F010E25C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:23:39 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-170135e43c7so1890968c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794255818; x=1794860618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jj+ZuKIakpIecXslA+K9xsh0cQAuJwVzh7t+4VVhc7w=;
 b=yov7ds+TLeGU95TkNGE8AkNTl2faLhP9Y4TzEHKUjW4JvXrTo30OlLLVsE2T4C322Z
 vKdaPHTTh29uAR8hj4sHWuppHQhDHGu0F34+55lVrhjxq8cjxLFUfS5FfW9Iil33L6iI
 eAY7G3+dfxJ2hRiC9GxABmYIPQAuNtxGFlhHulTTjwyELqxnNSq1jcptNdevLaYIfHi7
 4iHONlCTIwzeg6g1lG6rgdnrCJfF5eXwiqEm2yCbFJ/RBwpuQ/8f2nf4Kh9AL3QIHuvT
 JQzXvIe3gUgrzCN2KmnObxQz0HQFTr+gLXpqW56xVaBIkr2YuVK5eQ6bGkJ8MevtKbPC
 IKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255818; x=1794860618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jj+ZuKIakpIecXslA+K9xsh0cQAuJwVzh7t+4VVhc7w=;
 b=xCzAxTpjvc9k0yRghKztIB0voBgWI7eddC8mIrqzzee67v/WH6lj+45sk+6mjiDVm/
 o+lF3bbhXT5aO3uDG7BpEdyikA1LLez86xyqPmvrznEM0qPh7Vah0VKCnqyo0vpGkYUd
 XBNRfPSPrQMUaUZd/niMxDWG+0LZ13H24vvUAL6fmHr3S7oDUYlGsVbaDGiQ3ZUb0/1n
 qLElXo08tNnzxPMgcD+hCXYQHSoqEia3Ik03LKPQ0eWGAA74wigHiL1h4Mf0dvO7myAw
 lM42KQJjHgBCCIc7B2B9gD6hOasQvI8kCqrt2PjUbfqbTwIf7Dfdr0wo8KbqIjjRG9k+
 fG7g==
X-Forwarded-Encrypted: i=1;
 AL+hErHczXsyFduysMyD0Dnb0ozaIjJJ9LVlO/ish6p+fmniI8X14GgdbM7hheLqV+iVH/Tl+hUeClWmt/c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9++oO+ijO+rdLdctSyh13rRBKi7DeDh7CtCQt2WyYlE/smjnkL
 UREYbW2m3MwzBoBmY8pzMrfrO3TusSoU/AbCnqGBKOLesN86yhMuerE37WstkeOtytM=
X-Gm-Gg: AYBFou0Rj+GMJJscJxePSNvA3RdX6+LuDy1eQaTDOL49MmpAepqWHt6sGFhyaAdEdNy
 ELJwIviAwV1mjhbqUrazrxGQVGADInT63tKdGqUbF+VDChAGO5TOgAdwoHsGAALkFesIfQ7XwJU
 4WYbKjjQJN+uB+h98yBT/h7OPFkQI8FK4dat+1KbcgJ5Q55ClmoFKWR+W6xjKHc1RkynrukZ4KI
 cFtx6nRwvu/LtTJwku6ZHao+QBFzzkwEA6hs35mYP3fGafsvrxPNyva4iUldiBIMIFF2qCfAYBz
 45gkyX7xvMFoUnWY3SmaY2Umq3R78NXs55arNHLSsNF3IKtH1RZP5UcdYNUTC7pGrVi55rFc+1Z
 nX1EVLvi+KQKpLPAc88WjO/fi9ShCDBeUwe8P7jC77voNtt2KfnmCLG21AmnDzbYqEmPLdpPP+N
 pqT9EzWHPOetCGTR4qaocwxwvNKx6maUTLuNKyY3YPrFSrflhMVxtpr6bWTbgokCVEBQa3wiCd8
 vsaSKiE1fZDGHYcnBmX8cK4rfl8bzJe7iFKG8jOyEmbqe3fv7zkm4SWtEi7fI+qDSS8kYiWh98Z
 +zqeZQIuEOhkDodu4uEwDVw9avzzFZ0SI+H9lZE2oJOzTm+7KsyUmQ==
X-Received: by 2002:a05:7022:92c:b0:165:aced:1fde with SMTP id
 a92af1059eb24-1b3b5bc4ceamr1248497c88.0.1794255817923; 
 Mon, 09 Nov 2026 12:23:37 -0800 (PST)
Received: from DESKTOP-6A237H8.localdomain ([106.219.176.229])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890584sm1520455c88.3.2026.11.09.12.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:23:37 -0800 (PST)
From: kaii-k <harshicon28@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: ckoenig@amd.com, thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 Harsh Parmar <kaii02ctf@gmail.com>
Subject: [PATCH 1/3] drm/ttm: check for NULL resource in ttm_bo_kmap()
Date: Tue, 10 Nov 2026 01:53:28 +0530
Message-ID: <20261109202330.1816799-1-harshicon28@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ttm_bo_kmap() dereferences bo->resource unconditionally (res->size),
causing a NULL pointer dereference and kernel oops when called on such a
buffer.

Bail out with -EINVAL if the buffer has no backing store.

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Signed-off-by: Harsh Parmar <kaii02ctf@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4..158f0df 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -435,6 +435,8 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
 
 	map->virtual = NULL;
 	map->bo = bo;
+	if (!res)
+		return -EINVAL;
 	if (num_pages > PFN_UP(res->size))
 		return -EINVAL;
 	if ((start_page + num_pages) > PFN_UP(res->size))
-- 
2.53.0

