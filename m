Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6B606F888
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7hVRTEk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC9010E0F2;
	Thu, 12 Nov 2026 04:36:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A6810E0A0;
 Thu, 12 Nov 2026 04:36:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCD4C4167C;
 Thu, 12 Nov 2026 04:36:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794458196;
 b=cmTD/+e/A7CBczZJeE6uFhL7yydNUyhXNinovDqPTKRi8qZqiPJvvR+iuYuwY2VaTHE/
 sX9hRlc+BugECpTvAWtzixK6AxQxY5GPXp//GmF/XS/qEBHwT4vW2SUuem1XNrt3pQwkF
 VRFyDEkvskAg7yCc1wIobVUD9BQK7f/akdh8PrjcdMGGbxJdXWpoKuL6q7B1/UcCWpWB6
 9vDWZWlvXFQnQ6hMTjT8i89w8odVu5xshr8BR4ujk2ICnwusbqL2tWHUmPF0AtOWGFloR
 LpN/rJHBs7ROj9zWqeZtSKY/MmM/VQdR2GMzg+M7YQfdktsTHUa/K2IL7WMoEWgFduQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794458196;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=d0ee55NVmB4wkp8GqkvjrVAOKus4qL3ReFL8IStXY8o=;
 b=LuFbotflVuKqMPAH+4eBrLj1bFq3pvPfbNYAF+PVuUmWs71K4sb/ZSmpzwepewW5HsfD
 pVVo61MKzf/BICDInx5nrQxqjf4rnXV5b7RZhCtUWKHqbOpfO1LHF260iZJeERfulR5g9
 INJaCN4l9kOwYKp7nefRy7nKMnBHKaDI8KdKQ8bMs9Y155tExfu8C28vFM9nkhSVShGIH
 94QspsWplSPQHSVl6snJyxLzOSwtg4FrqVqkKBdL3Ctb2qNWE+K5eaYIopftg0OtAOm3u
 zAccubwqYADzRvj+sUFfvji3aX29ERZ9HWTiEv7nqohDt4Q2FAn9js0ZdZf+cY6z72g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6DDBF1F00A08;
 Thu, 12 Nov 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794458196;
 bh=d0ee55NVmB4wkp8GqkvjrVAOKus4qL3ReFL8IStXY8o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=M7hVRTEk6Sid0NWVgF2naAewNzWe9cxk55q6pDbdzmTbR/4UefhddbQjbvvhiRq2H
 dfwVKD79Jo2/NeFNF/rb8i6WPPLqXyPlAbFsYfciiPz8y9ZmndLmaGbgejd0X5Q8L8
 IIH0hFXK+gZgVjKBFPFQpNViNe0/1KHv3N9pngacAmvaX/hTt6SlLS5W8rVe+HVA+z
 URRboZ63hNQOQKpOdh6nK+hQx8ao+Wz1SyLj/qw75P4pevOV4nkDq1i+ovGVZaTV71
 p0mC7gpgF0W4EF40nr2LD2hY9dxFkOCCcuGi1sTnGX03Uth009Sg9sIP3p9AuaCd8o
 P++ScMp8BBwdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F25CB4929C;
 Thu, 12 Nov 2026 04:36:33 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Thu, 12 Nov 2026 10:06:29 +0530
Subject: [PATCH v2 1/6] dt-bindings: display/msm: dsi-controller-main: Add
 SM7250
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-dpu-sm7250-v2-1-8e925a3a8a7d@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458192; l=1541;
 i=patches@brar.si; h=from:subject:message-id;
 bh=vZLUcoevInvSs4EvlJ6xECEz5Duh8PMGv9TOdJ9WEoQ=;
 b=b1ZAK2YbTLicS3bJpWLAnirFVI5+3thf6w0TmH42RzbHv5sC31MLAoVQiU5qP/+2Z5dH1l72a
 IFqND6gvZiGD/1hdu8K7JPdFdhK9mynbzZ6D52g3Zs+pbb4mHta0ZQF
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

The SM7250 DSI controller is the same 6.x hardware as the SM8250 one,
with the same six clocks, so add its compatible next to its SM7150 and
SM8250 siblings in both the compatible list and the six-clock if/then
block. No driver change is needed, the controller is matched through the
generic qcom,mdss-dsi-ctrl fallback.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ishu Brar <patches@brar.si>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e4fd1cbbd4e0..d447d7cc1a1e 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sm6350-dsi-ctrl
               - qcom,sm6375-dsi-ctrl
               - qcom,sm7150-dsi-ctrl
+              - qcom,sm7250-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -358,6 +359,7 @@ allOf:
               - qcom,sm6375-dsi-ctrl
               - qcom,sm6150-dsi-ctrl
               - qcom,sm7150-dsi-ctrl
+              - qcom,sm7250-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl

-- 
2.56.1


