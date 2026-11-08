Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42268606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zHpWCQf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AAC10E14F;
	Sun,  8 Nov 2026 12:13:16 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4A710E14F
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:13:09 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so22877f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794139988; x=1794744788; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ygaGJYoEs4KFSYAAlwAVylXljw/N65/5dysb1mPUS9Q=;
 b=zHpWCQf6lMO9jvB89CIR6Muvv2pYpKOLJs4/PTZcbIPtevKUOzwftu8sMHe9qv4lom
 Gu3RR9sov2sX7nuTg00oSH+aR2S2C5aqlshrAhZf1tFuxNYF2DThTWwRC016Vl7byN9q
 NPrhS8N70O9uvEmp63JUw/x8y17xXAHINZBWFyCTNVrFXNOgCk3XRzIv0pzYCvnmvMBQ
 Wk2TPVeDrp0ozU2lC2z1iRCt6LuitRdqtkGPAZvNS6duuYV4FfgO9SHKKevsjduQF3+w
 MZSBTLuNTzw3wFxjwJhgCC9Azut/GJywxn4UUleKB3XecO19evrEwGec2YlRCCHn2uNI
 sDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794139988; x=1794744788;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ygaGJYoEs4KFSYAAlwAVylXljw/N65/5dysb1mPUS9Q=;
 b=C0ix8t+juHKLPvFf6q5lN1+DAOpjuIrgUoi5pfSSC7DYA0GmSYmgwItgFf+GJ+TIyQ
 vqLeG3mNc4pIwnKulLtxOIKpVh7pOg66dCZaJlUNKBfKXPX030tbLazlhAUqdCkx2mOM
 SFtwMw15SHYpPoSanW0nt4ha9v/ap/wQxuN4xQvULzpk1bngOg4MNlJWYrEKFeZDKB7O
 2ZasdDGSF2PkiJ2YOBw72ystn/wRPAnJlzgfKRwCPTqQQ/atWLgvCOcP5mBACZPptfk3
 AqxJXH1KhVRJ5SUVJR5vqRD1/0pzB+VGnWHCmny1DJoEjvV1SMPjy4ogner0FnaG08Px
 YKaA==
X-Gm-Message-State: APuU4Z9xxLFELVymt5JfsGtkEmH7cVZZ3o8XwwCUFErz/Mf5eaFq5YUN
 AXrR0YRSgK4nFK5gpYBSMkA1qlqR2/cBouZ2YQmA1W2yttHinYpXyhx8
X-Gm-Gg: AYBFou3+sT6JocJWMetU9OeGilJ8ViL+x2h6CRK1YF0qwmQd0PL6AhhfEkx027GqrES
 +iT8obPUqtxT/uZIUKibslIAD6/N+5rjdNY2C3Vxmt7EWbX87pPTa3Z00ac9M/cAmXE5i159JaW
 MAtuDyhW7Ugm5HfEM6qLpKAm9aDe+rT+KHH+sn7AOiPCbtgT9/ihHkGFsf66lg6SEZqQ1IFY+v6
 FsZJkEViYvKjjM9S+GGeITLsX/xovlROyAuRo741KUQqRTbNBeZd8+0hQpUmmHTCf6Thfn6qohi
 bMHRKLETUr517VwwoUVuCqItQgPhOhsLH9D6UP0kpcH4WrOJUGpXkxgFZ8ukNTI2Pmg4BINVof+
 o6mA3lS5B7bJHxJ49joSLJUVTUmCeMCe576ubs+DRaIl2lWN9nEqAu3uB2O9fYV5JjAOQex9561
 kWLWRBlosL4YAn5PeLdOktTQaYCcQf3+LAUous2IcLtYcgIBIJdqksseUMXnoN0hk5K6q3oDoaq
 CR8DuxjBznmbU18mhZmu4ZuxVPEgLjt50Rovw6s2gTDx3ljx8RntOlu5/U8vgcOGAMC1Wp3OVr+
 +QXAPSoxHoPumtIsLcnF4RhmtluHMhIcOtPpjMaIxVlJORcIjsILXU7wpH2thaVe06VUD/AFTev
 km7dGfuIZcn/stTkZFu38QuJR9OVXKCeexxU+vVDrx9/pdew9QQo=
X-Received: by 2002:a5d:584e:0:b0:488:823d:5086 with SMTP id
 ffacd0b85a97d-49583ee2ab6mr3013316f8f.0.1794139987564; 
 Sun, 08 Nov 2026 04:13:07 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597090444sm3945815f8f.31.2026.11.08.04.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 04:13:05 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Sun, 08 Nov 2026 13:12:59 +0100
Subject: [PATCH] drm/mxsfb: Complete page flips only once the new buffer is
 latched
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-mxsfb-flip-latch-v1-1-ad816b23b646@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQK4muEi3MxhqwHzQiEO+et
 PwW7yWIFJgiDFWCQA9HPo8CWVdgN3OshLwUgxJKSyl63N/oZnSeL/TmthuS6xrbdkrPRkPJrkC
 O3385Tjl/QGTg9WIAAAA=
X-Change-ID: 20261108-mxsfb-flip-latch-ef53c4526ba6
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Emil Velikov <emil.l.velikov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

The controller copies NEXT_BUF to CUR_BUF at the end of each frame. When
a commit writes NEXT_BUF just after that point, the new buffer is only
scanned out one frame later, but the event armed in atomic_flush is
still sent at the next frame done interrupt. Userspace then renders into
a buffer that is still on screen, which shows up as half drawn frames
when a compositor renders directly into its scanout buffers.

Keep the event in the driver and send it from the interrupt handler once
CUR_BUF matches NEXT_BUF, and AS_BUF matches AS_NEXT_BUF for an enabled
overlay. On i.MX8MQ about 2% of the flips completed one frame early
before this change, for both planes.

Fixes: b9f5937680a8 ("drm: mxsfb: Enable vblank handling")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  3 +++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 47 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 641691fc92c8..d21f12074a81 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -166,7 +166,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
 	reg = readl(mxsfb->base + LCDC_CTRL1);
 
 	if (reg & CTRL1_CUR_FRAME_DONE_IRQ) {
-		drm_crtc_handle_vblank(&mxsfb->crtc);
+		mxsfb_crtc_handle_vblank(mxsfb);
 		if (mxsfb->crc_active) {
 			crc = readl(mxsfb->base + LCDC_V4_CRC_STAT);
 			vbc = drm_crtc_accurate_vblank_count(&mxsfb->crtc);
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index bdc47ce5be79..9264ca53999d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -49,6 +49,8 @@ struct mxsfb_drm_private {
 	u32				bus_format;
 
 	bool				crc_active;
+
+	struct drm_pending_vblank_event	*event;
 };
 
 static inline struct mxsfb_drm_private *
@@ -61,5 +63,6 @@ void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
 void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
 
 int mxsfb_kms_init(struct mxsfb_drm_private *mxsfb);
+void mxsfb_crtc_handle_vblank(struct mxsfb_drm_private *mxsfb);
 
 #endif /* __MXSFB_DRV_H__ */
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index bbc2a2df9f16..c7e516758a1a 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -328,6 +328,7 @@ static int mxsfb_crtc_atomic_check(struct drm_crtc *crtc,
 static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
 				    struct drm_atomic_commit *state)
 {
+	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
 	struct drm_pending_vblank_event *event;
 
 	event = crtc->state->event;
@@ -338,12 +339,54 @@ static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	if (drm_crtc_vblank_get(crtc) == 0)
-		drm_crtc_arm_vblank_event(crtc, event);
+		mxsfb->event = event;
 	else
 		drm_crtc_send_vblank_event(crtc, event);
 	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
+static bool mxsfb_crtc_buffers_latched(struct mxsfb_drm_private *mxsfb)
+{
+	if (readl(mxsfb->base + mxsfb->devdata->cur_buf) !=
+	    readl(mxsfb->base + mxsfb->devdata->next_buf))
+		return false;
+
+	if (mxsfb->devdata->has_overlay &&
+	    (readl(mxsfb->base + LCDC_AS_CTRL) & AS_CTRL_AS_ENABLE) &&
+	    readl(mxsfb->base + LCDC_AS_BUF) != readl(mxsfb->base + LCDC_AS_NEXT_BUF))
+		return false;
+
+	return true;
+}
+
+static void mxsfb_crtc_finish_page_flip(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_crtc *crtc = &mxsfb->crtc;
+
+	drm_crtc_send_vblank_event(crtc, mxsfb->event);
+	drm_crtc_vblank_put(crtc);
+	mxsfb->event = NULL;
+}
+
+void mxsfb_crtc_handle_vblank(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_crtc *crtc = &mxsfb->crtc;
+
+	drm_crtc_handle_vblank(crtc);
+
+	/*
+	 * The controller copies NEXT_BUF to CUR_BUF at the end of a frame. If
+	 * the commit wrote NEXT_BUF after that point, the new buffer is only
+	 * scanned out from the next frame on. Complete the flip only once the
+	 * hardware has latched it, otherwise userspace gets back a buffer that
+	 * is still being scanned out.
+	 */
+	spin_lock(&crtc->dev->event_lock);
+	if (mxsfb->event && mxsfb_crtc_buffers_latched(mxsfb))
+		mxsfb_crtc_finish_page_flip(mxsfb);
+	spin_unlock(&crtc->dev->event_lock);
+}
+
 static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
@@ -425,6 +468,8 @@ static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
 		crtc->state->event = NULL;
 		drm_crtc_send_vblank_event(crtc, event);
 	}
+	if (mxsfb->event)
+		mxsfb_crtc_finish_page_flip(mxsfb);
 	spin_unlock_irq(&drm->event_lock);
 
 	drm_crtc_vblank_off(crtc);

---
base-commit: 19e67d977d3d4d0c54f03906ef578578190db9e1
change-id: 20261108-mxsfb-flip-latch-ef53c4526ba6

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

