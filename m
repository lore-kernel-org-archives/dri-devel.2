Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD53CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795A110EFDF;
	Wed, 13 May 2026 17:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qd5QElXj";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBA810EFCD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:50:18 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4493cf2f982so501966f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694617; x=1779299417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3sIh5375gOTbKLogW0nu2FPAiE6cFaR5WSblCu7vM0=;
 b=qd5QElXjDhUxP7b7ClvHWAkc6Oq1NZYaerFp/qhu9yEbhX6ilH/BVGpJXJ8O+76XPo
 XojbzmpkKN3L3xik8csu7ceDQzHMz7AiDVhqocwVSu3JIUk9Ihf0SeAx9LT6a+XeJUPF
 TFKAE3gJQ4fKS0qtTfot3OOxH0xIHPGauWzhOPfVRr4nBfbV3wTtzTEkdxLq4EBRGL0n
 R2+9F2eJeKHiafBrTK6vuk1+NxdWS5fpTL1dLxeVnHQKUgaLdHoY+XJpjM1oOteEBRkJ
 UEJqKxYgpG3xT5uQVgHn1mY+2rXGNPyb2YSORvnI81GiEtzsCIGNvtZXyXrS4/VXLOYj
 CUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694617; x=1779299417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C3sIh5375gOTbKLogW0nu2FPAiE6cFaR5WSblCu7vM0=;
 b=BH/rS1KxqLrnIIIf6b2fdD7GV4JmBKFk3CWVbA7xFwEnoYjHovnraX6ZV+ni1wjB0r
 MiuzMdSsjz6zF+Y1btRYLE7bX+D9Gj290ojokDmrJuT2O0rNCsjZRJ6iCd9sfqWguK+F
 JtVXnAKIvdTRXPVlfbhR42ruqnGj7W991rgzLjaQZQALA/moqXWhSWlkzvVSnewal6yL
 /czkwJa0PpFOSgwnULbrcKWZKscIg3pediMsklUwd3MQ8DlBIlUL+wPc8QsGYu3WaTX3
 BFimuJDgjr/8gTnORuOWHKSND6id2aLKCNFC57LyxbwHCFTZHAJAVx4prt83OiT22H9c
 Qi+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0OAPWvad1KE10Rw8YVl15gb6jdaxq7CYVsx0v632aHy921GoDfbxAlcPX35asweu2pHD7O39xAt8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLSub7QEC3y2fJsSDra0FwmLkyhKkweGfT8fk9u628iG0QnJAc
 1JK0DJv2/fDAN5L3T0tK6GPlzPcmy2PTPGCadsvElMzC9s8osF+QnjL9
X-Gm-Gg: Acq92OF+V+lukVbNAyd9ydFA9+Qtyj8P2kgLVcB7Ay7EqhzLkcBpev8YuonTokUQUHd
 T10Wsvh1wHfrniYtWd8+cPH1MCnSF+gsFGx4PTFsmRdg4bIOam3xJ0L5ppJSr9Q4YiI05FqVvBj
 uKziFOoNij+exYaAU29yvAQWAJI9Jg8V+IUek+pxtEfE86iwLglBggWSdXkvd+M34OEwOyCbGrW
 uu2r6ts7Ku79SF8StBVzIwduiwau4NUf+VZXcPEOHultHbXwwZUpCCdw47HI0jc5EgXzphchqpp
 P/VI3l9ihL2as0lKBgcIRtNtEherBco+pOwyQEnT3Zz3N+EQ4p5MKwMhCr7DKyctQsU8JiBJs2w
 zkzF8RFMdPQ1lJa0eVT/DROZbzIH2RXYeh1OTO7c/h0YO4p8ZR8/JcsPAtBKhOOQNPLOGlwrx3m
 +cfi7Gdd9oiQM3jsX0kq/GTWfuZbaGO0suLfJsCZkYPZvddXwqJAt9SB+AYjNpflnBbKp9sp0gY
 qMvs/UdrMFwgmJI9Ptp1zfPkA==
X-Received: by 2002:a05:600c:19ce:b0:48a:58e1:6cf7 with SMTP id
 5b1f17b1804b1-48fc9a362f9mr27622065e9.4.1778694616986; 
 Wed, 13 May 2026 10:50:16 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-214.um39.pools.vodafone-ip.de. [109.193.28.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm486730f8f.29.2026.05.13.10.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:50:16 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 1/2] drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from
 Mesa NV50 bind probe
Date: Wed, 13 May 2026 19:50:12 +0200
Message-ID: <20260513175014.96599-2-marek@czernohous.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513175014.96599-1-marek@czernohous.de>
References: <20260513175014.96599-1-marek@czernohous.de>
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

The Mesa userspace driver issues a method-0x0060 / data-0xbeef02xx
binding probe on Tesla GPUs that ends up triggering CACHE_ERROR in the
PFIFO interrupt handler. The probe is harmless and recovers cleanly,
but it floods dmesg at error level on every X/Wayland session start.

Filter that specific pattern down to debug level so dmesg stays clean
while real CACHE_ERROR conditions are still logged at error level.

Tested on Apple Mac Mini (MCP79, NVAC 0xac080b1) and a G94: dmesg has
no CACHE_ERROR spam during normal operation, the previously visible
beef02xx pattern now only appears at debug level.

Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
index c4b8e567d86f..fa13cd55b593 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
@@ -327,12 +327,25 @@ nv04_fifo_intr_cache_error(struct nvkm_fifo *fifo, u32 chid, u32 get)
 
 	if (!(pull0 & 0x00000100) ||
 	    !nv04_fifo_swmthd(device, chid, mthd, data)) {
-		chan = nvkm_chan_get_chid(&fifo->engine, chid, &flags);
-		nvkm_error(subdev, "CACHE_ERROR - "
-			   "ch %d [%s] subc %d mthd %04x data %08x\n",
-			   chid, chan ? chan->name : "unknown",
-			   (mthd >> 13) & 7, mthd & 0x1ffc, data);
-		nvkm_chan_put(&chan, flags);
+		/*
+		 * Filter benign Mesa NV50 bind probe: mthd 0x0060 with
+		 * data 0xbeef02xx is a harmless userspace probe on Tesla
+		 * GPUs and does not indicate an actual error condition.
+		 * Demote to debug to keep dmesg clean while still catching
+		 * real CACHE_ERROR events.
+		 */
+		if ((mthd & 0x1ffc) == 0x0060 &&
+		    (data & 0xffffff00) == 0xbeef0200) {
+			nvkm_debug(subdev, "CACHE_ERROR - ch %d subc %d mthd %04x data %08x (benign, skipped)\n",
+				   chid, (mthd >> 13) & 7, mthd & 0x1ffc, data);
+		} else {
+			chan = nvkm_chan_get_chid(&fifo->engine, chid, &flags);
+			nvkm_error(subdev, "CACHE_ERROR - "
+				   "ch %d [%s] subc %d mthd %04x data %08x\n",
+				   chid, chan ? chan->name : "unknown",
+				   (mthd >> 13) & 7, mthd & 0x1ffc, data);
+			nvkm_chan_put(&chan, flags);
+		}
 	}
 
 	nvkm_wr32(device, NV04_PFIFO_CACHE1_DMA_PUSH, 0);
-- 
2.53.0

