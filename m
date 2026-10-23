Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC180606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJ/LqxFH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOm412+n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451CA10E5F0;
	Fri, 23 Oct 2026 09:04:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389F810E5D8
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FOwa1048397
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zizJUYpF90I
 cu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=; b=hJ/LqxFHflNTHadd//qNX5plcNF
 qo+hG3Jl0Hv2usG9aarPvOGXDkQS7QbJjC29isFGxQTMGuDurPIOM2X0zyil74fq
 G82o6puo5002gvp7InM5G9aKCVpou5uL4CVJtOmzQfjIOqzoik8nLlcWvpewIHkc
 bMw6wQJBLOy/glPuKuvO08FIUytOQc4LMwzHBrHdpEuSola/UZyWNVUjejm17hjS
 zx3kwHB11uU6qV60qM7pd5vhHI+yPx9gBidMnn5xVHJcTy4xjXwEyMfFs2+Re+aX
 CTahl/YpUyxOSQg+se2V+hLKTuQaDNG137LZHJxWf7kFU6qc74rpQl+zyXA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjwve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso382361a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746212; x=1793351012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
 b=JOm412+nF59qgIju8eWLl9I994oG94+0ysrNjkvBNb0M3noZqTd7PUoDS1hG42bxOu
 q0rqhNXYdECvG9AISZeAkj0TSxxmaFi4rSqrp5uFz7YiFditXUE5BcsvaKgnQnqohUCS
 HySjtx0l44A/vrz2nkGbGVwZiO2ukqzrgq875LY178PBMmE1RMxg5bTWVP7uwj56GnNm
 W5xYxAC8rZXkvFWvyZRHRV0/Ld3ZM8XYmqjeYLyYynm18NzOccPw2R/5fE8t9UV5fVhH
 ARFvQBR2/ji88VzlL1UKjz4WkXXFQy1wGLe3Mt2GR0K60WJM47tnaP9zOlH8OadH2qjH
 yBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746212; x=1793351012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
 b=CpgN7rTBIp9rSBkVBWVKJ46WzRsQhv6mIS2bgEOUq8/0RJ+4Q4XgW5UbdphMWLsxYt
 Pnio/Ccd2WSqbBupBwDb2fZx7/o+QOlTlWX+Ehi31IyWlFakIIeruPAJ2ynoHDoez8e1
 2PauujLF/jsycNqbs4tkXUSpMoK3v8LQRj4ZvroyXjMMwF+L4M1a8TJimSiMkkWaLzR2
 RkyJcZSMjDZBhb6E3lW4d+BMiyc+9GxLQ1O4CBWqj9MeYRYZChgo6Ny3jVC2bIDs+NoS
 Lh5LOVohD2a/NwUsUcuMZ50ADpXZKkfks/wHcvTrVg3MsK13Jhi9z0KgZBY9LGEXjgxw
 AZAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNPZCMzpTdiMsUHCGp/rMwUqwG1IBx4Y4HhliLHJf+BMOGOAMifUqEkP1rjSSFyOvgnpRf8s5TNG4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfoiADlNsjTK9U2DcEe7ZyModSMS9fPcAE+0GrXk0bWBpjy8X4
 X0dB2Nm/W6k2ML84h5livsN44F2+MBtreajsZvLfspUby+H+ll3vVwwiE6rAVipqcb1RuyVrcbR
 kmT1hyKXORHqoqq8dSg+QCF5SleLmNik/fHEi57FvHPJZDKPTNkl1+TwVbDbG+500jlrOkWo=
X-Gm-Gg: AYBFou1ctTIvKmfLLlEN/746Je+JFTnIIZIyhbfik0nYmI6dvUDBxLus1vSYx8ySKpl
 DPQefh7C/qM9dhXiXB1DiPM2ecDWSRwpaMJ+D154QReaf/9ShAOt9RQu3SJo6ywse3qjrcQhZbe
 dFx4t8IHSe79LN0oQzswhDhmoD4EYCys2+FVvrqRxZyKTLTjFPMKCvJX2omD2wzGoKDf2XyS+pl
 IiBuWv+KA5nCgJWBYV2ZzY+Z06dNssWwus69J6+dM45e7PdhVF2I4poyv2Roe5nYwxYmjyE0xQs
 jchbMgBnDrFTlWqsYNM0Ger1LcKU6XKkED0qNnth8yYaVmH0UzJaHYlrYdd0u5GiZBCBKasBPD3
 1Z0FjmTZTPWhQEk7x/D4K94L55czsADduCw==
X-Received: by 2002:a05:6300:618d:b0:3e2:91f1:3878 with SMTP id
 adf61e73a8af0-3e359a416efmr1359351637.10.1792746212370; 
 Fri, 23 Oct 2026 02:03:32 -0700 (PDT)
X-Received: by 2002:a05:6300:618d:b0:3e2:91f1:3878 with SMTP id
 adf61e73a8af0-3e359a416efmr1359311637.10.1792746211896; 
 Fri, 23 Oct 2026 02:03:31 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:31 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:05 +0530
Message-Id: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXwlGu+u2SrGla
 Sben09ewzJMSXwJKBoRqv4EZ8/w2Iu/+ucy8ZV01of17DDIC7ve8kBsNb9UlTwNNTNvlFIOPLaE
 zdKI/fO4sg+AON8IyHNw1x0URAsI5/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX5VRVLXRr0lrN
 wdEzFWWEHliDRl9+PJIQO3p2+pA+Nc4oZXhjK2E80ia76e8crCboF+alJ0Rgo3T/E1lz+F4HlcC
 oZebVuriwzm6IsS185Wu29l5nff46MtA84inurg6MDIEyXB3ttOWmBlxeTIPtGTBGAK2yxe6LOu
 yeNptRrvvZcvMWbHL+bZ1IVPf/VlHseeNuqiVy+ekfGYAvS4MjjMkrB/JBUVZGOtu3EUAe1LLFq
 xDY10zGOx3wc4MNTmc1RwYPYtvctv7bLDLzEWTGkEK0pxXy0PBFvTdu2Ju/bW2GCDaPDbzlFoMp
 UxqDIiTv3mvUCcr7/n6mbsznqjQVy9GSAAhtzXtE36md2Lvf2Rck9iAyN8NJZuoBa/QBwc0+P5w
 3cZpMTo+G94GwstLjpFnCLr8vOt7uJzZ4HuqGaVR+LvC55zRmk6pxqXq8P6H59R9NfVKWUNFtwZ
 q8iKrXsObj+4P20qyGw==
X-Proofpoint-ORIG-GUID: 5nwyQVAcpYxWTwNCapWqS5YtDKPP_K6y
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb22e5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PKVKsYk1ooiKBYXMgQMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 5nwyQVAcpYxWTwNCapWqS5YtDKPP_K6y
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

Remove the compute-cb@9 nodes from sc8280xp device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fbcfd3883bbb..3a26377aac5c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -6279,12 +6279,6 @@ compute-cb@8 {
 						iommus = <&apps_smmu 0x3188 0x0420>;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x318b 0x0420>;
-					};
-
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

