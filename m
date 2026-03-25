Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C0FEA806
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFEE10E1E8;
	Wed, 25 Mar 2026 05:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+MD7Rfe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/INDgxK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2150310E0BC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:35:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4xlNg2340461
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ah6pnoecTpRh+rlGM17uJM
 CQiJAf8kmPiVhn1k1UV4s=; b=T+MD7Rfe8C+eR5bn61S3co3W/JRsaetdMyeHgH
 oVdmeeSnvevrOPEg2iEELkzXHH7OyoAnpAqE5OvouKUBFbffQeHjPAgrODPeJ6ff
 VPrTnZ30ocMdD6LKigws0/wmxycqaCLdYAVMVaq5yALoK8mvU5QmaDuE7JBt1qVy
 2GgvhPdr1Y6StxvNn+3HVz6TGG3rM9F9MI8Yyy/BT7OR3RsXbik1sqqwtI9sLQMF
 z4dL5EqeIeAF+Xi7664r6hasPtgiPGWbKhlXQ00dXkxIq1p4zI+ruG3o3lC8tl6v
 vvZnNJMJzhUZJ0xjJebUpIWx8KwIpgJ3h1ZuN466mTsw4nUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw43hk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:35:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5091327215dso18865631cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774416952; x=1775021752;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ah6pnoecTpRh+rlGM17uJMCQiJAf8kmPiVhn1k1UV4s=;
 b=V/INDgxKokgRpfcFAMDgeW5VRZuZSlNGwr4iXOdQKshlenNO0JBGBdJMq4wA8R2PCv
 QewlsVKBXJKaocqu1eZlHF7AT3OJ5sWiL1jreFicZdjknVn44IfzgFbIT94Zm249bxpO
 thiNdSGdIJSwpu3joNq8fc441rRsAX7KpyEjUP1iv3EVHvaFZMRc04n5g/yffAaRyR6M
 lFusTD8geExhbl38hGrTToMsyhg5oXauMRZUz6oOH29wVcPsl/D7PGGuju5GppYuuWUe
 gGMWnWD478iMynjIp9ZJZDgAMimB2Sm9RMEXrPpo+m8B7x6+GsF9hxYs4GqF4pHQIOs2
 5suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774416952; x=1775021752;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah6pnoecTpRh+rlGM17uJMCQiJAf8kmPiVhn1k1UV4s=;
 b=fWXT4dDVHeH91E8eExhaImlPrvM4wyT0jHtlvGGQ4Ro8mvrPI31K4NyYWW1DiXYXeS
 KOFtmKy4XU11orCkAlV6tJ6Bom4rZAFKPzKj009l4WmSK1xxO4SWRqaYZukVhRHrlZp3
 suCnveNvqkCbl5i+bdGo0dnE8/+5LgFS4y/W6iIyxiYaRQC6dYVgWl2yrlGhgdUXqn0P
 JS2QTw+RbOdrfNWbZATGoQrSLE2txGeaA8jvtUX3zowFp8x66U8f4PjrtixfrJ+TUPYj
 lr7ZEPeeTKvbrRmt5hYcN9aBq4fJzM5BPsx9Acf/Cg6zRu10lb6tNL4N6nINDMmzbxlA
 JEQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2XWF+uSIDiAyDHmwZuzVrvqcK+6Zif+r7a1eb/big70LVwNa/OWNEOKHDaB8CwAe7WwLvT3Qc1as=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFl0XQM+dGOBwkxWdpD87MdUxw5CXeisCsOPVOZKNXtkR8WuHW
 yJL8Tim8dHKLhemiQBiwJiqlbj0DgUQMoVW6ABv1+aRyhp+rQKtI/OhX8kK90Tkp86QB+27l/G8
 7PHO76an6AIrlc0tH+feayUNsToY0J0X73hHpoj4HnwouA4rYBiGJztQyQtg3Z4+sixC7TPU=
X-Gm-Gg: ATEYQzy01S9hmFS1lnCbt7KOXqjrQhhM9pTxMjtFAWQZhjhR2IET0l8Oo4JnzLNzKX6
 ZCMoMFP+QTdNrUkXDBWkSWlb4qgT7PcPg3/ViHNVxUL0m7vDZR1HC4VtMPerJc+CNNdXEGwFcLe
 c5x+zEOOGhbgnXomqeUbUZ5XR8tvoibh/UFph5R7BKtWrDlbHc+MCKWmG5plW6eyKj1wQ9E3t2V
 vV/eT8Dgv4NW9SltY0cG3CAaN/l+opWfuglW+X7z2edXJoxp0kpoL+i1k3AQyG+/2NLsTxcHleY
 j3ne6JmiZ766zVjh3XKM+vUdpBQKR9KyzCqJj6IhbdAMKyUWgo+bTCqAYjmYxoXETs5a+kKzBjv
 mBQpDIxXSDhfCVljF9eCOz/cSQSDR95TeQMCx/bUrxtA+7qxbA0T5C4bpYTBCjvlQndKoNXQytT
 SPylv0EIjJbdDfz2lVt2MS9GJCQfbHKPY8WX4=
X-Received: by 2002:a05:622a:244b:b0:50b:4f56:f6f1 with SMTP id
 d75a77b69052e-50b80de2459mr30344961cf.35.1774416951588; 
 Tue, 24 Mar 2026 22:35:51 -0700 (PDT)
X-Received: by 2002:a05:622a:244b:b0:50b:4f56:f6f1 with SMTP id
 d75a77b69052e-50b80de2459mr30344811cf.35.1774416951166; 
 Tue, 24 Mar 2026 22:35:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285207454sm3572766e87.48.2026.03.24.22.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 22:35:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 07:35:44 +0200
Subject: [PATCH] drm/msm/dpu: drop INTF_0 on MSM8953
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC90w2kC/yXMQQ5AMBBA0avIrE0yKhVcRSyUKWNR0iIScXfF8
 i3+vyCwFw5QJxd4PiTI4iKyNIF+6tzIKEM0KFIF5Urj4JcVy0rnKG6z2BEp0oXRbCzEaPVs5fy
 GTfs77GbmfnsvcN8PNxJdvHIAAAA=
X-Change-ID: 20260325-drop-8953-intf-a002056b5ebf
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6SYrootL3V+BiYl0EiXK7X+16sioFaPUb6abtFLoYf4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpw3Q0Dj9yZcEq3K1bh0Ph4u2LxWZYG97PFR7O+
 /60a2ZiyWCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacN0NAAKCRCLPIo+Aiko
 1QQUCACCaKQ9oOfC3Y/Kx/OgB5O+vcQUoXkjhsqUsRQZgrUNzfo1B+wP1QThX0/Byc7XqUgPjbN
 CqtUdcmXfwOdyjRfmHJ+5Dl/W8XF6zAD3T5bGl41VmxVYjrmI7ZluW+l30UzELOgenObG6vC0k4
 TyJPe/RDy4KJDbl155uTbLrjsB35RXlv1Wq8aYjWYd2kje0Gg84iIvU2349Qvtz6aAsMQhzn1nh
 GRkflGHu33rqFDKS+Lc9PpgJ2UuH3IkqvwLL14ca9MOBhf9G6h3sdA4Dw+fbC+IyRu1cEfq5IgM
 /C9peAvl2Rsja7Bcmx6jGc4h0KLpG3yZp0fFNKgyW4MHOq+Q
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzNyBTYWx0ZWRfX4H7DIAijBti3
 Y8tIAFK071kPtpA8L+os9lQCPuGahKT+dkSf8vWmzqIOSpS2vsdtVebjFJI6h1aYKC0ceG98R14
 WOe54lCAb1LpIiQBauHrNyUwaZZMJJhwyew/fT7gCBJX5XZyP9PQS0zsCQUY/EWYeLxXje5sCC7
 Y7gZ7YHplgPz7vGPPodHFnpXDUd8sila1Ebb4nQMs0K0bgV6hzCGv8kuvmo9SiBB3WyIN2Fjqas
 VnOSlPzIfesQ4BB3P0xDf66yEO1Fmbl10i0op4eoi/MSyaUDm9kVSFZqa5N59t337WRJTP7eKFt
 9rgM8vJFg6zBx/Ac4k0Qo/ufT0OHKmFHdPlCBolOto1qiavz7gmKd1CoH6wwPzFZFYoJAzbE9Dg
 +obiuAVWJQR/eDMgeTS2I+uYf/ZtlTwtawCCCqXLPOGV+KYI0UHeGJnivP4a1uIUPDXk+u6lWkM
 UujhB7bxbexYQjrAzaw==
X-Proofpoint-GUID: tgpdxRxBASAlzSnU-c6aCym9QFGLzXZ_
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c37438 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ncbHsLySchLQHkEGmEUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: tgpdxRxBASAlzSnU-c6aCym9QFGLzXZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250037
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

There is no INTF_0 on MSM8953. Currently catalog lists dummy INTF_NONE
entry for it. Drop it from the catalog.

Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index b44d02b48418..2162ff917b0f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -121,13 +121,6 @@ static const struct dpu_dspp_cfg msm8953_dspp[] = {
 
 static const struct dpu_intf_cfg msm8953_intf[] = {
 	{
-		.name = "intf_0", .id = INTF_0,
-		.base = 0x6a000, .len = 0x268,
-		.type = INTF_NONE,
-		.prog_fetch_lines_worst_case = 14,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
-	}, {
 		.name = "intf_1", .id = INTF_1,
 		.base = 0x6a800, .len = 0x268,
 		.type = INTF_DSI,

---
base-commit: 6efced27f5df9d7a57e4847fe2898cdd19f72311
change-id: 20260325-drop-8953-intf-a002056b5ebf

Best regards,
--  
With best wishes
Dmitry

