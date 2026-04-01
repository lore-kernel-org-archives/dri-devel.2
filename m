Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38148D3514C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0578F10EC24;
	Wed,  1 Apr 2026 07:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="od46VEHN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JdwkHCHG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D147110ECB1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6313VhFD1460261
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N12IT7QQm6dQyXdftpTiwQDPXATOjkTcFh3mc09NiTw=; b=od46VEHNjwjDL3Vx
 /OeLgV/Jzx3wRxqL6pce+ExMJvYw6dHlupKe05x8TX6+rs4cT2kQKPGJCaSIbKmD
 DF8PMicQUjDhsnJLoivbRz1wF4WXF+ZyRXxCjmFgU7poj8QiyQabSYEzQ1Q06Asu
 20+Y3WDEJWN+b7t/VBuVY1rp/tUfNWJDxnWZ6Y0KVnOaOhRAu9Fr/sc0ZjDcw4ng
 dJAAd7OSOYlV3lWfS5oP4WfDmHGmYbGSaXqoRHoS6VcajAMm6CVbpgz9TLlZ8K9y
 SmNVPk0SKTHsIFZ73K4usrY/2+mISWzohT+PIIb5wkLv0hz4o+K4UV+/9nObAjoq
 GeisFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8uhg0us9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b6f869676so140150261cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028402; x=1775633202;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N12IT7QQm6dQyXdftpTiwQDPXATOjkTcFh3mc09NiTw=;
 b=JdwkHCHGR6AZu43zzMmcuFBSi/Ia/9c6NkgOw7QyK0pm7pK43qL1QLCz/VLg3Vxiai
 sA0lCNr5+gLiQQ6b2NQuOycA5WdIfNIYttAamabpPFMzPDJkjjIFnh5j/rxGT8fAnWL/
 zKh+GRoEUCfAy9hyE58tO1D9EgjHLNFR3vAKzOwvu/EN6KdIHWQJwigy0XKxg37Knhdg
 ix5bqqgwsk4sshGN4BKyrQutDI7mV1rotBiK8j0srUkoRKFLaTi3bADFKdtPdCdU6Vtm
 obgz9Ch6B+8d4jV2tt8oVsmofrIkoC/v3FyAyb3x/BNM8FOeQIiE5BxeAkGeQzVPVh0b
 ZuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028402; x=1775633202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N12IT7QQm6dQyXdftpTiwQDPXATOjkTcFh3mc09NiTw=;
 b=fmY3yuBmXc35R9ae4oCCSlMeSyC2pPjjYLjQYe2NyLN2mjzQALC7cmJowAZeYXXLCU
 wISacmutOBSmefPOPpBAzdUK3J7W2iVAadn8j5mnbWyZ3HkSocXmeLLNsnrZuNqUNut2
 VaQlqF8ZGgXaTVP+vuBvbe3xVo/gVZbFIqaRB/D5URKaO9U2Z+GYOrxom9C9OFjCm+Px
 6kfC3LSxCbrOPJNP04tVfEtFjsJ8hSWM9pYHmBPlNgld9tHtDF/uAtO+lYHbpvN8Xwfp
 kw8iJKWHDVy5fFQCXczZ4z/9LxSFoP4yePBVDpmehAkjFYOx5rx6GBzUbQaa+8q+/SRJ
 KkhA==
X-Gm-Message-State: AOJu0YxqqE0w/g9PYeAxyYXtiRzhM9jkag2PbbMqnKSy1qJ/PUc77hkv
 HwzZ+kCyTK8AB86GEEzZ+40/fZmusoxWHOi2ggrNaKX+xSltx+qrKrtQpW1BFAbYPJmCG8Ka5uc
 Z/1diDwq4BqH61kSKS2p+ixxPcQ4d/0P9EbGzBXqA4kd8SInBJhhMPORpqsZbLhrmdx2dea8=
X-Gm-Gg: ATEYQzyuvj2BCr/zHlkXGkQn/4enaOvsA/duhmxUtNAq7WZyLTcSfYdF4yDrL00nvNg
 TMOZe5cA0vrHF4iK9sgBi2DvbdvgtLPyh34qOk4gTPAIGVMrfTaIyeGM52A11YyoQCYQikyEWMz
 wYxRh5zdbul8ASWX3Gd82hbiHgRaOOTxssv9NX92/d8QDlklshSdFrnRCLL9l6dOsawJeOmJQl/
 EGBI76o2S7EifcYsC+GPJEpD97Gn5pM4MGw5i8uNsI9b0gkihArUJ+LYe1ViPH9I2O6pVWe6jZi
 /xzqPqLKnvm4rI0YEDPdZVxHjPzHOkCkpMB3KrGFj+TQXY0vnXcb8mAAkZ7pIKrHikbBU3jpI2T
 jc//G+KM51Z1R+fwr/vFHxAzQG4XId1i8URIpWqvzhXIJd7nMwgId8Kj2nc+1Bw6smx34wTclKC
 3C1Lt/KRqyEDuB1CTW9vooqAnKjGGXGdHjidw=
X-Received: by 2002:a05:622a:347:b0:509:31bd:3de4 with SMTP id
 d75a77b69052e-50d3bd36066mr35220011cf.56.1775028402498; 
 Wed, 01 Apr 2026 00:26:42 -0700 (PDT)
X-Received: by 2002:a05:622a:347:b0:509:31bd:3de4 with SMTP id
 d75a77b69052e-50d3bd36066mr35219721cf.56.1775028402051; 
 Wed, 01 Apr 2026 00:26:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:20 +0300
Subject: [PATCH 01/19] dt-bindings: display/panel: himax,hx83102: describe
 Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-1-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=941;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CKt4o9MtJVlHGeGwYzQvEJIoQaM/NF+MZ+0HmD/yJ9c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMir8s4mocEGfwo31npITXA+knKdJ0LlAlBqt
 gVKdrFjX8WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1VWYB/wJdQeubNmHeczzuJLLmF7yqFrmL82/+5J8KYZss0rUKi5WcUnMkcq6dn2fLFtWP5otFYy
 8uHY1u4ofoZopDx3Frg/jcOb/L0ALVBm8Liwf59rXDFNAUL53MkK6CjqzFYaykpQQrdDdmpVpHT
 6xTTKR9Q1WRwfIDgfJYehbSfDWWxKanI10Pi2s+5DhWL8CTZ307txR8hYtFg+JTts18TPlxkm0U
 DyK2pxAdKhSzJM/MACuc2ekEc7q6hPx3FqAjAWxKKh2uVu1L78A/6Cgj3LkoSD91cvBniugcYw6
 Kn88RcMJU+B/YNJPqamd152wYxjGoUV+4qCJ/+XmwyPPSexa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfXxl06I8joOaRS
 9areMBAUdwx2tq7Ac84jgwTCy21Og9eJwpk8uWiQ5kiRf+RwO9ydhOFTM2O3RAkGhmbWr1g3sdV
 0+4wC7tlZC4Gl3KbXwNpZnjMPnXKXe61N5uE9gVgwPcRtAfHuOmucXTDrfRBEChsY920WB7Wdv5
 K6RI+kgLRgFTGGOKIsrmKRcjJkUvWb6MkNomllKIBfRMdDbYa3LrlaUK1+KKbR8XUWgx5kNx+qf
 IhqWa4TryvS+4Fz7azAxAUSh75s7EK7/wkpn8lVLOgdc33OCXG+nw+0jDP4bg6ee0j1mE3eTlQv
 OkiPoN0Ejnnw9MQ0xmvYOoUfya+ii5dTJtwuPANd258/BdyCeVUhw6j2uK+4hmKvTVh77EbfLVO
 aS8DOC+L/Vd2kzfXv2q69V5anjsX7M2ptvpESZ8vJEPTic2YBrdpg75Su58MGC0fibVgXVrtV8O
 m9Iwvf14wO1QZCMfh+A==
X-Authority-Analysis: v=2.4 cv=YcawJgRf c=1 sm=1 tr=0 ts=69ccc8b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=dDwtKCuX-g0vR4_aJEQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 0RXtH0DoiOfqPGk7vT8Ym0J9nhLPg6Fl
X-Proofpoint-ORIG-GUID: 0RXtH0DoiOfqPGk7vT8Ym0J9nhLPg6Fl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010064
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

Describe Waveshare 12.3-DSI-TOUCH-A panel which allegedly uses HX83102
as a panel controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 66404b425af3..7667428bf9a8 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -30,6 +30,8 @@ properties:
           - starry,2082109qfh040022-50e
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
+          # Waveshare 12.3-DSI-TOUCH-A panel
+          - waveshare,12.3-dsi-touch-a
       - const: himax,hx83102
 
   reg:

-- 
2.47.3

