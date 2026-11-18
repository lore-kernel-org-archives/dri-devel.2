Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qzq4amfM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18A710FCBD;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1199B10FB7C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:19 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso473771f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003637; x=1795608437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=Qzq4amfMGPqzqsE6If9jCjonKvF2c55OH+THD1+BNrFiSphYKJsxBzhfwW+0Z3gAZE
 n3fPoHDD954HUKJ4/HKwyyDd5r/R9Jarl9up8/Ck9XVmPmhlb9nWsCYDZxeUybOmv7oJ
 isnPkaQ1zADvob0qldGTnNEgLWhHouJFRr+HaehOC0zOREwIAMJjqGsNCKoAm4WAURRe
 2pOMCczllYqJ1p7Wyg3ci9CmzQQub661KXVIYhWNM+h+le3+3FuScVNAihLgF+UVtXyn
 9eNk2An1ENGREyWjY7/yLdA0S1qL0jHQiwjyf/lUB1nq2/flRs7gJR8eWRSMCZLAm5d/
 rFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003637; x=1795608437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=0T88Eexvf1n8jmZj5wVdEVYaQmJlhykmLvzDDnRI4Ba0CAa+b2zn643fPYHqgW8h4Z
 YhFTwTyWmPdoZqfhbUOqoqh9rkljQPNEtY1iEFMNj8SWw47LvdgTsXpHWkdf3qKaE1LO
 XNfcx/7Wat2X1Kflj+iFQpfPp89JT4tUt3T0QVnujwqs117Tzb/5jSl93jvrCTl+9mV9
 s2tHRWDnmHxMXIRBY/KbKX3JdJZB/nsQi3AQNDPw1IiIDZjeB3+UxuTNHUU+DTI3ZmbY
 lKhwAydCcbjcqGUA0YnVTmDXFE/eCWanDai9QXo+GCdPOpNm7Z+KmGytwo1XLWprIvxq
 uh3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErE+bczI3btw8793IE2zawOnrNNCYvvCNOHWxpFjjsBPwoJh3CXr4xvuYAIWsfRgjx/xQZuvHig2kQA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PCD+Zc6aL8P0R9PkYG606O3B5fzzUZe54WjtlqSiYF0TGRbvY
 +c7frW83jfEepBNxgLhAsCxfip4IfTEidduHIPc/qI8bexHK2KEgzN+O
X-Gm-Gg: AZFdTZftuNvB2jakTjJUQzr3Z81GJ5C34HF59vc7X1lbApXt43fDPAy+OpTUv4L04eX
 tFcvtmOgLv9K3PKugDDWByIrpaErgdu6qc7nroqrk10UIwhTWSPlKrosxoeZazlat5SuzpVzfCE
 h0gwpHGSj/Dzjjxq/VGKs0dHLkf3yNG8blx0lJfTmOmEzt2RJTFVFccTwC7jqPtsaZyP28Ni0Up
 azHCWNN2x2uVemstN67mrg8i1AoUKpfyXab2aoez1R5EpGNkOBqtB3ySzoBVbzMtW89DFy7/EYr
 AaHkQSdkT5ExZxdyoFrOA2G0qZZJhRUfuum02+ycYs/3eWuKFDNUsR0u53jWo6jnUSNkEwKRK53
 zOoOR2WZHgSR8GhzjJo5cH3EBBwhnDkPgC65qypTCSkewsXIDeSNRPlSI28r9+HmzJoC9eZpvwh
 jziASBQcLgv7qPgkc8Bh3Np0QhUv9EthGNLJn2l2mKzl3HnvWfwRyH1uoGqDwCWNhde5otkmf+7
 wdK0JVkkQvE8mwdpu8egUoYLPDpYdzr8d07iFLWLUORexswz2CRtVbmzEsao60aZ4C14kFZRLJV
 Lh12QwbX8XbZTfiV3Xsx3j8QnlYC5Mr8J55JczUkClT8lU2yqrPcWOynFumjUkMsjeiLiGfTOEV
 Kyd2QZtJh2ECsB3qQOU0U
X-Received: by 2002:a05:6000:41c9:b0:48f:bf3c:1631 with SMTP id
 ffacd0b85a97d-4a638eb6cf5mr4646275f8f.21.1795003637378; 
 Wed, 18 Nov 2026 04:07:17 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:17 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Wed, 18 Nov 2026 13:07:05 +0100
Message-Id: <20261118120714.31505-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
the Qualcomm SM8250 platform.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..85635a871e7f3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lg,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.39.5

