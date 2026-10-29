Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAD60A2619
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOAcI3j7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3A811255A;
	Thu, 29 Oct 2026 21:02:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC5A10E834;
 Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B64E4388A;
 Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793307759;
 b=gHsC2U1FimaqU7VFBPyHatux/oE4jGHuJeEKwpsmJtci1PXfMFHnpZSMo5HjWNVjHNNa
 rvLW1q2Ka+qZLLPKMCaY6hOCriuVhm7cZOBQ7ez/2TyFuESWLqSUVBBQDnGhDvapF9m8i
 ycOxTkCoazdLT4ipVNRWCRcmV20Z+q5w6vL2xTcmfxwQtH5dWnU3MjC7prSQydD5bJtRm
 7SMIY+aH4XEKahNomYUEX7ieNoWJayjdxwvT8AR3WHbwup83DjgXcBDb3vGKuGgyhZ7hY
 XGDCQ8Z4QqSfGL9CvC9aV/3A0LqX8q5aX75pzFhXhd/CeKTBmChLIvvRq1gvm6Kfk+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793307759;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
 b=KH79yAZWGaJ8JWB6UtVs1r6w4D8LG9RqGdi34uafO45t3AgHmsRBpEbxtIl0IIsrmFDk
 YJqtO+TpGtdPo2I2ViGmdHXgGvCc66syMXpmQR63Gz70DI0OIdTXkRyhGeaTzEYFOrv5B
 MRVU0V1uR83RX30WCZnL6o0SNx4jTt86uRi02EKtFLxWixclLQCIkoCOP9Bs82WPWU5x/
 O2wEapq78tqR3bTzQlGM1lujZSr9cy3QkRJzCggu3iUmmVK21GbjENEhUJzQUEIJ+rHK+
 FSMuQcr9LL4x2r7BEyl824XELImaDaPLIaehLT0ZWa8TY0ei66SQ/PcbdlytcamXAfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 347C51F01825;
 Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793307759;
 bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NOAcI3j7Pjd6CqCeeEek8By8XRTez2mvUqu+LEx8iL+G7ZC6h9z4nOiEvoYJLMsop
 eY33qzxM5pVJA41cNp8NU/qWaLFtso+QzoqrJqObyKiClso+r4ks3lOOkq4nGDyf2q
 Eq7RU7CwPpccjcJV16pxh6COuDBJ7VlKQQw+RzyVwKScHds8PE1VPGhFunkQyIITqT
 LhYEyBN4G8T99FfLaBeSy4N35+iUGTRLBhY3LgsEB5lqyek5EynVcJ/Y4b8zJ1qYW/
 nqGmv5w+vZeSBWwy4WCBq+djwdov7Utm7Q8FmrHpdzRsD+WJwPE06oaOAgT3FlfgcD
 8DlEv01nFwz2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9C87A45986;
 Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:32 +0300
Subject: [PATCH v7 01/11] dt-bindings: nvmem: Add compatible for MSM8952
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-msm8952-initial-support-v7-1-ad748ace375d@mainlining.org>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
In-Reply-To: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6JMvRgvxX2he4PG9Fo4mqxxQVXCwNkBZtmdxWuS+a1o=;
 b=Ho5sN1dY1oUffDS6VQODMFlBjBFh3wgB50BCyY6vcZPV2AsevVqMFA8lPuOFykbPm18FX2kev
 yeCggMCpEKICCAmefW194BWAcmjpSfDIiZ46pImTu1Wm8CZEqdvP0GA
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
Reply-To: muzafferkadir@mainlining.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the QFPROM block found on MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 566304ed4c78..646f2e8dcf4d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
           - qcom,msm8937-qfprom
+          - qcom,msm8952-qfprom
           - qcom,msm8960-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom

-- 
2.55.0


