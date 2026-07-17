Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FCBC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60E510E7C6;
	Mon, 20 Jul 2026 07:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="v0Ev9U20";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIXOAQwc";
	dkim-atps=neutral
Received: from flow-b8-smtp.messagingengine.com
 (flow-b8-smtp.messagingengine.com [202.12.124.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3594110F454
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:01:04 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id EF81913002C9;
 Fri, 17 Jul 2026 04:53:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 04:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784278429; x=
 1784282029; bh=zinUu7usH8QT+lRBkTaKjglbcOcyqsNJ7aGjhR0dVuc=; b=v
 0Ev9U20tBJWMVb1EmdXdnSoUf6IwfEDDfeQWAomsNPlGcq2M/dSHHugtLYyProcf
 tUVfpYEHMEHgmAjoGtKW/NI6ybmC/hJ40dbu0DfaTNeFkBzKoK5y2Ttn5g/N5qPU
 Njt+qeuAo4vUGll42ky+E5WPiNds2bcTINQw6y9DKPVlb0LLxk6uj06aJPi/deFg
 J0rkKLXlMpE/E0q/vq4y4v1gh0M+47BYIW8e74q2/r5vgYY6sMgWw7NCpFVLd4l2
 1yzkrAEcYerdljozyw9D39M/XbkYEeqia8nAIIjzW/AAos4VG9U+WDp1zCP/SqrV
 G8DgZF+vTuOxDN1wS0sTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784278429; x=1784282029; bh=z
 inUu7usH8QT+lRBkTaKjglbcOcyqsNJ7aGjhR0dVuc=; b=kIXOAQwc18Lq5X7qC
 /HflxDnJPI2DhuHg4+4a85wMJz48k+2uNgkIP9e90PCXiWUyhW50tuKDfJ4wR3EP
 O1ZUJX5GjW2tWzA6H5K8aQ0AFBYYHajgtImlXnY169Hc0tE/9kYbQWYYkI/a1rO7
 0TMeHvhqj4aGueHYaJeVtkHWdpIz8g2ZiCoKZPVYIp2sIXSmnpiJ00wqFup26Bxc
 m+jHudN8HkXb1dsOGsreNjXC0HNRlFO2yPi4zdElahDcUjseEHNDvjn4O68LGcM1
 dTG4oF68ggSxy5Khe7anEofBtl8eH6GdUCz5iLalW86UQB6rYJYjrvUV2GsZ+dg/
 5wnsA==
X-ME-Sender: <xms:ne1ZahKSnZPikya0PRW9xaHqJYmxvzw9PuieOBrHHI18YeIE79cFkg>
 <xme:ne1ZapCs7osDD-DI1Fy8I7njz9wxbp5l04XG5p03nrDaH1ZbQvS0tF0UehYPPKXc4
 QpI3h6lEcDaX6McU0RyGKW5JLGRbFYXxuzxhTK3Q76FHIadS7QB9A>
X-ME-Received: <xmr:ne1ZalPAfAEOvps3ZTtp--HFh6H6o9dfpdzS3oIenCCmeahqhEA3GxmjUvTRFpl7KIr-gdNi92QHZQvqgoU>
X-ME-Proxy-Cause: dmFkZTFS7GW/vS+PGg3aNaRtXNWwH13wr4t6a3PsYvzLEfoa0d1tCLQMk4kuPOyqJxWYg8
 zWRgYifu3Q3qEvL/I6D+A7sONbehMF6Fzv0Jx15W8Bp0zPI2L6EoHnTvsn7KCzlmdcjq5Z
 AMiUX8pm/4UU/5q2rly/ctUYuGrpfv6aggolOMe4+7cw+YQgQv04wJ8otXu77hR4cT4fFc
 rauulgYGXJAH/ttinZ2FdpHwYOQghdgc8wZDZhtrydZHcBfVIkqxRabCZivPsjLLb49//R
 HUixI1q1RTZqMytwufV0grN2inkZxcvjyE8RnYSpDV3z9U1hNPWgMeNXqfzcYN3TNROTjP
 DJWBxCI5LG07PpCtrDGQylNVLAXiJDOw8Zv7N+umyJqbcz5h42OyiWTfA9CJmLIVWk/eBR
 7Oln6Gq6e+F9e84h2z6cwCDpiPcYcwApw7eCgr9txIBNNq+fRM3OTF3EQHFoPNbSxFAkpU
 5ELogvMw16Wd+Vy6XMRw9A/UtwpPyLICJuTXAYYhH4xpDkDzMpb3HsHGpDAc1aQPOHAVKz
 djVrFxTql8z755ghlxCYAAPcAYjK1U21pj1mw/oRDOjRT+w19y4qp358reb4GFc2oAgB4C
 J/ZOdnLoEh/CfXkF+vAx7BUzlua9nEu49XoFr0DIyWHCNBHuc6tRzL6mAn4Q
X-ME-Proxy: <xmx:ne1ZamVf31AEljBp2KKIoxbKOG-lQk3X5ND9YiBLc3vCKwgoosp84w>
 <xmx:ne1ZagQVWCGUG30yhYZaGHOFuWtPwDLAGpbk02NECHF1eP5fnOfnvQ>
 <xmx:ne1Zak0hbu3Ej3bh0k9toYLJ3R0M43UiOyyYQlVdTmEiym68R8bg5Q>
 <xmx:ne1Zalh9lYwZvJcbWs2ezvAw4Kqm81gGl0hUN-NqWGK9Ainagsp4_A>
 <xmx:ne1Zag4aPt7Zx-oleisTXffXPfkps3G8dhk90C6wCJV4EDkwuO5WycWb>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:53:44 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 4/9] iommu/rockchip: skip orphaned-fault banks in
 rk_iommu_is_stall_active
Date: Fri, 17 Jul 2026 20:50:42 +1200
Message-ID: <20260717085220.3212274-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Boot firmware can leave a PAGE_FAULT_ACTIVE condition in an IOMMU bank
before the driver has configured paging.  Such a bank shows:

  PAGE_FAULT_ACTIVE=1  STALL_ACTIVE=0  IDLE=1

rk_iommu_is_stall_active() sees STALL_ACTIVE=0 and reports the whole
IOMMU as "not stalled", so any subsequent readx_poll_timeout() loop
waiting for the stall to complete never sees a passing result even
after the other banks have correctly entered stall mode.

Detect the orphaned-fault pattern (PAGE_FAULT_ACTIVE & !STALL_ACTIVE &
IDLE) and skip those banks in the stall check.  They have no in-flight
transaction, so they are already quiescent.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/iommu/rockchip-iommu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196..f42ffcafb 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -378,9 +378,23 @@ static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
 	bool active = true;
 	int i;
 
-	for (i = 0; i < iommu->num_mmu; i++)
-		active &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
-					   RK_MMU_STATUS_STALL_ACTIVE);
+	for (i = 0; i < iommu->num_mmu; i++) {
+		u32 status = rk_iommu_read(iommu->bases[i], RK_MMU_STATUS);
+
+		/*
+		 * A bank stuck with PAGE_FAULT_ACTIVE but without STALL_ACTIVE
+		 * and with IDLE set has an orphaned fault left by firmware before
+		 * paging was configured.  It cannot enter stall mode but has no
+		 * transaction in flight, so it is already quiescent.  Skip it
+		 * rather than treating it as "not stalled."
+		 */
+		if ((status & RK_MMU_STATUS_PAGE_FAULT_ACTIVE) &&
+		    !(status & RK_MMU_STATUS_STALL_ACTIVE) &&
+		    (status & RK_MMU_STATUS_IDLE))
+			continue;
+
+		active &= !!(status & RK_MMU_STATUS_STALL_ACTIVE);
+	}
 
 	return active;
 }
-- 
2.43.0

