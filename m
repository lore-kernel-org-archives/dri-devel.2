Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF509606D819
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbXuMzoe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DBC11235E;
	Thu,  5 Nov 2026 10:55:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC9711233A;
 Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4670B411AC;
 Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793876104;
 b=gu9rYsh6ltFvfJ9kIOQaXz5TfHoAokbA7Z3+j8j1+anAj0LkmKzBW64jTKkpWzuFXeIH
 alRR0prrODdBAmGi56FORllVYmac6EunxH8hiuoDTrSH43hSypI0RyN3tGAmlnfakx0+C
 Weu8owrJgFVt/pJ6vfQ/UocnQyJqTrTkUiWDUBzqdyb3PNAXhE1IA4RH7JAJz4hlomRy7
 TJ5x6JWlUVhyxup5s2tN3Io14lhubAtAE1MGGakVQeiBrOWE6FBl3MmMa2bHbchfiWZkf
 38lm8S5RhZT1HXbycntsxrgLf3Pn3UrssdfFmZP/jqm/mqwXjvyDxjceUqFFirffHrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793876104;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=vrbFmRHg0Vwaa7wvCtJ83s9ZBgrN+iwSbrevpGKdNvE=;
 b=Gk7N+ifED987xcgbZALAXQcc5YCeSH5j9S/+/GTAr/+0HVoQdr9iE3Z2SBSjNDxl/7NS
 sTdqR5qmsRmit3snDhFiHSfDlS/wV4uCUYUGvhr31AGaboLsm7x4mFINC/pHZA0PeFLJG
 G4qJB9lPsLtmvxr1sGsLbuwFBlNm/I6IbJtDMOj2de/bxDecaQFCNNK32Cak2PM98HGv+
 +W4aaQcuKS9X4pL/usM7s08e3C4w13BWOJmAtwG3Qs0jnNOjLnqBN9Ru2nq4vGMhQnyBR
 cbEsNF00qF90hAPEFXaG7XscLgb3HsX/CPAuUbz2+heHkGWbFo/ApGy321JZpEzsw8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 820111F00A18;
 Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793876104;
 bh=vrbFmRHg0Vwaa7wvCtJ83s9ZBgrN+iwSbrevpGKdNvE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=CbXuMzoe5qU+uDFNip+1wLfiN8y70+UZhIAbf4BG2nkWV3I+9szWEz0mtsLevKdkG
 FyclFAcx7YjmAbaGaznHYS9d0NI8NHm9PvqA7A7wItZ/iOLpy5VMreSbqBDtPjR/zA
 3mm2X6TNug8j2K/DwsAvhKAgmEatuEf1Of4B+61k0GYxt6FAHN6VwX6BWpOY0H92dq
 7BCuwGnV+G4lHmsLD8kdZyrw5ijAaVB1lzNZedw7UfnUwQsuOh8ZWX3P/8yu9JbRv9
 eL4lnHTxoAyCehkIUpDrpVh05w1ALx3bOeXIzaTkErJCtcONuRO1SJCiWCqohmioZf
 ykVVLIpTzXGMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0EB22471DE;
 Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:06 +0300
Subject: [PATCH v8 02/11] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-2-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=kpqMYq4BzsuyLclvUfDPu/lZin8icjEat8+zs0C5qZw=;
 b=9WSZMwhPlP7hXbdYUrdG/vxs8AJkxR/4Y4m+tW62ZnC+XgNTxbi3GIJZbQk1BhG/fe7KSFTLw
 l+RMCYRa2YmAT8BGxEcSw8QXMEyotCg21ySNJU5Y3cqphbNMnGQWJMH
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

Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8952 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 93a489025317..9952b9da9a6a 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -27,6 +27,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8952-iommu
               - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2

-- 
2.56.0


