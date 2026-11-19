Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDB606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wX45sKT/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4918110EFED;
	Thu, 19 Nov 2026 21:26:49 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31E110ED2D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:26:37 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-67bee1f693bso297742d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795123596; x=1795728396; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u/T6aa6iCWFrqHcoyuakH1O4XrX3XcHQl1IIpLYEGug=;
 b=wX45sKT/EjD7M/w5RtM1ffurmZTs8VP/DMlP7YhoGUCmQvvab3LvfqOO7NdZ0LOr6x
 fJS6l+hWRXl0igoyAt+uxxPkTPrG+gg4S2sMYIeRk5ztokC8t3bFYHTJ39SxHSt9jmHw
 JzEA9utWLrtDJ4RmGBkjCAGFh3/vZuoXFDxgwC6mjRicP24BScCQgVMPszIHwToaxZgg
 jl/3RvpHfW8Y8erToXBtHmus90UIa2eUAtA71cPPDMqHWCEAOlOa2c4WdTLv3jp2IzQy
 +DfiXnSdD0FDVxGxA3iEkOp3FBr3/hpM4o1kkZ1zFKEAVR4EhPF1Eb62IEDxzgPUytFV
 x/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795123596; x=1795728396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u/T6aa6iCWFrqHcoyuakH1O4XrX3XcHQl1IIpLYEGug=;
 b=0pn40VTTuz5GlJDkiO8a41GgS92rS+NTlmJVSb4NkP9Ou549VAHAfJB08njWZaFWms
 +LDKYSZ0UtroZwGJrylPV/DtlGbnv2BbNyjzD9SZWpcFo79se2RSGTUDa/99KjDvyoU/
 UNp0e/X7c9b7/7hOjzr9ExnQtTc29zPeei6Z8ZMLVmGAR3q1eiQl3spuzU1dBKZ+dvEm
 t3KwsEuvr1K70mtEAWz6NWms+Esx5Gu31PJsQOGeOxSQLOlqcEAbxYRQFsRJjuqpayig
 8wsD9YCGO+T021cF7v5ow4KK2jI0pn0eZl3e6PRhBd2EiNoi7yPOx+KtEPgMsruzA3M9
 8mkA==
X-Forwarded-Encrypted: i=1;
 AL+hErHWby2d6j947pyMPMECwP5pFmpMrgxnavdvExKU0gBpyG3+DHsIhAFmdkHKlJe+rQVC0oMkFx+rnSs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9LJnSLlBZ4mvz3deO3TENZGYDCpVdRjNjb5lHN7mqUd3EWBAl+
 3YwB4E5HjbrjL2Z+AAFhk1x9hi5rr+xBhzpbT8359SZgLg/kcFCpI47R
X-Gm-Gg: AZFdTZcAmz2W0Lk/qyKUFiTwYY3eYZ91IIsDNH9+ZfTunR2nIMCmw2mEs3Ru6N/sgqV
 LfAaPY8y5H5NBHxLNF35kJx6qNH1+u2oSV/hiUryhdRtaz3OthKchqpLOUc2lmVbOlcn8Dd6YCe
 WpthniIrR3Jn3HiN5sBBuyfpTP8qheRKe1n//Pj6daPXZjyB7YN9AHvpKEmFLE+p6dTpMpEuhR2
 /qeZvAH7+soiB51Su3yriIJ7rYO3arQG1xGBREhRBUHXoymcWW2/5gWgiMy2BD20Zg5nxy7MkUX
 O2I15ELRpoQ2omljcvfcfvHi8ON+EPXXg5MXxRUNdqlvgyMn+8RO/nLEtIcBKNge9mOF6ppIsRF
 VlgOBqErreu2mAqU7o2VQQi+tiVdVKwjCdRvAxahmKOSwt1p5G4p8AfaNAPAf4s4eBa/ui9XezB
 HP3eCJhuSUDtosF2pnHhZpoluEu2WupswcmqLYwxqxlGSOaUqPs3Q3Z8vEt/pK2ZNUi7RWLXymF
 q4l1azXIp4m+0rRuKOuxz+u2+mQI/0i3tNr294ETg883GUdRaufh9KNPspGcDPVYGnoWaUNek/3
 p23JzBgxPIyqqeQWUfmfgMSY7fFup86zqU22PbLIBk4QRGxafnOuYxWOBfr4C7usykv13Cblj0P
 rsX9iWzvp0tTLOljWI1kyAeHnNdIdQiyEC82+zn8L0tbpeLHfa3941r68XIjKOzc=
X-Received: by 2002:a05:690e:1094:10b0:67d:bdd4:e44 with SMTP id
 956f58d0204a3-67df44b0b15mr275383d50.98.1795123596293; 
 Thu, 19 Nov 2026 13:26:36 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df338e8fesm658337d50.16.2026.11.19.13.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:26:35 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 19 Nov 2026 16:26:32 -0500
Subject: [PATCH 1/2] drm/nouveau/dispnv04: Restore Apple backlight PWM on
 resume
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-nouveau-pmac-sleep-v1-1-360c08654a25@gmail.com>
References: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
In-Reply-To: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=uadQHS718gQ/DHTMJAZSo4vKONsVxecudR5BmvozqCU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3asXt6nLdEw84Wu9+Lqyb4fdrte3rwmRutwtxvns
 sAXfFMXdHxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1+xYzMnQ3J7f+3s
 5yVrVA4PK7EOX4NXbX09fYRkWnZLN8u65cuI2R4a/M+jMr05lOJaZVOrmsLHhjG96WOOlwXu5y2
 5nWdne1GAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the Apple GPUs handled by nv04_dfp_update_backlight(), the panel
backlight PWM lives in NV_PBUS_DEBUG_DUALHEAD_CTL. Open Firmware sets
it up and nouveau only toggles bit 31.

nouveau runs the VBIOS init tables on every resume, whether or not the
GPU lost power, and on the iMac G4 (PowerMac6,1, NV34M 10de:0329) they
write 0x7fff to that register. It reads 0x83e60535 at boot and
0x80007fff after waking from PMU sleep: backlight enabled at zero
brightness, so the panel stays dark although the display is otherwise
working.

Save the register when suspending and restore it on resume.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/dfp.c  |  6 +-----
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/disp.h |  2 ++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
index 00eb2aacbe93..33b5a3398460 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
@@ -485,16 +485,13 @@ static void nv04_dfp_commit(struct drm_encoder *encoder)
 
 static void nv04_dfp_update_backlight(struct drm_encoder *encoder, int mode)
 {
-#ifdef __powerpc__
 	struct drm_device *dev = encoder->dev;
 	struct nvif_object *device = &nouveau_drm(dev)->client.device.object;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	/* BIOS scripts usually take care of the backlight, thanks
 	 * Apple for your consistency.
 	 */
-	if (pdev->device == 0x0174 || pdev->device == 0x0179 ||
-	    pdev->device == 0x0189 || pdev->device == 0x0329) {
+	if (nv04_display_has_apple_backlight(dev)) {
 		if (mode == DRM_MODE_DPMS_ON) {
 			nvif_mask(device, NV_PBUS_DEBUG_DUALHEAD_CTL, 1 << 31, 1 << 31);
 			nvif_mask(device, NV_PCRTC_GPIO_EXT, 3, 1);
@@ -503,7 +500,6 @@ static void nv04_dfp_update_backlight(struct drm_encoder *encoder, int mode)
 			nvif_mask(device, NV_PCRTC_GPIO_EXT, 3, 0);
 		}
 	}
-#endif
 }
 
 static inline bool is_powersaving_dpms(int mode)
diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index f71199a39bc4..7d44d18e1b88 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -35,6 +35,20 @@
 
 #include <nvif/if0004.h>
 
+/* Apple GPUs whose panel backlight is a PWM in NV_PBUS_DEBUG_DUALHEAD_CTL. */
+bool
+nv04_display_has_apple_backlight(struct drm_device *dev)
+{
+#ifdef __powerpc__
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	return pdev->device == 0x0174 || pdev->device == 0x0179 ||
+	       pdev->device == 0x0189 || pdev->device == 0x0329;
+#else
+	return false;
+#endif
+}
+
 struct nouveau_connector *
 nv04_encoder_get_connector(struct nouveau_encoder *encoder)
 {
@@ -74,6 +88,15 @@ nv04_display_fini(struct drm_device *dev, bool runtime, bool suspend)
 	if (!suspend)
 		return;
 
+	/*
+	 * The VBIOS init tables, which run on resume, reset the backlight
+	 * PWM that Open Firmware programmed. Save it to restore on resume.
+	 */
+	if (nv04_display_has_apple_backlight(dev))
+		disp->saved_backlight_pwm =
+			nvif_rd32(&drm->client.device.object,
+				  NV_PBUS_DEBUG_DUALHEAD_CTL);
+
 	/* Un-pin FB and cursors so they'll be evicted to system memory. */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct drm_framebuffer *fb = crtc->primary->fb;
@@ -126,6 +149,10 @@ nv04_display_init(struct drm_device *dev, bool resume, bool runtime)
 	if (!resume)
 		return 0;
 
+	if (nv04_display_has_apple_backlight(dev))
+		nvif_wr32(&drm->client.device.object, NV_PBUS_DEBUG_DUALHEAD_CTL,
+			  disp->saved_backlight_pwm);
+
 	/* Re-pin FB/cursors. */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct drm_framebuffer *fb = crtc->primary->fb;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.h b/drivers/gpu/drm/nouveau/dispnv04/disp.h
index 85ec0f534392..2f84287a3521 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.h
@@ -88,6 +88,7 @@ struct nv04_display {
 	struct nouveau_bo *image[2];
 	struct nvif_event flip;
 	struct nouveau_drm *drm;
+	u32 saved_backlight_pwm;
 };
 
 static inline struct nv04_display *
@@ -98,6 +99,7 @@ nv04_display(struct drm_device *dev)
 
 /* nv04_display.c */
 int nv04_display_create(struct drm_device *);
+bool nv04_display_has_apple_backlight(struct drm_device *dev);
 struct nouveau_connector *
 nv04_encoder_get_connector(struct nouveau_encoder *nv_encoder);
 

-- 
2.56.1

