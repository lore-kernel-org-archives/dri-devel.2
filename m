Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9359F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1252D10E2DB;
	Fri, 17 Apr 2026 23:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyhnYDER";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHYBniiU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB0F10E2DB
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4Zkv455054
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=662gIcwEaIIKEvo6iC4Gxy
 eWYPAbQm0eUxv16uFd0gI=; b=gyhnYDER85N4wx4997fp/QNxPaUEiMwYvQUx4t
 xYOYqC4kRu7U4RkiB7Db9WKfL4F4EVo0kvS4DUceCo+6qPLlPLYiugTdESDHcf/9
 Kfwfjp1tQN2tCBic6xECk3s0WdMgBOwGM/paMYg61zTlInFGG7yn5lx8rrlsCREf
 mFYyzbyJfsJtbx0U8r07K0yg4NWQmxE+zkn6zPxKvaEquRMd/gwaj4PA764doTwh
 9eMnmlNXmcUbNXOmlnJcrjWvJa2hagUPKkcihlcLqgqXAayBxdQCHkvDJ061ZW0Z
 YeSIfZHyUseH69TNP56+5FmoxygdCqxtqewSBW3tNm+eLPgg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg88u2s2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso15761141cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467787; x=1777072587;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=662gIcwEaIIKEvo6iC4GxyeWYPAbQm0eUxv16uFd0gI=;
 b=DHYBniiUiscJsx/hZnBmin9PzrMCbZYRZ6Rh1qL5jBD5x7JOs3p5y208ihy4kE6o/y
 ys36YMcdGhvBFciInrFmzfOXt4rRZW+k7fyPLsUxdg+SKuxKPwK5Yo3GRxmMFHPm1g4f
 0hBq8cvlNW5jJOBXKj8uHO3vCo84B4isW541zBncz+CJzXITRrH8vD6RJ8xhi4ev7DZt
 fbjHKOf6vQ+sGbtX34WzXCZDJRA4NZgnwjhm4gVSNkDtgGHFqzgNt8gel1nCP/gfQEFE
 mxLgFs4YuGqZNwdxR3Q+3Kdf5UU+mwkR4Z5Tg9K6mIYDzq8JIfdZmQg/QlE+b6+3nT+E
 6nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467787; x=1777072587;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=662gIcwEaIIKEvo6iC4GxyeWYPAbQm0eUxv16uFd0gI=;
 b=H/NSNzWeZE0SGcn16seaeP8TUImPU0jD+lvk2QiPQnimDYDHJKtjIjb29gk/Kuuxo8
 Pq3B7iikzfud3nJlIJdR3pRPj7bXF59xFIfZsKPQvSAgtoE5HJnvcY80rB3rvYvUzk5E
 JtpZQI1ybX791VcANjikJTdomBbYoqIgZn+dNgOtfMa8MCcO7jczNYUJd+PAbis+CSyB
 BeYse+R8m83Cl1qZB7BNue9Ithp+6vrSLpzgiRnwtpkzNOgULbigv00Hddroxx4RIIpY
 V8W1HnXY6UnoBHu6SW+Wr85ZKG+ONnahBtxQGV56WJk13cTImUJ/hBslHR9mVfhqVTGL
 2C7w==
X-Gm-Message-State: AOJu0Yzy/yOsWrmZ/FO6V5wNzi2FKLtLA1wxwLgdM20mXRF6baCwhiF/
 EMao4f8j9o+xbS9cmAlAQtcS8N4eZcmSAgmStQTK5/jwxt4k0IFh4oJtdRN3W6JQ6AgT5CBJvlv
 bRH19Z2juLErvp9I7eG/H91puLStmdjbgTOmOwnNrfir6qZT4wrq3q9lE+Pk+EN26OFx689A=
X-Gm-Gg: AeBDietJM1+x261O40lFC+rx6wAlxnUT4Ax4H0eilZ2yvgoPCA2bFCdXj7N2zCptPae
 IEa6lF3p4qISPteJE/rf/G4myQZQoEh43/AlGKxyCHCEMw1tXaACOCemrOQhFUYYr02xKSmNdQ+
 QVwPEcBJrmyI3BrkZAjgsrnGtqzOnotwj3sFXqOlr4H6Gw6pLGrFpfs72YBmWDagFbg5EHgY7Qf
 NmEvMi60Fj6z2Xlwv1c4NjGfEXHFOEluNfKLmjyw8zOaIoDgMsMk3ST/s+lu6lfwzeTMZDqsuh8
 8WZc84jWSRRe3OsjCK07fmQHOTmWol0R4TzjRXNk86vPoVWDIWoJlKLXAEQ2ThRD/oaYKIffHD2
 H6GFJC+1d82SfqPhL3KwaN0h0hFr2hfrLxPYMfcW8M9ICbhz4xEbLXiXBQShxQKjKVMJWwdn1Hi
 HJuTF4x0b9Bke364jNbvv22iFxY5WAaBtOmeACmd6+IL880g==
X-Received: by 2002:ac8:594c:0:b0:50d:9f02:86c7 with SMTP id
 d75a77b69052e-50e3682ee36mr78878371cf.13.1776467787161; 
 Fri, 17 Apr 2026 16:16:27 -0700 (PDT)
X-Received: by 2002:ac8:594c:0:b0:50d:9f02:86c7 with SMTP id
 d75a77b69052e-50e3682ee36mr78877861cf.13.1776467786685; 
 Fri, 17 Apr 2026 16:16:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad12asm815695e87.1.2026.04.17.16.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:16:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 0/4] drm/panel: support Waveshare DSI TOUCH kits
Date: Sat, 18 Apr 2026 02:16:19 +0300
Message-Id: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAES/4mkC/33NQQ6CMBAF0KuYri3ptFSiK+9hXJQySI1a7UDVE
 O5uwQ0LdDPJT/683zPC4JDYbtWzgNGR87cU8vWK2cbcTshdlTKTQm5ELoA/TURqTEBekeOt72z
 DEQooDNS1zQVLn/eAtXtN6uH4zdSVZ7TtSI2NxlHrw3uajTD2/i9E4IJr3AJsS20E5HtPlD06c
 7H+es3SYeNQlDMKflAyUYW2VYnGatCbH5SaU2qZUolSBkuthJRWyQVqGIYPVRLORmUBAAA=
X-Change-ID: 20260401-waveshare-dsi-touch-e1717a1ffc40
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1A/TJwuFxWd+k6ydq9PlXg+2s+xDZdLBjpZDlNrDZmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4r9IfeFB5EOEVa4K1JmCLmN/GaQxsaO2+HxDi
 QnnP7pz2BmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeK/SAAKCRCLPIo+Aiko
 1bkNCACXs/uhyIZ1gbwpd/VfscDcICcbYvqj1d9Em3lRChF2v2swu6uUGWP6tYS/UUI1oYVbCpi
 xpdHJ9FhIf5B/yMkHZjkWr0Amm/5USULE1MMK6Krtp+DUj8Yb8fEMYwK+RwRO12ldXgRBOwXge4
 qEJZnHYBd79tBrX+439pC+oGjS7CI4ba0lxkpWxZITro0h2q5cLS0kq7JUp3715s26bK4UEf4NZ
 jdzjeEJI8ZRd9BAruoH7mWBbJqX5FlxrWOMIxC3nsRDhJkKv8mF882vLi7ZkfeXoE3ntV6XoRsu
 tRXwwG+zkoNlorwr5yjRVS0R9OI7/QpxYjASDhUL+ywSDVp4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: UfBosAduFSQMXsqJ3WoIFocHSuEQhMh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMSBTYWx0ZWRfXwCh5zXm4yyY9
 3q9xJbpqNhzV0EG8nSazhCc2QXZsIU54rLc4XXicBCo1tPecPhi5ZqWNarBWvupWMEMrmdyLkNP
 MBRPvp3h+wCSheIWppIWByLlb9+mlDWjZ4Fjc5uUKlsT3hGA4hUwqPZPuEWXGMfqZF0A29CoLDW
 OMyVkacgdYdJqpE1tMcgepTm1tgpgi3peV+vPP6O315JgJ1FwsBkrDuAmGWIM2505bpBQEItpM5
 Y3TsdEwGKK4dSkkENej8lzahPRCERFRnjN/jUWbsNRXZOw0inod3trTPvA35NExPW8YhM2OmCd4
 0fQQp2kf9AzB2ScwK0YyyhWNv6B6vmfL9xp6h8+hAkWl/ZnRwx+caIv195RNrUyZ0Lczb7PWY6C
 4Mx3j+A4DOgerWicfwWhw4w+IJSZvqBDdcW5cFmJarwHp+cuZa1v3SovBS63/AUq5FYmpfD9hMe
 usmKvFj5ygtG/Si2+dQ==
X-Authority-Analysis: v=2.4 cv=X+Fi7mTe c=1 sm=1 tr=0 ts=69e2bf4c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=woyZ9DH24JpTQh7i3M0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: UfBosAduFSQMXsqJ3WoIFocHSuEQhMh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170231
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

The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
video-mode panels, bundled with the separate controlling circuit,
produing necessary voltages from the 3.3V and 5V supplies. Extend panel
drivers to support those Waveshare panels and also add GPIO driver for
the onboard control circuitry.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Dropped patches applied to drm-misc-next
- Link to v3: https://patch.msgid.link/20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com

Changes in v3:
- Fix another typo in the focaltech,ota7290b schema, sorted out voltage
  supplies in the schema and in the driver
- Dropped Ricardo's T-B from bindings patch (Krzysztof)
- In the Waveshare GPIO driver bumped max register to REG_VERSION (Jie
  Gan)
- Add a lanes vs config check in the JD9365 driver (Jie Gan)
- Link to v2: https://patch.msgid.link/20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com

Changes in v2:
- Fixed errors in focaltech,ota7290b and waveshare,dsi-touch-gpio schemas
- Split the JD9365 patch, making the changes more obvious (and
  describing panel classes)
- Cleaned up GPIO driver: moved NUM_GPIOS from the enum, switched to
  guard(), added regmap error handling, dropped
waveshare_gpio_i2c_read() (Bartosz)
- Link to v1: https://patch.msgid.link/20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com

---
Dmitry Baryshkov (4):
      dt-bindings: display/panel: ilitek,ili9881c: describe Waveshare panel
      drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel
      dt-bindings: gpio: describe Waveshare GPIO controller
      gpio: add GPIO controller found on Waveshare DSI TOUCH panels

 .../bindings/display/panel/ilitek,ili9881c.yaml    |   2 +
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 ++++++++
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-waveshare-dsi.c                  | 208 +++++++++++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      | 251 ++++++++++++++++++++-
 6 files changed, 570 insertions(+), 2 deletions(-)
---
base-commit: 17394e05b295e4936e0ed50d2f02ed7f08fd4f7d
change-id: 20260401-waveshare-dsi-touch-e1717a1ffc40

Best regards,
--  
With best wishes
Dmitry

