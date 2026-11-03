Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BD6085084
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=PA7HwPP7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FF910F522;
	Tue,  3 Nov 2026 11:36:21 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE5C10F51D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:12 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D1221F37;
 Tue,  3 Nov 2026 12:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705634;
 bh=PqS2ruK7frGkC0TCq9Vxb5F4GJ8X3qRXVBnADO5zlCY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PA7HwPP713o5ZrPurkqsJc7F7kx+HyLJpiph+MSzeV7Elf08n4ilzQ7mfsnSpk8to
 8F3/rTNRNvqpi3IXLM9Z3i/ouuzA1fkqEB47AYRVsq/XrNgxNDAGxc0I07V+hgTw+Z
 M3lNfVfNTz7GNMRxdLSwItNPL6D4ZOCJSm4jYErQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:33 +0200
Subject: [PATCH v5 13/15] drm/tidss: Add support for AM62P display
 subsystem
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-13-f1c8d0e52bb4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=nQs3IwWopJPpCONI45Cyuco5UVYrRBdHvpe+bDQ95yk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq6cca65axinlSiBbteoGzJR3wpLtcFhjJWSwnD
 RuFNAUm4S2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaunHGgAKCRD6PaqMvJYe
 9cBYD/47Pn1bCaMx0NbtKo1mrQGgueUJmrlI4qYyUVbp7dgQvEMnquROrMzH9ZQnDh7A5vprGE0
 MCIpdbfSwJLWoYbXvIpgIqdysZducF9YL+u39rhRWiSznOCC5rbc5feqf/tYXfr08pC2f2BH6AL
 dzaI6aATY/2/1T/TWwv9PxxAdZl62/sZUfC2pnCuOqddkQyECmkQ+Chs5XDR4uPjpapR8x93CYj
 N5eTmitx4gRp6n8vpvbWtdwV0EEHpKBSbRzn7jqiLxW31dPZ6EWtDTo1o3MnWvOvrELQKC60FjW
 8f7A6bBDsG7thJ48zfzMOe6TWXA8C4Tdmmm3lNkYNVDoQEnKJmg6c3/qDOnwl/jQp7twcGwkUeO
 suks5rTINlcfUwv0m+3mjmm9wHtK1pm7Ccmbybc+iB6+H/c2Hr7OKuiPLmcOAMO9Z7LUSNXg/C8
 0Q4OkoOrfjXaWDrR9zCSqE9CZHrhIZm9fbnT+LP0KxERrZD0M1JR7f/5DZnJrgpH7ggDfM9t6a5
 Co5aNfs2fmZHr5W+oxejKY4HrOp1JE4G8uVBf5PGaLRgguIxO4hilqE3ziqJivdJFlf98noBAoj
 9AxtHzm5QOrjiqy7imDWoWocsv+1IJeL+4glwDesBDM9Rea/RXAUBa3mC4F1PgA4uVbTDWd/ZAl
 Us9VmOIagxPTB3w==
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

From: Swamil Jain <s-jain1@ti.com>

The DSS controller on TI's AM62P SoC features two instances of the TI
DSS. Each DSS instance supports two video ports, similar to the DSS
controller found on the TI AM62X SoC. This allows three independent
video streams to be supported: OLDI, DPI, and DSI.

Since the DSS instances on AM62P are architecturally similar to those
on the AM62X DSS controller, the existing dispc_am625_feats
configuration can be reused for the AM62P DSS support.

This commit adds the necessary device tree compatibility entry for
"ti,am62p-dss" in the tidss driver, pointing to dispc_am625_feats,
thereby enabling DSS support on AM62P devices.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 7e7f2ba6ae82..86b7596ab628 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -240,6 +240,7 @@ static const struct of_device_id tidss_of_table[] = {
 	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am62a7-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am62l-dss", .data = &dispc_am62l_feats, },
+	{ .compatible = "ti,am62p-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats, },
 	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats, },
 	{ }

-- 
2.43.0

