Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D2AC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF80C10EB21;
	Wed, 19 Aug 2026 06:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rXS7CkXW";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0497010E4E6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:37:33 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so2787312a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787071053; x=1787675853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtbdktcDMHK2UUilb3s7er2LASWhJy/LqRbzLHdr7EI=;
 b=rXS7CkXWLQGj1GZ03aLGbWmbwOSESpnL4f0W0GJV+DgzMyH4v2lx0wFqifHGKgvqf3
 Btimkxrhza7QZuuERaWzp8oGCpaU45fMLOx+MkD3Bn3o/qsKwmQF/18LnxdoNkk40Q01
 PjT8jeSSUWD62NvbiN2EUCXVTWFAq0QyQ4qdwLL8CTYjX7i9G8hLbMRUX8yvSemDSGA8
 C4K7xpkGSWgo1MdYqh2sGixKnFNcVv59jWCXfIYGsp2CC/yZ6QPbBm6f6qod7raQH8+o
 hoHVnjRHJzZeYGXhXmYL52u9Uo7DXVcBCGCP/axqDV2LmBy4B7rv7QPEc9lLAVq75MN7
 Frpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787071053; x=1787675853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtbdktcDMHK2UUilb3s7er2LASWhJy/LqRbzLHdr7EI=;
 b=TILTddSXTxsa9kFRsKVjK0A2SZF8um5A+w9nPaWY4osyeJjX53IEvNA2vm/SH4zr5F
 T0rXXX+ZdUwODHwhAaNzejU6YnTxnttaWtj3EUO3tjKRG2iiytGOKA+i/UqQnw0a+yUu
 7AQxnK9Avzbm1qEUQtAZT/b75bSan0jXx4hVXk/Hqx0J+9G7z3EpotaSfCqDzedtbsBw
 810119QJn8qlMohHKxWF/nlS/WV+44RUi73V9y6Opq7hkR135/jPYTCLfYsSZcZ7L+5G
 AbsUPTUFCs1gYr6PqqvVz5gH7uvHaud+fN4dm52PfK5NbyleYwbSEwC+pbIueHTSIUfV
 /DBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxoP8fnFjZqNNo3Hwjd5WzQ76nX/ttMs47HD851JoFOty/0Zxsxv3lRjs30MbPd+BHz5+IMNOgsvI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9bNeLFKm6OYIOBeDx7oiTPOHq9lUP3hH/NBTUDbB9wRpULMo1
 Ztx6YmXCLu9nwZqtDhKof7JtY12Z0Kz8unfw0h9eLccLxwZDh2JpxE5F
X-Gm-Gg: AR+sD13V3rnX+9HvVcsPacTPKlelTNjy19Bt6IsZdODe8Jw3Y5lvtvunfEgTS3Wswgq
 xsrj2faYnw2s9slbqbWgEzEh1nNDVWwo5r7HRN9kQjGxjxVu6j7eTiib8RJFPqVq7aDzRmdhrB9
 FGGbe2BDR9PgwRttoI8ZbE32Ab90zPEGpqRVvKdYCI2Kft2ByATdGuDMj6bIyvXm2F5bmMF0oQj
 ouMc1TTzm2TsLerJSJJkgAhldowITCH0hqZgJY4XYv01V3GFahoNDFvkzLoGqxi9ILAFS61hytg
 I0Lk3EiaQkGt0Zi2Fzmftxox+jl0xmayUM1GJrm1Cw9y/Ydvt0tt7w19L4+souivd/5KRg+bkbS
 ph3QvlYJAQu7qDezkxrzGZIIlHBKxDiXqJ7EQb5REkcFKGpscIdlNiS2OWLodBcY9eX5fTSCOU7
 ZThttd61ObwIoa4H2Io8FTF8OjiIj1sZdABg2Y2G4QCBL9cf/WKbNe2mtFNXCWgN0aPhXN4jNP+
 n5YbrSNFwwnUIh3WmRpz3h7FJduZ4L0aWQovm6yX6RDJEqfJtSSJM9YkrNlPVA=
X-Received: by 2002:a17:90a:1547:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-3954de91bb4mr13085012a91.5.1787071053346; 
 Tue, 18 Aug 2026 09:37:33 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531ff679fsm9195992a91.14.2026.08.18.09.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:37:32 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 2/2] drm/ttm: make ttm_swap_ops static
Date: Wed, 19 Aug 2026 00:37:19 +0800
Message-ID: <20260818163719.115946-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818163719.115946-1-seanwascoding@gmail.com>
References: <20260818163719.115946-1-seanwascoding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

ttm_swap_ops is not used outside ttm_bo.c and is not exported via
EXPORT_SYMBOL(), so give it static linkage to keep it file-local
and avoid polluting the global symbol namespace.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 943297b49dc5..1b9477381a1d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1449,7 +1449,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 	return ret;
 }
 
-const struct ttm_lru_walk_ops ttm_swap_ops = {
+static const struct ttm_lru_walk_ops ttm_swap_ops = {
 	.process_bo = ttm_bo_swapout_cb,
 };
 
-- 
2.43.0

