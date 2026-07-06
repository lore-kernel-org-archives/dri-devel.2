Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47825C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D1210EADE;
	Mon,  6 Jul 2026 21:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="njTE8qK6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Utoyp5ts";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2871810EADE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:41:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KErCt1568226
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=; b=njTE8qK6HOr/c07s
 nWJ62yK7y5zZB6HxnWuxRHGIbpX/GR6+AbzabIh7+TiSZ/sALesKBtbTUhXWOYaX
 UCSkt11/mJwBkA7ieDsiwlbciJLTKTLnimAuuNdf9RDmzLD5Fp4G93Ory2NbHBTL
 kJnB55MdwG2dWytvowbRjALalOlBbMX9diBjsjs2I3Mh0pu+byBkPe1A/NwC2pwh
 l+9/FfX1GWDqrJJSGektaCNA5OubT1JrU9e42JwkztuwpoLVhM6xo4fhM8jDaL3M
 Dwp0AxiHrwiIQJO6GlqVggp0tNF5uOEaMW9qKjRWiQIJpV42fSYUm7D0D+M7BQ9y
 sJLZqQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7kn7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:41:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9a700dc0eso29047535ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374068; x=1783978868;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=;
 b=Utoyp5tspWUSnqItoj2Bp6ykzKCFwZnrijTGEi8Wnkyd4r7IJE4PK7JtmpoRjjs6JI
 CoJa6Wf9TlS0ovzNRtN4lFWZLyXW2OoM+kOEdgCs7JCwgt0jNHENER1ipERHeX1P1x6K
 Hp/wEcKDNaweOTqNI92kzJYQ34bn1otPf5SyY1lO0p3sHK8E76zrR95rWRBtjQkreepE
 SEpPn6zKOYI0/KYq4iMmTun9i3UyOHZC06gywturBlMq5klVEJ1TQUlotZaPLnBDyjmb
 OmLGUvL84moCU9cA5g9wxJl2o/OuTW+fD6VGzk1klkUIZIHd8AYqKt0iXG6nFUnfErIm
 kXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374068; x=1783978868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=;
 b=GQGOorsZxAD2BPkciiG3RkeMLqiqfxMRiTmMcYsBDtOfTVvL0bpZAUTdwq220P4P1H
 BDkeGExS6H7t61opYBXOUlmBkYjMZ9wFTI+DcUHiEY89eE1oQDSMOF77+yW7LfqZL1ON
 Wcb5I7C6s6UCPKHBR828gx95nn+aItftCKql1QLhtOZM2W4pQQy3jel8BhU6sGVaOLu2
 fYFLidlxfvGBNFt1Xcfo1GAV9ZGAyUJcqezr55qnWz+XQ9U3roVS6n8ectYeDzA/Ebhs
 PO0Z0XZ2ERVS/gci2yxnNKel2tjNIIxBPh+Ilc3YT3y67nZO6LRD/3/XnxuEZOCcTD+n
 8Hzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKDRb102m+NPmeg3dTD4vculEF30ypeLEh7dH0pjwzXdQQ2Xo6ynYrOK1wgbkifi0cVDuLzym4qPk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycQJn83RAQtX0gU3xt1rXnCh1elIyjFZPq/RCqaOFJ1qbZ1hds
 D75zE8BdACfTbVMwPy4FkbRA0zhhYxRmhz2U4IYrC7O3m9bO6Cdcpo30t83UAc+T+jsewSIF8V7
 3VQLYE4ESBmb0gbWxOkripKbe/mb7s+fkUbOIhT/b309rXScxTCIWk2gQTtOWTGKjzA6dRo8=
X-Gm-Gg: AfdE7cl1NKBPf2nKI798UhYagJ8VKd9i4P20ZbM1qg7gtiwtoiOD85OMqVSV0rUZtLg
 +DQCoqmfm3yyYMlHGnx2MPRO17sxYf8zrjtUcX6D01jpmhjDPY5+G+uUtXBnwPp8fgMIny0dvE2
 AYXDYWbklJsHRqeodP+DUb0Hp3MOOKQtwHPfe97/D8uR4OgbmeZNknnOSVHV0vTN+7qVbvQIjc1
 FTGK8z6cDqlp+qfPwPDRX7IEkr/qcJJdWZxWtaAmAQufRQIUkUf5pykfanDCbUbPndExnJQZVtw
 o2iMVKbOrWJzw18MiBgzyGMZvBbxFlePZR7S5ShQXsa62oZqT+yrwLuSkQE8CWsCH4g0a1WFDA1
 sSae0OhmWSSKosDQOqiFxQas4nqik12zXYYQ=
X-Received: by 2002:a17:902:e78f:b0:2cc:741a:ff33 with SMTP id
 d9443c01a7336-2ccbf07b90dmr27229485ad.43.1783374068143; 
 Mon, 06 Jul 2026 14:41:08 -0700 (PDT)
X-Received: by 2002:a17:902:e78f:b0:2cc:741a:ff33 with SMTP id
 d9443c01a7336-2ccbf07b90dmr27228815ad.43.1783374067709; 
 Mon, 06 Jul 2026 14:41:07 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:41:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:21 +0530
Subject: [PATCH v3 3/7] arm64: dts: qcom: kaanapali: Add QFPROM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-3-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=1140;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xlkJOQ68/B3gMybJ9Ns4FY50UaqHntYHUufy67tsBxg=;
 b=7edwsEeVv8RHFs9wiiykhb6VXFeyYOH/HK4hwAwFZ0IHw5gWNb6aDpzyhjQU9h/vPFqbm1TSa
 s9NCvSNutLKBK4+wkAdMeVSn/V2LA9Rq/OVHw7b/aeeMzaXAawE2luN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX+0aZOBBV0x2T
 qbJ2Oxb3RbcSp1Hla+VcP7XXS77qtaJFUb2Zn/9uoHlDXCXLza+dyRgJO5qqc12sraR2yzjq/5x
 wGuVCTRzmtrxCII8LyIJI0Xgrz+2qw5ukHR+eGUw6zsBjcu7U05vMVpDBOYks5r8TIuf/UY2L96
 4HpTZZaBnZpg1ZlnQmGzZh8nILWZeGLj3TnivcXV7MJriMX8GFFt3huRZzH3i+9Xv5wQ1Wp05SW
 6IoVfenk+wffUSUlSSLdCgiK2k265+S3wezFuKn7lB6NPUoV5JhsA8l4qzxpzSVAvvcj25OHrHq
 1pwaJyRNdq++etiDZpw3Pb6Ce15W4PIQpgl9GJTep3u+uHriK2/Ktb3rkbxyYypYYREq5D2FI4g
 S6KZrf0Mz7bpodBoEyRihFI/gLtqHOcJoKDI9+jpCA+qYwn17qJK/1qtSztH7mhEj1w9sPgAbow
 MxV/Wv+rCMXR7EVOsPA==
X-Proofpoint-ORIG-GUID: ygTApsDUOUlo6vt4T0H4Ib_HP1wpqwLM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX3PgUtIh+3Esx
 lpiTbkYdJGMd0MSVXPPTe6U1VndW06A23CIUtWXzj+DIL5Z50WxfAp/BvEjNkRbFcQIfmEkgr3x
 M3NIkKf56OFNMgBzEfBWpr3iM2aIEFM=
X-Proofpoint-GUID: ygTApsDUOUlo6vt4T0H4Ib_HP1wpqwLM
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c20f5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218
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

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the QFPROM node and GPU related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index a41962366941..2d0db71cabf1 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5871,6 +5871,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.54.0

