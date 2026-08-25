Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9679C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1E010E88A;
	Tue, 25 Aug 2026 00:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qI3UNohJ";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A6710E88A
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:15:48 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so2159711f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616946; x=1788221746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v+UheZ0Lyv0FjGXFOmgiG2WD4aRSJL9mFA1poG6PJPI=;
 b=qI3UNohJvKLfFUqj3TDCLyV07/G7RfJCejwiyr/6h1cDAeCut+0ha3gWiN8A0sWWkx
 +zto7JJnMfK/T1QsKV9l7rUFafGGinRbxclDBttRCnN4PdDPl8tTj7UA1vRu8zsOj98Q
 yvexu7pqWwwi09tCNZsIVh8Gw0ehY6GJMFBJaG005uTNvlp2+cU5tLkHW8hjITly/z/3
 KHVkXgcAqEYOb6BlBG4h/UsXo34g8hkkgamaqUO6T1Ufl4Vhx92nqnanWB62Ii9Xet+U
 jSgUqa1gIdaho5DxTA6Xrmgj4VwBaVgye7lpVYRwCL0nxdRdzZyRNnKvRGpxFbylwUaX
 NUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616946; x=1788221746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v+UheZ0Lyv0FjGXFOmgiG2WD4aRSJL9mFA1poG6PJPI=;
 b=JjsKrFnpAegWfpbLJswqt7R7bNtAJznJ95nL22rXm0kRJKE0Yhpr0DLVMYzEtudDIw
 ip3EsARzo7Firhl2MFNJCmLuf4gve5oPhA6OLRIu4pD5dFB1P5b/07646IzL8fC7uete
 /g2A7a+qyUT0wZrvuE7b+JTnqmx0h7o21ly0EZQv/DnySHbeKF8u0oyrg6LG9t6l00aS
 zWFtpYqiGk0c65D7JTQRq+cxQAHgDmSQG5j/nnVBhwTmiqTAjclHFqSTxozsppWf2jH+
 5V/HhXAJyJkoW9wMwqklzE2xyvG/ZuwGMrwHH4Ps2r4QVpOPTTFQHTwON00VUcY0lSo7
 ++yQ==
X-Gm-Message-State: AFuF++ltbz+V3tC3dgb9mgnrMpIDrafkxUyslsd6/uXqxgGaTNZ0+vcq
 l3PqBqnkaszxtNfnXuxQTKaONxnaZ3E7iMnt4bSWfM35MWi9Xl09kKQL
X-Gm-Gg: AR+sD12FHipzDxH10Xt28G+shSq2AcVK7AGbFLO53ky8poVLmtM26cFlDkta8RmHeJm
 DXcB1YL9aHOrdJ853WIZfrKlaL7Fqi/dR4BfWVVh8Ia4nFwf7C8NNCJpPNM0pVpd3GcBYcg00G+
 7O1fpL9xWmsRDPcPprXv1e7OZBff9HdAlDjn5wnTblqATr/6knbCroR7L59iLpsz3lDhI3A1j4y
 9O+U6zjRKZYboZpN/i/LIrB6iijvuhHd1jR/Be4bITR7RdKe326NIFIxO9oYH8/5W6vBbIinGA6
 9LKloycWdMZ5KiWC66N3dGyBxxtZO5yCVYe7onX5tn9N1BHIGH/Ap2rIElQJNl0T72tPhtQiCtz
 hD4skhi9J632cz/cuqcZ12xe271UsHb5VcWLvLR9bpdCipeA3Bl2azotLryp4KL8/7MOAlPtVWz
 KLWIWuqyEnkzqcTc3lyqRRL0TKSshQ8BTfmdaiokzoWDXSPLNxnvcBW34Awf6A9gFbhTI=
X-Received: by 2002:a05:6000:4008:b0:482:c72e:6af4 with SMTP id
 ffacd0b85a97d-482d9e97514mr2786420f8f.0.1787616946458; 
 Mon, 24 Aug 2026 17:15:46 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:44 -0700 (PDT)
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
Subject: [PATCH v3 09/10] drm/nouveau/dispnv50: program pixel clocks above
 2.147GHz on GB20x
Date: Tue, 25 Aug 2026 04:14:07 +0400
Message-ID: <20260825001408.14219-10-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
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

