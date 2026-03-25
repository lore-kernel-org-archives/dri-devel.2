Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D4FFEA801
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEE810E709;
	Wed, 25 Mar 2026 03:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWZb5xiC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFfwRLtQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3741110E708
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P2JA1a3057336
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=di67ISekbvw
 bJhWpM+p15imtrW+SyyjQjZ671m+0fHk=; b=QWZb5xiC7p2mZ5gV13bNOJYB6qH
 ht92Txoa/5EqyO0OAAybey6OMfi+1c0NTMqpVXgAT7+FClKSKmeo7J2+eP1bf8+j
 Q5KkNEwLP+mVOc533w4qtVerILtPz7X3WvkxVJHJiFXkfjJqt5DgnuGxUaO2LaP9
 wt85BhDLDSaJb9mMnNh+QKXb+bdfLtMM7qL4M0SXA4gKrM8PS4fG6XCxnhYrEGdD
 dwWwBvK85MSBS08g4V0/qg+OtzsDBERBjaURsjI/jHDnSXOG+KJbRJF0slQpb9JA
 tknGKhGHTegzrAi0AE+92a523560a+wQnDOMIufCwiVPAf0+c+q7Flq/pAw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d46tp08tk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82a820305c1so1409922b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774410845; x=1775015645;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=di67ISekbvwbJhWpM+p15imtrW+SyyjQjZ671m+0fHk=;
 b=OFfwRLtQ7WKSoUGXUbN+4njXW9ecv9F2wlMnxUnZtnMSwRlRvrbckshQoZYo9wXZq5
 37RYEI45M2sqnrFFPc8E/N4e8BhvW4dO6XplaFGjoFhSnrNeg8IlOjFw37caIqySKjLb
 ZC0/hfuldIbMjnyURXkf2ihu6rox0v477/slgLnoiYb9cV+MMri7d+SYPbxh+UO3xRZh
 dxCEofA1/dVy68bnyrouNuMxCTiK4+oUwaX+HuqoyGfYZ/9Uph1z0Jtdqegl8TcJAblo
 wkI2X4hM2SLV45643BSBJOVnvqsMB3Q7AFYDdZ+IDWBss6QFE/OaHZkxYQWcOrTaRILb
 nb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410845; x=1775015645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=di67ISekbvwbJhWpM+p15imtrW+SyyjQjZ671m+0fHk=;
 b=VZTNiyOWewCKnqIEW1yuIg9j7Z4DgckXnv+YaexU5d/lJjwa12nuV07CXJOI+ydbBr
 xQjzNiGk6Cm1ulU2lMW2jYQ72bFifKMoliPAIvU5Jy+SJ5pSin5A/AAUb2eOjucVhfbH
 ilKUhzXL4v8Fhb/nOmDXyk0Je+0k8ZcrMLVXix9BEtsG2v8g8gKHBWq1ZrBbqHmVgH82
 HUzyDm5HtdYCbotzho0Fk7/pmj9CltSH9epNjaVa2uyZIxcI0VIrEiUayet8qfJAqAbO
 sVH7cQ3vEn8vlI8w6NQfIPaciKz/xq9X2Eb2NXE8ZIH39zLVZi5bnz7fe/9LqbaNmGfV
 IAAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVulpVUH/U7to9rHe4fBo2YPpDvpIH7STUNUG5lSng+NnBcltGlz5KILm8CcrcbOiKD4IBvi7s/7YA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzf3CsQt4cepwQDzM3gyy08Ejkx3wuQlUBvFQOFMy39id812Vje
 mutOA9iDpw19gb7/pCDLrTyGf25BaW9byXl2aVnt12/OpChXUIegNw85icWpHS64B8vr57UCVNy
 o3y2ejVb4U6keq/sw8qX7xYtMIeWX3MI0lh8W+5fvtEPpkYgUAZThUxgrX0a/8yUIbNhf7BY=
X-Gm-Gg: ATEYQzxMs0JE7tBtZZVIDQgGmxCOiFmbezDAGutxMJIID4nFALOXFY6bwMGmeHivTNF
 9XRza4EEpx/nSHUDZRX3b1jR6efjA8BGfONe6PGlH7/5mjB3As2CPxPV1e2lpusD0K4Bf2PewLc
 iaKV0NtUTGDQyaR1cPoTsPQyc1/o6/hFhu9a8S+ddlP6KXYE5a0oya/GXkUTSW5VZ6htdNa5RCV
 6uldCMYHxTsSZCqBu7xdF3S5t3vVEEY26jDcIpfCu8vLHf8TCd1nQAZdQ6ZPOrDHDBFvgsPbZwZ
 rZyKkwERrufXFzE41XLVvGCvXPcOjFHx+/5yk3X0Xy5CD7/JjtRlO3zs4Il5I2zhAr1+VPQYgHh
 H5oTW+c8m4DRNNuZTZGd+r6ICPA0EksHkvV9yHjSkoWbne2R0++RT6DZp4WktPbGxWmNRy49z/w
 egswb3u68bvQh9O+IB+LHrm5JYbwADrgr12k5C
X-Received: by 2002:a05:6a00:4c07:b0:829:924c:348a with SMTP id
 d2e1a72fcca58-82c6e0e2146mr1713901b3a.45.1774410845162; 
 Tue, 24 Mar 2026 20:54:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c07:b0:829:924c:348a with SMTP id
 d2e1a72fcca58-82c6e0e2146mr1713864b3a.45.1774410844193; 
 Tue, 24 Mar 2026 20:54:04 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410870csm14220689b3a.52.2026.03.24.20.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:54:03 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V6 3/5] arm64: dts: qcom: glymur-crd: Enable ADSP and CDSP
Date: Wed, 25 Mar 2026 09:23:36 +0530
Message-Id: <20260325035338.1393287-4-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JOx9hEBe2lSOYmydUlbWsi-U53RRKMtK
X-Authority-Analysis: v=2.4 cv=F4lat6hN c=1 sm=1 tr=0 ts=69c35c5d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=w-eP6_cFhoaRftvBz5kA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JOx9hEBe2lSOYmydUlbWsi-U53RRKMtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMyBTYWx0ZWRfX1CSORiS7/3Px
 Jfin6AM0uhoVqy/g7NWiR6/ezkqs4jS0u1caKnHpTemugShdquhkYo1vtMlejFE6inPWoKtm+u0
 onCXxlwN6i6o2++Egp0oWmL9HNNjYP976DaKpbh2lbm8QPFdD+HPz9rlcnP9ZbXLW1qrtyo63Q8
 DejPlBKT7SqQfHCLfkE6EwO/8R3EF8i6mDGMb7w1ogJyall7WLWf53lOBVpJs738LNEoradilzj
 Ya4G1hyrJXDORvsFP5kO2cpgH5s3jRfXIPBp959gfop4yvXttVuYhvYBGZCATcuKDBYPJkZ1rkL
 zAmHnW6cciIwJdar0SWmEmu2cbTtaugK0aWqYGenhQOuKeU7U4Z0lb3ES+2h9Sf/76EAkmnB3Hq
 mUZpNn5d0C4NFoK7ESe97mShZzfUcUDT8m/c3sEvWHpJo4NihXRwfP2RP/hOYbOrJLxQgb4XO5n
 Vi/d6VA8kYT/jqvcyjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250023
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

Enable ADSP and CDSP on Glymur CRD board.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index abc6cc8bb0a8..690b90e3d6ce 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -478,6 +478,20 @@ &pon_resin {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/glymur/adsp.mbn",
+			"qcom/glymur/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/glymur/cdsp.mbn",
+			"qcom/glymur/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
 			       <10 2>, /* OOB UART */
-- 
2.34.1

