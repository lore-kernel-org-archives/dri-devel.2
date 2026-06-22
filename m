Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF65CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C711A10E68C;
	Mon, 22 Jun 2026 12:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGiNokEN";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AD310E67D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:26:43 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so45840965e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782131202; x=1782736002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWBXR6ADAVQ2Qq7HEur2Os4QsmTGdoI3snIfzoQqpdU=;
 b=CGiNokENrfoSv/jqDWnBZAl+ycQWBBB60eTeLdpTRjiElLXoxqvCzKIAf+w/L4NfWt
 iPBc3oqS4pChZ3J8RfCc53VSpyS+YYi45WJSTwMu/cTDqW+WX6dbDE+zJCS0Hfktw9MW
 sgXKdp1SEtsgXvR5crRg51AFUBWPT9XQoXq77f0xcYLd/FLjuzlY2qtJ0eX/A4HsaFbN
 uTKRmcWkbpNRDRzxZ3KGRRxr1OVEy/wt4s7iykvTdgBF3xozMgkEE2CW7C2zgsvgV4DC
 MeNygw8oEoc2RNkXKRQdYn3AOgZW9XaTDuN008dH6GEZZKa8hLoczxRBm+uTCwoEm76S
 obLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131202; x=1782736002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWBXR6ADAVQ2Qq7HEur2Os4QsmTGdoI3snIfzoQqpdU=;
 b=Pb2Idync/FvfBuib4LU2vDBSN4Fi2uAPN8NG6WFe6Jz+j1bBEqadA+0mR0R42mc4Lg
 2efm2bl0gja7um76jri9RWhCm/bO25nQH/CG4gNlGfnOLrCeOGqoBPn/2KcljC98xRIG
 mxmbazUTfWIdoz5tGHFz3QchvxuXJUF6qPZp9xnVz8WWxQ7oCy3KYhc6rPn+GRfxvVkb
 xidaZ2aFOIrPtCEyKK21Gx93s49ZTMQGGUZXAuZgzy/2xnI/hDV77y9ezLPy1Z+SyvQr
 jKkV4WCX/NxYVDp/W3znnpLeGsS8fS+yn20IR7MUARpeyzrE1rgBcKWMnz0BLGZrbb9G
 0FMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iphWddridVJaynQCTTr2ut3WEplStYLaUHSbm7dY8EexwTnGXluHtpxY9Fka+eVGBDE+8LK1H9qw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxBfnTnKBPKScW/buP/lce8me3Yrn2HA0Yp9NgDRFO7/e2xYBS
 aNuzs3MnkPly9cfQrVb4WcLDyMPZZLV6z7TevReYx94x1TU1Sz9PyBCN
X-Gm-Gg: AfdE7clX0dpv9gYw5UBeq3nSNygMbIdy06oloYAt5g48SZ1Pmlu0qm6Lyjm+NeFCK99
 7Uuiszu/7deja5CHUYzXk90x2PfQxdQZypOvSepL0ZsgdcHAJz4qpo+OZ3s1d6/PM+2vDopVZJ0
 MQuX8Ez8fB5NuFrJe1pbflZVTXzI0+QQMvsvZWrerXW2vuzffuv4iPC0CE5jsMElWRMYBCZGllm
 Q7LSlUC1gHsmgqfCsbaJBpGiFGrr8zcNRZt569P7voTFbz+rrNhsq/pvo4gbalnJphjzrtFH8Ey
 oGGZxVA/frzG2t3dhCyOwSYZ1oeRuy4mB4+Lbt6E668gp85oWSd5cP0kZcHmiYDStvfLREhDcyc
 oShkVXko2H5ke9P+0yyOm1tvo2idWUKZgXr6VVhSvoQjPI56VJvcYrUCL3fUjC9VDZnllE2+Hpn
 DWVvBmqOo5VarUJJGjJ01Fm3r7nHjDxxcp98XrMg==
X-Received: by 2002:a05:600c:5493:b0:490:e190:38f3 with SMTP id
 5b1f17b1804b1-4924256fe84mr192162475e9.21.1782131202105; 
 Mon, 22 Jun 2026 05:26:42 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:26:41 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/3] drm/ssd130x: fix column and row end address in partial
 updates for ssd132x
Date: Mon, 22 Jun 2026 15:26:02 +0300
Message-ID: <20260622122604.32500-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622122604.32500-1-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
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

On partial screen updates, SSD132X controllers expect to get the
rectangle addresses as arguments of the "Set Column Address" and "Set
Row Address" commands. Each command expects the start address and end
address of the row/column in absolute format, however the end
addresses were being sent in a relative format (relative to the start
address).

The relative end addresses work only when the start address is 0. In
those situations, there is no value difference between relative and
absolute addresses.

Fixes: fdd591e00a9c9 ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index c77455b1834d..77aa5585a46c 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -864,12 +864,13 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width, columns - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width,
+				x / segment_width + columns - 1);
 	if (ret < 0)
 		return ret;
 
 	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, rows - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, y + rows - 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

