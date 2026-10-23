Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD060A2616
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SlGnRFrq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SlyGci1W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D869B10E5CD;
	Fri, 23 Oct 2026 09:03:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1920E10E5CD
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FLc31048044
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+q1eV+ucE2e
 Co/QY19WIgE28IiM00UBzaKhHu6xsTrE=; b=SlGnRFrqga1sYpOmb5seGpqnHXA
 lMVCsGwtF7E4P+qtUnTF4k+SVec0V+ocmiJO6IjCO61vOGOwBxaratwVbioz6qjZ
 bQGqVW0h0u9FFAPy1p1Oaovg3IFu96kG7hH+aST3C8rUoIKMR9LPkv3gHu8RTNSl
 /pBh6DZ9Wa+wnHTc6dvi9E5dxe3p0tp1evpskV7U6NzXDD3HEqCt31KCG2QbaNqe
 vC6SxfajvbTD/XK6ZkVNhaJ38gmVTiQQGh02anQwIO0byCmhbkAbYFxkp78g9eEZ
 cHw/fek4fN4hO10DnSUQaidXe1rOBSYh/rufLnMoDAzVD0QY38qDs0zrNAw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjwuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd65285537aso290857a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746203; x=1793351003;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
 b=SlyGci1WYqryR5RhIid5g7ldGxTUp1cYdLJMzaV61mf/wsTxh5qLgGyvslz8CYisCZ
 n2ugvA8lEDjAo5ZazYnYYs0thhszBGLnIoMexr1+ZlFeydwYqKLpbaq5MFpi4zJWGRuA
 qcum8bPvqLHyX2/Z7uGDG8sMyvEG2Z3dno6l27Pedpb8v8wtlDXXZm4wXRiJcOR+yOjE
 5Lsuy7nktInX+VCaKl48qZoY09eVXgsC6J7E82dHE+PHr2TJxemSPfNDN/yWN6VTYeEh
 x6xF5lsmxxFlsp3rfXfEtlwBXYWKiEAsMCYQBqLJF7N9SvUlZ/MSmjgzEo6dnhSLBaQD
 BMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746203; x=1793351003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
 b=fvs+2FjLti/SH2aK6HO1EQsfeapHqRl/Nv733AQhOUymVOIQ1itveM8lBgQlfjLjnD
 VJDjCvVhMOn/2xZLnsSQjBmL1QpAMUJ2zJ9Teqm56qfEi1XV2AX60vExylMuVqJ7gxpm
 9+jiNm76OiKD/Djf9ESdtQPwro1tsXowfzubaypld8DdCoqs4QuwvlTaMn6z/O8inpye
 dr70ojW+0x5igq2MsFm6tHOFznteb3B+/iHa1B15ypyYrRSYQgO9r5ST4e2WRWyfF9FJ
 89PsPc/kqYsvaj08t1ib0wHrjq10lvf7BLiRh/RogM7HXoGXjiKBKL8qLajQzxsVoaBO
 1uNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNs/TcBhcb+hA8YgqToRWPdJugM3UBTBQ2dOIs+ErsiP271DjmQ3KE0yCEvBJj/wO54k/8q60psrE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKeKt4wzrjMmgtZWIfXHLoRm21ce3eE3XMDNc6dwGKdRgWaYFjw
 v/DhbZwX8g+Pi5QsNXwWNTw5zRmpeHFPAr+2FkqlE4p9+KHWDJ2DORv3gE5IX/cCcU2HnDt4XM7
 EPYrT4TahpHU3WZSk/BsnlSM0X4b3WF9i7BbGb3myNgzt4AIcfnCaiksDAK9Nio07te7lJIk=
X-Gm-Gg: AYBFou3bNugNb5TCc3gMD2qp/CJLzVdbTI3UYrfiuMP9Z/qadckNCOyh3CMb/lqqaqy
 FFEMV1qYamqfGdFoThOWtvvWDK0AKyNT3/A1QmpMofB2bobxWhV855Xqi4hW+AiZ3cbhyyZ4Idh
 BDzlqvgcArnL7JW33dLd8q5NK8w01isHbXg4OGYZOZcXl3+/6njW/wLwmgNUp/vJV92E5ioyktN
 rtF/Q+vPr2/lFglgnJ//xuC0I2iPa+uiRcnHiqrwTqwzndT7k3Rvyfz28sVq4X7YHJpDHTBuSra
 uubuN5hO86a+DFRPS6hNX70Vlmp/xLmubWXZJjF5uqLpEd5sKnFba0F/OaxYUYzzt3TXAfysWaI
 4kjDThTegdbg4O633gvv+7L3uSokI/B2GaQ==
X-Received: by 2002:a17:90b:3b4b:b0:3ad:1841:6f8b with SMTP id
 98e67ed59e1d1-3adce74cd8dmr1384921a91.37.1792746202958; 
 Fri, 23 Oct 2026 02:03:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4b:b0:3ad:1841:6f8b with SMTP id
 98e67ed59e1d1-3adce74cd8dmr1384892a91.37.1792746202282; 
 Fri, 23 Oct 2026 02:03:22 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:21 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:03 +0530
Message-Id: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX9uUAHobjRCHt
 EWdXqeG2Ol3cwpkv9cX6bj7VkpSB0nxa+/zFnZ3hnZhm9uTgsYn91mV2P7hUw7ub058j1xCUcR3
 goHb7wDK7/ZJD8mvSW24v4m1nW540Mw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX9XnMevJX2dWr
 PyhSGLJTilAsQ5r+hrn0P3RkmyGQHqiORrxdK4hEgmQ0XrAISTqr3KfK+FJooMyYzmVs0K7/ySE
 XAQjGiXbJ8PFTZQGm1Fw6UtuFM0ZnTy/UblF5+UdOH+8PEh4O/yUJPGaYuKKvzczaaM98hC2hJj
 XQSYWFwzpGqR0JXF2xljlgb7slEEXVfgGLF9Z0F1soD/ZR7Pjm+9czcb/ZNjFAVryNXtnh66Lno
 DEzGjedNuDcB5sLcRpVZC9xLSYHZ9GaqCTlUTxnX2Zeaxq8N4zmHJJc0bfGxtc8rapWX6zkOfrC
 vBxCqmrgvnhjYhfSZYtpwBH5QHgLeDHy5qUUUjsijjrquNBKNRzNmDxWVp+SWdq7rkhpomSOW1P
 vJpM6gdTEz/dpK8Hoc9tSHgz1FdCkzjRAoBjcYHqBTQzz8eeCEvcao/kOqCtMtExz6yM1JbbMyd
 /lSUWCERhH6YN+NuUFA==
X-Proofpoint-ORIG-GUID: vPELBewMQFJpO4lpkj7snSATgDUhhQzP
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb22dc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OoeahSk16-wZEypY81EA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: vPELBewMQFJpO4lpkj7snSATgDUhhQzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the compute-cb@9 nodes from Lemans device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 695eae1b7256..5481dfb73454 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7861,14 +7861,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2149 0x04a0>,
-							 <&apps_smmu 0x2189 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;
@@ -8000,14 +7992,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2949 0x04a0>,
-							 <&apps_smmu 0x2989 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

