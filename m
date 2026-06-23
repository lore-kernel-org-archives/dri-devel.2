Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E66CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD9510E95A;
	Tue, 23 Jun 2026 05:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghjTzxQN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8s96GeH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D52310E959
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0l1Hu2869366
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QG3aJcDD0ugIKtSRz9Ak9B1Q0FV2od+EXVp
 HzTQsOoA=; b=ghjTzxQNSPunCSRYc6erD4dzkHScpm4YIGLE+Q5qFlUwuSEH5Yi
 9y0/8lDemkYIV45m9tQOuT+NTYocyHoyXd11Ap1OwcKb2ljWD/y9lWmuUKgr0FnF
 S0gH/gVWKy6KIQMFcG1qjg37fWMz1E95Lm6I9Kar1s75E7/gNS7ObtE9imtghGHO
 gKLakEmFtDZI9tU+jRwrFj+M1jof0HNZHClBHnEe/HbnJo5hu0J5HBvNC1nsNvVg
 9LeMVOd4kFOF09L5bE0GyW0rdpFG+vq6Qtysi/0TRsgs3DTNJJciuAl97/pDfMXX
 AfBUr7iWlAfLyX4XXQaaNfR/IxiG/FDETRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmtvta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92158791d14so399400285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782193741; x=1782798541;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QG3aJcDD0ugIKtSRz9Ak9B1Q0FV2od+EXVpHzTQsOoA=;
 b=e8s96GeH9cFhmdvAITg4HOUKNGrxg7IZznAp69bFsWmJ6gF6tYC01r/RM1WeVxNBnK
 CmEoWxGgJ6/KOTAB7XcVLHcJ+xxv74rJCLqnJocuRa0Y66gq0bl4QNLV1EKtM64eQ5oG
 ScH6fskQ2yfIZHlAwWeKA4jagJg4JYsl+LAX8jGcA+3L+nMj1oiPXv7yS6LChvWQyCOT
 eO0JMDCKHoggp/RFbdP/WAfwR0wFfE0AwMWAal8sYMOApVuCwoedYvVy7MTSqhA55VcP
 +kul40LTpbEDbG3NNsxI14bQq5qzE6QwkNhUhLhBq2hgOf+bJns9+h6GgJzUNbPg53Rh
 y94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782193741; x=1782798541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QG3aJcDD0ugIKtSRz9Ak9B1Q0FV2od+EXVpHzTQsOoA=;
 b=agRFPxlVlU6eny2phRqVfyZqJ/Yo8HlL3c/zAR3WUv8WtBe0l1EEsh2+7zwlh3JWmg
 TmH6+mscghdEi19ePU4loV7wP2mom9Qr+V7aChjZRTHFedPS9V/GLq/bJRDP0B9NpsfM
 NsPFlm/eWp5JmiN60aA5uWPErb7GcSrulVZ0vym50xlHhkuw4ZoEPvw+tvwIlHaI7kdz
 TohpGv+9pCuy6CXH4pJ0untvl298XaE3FONM0kLQTiPccfhwgkZq17Z+3jz6cOjfD143
 N7Ojb73lAkB5UeqQux7ph6cqNW70otwGLckf1wukKpm/yTH0Jvyzl9cYY0vMMHVZ2jpW
 UaoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JtQp/fVFtUiJhnCCRIR6jTDvj18GGGQKxwUUj1uQ9OcCo0o/8oZ5r817dh0kL14kebuI962qFMhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx96WvT+kX3gMiPb1ecTvbplK4klNwEvNLZCLEilcKmUADxxFs
 oX8q7LfxMPsKLI24OZV3NPJTK3R3mXNwe/No+aYQgAqbe5BDYMMtisvLfXPsA3LFvBiD9lTe/y9
 JwoLZI3aLrNlr0iigZDyo7L+W3l1Bx0rpYWTe7k2D/srmhre3IKNH7r9jPXXOCcD2x8utoO0=
X-Gm-Gg: AfdE7clhn0Fx5JfbNmHCXKZXBEmKWAMHbBLXfb/gefCrRflyrPvcOrEh4iX0GFuvX4t
 8A0Qg296dRAAiYqP2zX8op/jCDS+AFscI+5P2sq2GoiurwpD3eQKrVrSwTYps7xDN5MtcEvL+E9
 n+p3VU0L1ONhiJ20UCAla5YkKuiWnd29AIb3cjhr9AxZUDfymrfx30Ye7sDe6eq3139FUDdZCVX
 hik9Xe4HDvvLLBU2lyLjtIbG+JzRi7wkXDO1APHVGi8f4xfSiWQvrXsP6FxdlRZZ9fuezldguH7
 yI+Cjln0syBaJ4x2H6Nss0Zbt5qOd1fhd9Yagv3+KH7BMA5NpiMR1EzzlOQwtJs1tcOPrrtkLkm
 cH2fuSCgV1BVcAzHbhYGXE7WIy+Q=
X-Received: by 2002:a05:620a:17a3:b0:8ef:3de6:c5a6 with SMTP id
 af79cd13be357-9208d3f9286mr2845668085a.47.1782193740856; 
 Mon, 22 Jun 2026 22:49:00 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:8ef:3de6:c5a6 with SMTP id
 af79cd13be357-9208d3f9286mr2845657985a.47.1782193740029; 
 Mon, 22 Jun 2026 22:49:00 -0700 (PDT)
Received: from quoll ([178.197.218.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm32588915f8f.31.2026.06.22.22.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 22:48:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Andi Shyti <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linusw@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Marek <jonathan@marek.ca>, Taniya Das <quic_tdas@quicinc.com>,
 Robert Marko <robimarko@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>,
 Adam Skladowski <a_skl39@protonmail.com>,
 Sireesh Kodali <sireeshkodali@protonmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sunyeal Hong <sunyeal.hong@samsung.com>, Shin Son <shin.son@samsung.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alina Yu <alina_yu@richtek.com>, Andy Gross <agross@kernel.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: Drop incorrect usage of double '::'
Date: Tue, 23 Jun 2026 07:48:43 +0200
Message-ID: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24538;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=43pJw6DvWM48MK0qOhX2LPbHO1ITuc3SC/S5TDYz9Xo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqOh46i2/XRiqEjf4RlyvTKWXtcHXSOAUJTIX2q
 Hf+onZFHyCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCajoeOgAKCRDBN2bmhouD
 1zEXD/0d5p4axXW5efPiX7RUnSL9svTCXbUKBh5ZS6XsWj0n1ONuepokWhRZ4FyBOieKLAg4DlK
 QRRGftrVXy10+Dd/VaXPcfsKM6DI1KmkBqQB+o9NcqzbWvGwPfZ0s+GfRpKG4MLboT+xcO+wQQw
 zy4kZvaq0L9KJIv3YtcM9hxy2bEf0rV6Rs5ch5ouAQlrn99JzkKufT4UnwyuSeTCoe13QsfeOvW
 sArEjXRGSDGxFPZ/Kj4cBPA3Kig0LkMrcncF0PfjwSeVAkroMA9W1taeApq2atfavpwQZji22xN
 WW6lzclPqgY2DDSZOvfN9tkQYSOZ1io5DZs3/nZIfMMxZx8qSKbIixYc/dUZeyCr5ux44jSwBIR
 W2uUMBSK3R98+/4RvwDaThw7yBKzV31pJEcjpzyMLVFJ42T/0y7m+FYbcRYMy2wN/e7lXr6jwoz
 t425TsEdmGpFjH/JKVsGZLwratLCn+niz3BYBWfyU7zF5xzwPa8XyJ2cDud2FpCxHERpakMnHIZ
 6LXTcjADmk03uK96M3leZBNGn3XK2Y24P/AvfGc1c4W+U2sWG7Erde94m7fccR1/8Uc63Qx4Pay
 4B/S+x6QfT6unSqKAoUj86tNchsiUmSFs/9ivYLulzQHrHa/1M83LTEfFWFJI13w2GNpqPdwCEB
 ktwA5kNfaRIKx0g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX6zoUNp1AUEAV
 75PbD4WStmUuMUN9FkUB/sw7KPeEUWpBjCfqG/ru+hZEkGrgBLPMTKGRiDsYHP2wQV/2SakCOFv
 Od4WkBTNAW2CiPECkC2e+HfqjNKe90I=
X-Proofpoint-GUID: hZi9VfAiRltvJ1zoYzYRYTqxOomh8MKi
X-Proofpoint-ORIG-GUID: hZi9VfAiRltvJ1zoYzYRYTqxOomh8MKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX6/SeSxToqRds
 1h1Pyv9IwXlJ5Wr9LL5VMsuh4m5bOu2v9mZ37ThYBmdUa1H6AbYf7ugahgsM5QCocJFVp0lzsOr
 hejZK8ZuJqTmK4IVMhafMGXlwP3LTpEW5dZnVB22Ns7OGW6Bfppv2+jtRjQP5eNj2LRYLVf1siJ
 g13R+mNhLhhP5ZffD8uKOc6AGeL9eo8tB3Ym2DH/gr/FC66095SyyYJssntr94P2aIWJX+GsGdZ
 1avaO/oXTOHK2RuEL3bzmdZCz+vJgF82DLnUjpGwL0uOC3GG4AWXzrYH0XcnZMG59os8eI5c/mM
 pFalVOM9hN2VcG3PzfuAqI7Y9kIi8P/R5VYJIrjNeVxLQ251uuukXN9Pamiyn0OB3F8bsETHkAd
 6wRM3d1moWGFBjZ4Q8wVvHeUiwj0LP1w/GAXbrqi3gE1XzkD3a0zJByl8dTiLXtY+sv/UaMVj81
 rjnUm7a0LHQNkQjlugw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a1e4e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=fqWYVyBuAAAA:8
 a=hD80L64hAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=lo55dvS-tf9TgaL6bfgA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=3EkFFxAVN7Xjp7FSp-fE:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230044
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

There is no use of double colon '::' in YAML. OTOH, the literal style
block, e.g. using '|' treats all characters as content [1] therefore
single use of ':' in descriptions is perfectly fine, whenever '|' is
used.

Cleanup existing code, so the confusing style won't be re-used in new
contributions.

Link: https://yaml.org/spec/1.2.2/#literal-style [1]
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
I split the patches to avoid bounces from mailing list due to email size.

This can go via clock tree (no dependencies)... or both could go via
Rob's tree.

Changes in v2:
1. Add tags (partial Reviews as Acks, as that's the meaning of Ack)
---
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-apq8064.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-apq8084.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-ipq6018.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-ipq8064.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-mdm9607.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-mdm9615.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8660.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8909.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8916.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8953.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8974.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml     | 2 +-
 .../devicetree/bindings/clock/qcom,ipq5018-gcc.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,ipq9574-gcc.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,qca8k-nsscc.yaml         | 2 +-
 .../devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml     | 2 +-
 .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml  | 2 +-
 .../devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml    | 2 +-
 .../devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml      | 2 +-
 .../devicetree/bindings/clock/qcom,sm8350-videocc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml   | 2 +-
 .../devicetree/bindings/clock/samsung,exynos5260-clock.yaml | 6 +++---
 .../devicetree/bindings/clock/samsung,exynos5410-clock.yaml | 2 +-
 .../devicetree/bindings/clock/samsung,exynos5433-clock.yaml | 2 +-
 .../devicetree/bindings/clock/samsung,exynos7-clock.yaml    | 2 +-
 .../devicetree/bindings/clock/samsung,exynos850-clock.yaml  | 2 +-
 .../bindings/clock/samsung,exynosautov9-clock.yaml          | 2 +-
 .../bindings/clock/samsung,exynosautov920-clock.yaml        | 2 +-
 .../devicetree/bindings/clock/samsung,s5pv210-clock.yaml    | 2 +-
 32 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 53a5ab319159..6863db9bd092 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM8150/SM8250/SM8350.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,dispcc-sm8150.h
     include/dt-bindings/clock/qcom,dispcc-sm8250.h
     include/dt-bindings/clock/qcom,dispcc-sm8350.h
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 27df7e3e5bf3..68532244901e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on APQ8064.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8960.h
     include/dt-bindings/reset/qcom,gcc-msm8960.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
index 0a0a26d9beab..1c022e75fd71 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on APQ8084.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-apq8084.h
     include/dt-bindings/reset/qcom,gcc-apq8084.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
index 4d2614d4f368..c7fb84438db7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ6018.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-ipq6018.h
     include/dt-bindings/reset/qcom,gcc-ipq6018.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
index a71557395c01..b4d3175780bc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ8064.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
     include/dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
index d7da30b0e7ee..0a7be7583bdd 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-mdm9607.h
 
 allOf:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
index 418dea31eb62..0656d5ee448d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-mdm9615.h
 
 allOf:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
index e03b6d0acdb6..70c9da1f35c2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks and resets on
   MSM8660
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8660.h
     include/dt-bindings/reset/qcom,gcc-msm8660.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
index ce1f5a60bd8c..2edb6c251d99 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8909, MSM8917 or QM215.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8909.h
     include/dt-bindings/clock/qcom,gcc-msm8917.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
index 258b6b93deca..af4b639ea8c3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8916 or MSM8939.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8916.h
     include/dt-bindings/clock/qcom,gcc-msm8939.h
     include/dt-bindings/reset/qcom,gcc-msm8916.h
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
index ced3118c8580..fc0360554f68 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8937, MSM8940, MSM8953 or SDM439.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8917.h
     include/dt-bindings/clock/qcom,gcc-msm8953.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
index 929fafc84c19..378dfe7854ac 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8974 (all variants) and MSM8226.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
     include/dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
index 724ce0491118..72aaf699cf70 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SDM630, SDM636 and SDM660
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
 
 $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 4cdff6161bf0..3ac4419009a9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,gpucc-sdm845.h
     include/dt-bindings/clock/qcom,gpucc-sa8775p.h
     include/dt-bindings/clock/qcom,gpucc-sc7180.h
diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
index 489d0fc5607c..9925b931ecad 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ5018
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,ipq5018-gcc.h
     include/dt-bindings/reset/qcom,ipq5018-gcc.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
index 27ae9938febc..5b128fa841aa 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ9574
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,ipq9574-gcc.h
     include/dt-bindings/reset/qcom,ipq9574-gcc.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
index 61473385da2d..3da10c364a85 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm NSS clock control module provides the clocks and resets
   on QCA8386(switch mode)/QCA8084(PHY mode)
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,qca8k-nsscc.h
     include/dt-bindings/reset/qcom,qca8k-nsscc.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
index 734880805c1b..bedbdabef672 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,qcm2290-gpucc.h
 
 properties:
diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index ab97d4b7dba8..b6c835bfd0d9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   The clock enumerators are defined in <dt-bindings/clock/qcom,rpmcc.h> and
-  come in pairs:: FOO_CLK followed by FOO_A_CLK. The latter clock is
+  come in pairs: FOO_CLK followed by FOO_A_CLK. The latter clock is
   an "active" clock, which means that the consumer only care that the clock is
   available when the apps CPU subsystem is active, i.e. not suspended or in
   deep idle. If it is important that the clock keeps running during system
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index 99ab9106009f..fd06ac9bceb9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm LPASS core and audio clock control module provides the clocks and
   power domains on SC7280.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
     include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
index 273d66e245c5..f235b4e24cc7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm LPASS core and audio clock control module provides the clocks,
   and reset on SC8280XP.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
 
 properties:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
index 8cbab3fbb660..d7e1938b5e1b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm LPASS core and audio clock controllers provide audio-related resets
   on SM6115 and its derivatives.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,sm6115-lpasscc.h
 
 properties:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
index 5c2ecec0624e..a986ab4ce7c7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,videocc-sm8350.h
     include/dt-bindings/reset/qcom,videocc-sm8350.h
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index f4ff9acef9d5..124d259fc85e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also::
+  See also:
     include/dt-bindings/clock/qcom,sm6350-videocc.h
     include/dt-bindings/clock/qcom,videocc-sc7180.h
     include/dt-bindings/clock/qcom,videocc-sc7280.h
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
index b05f83533e3d..56ab972c3da5 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
@@ -14,17 +14,17 @@ maintainers:
 
 description: |
   Expected external clocks, defined in DTS as fixed-rate clocks with a matching
-  name::
+  name:
     - "fin_pll" - PLL input clock from XXTI
     - "xrtcxti" - input clock from XRTCXTI
     - "ioclk_pcm_extclk" - pcm external operation clock
     - "ioclk_spdif_extclk" - spdif external operation clock
     - "ioclk_i2s_cdclk" - i2s0 codec clock
 
-  Phy clocks::
+  Phy clocks:
   There are several clocks which are generated by specific PHYs.  These clocks
   are fed into the clock controller and then routed to the hardware blocks.
-  These clocks are defined as fixed clocks in the driver with following names::
+  These clocks are defined as fixed clocks in the driver with following names:
     - "phyclk_dptx_phy_ch3_txd_clk" - dp phy clock for channel 3
     - "phyclk_dptx_phy_ch2_txd_clk" - dp phy clock for channel 2
     - "phyclk_dptx_phy_ch1_txd_clk" - dp phy clock for channel 1
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
index b737c9d35a1c..1d907dd8fbf1 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
@@ -14,7 +14,7 @@ maintainers:
 
 description: |
   Expected external clocks, defined in DTS as fixed-rate clocks with a matching
-  name::
+  name:
     - "fin_pll" - PLL input clock from XXTI
 
   All available clocks are defined as preprocessor macros in
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
index 3f9326e09f79..8a289f1e2ace 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
@@ -14,7 +14,7 @@ maintainers:
 
 description: |
   Expected external clocks, defined in DTS as fixed-rate clocks with a matching
-  name::
+  name:
     - "oscclk" - PLL input clock from XXTI
 
   All available clocks are defined as preprocessor macros in
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
index c137c6744ef9..a51cd4fafb41 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
@@ -14,7 +14,7 @@ maintainers:
 
 description: |
   Expected external clocks, defined in DTS as fixed-rate clocks with a matching
-  name::
+  name:
     - "fin_pll" - PLL input clock from XXTI
 
   All available clocks are defined as preprocessor macros in
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index cdc5ded59fe5..68c2fd318765 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -17,7 +17,7 @@ description: |
   Exynos850 clock controller is comprised of several CMU units, generating
   clocks for different domains. Those CMU units are modeled as separate device
   tree nodes, and might depend on each other. Root clocks in that clock tree are
-  two external clocks:: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
+  two external clocks: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
   clocks must be defined as fixed-rate clocks in dts.
 
   CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
index 32f39e543b36..e9d17d48b4f3 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
@@ -17,7 +17,7 @@ description: |
   Exynos Auto v9 clock controller is comprised of several CMU units, generating
   clocks for different domains. Those CMU units are modeled as separate device
   tree nodes, and might depend on each other. Root clocks in that clock tree are
-  two external clocks:: OSCCLK/XTCXO (26 MHz) and RTCCLK/XrtcXTI (32768 Hz).
+  two external clocks: OSCCLK/XTCXO (26 MHz) and RTCCLK/XrtcXTI (32768 Hz).
   The external OSCCLK must be defined as fixed-rate clock in dts.
 
   CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
index 6b1fc61a2ff9..475db824d4d3 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
@@ -17,7 +17,7 @@ description: |
   ExynosAuto v920 clock controller is comprised of several CMU units, generating
   clocks for different domains. Those CMU units are modeled as separate device
   tree nodes, and might depend on each other. Root clocks in that clock tree are
-  two external clocks:: OSCCLK/XTCXO (38.4 MHz) and RTCCLK/XrtcXTI (32768 Hz).
+  two external clocks: OSCCLK/XTCXO (38.4 MHz) and RTCCLK/XrtcXTI (32768 Hz).
   The external OSCCLK must be defined as fixed-rate clock in dts.
 
   CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
diff --git a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
index 67a33665cf00..b1617d96d3fb 100644
--- a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
@@ -14,7 +14,7 @@ maintainers:
 
 description: |
   Expected external clocks, defined in DTS as fixed-rate clocks with a matching
-  name::
+  name:
     - "xxti" - external crystal oscillator connected to XXTI and XXTO pins of
       the SoC,
     - "xusbxti" - external crystal oscillator connected to XUSBXTI and XUSBXTO
-- 
2.53.0

