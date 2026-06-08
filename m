Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FFCCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 23:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D17810F9FB;
	Mon,  8 Jun 2026 23:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJb0QwF3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcllaFR2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7B010F9FB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 23:36:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658NDaTQ445125
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 23:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UBrkQRGZcYDhaaq4PZ0t3p+XWTYaSbIMbZWV83bVyyo=; b=ZJb0QwF3hAH7XrK5
 /zmUfib0oTuUCZoyhRvYkgu/gi0MnX91UDY644ag7btA/pZGA2j7AxH94L/IYrD5
 p6V+X66+7dqMy3b2IpKODM6xZ1ZGIJJ5D/5N3fWQBRIZMk8WPgxprvDPzilfCC/V
 NILgh/EXqHfcAP80dbxAY2MK+D1pFDQVUAKLxY8arSMkVoB4Cq4A6tgbLOkjUi5Q
 yl4+MzEXpj5h+gVcZJDlsGTL6lUA69w1CK1ihi9PYJQelo58N5WcEdXTV2/NSKj6
 tkPEDUDtJrHM9lH5uDphP2QfIe18lrPNcPKFsM3W8b7oT/lHxuaAN9NY7wwUVzre
 dU1I9w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun43e48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:36:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0bf6904a6so68917455ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780961819; x=1781566619;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UBrkQRGZcYDhaaq4PZ0t3p+XWTYaSbIMbZWV83bVyyo=;
 b=FcllaFR2/izLWLnCdj4uO8G/YI7XIgtnrV1gK3ZB/Pi0MeqK+MWMM63PUnmUB/fpUL
 YqddWazvosa6LFvvQi2iHAfyeFqwHgAqKq7gV5jcK5UpMUOU3GwllijYUHhw0vJplV4D
 5asRWEXRqaLeazpAQbgAEW7DDDag+fr6FsqZ4poTzS6J42BcVmkHY36sraQB7dRq9flH
 SMOvNa5QW+hGvPL+288i7Y+ubdnihqeA7zkTNyzp8mshOpYlZ4RE6AOHvZA0lmgp7pIb
 qmUahrV1/RBUCWTbcdt0tK/MvmerC0UV8RCFyQyzrCdmR1AZjo5BTC+Cp7ua9KHhZE5d
 k0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780961819; x=1781566619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UBrkQRGZcYDhaaq4PZ0t3p+XWTYaSbIMbZWV83bVyyo=;
 b=MeXl3ssP8mi3UCCCuVWifUls6MlmWFOCz7WMwsIafdpSgqpgp4YJWct0qyoLUUdKJd
 6F7YO8EGNk5nH+2CHFF5h4s3+Ua5sSKQAf9X3DS20fh5f+gG5iBt+Wk4p5sMikc8B8D+
 IUi/IoP/h1HxHTeYt2qQGAg50tyhlnZdKwd54bgo1jYeY6IP3Ld7zxy9p4CL+c/Phfg9
 wr7ykUpHVzZ0HGIx1cDtRZRIjxQFVYsbv6Zsug0KTxTGi3l6hcVnIZoC40rhmm6L4VyA
 AmuowBpo2p0PCgPw++GMb7lxiF8itwk4bJLg5pNe9CugEar+JtQnntNJXDug39oY/bHi
 dMkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I801DpC8t/B2AU087+gy6pLFgp57zYAg1lYLtQD6i++F6e7E5kbV6TKXHIk8aTK92yQ3yEKFrlLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7HaQXlwEtBXL4zHRbAVUboTEhT7WYC0uUK0BGxgILyRVjymSF
 aNEFj1mbiEx7GLhZgUqF9ljWW1DoNfzflyiWu5B4S2Y1NWeqLsCNLHCAUJexQYDpgMvMt+wvzgM
 2Ew6D+cjXz0VdKqVSUNCCBFeV5RTJlVjNVygUF7S1NcLR04+NyWnkGTdTbARC7JFHnVYQkNI=
X-Gm-Gg: Acq92OEqiN0jaXdKlQOD5xVqJnn3Bv5SFxEBakdkPCpjOzqdWjrDSsACk+4FqLWNgnn
 lHx+lHiqExMMIAdSfp7YqzHxz2BavmXOQ7/U0EJki18BTKt3dcuow+N9dHJ2A8XF0yNUUTY9hCO
 WCj9tnJqegeDyGa+AC3HMXUAY15OkqqeUebLPBSNdzmbYblbhxTjie8SZfQOZil8LOJsgtfvec0
 soOENsQ7QJsqbGpuj4KlNB+doeWwJz0AlDYw7jUfnNhu0EXKWeX5Tc77ZYblxvdKAALeRZPy+IF
 bu0ymAa+hxYuvELmL4uTBhoYBLAVRBdk4nDgu6uyIK1B3z56Htq9S8t55ZvAGhxjVi0Swn0zzgD
 5u8BTLxcUfTs5qgR53rLrnfXduUCFm+kmXs2tNaAqb5q5yLEjhMAjCfZs
X-Received: by 2002:a17:903:1b44:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2c1e85aef51mr219048465ad.29.1780961818644; 
 Mon, 08 Jun 2026 16:36:58 -0700 (PDT)
X-Received: by 2002:a17:903:1b44:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2c1e85aef51mr219047945ad.29.1780961818187; 
 Mon, 08 Jun 2026 16:36:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edc8ad7sm66206975ad.42.2026.06.08.16.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 16:36:57 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 05:06:29 +0530
Subject: [PATCH 1/2] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-shikra-gpu-v1-1-9d0e09cab115@oss.qualcomm.com>
References: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
In-Reply-To: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780961805; l=846;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=p3O1+oVxykLDP+avfBtT5F2AwxJFis2S4LsUV/Ws0Zk=;
 b=KmVpOd+07fG4xxEEbAy6jMK9euc9ZYNKCadBlM1MTvrQ+bp5f5/mWujTWQruv8ubQ/eSbU1cO
 4yt9peMvMSxDINlXN6z2GwRjuEaUylvOLQ8RbHPlvaws5hOzXufjvVr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDIxNyBTYWx0ZWRfX4ry7Jud0SECk
 +O3lrQXlKoU+UlH/My0OqyQS84ejmyTvOT84DDOSYV3bwzFlUDMgZW+MLU21DKGfiq6yt8PoWII
 FrQjPWAwOBXR93SDvcDmFxD1gsozNHw9ObGxxQ5mrYvp/uEjw91vE9UnBcb+dIpoXQLi/LtZGg4
 fQWoi9CxVlodp8IR0eAa9jeIJddcc42O2m5rxBW43i4L7a5PLHjd9kD+gXh609h2PzfWl7ABof6
 xCiSPOedZB8t9Ezb7LDy+YOz/if3tbU0rKFsRA46IIS1qaJOqMS8HbmtxXrVN35BqLT+X8Y8zVk
 /HlZ1BCrMOIPRAgmmcAr5wWAgKfrPrsKS532WCm5p3nrTG3bwSN9o2qNs7SQveO/odS/hNj0Qj5
 x0hlymh5pX1+mCRa6r7r1N7A09Bmn0bvc0DPjCLvUdKbL5z6xD/Yl/Hn0iuRdOf9dwi7deYcIpQ
 UFqgoXx0IRKUgKFQbVw==
X-Proofpoint-ORIG-GUID: LnYF9X-fdq-J6q_JD92rpm_PlZGc91jP
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a27521b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: LnYF9X-fdq-J6q_JD92rpm_PlZGc91jP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080217
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index a40899e5ea58..2308e97f1467 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -357,6 +357,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.51.0

