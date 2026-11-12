Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D1606A884
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VSBgfG3B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DIoWNtT+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F27A10EA14;
	Thu, 12 Nov 2026 15:02:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901FB10E623
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACBEXD13477246
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xWn5f0LXvPfccgqP5IckP9
 cPc4GfBcu0p1HOXp4x4hQ=; b=VSBgfG3ByO/PT0jOgTQ73/OZt1HMy9/MF91MqT
 NAjQJBrr3b0qa5YC7EvcIPtLs5JJbFiRZ6yxPvUUqXZst9APtwQgpICTwcmv0NXy
 iRJSFW+P83x+XPz0h8szh8r4/2iG1U7K8fzvUU4skuxFt89H6fW0S/LKm+XIZvvr
 cvSzOJ25/0yPaRTrD9DrPWkGlglPSoQvmnwuCM6Brrk0OVmh2bMJqFwBi5ksFi+H
 WKtq8xq4AyB1fX9d8dBXWqgHM+aZK8yPaXaifMSoi3oUiK3mWil57viylPPGYShL
 mPYhNXOPHtVfCYw78FtMAccN3iPzs9TAYfGaXTY8GnrqfTjA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuj2qf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:15 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5e93fab204bso4216964e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794495735; x=1795100535;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xWn5f0LXvPfccgqP5IckP9cPc4GfBcu0p1HOXp4x4hQ=;
 b=DIoWNtT+mosaM7Vh/ocmcW5FNQM9PifiYnpCmClgcEBRfyu0qfLxIhEWDaNer40s6n
 hx78ap6zl8f0IoLUMZIMMOHEjbWd96l8zxmEllOcBxLOgh7skI3E5I7SV94Uya0f8C9r
 au9Zupd8dz0CAcIq7SMj8+4t4xHcgZEJ3uRktN8A0bpUbHm+l+Y/I6ZmuAh3W9pj/V/w
 irRdLsokHllHBFetaEIJc1YtliJHNOz2Bts2tDG0JJAMyyZIi24RE40gRJu4k7fPAxp/
 k9PnjtDcvIrmE1H2HIHal7wkxHvmBhzputEJKbd+oLrN/LoiudRfWfP5JDZAf9+jMz1f
 vVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794495735; x=1795100535;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xWn5f0LXvPfccgqP5IckP9cPc4GfBcu0p1HOXp4x4hQ=;
 b=vVFCx1neOEFVZxzVPe/47oDIui+cu8iPMlSC+UU22INEhCIHYng513J6p4Nnl8c8YH
 79LLaYPOEqZMpwUbiqfTF+eBvw4RNawPVep+Ju3K9wdc0LXWw1Lu0kWIO1mAPJ2zk9S4
 TRc1x4luGx4UoCghvO0zsCJTzBScDfwRw1l7tJY+YH+sHJZR4jGtA7gQidUnf1CbRUWQ
 mL9sYPaiPq3RmVX86oIZxgzYq8rHVz852ykqLsoYGZFEXFOlk8JcnDEs6wh60945AYXP
 q45BpJsw1HzJrJuDK1wGPrlEWKXaERo0HYwdNXfJg63tTQa8ttg9bEC12RDND6+94+gh
 Eebg==
X-Forwarded-Encrypted: i=1;
 AL+hErFSouU+ihLGNLFf4sIksubHTRYHj8zOlqO+rgJPQyUowtUBYhBAvz1zpwJO9i/O9FaNPkwYR5tPDX4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HeHR8Fe6DflKbtgV8ZYz1fq8DITmXnJw8iWdP/QbVH/ZsrKAj
 or3jjeIpO1HKq7YHnKW1TrQKPwe0aUDOd7TxaRpzkI6nsryt955Fq5xjQ/WKlqOJDlL5e5h3FIz
 LWIHTTCnWkI48UhaJJAB5YpT62+hV2yuY3dbPHoqtYIlIpbzf7+A1MFdqrgPImsXO0obXwOw=
X-Gm-Gg: AYBFou3hOGLk/oHT/soPfoNw6njwekGI6G6JNgIBx3GSCVBaAEzLz/7WCEm/EU/yrq+
 pxLZKWQRHeNt5kX4hUXgOMUar5FaJtPi0FJBM5drPSnEJvr6MsGY66a/bmreosIn86ltPpcELiV
 QKqfmBJ95lWmZ9lHsfkJu+nfJm3XD9aiixlCAkwInO4BT3jbTSZpTHW8CRCiAVIb0d9Aw9YM0gl
 oVkqXBjLBXuf98nO23AjsPwWWCc1hAgFuh3SsyUFsT6dINtwtYgcLY43j3TDF44nIPvq/ZYmMS4
 usnlR0D15nVKhYC7RJZjZ+q3vFfIIPjDqxTpxrW0qeigBs+UBdi/czvdiah706PC6lMzSL2Gudj
 hxzaChXKvGDm0M8boPJIriNH7XRRFtypVeLWJqEkQHSr2Y7i/wLOk+mTwJ3YUGDPGuny3eA==
X-Received: by 2002:a05:6122:a5c7:20b0:5ee:3276:58d5 with SMTP id
 71dfb90a1353d-5ee3276714emr21030e0c.5.1794495734456; 
 Thu, 12 Nov 2026 07:02:14 -0800 (PST)
X-Received: by 2002:a05:6122:a5c7:20b0:5ee:3276:58d5 with SMTP id
 71dfb90a1353d-5ee3276714emr20921e0c.5.1794495733786; 
 Thu, 12 Nov 2026 07:02:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm106758475e9.1.2026.11.12.07.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:02:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/3] arm: qcom: display/msm: Require DSI graph endpoint
Date: Thu, 12 Nov 2026 16:02:01 +0100
Message-Id: <20261112-display-msm-of-graph-v3-0-7fd0c06ec6df@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNzQ6CMBAGX8X0bEm3VH48+R7GQ6Et1ADFLhAJ4
 d0tePGg8bLJJN/OLAS1txrJ+bAQryeL1nUB4uOBlLXsKk2tCkw44wkAMKos9o2caYstdYZWXvY
 1lSwDeSoTEIUg4bX32tjnrr3e3oxjcdflsLm2RW1xcH7euxNsuz+JCSijzMTAEpNBWoiLQ4weo
 2xK17ZROGQrTfzTBT9cPLiMMplReWpErr641nV9AT0FVxgdAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=a5k21sPjS0DUr/NbolvO9G7hioG0EUTtUwzEZTG6XNo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9dTs5tNTAu964+ctTeD9UFyfijhDnNW+6OLsA
 OAGmozIQkaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavXU7AAKCRDBN2bmhouD
 16xvD/9Yv0mSIUagFwLapTjq3aTkxOjE6xtjL2EMVjynsMVBf9ar5yIAEdRzEaSpHUkgDHVLcGv
 nUYzLhgZYbQqytvV9chGw0i0//kvdB6KwABtuRLWMKQ8pLu42Zt43BMWMZxiNXFhxpPV0g/Ap6n
 r/HG7H7F2/vRT7oHap10fIGXGK7TXHZY8Dlm3jwh+PWVpVkGJlt4nnqTHYFugb1N5JKU/D8vrW5
 vU+QCR0pmqhKaYaBN0ZZP8ICx8EWWHLNhMYoA6ypLH5ZPFGaLf4c4D+ulyyd2HSS/HyvTmfwBjG
 SCzXjbksFGnLH5W+58s9IN9T+4eYfqQSYUeOYhfBqXd0G4BgypO/PhKK4lvUETpRzWRUf3Cp34b
 PoanxrLmyfzQUCANNbvnlfPWpeAO3ws2YhdK7bUjb7UaKuNnDggH/jZZFAkmnAvXJlpuHEOjhX8
 kl/jxHckV2/M+ggJrF9cNCHGQjRXJoWEEEs0dNTVbP5+K9fUBNLNL+hltT2TUnJPrSGF+jS7C6M
 z3wu7xSh50f4DGxKew1cMSc3L4IuEGYOq8jqNMDJNlz3RzbbU1zHfbzCCVUSRmU5KGW5Ft3WSJ7
 Hgg6CRoBB5bXAtPV/NU8WIisEmz7IovjU3sdDoULK/0ihJVhM78ztO5wFt1P7ICt8onrUJrK6vR
 Ntp43P+bMY5EPAw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: uDUY9IVI8sy4PhAnQuhWYiizDbgBJQDD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfX8wZ6xX7iRT2B
 JdEhQGTrUu7TFvMp3HSyFvcH818Bi+CCARMwHZmHzOpSu/cE5GvHXQxkp8n8DDV0BKuHmTgP15x
 H0sHsZwXjTSBvBge4TRIiEzn6CrNcls=
X-Proofpoint-ORIG-GUID: uDUY9IVI8sy4PhAnQuhWYiizDbgBJQDD
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5d4f7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_iFXmH2w7s5zJ4zlvgEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfX6kJp0S7yoqfm
 vQLNS5g4qYqm0YLhfWz6gsXSYQ6nWZ/qt1FGhMCDT+u61tlq6quVcgraPLIQEPYiZahuGobO9Px
 uSpFFcrbjRDn96KCKZbDonSDOH8f3PEWyjFo5A88O6e2grDhXDKiePJdBchFuGSDAp8USoESLQm
 CDZlV87mBHNAPAypqffCoQVK7q9e/SPnzo9LEt70jc/oAC8kDyaQv/JE6D5Zpn4RIv25FIB+uzM
 qG7AQB/R/DHYTE6ZwDsBZHuV+kHtAA9MWi/40ijSq4v8+HQjKakrhpGnDosUcacSKu/+9pH7pnD
 U33OgPJg/yMge00L1i1px5kBKoH7cwf1MOHJI3JmZnUxvIuP+oUm5bB0hneBrzc7v/9xz04QFtf
 qWfwK6CmxcKSn7G5IRoSgAMTr++sibiUci+3ae7J63zy2EcqEtRDlor0swOsoH3PZwuDhhvUZPR
 DFS+Q2oQpH6d9OdXn2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120059
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

The DTS can be applied as is. Then the bindings can go independently.

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
Krzysztof Kozlowski (3):
      arm64: dts: qcom: msm8916: Disable disconnected DSI
      arm64: dts: qcom: msm8996-oneplus: Disable disconnected DSI
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
 33 files changed, 92 insertions(+), 5 deletions(-)
---
base-commit: 27b8d2cd13f68ac75f737a6f471a7247d2beea6b
change-id: 20261110-display-msm-of-graph-a081a5c614b4

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

