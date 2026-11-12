Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BF606F89B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjiFTQHD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F60D10E3B8;
	Thu, 12 Nov 2026 04:36:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713CB896F7;
 Thu, 12 Nov 2026 04:36:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEA9E438FE;
 Thu, 12 Nov 2026 04:36:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794458200;
 b=pjqWijCXQ7qOiA9m7f14TVjbs9A8HQfB3Q/DhvTxnZn7TPcfMpq1FzwQtBn9qDByDibj
 XSaaRmTpf6nBcTeYyi6kp6zxKg9NkLQ5dfuPz3dX0IUjAepKEOgfMep/L8GngWMZG/d6W
 Uf5qYBexkCg0JBztBODnCQwT1GES5ZI548MPAqsq13B4p5LwFyIi9l1cCQVmXzhBHxTfu
 nlYhdQvnAlaaqnTvttIyshNSrRJmhayyURjAs/kb1aZh7NOOe4QarOQ0h9AssVwycvxZL
 35MZXP4kuQ29UYLktQDB3bEHgOy2SoVOabyQR5+c8kQu2/wxV0upNjXpx9N27L/NpRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794458200;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=CyYKJ2XHN0ueROsD0D37/Kxc+UdXNCVk/iQdBfNPhlw=;
 b=hsMHV9xaim1yLL/lg2c71j+qc0H/AKtZFVOF7gtR79Pn9WRQgqDU13ppo1kDTU2Klka/
 BJbKIest9IRdTPDS+6+jAstAU7rr9M8TtshOeQA2mOUIgp1xVbX2O7U2wnhiYyjjNKB12
 qVNI5hVbRyXEgfWhZGSUun3OY47F4E9lvoe0/i6AGf8GRvL6AhXW/BGtV+QGoy3gyTH6Q
 m8Zx9bUU6TsiJE0o4XKnuCaXvRYRgdQNbvbC+egsv5e7HOHQtaMNO6esvZotIpEIF+gAG
 ac+QOV9/YMeGNbwrncsN5VVpfDFITOQXNu6QXqy1JjvceiPLDdv8/PwsRpTMvCvo+kw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5C6F11F00A09;
 Thu, 12 Nov 2026 04:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794458200;
 bh=CyYKJ2XHN0ueROsD0D37/Kxc+UdXNCVk/iQdBfNPhlw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AjiFTQHDVR6eHPohTMiysDEaDkwlVQSbKukfZrQA+RhezIQTwVtRqrekgA5TO7qhZ
 P3jBwjOgQoa4cuYPdx0GNGjEDlhf6CrV8HIIxrNQPvD3ZWKNDUeMR2Mm2OPCiMvCBF
 yAd90idqw31WLFy+As8anyr6K8PRVR+F9M5LkqTywHOIJ4+7DXfGm4y9V2bA7GY1Ur
 LdT6dikRc+a2vWOOVqbQe8hHIlt+OcKgwmvc08YT+T9zmwrkg3h/6l/xwJLGQrOMPO
 cG/wC0gSjazJ+qfyVPDEfuC+TaosoLNlr9AxXMOCh1f9V8QGOHZO1K9MWKjGhtITeX
 dl9ShTmPTwjqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 645EF492B4;
 Thu, 12 Nov 2026 04:36:34 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Thu, 12 Nov 2026 10:06:34 +0530
Subject: [PATCH v2 6/6] drm/msm: mdss: Add SM7250 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-dpu-sm7250-v2-6-8e925a3a8a7d@brar.si>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458192; l=935;
 i=patches@brar.si; h=from:subject:message-id;
 bh=cuDZuz9tdcvui7XRO0ZIEMGONp1eurphXY1/XMpNa0g=;
 b=9IIeU68BR+9eVfgMJy9nRN68JwKvK+/h+pJxRHKe4L2ip7ZVfdUYvX4XnweFeq8OpFaxQ8bq8
 1ROofAYYv5sDUI5z++oP6fdI/pWAqjgfR0wgxi8x8016UrZdXkrj6r3
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

Add support for MDSS on SM7250.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e69b122f2687..f619052bbb46 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -562,6 +562,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm6350-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm6375-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm7150-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,sm7250-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8150-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8250-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8350-mdss", .data = &data_74k },

-- 
2.56.1


