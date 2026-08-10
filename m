Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71354C5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268ED10E214;
	Tue, 11 Aug 2026 07:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O0liesbJ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00A10E25C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 21:42:51 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1517049f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786398170; x=1787002970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mAgyZghrLzvIUtwLqemCCKGCV+TdS1W6/V0Fv+KXADI=;
 b=O0liesbJQyZNwssugofNJAMlLjX6TNwWleNaP4cZPqHu35GvOZ10MJQUbc4/krhFQ7
 PTQ2SQtZqTiJUA+OVVw7zzH9yutKtd+03JcvC+Y/XGX6wWYbXSUNvgenacps9AEGcEA8
 xfBe9CDws5Rx+smEw4FBNoH3G6FMKe2fiUwsfRD9naqOXqf/tcq9MpCWUuAQxasy27tF
 IoYjPDN+gLg9SNmlyiqRpt89jStJVtexoHHYHBhu7SjzrTEXly2P6hXiH8Ua/lOp+r2r
 SGU6kxhSzSiq/9Pde55GumjprYWb7feG++Aubw1msCn1LvWw1rGCV9G1e1iErM2XCIII
 0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398170; x=1787002970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mAgyZghrLzvIUtwLqemCCKGCV+TdS1W6/V0Fv+KXADI=;
 b=i27aTzvGEtW7XY6pm2FJmWxj+zF1Dewm+he1YGsFAUH1ZOMmQFYYuLZh2igbCLwRYG
 F82MSToK3vPL0XNAKH6+XvOBBL9+EHhCUhatztgzzWyNWZnIrTyQnoqoUH5lOFLdu7Gl
 sE9pvzSYyaoDdGmikFwDO6ZIFh19RI0klbfITTg113g+j/s3VParP+EtjdTmCuMe02y3
 oFedsM6LCZylfb3JwXRmzuRrV01aOO1XX2MgntXguptllsT9cK+/Q0WhRyYwTW6jWutH
 KoqwSxaXCSvaqDoVfCLW/9UcnhL+x3IlfhpfD/53LbPVi4ALVoujgAMLcY17GWzkEm72
 R3aQ==
X-Gm-Message-State: AOJu0YyVtOJhtYxBxNVVhE2pMNWv5kY0X+tGrv3Bgi1cW7AsQsReawDa
 nsLvWata1I4fKoZtpCBAH3jG0AgtJqKrAr9x+zQHr/iyeZgL1hTCnc6f
X-Gm-Gg: AR+sD10O5H63fx0D+qXam0SDugzUMeLXHAOrdfsj+u0klto39Z2OeTgkQfA0lKiOofB
 px9HIYReYJ05aMXql1hF4l8eFGCoSSQkL0HwK/5A7gRSQ7wPYOw964yDAg2ybL7X6gETYifcucP
 kJfV5Oa6YpCX88rwRkwJvLX0JcO03sv9c+rpwa1nr25RsvGDTmIXGQYIG4h4IGdesVB6PP3QTAT
 EeX/ymHyqRAbl8YviKm3zEhQeFakXLht6LX/ESE/Seec9OVwv84lA0RSvS0ZVZRRV1A6kAtiRbT
 BKoVOPOYfaqRxZ9r/7RB/M8Ol+XMeGgpSNItNQHU/MKQvvbN0xug/QqNuu+xICy6TNd6ywp738P
 R8t7YxK6SrHGUFdUQhkLQIOKWY37UEFF7KcbL+1OouNhB3Mwl1dKvxrYsj1T73kSnaiH7fBHOWf
 F1boxz0+rXltrDFlYaClr4q6OJgJYgJe1xcPsuHNXRSI5gTJAejk3MKxGApitRv0IoG3x186tD6
 Nq8qyX0AbsqBUnB3gfSlFntWC4SJAakpgGnQ1w3hqJzGRJR68ON6mbT
X-Received: by 2002:a5d:5d86:0:b0:47f:8fc8:a8b1 with SMTP id
 ffacd0b85a97d-480026c89d2mr30573171f8f.14.1786398170143; 
 Mon, 10 Aug 2026 14:42:50 -0700 (PDT)
Received: from localhost
 (lewi-30-b2-v4wan-171487-cust1241.vm4.cable.virginm.net. [80.192.28.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e902dsm39534359f8f.21.2026.08.10.14.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 14:42:49 -0700 (PDT)
From: Muhammed Sariyildiz <asiyee994@gmail.com>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Muhammed Sariyildiz <asiyee994@gmail.com>
Subject: [PATCH] drm/nouveau/clk/gk20a: fix undefined behaviour in signed left
 shift
Date: Mon, 10 Aug 2026 22:42:47 +0100
Message-ID: <20260810214247.21416-1-asiyee994@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

MASK(w) expands as ((1 << (w)) - 1), and GPC2CLK_OUT_SDIV14_INDIV4_MODE
is defined as plain 1. Both are used, via GPC2CLK_OUT_INIT_MASK and
GPC2CLK_OUT_INIT_VAL in gk20a_clk_prog() (and reused by gm20b, which
includes gk20a.h), to compute:

	1 << 31

Left-shifting a signed int into its sign bit is undefined behaviour
per the C standard (ISO C11 6.5.7p4), and is flagged by UBSan and
static analysis tools such as cppcheck (shiftTooManyBitsSigned). Make
the shifted operand unsigned to fix it, matching the pattern used
elsewhere in the kernel for register bitfield masks.

No functional change intended.

Found via static analysis (cppcheck --enable=portability) while
auditing nvkm/subdev/clk for correctness issues.

Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
index ea5b0ba..7a93f9f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
@@ -27,7 +27,7 @@
 #define KHZ (1000)
 #define MHZ (KHZ * 1000)
 
-#define MASK(w)	((1 << (w)) - 1)
+#define MASK(w)	((1U << (w)) - 1)
 
 #define GK20A_CLK_GPC_MDIV 1000
 
@@ -79,7 +79,7 @@
 #define GPC2CLK_OUT			(SYS_GPCPLL_CFG_BASE + 0x250)
 #define GPC2CLK_OUT_SDIV14_INDIV4_WIDTH	1
 #define GPC2CLK_OUT_SDIV14_INDIV4_SHIFT	31
-#define GPC2CLK_OUT_SDIV14_INDIV4_MODE	1
+#define GPC2CLK_OUT_SDIV14_INDIV4_MODE	1U
 #define GPC2CLK_OUT_VCODIV_WIDTH	6
 #define GPC2CLK_OUT_VCODIV_SHIFT	8
 #define GPC2CLK_OUT_VCODIV1		0
-- 
2.43.0

