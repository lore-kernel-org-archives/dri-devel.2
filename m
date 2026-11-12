Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130A606A8A2
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDEwgO6f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7546E10E350;
	Thu, 12 Nov 2026 04:36:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619DC10E0F2;
 Thu, 12 Nov 2026 04:36:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23E6047784;
 Thu, 12 Nov 2026 04:36:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794458197;
 b=h9/GHXb2CGv6+MWOhZ9c2EJxd8MeKSXg34y4LMCGqFv8QcL8nkhk/NHle4ChZpGD93sv
 3uj3xFqTw05AzKLmQgZ8z2tmaJfPiI7gr+/AtnUo15YWV0EvVb+n+f1+vvWRnecOtQf7E
 dt8TbWu8nJ2mjJmnBrsOtbP+E2GRak1hIqoj1666KpaY0jzaP7T7K5MZxz0shnQC/x/Fg
 kHA/+cf6K0LNm77s8zXztue/ITF60h7uQ5SbV7GOcG9j7ZEor6Hhq46Uf9EtQdHGJamWj
 MeKodEDMizfEDISXavDEp76tXjlVG1p8bDfoUxkkaRo6rTOJcVuwcp9sc0JZJ6BebzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794458197;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Reil8ygCc1nytaXO1ICNS5j8n2FP0GWGO45b+PF/9yc=;
 b=ytwwBYZCBqZMbzXa+ZF2bISuV42KA/mohYui4X9iQnHgHkHl/bGvmD3JV1LSsX4JuQQq
 GhntMDUEuy9cyiYii7r03PRXcede5NIbJ3I2/Iu4huLPFirPnvcSWf06m1aJLmp6l3b18
 z73v8cACEarRHyTbZ7JEx3eESHJNs4CgGCqsNuMto7XjCTOMjKoVzl1Y7bwFyZfABIA7t
 3bPMzvBN3EW5XyP+flk2gfmBlXSKe+3XCkKHlZTP2fKNOroaEj+yYbjBz9cuLV2ke3+NP
 FK+er+PSUFAB4SGJ2M1hM8CADIeuV4HHFxFR5mPPBeL1UmV58aq+JcywPKeK0XoYtfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8540B1F00A09;
 Thu, 12 Nov 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794458197;
 bh=Reil8ygCc1nytaXO1ICNS5j8n2FP0GWGO45b+PF/9yc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=BDEwgO6fs1Xn0A3k5uJJnkIh925xzHGp9vgsL+1k2+JKOCLsNKq9JtoDelFpcimVz
 Ud8ZdquR47qSgdqrP4p7cIu7egDFYv5qO345qfw/gb8Ax1kkKTsGiiN6iRysbXXB7z
 HExkYQ3OcAU2siivc2Dut9cqZSnHlZpJugoBNL7bPlUNCAQbZh6dqTg0Ih01PtrDjK
 8bS+k/3PZcVuIX8HNiw2GKDGortqVN82g++WWSU/EcKDxvJKSUSpNPk9gREOy5ox5g
 +xez7VQuMC/go008Jt2HI8n9lUaaPjQVueFWAEm7f5O4I0Jb4Y0aFARmSW3x95093H
 Yz8KnMg+FwxtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 125D1492A4;
 Thu, 12 Nov 2026 04:36:34 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Thu, 12 Nov 2026 10:06:30 +0530
Subject: [PATCH v2 2/6] dt-bindings: display/msm: dpu: Document SM7250
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-dpu-sm7250-v2-2-8e925a3a8a7d@brar.si>
References: <20261112-dpu-sm7250-v2-0-8e925a3a8a7d@brar.si>
In-Reply-To: <20261112-dpu-sm7250-v2-0-8e925a3a8a7d@brar.si>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Ishu Brar <patches@brar.si>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458192; l=1095;
 i=patches@brar.si; h=from:subject:message-id;
 bh=zdiEvG/7zaoPQ13tOuYyocT10YBSxG0J7UB0g2LRpC0=;
 b=BbG4pq93CxRb8K+GHwOe+p6klLTXpN2WuonqGWZzvmgVvC6oavlRZBNbSMAy4ViFoEpZJnBd5
 EBpUhyq2VlGDSu2Wzvl3SHypQNSDRkigaEgEXSueQctigNrBWXXTzBn
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

The SM7250 DPU node has the same register regions (mdp, vbif) and the
same four clocks (iface, bus, core, vsync) as the SM8150 and SM8250
ones, so add its compatible to the existing qcom,sm8150-dpu.yaml
instead of creating a new schema. qcom,sm7150-dpu.yaml is not a fit, it
describes six clocks including rot and lut.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ishu Brar <patches@brar.si>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
index a88d22f30a60..d779d3008c1f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
@@ -14,6 +14,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 properties:
   compatible:
     enum:
+      - qcom,sm7250-dpu
       - qcom,sm8150-dpu
       - qcom,sm8250-dpu
 

-- 
2.56.1


