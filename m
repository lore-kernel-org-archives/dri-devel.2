Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE15C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5310E10F161;
	Wed, 12 Aug 2026 23:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpX+Cmj1";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCCE10E46F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:13:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso1195285e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786576416; x=1787181216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tfw6HroNHGc2c12iMbCQTsQpKK1xWyV/VLQvyFAcyJg=;
 b=OpX+Cmj1uGJl1q3eLd05KHdF181l0/tdKwWCFcpNHqoRDZi7J5xjX9df5q9b1lAz8Z
 0nHnq8ZQK3j0aSigaHQAyrq2lPz7eYbidFdGFuaDlKsd8C/C7hSy6fe5KIfM/pBaxZHE
 kO1QRJgmPBR2TsctefIJ9XKahMLBxagYvWiAMLuXrxF2jzAbsjmpta8AiHmzubWdqPHo
 qJxp6F6voSeM544+k9mbikwgVE0rcuy0jSSq5SaHcXJPftsqityMbZF2nkCHmmB1ravw
 slmmHxkV62YtmBQgI+uVc8586N/voD8xFvN2LyqcEaH0xsQmeyLfhq4J/EKFPOZenazs
 Oxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786576416; x=1787181216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tfw6HroNHGc2c12iMbCQTsQpKK1xWyV/VLQvyFAcyJg=;
 b=AC42CNmHkldW6ZnEWvbqnntVZd+vZQYMKKeZpU+A+fKZXi4qJUbHDMLl1dfBYfPM2Y
 b11cUhZmRWg1KEsIFZHZRupHHP6z0wMTL60ZEDm1/taQj6Z29OTA800uhrLD/6s/32M4
 yLo++pgHDqNLwojtQrtlKm4FgTd3jShdNrHo/Hbt8gMy5+dPWbecmzqWiXwFG/iR+GTF
 eYNfJtK9p52t3NxVTaPQ4+Fva4e9mvAkfZQ+J0Jrs42MN/cSNyPNJpoKa0i9UQRQx203
 Oa4UNDu79BnsH+j82VXqTceuJNszoe+Eb5liJXkjFRWme8eZ/y6fq9Y36+8xeUyYPCrY
 x/iQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+dSatTZqsK0LCHgUTa1VfAOhd9a5v9NuKNOZWjHlWn+X+GtyMS7jOUjFGvOoF+ksPnWyRhDjousE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/MMbU7YXmbkuHI26cYVROFxzZ6ndWHuIbUSzO3qOPYbFESxiF
 l724DSY5KiQs7NAZW92R0c3duMHZzJL7TRU4Gsl8TXr9yrIvmOJoamCM
X-Gm-Gg: AR+sD12en1Keqo0copPQ+3bHpKtGWsJPeG4VWw62p1sXeOzZycA6ZMVS/nu1tbN3B7O
 QMrN7JOzI5gZ6BjaZQ7sZetYonzjZ+Merto4ya0uNdmCma4WOYhjB6sER7nQ6/xqphk+mtL/bON
 10u8DMdS1BU7pXrg8tNKmnWyskcKu5bX8FQfdu7b99crLeZ51TX8Fqhim/ROT8EfJxu7V34PMgc
 LeXFmKxB7SzeKeuJnmTio3mec71CWaWHmpRxGCPDsFnZcsuCMZmBGzA1edJL7tgLGYCosRSQLqy
 KP8TH9Jnyw5LUR/HhotRxbgAThda73KpqjT79wvnpedpQ5YXULSR4nylLSQj+roWRy75kHD3KkF
 2ueUvabkI8H+LzzPWwJgvVKB0ZSeAl6ULCveLHOsHepJ0lsTHdo2mtgLD5CKxJUWaczeH3v69jU
 rzClrhQ7mxosHyreky/7OAuKjSDKpSNf6ntCULXyiM+cF6OzgXKK5m5A5mXxGDNxB6xI0K48ojR
 kBIbBfIJG++euSjsGRFHEDvE1368iLY8cllGo3KxSOQAXqisCUJ3q4=
X-Received: by 2002:a05:600c:3b2a:b0:495:4505:dad0 with SMTP id
 5b1f17b1804b1-499821ad33cmr5870475e9.2.1786576416271; 
 Wed, 12 Aug 2026 16:13:36 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm44532245e9.14.2026.08.12.16.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 16:13:35 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>
Subject: [PATCH v3 3/4] drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from
 Mesa NV50 bind probe
Date: Thu, 13 Aug 2026 01:13:29 +0200
Message-ID: <20260812231330.705425-4-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812231330.705425-1-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
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
binding probe that ends up triggering CACHE_ERROR in the PFIFO
interrupt handler. The probe is harmless and recovers cleanly, but it
is reported at error level, so it shows up in dmesg on session start.

Filter that specific pattern down to debug level so dmesg stays clean
while real CACHE_ERROR conditions are still logged at error level.

The test is on the method and data pattern alone, not on the chip
family, so it applies wherever nv04_fifo_intr() is the handler, that is
nv04 through g98. That is deliberate rather than an oversight: a false
positive would need userspace to write exactly 0xbeef02xx to method
0x0060, and the probe itself comes from the shared nouveau Gallium code
rather than from anything NV50 specific. Say so here so the narrower
wording of the subject is not read as a chip gate.

Evidence: 99 occurrences across three logs from a second, independent
MCP79/MCP7A machine running 7.0.10 and 6.12.90, under both Xorg and
Wayland, with kwin and plasmashell named as the faulting clients. On my
own reference machine the filter went in before the persistent kernel
log did, so I cannot show a clean before and after from there.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
index c4b8e567d86f..ab144c1bd9da 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
@@ -327,12 +327,26 @@ nv04_fifo_intr_cache_error(struct nvkm_fifo *fifo, u32 chid, u32 get)
 
 	if (!(pull0 & 0x00000100) ||
 	    !nv04_fifo_swmthd(device, chid, mthd, data)) {
-		chan = nvkm_chan_get_chid(&fifo->engine, chid, &flags);
-		nvkm_error(subdev, "CACHE_ERROR - "
-			   "ch %d [%s] subc %d mthd %04x data %08x\n",
-			   chid, chan ? chan->name : "unknown",
-			   (mthd >> 13) & 7, mthd & 0x1ffc, data);
-		nvkm_chan_put(&chan, flags);
+		/*
+		 * Filter the benign Mesa bind probe: mthd 0x0060 with data
+		 * 0xbeef02xx is a harmless userspace probe and does not
+		 * indicate an actual error condition. The test is on the
+		 * method and data pattern alone, so it applies on every
+		 * chip that reaches this handler, not just on Tesla.
+		 * Demote to debug to keep dmesg clean while still catching
+		 * real CACHE_ERROR events.
+		 */
+		if ((mthd & 0x1ffc) == 0x0060 &&
+		    (data & 0xffffff00) == 0xbeef0200) {
+			nvkm_debug(subdev, "CACHE_ERROR - ch %d subc %d mthd %04x data %08x (benign, skipped)\n",
+				   chid, (mthd >> 13) & 7, mthd & 0x1ffc, data);
+		} else {
+			chan = nvkm_chan_get_chid(&fifo->engine, chid, &flags);
+			nvkm_error(subdev, "CACHE_ERROR - ch %d [%s] subc %d mthd %04x data %08x\n",
+				   chid, chan ? chan->name : "unknown",
+				   (mthd >> 13) & 7, mthd & 0x1ffc, data);
+			nvkm_chan_put(&chan, flags);
+		}
 	}
 
 	nvkm_wr32(device, NV04_PFIFO_CACHE1_DMA_PUSH, 0);
-- 
2.54.0

