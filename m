Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C45CC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8671810F678;
	Fri, 14 Aug 2026 15:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="flinAHY2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF6010F679
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:29:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB29760A72;
 Fri, 14 Aug 2026 15:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F381F000E9;
 Fri, 14 Aug 2026 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721380;
 bh=hagYf35q6G2UhsHzty44d2izTZaC/NeM9Zitkk0WHRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=flinAHY2TCzAQp51/VofbBun1xlQT2bmsz0G1F/e/noxEOuSLeCum+o7maLYlpqmQ
 /fCNRK5u2pVUDff9WOpgjdwfv0VumaETvgyjBD4m7+9abjd9YoLuS7S3vH2wdng+V6
 uj7WjDBEYfLKM0HpZIxqjl1aAMkhgGMzLDS8HyEPqzQENhaojB43Nb+uGZYwrR+2S9
 AmOQ7kiZ37CH0EhkOYKjVh1rHWwCiz9CFNYIp+EQLcshpuHC8XmP2t6KaIqriIeuuk
 1mU79Rz9lLEOUmvrPQziSTmt4Y/uAz4fcbHpt43cs5nOKiBPHM6LWTWen7lsSUWhav
 YJb4sUfspUFpw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:11 +0200
Subject: [PATCH v5 03/10] dt-bindings: gpu: host1x: Document memory-regions
 for NVDEC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-3-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
In-Reply-To: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=treding@nvidia.com;
 h=from:subject:message-id; bh=96od8SnVSYMiavrRwbh7Ehk1YxWlsQuy9Uk4ZKu5YoI=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRXzzaJcNN7yh/4w8KOcdpo2zu6d8W+euiDX
 mBrAATLPxSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80VwAKCRDdI6zXfz6z
 oTw8EACuc0eBM13PSAlDb5GHdm6QtW4MAiTJa1Pw+FwiKHMIRJpmpzbu0iIG0ZOdmChmnu2ClwP
 s3gbqJ6YRrL9ruy46tyMj0RVjZmP+8itbMFX9Dzx1WQ20c6wSYZPljF4/NT2DncBSidJT9msAw/
 Isipo/ka6MqadTIpfMi+veITAsnb1pJn0wugYxr/lecYT1Qqk8pwaBDtrh6QcceAiyT4XfUkuG/
 V6wZv8UbLps/2wgNoUPKoxF2rAqYsH4936MxwWMKbqK9HdO39ObjyAvfkRyBoSyITu9IEC+Tvz7
 VGGB576u4oSzVEUSJCQfgVFE1uvf4l1aOpmgYgzzp4PRcRg8nuu6eyjSjJ1TtNl+zU8SU6uthvC
 zv49vGosmKrQ385BX94aSlQ356vW9xuaN96c66oAzrSwDFpyXthbnEQLJoOBaKQVQFbaQMfvGwX
 CgTQD4FXkcZnm85qZr6J0K8TKMtlY/NPvtDpB9kMN93B/PVT5GASAQI2wE9uKDq1Tq30K+I68c3
 zO9oJ9WO09izzerU9CXmI42KivHR3h5CUiTV4O0eeAE+LvA7T/kgD2XTTur3s7VQgqJhDK66iGI
 lXeWljmZ6k5XjRnwmsNoncXTKdLTviNhoB4KcPTqULm8/kGAKhLCJD0fdHxTor05+AjZx3SixcW
 eHXtvYBAnuEhCfw==
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.55.0

