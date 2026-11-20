Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28A606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DQ/N1c8p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424F310E8BE;
	Fri, 20 Nov 2026 01:12:32 +0000 (UTC)
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2C610E8C3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:12:25 +0000 (UTC)
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-3aec0b1d816so197953a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795137145; x=1795741945; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
 b=DQ/N1c8pJVsoScTmhERy5u5p1738lj1PJ73n6DUwpAaADxEYTnZDzYfTdhsz0C1vdx
 YMwuWqXkADgEXHKE1T9hvX3T3m7n7JoEwsFm2J9ReOhpLZxAmonr8wym3B3avqQY2Kzu
 pINokeErRU699IHn47SX08Kat3AhtASd5Kff3A/IWgnrNTxRRN9heN5V0EM4pU6KxuXd
 49Rrvb6u3SjWCpTJ9XD4pZ3aVI+qalgRpfyQTHDhElJ/n4e86ZVEJwHu2xMG3TSun041
 xZK44eYsESAwMncxQ5WBFVRKHlL0o4MTniXSrcezLDeVFFWA+5/wi93FIbN/kJ+VtghT
 tnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795137145; x=1795741945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
 b=VpgonE3qayQ9TI5G42Dsich8gWl7nkiZ4xtNZGfUIlHPszXjDnnv1GFqishlA6Gylr
 F5chmUp/A9DagYsceFNX8AuUraP6pdGTY0MQ2RE/7SB6U18Wj9dMS1ifXqay0LPgHYRl
 Se5dpJzqoboT46w/GtjbDX5aZyPFKevfXGQgIuqP2ncg+R+mM1Xzw9tWhu6zyDRCiGZI
 eVrDo0pHUVKapq6tTt9LDAaSdJrtQe6ImC6qY25RdKfY+TmYzZPeMFng0jbI07TftT0D
 0hjZScVZFwDuViZb9AYsYX8IZX8CfkSf5eL8fiWF9JNZeBo4vKEkHnZAWv72E17cDSrP
 vVmg==
X-Forwarded-Encrypted: i=1;
 AL+hErFhCQkjkTwshVHvItK6XGN/s/v+1Jh9wpM5YWPQC91UTg23jW8phFlERgHrXkO8Ni1uB09lMgdcioA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KpNmlEOdaLv+9R+C0Nvq5FfVRnhGVtuDIYx9Sj8sTmad7J11u
 wZB+cBhd5yn7eHwfLF8/8CtiSe5hsdA4D8mTg+cIgFiEhAf96WbCnXxs
X-Gm-Gg: AZFdTZe/alUcWngVBIlMgXBYuHZKkDZYYZJgmycqQ5CPhPO7y+09hAmZmmbiCpBI8e2
 3rPAAObVJG3VQJhK8pZiwIoUSfwoI8XiIDvYgp3GPBXaSer6RZ2kCaIoRpjx1u8zI/rGyWSWgGy
 zjOW2T7QQLRjXIHl7i7x7W+R0bZh3HNcCsJcBneLA8lBuUFUuCFZ4TnUyYy9al1A/tLyP3Tva4k
 XunJS2ATEl4WIaxkguQXxMS5i5Uw9+ARnabWFxbn3sg4AK0nWZSFv9hmVaF2NP0mlBl4StA4xgg
 olYyaU+wWRG7BUl5TRdHwXny337oRbPo/Fk+VM8p8xQxLJshhpaVI3grcwhwdCNF9XJD3oVoKr8
 Y4qhNDHxTq3Y+ghyZiU90wHpm6MTQ6HMnVdHgLFnJQnhPpvOXYolEl//Ecvk0sQiEC71F/FpTbl
 BW2/qRbSiU2EzAGfMC6qJa4Sq5gwnRJSx7HAxyYPkYYt7oc0TXqSeyfNCbf7FzrN3BCuIGzkD2e
 bABPmo6/zCXoun5f4fiMnkG5HM95NOxuPyN29NJvXSAfwlrwutEA/p/o8no0lbRguIAAyNl/MmT
 yq5GW3lt64DhoYWjVTCpEwn/jK2Rb/Lik3xymvjOF1WE2Tz588oYz8OQ7ySEDWg1hdldb9d236M
 UGbBQzui8/ajR
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id
 98e67ed59e1d1-3b41c95ce7fmr1046872a91.56.1795137145051; 
 Thu, 19 Nov 2026 17:12:25 -0800 (PST)
Received: from localhost ([50.7.253.42]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 17:12:24 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Fri, 20 Nov 2026 12:05:48 +1100
Subject: [PATCH RESEND v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-2-d7531fa8061b@gmail.com>
References: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
In-Reply-To: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred=
 I/O devices")
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
 	struct picolcd_fb_data *fbdata =3D info->par;
 	struct picolcd_data *data;
=20
-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);
=20
 	spin_lock_irqsave(&fbdata->lock, flags);
 	data =3D !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data =3D fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n =3D 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data =3D fbdata->picolcd;
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
=20
 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata =3D info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret =3D 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel =3D=3D fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	o_fb   =3D fbdata->bitmap;
 	tmp_fb =3D kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
=20
 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel =3D=3D 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)
=20
 	kfree(tmp_fb);
 	fbdata->bpp =3D info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }
=20
 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t off, si=
ze_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
=20
 	fbdata =3D info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd =3D data;
 	fbdata->update_rate =3D PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     =3D picolcdfb_var.bits_per_pixel;

--=20
2.56.1

