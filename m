Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8ECA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A1910E374;
	Wed,  7 Oct 2026 10:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P//wiHC+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnWMWSCv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9227410E374
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:28:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jRIt3298190
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 10:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iH+9GiDPpWneB28pB6GX8OAUsgwnjX/bKhO7+TO9WNE=; b=P//wiHC+IdUuYozE
 Uv6VxperqWIN7ARGW81JVcKKEtgX/UyTflDhn6bKX2dItLj2m5SS/3qCwOhOi8oR
 p5nl5GPP37JRBzEWxODW6QOhE9CP+sjyo/H3sC+VDZnGBg+vmrfA5zvvvAKg84Ni
 EhXlhJl2TFwfNLB+Ki6RjzKJRgDVzppLBax9NsUQzJjSKuUlxp21u/DukW+r7S6v
 z201Dd1Ighe0Th53ma/Bg6VWNVCCUntyyh/26sJ7ODLNftLvqxTO9TWBfRJ61Wgl
 X4RQoMFqCr6dY96QGzi5PAeFHZzbkWkERagMBH9nqyLTTH58ZMc2TzWMGQiWFm+e
 HIaJSQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrn6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:28:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so1477533a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368929; x=1791973729;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iH+9GiDPpWneB28pB6GX8OAUsgwnjX/bKhO7+TO9WNE=;
 b=RnWMWSCv5amK30bFhfXCcWntM/r9WK2ocUT9MjjOuwvhBwVdIV5xQMEmQ8y/l+xJse
 Y3SEOX6ztp1bWHN/5Guif6TJ9rlluxEkfe8/gVWXLYmkew+7tODPTsri6WAD7cgrkBB7
 1kHPd2uLnXBX/Jfz3PlT7IrM8rSsP7tIV6PLF87QeUmrO8NCIJM/au8NNrqCjj+ftll7
 n9L2DFEp8+9zQyGwGQ+kVjjg7+TUV1HHVGu/WgMvcp3dpUhdN5qD1czncp20Dcrf4hJ6
 S1E8vHkF4NagsaG/zbEc8C+Oo/nfrP2yOWh4aIlAYKzqNqKoGQ7rOxB4vlS1ximpeBgc
 3F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368929; x=1791973729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iH+9GiDPpWneB28pB6GX8OAUsgwnjX/bKhO7+TO9WNE=;
 b=M5+MNYySSLh810RqmpJuMn74ur0CNctWz53MwMthUm+rsH6MQdKM9YNb+j3lqDXZFW
 Z2ubMGs7IadAJJmnwh1dpXCrDbwQQpORC8mNOr/Vy7ky7vbSSpdWnflz/RBgtTzDx/D0
 CRqhRmbCJyukiX7ABjiWMmpceQ0pYl+/kPCDkRsqSPf29M6HHTmSaWwtZeImgtxPoT/B
 RXj2E5TW0rgw3EcEC6fQ4TJKyku636TKHXVY6WFOD6xPGVG5t49e0CCJyS62WjFTuyPK
 gj4wR0IO6HXo+lS2CZU5qtY1lVNuLNsTm22QJJXW3/6WffBtHo/lphIKi+8RsDrLJFKd
 pAMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBynEx6POglgEw7xyDF7/5xM64mWERzbsj6HCxQE51Goshf4W0KMYIBocR9ZPeIVuinDPUIUV0DCzxQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laJr596EC/py3YRj/qu66WoX0Km6JtoqRNC+w5H0eoDzDvHPUU
 c7Vv89lFW4d539NPmGIURQNnpug6M0xekHbtj3GtgxYcNuLuZPq9g+Knc3/gPThVkbViFUKUSzb
 OqCSDcYAy9eOQlFYKSsclxi7WaTD/5Rg79d+A+dTMJYu2zCpYRTOprSmqYum+M8yMsl8/y6g=
X-Gm-Gg: AYBFou3h7ldYqwo+caNyQjGb3aK6mIM41yJmnu000Q7tXmCt9gE+AJD+wwpQj3Yx03J
 7PAk5huRT0nAsm+7sllud5Cdddh7FHr/xAAERtKVlzt6Z7+KVxlcjIUdU7wM087djZ+JLB8RBYT
 MyxiNpQRBYfIVM2ej0ijRMjb7U09JJ4xmrH0UvFYqI5djX6It9I6f8L9n6UGpVoDkgLy/nW71at
 uuYSQ7bvoTVxCajmUMPv6CJe7xisFgcqpgBiVJ58dHwSGrobU18lSZaLzragUshAN3GuqyDh/gq
 KRMXhuc+qurdTM2On8MdN5FPSEvu8zAXuGs+MRmBoeU//s1tW3qI6nNs6UWGHcYpA1XJMJT/fYs
 0Vdls/OkksBbjIjwjCNVqd64Wd+6sEEbR
X-Received: by 2002:a05:6300:7105:b0:3e1:1abd:f560 with SMTP id
 adf61e73a8af0-3e11abdf5bemr2333414637.6.1791368929227; 
 Wed, 07 Oct 2026 03:28:49 -0700 (PDT)
X-Received: by 2002:a05:6300:7105:b0:3e1:1abd:f560 with SMTP id
 adf61e73a8af0-3e11abdf5bemr2333396637.6.1791368928785; 
 Wed, 07 Oct 2026 03:28:48 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8cf2b69sm1221334a12.8.2026.10.07.03.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:28:48 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 15:51:18 +0530
Subject: [PATCH v4 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-glymur-dtfix-v4-2-31f7143e759b@oss.qualcomm.com>
References: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
In-Reply-To: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791368909; l=2062;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=psbWem1ZCCmNqyaQ80/h9KgNdtSx+SOb41pw5y5eoH0=;
 b=UkA4SeYk56+28bkhECNF2TH6RB3spudF2pbqXEYYo7qD2cnHItHZRm0hxNzHrkYBStZum9idS
 L6nsVxg1BHbAsaTmPfDaV+kBTfnglyDTn7u5mfOXdzyIcJrkS3qTTzD
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: jOC5HLWpc63NHA1Ifyirs6cPMKc4lscC
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac61ee2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=RYp5giNeBl3isHo28N0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfXw0W4vQw3iXqm
 JEgSMVJcbTaYfHgtktAH99E52KKqPwQryHH59rDhW++GgvdC/35LECf+tgnNgt/1YdyR80YuCT/
 BQsfAwh6djiX8zpW6NPvMEXieSibtf0=
X-Proofpoint-ORIG-GUID: jOC5HLWpc63NHA1Ifyirs6cPMKc4lscC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX3ZvCBPCfy9nJ
 doV+OaZ42NJug3UvpU8uOCbDTv8N1mIJlAt667+5pfilv1tMjLLrwG611WNYi1ZtV3Bm9VN4YUQ
 GyUQlorez6tZ2/WsTshcDIkqSIEmIedBXsuwCFt176DC4ZBMZS8polkrqFG0RWDAag8fW6di2cC
 rD9U8BYqT82OzpHodklBQym4+U+qlJRDlyjALXraJwZq/yZYsvt5xS+GlRtrIbNleYWU5bkdupk
 YZDnpXO4Ri2XFmcAYW6wzGIiEsRDm73+N2Tev8C/Eh1hLq1hz5aeUkMFE7KE1sAsCFir+38kY60
 /vzxrVVuC4R/0nAuCTGLt5GesE67VhE/2+W/H4KDV3FUmDLVupnnWz0zmdqn3mBO1hDWQkMaTva
 PeOvJzXxk0JmN+FFNULYAEc2MVjDjnjv1ZH+xmsAzhLqQCGkDZd8C+hhDQ5OTc/EuXiWs3tQuEn
 e0ZzYJQCc5J9sL6mSCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
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

The reg value of a compute-cb node must match the SID (the lower
nibble of its IOMMU stream ID) it is associated with. In the cdsp
fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
14, which don't match their SIDs and leads to SMMU translation errors.
Fix the reg values, and rename the nodes accordingly.

Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index de7c395d9c35..3219603372ce 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -8471,9 +8471,9 @@ compute-cb@8 {
 
 					/* note: compute-cb@9 is secure */
 
-					compute-cb@10 {
+					compute-cb@c {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
+						reg = <12>;
 
 						iommus = <&apps_smmu 0x240c 0x440>,
 							 <&apps_smmu 0x196c 0x0>,
@@ -8481,9 +8481,9 @@ compute-cb@10 {
 						dma-coherent;
 					};
 
-					compute-cb@11 {
+					compute-cb@d {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <11>;
+						reg = <13>;
 
 						iommus = <&apps_smmu 0x240d 0x440>,
 							 <&apps_smmu 0x196d 0x0>,
@@ -8491,9 +8491,9 @@ compute-cb@11 {
 						dma-coherent;
 					};
 
-					compute-cb@12 {
+					compute-cb@e {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <12>;
+						reg = <14>;
 
 						iommus = <&apps_smmu 0x240e 0x440>,
 							 <&apps_smmu 0x196e 0x0>,

-- 
2.34.1

