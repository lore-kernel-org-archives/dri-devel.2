Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277EC5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0878710E716;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC+ob3UX";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA23C10E17C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:26:27 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-51c1372f84dso24786091cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786980387; x=1787585187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5H9dh4FxhaHEHhhWqbPHlAZDZeIrPiXZx4M8+NdC4qg=;
 b=VC+ob3UXjcleRSJXeasVWJcI/oQ7dYC0VehH3/keFljOcbvECdiqPvFa5MoP4lvNjq
 kdHII5f6/Ik9a4w9EZrb01ZMVzzBqODzHntFKuPDRPmGH0fonPjrnr5U0tgtqJFqCPoN
 +vHoJTdHaThVRgxlykBjdy7qXc95xOMbsAasRIg59Ra70h3J1LsZ1dNfxODqlqjp2llE
 nwmvqno0e0gmJOzCBis8qWabpyFnsuAqkKuM7Ro+qnwLn+TaK7oGqG7a0dLG4VC6aWbQ
 lMfBaXLCJWgNN5lmCs75UitymHLYZLwNZTBKILBBJPvHVxAaelBnlUIUXRCbBwXdLKIZ
 H7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980387; x=1787585187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5H9dh4FxhaHEHhhWqbPHlAZDZeIrPiXZx4M8+NdC4qg=;
 b=jWhQXb6CPI1ZqZ9OTZT8lS/6Yzj//WBdeAjZMpfB0XuTGTXZWF1wK0k7UBakDBVExq
 Wi8VSsx5xXT4INEZ7w0taxoGtYRYNW4+gPRWY6JXFE973GSyG1i/tz69GGPl8eMVjd06
 L4X11K+BOrtcX7Ov/wM+ie58yyUOZJU4bEa76tMPQ0AK+ueVpE+kXfr2Ws3Uq40Gvxo4
 sg9Yv1pvy5/vMCzHHDzcd7RX0J49L05MjYyVOJrxByLYNX3vVuXUqgZ3V5DXirREf7ko
 F/hphWjAnpJoB84d6XiCIMNPx+8BJ9a6JQ/zR0YXGsZRN1VOtXSHiAZ1HeJrl77ZNps9
 OTLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKnORKuutaKTl3u4llZa281Ow6gaf4KFrJ9r8uUaOrLJiCmPaR489vsJRM223m137RFbaz71/BqI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTxg2/ILtqRi8mWRlrdPRuGMM4byNJJGcQx8amfWsvBUbVRyUE
 77DpsxZ1eOeZSFzrMNrqWCd4hIxfrqHAhI5VV6rl+yUzExkG6mlYBsZY
X-Gm-Gg: AR+sD10k8wPkJikRTkF57zh0QxxiPfTo5lPPEQd3XLQfDjkil6cr0G2YmKuknqVkVQB
 PRhBlvJoXsdFfw4ZWAtp2csBY0y4GF93kYwSMz4dpuzJ4QsmMfdjX+TWQyDQ+Ol3Ce0YOIOr2P7
 ZuIZs7MZqEn63jawfNqzHoXhuwpMe3rIV9a6pmUMHw/2cyFrxs6XC4HikPgzCwpG+r/aZ5jc03z
 I/QPQbUlOb28lnqpLmzDjM2ugBtr+D8xc4TyRUbGdQsX2wsdYFAnFWSBkW7eeqKwQT7I7vq+ZI9
 UzhWYBrbB9DSNkkp45CSviixRlQfPBtFPC0n9SGNPn03vm4Ik8/45w8Sxo7lnFy5B7eFDFarOll
 UawEUBS843QESRLx6Ys7wwn+d7uZ7cnBMAeyMKnVRHLRI1Ua66pRhWkXTvi2lemgb0H/jmB5a7c
 n/owNthskgHdjqXA1f/52EtSAwQdhZCiYRqkBBSgkdWznywhd6pcZFewLneFlZSerQ/5MuLCuwV
 mXjRgzXH8yNHlsPDFEtQgM3u8qZRm/lXKCx8755AQ==
X-Received: by 2002:ad4:5cce:0:b0:8df:98e0:4594 with SMTP id
 6a1803df08f44-90a91d5fae4mr262527506d6.15.1786980386455; 
 Mon, 17 Aug 2026 08:26:26 -0700 (PDT)
Received: from holowork.tail3176d.ts.net (static-68-235-46-81.cust.tzulo.com.
 [68.235.46.81]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c45950413sm11070806d6.35.2026.08.17.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:26:25 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Amit Barzilai <amit.barzilai22@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Fabio Piparo <holofermes@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/ssd130x: Set the address window in ssd132x_clear_screen()
Date: Mon, 17 Aug 2026 11:24:59 -0400
Message-ID: <20260817152500.703770-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ssd132x_clear_screen() sends its zeroes without setting the column and
row ranges first, so they land in whatever window the last
ssd132x_update_rect() left programmed. A partial final update then
leaves the rest of the screen uncleared, with fbcon the last damage is
typically the cursor cell, so blanking keeps the console content on
the panel.

Set the full-screen window first, as ssd130x_clear_screen() already
does.

Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Fabio Piparo <holofermes@gmail.com>
---
Exercised on an SPI SSD1322 under local enablement patches for that
chip; compile-tested only on the SSD1325/1327. ssd133x_clear_screen()
has the same problem, left alone here for lack of hardware.

 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df..256d370e240 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -900,9 +900,20 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
 	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_WIDTH);
 	unsigned int height = ssd130x->height;
+	int ret;
 
 	memset(data_array, 0, columns * height);
 
+	/* Set column start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
+	if (ret < 0)
+		return;
+
+	/* Set row start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
+	if (ret < 0)
+		return;
+
 	/* Write out update in one go since horizontal addressing mode is used */
 	ssd130x_write_data(ssd130x, data_array, columns * height);
 }
-- 
2.43.0

