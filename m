Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C06C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0F110E6F4;
	Mon,  3 Aug 2026 16:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGy1gUK3";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FA610E6F4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so15869905e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773473; x=1786378273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/c4A3W/yWJ8G63KpRNdKLfab7NwGTF+mRH1tOy5r8yk=;
 b=mGy1gUK3BKGtv39ANsVkAk3zYxRZh7lffIn0Xu2iuj3SSAzjwDZo8NSiu6shBN8XKQ
 EKJyIVYBM56b9lzAxts6EiAFjwetGYHJPDcopD0e/NjAtkFnTAdBVhgjz+DYQ4sYr9t5
 CT7JTITsx7CbtH1U/Lf0q7CwdeJVToHe4IJi1QqF1FefYYpja7d/r+bBiwvT22a7CZym
 lAyIXWn9gvnccUs2F3FScRC9wahIY1n4N/xkv8jHuE34P2y3wY6GWeCLq1E9ubHpwOKX
 FQd59M8WIDrvZHuUlQ/xbuSPGaT1G5lTJkA+uNRg8ZleefQc68l7LlFDjYzvGJyLcNYL
 L9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773473; x=1786378273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/c4A3W/yWJ8G63KpRNdKLfab7NwGTF+mRH1tOy5r8yk=;
 b=fkfCfuK8WihSWTbRkHaQPUZ9OW9x9elX4Y8U2eopvZO8Mj7W/0LLsAUhZ1SmaJre6p
 JHMbkkO7y35UQR4zbpZr62cNpNkvvs9/FWlcbtoC/xWo4N57xcEAAtC81zxGOVCRv1rl
 HDTwUh2ZMTxY1Ucx9uRSXXuqJT7kfUKEzaD0yi+zWgzGp9JfbWPRA5Q5AW6dQ74bhf9n
 XnxuaZgnrLEn1livfkFw6VX1/r1k7kI9r4nnhfzWGmeAOCaYRXUGJ1b440kyHInQD/k8
 waJcle/t6VaOK7vWAnwAG72wJDLTr0vrLUnkANBlksU8xH/jeFMt94oblJY/7wIYl5+Q
 7Mfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMtyxcvlLtoXyuCzlgfVynvX/aPd/mH/ZO2mhTTe4f+JnKOUVfwMjLP46d6vLYxjwWeiFDcTRGvcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgZ+3GlsG3EzIWqzBjiQq+SXkDQ0O3wK6ROzCFmANHRaPtvWEC
 9Wp/dPBEEKNzqVZQtYj4qGcthrGh3FD4iBArWrNNHP4ONG4XRwBeqJC8
X-Gm-Gg: AR+sD10O+lofhmhIO1G/w/sixCvDbcwnlMtWCIdn+njf0FvRMsVauflIpke1aT6TMtW
 m58/6eU0VdBPDWLBsf6QeZU4W9RIwkrFQND/q3QUFMMuk3FYK+mZK439oTwbOyUckMmj1KYxrsR
 J30L7tCrRGUcCCZLSKx4ARa6yfcfL+8fAQnMhm6kxSVTysgjWoIiS5CjjC6Xx0HQzD9UXXagChh
 xIcJwN+ZNJgaMyA/YYSbfwj5nDowuSC4C9GwbtwCpeJvqk4Ir03JR2PEV+xDSJzW9stqJdqig3T
 080gZAgx+SUK8fKxJkjDmXh4l/GPXkzBOfu5UA5Teha8y5uyGSOuZijaY3DS8MTog7xqa5p9eC1
 Y+cYkU34jBStmIknE8xqZQfQ9ClxK54dkgyDXwl4wV33bPXR36v4Gqf0inNpIc4fwKo3wKxXoCD
 4pdeD310gtxKbK7umkd0ayubRQqoCMY6UAmIS2kZ6aU4hcNq48tIPvtvlhYJZ9M+u/Mm4MdnuAg
 aVbtwug1u6NmSJK62R0HKtMpQyzuaW8/tU6qrV/cmm/j0uYJFEAAT5JjYTbbmqjGGLTsV28kkQX
 txjytRmGmLWOlDMnPiganjOn97adL94xp3ATxbdASMvLytsT3QIpdV1FDh+YrUKEfrJR/dasSu/
 +Owbpze2Nk+zMcP+zrDNmu+ltHsKJoUeg8MUBmCKyyoqc4FfNfIfl9nh3okNPuzaWfrvYmyOIzv
 E8nw==
X-Received: by 2002:a05:600c:4454:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-4980c64b6cdmr249435305e9.3.1785773472786; 
 Mon, 03 Aug 2026 09:11:12 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:11 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 01/13] drm/sun4i: Fix V3s YUV scanline size
Date: Mon,  3 Aug 2026 18:10:39 +0200
Message-ID: <75ad4947981f2dc33fd42c05ae0b0cedda7647bd.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

The VI scaler line buffer on V3s can hold 1024 pixels for subsampled
formats, not 2048 as currently claimed. Since coarse horizontal scaling
is engaged only once the source width exceeds that limit, YUV layers
wider than 1024 pixels are passed to the scaler unchanged and the
output is corrupted.

Use the value from the vendor driver.

Fixes: 2586de70c15c ("drm/sun4i: Add VI scaler line size quirk for DE2/DE3")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 4e4226295010..b6cd7352e76c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -785,7 +785,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 		.de_type	= SUN8I_MIXER_DE2,
 		.vi_scaler_num	= 2,
 		.scaler_mask	= 0x3,
-		.scanline_yuv	= 2048,
+		.scanline_yuv	= 1024,
 	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 150000000,
-- 
2.43.0

