Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE985C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9AA10F557;
	Thu,  3 Sep 2026 12:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZB1utidK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4945110F554
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:25 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C17E7280D;
 Thu,  3 Sep 2026 14:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437332;
 bh=UvHdagbTwCCe3LWLChhWVp46JCYRvLJb6Ptg6//6bMw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZB1utidKsV2TmqnhswUpSXMuZxuzfR2SQ9ImBeg3qIeHn2byrNnYEGJpGBkL6No0z
 Oc7qjdrVAXI4BCE61gKso/H/K9vg432yE749m7L6p+ac/UrlhITjidiQU6N0AvgQ7c
 IDZ9i9D1h65i4z0E4MLkaAb7Qsxgdfwyy70XRBUs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:55 +0300
Subject: [PATCH 05/10] drm/tidss: oldi: Remove define for unused register
 OLDI_LB_CTRL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-5-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=UvHdagbTwCCe3LWLChhWVp46JCYRvLJb6Ptg6//6bMw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOnQQE2GB842vtnlyKLRE1xvbDux8h6KHfdm
 ZGW+Q3hMHKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljpwAKCRD6PaqMvJYe
 9QlMD/4qgYBtFeE9l98mB6BooNKopOctD3+GCQ7Cnbg+hgKgjoAl3fMJ7XkgoQqgF48UZsT5uiv
 Wkj6GxOE6UCgW55KPPLxZx+id1CeF7yohnuoMMadG3LbCxSo3eyvg+2AImrVXxSWlig/uW3Dn8p
 VwECHTS0nzNsbGupisrzTjixJx6DSS+R8R0bmzfcX6h0Hm5TKl8Bl2KshhiHyfBAVn5VgZGHodF
 UyqqjVSANCwljtedRDdVQtZrxNQcrXnPUv5AlCwEulZFf6oIhoQ+4rgp2iFBG7KJQ4G7WZqCPRI
 5FoOWRY9uNhuHaOXTw51TW2vp2HDENazARJrvZGYitsBkesTrYOypOf8r2DXbkq4Pjz9L7TJyV8
 ULVR9mSynz82Z8DPAX1vSte4I8mHG2+Q4XOYB5fKyxY6zUpBFMZ0THD4JiLZDZOxZNlOoNe2WqY
 bIzpoIt6exZ2QkJyEYd1ozEk+yKdgtQ3OOjOfkA66uzw1hNm9es/2RoGyykeDClTPHXLAGn1na1
 6Mtn78gM3of/5t5/AKMgYCcQoyyrWsaye8MQNeP5/Lc+AoJS6PR8T9y83VXeBj/bKZ/WtbrlKKw
 fz3DANnt/+dH+74eEzLh+FvV2dYTC56iE42A5ZB7tARyoqle2o4G2fGP7VOVTnb+YlaF9dLhEfv
 SGcP7zo3zwY4BVA==
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

Tested-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Swamil Jain <s-jain1@ti.com>
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

