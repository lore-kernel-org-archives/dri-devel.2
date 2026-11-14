Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E89606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I1BJ9Ej2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jNTzPoUW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16AD410E2B8;
	Sat, 14 Nov 2026 17:55:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE4C210E2B8
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEHpcaO2718826
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ypaNDTkykj50DMxDhN5W20
 Hg9WT0vYVFy5lXvRf87JQ=; b=I1BJ9Ej2BKfPwaryBVNR5KD+hlB4lYjAN2ybzi
 fqiWTiUQ660R+q3Aybg3fKDWh2I8SOWdp4mX52yeheyb5pI2MWITu7pwqodi/rGX
 QTzvTeiEPSIg2IX7moEueZIRXQmKU0IFROhW2zfe2IpiWXxiUnXL3QdtmeCoqLvb
 7SAi1UQUjnpEgMsuxCLxjNRqIBgtfYxags3OQMx9dxPKk9WY7a0mSoZ4mZDg2Pbx
 lU/tGOwCQ1J4AcT5m+Mn7j+0rI793HJ0bHpg2gfmtU390465iYhfDkgMTMHkOOvM
 bVwaFL7Wiq9/sQeb97JWFG1YLrmZcRhvS++mYctU8Pfk6FWA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj41d8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so434474185a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794678889; x=1795283689;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ypaNDTkykj50DMxDhN5W20Hg9WT0vYVFy5lXvRf87JQ=;
 b=jNTzPoUWgIuqZ5Fxu4es2OakHNeh3ihtkUxSpiYzw3gwyKSHTCavT754/5DXVXMpl7
 6HfLy39cQEhnwVr9NsDt9wIhOsJXhj2X5Cr4XbKVoC6nNk1o/xArQS7cWwinyxaLZdwR
 LZzeuyOkgfaS+3G53w/3CktGztcfMF6bZ3Hg0pRObxLSZ1nLvCrsNra+RvqHpJnzQoI7
 gkP97jH89ZpxjIhuU1TccWXRXBYnxyGl2OWjf5kVBWs/2EBQLsE3lREYRR30+3+t9QJs
 gQgwkbu9+anPQwUnhm92S4PtclDWgTQpbbhWdFikpYwT4YkcWrhgHI//dsxTsn5bgIjh
 MzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678889; x=1795283689;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ypaNDTkykj50DMxDhN5W20Hg9WT0vYVFy5lXvRf87JQ=;
 b=L/mpio3ywdtD5jmyd7/kubow7JvuuMVwL++ReUHZfs7/oGrTG+tJjM10XGipACbMq5
 3kcoBJlBHKaqcg2df3ZGgt0YsMXQ8gZc8iq1lWMXjc7boiT9BoZ/kmlkfl7oHlO8MVh9
 Rh9q9qCo1oIs7QEUKzfzubWjJVKGSIe6+Vugaxv4kE1c9N2ZfECralw439L45g63EoJn
 CToW+QoRDUTr4SDl7RyPzyjNYvJqtSCQaM95LaKrJhIz5BahSlBeasHOQH71FBGJ8zdS
 2KQvSJIzTeN7G5aiKTZ6Jr7x4Hik5crCjYdkau56l9eYbaqn1hfL0uJeqbnd2yQgZYKw
 J9yg==
X-Forwarded-Encrypted: i=1;
 AL+hErH22R1o799BOhwcNdCiN1J3FYk5WesMZQUgOAkLj9Y90jexmboFzpiAwXJj1c8LYnBnyGU8bOhZaNM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/hjXrVAwYJo1COstEj13Qud2zuoI0ulwBopAOsrgDLXspZgPHT
 HFscxxXZ4SrrGAN8Q4LUdVpvC5YbxXOayaCRQQmPaBdB4MoHoX1mURIYiMKdWMC8PDcp+G0/GU3
 PqjbW5nNx37A3RKoi6384NsPKOpnCP9qDAwXUfF8uYDkjO4VOdAwW4d3dS5rr5QNIbxOOYMo=
X-Gm-Gg: AYBFou1kCbiscpBCb0W+gklcNFE1p+9Bq05QZUDLoppunaUbLVVgl/y5ttj+/CofqHP
 Lf/yYsbN3p3clacSYv1+Uv4zhDIR0bh6ruHpeAE/Vhv2tCwS6j7FLNoVVyk3WyM05QMdNQ8o4oA
 WOmU6kkKHLiIPQnX7sETycNVZ77T9U2gOFAgGAWsoThF6PMwbIWcPMWMtwNVChX5lLPYZWjDRSB
 40CTV1hIate/Dtm75UC2+GEaHZXbeELiFlM1odopNMwsX50eVnHJQQocSHWgZRndbo9vyMkAc0m
 ZjpBE9S6sZnqp6Yis0JCiZjCe0cBIGdLwd48SHKstSX7YaDLKoL340TAfQFmZnhD/WINDdV6riJ
 +nlh4Zr1mOv00x9Uo2SNmZgNJTgHYbk/3uHjDCUepWwMRrEymZDf1aOpttRs2AbY47NVfjA==
X-Received: by 2002:a05:620a:4012:b0:93e:6f43:b2c1 with SMTP id
 af79cd13be357-9494bb85888mr1013008285a.16.1794678888699; 
 Sat, 14 Nov 2026 09:54:48 -0800 (PST)
X-Received: by 2002:a05:620a:4012:b0:93e:6f43:b2c1 with SMTP id
 af79cd13be357-9494bb85888mr1013004885a.16.1794678888165; 
 Sat, 14 Nov 2026 09:54:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm11060292f8f.9.2026.11.14.09.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:54:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 0/4] arm: qcom: display/msm: Require DSI graph endpoint
Date: Sat, 14 Nov 2026 18:54:35 +0100
Message-Id: <20261114-display-msm-of-graph-v4-0-b8de044c6c1b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ7CIBAF0KsY1mIYirS68h7GBQXGYmypjDYa0
 7tLdePCxs0kP/nz/pORT8ET2y6eLPkhUIhdDmq5YLYx3dHz4HJmUkgNAIK7QP3ZPHhLLY/Ij8n
 0DTeiArO2GlStWH7tk8dwf7P7wyfTrT55e52sqdEEusb0eO8OMPX+TAzABRdYgNBYQVmrXSRaX
 W7mbGPbrvJh09Igvy2YsWS20GGFblOi2rgZq/i25IxVZKtEJ6zQ3mqHP6xxHF9clSk+aQEAAA=
 =
X-Change-ID: 20261110-display-msm-of-graph-a081a5c614b4
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zGi4k/Gj3ijKyZBujv0aWejXJjnkHLrzLQhAr2kTbFw=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGr4oF6iONK+bdCSxG6Yxlzhx4YpjzBBXcTSQG7c0b/gJIoku
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJq+KBeAAoJEME3ZuaGi4PXQkIQAILc
 UceKi8f4MJpOmafTP6h5JM4/OeMekgPZtYL7Ou51kMK7Dm7f4X8DM92sO72o4tTq4XxLMfCdtgE
 laG1cweQhuVBZ9CGojJeIWKTIQCiJPWKYMTjJu6T5zhlOFFiKRMmapYLrwaV15JDrQIcS334rhB
 qQ5/otZVESnOS49xVKgVGupfetLhHalnbum3FBJ6mhLXvzxd353U8VzEWWketR7W3oyUpVp53wH
 FH+e3i8GBEPGr05MuOOzk7ZHVXMqiuGzc8/Rc9fBBpR1A4+uHd9ZQp85xE6Y3z7ZDYHDBLe+jox
 deExQx1kgqzEqKmjS842ob/1PAfJsOXLA1CcUR0WSiQXfUwAo4zW+oYXpoN3WOU96KzdzGat/Wx
 g3tHCpyPbcCSGvE3Ob2XN6U7/WHiwPGdUY4qd6yqOjrN1n185bP9/6GUYQnh8v6bWt0iR7givjt
 THFmjXzhO2uOW8Uoc/asCuMIyTqSmg4W3dVqD7DLMrW8CyC95DGUElJiLqy4wWM2skXFCFHAWGa
 oCVmaRjIgUed8aStElj8i6JRvqRLsBEcGnLgyPnJdQcoS1IZCGHqLMKsTwAUlYD/rQhlBThHdev
 06nVStfD8zvJAihwDJXxhfid440bN3H+IX2YV/ZVTU/2HKXF6VZarwfrpegKysFpf3WxVaWRr91
 1qfqu
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX/oJ6yh/WoBU0
 LSc8zbd9zZWyJ0vwIz0G1T7BcXuIDvzfmFVmW8ok3RCSOwBnJKBQ6jLQE8HtJK32mdypYc+9Fcw
 rxfax5hBMR3IFDY7pp1zMLHir1J6qmr8nKn7bAGnlLMM8kjEjzrYZosuz8vFgkxLCCYm5HucMS8
 sxcj1M7zx1JxmArSpjy2NJcwOBTsASSqFyvqQNExKevlyUzZ45xvIcUl9aLNy6t5BEJfyHGokVo
 LRm2CzkoGtA4rbBD1fjTHyVm7yIDuBLo309zpA2zkPHYXD1KjfaY0viV3xFC3XatVY62Edo4/fQ
 Gg5fsYvHwurMBdTDxyghY6YMVcXmbFM1RcbQpfA1x1xCA/KQS37wA5rFM+7GME2nvTibD+/Rz/r
 YfSN6CSwmRkPMRTy1mMQoqhAou6WIIQbMmv9h0G8X+JC4+9bJYozq3ZTvv/Y59U7YkD3EALLyXm
 /SwZjrUqzzjP3GYDyyw==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af8a069 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_iFXmH2w7s5zJ4zlvgEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: CYF2qd2_ZGetm-30Y9pKR7hMrvJ0wqai
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX+2phB8dDw7ND
 0TDhYvZq7LyFBPjK3KgOXtdOWaf7oiuE+7edL7t74WqXYzih9MgUGjVY/YmD2fb6wV7TUUUhpDT
 rMAB8FWZeAfiu/2ae8UsSdJcstrL1mM=
X-Proofpoint-ORIG-GUID: CYF2qd2_ZGetm-30Y9pKR7hMrvJ0wqai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140071
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DTS can be applied as is. After that, the bindings can go independently.

Changes in v4:
- Add new patch #3 for msm8996pro-scorpio.
- Link to v3: https://patch.msgid.link/20261112-display-msm-of-graph-v3-0-7fd0c06ec6df@oss.qualcomm.com

Changes in v3:
- Add missing mdss_dsi0 to apq8016 (patch #1)
- Adjust commit msg (no probe failure) of patch #2
- Link to v2: https://patch.msgid.link/20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com

Changes in v2:
- Patch #1: Update also apq8016
- Link to v1: https://patch.msgid.link/20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com

Qualcomm DSI display drivers won't work without proper endpoint, so be
explicit about this in the bindings, so we can validate the DTS
properly.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      arm64: dts: qcom: msm8916: Disable disconnected DSI
      arm64: dts: qcom: msm8996-oneplus: Disable disconnected DSI
      arm64: dts: qcom: msm8996pro-scorpio: Disable disconnected DSI
      dt-bindings: display/msm: Require DSI graph endpoint

 .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 6 ++++++
 .../devicetree/bindings/display/msm/qcom,milos-mdss.yaml          | 1 +
 .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml        | 2 ++
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml        | 1 +
 .../devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml        | 4 +++-
 .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml        | 8 ++++++--
 .../devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml       | 2 ++
 .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sc8180x-mdss.yaml        | 2 ++
 .../devicetree/bindings/display/msm/qcom,sdm670-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml         | 1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                          | 8 ++++++++
 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts             | 8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts              | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts                | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts                 | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts            | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi              | 2 --
 arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts            | 8 ++++++++
 34 files changed, 100 insertions(+), 5 deletions(-)
---
base-commit: a547b4b87c936ba23a6794128abab0a67c512cd1
change-id: 20261110-display-msm-of-graph-a081a5c614b4

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

