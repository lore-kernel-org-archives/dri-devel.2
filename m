Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8D60A2633
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oNnya9H7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EFb6cg5V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3810E5D8;
	Fri, 23 Oct 2026 09:04:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8095112A33
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FDQe1767186
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EhRIYoT55j9
 ig8mGHfIEupQGVMISzGazIaZrj/4btXE=; b=oNnya9H71PxHpHVdWa6UdI2Fpqr
 RAlkKwL56vIVmImFPeL+WraxnAv4ocEDUrEXkh/p5Ev+MgY3vyac6fKmBmGgZ62R
 46ZoMSkbvMAvSFNM8quyhemenFvIHGCIK42QtgW32IGMG4JS4GBh0O26wZq8KVEB
 bQSzOdjGZTcKEauPhxqkNxQCbzTjLeU1GFV2XnDSCwiyd8ao+bMOp1pjJDEX4S+6
 LMTD6sF+usPRdctUauAWxeqc2DSAqVXBMQnGQZ9+6HY8QMN4YPQ6fYc2/c/V3Hvl
 R0pm9QMY4PyDeAbIvaZ2o1y7BzFClrmQMVFKQVRA+FOSLCTJ3W0jPsqViFw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahuaak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd63a7cdfb3so521335a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746230; x=1793351030;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
 b=EFb6cg5VzPNMXsX6rpkX6zcbwKMXIJ6EHykEybJLkCPtyfTwOZxNZ/S3Dv/zEJj3x7
 juT9j/wGuxK+vUX5fo7B1Wv3SIL5zORVuULSfJeV9U1It8I42oPQND97pFqpwsLhHAss
 JuVQcgxwiSO4KgRPPtwN+UkmWxrXpDAWvNJ19+ceRUBrXzdJR2AcX0RXpd6TFmudFNeA
 BiJ3qOeyc4w+pTz5r3vJhwEQuOSllWn2FOFX9lx1nQGWuY14Q1dbB3wp8zM5nTIgFQNe
 LJ7lvdVSyTR0J9/svN7gVBN30K7S6oyTocCcahQUPBSVv5xEepAgKkMDA0rmdfvkpQed
 Zelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746230; x=1793351030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
 b=WT9P4jX3wYrGZmyFrN/MoWXuc5h3b7RUnJ/D3/z1BjkltugcsP2Zcpp9RcQkchjlKn
 WR9vQATdUzHLZ9TcAg9xm4oqLIlo3ZngHvdzJpQa02hPtkrqXozuBOLNMCON85vzgXHp
 wXpMqKja30Nq6i0fOq9/9MMcZlUgLXhPkVyNyEIZVWLTuR0oapbAqxTY3ugdDvcDXrrc
 8Nvy01mFugB0MSDVwZN+KLzI9BMJROhc3bcMLmzuxUWwEkh0MAxg24NE/W36zyfsgqqu
 tMiEeBvDV5onmiUr7iKa/xJpAjTLsK8mGJikDYTNbpY4kqyQuwqy7E/lZHFzfkdiYmMA
 +DZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygTxn/jd1VtQ2lKzNzt4VNNHHpV95OJzl44p1uVtLGIcuyJo8zQXvdEvOrTd/ozJ9VCXiiLR1Nnhk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNiTWkY2IFDQJMMXr4a7750jwNl48sQljxNeTYivZBJddCoOAt
 KIP9PsWF8RGnKrIOHzmwIwMItWej73XB5f/qDuROimtBRfy/EGAAFDn7JrTdtVCupHhkXRD4UfG
 WY8CidT8N/mNOQp4b5WbP0Lr/1BosYb0MitOFvFUsJG2DlSufvI1CfcDMsqDXbdLQSTEfMEk=
X-Gm-Gg: AYBFou2FPJPuDptr/aO1c5+1VlRu2ZjruhI3dvsnmYlGTkQm3KnYtAS2kEWlepWJvlE
 okUN9L9Cl3LGvB4jluDGN4BbkL/w2yw/h3s7OXLscBB0tT7KZQfJJ7CKG1q8JawOhaR6OK5g9Qa
 2+cHTnNzQkiJxjfzBDuAuSblTzSxa1FZBrR7EFtNekDSJeMXzfUGNvWP4YxeZwocZMnW1F2M/5R
 9yXpAk8tMaqb33k8oyaa3EK+nibr5s94YPH78s/EOpbYi0V4huL33bgrjHTqWuavqfmzV1n9O0/
 z9qAKrP7Ypl10OvbuAdTUB1CnahmXNasbS4WI0fo+tgp/DxAMgOhJazJYJTos7kkRg23UsRAJE8
 UzVR6zoXdrL0FP23H3LpyPVB2LvIetGKXhw==
X-Received: by 2002:a05:6a21:6e91:b0:3e0:c5f5:626c with SMTP id
 adf61e73a8af0-3e36945f18fmr1219885637.40.1792746229800; 
 Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e91:b0:3e0:c5f5:626c with SMTP id
 adf61e73a8af0-3e36945f18fmr1219869637.40.1792746229374; 
 Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:08 +0530
Message-Id: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXwDPl8AU2/Dru
 aLlNLbFnvRz3xPbF8sFlL6V968GVDo95Ot3AF7IdL6ennYfxKua2IamZKJyTI+PyUsr7jsXWVV8
 s7/gguukIbm5oY6vwTJ4i65zJXUW9yc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX9m1rKEb8cxmN
 j5NhGw5CoOKENUa5G4sGHCaLfDNVuuUZ8fdJwIIVaxJl58j/F8VFmIqbZHuT282N9DM3wO0744E
 /Hu+J9u+XqEk7Y63rCiorD3vJXQN5T+x/3t2WXUctX45BQ9yjGObK8wqs1kgfiym5zqL90g+gi9
 SKjSvETU7o9g8Sb9U3l98ZIr9VYjHau1CCMrjX5Lf263FcJ9yhRLiIKql+JBXSPBZ66PzL1jhmD
 gl/Gd9NxQFcUh6qGrE4TgofM8JJARmuXBnE66zYsqdz0yeISluBhxBDDq9LDCyRVzHkbcLQsnLn
 1PNeKePY+/1fJHFUzGbof3i+1obZLwvLXg4IebqvC19f2DR+6bF/wMLHC4qA3Gi1/j7Yd4SxTga
 113LBkuspUeyQws8ZBvmJ44sBEbaTAWakm4L3jByO71HktT4KUCIcEJ6yKm8VnYIq0VbhgH4D6d
 0HjGL5lBjNTbNIMmQ9g==
X-Proofpoint-GUID: Ia0a5AmmPfeaf0pIf058h6Cwa6PLX52T
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb22f6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vzw34t4vhacumBYsXzkA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Ia0a5AmmPfeaf0pIf058h6Cwa6PLX52T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

Remove the compute-cb@9 nodes from msm8996 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 818e5660df91..51ef306c1ce0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3701,12 +3701,6 @@ cb@8 {
 						iommus = <&lpass_q6_smmu 8>;
 					};
 
-					cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_q6_smmu 9>;
-					};
-
 					cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

