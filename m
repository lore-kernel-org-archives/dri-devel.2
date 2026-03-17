Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B825FD876A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3CA10E64E;
	Tue, 17 Mar 2026 13:47:55 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091C110E640;
 Tue, 17 Mar 2026 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by psionic.psi5.com (Postfix) with ESMTPSA id 2F54148A3B;
 Tue, 17 Mar 2026 14:47:50 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 0/2] MEI interrupt fixes
Date: Tue, 17 Mar 2026 22:47:16 +0900
Message-ID: <20260317134741.3420-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
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

Hi,

the MEI softirq does not use an irq domain, so the NUMA node cannot be
inferred from the node of the controller, and the map function does not
automatically clear the IRQ_NOREQUEST flag.

On x86, the IRQ_NOREQUEST flag is not set by platform code on allocation,
but that appears to be an oversight; other platforms set it on allocation,
and expect either irq_domain_associate_locked() or the device setup code to
clear it.

The flags are probably worth backporting (without that patch, the GSC is
unavailable because request_irq() fails), the NUMA patch is probably not
important enough (but doesn't hurt either).

   Simon

Simon Richter (2):
  drm/xe: allow request_irq on GSC interrupt
  drm/xe: Use same NUMA node for MEI interrupt

 drivers/gpu/drm/xe/xe_heci_gsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.47.3

