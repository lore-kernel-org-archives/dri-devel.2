Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F76CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4B810E411;
	Mon, 25 May 2026 06:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TUCiu2l7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bsBORkJ3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6825B10E40F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:21:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P1Bair4120815
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VH17n6noNfw3rfLs2gSqPu
 LuLSe8f67XaN2dj3fT22o=; b=TUCiu2l7F6S2kbpTb0WkJKug5J6GiuM57RyN5X
 IjgqIi4FHRp+MR/mmA9G1K/hGZyD4FfSaA/W9PH2CICB/FPzFxyFQ60SnCUNw+Gh
 b1edEWz5yg+paSzLAnSQy4CejZjE1CRYsNzhJ7Q1TElnIjh0EAPs3OQLyKBm31ho
 nV/MVZUybpvWF8iKtyQAIQX7Yyws1dMymTDqr/Jc9FQeD7snOuFporaBC0TnCs1o
 PkeoUeg5poVTHklap5zzhnEd/j/J82AJ22K6SLDD0JErYoveKW0oSWYTsf1hgVjH
 8KVRsgSUO7I2fr1I5J59n/1x/QloAOCvmXGGHTnn8p2zFtmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fw55f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:21:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b7aba0af02so87587425ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 23:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779690091; x=1780294891;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VH17n6noNfw3rfLs2gSqPuLuLSe8f67XaN2dj3fT22o=;
 b=bsBORkJ34VuLA3/768pfHQ43M+vwn6nItQYEmmaXl1oob1a4D43aU1LjI9A8PQPfkB
 6xUioO+aarYPJGAddQC+qlfZDUWLLdDaw8V/dKo2vZbl/F7M5HM4W5SESaSHW/5BfNn/
 C1TPVyI37dr03ZZjKTA1vPMKzIpAfc3AawM1Oj3GTRahpkPwVwrqdSMxl17llPu9DC2y
 7LKcx+9kEkypROotOteGItT6/idsZtsLOlB/mj3MP9grWo1KOTM8e19UQ5B2s1La+E6+
 TtzGusCjUyYtkyfWBUjkhH6iG1tddCXFeei80yprtNmK+H0XZWBFHTr941j1p8jg4Teb
 Td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779690091; x=1780294891;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VH17n6noNfw3rfLs2gSqPuLuLSe8f67XaN2dj3fT22o=;
 b=V+YpO3MhkZqpntztMPABwOzssdmYWLuPcwbpe8ia9Ec8kU9Yw8kbb8yRjQI6y/ywuj
 CCifAka9Z1nsdl/HKq1I174FHhWepYovKpbRsaRyEgYgKElNdX8XhhS8ehSzovK/VM1G
 jxMlVVGQFtcAcUHgm6hJDBbvmq5Ktkw/LhPwu2lu16b1nNMfTTLtJKggDMNz2Hoz8gro
 JfW4wuZ/UWpRgIbmA2Ei3Lhy2VJM6MhDN30YAfP4n9MiykHp68tgG0JNgQ+rnsoossT8
 A1V5mpNxUy+OpnbJjRRGYQJ9sERsOYp0gd2ZIothnYwdZvBSp8mRzTPlSzrAKpLW1+fr
 0yFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xDY+UNCsire8k4xcOVc4OJfNi7wl7L6HnDCkNpLmyVZSZKT8F1aqyOkO6Y7Fnah2TSn337ryVSwM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbWnEhINrfB6x+mBDHLCqtHqEShNqeL0AmxLiQXg3EVcX80m+x
 y9x6IVDK2La0PF1ZAayyGvBhU+5sh87+xCglKsGWFCQOq7mfaupphzWa9ea3EF0gw1MvPAikFrU
 ybgkc/hH6gyhlI0JiDOXNODKppFS6xSj3rE49Dq9GcSRxGjNZk9ahvzbt8acbzE2shQ9l90ZTNB
 TaaKrc2Q==
X-Gm-Gg: Acq92OGV+k47Nj3RxDcADNo4FUH8WdFX1hn5wz4MruxRwwBIum/NfSgsLgeggIokeyK
 aDn0MePqmFDgB6AKe+1DidA3fRx/7I54xFBl56Xf3wR9+Hwy+GvVPxKSS0uTrcRswYbzHkd73Tg
 5wCgaCY8OnlYzXhy//vfoA8M8rZ+CZe/zY/WpfAeBTD5rHsWYe/JiWzTPp+ppJ8LZ/Mrg/W8eB0
 pzhjOeWVfYy+JcEgPojeZbg/M/1s7TsbPjk7H4mXWfsuh07q7Y6gUXsBZ2/vDGmgYMp2BqFdBKZ
 3QtunfvqO4yNYM5Sq7+XTRSbLvWw9e2U+KmxN6MK5rYzjvqwpL/1RaZ1CH7rGyG6IJkR4f/6lGx
 /3tXbOanZUeP3FQRvVQSW/kaPDfd3anCKNOA6INbm/5kV6SdlN/cm/4pp781NY/roKANqv+IXpU
 M554ELuoruOJJ5wRXobMIK53oZkA==
X-Received: by 2002:a17:903:b0f:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2beb05e2c2amr156259705ad.23.1779690091189; 
 Sun, 24 May 2026 23:21:31 -0700 (PDT)
X-Received: by 2002:a17:903:b0f:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2beb05e2c2amr156259465ad.23.1779690090719; 
 Sun, 24 May 2026 23:21:30 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3cb3sm85722765ad.40.2026.05.24.23.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 23:21:30 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:21:17 +0800
Subject: [PATCH] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFzqE2oC/y2Nyw6CMBBFf4XM2iZtgUr5FcOijxnpgodTNCaEf
 7eKy5Occ+8OGTlhhr7agfGVclrmAupSQRjdfEeRYmHQUhvZKi3I5Y3XICzV3lhFHeoIxV4ZKb1
 /S7ehsHcZhWc3h/HbTyVD/ouMj2d52k77VMMyTWnrq7aVRjbRBOstUuiiNJ0jsk0MtVTGNu7qK
 CLCcBwfZdYpar4AAAA=
X-Change-ID: 20260512-fastrpc-9f3b691f8e2d
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779690087; l=1059;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=SN+gsXJCUTYS3QP/s7Ozjn5Ljc3dX0Asz2QRaKXR+Iw=;
 b=h6LoIVHGzlEZvBo37CVuAx4E3Lvu+iQLPiIfx74gWWVlY60hZc1jGL0nnHP8TnhJrgfrKftqS
 6bKeXwBfygDAejjya+rECANlDVsihwIcYbVv15VNjpYkQQptoxX+4hf
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2MSBTYWx0ZWRfXwte3LdoX1KEA
 qkjJChyvjTg/UKOKLDPJJBO99ZoSWgpvOcCulmhLb+PST5mMwkSZ9MsjtV4LtEusd+nEXG2Injd
 KLhamHYBST5k+LLNKtuxBvWLE9+e4sqk+qgSVC+jiofaTJdNY2MUQnlBtWk3wduoEzmBMywGT/I
 FgkKTN4w6JN9z0zbn3DgXC7movpoqBj5JcKE5AefZ8gI0fGeLrjfCcjQZuIP5K1gI9/gCTXM9aF
 PJPvgg7MbwALV8isJAmP7Hr2wFhoLvEETs9scM+z4+tImIX4RbEQqBVzurOr68ENqIaQWHr7jT4
 Cn4r1YlgFHfHQnoh0Fa0a8/bUWolHcI4uCTs5uJ2R/N21/KloXeSI40ZhzaIGo9dhB//U4vk8JK
 DE/tpmSx0scmNFxh5sQ1fpBpcJXFBJlPLWZ726OTVhP4aK9J4Ci/8MfRYI5WCu7cJQU3cQv+mZo
 4y9nLTkPXhKU7XcBHGQ==
X-Proofpoint-ORIG-GUID: uPpAxL8GfRi-9jzYg3PS5a_QLJ7JG1Xy
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a13ea6b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PmvgEI0Rx0sAJRWD59EA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: uPpAxL8GfRi-9jzYg3PS5a_QLJ7JG1Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250061
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

Document compatible string for the FastRPC interface on the Qualcomm Maili
SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
fallback to Kaanapali.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2876fdd7c6e6..afe52296bf1d 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,glymur-fastrpc
               - qcom,hawi-fastrpc
+              - qcom,maili-fastrpc
           - const: qcom,kaanapali-fastrpc
 
   label:

---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260512-fastrpc-9f3b691f8e2d

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>

