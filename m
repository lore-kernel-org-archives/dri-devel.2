Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BB606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E46lI7vI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046B10E701;
	Fri, 13 Nov 2026 05:56:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B258A10E636;
 Fri, 13 Nov 2026 05:56:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7638861815;
 Fri, 13 Nov 2026 05:56:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794549399;
 b=on1yyvEiiv7JwjazYYZAd2kX2UGSenqDZiPqmiHPWRyBNLf6ChDEh8/KR2gnyfZ9nG3A
 MSHiJIU9PhZ0Hiw7QCQsM5+eyK2h1w2AignxI1WLE3CMHX0eT4KRCxn1SOG424ElQIS5N
 ekiVF+a0wWovXfgU2lCPxyI0cKISpCrFQdJEsIi28bcWRqU2IoBB8Gug12YQZ54YhRKnO
 2UTojCbcsdFT35Zq9gmyfYIKJsURgcmxiaqF7o00lFg2mQX+w+C0R0t29N4vuZrKN49Hk
 JNr3kQuLkmqj5C404e2dLgIuvG3T6BwfSx5emeNvgtqZO3JICWQIHoC9o/7KtnvScoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794549399;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=4lQDrfrdQF+odj57Rd/7QUj49vlFmnUO3XKdts9D4TQ=;
 b=bIQDcxJUHikq8lxv1SOJS+ghbi/sa2zLiweeayd1/5WAWAQkF/40T+lBFKCAXHY3ZnlS
 MxXbo/0WYQQE3k+B3+Sde4UTq1cjG2gQc5NVT60Rc8tpqH23koTNxuoDzk2gFhtvsC+4m
 xEa1oaWnYoWRybxX4+vjBHnpSpyRLG4zF0T5k91v+MWhU3kCyl6IqZC+wfIoI3q8zvork
 FPFUxU6kDikv7M1JLqG+093Cs+oQdW6are9DweWXueZpSjJkmUJeU7UL3BJrTT0Hn39qa
 TizAsIUdrBuGwkWOZCfYMa+eTL09c557OtVzGWzfzvDIaYy0jksZOYmxFuYg6rmL6iA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1CD6A1F000C7;
 Fri, 13 Nov 2026 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794549399;
 bh=4lQDrfrdQF+odj57Rd/7QUj49vlFmnUO3XKdts9D4TQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=E46lI7vIdAOyBIKFN+EcJ5FNx6CJYD9M6A4YCcymsDv/87hn7DTXa3znyE8Bxc2iR
 NTTfOsUkPzgYv2k/UD8cxBCP7N5TqfrsoC3QaY6nW8gq0G01JqvW0yTOoDCR0tQI2h
 bcpAin/DjZSqd+RrF/RofC86KoPtsNmyAa75+CW98wMe+JP3XMfEDnT+D5Eb5uZW89
 XqIasrNEfHHFxLJO/ytcFzDKj5++AQBNHdtXgTUpzPYvgYs/Fczo1IHgBYx/0JoUkB
 LAKECCnzuU7HM5q4FX1y049va7nnTHJTR97woOYGKZRJrHv/+fASbQRNlql+vr63in
 ygTJHyhklf/SQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9B8024760F;
 Fri, 13 Nov 2026 05:56:37 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 13 Nov 2026 11:26:36 +0530
Subject: [PATCH v3 3/6] dt-bindings: display/msm: dp-controller: Add SM7250
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-dpu-sm7250-v3-3-30bdec59d204@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794549395; l=963;
 i=patches@brar.si; h=from:subject:message-id;
 bh=AcZp8+cV6TDy361VSXZ9EuoRu2qfcwVDBf4K2rgS/Lg=;
 b=49nL62R2ZVcoSVeaVUn4mObj6aSRGxlORdsPdZDMjTPmVGcEYUcZFnc0f84FgzFxsM0D+zXw7
 juLSrBFAyifCoPiSOYtFrON21pAhV5ctpDDFYkDbS1SqFiMnSZM959U
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

The SM7250 has a single DisplayPort controller, the same as the one on
SM8250, so add its compatible with the qcom,sm8350-dp fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ishu Brar <patches@brar.si>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..d535e090ea2e 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -53,6 +53,7 @@ properties:
           - enum:
               - qcom,sar2130p-dp
               - qcom,sm7150-dp
+              - qcom,sm7250-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp
               - qcom,sm8450-dp

-- 
2.56.1


