Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E41C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F7210EF54;
	Wed, 23 Sep 2026 07:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gm44LA/R";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367E910ECCD
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 22:56:01 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-93910a0cb7cso32074685a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790117760; x=1790722560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zOb7x4ygb83hEYoABya/SQC3FYbUHL3RXKH7jN2xAeM=;
 b=gm44LA/R6b94VQs+mZ6iZ9XWoDBvUSZCZuthO8ul017NaTJ/0ze+eNT7nyVc+b6VFk
 1UmowNK85jyEmrgxUci1JhpsZlfxGoGxkvcBjmCGizzF96K/pN2R/JK9rCF7vguVgcNz
 cN3YMKj1LEWrsXCv5KEXU39IgrX5Qz52aMoWnuGdyRqFZASJoTGRRmcdRi3pK9nFr2N5
 HEOBrvTk0HJaYzih2qRBAfFkV18gKQi/9TE1OM3IOhJncw2DAASffuDc15kNK9H/74Tf
 xhzNVIqHz9hD02H4SERov7EuYLwhPF8nq/jjDHBw/uDZjTBd0xGBd1qMLpnulqh5UvVd
 yDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790117760; x=1790722560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zOb7x4ygb83hEYoABya/SQC3FYbUHL3RXKH7jN2xAeM=;
 b=qfrncb0nOR94L8BHKsgl4eEIP0MaweTt7e37h+tVdvfKJCLEcmAQntXt2waS+sTtSx
 5MEvul2o3+FKjd7NVPK7Ag4LKdBABerg6qsO+oiuzokZa/sUYpS/lbxbmJQJAPfIwRYb
 BHG4j7+9XUg730LaGjEHrv48/hikzaJozBNBdVjhvsUMnUDx1xPfysaMsMYwPWWBsi/c
 q3BFiu06Cn+EcjjQ/TmHg1LLcEE2rb0P7lnUDSH42J6fW9hhQrZV06YvbGgtdpyDiJp8
 1ew5m28Unk99M98NFiK/SXUnsC90p6etL7H2sBak7pGAtf9HW35nsXgQ0V5pByhWrZyB
 k7GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmOK2vxx5i2N/PPtOslLT/QkWVwx3X7frMVkq86Mw+byjND4x4+9tS0+z0NVX+WoTCg23N763YtnU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++meXbQibxbhb7UOXctGjMoMbD12UcYCz6K0rKM9vHMlPXMVbDKB
 dXG90ouBOCO0zupzvj7sPJpFowKds9/TIu0/ngcR3lEKJGRcvoMeSLkQ
X-Gm-Gg: AYBFou177KLb2q03kyKvnCKv4bWQpif9qKgR7Lw9KwQ42LfJP95Ta5ZEp6KMdl6aICo
 zDiUZRAGp3K9rSNwvDRHqj2cAtYaTD8cjCycbrFj+wvatBGZS0kGSdwXTgw10hil1RZuhnjtLFy
 Sg7J42GocOots82VYCW4phR0xDUmuE6Wn5/asBragKk/BLZctvVHzU/NnIMzeuQVB5ujQPihPjq
 yK5b6qdT+k+uN51V2r53BLvQcPyChVL5Vb4QvGvkp9sS+TewUkhFhovHbhybcpYL2hQcQ6Cfwke
 BGuM9ytX1Ons72l8MhTMEFp+mwJIfklwpFXehT89SsoLwu3goFrzqA4rvkVJla9Vw5iN5fmJ3Fv
 1jqUPlgAasa2Y0jvXUMZUB/Mwo352m1cWZQrQqVdyEScpOeA2BguCqRmLVCHHLM+ATIv2PeS1Zd
 Pfxh1b1ge+iIHJ9PuKKcT9DN9aHER74NOQODFzG38OXwPyOHdhUnjnBhyDkvObjXA6bu0Yf903P
 dlOjx1tJlAHf1K9bkYpn9sLuQPVRZNMGCIYMTTd1RBAiA==
X-Received: by 2002:a05:620a:450c:b0:939:1d67:2231 with SMTP id
 af79cd13be357-93c251fc75emr141927585a.34.1790117759919; 
 Tue, 22 Sep 2026 15:55:59 -0700 (PDT)
Received: from holowork.lan (static-68-235-46-62.cust.tzulo.com.
 [68.235.46.62]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c417be4sm8201596d6.22.2026.09.22.15.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:55:59 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Amit Barzilai <amit.barzilai22@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Fabio Piparo <holofermes@gmail.com>
Subject: [PATCH v2] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
Date: Tue, 22 Sep 2026 18:54:45 -0400
Message-ID: <20260922225445.1525837-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

ssd132x_clear_screen() writes a full screen of data without setting
the column and row ranges first, unlike ssd130x_clear_screen(). The
clear is not reachable today: the plane disable returns before it,
and the encoder is powered down by then.

Factor the range commands into ssd132x_set_col_range() and
ssd132x_set_row_range() and use them from ssd132x_update_rect() and
ssd132x_clear_screen().

Assisted-by: LLM
Signed-off-by: Fabio Piparo <holofermes@gmail.com>
---
Changes since v1:
- Drop the Fixes tag and the stable Cc: the path is unreachable, so
  this is a cleanup (per Amit Barzilai, Javier Martinez Canillas).
- Factor the range commands into ssd132x_set_col_range() and
  ssd132x_set_row_range(), used by update_rect and clear_screen
  (per Amit Barzilai, naming per Javier Martinez Canillas).

The helpers do not keep the programmed range the way the ssd130x
ones do. That skip would change the commands sent on every update
on the SSD1325 and SSD1327, which I cannot test, so this v2 keeps
the wire traffic identical. Easy to add as a follow-up if wanted.

Compile-tested only; the clear path cannot run on hardware today.

v1: https://lore.kernel.org/dri-devel/20260817152500.703770-1-holofermes@gmail.com/

 drivers/gpu/drm/solomon/ssd130x.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 324467ae930..8cbf1875448 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -415,6 +415,20 @@ static int ssd130x_set_page_range(struct ssd130x_device *ssd130x,
 	return 0;
 }
 
+static int ssd132x_set_col_range(struct ssd130x_device *ssd130x,
+				 u8 col_start, u8 cols)
+{
+	return ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE,
+				 col_start, col_start + cols - 1);
+}
+
+static int ssd132x_set_row_range(struct ssd130x_device *ssd130x,
+				 u8 row_start, u8 rows)
+{
+	return ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE,
+				 row_start, row_start + rows - 1);
+}
+
 /* Set page and column start address for page addressing mode */
 static int ssd130x_set_page_pos(struct ssd130x_device *ssd130x,
 				u8 page_start, u8 col_start)
@@ -896,13 +910,12 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	 * the second byte are SEG2 (D1[3:0]) and SEG3 (D1[7:4]) and so on.
 	 */
 
-	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, col, col + columns - 1);
+	/* Set address range for horizontal addressing mode */
+	ret = ssd132x_set_col_range(ssd130x, col, columns);
 	if (ret < 0)
 		return ret;
 
-	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, row, row + rows - 1);
+	ret = ssd132x_set_row_range(ssd130x, row, rows);
 	if (ret < 0)
 		return ret;
 
@@ -1052,9 +1065,18 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
 	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_WIDTH);
 	unsigned int height = ssd130x->height;
+	int ret;
 
 	memset(data_array, 0, columns * height);
 
+	ret = ssd132x_set_col_range(ssd130x, 0, columns);
+	if (ret < 0)
+		return;
+
+	ret = ssd132x_set_row_range(ssd130x, 0, height);
+	if (ret < 0)
+		return;
+
 	/* Write out update in one go since horizontal addressing mode is used */
 	ssd130x_write_data(ssd130x, data_array, columns * height);
 }
-- 
2.43.0

