Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD02606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOklABr0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MWCCUkvG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E5010E60E;
	Fri, 23 Oct 2026 09:03:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0943E10E5F0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F75w3153902
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jadIZSIrpTy
 Ei91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=; b=XOklABr0j/NFfZ+wWinWrioG811
 NY0GoQIS8QewX95BcHrRB277F9Ls2y/Afkk0Mg59eD+Fxx3+sMbVgOi6JOYOMLGy
 vlXQ1/ApH8jdEP9uqfrr0rDuVokjbuTcVYPIZR0eyEmusNMsN0hdHHbouZys9poo
 jWI9YRxMhXKbgIH+crOstxic8+JjN+uNmuTyRMVjcR+9U+zWdVhoQ4xJ+v2jeVR6
 MBa/TldiHqT5G7Bv+9zFkB/uhyWp+z2qg5Z/IP1z49sHlO/cqw3CkH/QNiCkbess
 h5NWTppYX4dJGwufgeqOpHCzhvKYbrErJctBL2fRlsf6t/ix7gKTQLvHKtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrauqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so760768a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746208; x=1793351008;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
 b=MWCCUkvG2b42MuZ+pXTQXg6jejYLwDJjvni8FPoi3Fb6aG1oNQxy5U809pR1I7tEbv
 G+OE9syroW1CL7HxnZwYlAEdAOb8kAQ2/sxOfYFn54QKHZpieOgwo+VUJyYNvVGZXe+k
 +WFDPvDD1yi4VcoIGsdO2k91joFjfAWzjSQaleYxDPL226yzrVtmQyxj7z9R/1K5W6C8
 7/RI2CYwIfg7bEex2SLBkwphcwgIP5ociZD1HdXObsK74Mk9vMxgNa9UE0p6rp9vr56t
 HsGomjhdfRudpqCaTdZx2WQd4j3oox7E0vRxoIoJXEGsqAlUAhoWccFZw4RCHlM1pYbl
 HGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746208; x=1793351008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
 b=LWPSbfkbWnbVXMOLVeTtzfEbo2goH9eTz+MdTGuVsD4/2P3Cj2HQQtXGSC9Sq8tcTH
 M2wxGC9R8DOhwzhOZoCwP4+cS8XfmWIwOE/Y+AzHV8LCu1a3iLRoT042GtrP013vPGZt
 6DAPXeXIfSIOcv2ffdwanWq77bBAvwGW+rCIJ/3cU0yOpBrhMvjJc8sU81LV7r62pdU1
 jZW3IgwhOK59j1jsgWu+28KhMTY6pfwo8p6790gbWgx0sUXQPKNJWZZQTyfwEHC3ze4d
 tvxz1/5j2wclo+BGxXl2aoMlPjRNHEiR67pgBFz7At4IPYRQmRsr6fV/BYN2LeMCmeVE
 bhtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3YC6QhS8qp/3BxVP9qm+JDCi+MuW0VOjxnoERpIl4rB5LoKLHpoqKj3ba6cV4gEKq85fs4ukjnIA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjYKCtKHt4z2e8E3fnfQTqTF8dL25H7Br5bNCq7o+mCm2bLcq6
 3CPlqVHLmL225KIYaEmsM8Lh6vnL5xyF46PQfXdgHcp97Q90TqRoTc9T+/fTwobEN6MaA5Q1pXQ
 Ef7SHq5fj4PMLd8WmJF4AjD+nnd8vHF43YRPzxFSk0rLNFzc6FK+NhUdhksLVUuUEW+VHifY=
X-Gm-Gg: AYBFou0GQdKMcJ51QRq3l9bfulVAxoH4lMBNNMlRVj7n70viYSld6CRJDBYmMcrn59g
 DG5pxdDTPaT3ebZ48UZj1P/M3BDM3wCaCJQWPcVz13dcWdWH1fg6OAs5ZtDC2bNy5NfUTFeD3sY
 1tu2eRFVtDXw+z8bczUnIx6bb9puLLxdWil/7evrmssqOzOuqkd3GmsquyatgKcBLiiEVR8BXJY
 hi1TmYgScsn7sN2mbWp2x8O9+1JElMv/BAD+i2iyCJ6HLliuYujm02BxdcwrzZk8mRZwWJSEhAa
 c9mxya9RpNio2NQLt3qJqFgPAIYHJ5mzjrOLVJYULN5rK5OxgEQY+6s6aMHpbDhTXV/4UO5EPvu
 aq8jnZuxmwg9Sx6McpOUvK7rpntL6yKQXUQ==
X-Received: by 2002:a17:90b:1343:b0:3a8:545a:9e87 with SMTP id
 98e67ed59e1d1-3adcdfce5d8mr1244121a91.15.1792746207509; 
 Fri, 23 Oct 2026 02:03:27 -0700 (PDT)
X-Received: by 2002:a17:90b:1343:b0:3a8:545a:9e87 with SMTP id
 98e67ed59e1d1-3adcdfce5d8mr1244091a91.15.1792746206987; 
 Fri, 23 Oct 2026 02:03:26 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:26 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:04 +0530
Message-Id: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pYFlgnR4bXylLzJY0uBliDw8q31hlNtC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX9YgbAW76KG+3
 sbdJ10XTqy1iyi0M9zl+9a3dknGKP5Vb/vKqApQ6VKFDMuCmo0CGRan5+lO/55T3A6r9Hb2O93d
 0ATNuFQxbJgwjEVfCv5VmVhYxCWMMZg=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb22e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tob_Kch83G3grsM8gxYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX/TNt9ba656l7
 igy3mVY4i/pCgR+nkp4Ep8atRe0T2MDcBXdyIoqUIFyZukchkkv91jixyhXoAXBICyHzirDwTho
 hQAOGQA0tbJl3I9Ay3civ6lefLNTFVwCDH1SadeAasEsgle96ph2vCV8bAaaF2p5mpiQ4r1w7la
 CbaLzOF85nV9JFzZtDgnx9M3s/Q7y9F0XMrrz/h0X8oI1D7lXyE+mbIkJGuMbwfeUhynmlZmq2P
 A1vCwT8TQXwjKI6f1NYLx7KJmMKEni5M5ITQwJ04c+UrzbDJI7KALdaOOnjTVFi0p5Io6cF5QWQ
 uzRKkDP0fjew/JtaCb0YmA4X7vk4OtnSl26Sg/qL5ZMU8p1gnmApZkX2j0DjOskZFCpf86T3GV9
 sEhXVqzCAN+HFCbOa9lIAhebNsn2vJ4BVlzGL0e8hY7QkGej/wbrgLGsLOkJ1jkPhR+hiMMEa+b
 9DWjr20ilSu9Q48wHbQ==
X-Proofpoint-ORIG-GUID: pYFlgnR4bXylLzJY0uBliDw8q31hlNtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
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

Remove the compute-cb@9 nodes from Monaco device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224..e73a735f2f13 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -7822,13 +7822,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x19c9 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <0xb>;
-- 
2.34.1

