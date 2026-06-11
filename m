Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB47ACD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF1710ED27;
	Thu, 11 Jun 2026 07:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Scm9pmix";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF4310ED22
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:26:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b1df16acso6886415e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781162800; x=1781767600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlBSAof3dxTHn+vmJPVfCbz7wQyEQetNaXJtCkbufXA=;
 b=Scm9pmixasVGuw2yi8xvV7YXu8kJpv8aOtjFhrCIFl+DUFSc1ntHz/RfAIB/5u/NsH
 etuP/9B084o9VmXNJUMJzr6jGfVUY66UaFRzEgDM5uM2ovta5vXzEuyDNyXorhhAIPaG
 V/ieGnXvhAE7g0F6Cbp7OanT+SgUFpnZpaTweYD2xKiUztbEmh37Qjq+TRmRU+cnlwHi
 YakSNs8rfSvcBdkGzlBwEPxJEVG9W/lLkmc/JVPtXTsNYbQN+uJwfzGlbDEoMvTqJNqs
 CWI3QLE6DhKSD0divH1rIPzBBnwR9o7rKhEDMNhTpVisyvEwjg7iVOfrVaMkx8PR+Avd
 lgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781162800; x=1781767600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlBSAof3dxTHn+vmJPVfCbz7wQyEQetNaXJtCkbufXA=;
 b=I7fNsARHUcWiFdIhhXvGUehUGJLN87e2hiRxlGY4xIYT/RcxeIh7DOQwSEbrc+vJiF
 kkJst4KF0/AjZZusGN44B+DqNMrFBypuYJ2mStVhbmaGpAOp0mg9rA3Ngk/naNP0If3I
 ZPzDn5R1kilsnF9aXcniZivuyREprOKqnyZWj+v9h7rMmwtIA7BL7k9bzAIoLK2afa0y
 61FdmByQY+a994TZj6N+m9qrvuP3C+SZeGGn9bwXj0vP+rljEjlEX73sA/Nbeq3D2oxe
 fahjgInh1aqa1ZNXVy4W/d5Qd5gkYQgOTtHUuvm+tQFRCVOZ2U5JoJrlo/HfAsXIbGOt
 D8tA==
X-Gm-Message-State: AOJu0YwJ2ACImnAQiaD0Liit3Ry2Y2hr28aRkO8I/lE3OxOcAlcQvDZ/
 vpgfIy/TCqklGCmqQJQseF+AVE6tjytVgT6Px7RrRkR05PfX95XTUPEJ
X-Gm-Gg: Acq92OHqMskqqEUCf5GLoRAuBH0i65fphQb5Ylz6sSLV766OEEPfXmE75RzWNY33Nfd
 NyzuNYuX12y+1peph41Sr1/OnmAck/mr+wc2GB89uYVsjS/ZfyOw/mbXJR6FQE0C7USzuX4Ai7P
 10WgAhGemXF3+0WNqeUNYvG5U7SoMBEavbc+2XUuJQy+3aUH3MZfAbdltC9SwzeCAZAKhBY7y38
 0iVw7SPG6mhc7AtfevknfZVXZYeNt5KIXW9/UTi3owAklCe5T2WN60/zcxD/5dKct3aTJRcxpdO
 7mq0I7W+3Fh0vN6fEsLQ664C907HMhbFqm75E+DpRBvwhw5uhVN7Mt/hsC/198CWxKfuWAt2KBE
 RnhLg6taxL4TBOotY8BcNfXCpn7ZeK5rl0ehUsF8It3uLmkbxbROjPfjO8vStsMzi8YGzLFU1iz
 FH0wtFCTEGcDQpu1QbkrfMkBWT+CYtj7fphZwqUGI3qLbknrScEGNUl3We1UK3nHmGa4TrZ0Esa
 1/XCWMcB1gJkCxw04Ua0sIu5A==
X-Received: by 2002:a05:600c:1f83:b0:490:3fdd:d344 with SMTP id
 5b1f17b1804b1-490e558813fmr7830845e9.1.1781162799452; 
 Thu, 11 Jun 2026 00:26:39 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea21sm42585795e9.1.2026.06.11.00.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:26:38 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v2 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
Date: Thu, 11 Jun 2026 09:26:34 +0200
Message-ID: <66ea307dd4fa080db27b2b9a0caa31b562d72c2b.1781162589.git.marek@czernohous.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781162589.git.marek@czernohous.de>
References: <cover.1781162589.git.marek@czernohous.de>
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

From: Marek Czernohous <mczernohous@gmail.com>

From: Marek Czernohous <marek@czernohous.de>

nv50_sor_atomic_disable() unconditionally computes
nv50_head(nv_encoder->crtc) and dereferences the result a few lines
later.  nv_encoder->crtc is nouveau's own shadow pointer, set in
.atomic_enable and cleared at the end of .atomic_disable.
Commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc)
checks in ->disable callbacks") removed the NULL check here,
reasoning that the atomic helpers never call ->disable without a
crtc.  On NVAC (MCP79) under
Wayland sessions (observed with Weston's DRM backend and with
labwc/wlroots) we have hit the NULL case in practice during session
teardown and VT switches: disable runs without (or after) its matching
enable, and because nv50_head() is container_of(), the NULL does not
stay NULL but becomes a small bogus pointer, so the subsequent head
dereferences fault and the kernel oopses.

Restore the guard, as drm_WARN_ON_ONCE() instead of a silent return:
a NULL crtc here still indicates a state-tracking inconsistency that
should stay visible.  Return without touching the output; in this path
either enable never ran (nothing to tear down) or an earlier disable
already did the teardown, and the encoder release is handled by the
commit_tail release loop in both cases.

Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
v1 -> v2: dropped the nvif_outp_release() call from the early return
(the release is owned by the commit_tail release loop; calling it here
released twice and detached the OR before the disable flush); turned
the silent return into drm_WARN_ON_ONCE(); reworded the commit message
(the v1 "race between atomic_check and atomic_commit" wording did not
match the mechanism).
v1: https://lore.kernel.org/nouveau/20260409172126.115441-3-marek@czernohous.de/

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 6c3a871..597bc64 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1565,14 +1565,28 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nv50_head *head;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_backlight *backlight = nv_connector->backlight;
 	struct drm_dp_aux *aux = &nv_connector->aux;
 	int ret;
+#endif
+
+	/* nv_encoder->crtc is the driver's shadow pointer, set in
+	 * .atomic_enable and cleared at the end of this function.  NULL here
+	 * means disable-without-enable or a double disable; bail before
+	 * container_of() turns it into a bogus head pointer (checking the
+	 * result would not work, container_of(NULL) is never NULL).  The
+	 * encoder release is handled by the commit_tail release loop, so
+	 * there is nothing to clean up here.
+	 */
+	if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
+		return;
+	head = nv50_head(nv_encoder->crtc);
 
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	if (backlight && backlight->uses_dpcd) {
 		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
 		if (ret < 0)
-- 
2.53.0

