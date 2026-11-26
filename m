Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0760A381B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y31dNdot
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD18112248;
	Thu, 26 Nov 2026 09:37:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED94112247
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3243E6244D;
 Thu, 26 Nov 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685853;
 b=Uy/P9feKejjnN1XyZqzF35B5Rp/LT+crmIjIAC6voZJ4xOqC4hupHcrlqUi04ztpDZ/M
 sHU3i7yRb1UEfTNwz64EkpXUwUe9w0IZ6Djcjl/LjEEzTcmbWwgpK7/nJP4pBY5K+BnQO
 j+AD/mp90OfG1pO9mXUXdyQPGLifhlcBUbcCE7hNeODeKNUEm7g7A7HDHKxQ+iXnSj9u4
 W5hPMniU6Uipg4mHoLCejvSzC/gaUIInQQoVZU1LDQ5alDKyk1uPeD8ZsmCx31QxrZgei
 DOmbykharRVgvPwlXIPAPLxaahkX03cUPS0rIP2b6LL7IIfLEIdvsWNVLM6e+bba6jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685853;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=u8vVbY9l5xchkpD8NxU5Vb+8nf2rc5z52Xi2T5uba18=;
 b=xxZLBAbo4k+uZumL7dk6xgZemCcz77akTxmcAwebMRtAX3ko/BSMpLQCFoyNtatYJ+Hr
 /VAdMyArvkXfNlG8TdeNIhLVbrZSMC+j8pH8yvpFzzAXPyGmZ37XOm+kV5/AcLG5Ag5XL
 vcLba/I2rBmOSVqY34QEbNFetGUVKDA3mEko7LnlCALVsIZeFHILVfy0+a0DY+8wvVtzj
 J3r6mGAAM+x92t1L310jVS1JxwSOcu4RpJKGY+J2lXcOlCyniZCrvZt2eNiiyzT5ae7my
 h3QcgejF6T+G7EmSN6S1eKYBwPnT/h5wjEslqZR91Pw6TaAUl328Uf1+z1cC9XJr6iQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 876BF1F000EE;
 Thu, 26 Nov 2026 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685853;
 bh=u8vVbY9l5xchkpD8NxU5Vb+8nf2rc5z52Xi2T5uba18=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Y31dNdot0KckhpBobKhymRtTQppcuOjKSykJ08eULx4bJiU+qunRHAOB3ZGHIQjmX
 qIkZYyPIE05Gsj2ero6B5eHEE9hL6BSxvhUzjYmdtnuhr3g42JoZ+VccyFeU0xWp3V
 C4V+yJmRjleIgZCoeZwZFoqf7my+hNMQbZW2NF5t78+SuZ7QXk1HfEaRD5coXIitC8
 Bt3zgiJEy1rmWw5QoJSVwOlakorKmvvts+70z03Q16COc+6cbO9ETwfaHeWQ/ZGS/D
 udRMEsmSR+1jin3JYVd4kW9P4f5o6lCZHUayVZQ7PX0QeA56HXdBb30OEJ92OG60I9
 ePclyyupj0VEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 354434D38C;
 Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:51 +0000
Subject: [PATCH v4 08/17] drm/panfrost: Don't WARN for a heap folio a
 neighbouring chunk filled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-8-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=1719;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=h1Sah06axHBoYiBV3DUxqBu4DuKnGCu2PGurGHT6NWk=;
 b=CCvH+szO5tk/6eO0K116Yny/jSRapqhHbmXz25bRXJzaY3XTeVqqjngpqIb/J+qrF+d7qlxOl
 RM/4aqfiCXABTvJ8WQIWPPa7r9qfA3vIfNWvPoQ/plJNJeebHdQPWbD
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

With 16K or 64K pages, a THP folio can be larger than the 2 MB heap
chunk, and the first fault in it fills the page array of neighbouring
chunks too. Every later fault there WARNs, although dropping the extra
folio reference is all it has to do. Warn only for a folio that fits
in the chunk. Not reproduced (4K pages here).

Fixes: b49c35ba0ce1 ("drm/panfrost: Fix a page leak in panfrost_mmu_map_fault_addr() when THP is on")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-210837@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 9edf66f6e..92a4d2963 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -703,11 +703,13 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 			pages[pg++] = folio_page(folio, i);
 		}
 
-		/* We always fill the page array at a folio granularity so
-		 * there's no valid reason for a folio range to be partially
-		 * populated.
+		/* We always fill the page array at a folio granularity, so a
+		 * folio is already owned only if it is larger than the chunk
+		 * and the fault of a neighbouring chunk filled it.
 		 */
-		if (drm_WARN_ON(&pfdev->base, already_owned)) {
+		if (already_owned) {
+			drm_WARN_ON(&pfdev->base,
+				    folio_nr_pages(folio) <= NUM_FAULT_PAGES);
 			folio_put(folio);
 		} else {
 			got_start = min(got_start, first);

-- 
2.55.0


