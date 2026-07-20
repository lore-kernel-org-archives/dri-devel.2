Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055CAC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0310E6AA;
	Tue, 21 Jul 2026 07:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=0sec.ai header.i=@0sec.ai header.b="bNKd0mll";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B87610E133
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 19:20:48 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495590dde14so17809725e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0sec.ai; s=google; t=1784575246; x=1785180046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nn308Uc42Dl57RP6Xi6iEgaOKqgEpx9JiKwuLvZ7d4o=;
 b=bNKd0mllxuRsDe6Hl9KFyGnmnG94i1R7vpB05cjIov1tIx1JC0pXyeYDANfrryJPX9
 wRhoS5rnjHrCgOhI0OSAtWsaoUEorFbslleZD/s6o8a2leP5IQvytSmcJQBYhhQvGg4m
 /dzmO/zeV5LIMpvvjB4d042C7g+XKgn2MiV+qJ43QzwW3Ydb/iutvflEjWDy16YvNFL0
 mG9d8ZKwfl6dTK1TL/R6ceJP2OoIxEJohjz7NyiOXKLHYSfJRLmvl+OhmlHAWDRjQu0r
 xVbrdLRwWYLXJA+F0R8yiMnSqMhVY6h2ZR88sY7chHU8A7FIABQF7cXLn841BtJZms9n
 f1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575246; x=1785180046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nn308Uc42Dl57RP6Xi6iEgaOKqgEpx9JiKwuLvZ7d4o=;
 b=cvOWY2CHWf9GkWzpwGY0sd0a+eIK3qmsvteAXh4wHohNSJ0TGA1UTeJFBrJqm8Z24T
 +a/HyF1QxMH5siB/WZDrhngwf+DkBg+2m+OCDuAhuQffs4a0h+x7IBbBL9tMgksfinLJ
 0Su7L9Et3c9rxhPMpTd/YHyTIaLmnutK94D4WXct5zuFSM5uDruo2oPQZl/2MhO+38y9
 pDvHeNJ7UbOXiHNzdVcngfyCaBMYJ5s7/QqJEvAqpmK25rJfOmrbsg0/rSwh13hE0xRP
 myrJ8vJEsWZEpgyRIVkfUzlJOHurrhpq7SJzSEzDy1kX2ZeawDGuR0mPbedE+jW3TVRV
 vQnA==
X-Gm-Message-State: AOJu0YyFfBtmbrK4ZsPXyUj34osbv2JIQ15awo7oBScIRKtt9Z9Xf2NY
 klUoe2inOdBZMBOCcQjm9BIHfyE8Fe24jnmhaOCW8MgrCebzuFXyTi2frAj1ltlyWkbv
X-Gm-Gg: AfdE7cnRWVztcc3I3rw3ANoV80uTRlJ5TyPPr4pdtkKwpe8TRyE//fsK5wVh60Xhs8z
 Y/ULrg2juz74EPmd8AL61d9motqM3miAXNRMB/0mWLfVeMaLFU+lmTmGJKKkAo/EoLCCa1JYiHc
 +OFTekZyb2DFMiyOwb05miQTffmLqeerrNkju6l8JOA6wZR8a/NJTmbB45alGxqUcERFYEnYIH4
 Tbmc1hwErxjVxf8BKeg0l4Ub0os9pcPuiGYCEF3sNCyCN+0wevbQkbXwxkAJFKZc+jCoCSwzdTm
 RCl6DHFORXgcvNmiTIrHFUrodPvS+bMjghF7+iGA1DT/shHVzvstugae4rEhMSctyL28CyJW2Nn
 xTwHuMsglZ7nXMc50fBciNqvIxgRqObtM3OZPDX63Hjo3g+6XqdAYTH8Q3ie5NLm95nQmffunom
 ANwd7SopVClocIxItAUTj/II3SM16CjyupRl+PHKMGXG80Gf32p2y9kgFLDxNIrW6AmXqjiozMe
 aDqQ3bSgEol9uVHPQXgPqnU
X-Received: by 2002:a05:600c:1509:b0:495:3f5e:e7a with SMTP id
 5b1f17b1804b1-4954a51dee6mr121496285e9.34.1784575246312; 
 Mon, 20 Jul 2026 12:20:46 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bffefsm9693325e9.9.2026.07.20.12.20.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jul 2026 12:20:45 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: robh@kernel.org,
	tomeu@tomeuvizoso.net
Cc: dri-devel@lists.freedesktop.org, ogabbay@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] accel/ethosu: validate all tiles and the packed-channel peak
 in the cmdstream verifier
Date: Mon, 20 Jul 2026 21:20:44 +0200
Message-ID: <20260720192044.19557-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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

The command-stream verifier records region_size[], the maximum byte
offset the NPU will touch in each buffer object, and the submit path
rejects a job whose region_size exceeds the bound BO
(region_size[i] > gem->size). feat_matrix_length() computed that maximum
by evaluating the touched address at a single presumed-worst corner
(x = width, y = height, c = depth). That is the true maximum only when
the address is monotonic in x/y/c and the feature matrix occupies a
single tile. Neither always holds:

 - Storage modes 0 and 1 split the feature matrix into up to four tiles,
   each with an independent, user-supplied base (base[0..3]) into the
   same region. feat_matrix_length() is evaluated once, so only the tile
   containing the (max x, max y) corner is bounded; a large offset placed
   in any other tile base is never accounted for.

 - In the nhcwb16 packed format the channel term
   (c / 16) * stride_c + (c & 0xf) * element_size is not monotonic in c
   when stride_c is small, so the largest offset can lie at an interior
   channel rather than at c = depth.

An unprivileged process able to open the accelerator node can therefore
craft a cmdstream whose real maximum output offset exceeds the computed
region_size, pass the submit check with an undersized output buffer, and
have the NPU DMA-write past the end of that buffer (up to ~1 MiB out of
bounds in the tiling case).

Evaluate the extent at every corner that can bound the populated tiles
and at the packed-channel peak, take the maximum, and reject the stream
if any reachable tile base is left unset. Well-formed single-tile,
monotonic streams are unchanged: the computed size is identical.

Found by 0sec automated security-research tooling (https://0sec.ai).
Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/ethosu/ethosu_gem.c | 73 +++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 3401883e207f..dfc499d7fb0c 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -192,17 +192,19 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	return len;
 }
 
-static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
-			      struct feat_matrix *fm,
-			      u32 x, u32 y, u32 c)
+/*
+ * Compute the byte offset the NPU addresses for one feature-matrix coordinate
+ * (x, y, c). Storage modes 0 and 1 route disjoint (x, y) sub-rectangles to up
+ * to four independent tile bases; the caller must only pass coordinates whose
+ * tiles it means to bound. Returns U64_MAX if the coordinate lands on a tile
+ * whose base was never set by the command stream.
+ */
+static u64 feat_matrix_addr(struct feat_matrix *fm, u32 x, u32 y, u32 c)
 {
 	u32 element_size, storage = fm->precision >> 14;
 	int tile = 0;
 	u64 addr;
 
-	if (fm->region < 0)
-		return U64_MAX;
-
 	switch (storage) {
 	case 0:
 		if (x >= fm->width0 + 1) {
@@ -240,11 +242,66 @@ static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 		break;
 	}
 
-	info->region_size[fm->region] = max(info->region_size[fm->region], addr + 1);
-
 	return addr;
 }
 
+/*
+ * Bound the region a feature matrix touches over the coordinate box
+ * [0, x] x [0, y] x [0, c].
+ *
+ * The address is separable and, as the strides are unsigned 40-bit quantities,
+ * non-decreasing in x and y, so their maxima sit at the box edge and, for the
+ * tiled storage modes, just below each split (width0, height[]) where an
+ * independent tile base takes over. Only nhcwb16 packing is non-monotonic in c:
+ * crossing a 16-lane group adds stride_c but resets the in-group term, so the
+ * peak may sit at the top of the last full group instead of at c. Evaluating
+ * every such extremal corner bounds all up-to-four tiles, whereas a single
+ * presumed-max corner undercounts the other tiles and the channel peak.
+ */
+static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
+			      struct feat_matrix *fm,
+			      u32 x, u32 y, u32 c)
+{
+	u32 storage = fm->precision >> 14;
+	u32 xs[2], ys[3], cs[2];
+	int nx = 0, ny = 0, nc = 0, i, j, k;
+	u64 max_addr = 0;
+
+	if (fm->region < 0)
+		return U64_MAX;
+
+	xs[nx++] = x;
+	if (storage == 0)
+		xs[nx++] = min_t(u32, x, fm->width0);
+
+	ys[ny++] = y;
+	if (storage == 0 || storage == 1) {
+		ys[ny++] = min_t(u32, y, fm->height[0]);
+		ys[ny++] = min_t(u32, y, fm->height[1]);
+	}
+
+	cs[nc++] = c;
+	if (((fm->precision >> 6) & 0x3) == 1 && c >= 16)
+		cs[nc++] = (c & ~0xfu) - 1;
+
+	for (i = 0; i < nx; i++) {
+		for (j = 0; j < ny; j++) {
+			for (k = 0; k < nc; k++) {
+				u64 addr = feat_matrix_addr(fm, xs[i], ys[j], cs[k]);
+
+				if (addr == U64_MAX)
+					return U64_MAX;
+				max_addr = max(max_addr, addr);
+			}
+		}
+	}
+
+	info->region_size[fm->region] =
+		max(info->region_size[fm->region], max_addr + 1);
+
+	return max_addr;
+}
+
 static int calc_sizes(struct drm_device *ddev,
 		      struct ethosu_validated_cmdstream_info *info,
 		      u16 op, struct cmd_state *st,
-- 
2.43.0

