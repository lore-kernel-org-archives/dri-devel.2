Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFE9CCA473
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1985010E046;
	Fri, 16 Oct 2026 05:21:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD97510E046
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:20:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FM69VY2678099
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CMeOnha/3ULmpqySymnxY/
 fHaKJfGvtA31OL5TMEwL4=; b=I6K8tbJd+V+H9u7RSiDr4lOXT9EUXsyVEYv7t1
 YJuUuQf0/K3FnduKIAaZ4b6tVyknbMPziCNL0thh77ex6RaxHaAQ3OrVUj69+19m
 UQIYH9kCREofi9DhG6yH5QbPkq5V2yC8DJay81aw1coz+yBGQr8V7gwkPj6mssGB
 Ymzb4sU/XCaG12F0yN5xtNvypIbVgRl34eQihZh5tj4xazJwVzhUeud/bFl2b2N3
 DU0btvyZU/z8m4RclOcRDoJ6StirCyaJLDdsT6cmCaVGyPaEeHfr7JGsJESIfeI3
 X+MZpsH+tZe9gWt1k/AQZD2v3jKRORgyfTvguvV7B/9hPgcw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tauvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:20:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so23533808c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792128052; x=1792732852;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CMeOnha/3ULmpqySymnxY/fHaKJfGvtA31OL5TMEwL4=;
 b=K4Y4L/61gzuA2dds5S/ZcstDvGN/pUTeJsavTiEQzuOX8crfnEv9gAS3oH3KYkiQLb
 5HRTGPFWDnWpbi5R5ONhcZtESO49VsMo4R8e3/YrIuNl7lh/fKIeVz5KqQq7AluG7/O9
 NnIXnjvuHGdkJW791o4urv+te17UJG+ihTYM88iIgsNe4B20KgRNRJ1fUnDo9yqLL10P
 bruiFt4QMCMpuaBheQR7oFOsPiBuzKZKlh/yvMyhVFzWIkAVQunpZPPu6zY8LBdnAj+t
 5lQD6Vsk6cID6ffAd6LqKLhWh7GH7nRgOWAJf4HRlNcoTCDbx2hyqbxNO5VDBZaHGi1z
 O8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792128052; x=1792732852;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CMeOnha/3ULmpqySymnxY/fHaKJfGvtA31OL5TMEwL4=;
 b=YO3B2fbOS+SG4bwjPkmr+IKdKM2uDvDhBWoA4Semv2g5k3GgXeDauHrtePxPp9kavR
 Q8ZHfPbPI5+XAAmbic6rs4ejPoUH1wA8hRaElZt9Q8Hl9WuElaNrT20GNWQt0YBMFR7S
 R6VFtg9kOtboudeDA5+Y7DHMHcsTc796tjCQ+cWk+685gfgYpbtTRsMzw6Vt1Zmr+tpC
 I64g43rmMX8iIZAGS+7emr6cCZ6enfzuTIqJi6VVmYli92G9JYUF9nD8+zmHETyOPM3J
 nDfHGZr2UdlwMrgmnK2jsw4GbKG3uKO5gwjXEq3Z7I/hbo7/9xwEjiLWqePm000FXbmI
 gKXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByheuQwVNJqlZhJWWcfepmL+6TYgITA+2PXRouNAVO1SeY/HH9hFgysNa2s9r+IkyTUmOvdyuok/q4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5dwWd+juePXnYE+MfmJ8kwlIuEkwY3A+vfxQ6bXNUPBoMSyi8
 6Dl8OwrZaRPALlB5+MxPkSmKXmkRhi085WQmftGC/EQCTpLz9A+BTNd23RtclniVjH3zUz/4T7/
 Q3reMDSJu55Zhs1jhDABaaklJtt5SvMiV9d1Qg27+V8MnU74h/Qwcrendx3n4VU9RGZcyqiQ=
X-Gm-Gg: AYBFou0WvAJvX57Wt6WFj7j92Cuy2zfLrk2I7/to7S82EI11AKAMNQytX+xJi2nbhqz
 giJgZy8bgFjX2XMTABA7OICkiOxs39AwgSkedD5hfc0xqoXCUTbIS8cEMIRkx9PJWDr5BHwlnYu
 sPA3NyqCQwPQdMUsjg0IkV50q+MlpE3T2SMvtGdqXXMONThti1YnybnN8dVQnfMNpUO9Nuvm+rC
 kll5n76is0XMZx02neSSMPSfJgJsk8k48z/+/PDHka3ZiG/LzP2CVL2mxmvaIhWMS/0sjSJtVqp
 2a7xf5kn3I7RRZ5Vbb2iSayo731lsG97FfK2SkEZyeIYqxmTbODpn/gOrrwEhhoKEu2lYq4j0+X
 WQpwqTAHuNsTD2kvJm2EHDAXRKaRC2LsyWQ==
X-Received: by 2002:a05:7022:b051:20b0:17b:fea8:1425 with SMTP id
 a92af1059eb24-17bfea8145fmr12395032c88.30.1792128052219; 
 Thu, 15 Oct 2026 22:20:52 -0700 (PDT)
X-Received: by 2002:a05:7022:b051:20b0:17b:fea8:1425 with SMTP id
 a92af1059eb24-17bfea8145fmr12394998c88.30.1792128051612; 
 Thu, 15 Oct 2026 22:20:51 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36083283478sm2997220eec.29.2026.10.15.22.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 22:20:51 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: [PATCH v1] arm64: dts: qcom: Remove FastRPC compute CB9 entries
Date: Fri, 16 Oct 2026 10:50:42 +0530
Message-Id: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wtXdXynywgZoQxvTqWlqm7DjV6kA1-PS
X-Proofpoint-ORIG-GUID: wtXdXynywgZoQxvTqWlqm7DjV6kA1-PS
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1b435 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zYYqb8WEuwc2w2ptBsEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyMSBTYWx0ZWRfX1kUWYSi5unsM
 1Rj2cdxmTUbnPqvXerQN4O2e9xyFsKyuf/yr9Ww/NG/vYs27U0E2KzsdUctZwZqw6djti62Huu+
 gQxehKW5sj6La21eIyS7TAJP+uxk3CxSlKZi74HjKVQrnuw9jEBciEFbJdKMcm2QB4WyQYRbQ9M
 pQY7PNGEYYKqUTlFwr6sUQz01dUpqY5G6OaVeFOXrpMrGyWGIIkb+5FpCqlT6cmrUgIPhTzd8kF
 Si8tzO4n8JSWCnkC/pnoypDTvq4wO+x8hvpQUzfdxbrFYL/eBVi9RVovPa/cwU3ctAcG6H0/Otq
 +svaTlLJc/LaXgpNCw8sWXnkjjTqaGRi8Si7GiwsztNk0ss54gPhPqjXXP7nlYunm4L1/AL9/dU
 9xEpmF6tyBblAXbU1I9QHjm96z/8nvLmHyO66rAnRMDcP7kqY+OD6A0sio6kWt5hPlYbmYEYEEC
 LNU1IQ4UqsK5wZniouw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyMSBTYWx0ZWRfX0EHTgHO9Z17f
 DhEaxqNvxOKIOr+EdnzpCIUgqvXyWPadEoceiYOuSQmczd3tFlIwAC3xWHJhO2TtOz+7+sN3Zde
 guXtHaiI2b4V7ez8phetGpHtZxNcQns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160021
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

Context bank 9 is reserved for secure use cases and must not be exposed
as a FastRPC compute context bank for non-secure offloading.
 
Remove the compute-cb@9 nodes from the Lemans and Monaco device trees to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
 arch/arm64/boot/dts/qcom/monaco.dtsi |  7 -------
 2 files changed, 23 deletions(-)

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

