Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB6EF588C2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9B710E5A0;
	Mon, 20 Apr 2026 12:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jiabUEvH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4807310E59B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:43 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66D532769;
 Mon, 20 Apr 2026 14:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689585;
 bh=FkIewGjJgmTlrhcbqcI/ZGMUPpfnTF6TeMFYfD/xf6w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jiabUEvHYjCCHaRqIxrMYNJgyP88QdLWhvCb5PIS/rmCWozC1pGzLcZToytdCqWF4
 8Q2mKF9y5QBsdLCl08grKuUWZFw6KTmWvZj5rf9WFLwQXndHYNZZ+PFg8jBoCLkmjf
 +wQVN99z2CDMlflW6civ0Uw2irm+V8DhX/onolsY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:14 +0300
Subject: [PATCH 07/15] drm/tidss: oldi: Remove define for unused register
 OLDI_LB_CTRL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-7-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=FkIewGjJgmTlrhcbqcI/ZGMUPpfnTF6TeMFYfD/xf6w=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iIFey/l4vcKVxR+5WkadBr8jXczXYL2hzcjU
 fo++LLqQdqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiBQAKCRD6PaqMvJYe
 9Y9wD/9akYkqmkfYxklqM8y0MS8KwtgDhNiRzs/CfWIGsFfMmM8+lKimGP0tv1w8On0CaNBBeNA
 uOJsivYBWChM4uDMT0lg4yvkcQ05/G5tok9VoWGWOFpugzhhUcd523HdwtK5QbPFYjd3YGTLi+B
 nvg8xDt74sPEmwcOqQeGbjdh0DcnXDTMrnLRh5G5Y1o+etnz26OpjOnp/9iPchVh0D7PhCBFGLj
 fRjH0Q2d8b3rngeJ4lJl5zE7ZTPOjQIPk5yJ9V6xY2pjZytt1AoNvLfF4yK56ntaU1WpUFy6WbL
 /qm5483YETC1xPZtSQ7GWX/Xb+ys82hJNkDIt+87VtusqzmJiwcZ+cz1ruAhWm8nKF5sk25Ch1q
 pi7pv9yBZ+LDswcevzT1CB3T+dci7TORTn/fMmnYgBCn7ilTEN370BsOeJxZgmaREB5GtyyVpSP
 4Fhhf47QXnvlgiarUEuApJ7Hb99Ga9utKvdcMu9U9MV14It6tqkDl4Ve3HNd8gs666mh8A5TM4B
 UKOEvQqP5VLBzVOaJ+WbuB7bwbmtWD+bK+vueGQvZCeRo5uVMuqGufRtwkCk71LO6py7E8RuHqu
 MXubMr7Fv3bwi5MP+6kGn1BMM4vX+4Zj7ocKnparh33kIN1d8Gz1k5DhE32Fm+4TzON4zilQh72
 26A8WLcmCtGQ8sA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

OLDI_LB_CTRL define is not used, and doesn't seem to exist at least on
some SoCs. Let's remove the define.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
index 8cd535c5ee65..a361e6dbfce3 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.h
+++ b/drivers/gpu/drm/tidss/tidss_oldi.h
@@ -20,7 +20,6 @@ struct tidss_oldi;
 
 /* Register offsets */
 #define OLDI_PD_CTRL            0x100
-#define OLDI_LB_CTRL            0x104
 
 /* Power control bits */
 #define OLDI_PWRDOWN_TX(n)	BIT(n)

-- 
2.43.0

