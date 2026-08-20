Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2399C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4548610F11B;
	Thu, 20 Aug 2026 16:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B24uFRo3";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2087B10F121
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:51:06 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso116029f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244664; x=1787849464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xoij1rKhFdJD5+LmFn+9RDZC5MZ7psm+4aCRvb4W/Ds=;
 b=B24uFRo3Hzxj/IeGZ+KSNWWzGUoQIp79kKLk0zHDNtq+Am8N3GIRhVEFOExKPgt/jL
 6peMJnGVd7PmZagDvlGrTtX1KiArenrfn6feANKRuHbPB0II3qel0mBGfr/zr+M9+Xy8
 ZLqeq5jwgrA2LINmRQprB+7uI8EEAX3Y5FQ8dKsCQegOaJwsaBH9cPUMsh6si5IFedvR
 Cfbshl/gbf2Vlf6BS1VvOgcwuleFEoVtc+TFVUYLZZNkLuFKDWjHn4cTs6gzHOisLQz6
 eL8I0ZZEDOHqUDdP5cSlYN4zkmINkGdh6h9VKe0bzw+ykq/U01Uadu5awHz9NSPvWzwn
 ahmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244664; x=1787849464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xoij1rKhFdJD5+LmFn+9RDZC5MZ7psm+4aCRvb4W/Ds=;
 b=kD/i2YgfHdtDsmY75XUIp6eHYXe72L6dMefQPgtFDKgyvyRjfUcWkLshlC+phJYJ8C
 9iGuTxAxjwnPVr+pkIsH2G1soUla4nhzM3vtSRG34TePrbR0ZVoYd5aAJHObPACtS088
 Sd+u7CkNNcblkFR8jQjxazus7kSqPlS8k8if27U874DEy93eYXUn+xbn4tVrwt3ApaFR
 2NK5jAoIalAMXvFZ4S04R4aQKz5kF1DWtQU0p8PQy1swwyA+Bn4JqY4Oy3hyQ8J8FWNw
 mrSWx1W+Tf28MvLmLjqDUe/NGtG5shPCHZKuQGIUk5TIjR9EjN42SAKrOs9G1UCDORW8
 Z44A==
X-Gm-Message-State: AOJu0YzCIzUh1ugtjVelbyrPmGaV70SEsxPqlkLrZ75IPH5soUZHd6Li
 LK9Qg2nEWKyZ30raHER0cSJCX2KRIoA53RWCeK2pSW3pYC983sTzmbFPkMyje7JK
X-Gm-Gg: AR+sD12lx4IsCsFJLgC342wW3cVPU8RVhuK3YFi6tsrBkBQ7plLapCnCvPZitSpOQw4
 XC/cupUE4dbqeoqE7Uxu5T7YvrjIAhUTCpethNOZyugr6RDxU+eBkGK+pHUZYxF3njnQZEYXcDO
 aeq4llZk17efH+WjHSQxrmdHsZEmGCGg/+wQGkftxCMh7pzCRQ+itQBeXQcetcYDuB06k28i9of
 oFK4crPmgFJlmz1+u1j6sJXdXoggGbaTeZvh1KSqLQn9mECCJ3hZBuWyHbWbTC0HE89RrptTvxR
 qiBW/NJB9S+xJ9ZmNCg8IqI/nclgSEFDWxd6gzBJbJ7zUQi6pXIs02SvgWUiN5Dw2mtk8Fv5YWj
 OVGeF0wFvnK6W6ccZnB64t7jx1E2wBkIrJivN7bSx9PNiFDqR7OtdPzBJhgI54OpnmRq38H4c8D
 xqO+KSOvInlkFGezS/TOKph52EyyfsRJsWrUu8MMr7ubDCJ4GXwo+FyZ1hObBnN17mVTc=
X-Received: by 2002:a05:600c:c8c:b0:499:af7d:b759 with SMTP id
 5b1f17b1804b1-499b845c91cmr3249335e9.13.1787244664550; 
 Thu, 20 Aug 2026 09:51:04 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:02 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v2 09/10] drm/nouveau/dispnv50: program pixel clocks above
 2.147GHz on GB20x
Date: Thu, 20 Aug 2026 20:49:28 +0400
Message-ID: <20260820164929.17117-10-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
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

The HEAD_SET_PIXEL_CLOCK_FREQUENCY(_MAX) methods carry only 31 HERTZ
bits. Starting with C97D the upper bits live in separate
HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(_MAX) methods, which nouveau never
programmed and headca7d_mode() computed m->clock * 1000 into the 31-bit
field. NVVAL's mask then silently truncates anything past 2^31 Hz, which
means that every mode scanned out at pclk modulo 2^31.

No mode nouveau can currently commit crosses the boundary (an
uncompressed HDMI FRL mode tops out around 1.78GHz at 8bpc), but this is
a prerequisite for the upcoming DSC work, which makes 2.147GHz+ modes
reachable.

Program the full value split across the low and HI methods, exactly
as OpenRM's EvoSetRasterParams9() does (nvkms-evo4.c, 31-bit low word
plus the 4 HI HERTZ bits, giving 35 bits of range).

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c   | 21 ++++++++++++++++---
 .../drm/nouveau/include/nvhw/class/clca7d.h   |  4 ++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
index eeaeb15aa664..678cbc78ca9f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
@@ -219,10 +219,11 @@ headca7d_mode(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nvif_push *push = &head->disp->core->chan.push;
 	struct nv50_head_mode *m = &asyh->mode;
+	const u64 hz = (u64)m->clock * 1000;
 	const int i = head->base.index;
 	int ret;
 
-	ret = PUSH_WAIT(push, 11);
+	ret = PUSH_WAIT(push, 14);
 	if (ret)
 		return ret;
 
@@ -245,11 +246,25 @@ headca7d_mode(struct nv50_head *head, struct nv50_head_atom *asyh)
 	PUSH_MTHD(push, NVCA7D, HEAD_SET_CONTROL(i),
 		  NVDEF(NVCA7D, HEAD_SET_CONTROL, STRUCTURE, PROGRESSIVE));
 
+	/* The FREQUENCY methods carry only 31 HERTZ bits; the upper bits
+	 * of anything past 2.147GHz live in the HI methods
+	 * (EvoSetRasterParams9()). Truncating would scan out at pclk modulo 2^31.
+	 */
 	PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY(i),
-		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY, HERTZ, m->clock * 1000));
+		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY, HERTZ,
+			(u32)(hz & 0x7fffffff)));
 
 	PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX(i),
-		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX, HERTZ, m->clock * 1000));
+		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX, HERTZ,
+			(u32)(hz & 0x7fffffff)));
+
+	PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(i),
+		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI, HERTZ,
+			(u32)(hz >> 31)),
+
+				HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(i),
+		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX, HERTZ,
+			(u32)(hz >> 31)));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
index 0fec6fc21d44..5754878ddc69 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
@@ -734,6 +734,10 @@
 #define NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS                       20:20
 #define NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS_DISABLE               (0x00000000)
 #define NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS_ENABLE                (0x00000001)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(a)                             (0x000020C0 + (a)*0x00000800)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_HERTZ                          3:0
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(a)                         (0x000020C4 + (a)*0x00000800)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX_HERTZ                      3:0
 #define NVCA7D_HEAD_SET_SURFACE_ADDRESS_HI_CRC(a)                               (0x00002150 + (a)*0x00000800)
 #define NVCA7D_HEAD_SET_SURFACE_ADDRESS_HI_CRC_ADDRESS_HI                       31:0
 #define NVCA7D_HEAD_SET_SURFACE_ADDRESS_LO_CRC(a)                               (0x00002154 + (a)*0x00000800)
-- 
2.55.0

