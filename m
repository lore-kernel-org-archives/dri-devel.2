Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5BBCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD7C10F42A;
	Fri, 15 May 2026 07:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YGYUdyDQ";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F9210E0A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:43:08 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso3693507a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823788; x=1779428588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGxg0Mcj6I7tC+AGT1Hg22gidJPewv2bFQbIhOlsycI=;
 b=YGYUdyDQQ17wbHTHkas0naqS8O0H7BRG6OG4D4X+RL8heQrt9l0auQltQDrDmtYwSW
 s69lM1bTnC5TU9miCwjVCLjkExT0jALP/F+29lWFJ3QgSh01wZduE04WgVyhgRkHi7Km
 RA3V4zt4ugdJxJRtU7W6g6Vl4WyhDdmI8eaQeXdvfa6RCIIm8DIKvBv5VU/gqq72l99t
 Z36smwBGqIWdgEDhEWiWV1Zu3aRdn9HXInLYUwoYzKKAxSDGxexnHtXb26S/9UM8Fl2h
 1JSOAKSvmeRWrJgYUg+S/iuuuSQhoVkI19zBnlfggqtINtF72xhXu+zf0U+95xw1eZTE
 tvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823788; x=1779428588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGxg0Mcj6I7tC+AGT1Hg22gidJPewv2bFQbIhOlsycI=;
 b=lQn2CzvlETK68TGsZH76ZFMR7oGc849e2uYkwG7VqUBQZ5MjarVG8Xq3OF3oZemIws
 ZlfUJ7BS4xN5UILxUsFrTmZ5A+JFm+56h79JKehJmc16DixO4kkTp/f+6b/8JKnAo0ZT
 bnVhxiZamfExUlaamGnF36yZeSXp/21Q7f/wTGV4QU6HnPgPBKYXhkLO3MT4r5LArmjO
 Q9cLCkPMBngdTZLgCC01XT3U/XmLOuWlAA+J8qLv/e8m10XI1hrIVNPVp/odKD7DbPXE
 m0pOddET0W1zx30ky+EbHhJcpjrKxB60CLLGO8p0GtBjES0ZW+XWMBgnLBk1qijjXZ0Q
 Qiag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tgIQEGFNTs5yK13KAwlVgTBXFDkXAUjmc9W+er0Wlw/uiLNJ4jwJVwyP37sJfL6FBIiScPSoSWis=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWP7eqfT1yzjHPpJcydo3SKWiI3+MPHhEEDBTEoGfDmh4naFJ/
 e7aYjsyZ1+jb8+ZirIJKCviuFl4WXq68i9ZvMvezpPEblEzt83XbBIq1
X-Gm-Gg: Acq92OE/5drappJA/mvixUSzlvTlwDw6QotpC7meGz64wv4loJNHL0cbauztiickoW7
 henPd/pbjXnzlb9LwVAys7uHZo5J3g+57T7R/QI7xdMcQwH+57Td2Z/pT0inf/P0WS3LnnkVZBs
 pIhPKLxBo7EJiYt1RE79pXnYNMlQSLc44k+XTtx6D19ePAZ7EcCK7691cwbcgJQstsj7w0TYRXe
 I2K7kskj4ByML/mv/SSyJ4PaCpEs8aMVKkROydrgZ1Mou8uczuqZcp6tpYAIJvzCemTs8cYgrmO
 FupbSYgSStfAVOqncm+AJTaYjMJRZ2CJzYRWZbyXadaU393fdbZ2xVBsWBTZH8BpAORw4Osxju6
 kVWaFjliz9EmK6qDTIoFkFXB+56xBSnxa5wTqH3iOjeDLBcOO+ZTykFB/REup+HXHTwWEKLD5Yg
 aNiQhx8nk2zMV5nt2OQQvnWcW5BUWGRmXtrKMsplSTstKE9DFxu4lOgCChEeNPi5XOF8N60UGWV
 HTu38urGsl6ihh+TRKtucTu5Nk=
X-Received: by 2002:a05:6a20:158b:b0:3aa:f9cb:d43c with SMTP id
 adf61e73a8af0-3b22ed00276mr2807800637.34.1778823788168; 
 Thu, 14 May 2026 22:43:08 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:43:07 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: qcom: hamoa: Add inline crypto for UFS
Date: Fri, 15 May 2026 15:41:51 +1000
Message-ID: <30c12b79c6cc481afb13ac93630c5a16bc856ae4.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Add the Inline Crypto node and wire it to ufs_mem,
enabling UFS storage encryption on x1e80100 and
derivative SOCs.

This is needed to support encrypted storage on
the Microsoft Surface Pro 12-inch.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..22420d0a323a 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -3952,6 +3952,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
 
+			qcom,ice = <&ice>;
+
 			#reset-cells = <1>;
 
 			status = "disabled";
@@ -3997,6 +3999,14 @@ opp-300000000 {
 			};
 		};
 
+		ice: crypto@1d88000 {
+			compatible = "qcom,x1e80100-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x01d88000 0x0 0x8000>;
+
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x28000>;
-- 
2.53.0

