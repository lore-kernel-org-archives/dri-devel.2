Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D17DE99046
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E2010E8A1;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhjkVjCl";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E264110E849
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:21:33 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4832c8f9d87so1845375e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775755292; x=1776360092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naig0CaZu0k7Q+bocF2lGCn7pzOcOGz/HtaZFjdO1l4=;
 b=RhjkVjCl+BHllsDvVSSb47gpTWh3BgAsAWVOvqxIvPuJtHjC2DCjlQfEAvzgEIieHo
 tYYM3ySHEJb71IPf56+hMOtMqkZYnJ40ksvS9t8QdgfGkjXPMnnlfd/l+IdAqDAP0dpe
 0DSlzFrL5lXKPm1qdIcXU+jZoBVLf8yz4jfILo1A3OPdeBeC78G+BU2fPXeHuU4eiB2q
 lGhF/pXX5DdYmMGuAxF5o8d3W69s/uAYgmsTUeuuNuo0gLDwACFnVscKPlzBs/YVwLf4
 QK7HpkqLJRUcGaXWyV3Wa9tSg18dPVtufgLgrZ3YRtpD2Xsh1uu2mVaKerPPvusYOZKS
 zReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755292; x=1776360092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naig0CaZu0k7Q+bocF2lGCn7pzOcOGz/HtaZFjdO1l4=;
 b=A2weka2nhySrnUDe8l4rneRmKAu6Bbbh+i48a8XcKmuKVD5jrROcnSsI+jT0iX01nq
 mnJLapLfD155bcdjaPXgDcHHH1fwvjCgTZjExKmtZDZnX7TbwMJq8diLggYr1ZkcHXpQ
 Js2fzEBcOxWz6djJApFgh1Sk2uQbFwJL2v1EN4dyqFwkczpgFypJoCKTzcifrIpm3DmJ
 2aR+gBsm/rKmL26lujjHqA1XnojXuXrRLvqsm+SxU7UJ701I/uIO/Z9dphFT3QS/ncK3
 HxyQbsFpER0qH7ZX3Lv7J15Siy8+30nxfSM7oY2EqJJPcMzqvPkpLymlis1ZtHRnXjd4
 XuEw==
X-Gm-Message-State: AOJu0Yy5gGITF3af8T1jfewJUYwA6o04dH6tS0aXmpuUQJh+appVrK4R
 h6U2iEyPzgsL3ASSaQ7fx4O2rw9ZWTQ/P4AFuAF6CbVmopOSKMDwVFPVzLEwy9dk
X-Gm-Gg: AeBDieubY6eCnvW9FN3wfUw6AXhSxlQi1d2aFe1XnuD7h6z6hPuZL3TdUeiYZjhejGR
 e5PQki3sY+KU1+EmAEOynGOpU16J1AVriysiKyQhjvqcJCm9xvh/PH9Yb1PaUChw4hAOLIY8DwB
 SWX5Gz83hrj1tfi67foimxLszYy7Vg/lc0p6Czmvep7+nJAUG0lfonvjlg49k0xg+X1esyAw65+
 5dNKdEaBUJL+xkXmhtwOMcRLiymDBhkSykkBJLGd6BQYE1OxhI20gA9ingroOGU1ZZNnJv2aCtE
 0Zpk6+KMo0Zh2TPd53n+5H0DtwyBn38oOOQuTuLHLpdTw3QKR0DNJg+ZGOaYZ70IOzFNHauaMhQ
 3pqxVSGDV/OCx5YrfS0ObLoamLWdVf5QCSICPpHEXGrHfSht8WZT2DbRpcFAzN6YjvHsBt+pcMp
 tgqegATJXIciU1uK+J7Id68XUEvMepinNJE10YdMjqSMR8OJue9i4qddHrNWkxis8AkFSmVvJg9
 riir7gUy1Tr/g==
X-Received: by 2002:a05:600c:4f56:b0:488:7fd3:5cd5 with SMTP id
 5b1f17b1804b1-488c5327661mr78481465e9.1.1775755292156; 
 Thu, 09 Apr 2026 10:21:32 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm367345f8f.12.2026.04.09.10.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:21:31 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 3/3] drm/nouveau/dp: retry link check once on HPD IRQ before
 disconnect
Date: Thu,  9 Apr 2026 19:21:26 +0200
Message-ID: <20260409172126.115441-4-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409172126.115441-1-marek@czernohous.de>
References: <20260409172126.115441-1-marek@czernohous.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:49 +0000
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

On NV50/G94-family chipsets with DisplayPort, transient link glitches
can trigger an HPD IRQ where the first nouveau_dp_link_check() fails
momentarily. The driver then falls through to connector status
re-detection, treating it as a disconnect event. This causes a brief
display blackout followed by a re-plug, which is disruptive under
both X11 and Wayland.

Add a single retry with a 100ms delay before giving up on the link.
DisplayPort link training typically completes within a few
milliseconds; 100ms is generous enough to cover worst-case
re-negotiation on older hardware without adding perceptible latency
for genuine unplug events.

The retry is bounded (exactly one attempt) and only applies to the
IRQ path — plug/unplug events are not affected.

Tested on NVAC (MCP79) with DisplayPort output over extended DPMS
on/off cycles. Without this patch, occasional display flickers were
observed after DPMS resume. With this patch, all DPMS transitions are
clean.

Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index d71dcfc6e..b6e40794b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -465,6 +465,10 @@ nouveau_display_hpd_work(struct work_struct *work)
 		if (bits & NVIF_CONN_EVENT_V0_IRQ) {
 			if (nouveau_dp_link_check(nv_connector))
 				continue;
+			/* Retry once after 100ms for transient DP glitches (NV50/G94) */
+			msleep(100);
+			if (nouveau_dp_link_check(nv_connector))
+				continue;
 		}
 
 		connector->status = drm_helper_probe_detect(connector, NULL, false);
-- 
2.52.0

