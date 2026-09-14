Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76834C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5E910F27C;
	Mon, 14 Sep 2026 21:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="bjIJ/hgq";
	dkim-atps=neutral
Received: from zebra.cherry.relay.mailchannels.net
 (zebra.cherry.relay.mailchannels.net [23.83.223.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A026C10F27C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:23:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D8796401A9F;
 Mon, 14 Sep 2026 21:23:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com
 (100-98-23-230.trex-nlb.outbound.svc.cluster.local [100.98.23.230])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6A980400AAE;
 Mon, 14 Sep 2026 21:23:00 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Madly: 50e8e9824ae3bb2a_1789420980662_268343512
X-MC-Loop-Signature: 1789420980662:1542830486
X-MC-Ingress-Time: 1789420980662
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.23.230 (trex/8.0.2); Mon, 14 Sep 2026 21:23:00 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4hkJ5v5rfvzyrD; 
 Mon, 14 Sep 2026 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1789420980;
 bh=+gamu+CGGogG3yY20r9M7q0gS6qZ3bN6gqK7kTFXars=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=bjIJ/hgqyhvv4mWS+5E9pKu8oxHuIQ/UCjM83pncY5L5qMQWGn4wSkFHJmx3xilsm
 sbA7iXBORfOrgNj8HaUozO9E8QpXEUgR0PdWEqp8QPoI9JLmhW6IAFqKMIWDdPhqq9
 KgsIlig3gGAuOz57Q7Y7yjMhOd7lYpduJKtuvltXfGsQF2T2IHibO3oUnbUHTyngqo
 ETKFXf25HJ/tHPytDT1B5ZBwRu78x8ZiMF4aNxMt9+oaFl+OVSUM7Kin2H52GO5H6E
 nKJsnJaxVNqWBTGO1VcZkBIf6Pmo1cvrbjFFHb8JVyl9f0N5GdPvdiemKsEZaUx/nP
 OKtfY5cyOil7Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com, tjmercier@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 0/3] dma-buf: system_heap: 2MB system heap chunks
Date: Mon, 14 Sep 2026 14:22:55 -0700
Message-Id: <20260914212258.2657788-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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

Hello,

- Patch 1 adds order 9 to the allocation order ladder.

- Patch 2 fixes the order imprecision when using non 4k base pages.
This is not new but patch 1 enlarges it.

- Patch 3 is a misc independent fixlet.

Thanks!

Davidlohr Bueso (3):
  dma-buf: system_heap: add a 2MB allocation order for IOMMU superpages
  dma-buf: system_heap: fix the allocation ladder on non-4K base pages
  dma-buf: validate the attachment before asserting its reservation lock

 drivers/dma-buf/dma-buf-mapping.c   |  4 ++--
 drivers/dma-buf/heaps/system_heap.c | 23 ++++++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.39.5

