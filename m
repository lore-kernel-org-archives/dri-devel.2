Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E2C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661DE10E2C4;
	Thu,  6 Aug 2026 08:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jqtihqCy";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D9310E2B9
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:52:33 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so1889245e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786006352; x=1786611152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=43GMMFZoVTY8+U+Ee+riXD/46xoLgGatma6l0KI0k2A=;
 b=jqtihqCyzG9nHdayar2/W8I1abCeFyqZLg/LwSDCNLQEmO0VahkSn+jy2saisnrIi+
 NQUCrKDI+GS+6y/p607sS+FydKnOebEotygOgcz8A6A0g2AZfJSeTqOgTa5GXUWURjK8
 0a2skxc2qkvzHtZjhxZPmZhVZ0N+kXlImNBqRojLuLh+Rok8jFdBU8tCdpQR7VG+rfWG
 n8pTjoviRergJrIhglZ/PbyeDX69MNXt6LZV0ttl/KPrLwU9ye0qnX0oQN6hNjYa/ra7
 RqrdWDPxqZYaOFC/chZsmRtS6VpLM3qsIuxhNK4owfnIodWwj63GdU9lUblLrbqYt5ZT
 TQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006352; x=1786611152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=43GMMFZoVTY8+U+Ee+riXD/46xoLgGatma6l0KI0k2A=;
 b=AMZk+rV4IJZ8l4aTN9NMP5J4gA30rM9Xd4hax7aC0WSVOEZ6mInN3DbhP52mOsCtux
 AKkJotFgipDesuYYLppHd5KWwr8aiMBQIZg23KmI0SOIOI5HAlp+G8QB+Sbz6v2zsmwR
 9LxUjjgtq5L9bXSoTEZrRqQncwOLGOkeev6idRruah5fbUlJCG5SmREWCpTcEGzNEtiy
 QOgbycQidJ5YdtTnPkL0lZTt/pJsPe70pGhIZscUMApDiU7mQq2sOZWmBcfzQSCfeyAz
 EQXUN1YD+SkPcYVflcrwTocok4KBmYFVy/hxKjYSxxv4R6K2Dk4Zc4uOBGRYUx5L6bSq
 ofPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd7GhSL9NW4OmPvpGAtfUg0vT6GMx0/jXaouizvuv5jQokaq9nzpq/ge6T7tkRwa0SMqGOTM+JzOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZVJp93TBErHF4gO06FEQd2aXgQi3sYec5215pbpn4Egch5TUb
 iiRKm1RJ95aUIMN4Oqf0VXteZqlxBaHzHK0B1OTMjXYc9zoWqSWvjdvm
X-Gm-Gg: AR+sD11gk8RLxKnIlFaB589qi30Clgbl3eBVaPcWtf4pkDJMLBAiaKKw5Fc6RhSQZYH
 yd+DqSt7xjUQTZk+ZJx/ZmkG8xFTl2mjnFGNOPWWQQPOb/I6HjeUK5gb5BNf/PP/aRscV06HYCG
 vpGmx+6cE/YErKiUy7oBVHqrOHcsS3f7TrDqUdGA8mcO2FAURgW2fnZw6B1UrVhMDktd84ZTgJ/
 c99OogK8WPSuWplKHbwZpd060T49d3AawXQjroov9RZxlYHD0LLN9PcLDipv+B8bUgGZ7iNeedh
 Gbh2q8BW82WbPFzcEidoODvbHrGFGip+ZAIVpE4M1Tv7C1Yo1BmByDkhxk4q1EXhAgfDL+uN6kF
 QA38l8r97QoL1RGaEurfeNqeR2TDF9iQc5YXlJPYnCmSElxbwTO4zgrIrHp4XeE0CDz/go3deYj
 CPSiFOdJsyZH9hZ7f8J9YJNoUPK9VPf8JMfy1OJP4KvaDAUON3S2XZmgfR+arZJkB7Zi+k/HyYD
 qUpaKK3C0rBB3Av/lTgvjWvPD8OErCinQ/fhtT+CUffkFWw1ugFM2d080Mji3Hvcw==
X-Received: by 2002:a05:600c:b85:b0:495:4505:dad0 with SMTP id
 5b1f17b1804b1-4994e7ba5efmr93074145e9.2.1786006351804; 
 Thu, 06 Aug 2026 01:52:31 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420cb4esm45985355e9.2.2026.08.06.01.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:52:31 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from
 Mesa NV50 bind probe
Date: Thu,  6 Aug 2026 10:52:26 +0200
Message-ID: <20260806085228.1848994-2-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806085228.1848994-1-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
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

From: Marek Czernohous <marek@czernohous.de>

The Mesa userspace driver issues a method-0x0060 / data-0xbeef02xx
binding probe on Tesla GPUs that ends up triggering CACHE_ERROR in the
PFIFO interrupt handler. The probe is harmless and recovers cleanly,
but it floods dmesg at error level on every X/Wayland session start.

Filter that specific pattern down to debug level so dmesg stays clean
while real CACHE_ERROR conditions are still logged at error level.

Tested on an Apple Mac mini Late 2009 (MCP79, NVAC 0xac080b1): dmesg has
no CACHE_ERROR spam during normal operation, the previously visible
beef02xx pattern now only appears at debug level.

Assisted-by: Claude:claude-opus-5
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
2.54.0

