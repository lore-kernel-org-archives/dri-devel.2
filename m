Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA02C5DF6E
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F5210E2CD;
	Sun, 16 Aug 2026 13:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GhWHg+2N";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067C410E2D2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 13:09:13 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495522bc0e2so898615e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786885751; x=1787490551; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N7ModForEGzdaliJRz1t1lN04ZfOQCHIzWf+H/xEqzc=;
 b=GhWHg+2N/Yo7HvZ1MFmG823ru4VwGApAomc6xkxJMeEKf8XVfNXoUP+tUYV/974LG2
 krL1ZRowm9EH8ycFSxquB+07aNiKxva75h1QIBoDc11UeTBb7S+Neol+OOeub3K2nf7m
 1xVfYU6sQ9SdktqXUyMhLIiPYCqyCJgzVBlb7Yi9ZnpnFaKu7ohEK2QFf2fvZFnpVpTf
 e3JrlA4QggGfJaxEzbrmAbeJ3xixVzzyYkl2gMi8890JSQCz7DIfRjn6+GJkArzlcaH5
 14W2d+TD3NSeCjd4ydbP0s+FGGT4inrKqjQ3QAxWcnb1QlXFMMbYQ7hDW7GSBcwlNQye
 b5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786885751; x=1787490551;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N7ModForEGzdaliJRz1t1lN04ZfOQCHIzWf+H/xEqzc=;
 b=hEBl3uRwJpHvdxgrl4e+gOg5v7odQeymb63J1HCIjNZ6yCrWT1kS5FusfQkZicMrDf
 LO8LkOLFFpdEnNmLkx7ho0yM76GH8E8MwldwL04SKtAw41d2YVvrTKhh6UD9fStoVDBB
 CtSPXjDA1T5d2XUfzdL0loHCo3WMi8Aya3+hcpldrqlG6JMN5u8gLYFJgBIo5vdcy7aR
 FI3HiKrOtgXK3NnV3JpAbRgXwKczKCw6HvMFbvqksDj2iEcFGx+7Km1aPMz9YlEtF9I2
 uCAUnL7aIt1oC3t8GpC0lBT4yq54/+YIoLZeq3wve/sdG2bBfTdOQ42RfEGUNaTTXVLe
 g3jw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4R3azDdap9vAJqlx6gRNbVHCMLkEouGki9M3Do4W2p0QUphHRI3UuiA0xZXlk2GZUeelYscnkUz0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9Bms3Dq6MlEWVHA7mE3NSvADdaM3b/0yY4t1kG+ZCUVhRfnXo
 WK/715t4scHrzZilbrFNbMaOUrxTycYap+70cwBQqt1dqa53mTzsOKiN
X-Gm-Gg: AR+sD12Xkgf3EWdCAVqQao/Yu5bXrnCRxN7xVvpicJljJf0K/LPWgO+fuhnYmYLf1Wh
 iMyDT4UeD9ZAWtxeRQLBZOf/fmQq1GhRRT8OO1x+uS2sbhRyEdjv//IOWiEhM4y0Hfm4SfgSiLI
 H6/Iog30AptUQGtY0epVU4aw1xMr39fspVowMfRxFYTwx54goKFnxQ7J891JQH+KDPH+hg1VtWw
 EkZC320YkQKMVJEq0RN0LpBXioZmgEMsYoy5Vqn1H0V6vnhMXeC5ytoO22ZFLQap5672JDXKiqN
 KFpbsCxG8o1CO87Z6XEeYDVkhtccbNur8gBkTwqn9NMzIltarwEdnLw63r+gwypDnpxMoeTS3Bo
 b04FFtBglI3/nVWozIjcsCrtRu1XwMsouC1g6aiS573ChC/IB9YEIdCag5hRSLAUTiX6ptmTzhk
 GwZ/0/A7paJKVO2EOFdh9lncrc52pj19ksccr5Fsoj6q4wBUB9j1lPyxfLtbXnYSKdmYKHGyocz
 LMZ6P09PHe5lgHZ6yF/X+lvVEbIE2tOThfLHzN4eQ==
X-Received: by 2002:a05:600c:1385:b0:496:c249:ddb1 with SMTP id
 5b1f17b1804b1-499879759bbmr135946405e9.4.1786885751312; 
 Sun, 16 Aug 2026 06:09:11 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996105c0bsm66548375e9.4.2026.08.16.06.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 06:09:10 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
Date: Sun, 16 Aug 2026 15:09:04 +0200
Message-ID: <178688574402.522643.5471719764843371376@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178688574400.522643.6695278742335367229@gmail.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

nv50_sor_atomic_disable() unconditionally computes
nv50_head(nv_encoder->crtc) and dereferences the result a few lines
later.  nv_encoder->crtc is nouveau's own shadow pointer, set in
.atomic_enable and cleared at the end of .atomic_disable.
Commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc)
checks in ->disable callbacks") removed the NULL check here,
reasoning that the atomic helpers never call ->disable without a
crtc.  On NVAC (MCP79) under Wayland sessions (observed with Weston's
DRM backend and with labwc/wlroots) we have hit the NULL case in
practice during session teardown and VT switches: disable runs without
(or after) its matching enable, and because nv50_head() is
container_of(), the NULL does not stay NULL but becomes a bogus
non-NULL pointer, so the subsequent head dereferences fault and the
kernel oopses.

Restore the guard, as drm_WARN_ON_ONCE() instead of a silent return:
a NULL crtc here still indicates a state-tracking inconsistency that
should stay visible.  Return without touching the output; in this path
either enable never ran (nothing to tear down) or an earlier disable
already did the teardown, and the encoder release is handled by the
commit_tail release loop in both cases.  (That loop then rejects the
release of a never-acquired output with -EINVAL in the nvif layer,
which is harmless; the vanilla code oopsed before ever reaching it.)

The same inconsistent-state path can also leave the encoder without an
old connector state, in which case nv50_outp_get_old_connector()
returns NULL while the backlight teardown dereferenced it
unconditionally, so the oops would only have moved there.  Hoist the
guard above all of that and look at the old connector only after
checking it.

Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 30 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 364227f5456f..f532b0ed8880 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1565,16 +1565,36 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nv50_head *head;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
-	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+	struct nouveau_connector *nv_connector;
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
-	struct nouveau_backlight *backlight = nv_connector->backlight;
-	struct drm_dp_aux *aux = &nv_connector->aux;
+	struct nouveau_backlight *backlight;
 	int ret;
+#endif
 
+	/* nv_encoder->crtc is the driver's shadow pointer, set in
+	 * .atomic_enable (and by the boot-time hardware readback) and
+	 * cleared at the end of this function.  NULL here
+	 * means disable-without-enable or a double disable; bail before
+	 * container_of() turns it into a bogus head pointer (checking the
+	 * result would not work, container_of(NULL) is never NULL).  The
+	 * encoder release is handled by the commit_tail release loop, so
+	 * there is nothing to clean up here.
+	 */
+	if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
+		return;
+	head = nv50_head(nv_encoder->crtc);
+
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	/* The same inconsistent-state path can leave us without an old
+	 * connector state, so check before touching it.
+	 */
+	nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+	backlight = nv_connector ? nv_connector->backlight : NULL;
 	if (backlight && backlight->uses_dpcd) {
-		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
+		ret = drm_edp_backlight_disable(&nv_connector->aux,
+						&backlight->edp_info);
 		if (ret < 0)
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
-- 
2.54.0

