Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD02CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D30A10F58E;
	Tue, 13 Oct 2026 07:53:11 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99BB10F0AD
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:50:56 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so821550a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791809456; x=1792414256; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=86WcGAeEklYqbgh3KKZHUzYuJQ+5rJGp9flS10qudDU=;
 b=O1EO+5zgoi3WVNF6eH7HR2nDxnXiZiNfI0ITvVNG8aCg/tL9NV+ZMGSYNk3I30hB8F
 iBbAqUkxBWma94hh5/igaV9tnCUquqfhExcGmaaeMetXditFMJmo6posZBkSsi3CI/0w
 4BpT3NupIP+BITqkJ9SnctXtn/wBh8R3LPL7Xg2emcAup0R3NSJsiojXEwa3lYH49B+S
 rxXbmtWxT7o1Q6m9egCNxe/jjPplUFbElVU66Z/DVYY8xikt8RICDMCW+5KQIkYSR+oL
 Tk9u6gJ+Sn9uDBTTJ6o52Llxhoxql+TuFlXfuM728IOYNRdGrO2ahBw+rMBgoj6Mo7LF
 oBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791809456; x=1792414256;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=86WcGAeEklYqbgh3KKZHUzYuJQ+5rJGp9flS10qudDU=;
 b=bMSn0kdSeou1h1R6RDuOpRANw0CgMN9jTbb0EwosCKzshQvZcYPJWAdNc3HlAgXjKO
 ngwziW6Swhnz94JFj8dlKXyozTYL5zJrCjCzb8LIpUXUUSR97ev3pSm4R9UGDfORDoK+
 e+e2+K2WOY///a5YRpi+2zrGL2GR+qKQ+fx5RfSVCGfgMeGXakaSc7htQqjRFOSU6Il2
 p2fGB0PFURuBaae9d6Vg+BKeu1w3BjXH2O93GJfr1yBAED7NzAqweQugTdi4+hZmAv0b
 D10+2cvWLleq01542ED+BtWsgocOZTh4Tswui/xbEL3f3wRudd1RBiInlxTLJvIKGL9C
 KwGg==
X-Gm-Message-State: AFq9FYJb9kSEOzFd77IHsma78UH8HG4hnydW1Wljkigfz9ILJSgo+QfT
 xFFofeGzPGVD0wT0bOaha09BBuaKtTNdiIMqteD/t8omEDCfA5iUjvdR
X-Gm-Gg: AYBFou28Zgec4cvWHTRhl3NF2QUOrF4fH+QU3X/UP6Fz1A4ACUrT1yjdoNg/mMjm6+x
 MffWKdHZM+qFyLN26OrZHZ7slhkv85ZxRSoJBWs/gEDD40pQynSGDiJxX501XGxo4RAYfO3a+TD
 eeer/Vx4QxtCZ+JAPlQXbo1jgbu4t2ziTvRre+AwJRNpng3QsqNZ5dX6z43I2tXzRDVlzT/D5yU
 Wc2O/HgUVl16i1lNDc34XTg49GCEonqosRJ86Z9UJ6FHdxXKbyXxu0hkfnUSfFD63CoAKxNu6Tn
 F0foGDcDBztYX7Adid90tJUZVaWvkLF8ST+msxLvnZGrCj77vGdOMhkTP2QQD6J2hzogLSih4yE
 HG+VHSPvuzoZ+jsi6x36VEvHTDLbRDgrEi/Isqo82SjlOGYbF59ayR+roSydgOjsXnPFpuSk2qU
 o1g0joDDz6Cp+mcdKi42DBI0CF2UoJbQ8HCxg2r0jqzHv2KH1cNNe5BJyqALBj5wzasjk019PLn
 Ia0sA9buvij99w=
X-Received: by 2002:a17:90b:1dc1:b0:3a0:eeda:39f3 with SMTP id
 98e67ed59e1d1-3ab3aafac4fmr6499105a91.24.1791809456102; 
 Mon, 12 Oct 2026 05:50:56 -0700 (PDT)
Received: from b4send_258f78389c344e02.eml ([23.155.4.238])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm7634732a91.2.2026.10.12.05.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:50:55 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Mon, 12 Oct 2026 20:50:47 +0800
Subject: [PATCH v2] drm/nouveau/sw: prevent NULL deref of disp in vblank
 methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nouveau-nvkm-absent-subdev-null-deref-v2-1-8b15a3f1c371@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKbXzGoC/5WOSw6CMBRFt0Le2GdKwy+O3Idh0M9DqtCaljYaw
 t4tuAKH5+b+VgjkDQW4FCt4SiYYZzPwUwFqFPZOaHRm4Iw3rCs5WhcTiYg2PWcUMpBdMESpKaG
 N04SaPA041FzLWvGqYh3krlcWzfvYufU/zqEHqWUv3x2jCYvzn+NIKnffv5upRIYtsbodGkFSs
 Ot9FmY6KzdDv23bF5qNAU/sAAAA
X-Change-ID: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Zhenhao Wan <whi4ed0g@gmail.com>, Ben Skeggs <bskeggs@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791809447; l=3997;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=9D/BNSC23S/Qmnz/rEyuzPeALBLDnVdnrOUvYw7hLMw=;
 b=EjYVQoBJ6xfZQoHh8JqdMA3zViHlPBACAXRZvdK3Aszn9sbBVAZ7oNcqK6IEHDatxfkwImc/7
 QvOFnSStI5VCtBFFJdX0SXubQOKx+LQwBQlTOYP7bRY8+bvvPJjMtMg
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

The NV50 and GF100 software-class vblank methods nv50_sw_chan_mthd()
and gf100_sw_chan_mthd() evaluate "data < device->disp->vblank.index_nr"
to validate the requested vblank head before allowing its notifier.

On a headless card the display subdevice is absent: nvkm_subdev_disable()
(strap-driven from devinit) and the -ENODEV path of the NVKM_LAYOUT_ONCE
device constructor both leave device->disp == NULL while the device
continues to probe and still registers a render node (DRIVER_RENDER). An
unprivileged client holding a /dev/dri/renderD* fd can then create a
software channel and push method 0x0408 (NV50) / 0x040c (GF100), which
dereferences the NULL device->disp and oopses the kernel.

The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
already tolerate an absent display ("for (i = 0; disp && ...)"), so no
vblank notifier is ever registered on such a card and the method handlers
are the only path that assumes disp is present. Guard the dereference
with the same disp NULL test the constructors already use.

Fixes: 79ca27706a03 ("drm/nouveau/core: rework event interface")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: LLM
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Add the Fixes: tag Lyude asked for. 79ca27706a03 replaced the NULL-safe
  per-channel vblank.nr_event bound (0 when there is no display) with a
  direct disp->vblank.index_nr dereference.
- Drop Cc: stable and spell Assisted-by: as LLM, matching how Lyude
  applied patch 2/2.
- Pick up Lyude's Reviewed-by.
- Patch 2/2 of v1 ("drm/nouveau: prevent NULL deref of gr in
  GETPARAM_GRAPH_UNITS") is unchanged and already applied to
  drm-misc-next as f569473c1393, so it is not resent.
- Link to v1: https://patch.msgid.link/20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com

To: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
index 0171cdf6f639..4cf8cd120c76 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
@@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int subc, u32 mthd, u32 data)
 		chan->vblank.value = data;
 		return true;
 	case 0x040c:
-		if (data < device->disp->vblank.index_nr) {
+		if (device->disp && data < device->disp->vblank.index_nr) {
 			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
 			return true;
 		}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
index 0cfb1eaae6de..b202e11238a5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
@@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int subc, u32 mthd, u32 data)
 	case 0x0400: chan->vblank.offset = data; return true;
 	case 0x0404: chan->vblank.value  = data; return true;
 	case 0x0408:
-		if (data < device->disp->vblank.index_nr) {
+		if (device->disp && data < device->disp->vblank.index_nr) {
 			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
 			return true;
 		}

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

