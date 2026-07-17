Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C65C44521
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0743B10E508;
	Fri, 17 Jul 2026 20:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1+sFPv3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKb8hD8r";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C2310E508
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtYfI2780245
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=; b=S1+sFPv3oD8ZA4D1
 6NQJIZ1xqUfwllz50zIRqPmGzoEcg5+y2zpdUY6J3qfkScQ8DgHhkxXU27swrtcj
 tbBLWU0DDrKFCJPEtMiqll4uU1IQjxCjdKgApxmZEWMfJR5bPsPzojfj3rnxRzEv
 BcE1+0Aw15aX8ItF7etjkVQnPpRMDGUcvFa0b0cwVzCjKjMn0fkUs/1T33ZEHk4Q
 E31ptetYOI7hUXTz4KSjywLE64xSC78GVEgwYW2bQxit3gP+5Zcu6bYbaM7T6ov0
 fG/kEgxpKy43MxYDn26ajGVwP+olmkvIGDlEBGzBOTTsnKt/JW9TsrVH3Ui4OK6P
 oTdVhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu97j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so145242515ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320954; x=1784925754;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=;
 b=hKb8hD8r2q074gSLK+rqCq2MkhfwSJjPoVb7BJfKo15Eu9yQhKDFLRoBhv9B3ejMbm
 Lt1biHILdRyyyUzmr6tO4Em9qAkIyRl23B7sqXtDaFIeqOaGhusAnzhEdcQkQ5z+5Pa/
 vaBl//BXN6VaJ4VYluHFyPdjE33UGEJeGbdms36kupsTo938kTRBcjQ7SyrsnJkZtHtv
 s7Pk407DjxbbAJMnb/tEwQEstSR7xtt/tQsKPQ2kQiY6bv5QLE3nNsoYBPX/rNHfpmgn
 +mWXW/BUtl2ezvY3MWqzWimIUci/F2T+YPx4foKw3uLoldv2AsteP2g8AftCgfOZv6h4
 swow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320954; x=1784925754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=;
 b=ANu5m0wlob4F/S2qTuWhnWOCnMfbku52FnkvpdImEtEcMZx6GbGz2tFKrXAYFRrUMd
 mecsMt+I2YLUniBjATxxZ0gQZfANMdQXiJYGfap5FP7b3KQl0l5MrFADFfdaOTtEELLW
 Ysn30qGBFFVSI60r53AB5LKYmEjjzC0GPH42yNtSpOKU2TNyWlmoUtuqvoQxDwK+LoUt
 Oheyjaxl/4KsnHeLEyq29F1pGuR73HMbISASadlQtwaFRBpFpaJ6iIgtf5rng8OHN91A
 Yu+5dg3yjlBwWnumJXWDcl5x8jtNaHovI+MnOduhbwRE+C8aBGycmikP4Jgqace04K8Y
 OxmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp20qP9cAh+6FpPMwLP69Ks6NCS2ViE0NVDjATvCk9fWVZX49klsbkpc4j7ORxQX0xV95cHImehPjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz25dlCNvAbUCgWr9Sy77Z8zR1NbRLyATWeLhva2spDGlREnEPx
 wjZJnDw8n6Dg1Rgug0ZOdVqYJlV8zVzzOCl0/8Jxt9IiHPIuic/5e9Tu0z1hv1rJRkOqHHT6aJ2
 +3Qu3QQx0x2XuSE+ttnDff8WlT1t4tmwhhELj7ykCI+N76znszVhQpYSRoL6cT6ww0oaynNQ=
X-Gm-Gg: AfdE7clJ77Qk5KCdoNpuoiT+tSTnUGCpTi35wXnLQFZtQ5zK7KOgflfiqAsiXuPPkgr
 t1nCdXFC3fsN1lm6KhM5pKErPo2102eL+ESZ+NBKFpjBzOHhsUyvIaW/V5p5JEiwRsYLugLlKIC
 K9+0n9hcKNZQ4V0+ZKO+O7cE6dABrtAKvGb2h0JGcZH9mosJvmrnZVY0Rc5okZMvc1aSJjucPbU
 ib7GpFAmFXEQ3SFby+7jCFgGsDfiXMJ9tFaPgDv59s4H0qZo3sUn3GJaqk0VqpXOngy+bnfIxlX
 UXgNAleW0T1mfRQdCfl8WblWKHOlnQYucQP3PpS8w7jYeBuDa9CU5SIxDBITbBFmPmbSSS+lhFs
 IZu53ndl/GLx07rlr0v0FqXbq
X-Received: by 2002:a17:90b:3f85:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-38e4b479ecfmr4276423a91.19.1784320953915; 
 Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-38e4b479ecfmr4276375a91.19.1784320953504; 
 Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:30 +0530
Subject: [PATCH v2 5/9] dt-bindings: display/msm: Document Adreno 722 GPU
 and GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-5-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1977;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=H03u72Mj2+0Q/DcdLyrGjsdWiF04QoAQmREqPJ+DCmI=;
 b=SJZVRrqpECN/vKCAH/EzAokdNAPN9nODY536Kc/SKD/uVN/Wi+sIO/cXcpc14W8BcSLEm31gH
 3S8w7NqkDqRAHSQssaeMIUwci5dn3785frvA+sLtN95U3m9ljtJW6d2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfXzRGsojhE/sPS
 9DjcNum1omuo4mYfjmmfMqFK7YThZD/4Et4O2LdXr2NSKdRwjcnocLFmgEbcJQ1GelrnjdDV8lp
 JCkeqg7YgHomizv9LR4x9UymHcQC9IQ=
X-Proofpoint-ORIG-GUID: SeWbZ_TeBaOnKkZ5lLm-bFeJocgzL0Ec
X-Proofpoint-GUID: SeWbZ_TeBaOnKkZ5lLm-bFeJocgzL0Ec
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a93ba cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=byR7QgRKzgUKQ7cIeKEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX4AWwSvYEOxDH
 KLDWUx7/2cpkp8OWApszfNKuj5jk9MlyIfalg95fMhsTlkbXYfzroDcCN/+38Ui3H5ELtkzpuw0
 oBzF2tr5+oQJduyFhisr9q4OBXZB6Azga3GnsIZWfc/SL7dOkmrl0E7A3USagXnsaZO9TlzilNh
 LeLtOBXjcJruLmUsKZ6+5s0VRsMrqxw+kjgOKk9pCYOiEPuKorSSoGR3Qth3irmOdmJcNy6/Tna
 Ff4okQjyjafPufCI+3LcyXK8xmzR59Z6oJCKBl4UKId3Appy0EfmDAAex5f8uU0lVjAYq5EtP75
 amrdGtRapvhp6ifv92/RgQyY30hFnYY2XbWpqjjVfESTECNBKXK8wWDPa3NMQgeIC5qUGVxoQzj
 cuRQF1V9dcBHLuetFAOtF5AXXuNDVs6Yelv5DBCgnuGVqCmyWTp0eoK4ztQFxEyFFEy+BHtUvJ4
 FxHPI0TKzUNKZX5efDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Update the dt-binding docs to document this GPU and GMU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 8578c2f8122e..9e459f12ce3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -262,6 +262,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-722.0
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
               - qcom,adreno-gmu-750.1
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d096632694c9 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -443,6 +443,7 @@ allOf:
               - qcom,adreno-680.1
               - qcom,adreno-690.0
               - qcom,adreno-730.1
+              - qcom,adreno-43020100
               - qcom,adreno-43030c00
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01

-- 
2.54.0

