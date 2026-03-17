Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF82FD8776
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59F810E640;
	Tue, 17 Mar 2026 13:47:56 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7582710E640;
 Tue, 17 Mar 2026 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by psionic.psi5.com (Postfix) with ESMTPSA id CD71D48ADA;
 Tue, 17 Mar 2026 14:47:52 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe: allow request_irq on GSC interrupt
Date: Tue, 17 Mar 2026 22:47:17 +0900
Message-ID: <20260317134741.3420-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317134741.3420-1-Simon.Richter@hogyros.de>
References: <20260317134741.3420-1-Simon.Richter@hogyros.de>
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

The default flags for freshly allocated interrupts are platform dependent,
and apparently powerpc and arm set IRQ_NOREQUEST by default.

The normal path is to clear this flag from irq_domain_associate_locked(),
which wraps the irq domain's "map" function, but the xe driver does not
define an irq domain and instead allocates the irq descriptor directly, so
the flags need to be set up manually as well.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6468
Fixes: 87a4c85d3a3ed579c86fd2612715ccb94c4001ff
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 5af8903e10af..3c4972a9922c 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -39,6 +39,7 @@ static int heci_gsc_irq_init(int irq)
 	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
 				      handle_simple_irq, "heci_gsc_irq_handler");
 
+	irq_modify_status(irq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	return irq_set_chip_data(irq, NULL);
 }
 
-- 
2.47.3

