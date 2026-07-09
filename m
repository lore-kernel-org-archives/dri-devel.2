Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C37C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F8A10E035;
	Thu,  9 Jul 2026 08:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ld3gzjIR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXDVPlYN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C7A10E035
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:20:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66960Fbq749628
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=LVFbsmyElM/L+CCIqiuiSwvH0ilc0S1tpfB
 Fg/GiJt8=; b=ld3gzjIRPJ/0FJjIIR23GWKMMluSPa4y9e+oshZ+jyyN1Y1Ggyd
 0aqaUo4TOr5w1Iw+xAXDSVrosTR2EmhTfbyZULw9E+PoRmyy/dHIoFLmmygKhhEf
 qST3NFELIOKHWdQeyL9pT8NyxEEDvaJU3dR5/9+lk6raC9SSOfHJuhv6RXtPdwMk
 UcQdjSDhvF2OSb34I3G1/smSLI4deRFdxKuj4YQmEkPGM9wI4YEP1Ui9kddZpycx
 z15xEZQuBmED6Jh8CyxAHyF94z88rIto58AXro8DWKjlrMAsi7izyXS7aqQeMRwk
 YjZR8gO9kVlu0H8i52Ki2n9ihbHskHGD7rw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwft3mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 08:20:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so1714493a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783585249; x=1784190049;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LVFbsmyElM/L+CCIqiuiSwvH0ilc0S1tpfBFg/GiJt8=;
 b=hXDVPlYNGSyL/Gf3Y63ckTwNdO+g3sAQz2PZWQ4DVhZKmAh3DnGNtKdKtgCf07E6oV
 73s8AA4prRpFXQ0SY8BxpvX6B76xsaMlXabcpUkJdp5uM4DicI76hs5O/PSvDKoPaQbg
 xFBpfQQSJ8c8Xx9LdBeiiKZF8oix6pyxs8pRyMshd3kQuS3z4LKegbNub/sSn2lLis7u
 qe5nUBsvdL5rUbLDpBpJfkubH/GK/xMFYRlpnyTw4jmhcnN17kDRyzWjjqNDe4OqQRzI
 p0DhvsjW+dxY/Ef4L4NWh/ZonHEyy/O6y7MQpqYNRSQMH+jq4p6GOz9NqwNY4syrbysP
 tc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783585249; x=1784190049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LVFbsmyElM/L+CCIqiuiSwvH0ilc0S1tpfBFg/GiJt8=;
 b=DdZejqw0EtzO3u9Zka3XdwmhjQ40N1VD2zSfgRd6Sl7nm9zXtaB5JWFkyh8yzXpzWO
 jcyd9IhWih1kmC6QQS65XsK7mLbvtnBTvvca8FVFWknCTyiQIHkfa6fGQ79wB4ukCBtv
 mlC8d4vPEoiK4oaO/Xt91hxnDR9eGmDZzkJxMSkBcu3nCBD6QQLJDPmEug/yfNd3rz/+
 4mNL5WlDs2W+34ElDN/XDbl5qHGJ6AccpbR9L5IUDQeH4BPy1pRPjKQU10gvfdNyO8O3
 4bVJzo+hwIYdgBqS6ARG33ipUbGTWeiWOmtZXgwgpBwqu4Ue1JPqFtWrUgNcAuTPnFVu
 izlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOpfvE2MDxBzIB0HK3MCqquv1udjJNorjfxGkRL3sirqaxBOuf2lWBGHNsGGD96PJli68rP05qkF8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAOBXpUwQ/ADYIJBEPld+LEHte9wPcRi5mMErbbMFh0tMlYsSl
 kPf9WTPqLCN/Xba2P9s0cznn8eHr0/LqpUa1h1PMDMv7UV6+xf3jIhTvVx3xCRtAKHsT2+UjHvL
 Vh4ngNRsrizWR63qtHIOO+h725Bve/8G49IBe9TRcD3/cht5RZDwwOEcfXbU77Q2Xso2z3n4=
X-Gm-Gg: AfdE7cm9K9MRfOMAdHrMYUXsJhfZiVGky+6lzN2ilCZ1q0riZQ78qUqz76pqEx6kSU6
 sWf6NazEOewqi309cD7LSJUBevYsX6nCq0JFZy8knp9ST8y242Wg6nYajjxQqdeossVeOoMBGwm
 4XOGvDIY0Tv7E1bgKTo8A0TiCG0bGJmUMDtMTWqhTiHUW9Xh9P/JSiY6slQE9twT93CEwc7Ynox
 PhCC4+ibg7j+/hROhn0FLUSI1OQGx8VFLGfhNbZU16XilhM9xCAfiFA9LinfXoV2qDTXVPbRT6/
 5uVCjoKN09bCvHzAx8QwY9H/T2KLbKqWzeUJV8/q09Fe0T3xTcCIhCXBah5mmbvqqw4LargMTMX
 E5be66r/kvbrZyToy5spRzp590gcIim/duT7z3Fl5fbzSfLZxjgpKvnylhxqnBFLdMsvjzck=
X-Received: by 2002:a05:6a00:399d:b0:848:31fb:43d9 with SMTP id
 d2e1a72fcca58-84842f9fe29mr6182877b3a.45.1783585249008; 
 Thu, 09 Jul 2026 01:20:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:399d:b0:848:31fb:43d9 with SMTP id
 d2e1a72fcca58-84842f9fe29mr6182846b3a.45.1783585248485; 
 Thu, 09 Jul 2026 01:20:48 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com.
 [199.106.103.52]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6dbfd41sm8323523b3a.57.2026.07.09.01.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:20:48 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
Date: Thu,  9 Jul 2026 16:20:40 +0800
Message-ID: <20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3OCBTYWx0ZWRfX3Pa5WhBSnNTf
 i5Vg2093n8O5i76y6vYd/dvZyhH6lZguYeiYKTgO8dKX+e+ppSM88edEHYQo9hmHZz/vW9PGaBL
 WjEdNiMIbcojVDmyGWkRxG35SKOhd+81C5TJa4xBdybrDwdzKvy+bpZuKK7qVeAliTii3um0UrY
 BX96fveGcJN1AY3BHichm2hGdQbIZ4e4qUxKVbW8u0jwje3AkjysAIP64tAC69lafBHzPTLLzhu
 mfEcVEjkCfKTPibuibip7JJLaltWj4ZV0Ce7bRoiv/LrAGcYBy2gHlbPOAnnDW3BgoG6AWnwJPm
 j6VytF3hoTe3ltSaOkAfM2XtvcUxN0Swv2TiliaAuA9az/r5kb7hx2NHQlL+3nS/XhYnizUG4Rz
 rcJFR2rwRMEkJErOVZ+nIh+KBoD8X7nBP8eIDglxSXK6bdJOXKqwg7OYPNW0YyZJUhb+HY4b68N
 8WLroDn5Mb2gB6WaQig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3OCBTYWx0ZWRfX0DF3YQFEbrVm
 aVn4AvqmmOrTMaM7gfrPTejScTqQaPvs+sceJLFafFt17jFaRYh9SFYr8f9Q2EW3OQ0kgJULX05
 L3ybUxanh35MJpNgqdo3sr5+0GXkNuY=
X-Proofpoint-ORIG-GUID: IyshY25gKV9GM7v_8XQoAAjbv9G_6lj7
X-Proofpoint-GUID: IyshY25gKV9GM7v_8XQoAAjbv9G_6lj7
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f59e1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=v9Ym3Pauzs3pF5Qw1NMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090078
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

Add compatible for Qualcomm Nord FastRPC which is compatible with
Kaanapali FastRPC.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2876fdd7c6e6..24fc0752c11a 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,glymur-fastrpc
               - qcom,hawi-fastrpc
+              - qcom,nord-fastrpc
           - const: qcom,kaanapali-fastrpc
 
   label:
-- 
2.43.0

