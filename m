Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FEFC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523A410E428;
	Sun, 27 Sep 2026 08:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AxhI6dqc";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C2B10E425
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:27:24 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so246599a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790497644; x=1791102444; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JKGd2FIRUe9e0cEAg2ix6lWvPWTo/rywpHY3UIN6DA0=;
 b=AxhI6dqcpGHAQPREpbZIbPu8yJkgcIA97KbuPfOUUJo2lJ4n1puunfxKYGAG8m1Xjd
 0xG+3tXUUbexuJdVVoILR0maEMrxSZQPoUHvOhi5quKb8E9GcJtMmPTeaRrv8OXXibLp
 0ebi3Szyb5xXV5nhFbpbQxhopfHXM67TTL91WmBnqT1J7whmLsJlq7/s4qSbkNyqanIT
 YjeWlMguEEiPX+BqPIfEecdHYN96m8pVOD5GKMuxwP1tU2EKq7bJrgFLlDLwWrQ65xnJ
 GjmCHcrddMNOHChfTRhBdAEq03U2mpSUQ79IeR5wzB6LkNP2SxyK4K49QqItwDL5I+p1
 O+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497644; x=1791102444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JKGd2FIRUe9e0cEAg2ix6lWvPWTo/rywpHY3UIN6DA0=;
 b=UNn+Fd6xUs74/vxdwEkK6/2b1kh54YMZCaufByo2RC65TeC7NvBLO2o79j5vobvSlA
 4wzhoFgvw+Cb+8MKLKHOypi9LGxfCTTZZSIWqVkL/GfFl0+4//KY4T0d3mpN3DsBiFqX
 V25E53eP6+2UloaxPbJp0Q0nPyqSqtxV01YtFwjm2BReZEPpdvblOv2kCnPk7czmXqX1
 T2oZx4uk+dcICfzwALh1zAGZYF9wO1ulBqcvOJ9zMl5e+YIEUGu0RCbIlEzw7xXHM4Ew
 rTZ9bEeTLGwEpD3nKwEwrWIwCpwrvLRvVxEAaaA5Nd6X1BSYK8uVjUNIoBmBTzS4YaKW
 67Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYBpE8JxF8f8RNN0Fuxl+trfuC4EqoA9jbW1Gb1DDfrk+UuP4BJTO5WK7azVHUHOR2jdWjLbREjOU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdf3mzI6rHxK9RGBhE6HkssI5y8j2+/2zIbBq9VFugOm4KXMe6
 +spPsNnoBIgap1jMyh17UglOg98qqbh6GxFCCTbys4X4gaNl+NgtFgE6
X-Gm-Gg: AYBFou1iNeL7TGVs+Ee0mJ8MTTy44AcUrcbd1vX3X+oraWeLosrVwZzDYFLBrwNGSLT
 PW5H4tRWrx8lYxf9VVhZkP+Q+PupjtKG+ELvbyBK8gMfyFSI+WEItNtzWdDKYlFzkx88yO764jV
 7OUsLuGIVAkZpnQHag5vbq/kV9bUxfWbSZPmms33opCJwlvdbo/WLMC//EuaqWIxETrWSRL1Dd2
 4KaTs1biXh40j/hOpDlEwJHVrUpoaEmsxl9KCj5T9e6xvGVKL77KkWeNmMOcQuIDoiiNkhKn6jA
 YBJPNls6jQHUcnrZFvWrNiZ3gfF88QANjxgExiZJML79F6mMEGuQOuLtL5heI8bZP73SVHQ5e6J
 mnGphPNJa3fA1PWRYnzDDEZmZgQJRhqEDiU43CSM/YBlxoUyVDcOYPgHUbzBxLjU0LLV5B7INVD
 OtaT085Fot+3m+mLzyU6ebQ70HUxJeg+9LY3bjmuCa+KFTqAgmE2DKJkFk2LL+0TapoWem80e8B
 A==
X-Received: by 2002:a17:90b:4cc4:b0:3a0:9640:8042 with SMTP id
 98e67ed59e1d1-3a0bb60e57dmr4980230a91.43.1790497644298; 
 Sun, 27 Sep 2026 01:27:24 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a2b1e4d5basm1921496a91.9.2026.09.27.01.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:27:23 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 27 Sep 2026 17:25:54 +0900
Subject: [PATCH 2/3] drm/imagination: Fix pvr_mmu_map_sgl() overwriting its
 own error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-pvr-fixes-a-v1-2-7f5b18ab989a@gmail.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

pvr_mmu_op_context_unmap_curr_page() is called here to clean up after an
error. Its own success overwrites that error, so success is returned.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 3cac482e103..3e494bfa936 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2553,7 +2553,7 @@ pvr_mmu_map_sgl(struct pvr_mmu_op_context *op_ctx, struct scatterlist *sgl,
 
 err_destroy_pages:
 	memcpy(&op_ctx->curr_page, &ptr_copy, sizeof(op_ctx->curr_page));
-	err = pvr_mmu_op_context_unmap_curr_page(op_ctx, page);
+	pvr_mmu_op_context_unmap_curr_page(op_ctx, page);
 
 	return err;
 }

-- 
2.43.0

