Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31956082BFD
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZDORVLc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9917D112356;
	Thu,  5 Nov 2026 10:55:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BF0112359;
 Thu,  5 Nov 2026 10:55:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC39B43880;
 Thu,  5 Nov 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793876106;
 b=DwfEv9u0PjXswRrepu9muw2Ice8YYykODlGNugODhQlJQ90ijJqTNd9jGnopQkhjn4DO
 8PHgBjsxUlg5+VdryEZHlqX5jka+XJK236CFd0nqKoFz/DKiTmUcWPVuBWbAo/nz9m9c7
 S0G3tLqgCojl5Pp5NzWMc7ZWRaptFOXu+ho6Zi9M/+1JXPcheVcDf9VW5xLWpF0BzFA/Q
 zEFjOBG/jEN9BelZqkiMr9AXbKtFIUNRenihPdtDc6627YTYJcSW7GQm7diDSmGucd75B
 nOGa+js6T1P68ZYRUdEh0vlhQHNlMItM83ZI6IJ1K2wbbsJJ1aJTPCAStvptxLE3fHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793876106;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=lWMe1RAYR94lI6AVLaNRykGgNbx1qk1GymPgorV116g=;
 b=j/6FVC2ocZPwujy4UjUIRNB89fp3I9SaJUFVDTvdNjmknoTqVpyi/6Chw7njVCNvIa/6
 Uevd+OaQc18LOc/BL/gkJNKNxQnBoCsEYBp4ViijzvuQpoLSH2aX06qTXiv8sFe+KniFB
 AvAakleTlPlf3roYpqbYe8nY74dBeu9xmNsPdx01clVUhlw654wP+tY7AN7gcWMOmD6Dh
 jVtvi6QipSwCD4eBzuu095G0coOwRfZZHu1nwdTjBQPq/QtUFnIkAZ6wMMgyv86W1iUQ7
 M7Nfa7MBZnsndJaUuS9PZsvDWVBieEbyAKbIWulyWDdmJXNet9RrlTaT7fSVT7StGDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B41851F00A1C;
 Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793876106;
 bh=lWMe1RAYR94lI6AVLaNRykGgNbx1qk1GymPgorV116g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=CZDORVLccv3GkYb+FlKUmt+7UwQQ5Xug1ZBlNr5tfvAKllxSaaAc0Ls3fMbeZ7dz/
 3ufpzB6LPNMUgkWo5joJglJcBxIYAO635M+bxT2YNugNQ3A6aaQipjnxcBwqjvsuK3
 cRPyQy9K1OWBOtpPijr9hvg0tLVqO531HvEUiA0ZdZRJ8HgPfi+VJIMsey1ltYc+zL
 8Bs7jBmi4vDdOf/wQVrVm421oKc+vAY+wC0CSvlBzK2lGdyWFxc/0Yf+99aDZiPQlD
 XmuKd2QKXdzVSEhMbFOX9FiOnJnH+CsDPC0uvh03Lr2IO7YsVbQvICkmRrxCZT/Gw/
 7gREOZ18cpyWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3C5CF471EA;
 Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:09 +0300
Subject: [PATCH v8 05/11] dt-bindings: mailbox: qcom: Add MSM8952 APCS
 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-5-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1080;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=bfllieSk1x0Zo8xBxn5AQLJBSUyzj9oz9UVJP9mqh0g=;
 b=BkAVYp5XLBwZyWHx1KKefdibqr2AbuR9S3KS8apAEHWwlOLenggE8vmJHX2nGHvRnNLBR5lCl
 uCnCOobkwloB6ROYUhv64xsxDwEmJfzg85+kFQwmZLR8knu2LKWkR7z
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

Document the APCS mailbox compatible for the MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 5110363a0717..c2b0d7394f36 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -31,6 +31,11 @@ properties:
               - qcom,qcs404-apcs-apps-global
           - const: qcom,msm8916-apcs-kpss-global
           - const: syscon
+      - items:
+          - enum:
+              - qcom,msm8952-apcs-kpss-global
+          - const: qcom,msm8939-apcs-kpss-global
+          - const: syscon
       - items:
           - enum:
               - qcom,msm8974-apcs-kpss-global

-- 
2.56.0


