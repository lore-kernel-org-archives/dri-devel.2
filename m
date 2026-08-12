Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9CFC5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D5F10F257;
	Thu, 13 Aug 2026 09:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ouEH6aM7";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E3A10F058
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:00:37 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3811f512167so1299758a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546837; x=1787151637; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5RKCcCs+aO4MrLdOnYHMwBF2RezT4AlJ4Gp/mR+XLo=;
 b=ouEH6aM7TZBI2V7TH83YVgc7wDYFsOEppz9dTMQqmEvg1nLDmeVBmeA6c/LvUOx727
 JHIFmNEwYxGxGMNdO846yC8trkSHUX7MoabXEuALyo+fR4NZ0OG6SXJOVve3xBYOMvln
 Caef8+TTGLXuu29Ga3YfbBOkAw48SqV1sx5qFw4tzQ2sOb/Ahttm/Aj7eMcH1sbc4QmA
 SQ2tnpHj2g2OXBocfLzp/+LOVZePquVIBDV/AojplhoWkRacxS0iCQj9t9a29JIsof9j
 fU/GIyHtHVEjnvFQEmQ3nI73lO2uuizX9v8Km27/D1zwoVUq1GkbC/V4Z8kzw08TMzqY
 bHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546837; x=1787151637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5RKCcCs+aO4MrLdOnYHMwBF2RezT4AlJ4Gp/mR+XLo=;
 b=B0YO6759StF1AhjC1IGhlSN1vdOvBYBJMjB+jSJTD8XilHk2kk/0ufbyvBPfqBNyQH
 mwBqMR/lWyYjA9TKSp7/jrLh70Ds/FTC1+czFuDlpHAyziOIymZ8+gWJhSBtmOsPVpo6
 6I6ABiN8QY/9LzA3Z7CCRdpQUE0TkAQmtMUGivEnIl0bAwRHsAS5/NasqkdxsXRR2oJy
 m2gYF70y5ysf2hBYq+Zf0ahS2sPP3t+eDc7383BwmUmvVGPqZ5WfMU/3ApiUCOD8NUlt
 YrX2PLRBRNxaPjxmqv/b/ureEC0wh9ScgVbBPsYGXNVSLQZDfN1JPeopPDkURR1D7q8K
 Np9A==
X-Gm-Message-State: AOJu0Yxgrq6tUKvq4Cpk7BDG1dRSCC4SG+E4Hc/ejzxRlDUM6TS5jweC
 nLJQxN7vxLGdBZUAJLYAdbc+bu1c5xb20A1Jb/FOKa0FwEhw8yqKv7S0jiKfYzJv
X-Gm-Gg: AR+sD13KZcdXTCgBVBU51IwHodjfgLxF8RWrrCu0AVHuLFbEDt2VFTskMqAWIRGzyCZ
 3KK0hh9+sEvHtHuLamBuN4cSKgnpng7sKCU2JzeiapMo4cl6+oRNNDjyVEBMd6xJ06N32cf3S9f
 /3U+MV4Kh03xZaOc9UVzMivXoGPhGIeSRK//2EXoVSk2MM71WM4C1w38i6sspZWjRdwSJ92a3JE
 jEIbmbP5xHIcLQLzqDtzHulegodVMVEzPoIZN1ItK1YG7Gm/51eVno6zwRXVzA5MjxxoqbB8wOB
 YXCONziMF9LpqQ5nIXhL5/5N4v9TTZsLY2T1VTDyPyadEHXS0zWRYAGt4JWIDTTzj4Xvk6B7Bi2
 zlF72y/8fZC9hH+65xrAP9dfO6EAbUdrysLCX6gVdEMUPR5f3yGktEhsv3h2lPcIVMQcnNbszGK
 5Rj6IoaWw0Hc92Fb5It/NlspwVj842KY0o4rinJFIXZB2JqGu+8Wy0YfreAIjV
X-Received: by 2002:a17:90b:2d87:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-393013c41e8mr6639072a91.1.1786546836771; 
 Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 23:00:04 +0800
Subject: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in vblank
 methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=2686;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=U4T7yVA0PCbP5g0s2yLY6Rg/fJ0eJtWweG0p/5LOj4Q=;
 b=zuoq23EqGDpiTQ22kZ6ODTRR2vhXOyPyC1C+c7ujp9yvu7qEc12Nu3mhBQN/oi2bH0Mkqjldp
 cfH5yZjZk6/CGDGFIQxyquHlnS8uQjUtZ8Pu9QRDOQ4/mxFg8b8kqGN
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
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

-- 
2.34.1

