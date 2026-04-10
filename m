Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5346BE99040
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290CA10E8A6;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3fC4GwD";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9861910E896
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:15:57 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4832c8f9d87so2707495e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775801756; x=1776406556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naig0CaZu0k7Q+bocF2lGCn7pzOcOGz/HtaZFjdO1l4=;
 b=A3fC4GwDxgzP3SOmEovuAsKzCcpZ6Rmz5Uq5ljo75cqARvRAuEMTn7mKR5KYhr+xhh
 /kC03Sn2CCfvgm0MQUDKWskgBgIZJuiriz788TPEMtHGonBoj3N1BVkdtraOEbIXrSsu
 rxHVeyLYu5lMCm6VHWwymssZUVeyWltl/zgqPV32jGG1FEkBrVzkT5Lf8VeqHvZpSXoz
 fuiBxmLGwW8On4HdmLr4chJRZnlQNMkV8LUDWFfQKUZ6LYrUbDaYgpuUDtsYtp9fj37x
 KEw/r33pLt37WDXbzxiBhKr/+9qjJ7uzWhMRGnqN41sPu/APsf+AVLBXQ88eiK9CTOdb
 ICiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775801756; x=1776406556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naig0CaZu0k7Q+bocF2lGCn7pzOcOGz/HtaZFjdO1l4=;
 b=Q51csNCcmfr2TpUpwzqES7DocnxvC5YR+8pk1BiuKBjIpfO/JITxa36O7H4dlfVy7y
 PK2XzJbOLyrbSK1PQw4Yrmj+aECZ2ceFkE3xpZ2S060tfHPvnOAHSnaYOK24jbfLayt6
 TAFyBktQ1JFRL60Ftm4OrWxfuNBdPIewSgZuFL3NBjOMasuMIOPzmWaLbeIGyAmu4efc
 s4k5NeURJ5Z5bdF5AbjA6ZnuZn+ZtqyNsbanBFI2A1sOi0jRYKtSVEqPsSjDpQ07BMKZ
 3NFkPYy2Q5PQd/NyH+EFC8s/eE1xnobcUiURZ3eRGRdvPFWpt8RX1M0XakIC2J/Mj125
 ++Qg==
X-Gm-Message-State: AOJu0YzfkpApR0+LeXyqnRLCj6ICVwBrPxVvyU0zgVzQ7MKRjBy+cW/U
 PPniYsHgx9ilUAa0QzVn1LcJ7dcvyV8/MsvwaCqb7DUT4o/tuM2wMdWh
X-Gm-Gg: AeBDietEmS1L5PKwh3w7nl85ZHZmGfqhIoKL4DCxmmm68Lv57a/G6UTMkIKUpWUQAzH
 Txgp0hsmDZg1FqZQNeyesnEOTMYVHenSAItGGiwCVmPv/uMbQDSo9m2YPxgIBPjs0rGmnkzgyOk
 ukHQm5Hswrvc/wUkgq+LTvNKPlmtHlD+xuZW30z2xvskAVV9K9T/seB86YDTm0ujLHWiTPIzzc8
 0YwHQIldsSuIuKm87Bp7wuSc7I4fzuzfADlAOLudqazQrfhcn8R1uJUyyDTO4xeImeDhGr2ecVk
 G7YkziLOYwG+pqOR6T5kJNAB1c4s0X9z7LAJgkcyR4nNE+d722RRHyoFj0U6dXcJqGQsukxrqVv
 bzkJStStSHrGV0U/YaFJMJ4MjTl9u/GtVCmOTAVv00kFwGuzXowmojdwe+43Tx3DkEtMY+HO8hO
 g+t7Hbgk67mC3WwRr+qsqsWoLgP83S1W4L43H0MI2O8QEUYmeJ2c1ROLjy/sxNHTWaHvPgbdfDO
 6MGRxwP4Jn19g==
X-Received: by 2002:a05:600c:4689:b0:488:93c5:4dc with SMTP id
 5b1f17b1804b1-488d7f76192mr8388835e9.7.1775801756080; 
 Thu, 09 Apr 2026 23:15:56 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm55473955e9.3.2026.04.09.23.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 23:15:55 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 3/3] drm/nouveau/dp: retry link check once on HPD IRQ before
 disconnect
Date: Fri, 10 Apr 2026 08:15:52 +0200
Message-ID: <20260410061552.19056-3-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410061552.19056-1-marek@czernohous.de>
References: <20260410061552.19056-1-marek@czernohous.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

