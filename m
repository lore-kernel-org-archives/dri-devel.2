Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281D0CA5FB6
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B3010E0DC;
	Tue, 29 Sep 2026 08:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HqJqDVa6";
	dkim-atps=neutral
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com
 [74.125.231.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2705910E0CB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:17:51 +0000 (UTC)
Received: by mail-oi2-f11.google.com with SMTP id
 5614622812f47-4bfec71901fso1454988b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612270; cv=none;
 d=google.com; s=arc-20260327;
 b=cUGMGr612WRQIU+UlYFhLTBix6ZOQ6wFrbEN3rENHyc0bOzWwDFTrGVTrjqe5243br
 4tM4iuZWmLvN4BWm3x2LYPkgpFjinE7tE+t4WEkdP2tAp+2/zXOjt/QVoELoH6Oe7m9c
 rmxuZ9mrDpmIZLcKPWdqVWbn4LBfk3JQu0is9EztdQO6ihjj/H6ohjdz5dLvh9ReRG0T
 M7r/hrNoHmnK1Oou2BAlWhrCS6jdYg8u5aqChPUJh6m4U54IvOs0lXNXRdRuInVXVNG2
 qGKG1AYx9jlxJ0lOuXy0IQmRHUENd3La2h3g+M07BpPmP5Y/xIyeVj5CmHvyHn4uoPMq
 Avfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 fh=W4AGbBzPNHYiJV3hEYKQP6t1vhCq2WfvhNmwOddt6Vg=;
 b=lYJuXGd3vtS1B4EcJI0ZL8Q6JjRdgigh2B39AtubILZcreHitOJNS+xNUz3YezGhig
 H0ljs/DtusOLTqyXSgDsqwLsKUUQr8ik/5wIeOj6T8okYpE4+V7cisgXoPbne2EewxuG
 CqZavPT2odIqdp5fPaZncmwsvTTDX2kPLKZhsHydrbOfchDRT3XTWOkwfhSNqOMqVpol
 4FOycySlvholF2HROe6bVQmhFZLLdnlGPQnbYAQCAC7Ek5LzABrqNKYFRls3UN9ryIwP
 yqe2/IcqBIgOSDbH5tEVxhiTUVMiP4ss5+aAZi2coCeaAGWHN0M4++/Wf75/gTnw91tu
 sopA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790612270; x=1791217070; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 b=HqJqDVa6BaI1ubFHx4rO0o0So8eaNhO7l3Y/K7Kx9Ki9t6p1KYuuEd5C1UBJKVjLoJ
 l7xr9hO1p4Y6OgCqog8mTPeTZ0NMHYBj5KzFmJgvJz/ZZV0TbjbZrI4r5trS8bPp0fVx
 igABjI/PQVP8VnbxZeqTc30f81Kymshh/yrOwrNsecz9c1c1U9MqdtGvm8duJ82g8dHz
 RMmgOqanr0jt3kb+T+vEd+f+Rdx6/A85mzNi1fx2rSwmLV3uT4TdSa5J3Vc/Mkn9h6VD
 wMbbYTYFS4NKlcqoTuegiAzKisABgQ0NRtOrN1Q9sDS8ryO8HxYu7tWguFSuzObo68Kp
 yxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612270; x=1791217070;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 b=GZjvFk21PplJLPP1JAVPaO1o3SJpqyKjNXEiu5yUiwhYuRaVs4i9G2NlfdC1rS+/a6
 08EvwywdhlNCrwHEHQpVzTcMBaE/bvqIJJXBbl3SbzuiJJuYeyrNlxsU0lnE/lDymMcc
 USIHf2LeMuuDiTATUKNv0wc9TYqWBrJV0qvj2L2+qWL5Uot0O3Jx03+qMhgBQeggmRH4
 6/z3z+e0zCAZK5FvG+NF8hveyUyGPgNjCmBlvJDQm6eFxK52d0X9JLqLoISxMBci/2ql
 Riy95pzYY0wq8oyFgIf+C2YGNnVqs4TC4HqsdBge/TfaOmG97KM56qRWwnMXzR8wCSFp
 jkPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJFDJkjzFD/zJKfHW+0zlkIz7MBa4rfDynD7In5VdpSFyKjTXOOReuYPlOO6u8PlTUOyg0X/VDz3Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkSPE5mffwca5zID1HOiomAYcpfJtk3IDS68hkp5JB/8gK1smQ
 +8O8DMRqLIdcO70E1geJj/dWryGL+695O9TP6Z/ZipLdDIQOqM+GeWxOjGPjh7UP/U4PzbOzidW
 72GjkRaL03z59p6E38iI0wH3lhSXn6VM=
X-Gm-Gg: AYBFou1t8xLTj29LaNbUiwNGN8t0dNFnEqk7gh89DgswZc+8Ox6FSfA8sra0mf0/my/
 yW3IwTRkvrXuaXamuaDa5lfKmfjuT5/I7SiUgWYapoHidRCTsQIxklZRag6v4JL3mzV/eEskNT9
 pM30dplgGczYJrcOyqRbFG/Lv227kx3C6sD28c3o+T9wUk7IuBB8SrkBGSy/0xopgohWJ2GBs6T
 wzitt0lt1X2i6Xt1BW8BNkWfsw+1MB/1CjkA64qX11pxTG9nxU5dxlIYaLhdSmj5P+iS+WGkVtX
 Zx/S0xCSFyXpBrIdvOxPFMtbbjI65YJhuOQxE7rNG/OKLmgTJAHCMH9wGzN2lqopXVAeNGRILam
 VOTu2DLOIlQ==
X-Received: by 2002:a05:6808:180f:b0:4ea:f4ab:dad7 with SMTP id
 5614622812f47-4eaf4abde31mr3114576b6e.43.1790612270217; Mon, 28 Sep 2026
 09:17:50 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 16:17:49 +0000
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 16:17:49 +0000
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 16:17:49 +0000
X-Gm-Features: AclHuK8BjruCpIs-y-znTwRHy4UbPVU7NoASXj59drlp5sgPwJENTSFHMkI16G0
Message-ID: <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
Subject: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, deller@gmx.de, 
 simona@ffwll.ch, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

Closing the last framebuffer descriptor can deadlock against PicoLCD's
deferred update worker. fb_release() holds info->lock while waiting for
deferred work, and picolcd_fb_update() takes the same lock. Lockdep
reports the cycle through deferred-work completion and fbdefio_state->lock.
Repeated framebuffer open/write/close with concurrent device destruction
reproduces the hang in a PREEMPT_RT QEMU guest.

Use a private update mutex in the deferred worker instead of info->lock.
Take it in picolcd_set_par() as well to preserve serialization of pixel
format conversion and framebuffer updates. Initialize it before exposing
the framebuffer.

The test with the preceding output-request fix hung in the first round
and reported a circular locking dependency. With this change, all five
rounds completed, including 29 successful framebuffer write cycles and
concurrent LCD, backlight, two LED and UHID destroy operations, without
BUG/WARNING. The original syzkaller reproducer and persistent-open
framebuffer tests also passed again. These are bounded virtual-device
tests; physical hardware and suspend/resume remain untested.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing
deferred I/O devices")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h    |  2 ++
 drivers/hid/hid-picolcd_fb.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 846a8ceb95..33e6654ca0 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -115,6 +115,8 @@ struct picolcd_data {
 struct picolcd_fb_data {
 	/* Framebuffer stuff */
 	spinlock_t lock;
+	/* Deferred I/O runs while fbdefio_state->lock is held. */
+	struct mutex update_lock;
 	struct picolcd_data *picolcd;
 	u8 update_rate;
 	u8 bpp;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index c17104fd60..258c7c4fa2 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -231,7 +231,8 @@ static void picolcd_fb_update(struct fb_info *info)
 	struct picolcd_fb_data *fbdata = info->par;
 	struct picolcd_data *data;

-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);

 	spin_lock_irqsave(&fbdata->lock, flags);
 	data = !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data = fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n = 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data = fbdata->picolcd;
 		spin_unlock_irqrestore(&fbdata->lock, flags);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&fbdata->update_lock);
 		if (data)
 			hid_hw_wait(data->hdev);
 		return;
 	}
 out:
-	mutex_unlock(&info->lock);
+	mutex_unlock(&fbdata->update_lock);
 }

 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata = info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret = 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel == fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel != 1 && info->var.bits_per_pixel != 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel != 1 && info->var.bits_per_pixel != 8) {
+		ret = -EINVAL;
+		goto out;
+	}

 	o_fb   = fbdata->bitmap;
 	tmp_fb = kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret = -ENOMEM;
+		goto out;
+	}

 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel == 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)

 	kfree(tmp_fb);
 	fbdata->bpp = info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }

 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t
off, size_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)

 	fbdata = info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd = data;
 	fbdata->update_rate = PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     = picolcdfb_var.bits_per_pixel;
-- 
2.55.0
