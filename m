Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0D606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urVyVRSn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79AB110E778;
	Wed, 25 Nov 2026 03:28:21 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C20F10E778
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:28:09 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so3089882f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795577287; x=1796182087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lq5GK581V8x7ovO5oAhOTbEGADqrrK51A5iNkY/jsEw=;
 b=urVyVRSnLZVNYW3QqV13JEDbiGwhKAk2nGHQR3IPHdDAOXglFnEMyCRzJNNo2RXgCD
 qyPVroDhZvEnlfd4qPFkvFvgqO9/PLoSuUfl3X4OwH/GOkHKP+dLsP+TtIG5nT/NAV9g
 ZV39Rhmt5RAee982SsD3Lft3OHWB6R5OFEaq4KU3hMZRYrwl2QkAu6O78mqNZPd2aeys
 eW7NAJZr6BglnUnyspOPiAIBIr0YJEuI1CjdpKiKGxm9xhwDedFxSN/EJLP0ZU58Osm6
 1lB/5gvupfNhPXGh1MMNTJQymH+iFy3awPW/v2/kjtzUTzDC/9uVj+lgn95Khn2RNHtQ
 ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795577287; x=1796182087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lq5GK581V8x7ovO5oAhOTbEGADqrrK51A5iNkY/jsEw=;
 b=w8yIO4mV4rkETYyAOeK1L/DaCNpDbe6WGQf0Fg9Ocql2vtqRveL0Ozw4XmHn2N1LIQ
 2CY2n7bsLehhvBbXYWoz26p0RNYJIEr1KGWiREw/TB4G9bg66QEj+bfSfHnTX0B/swka
 JnV15RudP9ariC8pSs+9gQppcFMq/gG85DOT8Bf/UC+pOFqbDxZQJZYKNb4H2unNzKtH
 Z8a/4VonmYrXW9fZll1kw416munLb1Jdag3jyTIv10QbSRIUr3+ExFN+KO5L9eI1zAet
 8kY0mY7CaxBgDDdJYFVq1+IPelmI7CqmkylHcuWzzr7czmyME4mMyRo/ZQD/ev0Ehj1b
 dBiQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGTfEjZ9FC48IuUmyE2uzabxDy1VY5KSrsOASMrBEGA/Uchs+FRup4QM71RJ311lsV1/0NblqlwpW4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KO3zuVThwetxB7u5TbehAfVYiuSupyKnGAnXGAR5/b1rj4+hw
 jG5cj51Z2UzEr4DqaebayG4kfnEyb5AyEvrTpddEPmVeh8TXiPm7Zpmb
X-Gm-Gg: AZFdTZeckM4pVNT0KgpF2FDIxSCkdoZ5Fg7yWC3rqoLP/Iv87uI2p6jbZIYiVpFlx7t
 q73S2HdvzW+VgC5YWNpmVnRmBtpay/v9jekD8Bj19kghRs1x263xVaN0Q45ErEB612negLq+VZR
 KMbs34Fc/qWTs7BJQpqcd3rjeE4dlr/cbPaos0Qm1LZvfzgHDzRy5ITp8FAIvNX/aNL0QfO+AyZ
 Zy1UAL0LpOilwAUnN4QNpcoQ55gbUKySGfWa2ayLu29BPYHmx77ynqi/0pU4yIeY10nkrGlcOiY
 U8ZdXdPa+eyTkVgE1oNpwcx+C8ScnIaiqNR6XqtGzk5IWS06n5Wfl+/hVEmjj0Irusb5LFhomdQ
 EMleYrTeIVOyjWQv7B+LZJBLCVo/Ucd+vMmREICV4qmHMxM2Jh0BzfeTMBFKHP2kxHJyfX0SjgL
 hb0EtCpjYFXcaf1em/xBimn8ipuOae4rYIqfgyqKuVligW9uS/pvIOe4vLH2YxDs6uUvVRNQdUL
 UCONkidrDVKtB51FxP9mrlMpfDxj8++gR+eN7WdguR2rdN3gaRUUAis8FkuMPXBffKlXF0EgtTd
 XIcvAquQhcOa0ISKd1SF0SkFMcpC47+EV6ilLtIxW5PrnSiYZvQ01Fb8A5ujDAkHg+HEh3HODfp
 gkKAAxhbsHNgM/jm8NFM43UvM3nUyCVs=
X-Received: by 2002:a05:6000:26d0:b0:4a6:8012:197 with SMTP id
 ffacd0b85a97d-4ad5d5f9320mr30278129f8f.2.1795577287400; 
 Tue, 24 Nov 2026 19:28:07 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 19:28:06 -0800 (PST)
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
 Abdur Rofik <rofikcoga@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/6] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Wed, 25 Nov 2026 04:27:57 +0100
Message-Id: <20261125032802.8460-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

