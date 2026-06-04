Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B5DCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F4010E3F5;
	Thu,  4 Jun 2026 08:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfWgm0ru";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0jHcrTV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2851410E3F5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:07:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543YqMS1994316
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 08:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 61PQyy4C6QpV3imW0J6BGaQpSZ8+cchsOaIwpKwWfAY=; b=CfWgm0ruK3Ws4/cq
 fe9Rz0fzfRAXiZG57QYctG/b0XUmBCrl60JWrwQeTUOS1sxwhaFk3S9JQzIi7iga
 TU3wIWhbkwoUxMj62mM3Dc/jEpJO9QcoJmU9X1o0QCKrSLzg6qSCQruflN62qeFz
 tic7sqwCj8+NSpSUwo77C/ZyGUp3DERxXZIrcEPXPUEhx74MTAVoY8yjTQ1nGFNZ
 IgSl8Z82QyJohCFwdPaf35bOEkvizJz/tE24hgDRf+/EltMYm+t4CaH0tm5Fj5q7
 rqUQSV5QPoTZFd9itw2YeODG9xL+TyKVA0Inr96uPQqyFvd+HbBT6UnBeI1ntscz
 +IVFWQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8ptmjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 08:07:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915737aaf0bso11692785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780560472; x=1781165272;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=61PQyy4C6QpV3imW0J6BGaQpSZ8+cchsOaIwpKwWfAY=;
 b=R0jHcrTVHmsl/qPbYMSvHVYXsK6+upXMnMtQ7athtjEmGq+am2yGb34G7jrsMjuKdr
 AJYzio1fJYbfIcB+yeJ1RMM0gOd/gzne9d+hMiL0pKsLqCA5PMHs6mJaLdV/vuExRCX+
 pTrsp6SvBkTNCpSldPmmEl/CTWGGScv/I4DhlCuivuw0ReJiv7rEznDIgMnOmHGk1axR
 qDHMXmA4hCembw/ZmhBfWAl8T7WeWVhiDvZUpZQ1bBqPkhMGLVABbSibhG2d0iKehvk9
 Skbw4XDwW1dTziR53UJzxI+yzGS7bZpERVxzdbNs3rl+ueXyOggN2q0V2ky+IzIDiW6/
 gLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780560472; x=1781165272;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=61PQyy4C6QpV3imW0J6BGaQpSZ8+cchsOaIwpKwWfAY=;
 b=opG0pc2DQeWVCZXgjOT0tOw3NmuH1n4tYKJ1dMUrY9QYPTxHCowBqU8+oVqovkcljA
 RYWCLOusl4xo+RNWyRS3ewH1Upkbotyd7u7v6Qmg7CLT4uedHRIrnaVqJLgbS2vY/46j
 l1SnBDzHJuqzwGM448xaz3fUfD+35yzXtfh85LwQH3P7C//V+CCd87+jjFKboBrw5/6F
 nYsw1cH9K2NNpqFTS2PuFp7dlgKPc4kLSbSXf0kEsk1OM3NhtzNwQ8H2IZ+EgmZ4gwI9
 0+OXW2zDgWa41NKesMbm19UDpKLEuIcuiZV2XPlnKt4y0K3Fana2vFIQ9v0Hotk3rz+L
 6eTA==
X-Gm-Message-State: AOJu0Yw8Ji9MtMkKIVhMCKKli9O07LYet0H7YN0eKaRcWL8bU+EAAuXM
 YrdhZotSG/oGntE1+FceLo/B+VqorCg5xehvC983dS1+8J7AFLfCW5OjjNCHQwGfwUJrcF8hFV8
 N71E7dTHwX6XbqCS2Q8Gek3FdFZdJZV4UZ9cAkgrnv6O7tw+Q61udYXfBKhF7fOqZCUm5yps=
X-Gm-Gg: Acq92OF1MNzRJrkrgodMVRBNj2m8h8pBez27AB+kFglhgbGZgTikpG78/j12bVZ8f27
 S4ooDBLGL9dEn1SE47kuk8y2xN2qm6wfQ9hhpsAiP1Y6ZmXrqzxLIriUGOQUy7CjKgPgLaJ+SON
 Ehy+eIJUwfCm5+u0t5WzRrB7amR4Nf/hYyEn3gbtyeNFDYIe6rv0F0ZFE9ih+a5TWsMigG5LXJc
 /9uzwbUeZcnotkYeXXa9rEhtX9wUcYwDPDkfvBGwYH8sb3y1aY+HxkPLWrlZv6aXsWs3njaJcPL
 X5po+wF1vju612yhheejEUlIN4pX1p6tZHnBFV4wnarBkvM3a+Z5KMkDZSUAhBF6HhyDgszIAGa
 WTN9lgbX18QggjvVca5j3vw2W0j7eZxvMzN5QGR1gzvEYU96XWcObEB0LgtX6gEf85KSGIjb72p
 8nsXvPLq2o
X-Received: by 2002:a05:620a:4406:b0:8ee:f43a:bb63 with SMTP id
 af79cd13be357-91589e9f107mr763056085a.0.1780560472092; 
 Thu, 04 Jun 2026 01:07:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4406:b0:8ee:f43a:bb63 with SMTP id
 af79cd13be357-91589e9f107mr763048985a.0.1780560470457; 
 Thu, 04 Jun 2026 01:07:50 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com (public.toolboxoffice.it.
 [213.215.163.27]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm272304366b.26.2026.06.04.01.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 01:07:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 10:06:54 +0200
Subject: [PATCH 1/4] dt-bindings: display: panel: samsung,atna33xc20: Add
 ATNA40HQ08-0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
In-Reply-To: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780560429; l=2628;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=5O6Xa4y0fRL3DY8QrCMxGJm7vbQjen4MmAX43kAt6RM=;
 b=rLMvjG7mqjoAENyW81aGwEM+FFL2OYknMHLQLduGD2E0KnvZ4OUtUjeUdI70qzYVYz+UItdq1
 FRcQcByBwnGDy4JTbwneLSLgnPawBQoRAtekYIyAbCEIasSsghyjBaX
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Proofpoint-ORIG-GUID: 1q-TYo43-p6xBE68wwZ4-JQuXWbsiN8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA3OCBTYWx0ZWRfX4TawAIPLVxkO
 GxFhYFjK7r9i4sfX15ZQjMqA4b8/NkuJMw8mfQThmFo/iLPJgkalJJygLrrSAqTVmMMkAQKensD
 joOrJI+lHBXgFBkdt8Vxy0/EX4DVC5Rjq34/ExPYokR0e7DFQer62t2jDVMEIcWmfcwdV3YteFf
 AyvUo4JTkaRxah1sSUCbjmjraMa9i+/XHtHjcLm/WrLEK+Iylp/IA+Yd34CddsuXysvoHYUJ82n
 kCeT7uBUctzzEmt1BHjya72ZNn0nnuXhkQKbwLJOMJ6rolLCOMxF9sHHnmCXDCOI2MlglT1tXyu
 2EQL9wjj/DEvV8hIeXcgtzTWJBhwaiHHLM6YsvjGF65b60gEERqrbVcDR3hKVP4FQCN/+VNdYQt
 jhUK/X1qhtpIqou7mh7b71B58t6tBY8m9nMF+52vB1JW7Sthe54IdAsnYYh1QSlSQYULtH1lioA
 w6BM1vbaOSeJ712eSHg==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a213259 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZJ8lwXEUdTpOK_Y3SCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 1q-TYo43-p6xBE68wwZ4-JQuXWbsiN8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040078
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

Some variants of the Qualcomm Snapdragon X2 Elite-based Lenovo Yoga
Slim 7x Gen11 laptop ship with a Samsung ATNA40HQ08-0 2880x1800 120 Hz
OLED panel which seems to be compatible with the other ATNAxxx panels,
document it.

Note that I stripped the -0 suffix from the compatible, as it seems to
be of little importance and some sources omit it.

EDID:
0000000 ff00 ffff ffff 00ff 834c 422f 002f 0000
0000010 2300 0401 1eb5 7813 6603 ae85 3851 24b9
0000020 500a 0054 0000 0101 0101 0101 0101 0101
0000030 0101 0101 0101 0000 0000 0000 0000 0000
0000040 0000 0000 0000 0000 0000 fd00 1e00 e678
0000050 47e6 0a01 2020 2020 2020 0000 fe00 5300
0000060 4344 2020 2020 2020 2020 2020 0000 fc00
0000070 4100 4e54 3441 4830 3051 2d38 2030 c402
0000080 2070 0279 2000 1800 1200 2ffb 0042 0000
0000090 0000 0c23 5441 414e 3034 5148 3830 302d
00000a0 0021 ca1d 5e0b 4007 080b 0007 7ae5 8551
00000b0 b9a3 024a 020a 5445 5fd0 644c 4400 7823
00000c0 0026 0609 0000 0000 5000 0000 0022 0014
00000d0 0ad4 3f85 c70b 0700 1f00 0700 7707 4f00
00000e0 0f00 2e00 0600 4500 5fd0 644c 002b 270c
00000f0 1e00 0077 2700 1e00 003b 0000 0000 9085
0000100 2070 0079 2200 1400 d400 050a 0b3f 00c7
0000110 0007 001f 0707 07f7 07cf 000f 0081 731f
0000120 001a 0300 1e5b 0078 8fa0 6a02 7802 0000
0000130 0000 e38d 8005 e600 0506 8f01 016a 0000
0000140 0000 0000 0000 0000 0000 0000 0000 0000
0000150 0000 0000 0000 0000 0000 0000 0000 0000
0000160 0000 0000 0000 0000 0000 0000 0000 0000
0000170 0000 0000 0000 0000 0000 0000 0000 900f

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 1bbe0da3997c3b06eccd18fe8980b58a6c05d963..27536eeaed8594c047dd0fa1cf425912be189508 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -25,6 +25,8 @@ properties:
               - samsung,atna40ct06
               # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
               - samsung,atna40cu11
+              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
+              - samsung,atna40hq08
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
               - samsung,atna40yk20
               # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel

-- 
2.54.0

