Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1296082BEC
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=BF4QVkXe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA8A10F52C;
	Tue,  3 Nov 2026 11:36:12 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914D710F51C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:05 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2FF32805;
 Tue,  3 Nov 2026 12:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705627;
 bh=4F38s6u+YAdZAkcvnqS12ydXVGwdXIr2aETVbPB3uE4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BF4QVkXeBzUPQ7ZfoZw3qrPx1bIklmPJ75hN1b5jG2jNZ6HVk5rU2fjx3eSduX74/
 USzRE5G76QW2nTpEUXmZW8sZTtP76CePqPTvUjO1KyYMEhD6B43suX1DTLvH0Y2cwj
 InvebAmeC6ZLftX/G2eukkgpOl4tpJHbkisY8b4c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:27 +0200
Subject: [PATCH v5 07/15] drm/tidss: oldi: Drop unnecessary forward declaration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-7-f1c8d0e52bb4@ideasonboard.com>
References: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
In-Reply-To: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=4F38s6u+YAdZAkcvnqS12ydXVGwdXIr2aETVbPB3uE4=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGrpxxeiQdCssNWcjrPR3Yhv4bAQhNlUrpPfUmWc/SmFYoCgG
 okCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJq6ccXAAoJEPo9qoy8lh71ShEP/jcT
 0GlOEJLepBQFo/LlgcgrJOL9HsgJsblq2Idi1NVsLt63IHLAOb9ENcpi93GIfnK1mHOdy1vp9Hg
 y8quxkqJqpb6CqnrrcNXF0qqgdPJtmRX8xXDwSdbTWfuL6JYmz+IaCvl4niNz0OF84aGmcXqOsx
 bPwmW3mRaoPXr4nABOHSAAieP83jxNCKljntCWHV3dda82gJMaDSwRQSbbYYl5Anw03DwpXE+xZ
 UW7gEi1Ia6NOzUENPbEIKHZFOqqEn3SDg7E0RY2HCawhX59GNR92lI2EmSwr04SNRfkqC7AbDBS
 +7yrAsVLF6TNKFyKOv+jd1UwY9L3jh9aMbRJytD/iLkTrfTmjpk82wdBqYn0fIKAJiT4xJuXaz/
 ICBG51tvf4bSouS/vCwop6DIWI4jVZ2Ut3KVYuSPp/s2gADfVegmSTXqgfRyf7WkEcnyri70reI
 M2SMbMWqqezkKxXKEAxYC18lS+bEG+pfgBM25jCqdTP4oyRy6imowaHyUb3O4tXJ2Qm00JjRrFM
 E3HhwLJf+ZXxc54kVitPyqRw6ikmZ8qQ+eecS3BtpAQw+zJwUx7YhBezEvQ1C0EEObCmVyuoJjH
 0tQ5OWoiai375iBNlvJ1LD2ly9oNUbYF9OdHdpEAGfUxLOjdowulzIDGnNa815qTAgS1Nmi8x8n
 4ysFM
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing needs "struct tidss_oldi" in tidss_oldi.h, so drop the forward
declaration.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
index a361e6dbfce3..ef9597fe5409 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.h
+++ b/drivers/gpu/drm/tidss/tidss_oldi.h
@@ -10,8 +10,6 @@
 
 #include "tidss_drv.h"
 
-struct tidss_oldi;
-
 /* OLDI PORTS */
 #define OLDI_INPUT_PORT		0
 #define OLDI_OUTPUT_PORT	1

-- 
2.43.0

