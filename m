Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8E2F8A15B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B16B10E826;
	Thu, 16 Apr 2026 11:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="dVlODALS";
	dkim-atps=neutral
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB5910E830
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776337508; x=1776596708;
 bh=pm0yg1XnWCN6qVV/+6F+T0ld+Sbc0pebe5jSdMJUCb4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dVlODALSIWHhtShcE2sLY3Y6DYlyZEBijcDBSiepCBrkFeAE/gXQoIH7CRGQg5A5t
 BcsGUXA1OR97h/qpRi9Sg2qhuPuvywjFAQ7MF52edyaXQIB2Gx4rlzRle5wzq4tI5i
 M/RwsT9kF7ycw8ye7IlTOnIi/N1Soz1m4O0A6NTDLkOt6qTqBoTQKzhEabyP+lV3zH
 vKz0KU104fTk1uxyDTuUGTvufRTTO5lgJH456zVWCRgQx4KTb20t57w4xxc7AKuIoq
 mA1aM7mOfC6YzDmfiWrojirzF4Wn7Xy+3cHpHKeQu4qlnY943QV0aewWPj7G98EtST
 aehP9p3g+GZRQ==
Date: Thu, 16 Apr 2026 11:05:02 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH RFC v4 2/7] dt-bindings: display/msm/gpu: Document A810 GPU
Message-ID: <20260416-adreno-810-v4-2-61676e073f8a@pm.me>
In-Reply-To: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 5023327bad91fcafe3c860e3384d4e02c7866b58
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Document the GPU compatible string used for the Adreno 810.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Docum=
entation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..1875a3b9f688 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -434,6 +434,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44010000
=20
     then: # Starting with A6xx, the clocks are usually defined in the GMU =
node
       properties:

--=20
2.53.0


