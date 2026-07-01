Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C52AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761A710F037;
	Wed,  1 Jul 2026 16:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VySaHdDZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCB610F037
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:08:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E66F143D40;
 Wed,  1 Jul 2026 16:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C421F00A3E;
 Wed,  1 Jul 2026 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782922129;
 bh=s5UylNYDTspcuu9MwQe+nNCZE8i0u6cLYLoMeIJYIfc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VySaHdDZoDiJzUm+97zbd0xZo4HMp6Hfn2fMQvLrLwb5XXMhno3TqC9g5nITaD6C2
 QcoZDYhaz8CSM6nl54LKWdZPg4JvN9LZiJZ1ghCSZZ+0UWSzFcDSd41v3mA8FbQ0tv
 lhP/RQFj8HymUZfo8xgw4whmaSMk3PlCphdNFJNouyFcFBUylKA9La0MY6PfKRXv+l
 mjED68ijJASgQSo00QyI5Uk823Kqk4O1T5vFPUmW3CxIuXEHzu5FF500FP23KgieDI
 Saj/33mlVh0Bc09l8g9w4SnZWNDl1kfSUjojpWPgG3KlvKhkeRnE9fwsee5JU1xoaQ
 fCN014hGMv2Og==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 01 Jul 2026 18:08:14 +0200
Subject: [PATCH v3 03/11] dt-bindings: gpu: host1x: Document memory-regions
 for NVDEC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
In-Reply-To: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=treding@nvidia.com;
 h=from:subject:message-id; bh=YiLAGkzcznmBG0BMFt9ttJjGeSWnN/89E2oKOOw+7sE=;
 b=kA0DAAoB3SOs138+s6EByyZiAGpFO4Wi6nVkH8SB1XxCYsDBFk1RCy3m6me3qImXpoqxvKh66
 IkCMwQAAQoAHRYhBIjqwwgBScz3wI3In90jrNd/PrOhBQJqRTuFAAoJEN0jrNd/PrOhtx8QAL24
 JFZ1eyoK168npHmVnch9YgVz+PSE7M0Wqwi8uUTcVivjEoiQ6p6pa0SeTBugcnaQb3QBo0JrLUH
 o3clj6tNA211B6HFML1dhEO7HKR8sJZ/48FQrzKH5/hNriAnSUr8GsNYN+EbMiJretpSJj8F6Vr
 5sNqDyQ9NJHdbJxxJ0WQgMEa1P3vLc25Sn9UCcBg2Vze+51uVnXJgM1JqTFXusf2HcdLzzBF5f/
 v8pd0wYGl4VDcrtfffFbgv2zptz5kwuHmwQwdA1TJZ1l9t0Fl9plXga8LaILGNBoiFy6ecl7dDA
 sVoQJgj8vyBXwRk5q4Dzo1u4FNC+5cl1OLJZkpcULDxkj6eyfnx23iY7OkXgCRz2PLUtvjhpTZ4
 QYTY1DyX9rlQFrlzy3aajhQtUhH15tx7rLFy/0DnxQbaJeYMMjcEu/DIx/+K4xfNPXr2KcnNfKP
 BbgkgSpR8yCTKCZDQYAubaDvQOUeWULBVkzsXU2S3gqX1Puf/e4Ge7ei4P7s1ruNjSFpMmzWbxt
 9y/W0XfJuIQzLIvozsP7xEQhIgospemSYCrQzf3qbPGYuNW/JbSiC/H6ahdoaDTyKJkkrl2te+h
 +WhWkbwXbu9bYoSe6dUf4gCoSZ/gYYT5sLIDONwrOZRjSdV8d2zo9HehXb3+r1imNr35qn32lf+
 y/wAZ
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1
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

From: Thierry Reding <treding@nvidia.com>

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
index 4eb325cfd296..bcaaabca945d 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
@@ -60,6 +60,14 @@ properties:
       - const: dma-mem
       - const: write
 
+  memory-region:
+    items:
+      - description: reference to the video protection memory region
+
+  memory-region-names:
+    items:
+      - const: protected
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:

-- 
2.54.0

