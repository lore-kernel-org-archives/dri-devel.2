Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB72C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B784210F797;
	Fri, 14 Aug 2026 23:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h3WxaGuO";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0AD10F77C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:59:07 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so11840975e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751945; x=1787356745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjOzV0q5U0Ngoj2QziahFo4rb8HC53Ty4Vt3SiFJTto=;
 b=h3WxaGuOieE34RZKuwWkjRHsg6BbN70XI5L/UUhI5t2uG1gc6OIoQ/ujEaZjXiRN/d
 G0+g3o+43KCNKGaBWNfcs4ifvJugJmC42w5n4zGX+drYAzXreGnMfUYgr1BQ9xEb7z9q
 jQWSdEWkYfclUq7G12yN+IdyCQyK2YN0jGS1YKD/VVr2khvVnxMtA8eemWoMof/AVGxf
 kXMDUCm9rAIzOOkcXaly2Qn8cQXNLSJf6tx0ZyC0t4UGjA4RoXhqAOyxnocxhvxlwxoT
 8s7wYCij3nY8nXIQNm5yRewr6x1MO2BD9q/3nN2KHa7tVdHiHxqm3li8wIxbllUBkccD
 z8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751945; x=1787356745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wjOzV0q5U0Ngoj2QziahFo4rb8HC53Ty4Vt3SiFJTto=;
 b=BZuMrUG7eq+OUPjkiwHSm0kjY0QJC8onUZM/bwNaNumiQwJT0/2uYTBB78uj2qszUS
 Ws0SiolJYHWdAaNPd2NCnJAIgVRqBVp8piLdg3z9x0J82dt1fNRusEwc3GRhLN+RLYCK
 TbQluzI+5aJCUYQcZA7KTcsk82e/JP9n3KXmamKnTjBjUq5lZVhWVmUosNFumAceLNPh
 bt1LIf00F+3KhH1reCgBEAeLlpwm/2dbTBH6oDbfk3A6dOmUGxru0uuYIGbWR51hWBFO
 MIyqznE2CWeMvsEqinD5My2NFMKDc+AZRBCO/S8kyknK/aHJ2lrBaRZ/wUGp8CxkIHMr
 GnqA==
X-Gm-Message-State: AOJu0Yxg/qlsqeuVXy66Fht8K37HcbnXtuSNC2R1UHQWknYRVZtk+9Fk
 Tbq5RuAMI7Gi3OOUcOe7atk/hOTvQ1qj/9od4pkf8I/fpSQPVwvyYMEG
X-Gm-Gg: AR+sD11HPa2GEQk2iN6Lk0TZRXVyaRcJD/2frfQLCtZdcZ64vMbo0sXyOAKpfOz8Nul
 XmvMA5NSGgIQe5lxBvZMIs1qokNKNDy434nMpF+NbLkggRvCb5iStm+NZQ/jjhEz1FGZvD7ZuVi
 47gLpGFBoOgGMcpKdFHQ7M6Lve0zztcfCex1aKiKk5AYSrhqvLlIpz8ETyWE9USEevF3GApHR/7
 0V1niZ09CopL2JcVurcIdmo4Wclryhocw4rUtLS04d30hKixp3iGVMg8v7lb7Csoqw6c7TWPABc
 hJLlQhMaEUgfZ+XQxahd0dObrD771F1Xm5qeStZbngLE3ht3Spx35HxzMLi6D/fGuJiKxlqRMXL
 tdcZLA76gDjUNTlIZbhVIN7LPCTYGZ4Z8px9bKObsm3oQGL3OvRdL6Uo1SJTJjZki4CPnRazrEP
 vIg/aVdr0Xkv50EOMZrbW40WQxSSY3d65MN4TuWvTI2NGV0aTMhal8FgCSHLK6F6rMPpo=
X-Received: by 2002:a05:600c:3114:b0:499:84fe:5f3e with SMTP id
 5b1f17b1804b1-4998795c12bmr121642805e9.9.1786751945540; 
 Fri, 14 Aug 2026 16:59:05 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:59:04 -0700 (PDT)
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
Subject: [PATCH 6/7] nouveau/dispnv50: program pixel clocks above 2.147GHz on
 GB20x
Date: Sat, 15 Aug 2026 03:57:04 +0400
Message-ID: <20260814235705.59132-7-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
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
index eeaeb15aa664..2046e38a4d79 100644
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
+	ret = PUSH_WAIT(push, 15);
 	if (ret)
 		return ret;
 
@@ -245,11 +246,25 @@ headca7d_mode(struct nv50_head *head, struct nv50_head_atom *asyh)
 	PUSH_MTHD(push, NVCA7D, HEAD_SET_CONTROL(i),
 		  NVDEF(NVCA7D, HEAD_SET_CONTROL, STRUCTURE, PROGRESSIVE));
 
+	/* The FREQUENCY methods carry only 31 HERTZ bits; the upper bits
+	 * of anything past 2.147GHz live in the HI methods
+	 * (EvoSetRasterParams9()). Truncation here scans out at pclk modulo 2^31.
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
+			(u32)(hz >> 31)));
+
+	PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(i),
+		  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX, HERTZ,
+			(u32)(hz >> 31)));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
index 0fec6fc21d44..1ab12d91c9d9 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
@@ -653,6 +653,10 @@
 #define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001                31:31
 #define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001_FALSE          (0x00000000)
 #define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001_TRUE           (0x00000001)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(a)                             (0x000020C0 + (a)*0x00000800)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_HERTZ                          3:0
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(a)                         (0x000020C4 + (a)*0x00000800)
+#define NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX_HERTZ                      3:0
 #define NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS(a)                                    (0x00002030 + (a)*0x00000800)
 #define NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS_CURSOR                                2:0
 #define NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS_CURSOR_USAGE_NONE                     (0x00000000)
-- 
2.55.0

