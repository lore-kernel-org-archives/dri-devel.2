Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9829FCD4F42
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65BB10EE7E;
	Wed, 13 May 2026 13:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KWYq6mDK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A2610EE77
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:04 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 737B02E4F;
 Wed, 13 May 2026 15:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678275;
 bh=bSJ25hdhRUWRW/tt7xLdkj0tLeAfFpTuwryHocg6FPM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KWYq6mDKn3YTBmsrpB+gmpADSvAEOqMRdYIoxsDrCZpEooPq+q4N+hau/Mxdg9v8d
 D4bcnmlCwGIBQfvmP88AHvjRG7OX6Qf+CzZ3VBPhxYW/cg2pblEzOEgF/xhSNCK9Hr
 zJoJWmvqTlnEGykIXbLBFTkCH2CK6xPXh02+H878=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:29 +0300
Subject: [PATCH v2 07/16] drm/tidss: oldi: Remove define for unused
 register OLDI_LB_CTRL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-7-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bSJ25hdhRUWRW/tt7xLdkj0tLeAfFpTuwryHocg6FPM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn+2YNXZZ8aN7zUh1BcDJWnr/httpnHSfxdC
 cui6qEUcaCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/gAKCRD6PaqMvJYe
 9SiqD/92c2VScAUTj8GGdabM+26DMx/WnaEAeKL7Xr0dK0X766sGDIr+pltCP7TpbKRVBk48LX8
 UVOeX6UMs8i6Gv8EI94LABG54BXMBDZX8LEjV5q3jdiV+3U7OKu5xTnN+qugSHlXwI8J9RN5/HV
 JDdam/oFzvnDu9fnjqTTkYHHUYtTWYh5xYeH9Ocnyop4bEVdVx87a6KLyl/I/RI8entf1JwlMC9
 2xyg/SBt7ib3koWQJZsESSqvaaw5dNNd3p75kFFtMXVssoeaeJY+GJbRnQDR3ONVoJmZSWvZfrc
 vQhCc8SKk5rAYK31mJg6cPp+BDKOcEqqP+jy3FhYXiZ3aeGttksrR28c0Rhw6npgFtvn9zCsCYO
 D9IszvVqi3RVGGP2t5CblnrZQnCn6M0v7yJb595Ogc0Hxb/HpsIt1oYF7m8D6y7vSIUs00KCVO9
 PnSWlDzdVIflD6Cb9RoNX4Ygnvkxhzb4w93t+78QA2uuxsmhQMYmA6KGmrK2uZ/MmR81ZsyUC0S
 54G6i1FMLlDWujFD+Az/Gqs2SN5+FTD2jKR1/hnQsONUNk7cqUGMGnybQYVnH23CYETJdcG0HuM
 Ee5NxS2HUMlmzpxxOZMfzQrL3tc4vI5f28BbIhBFRy6ELLrGeQX7n2lTxcs2ljHBUOiwHY8sps5
 vRzPI3e0rqvR0bg==
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

