Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA3606D81B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=SyyZKvzP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0447C10E7E2;
	Tue,  3 Nov 2026 11:36:16 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C88E10F52B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:09 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 180FC287E;
 Tue,  3 Nov 2026 12:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705631;
 bh=F/L5+gkuDrSZcJ30dAJHYqalbmfLemsHzfUp8D8sZNE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SyyZKvzPLK4g5G2Km6cPeZvp8WkIb+iN2bz2BvYSXFlO3AKNECX3yJnCpsa70Aaz5
 5/p50Q7jPbCebwKvMBk0+BEUaC+mI/tH5bE3c9K+7N/x9M+kPUO7GPgfjI7gTSnbfG
 8ev48aytWw2tIvKWSN9Hu36ZTaAMjwZ/mZAbHnb8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:30 +0200
Subject: [PATCH v5 10/15] drm/tidss: oldi: Fix cleanup on a failed init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-10-f1c8d0e52bb4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=F/L5+gkuDrSZcJ30dAJHYqalbmfLemsHzfUp8D8sZNE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq6ccZw4IlyT81hqKavStnM561Q2fWsO615iqL0
 I6H4lEeLUmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaunHGQAKCRD6PaqMvJYe
 9TcSEACY5+Vp+/E3NpI4r2/xf8ktIe5+uxKMnOZ0b0eCB2ArI6ZP4F6SJ8vJP9aAE10xJf+sJub
 N6UaSa5KtGT/09zMndU1fhNbswi3rXCF49+TyZoYF0ERbeUL/uTCChE9ICeepYjgkc6lAKFkYDK
 yh6Fjt62jidNWKt+u92kkpBAZ+XGmFNFktmNRbdiPWhbzrp8eTQ8FdhKeKArAymYRmU8oxq5WV3
 5sYA7Dh4tGVcIZQiPk/uetF+UWOF5mDcVw6EdX2cfPC2USSGTv+hMxSN5w+IjYx4HrQq2yizH9D
 4l/k+SbJp1pqJE+6Ayr0kCYv6oQAuCc6XOmhV4IFPa7fIUU+8OI2TXum+T0gA9rQMMGmVMINuei
 Kx7q0/Thoy9oKifj4PLEXUDGJc2R6o3XQV2IL9b5zTDxC14jPWXTm1kE4o7/LHxzrhvtBT4iUGU
 slkskC+y+olOzTFvuqLZvpqFC6YxhP0OrV7kl71Bsdit4i8vjXdEO8yV+LLm9eM0O4Z8I9leGmW
 Cp+dg7qMz3JkRlbM65Pn3dZROW2h3NZLASflwroP8kJUqxHl0ft/yqE25Ug3AC0BOLLRQPk/FWp
 byqPWvJPbdeXRpkrabKTY1JnPl4h1DoxzSHC/ZrruYzD1biPIdKm1oEKd88NhQqzlzGR4Z4Ohgy
 shiQtBds35Gdvpw==
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
Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
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

