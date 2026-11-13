Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8F60A262E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1fDUfXR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A4F10E5C7;
	Fri, 13 Nov 2026 05:56:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5C710E0C1;
 Fri, 13 Nov 2026 05:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C84A456C2;
 Fri, 13 Nov 2026 05:56:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794549398;
 b=onIQPt5+5Yk9VhfIMsYi48qzFL0cYHi3sFGpZ9qOjbtAOPREl0HZAvvC8tyYu4/Z0q0d
 /v5DlnyKEEzXsS6D+hm9NmmZQTLTmV2b76UaP3aUOUFcfkiGweGEJVGZS/Qg2Bf0jBUyf
 srdLkfNj8bF5ZQPG6zR79g01UVFGg3PXXgvxBBronlMFMIAILzSYF6WrOM0ml+TZkxrO7
 PUDZlqlkvFdedqItGym1FvuoUAa5L67ajH+je3cvLj2kb3rOIgLXO6out8LGSYt8IShZQ
 aoICQtxxHsHxRF03iJepGJocdKEYWPYMrJFycjR4rq97Zd0gj6rhFjhOWQpFszsXU+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794549398;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Reil8ygCc1nytaXO1ICNS5j8n2FP0GWGO45b+PF/9yc=;
 b=HDvSV6bFkCXmys5doaAemuCj59/TMz0nN30ej1LliwQKE2Wjbe7M99Q4BNiQd89DXRZn
 gAekn5lv5clGHO+joYCsjPsIkiKaa3pSTyABqr4hUvcRzJhG5tf0zl3eOJ1fXZCEkiFEn
 UAU+bQLOYs9CAlzrq4Y8Kpu7tVG2MbTAz56VA1Lt/6eeQa/durJWe8vUQ3ITvF4SZnLvU
 /pfYcNQu4CU7IQlbu0XgxTAMpzohePoxcOvE9fv8FN6nIsq2J0yUYSkeNqz4YOsE9EgiO
 mFve+gE1QC1tDWVL7vutalwj2V8qzYzFFHFvslaEuvhLqudrsG0yzCCrHcL0/RUhiYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F3F6B1F000C6;
 Fri, 13 Nov 2026 05:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794549398;
 bh=Reil8ygCc1nytaXO1ICNS5j8n2FP0GWGO45b+PF/9yc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=a1fDUfXRKTgR3+0ure6sAiL+itJbO0svMAUHcLaowP+IwZS4owfs95gsJTYqvVot+
 rS9eVM5CsLh3ggyO0trLW1a8oEK4IcLVDsJLSh2nwYGO3uNWdE2/E84KwsDu1axVOe
 kNePv6v11gIWYccTjbT2y69VJrfyconmMOTWgK2TvGIA3r/pReLypL+R1Sd/pwWuWY
 MFEw8MOSwFPrARFMoHLQhlGnQhzBLdqGTd5RzTBpk0CNhSqO+p9FnrDfmpj70fQPNv
 G7KvNUAGdbxNt3lIBumGYjpKnSs0AQh8cXchMeVo9ys3Vh4ZLK2NgCn9NWSKXlz6EY
 Sm4uSU/UNanGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8315F4760B;
 Fri, 13 Nov 2026 05:56:37 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 13 Nov 2026 11:26:35 +0530
Subject: [PATCH v3 2/6] dt-bindings: display/msm: dpu: Document SM7250
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-dpu-sm7250-v3-2-30bdec59d204@brar.si>
References: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
In-Reply-To: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794549395; l=1095;
 i=patches@brar.si; h=from:subject:message-id;
 bh=zdiEvG/7zaoPQ13tOuYyocT10YBSxG0J7UB0g2LRpC0=;
 b=qh+6Ez0un6ILQeF5jbgypelRJPgiut0hQ5d4TtSSR/cUrrmjvj9g5lF/dhklF3VG5zr1Kvy1J
 xJKEsUTL31MCrm5tEv+LZPwV3CQzoGHBMgPTDEsF9DST+HIQGmL4pAI
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


