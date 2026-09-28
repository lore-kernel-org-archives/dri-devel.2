Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9DFC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91CF10ED60;
	Tue, 29 Sep 2026 08:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ri9Gf+j3";
	dkim-atps=neutral
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com
 [74.125.231.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D8F10EA2E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:47:00 +0000 (UTC)
Received: by mail-oi2-f10.google.com with SMTP id
 5614622812f47-4c3bb46aaf0so283021b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 04:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596020; cv=none;
 d=google.com; s=arc-20260327;
 b=Q0yLSBC4Z/ATg+dywS9bPLOZkaQsPu49u0VvJ478EYUI5dXLsZEVsgZK4MpQjOO33W
 XWTLiiu2o7GfRl0BnsKv5u1iy1mR7SGk5egDWrKcYbe05XSwZUzXx5CdZ1MV7a66+8DS
 broQfih2JaMUXIUTFLfv9JQx7qfneVUEwMHV+I6zdVkc7RdbMXhqN1/HnKRKxPN7Rg2O
 wIkWBFiaPUVHtqIHyqWJcPUIap7GC+mmHgn84xnBkWN6gdW0IG1oUlYGBZJOAfh47Y9l
 nnIau9ZavTRtl5dD+AmeQhq2vQ3xp0jVHbFtgoqezeNw5TLpPiiyI4PiEXRG4Dhmc+lo
 3a3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 fh=kIC9/A29+/e1zqNDNQHSg1zujtrSkk/Rq7VokMNTsFI=;
 b=ruC1PTEVe8eG2NU9PGwEg2N+Nz/7NfXMvGTO/B6t9E1ErlvA6gf5H7MKLw48PYuElj
 tRBDpHDWrtuS/IViloWVLNLrvwAA4buQE+ePEC8Q+Ala/uy7ikDeNbdZEgSeyRPk0qMD
 x/T8anjjUJ0X/moQxoq0iZVhvRQudrMgFL3EWj6jyMKz38DdJ065k9iqUR4t9VQqtlCn
 of34RzNRJOEWgE+horGZpI+RrNtherBM5tXIQvN4j0inDPhpgziDMr5K4zpJwQUg9gkp
 HaFfmmuhfJhuBy0kRiwLXpMyUPo8RshzDcuIBl9SA0/DYUTgcXyqOZVRiaXcQjCG75dV
 P3hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790596020; x=1791200820; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 b=Ri9Gf+j36A0Orc5xdT6JTujQt94De0c3D30/LRaM+k8FHRvcvVQjmweF8zmSSjQWbL
 +kDNJp2TaxQCCSRTwRbxpgS2XcR+qrPIYB25u/zqvB2rP5t7+5VpCgs6qgi9popZSliU
 Yaz40Nq4gOi+q73kFplSAWIPcYkJl8IUXBc/Vt34KHHbA5UbuRjL2CyHkj0EX9gz3Hb9
 A3Rs4jxgu0EphryfxzZK43U9D/TYncciOoqlGOP0J5BaGjibA/mqWYYwM9aBL9uvDzh0
 q9IJae9LMcWTDaHsSasyJ18FFHQGWmTJJmva2RQwFvXV4NZ7lH65Npt7ATjMWR9Vmuu2
 W+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596020; x=1791200820;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
 b=CsE4Z+lp9ihUkHMz7qx8dNPWbTaCy7eVaF7P5+azmrw78eL6PDpC69CM8uuiQryYnt
 eRGGT35SwGE/uzg0dRthP44PFcBWFk4844bGdX1jYduI3Fy53ZU/sU0MOh1PfEZd3IRT
 BGrkVG7eaO/y3JabsKrCJNeHwvRzbQ975ieDyDtEnI2Gv+91e0EOOOKjO7XNYjoPZxAk
 Gey8Fee1QXkyh2jhjSoABLsLxJjG4Qz9tahxOaYmlVKP5WeQrMoWayWE3MSEwjMuVqwE
 3TuP+ZeKlDQWd5dXGCfoSz0BlAAF7n44Dn3O5/TbqVnsfOTE4ytBjaEMK73ANIqjvDba
 LL9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkgSsP3+OWWZZgjUvuqb1emEcRIP+PGu9jiLveayjHh6BAgMURjw6xiNvtyL7t3TIv9Lkm6DUyKm8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbNO7yEKfxZmacl7W3osmkH8/MjsJGZKWXOGHApKYYy/DFZvC6
 aU+Z3eCVCjnEzV0wCadmYH3PiqoGgnXnZzgob3IlOTt/IaG9A+4Xfwm/S4qCbCTJziFu62Lvgdn
 6sDkGGM/YmBG5MJh6JUDe1ZtNWgkQBdQ=
X-Gm-Gg: AYBFou3W1sQhYxyt3dYSJjGM3QgknzR5tW7kNxhq21HBWI4Uwc/hvvARSXfAIfcbLSA
 M2j+HVigw352WOTyChdeTs3HC0RXApAtJX6jNdYHe8B4q1JbrlQxpl13CcLJfNs9a7FDI6BzglD
 TgRY8Xtz+EgKpz4J3FszKuuL3uGl74PZ5lD9qKLoDkqAQNNGUVAtpq5n0KD5T++XnSC00klG/kh
 VZsqygpktIDuuy2vsEui4XfFDZjqiCbFtNEbKuSe0i6J6YTipfM01nkrctGsAi+Q92mTFwUyCmO
 nZfnWFORu82wsMWKFS9ITUoj9b7mMre7JDwiCyq6Q6sjL5R1G46IJ7HmJR1vBvxh+/AUttXVD0W
 8CQnBCTnR9w==
X-Received: by 2002:a05:6808:4fe1:b0:4e9:429e:d9a7 with SMTP id
 5614622812f47-4e9429edd08mr3795446b6e.49.1790596019638; Mon, 28 Sep 2026
 04:46:59 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:58 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:58 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
References: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:58 +0200
X-Gm-Features: AclHuK_kufxbmR3rqUnxgcHL0HxOsXbK2RSoAj85Izv9mkp5_zAOdC4beU5raZY
Message-ID: <CANOyQmH1zm86uwt55Ueg50sBkiKHxXc7oJqNO3x_64qc5sE4Vg@mail.gmail.com>
Subject: [PATCH 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
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
