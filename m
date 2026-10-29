Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A338606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=v3d8Qd4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30951121BF;
	Thu, 29 Oct 2026 10:20:08 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A08E1121A4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:20 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id ADF706DC;
 Thu, 29 Oct 2026 11:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269025;
 bh=/GoFfTl/Kixz7EDIo1Uq3VIIhFdLVvKZohyPCmYYDv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=v3d8Qd4O96kpm2a+g2SeggLnDaQSrm/8Rp3rMtzZutwLaaQXdZPOMtIFKzzk0lam2
 3xKv3nLaqZqWKsvIdhtgSbCgk7vlXjzBLLrFjKc3ZRT7KTlqXJ95w5YpgQxKzuhkzs
 tacb5c5bBhGH1GaOW2gwZA4WBeKh1ddMnr8/WVd4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:55 +0200
Subject: [PATCH v4 09/14] drm/tidss: oldi: Fix cleanup on a failed init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-9-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/GoFfTl/Kixz7EDIo1Uq3VIIhFdLVvKZohyPCmYYDv8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2YCPZR5VxH/A71tEGFXbblUHJJy2Oazo+qE
 8XAEUIBt4SJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdmAAKCRD6PaqMvJYe
 9RJZD/9UVeyhtTJsTMxIRzfp8aCl83yU/jVMWxR5xDZuJvEg00jydB1IcemMAPUquKtrLIFR0xw
 KD2G7/Z4CvIV9bRjn6O77GKv4gWEXQMDsU947Z0hQV/M99JRE+BvQ89Jbm0notGSS1XeBv20cpm
 DZi3dOehrdH4ueu+3wvaq0NWuY19RYeVu3VyGy/A9Eo0APXUIMyTRdpqG9rqmwLWZ/y+ctsxmtX
 FOqzbCg2xISnPOEXRUqvHwXFIq2DmCOtPK/am/DBZEQcOBzK/BuFT9YkTMoxUAJeZ7UA12yT+t/
 BTw1p8CqktI07ze1nyPipNv7O4O+DmHsCHLNhVT+OksioTC8nX8ar1LzfzSpVbHFpYVMpXsXRcu
 InYfkP1xpndBAl1ESawpuZV1RbtZkiqVo6F5FpZXQjPWipoF8ZPqZtCEyCaXKhQatklaVUwCDTp
 AqESpVUzuu7Iv/5fr4ZusGS8TV+h32MTsj7K3MkqJmTG/X4oXlpjyz7oxx+xoZ3RsBO9z5VVRHN
 W9eiD9zCretVxt9ippLvWehg2VQYm8hT4QHXHhEbZ7z2IXbxCc47w3LybNaQk07gcwfDE+7vDiZ
 cdkku90T61Jzd22znXteUgOQ3I0vAss6clbI+aP0bt9Rpstms5oMEMvOOGYJNr8PcZkOAaJ1k71
 fWMUWkGECleqD1A==
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

tidss_oldi_init() registers a bridge for each OLDI TX in turn. If a later
OLDI TX fails, the bridges registered for the earlier ones are not
removed.

Fix this by calling tidss_oldi_deinit() in the error path.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 506507e83112..7344d86e1f13 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -638,5 +638,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
 err_put_node:
 	of_node_put(child);
 	of_node_put(oldi_parent);
+	tidss_oldi_deinit(tidss);
 	return ret;
 }

-- 
2.43.0

