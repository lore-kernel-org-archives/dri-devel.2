Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD27606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U88o+8Wf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488B810E2EC;
	Sat, 31 Oct 2026 07:53:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F8410E26B;
 Sat, 31 Oct 2026 07:53:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 809E7605C6;
 Sat, 31 Oct 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793433222;
 b=IcrQ8KVv8gQKi1KRFi2mDXk3jOEGXVnoYRVsvbo8bT9hBMEVnom7TGYMVwkaMbi0sc6J
 hDQWgFlM/5YjRTl68RfAXR20OokRby7E2+4DePkIcNCgEwAzlfxPrn78YynwEk6RXVhdR
 /BJ3bSi/uJrf1DB+bI6WEWXlPsiyWHYEoxzKrKvmzjeS3ZVUd0kqdHUVpzDOgHCwdLoJu
 QTA//hOWidhNNuI4S3B/LHP14j1PfkQcj+u/nCljni+1OvdbeNbUn4IHQ1BahCG2bgh5+
 6A0xVez23O6+JYu8vk4igXpInJmldFFCZRhSU7ecSojfjvdYbSyxm6OYQPdN1LpsqRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793433222;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=RC377F6Q8z5zRhi6tzzOZ9WrBx+Hhd5evmJ+C0Qr7vI=;
 b=u3vKBM47H1oxpljeWh9xb5YvIvV/nRxQo65Fd1AW079fOv75OKDhotniG7ohqhbUp4xS
 0gyEomJ3h99t5yg304qpsckVIl9vZBJZxb7QzFu/hgNh1ICTJtYN5yFm1JobSttvNFJsK
 OzLcR9NXjDUWfWP8wUc9TyJP8BHCEFrZvJnjNFkRYPdYfUBOu8JuTBkB9vb+B3Ep4Q71J
 lvmyItXfpYRCZ0DP72XwqUr2yayoO0fQaY/gPZZFdBsMYoSvRwxOiDza3A3mTnzwLR6pz
 QsMrnHvwvBZ1nMb4rJtSYLELmHbX/+HxbHoo86ol/dpFp2GzNRiYHGXJdtyhkmgJK7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id ACC5F1F00919;
 Sat, 31 Oct 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793433222;
 bh=RC377F6Q8z5zRhi6tzzOZ9WrBx+Hhd5evmJ+C0Qr7vI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=U88o+8WfcJSUR8xIU/27yVby3tojBBaCKbeem1oOLL0oAvgspvNC05cnflw7vo9DX
 00H1/0i+ZJcN/olknGaDqTzc2OErBxkDrg7vp380mL19HlrVNpFMXZUvokbT8BHEgk
 33r0ELpXyXF8qmi5SWim16G2Fuv5+4jr8focV/yD0sH/eqMtqNp7H5Qwgsp0nwSm7n
 HwTiGwXHeBu12CAYmrY+5eG400eAEXE0WXg4fwwGZxAR/IDgcJ0BGTHxMXcdyhsCL1
 kFS/cgxodeDT+xTR8HIiR7gzTci5teWASbdSruXeYQyboj9YAavTNsGRIropTaJbiS
 8sAboKkmKTvzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3E4B0442F6;
 Sat, 31 Oct 2026 07:53:41 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Sat, 31 Oct 2026 13:23:37 +0530
Subject: [PATCH 1/5] dt-bindings: display/msm: dsi-controller-main: Add SM7250
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-dpu-sm7250-v1-1-159f403ec405@brar.si>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
In-Reply-To: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
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
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793433218; l=1468;
 i=patches@brar.si; h=from:subject:message-id;
 bh=6SbwGceVC9vKT2xEXfQ+/gx3XJ8s8yaQo74zaxUPzEQ=;
 b=/h9U/cBBx9rgDAzT27cbyYXjoOawQS9Ki4BjMGT4urFWhbTcumBQcszg8SAF3kcmwJndRzW5F
 d+bdSOpPyqrAxBTF33jnMvdAnkf8Hqv6+t1oRc8h/jgHhQSNKrxEWfK
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	T_SPF_TEMPERROR,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

The SM7250 DSI controller is the same 6.x hardware as the SM8250 one,
with the same six clocks, so add its compatible next to its SM7150 and
SM8250 siblings in both the compatible list and the six-clock if/then
block. No driver change is needed, the controller is matched through the
generic qcom,mdss-dsi-ctrl fallback.

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
2.56.0


