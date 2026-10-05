Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF57CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B2A10EBB7;
	Mon,  5 Oct 2026 07:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5CGdhm8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GNspDe2X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB8610EBBD
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:25:18 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xvJT4060136
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +0ADLN4tmjKk8N9WUyV0L4KRQPHIhMO2nAEzDRj/GbM=; b=V5CGdhm8k58mrLcI
 Wo24SlRivtai3j96ezyMNQl2BSjodo1XjTa+B5w3X74frlm/Yyb5vgPfOpq7OYs+
 2rfFfGVgQ3ofPpg7K1L2iXGVncBwyoFCDLorDtktYN8ZRdLzyXvlwTsqdDu2gKTe
 m6Tt5+2z8pGZZiCZ8HB7XuksZ8WtQqhP7fdb2uKWNV4bazEpJmg4NJW/HyPCWMFa
 hci3quG3pcw2Xa7DLotfrl6i90t+g8XhbUImiOuLAM2PxVuYXHVXvDsuEVQ3Pkba
 56MX4wFL9vog4bwGSATidxRMpsi+JXl10RqbByQi/zEkuLTwVHQHguXC8nyZ5VEz
 jQEIWA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn8u3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:25:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1359807a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185117; x=1791789917;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0ADLN4tmjKk8N9WUyV0L4KRQPHIhMO2nAEzDRj/GbM=;
 b=GNspDe2Xok9uREF9REgFAt0QRM5mN1i4VjJxPRxYSeg/lvToHllMbz00SPC7rJc0qq
 aMttNoLXXPLZ3eFkxJowqzmK7G+j4cqDiUs6BbSLUq4e1rEp8ngI48l95b0dqbyHlm7K
 ilKkPCJZSSwzGvAmsi9/BAcCWgJpEqSLpuXHbHzE9m6WAgl27ppidtA2tb2gJxOLdyI0
 7sZDizNdjylCBT+/HJ07dreLHxo8ITtnVkkCkAPjC5u3XJelyrE4lrNIVjj0aaeGuSCi
 vSznN9F31emz9QpSwIq/IGdRJlBTkZqLjlG7kvBjst1p1BEuq5/P0781Ajznf7LfofUR
 yXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185117; x=1791789917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+0ADLN4tmjKk8N9WUyV0L4KRQPHIhMO2nAEzDRj/GbM=;
 b=VcLAjiQ56jHJn8f9ANx+PJeLkARssq9t8dDQBUdSWmiCqW+lQWmoXpj/HJBYkHkIhA
 MaYXnX2jvJlln+uPAh23M3TX8qt9ztAfcnl/rdhfOSSLfTuKmJSsVaGUS9IxuPvNyj61
 uG4D+w5ixN79uxINtpfi4SupBuy3CXQdYulDo/4SBiNG8cErWlBi26FFRTcAQA0KOVOy
 94UkSpiO5X3+z+x5T6YsgawPx4tMpR+VkORzG60GmF/RO5Mnf1CzZjC5A1v2HhAAwTyN
 lfQ+CcZTd9I4AcP4oosa3Ps7EhpdSWIdMLzAanKzD2JkY51nQ8ozis13uoQpns0pNpyK
 6Gdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIivamnU97SWzl2KE27M/wtn2Pn4rwsGLg713rFjyjd0sq9Kqoid15h8cpgibLk/jTwVDlpCrnv88=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpGSRtwqFTYpYrmx0t0rplW9VXcZT0TmcZukKfBF5h6PwERjcd
 DBrxPdGC/LKDUQcDHdzuGSPAsXO7STjqqIv24/3WKJn589+reiFg5K4Q4cD5Sa85UxPHMH9y2jX
 8cZRQ3BsmAgLUKc732idXoNcnXC5Qj0BhDNjQLoX8SUY8buy/0Gl9zX2okYEqs2xbuWCFsf8=
X-Gm-Gg: AYBFou0BHqYP4Wai2m7drAsqVHtmAwTEKBhz+DKskcs0fH7Nf/mBxYWvWmxs52GokAo
 L9JsGslKgv92djtqHPHRqduUtI3CyUT6k9Kk8iyATdtK0jbceMkZCi1+IL7ukdzHBC3N3QXHHfu
 9IF8iiIp5AbWUTMgyk/m3zoytC8MNfP3HKT8DnaxJw5gHJEoxpWAe+FvdBuGFKHutp/aDOYX0Zz
 zsXimb06HyhA2jynSZzvBC6S+u9asAwUGBFTDI5NHC78ass/+LzkN2hMdKdaT9EUW5iAyZ8XjDG
 5hYm1wLIhPYa2EDF6HLhJWP8uQCAxa4xLQPRGPVlQ+G0/BL6yiy7++NFI4MIJmX2rfAEd66IhHJ
 o1CcZmhUj9dQBorKoD3WGTyCADxxJUuLDW2g=
X-Received: by 2002:a17:90b:4d0c:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3a7a463570emr1941189a91.33.1791185117398; 
 Mon, 05 Oct 2026 00:25:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0c:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3a7a463570emr1941150a91.33.1791185116922; 
 Mon, 05 Oct 2026 00:25:16 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:25:16 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:54:30 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort
 over USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kaanapali_dp-v1-5-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=773;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=H/ngu2NtKM0XR9OEviez25RT11Pu6dH3Orddp07YVTY=;
 b=D+xf16u7uxuQGu/DAQZ8gv6a68ZQIUfSSSOn6ayBSuo43khwowC8y4fM1svWyJdiebAe5xzBG
 yUJfp/uy3LCDY6ghTGnBTNWaIER8u4JC3fwO8PU4lULQmrIgUNGl4JA
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-ORIG-GUID: Jm4RFYE0JhtSqjbJhIOKQ7WJ7wB9RB-J
X-Proofpoint-GUID: Jm4RFYE0JhtSqjbJhIOKQ7WJ7wB9RB-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX8rVJCmAW5dmz
 uACwterzpK806LvkkS+eqZTOaUa/cYD/zMnyeawi0IyWN3GScWKc3XAMSXg0IYQinbSarWiry7O
 4ZT0zPGMkSOGZ9dAaskgxAXrAZmLJE0rsDbT4lyICalILM3/AlG26P2lLJUjMzlWZQYHZJttJIA
 11zO2LOHFHz46MU2U5dUfyoomQ6dR20l1ZpyxXanFnHOSKjSholZmvhHxM9HCef/gaDyqKAZU9I
 PqkOYtDUciHPy1Ybq1pcsZdO1dikbyYdELjaShCkuMg7mAwBTF6QT4beovsKSjdt9f3KprS4S9p
 7rLkm1oQK1G2Y/K+QVQ1viN48bk1UTMjf1tuSbMUhWLb5J3cJCR0q8ZFgM1tOemF2v7IagGYxeQ
 7Vq5fMLGSRTgXtMTbbjbCF1/7aGbtj5FQXFWQ7bhDeDRocVYl4ASoCh8tUhR5TYzWadykSPhjPE
 XeoCCjLixoy6SAu5X7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX/wnnzmZUxCRn
 1/ELVg3rmYCkAUR/OD7LKSoPj9vaSAnLbq9C4AD+VURkFRJXPKEp98SxVhSoHPHCVYTm13ZNNyW
 mblA0TKiGGYdwHO/Yd6AeCsbbhoFs/E=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac350de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5UEAqLcyi3SyoXtcnFMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
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

Hook up DisplayPort parts over Type-C USB on MTP.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 16f4dd041649..ff5d5c2fafba 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -1015,6 +1015,14 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
 &pcie0 {
 	pinctrl-0 = <&pcie0_default_state>;
 	pinctrl-names = "default";

-- 
2.34.1

