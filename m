Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F5F588E3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A3310E15E;
	Mon, 20 Apr 2026 15:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQrhyNSO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HaAJOGsp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2669910E15E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K97Cqc2755700
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KPq2KWyVdJ/QThETfa/aj4
 GaL3KGHo2jIAgQ+4vtHSY=; b=mQrhyNSO1d4bVUQ2uy3chP70enO+iO9b/9x8wF
 WYVeBNBsgGl5uk4Wx5ZzJTsJhSP7twcpbRlFk0X9cqLO49FDjXuQQDyu7ku849d0
 vEHn2zSLkdnK3Mb3Lb9KzkMJUxxx7/FhupOQWNn6WjtpzDLPGEdbhqxOiFeqoO6s
 L+TSM41pvZdc6c2Tt6/aTaQUX+nYtUgVVuRtnBXRzpAw0+LqFLs3uSHAv9yKD5R9
 bhi8oehMmdD3XNG+jt2bnnKEF9c5BEbpCXtOe40u6L9kE7UFgokFbkUJXdlmP+pJ
 VTMWDGRx46hXqjtEbW4BamBkdAyE4xLqZfkxMPDXeu0aghPQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh7xhcmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:44 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-467e8ec004dso3625624b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776699104; x=1777303904;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KPq2KWyVdJ/QThETfa/aj4GaL3KGHo2jIAgQ+4vtHSY=;
 b=HaAJOGspShQohZKmpFtXqwNThA3m1peYCny7TyXlF0XZrwn6SOJ8KgRG7aSHK/JrNE
 zjUOcat5hjx9GOJn1ww3eUE1pv0YEoouUHs+d7NHV54CK3VHFrWNI7dfTLw1WMxdEcmi
 4xZdH7GdW9woztotoYTrwBbXM6D7nEBEq9Z14rpsM3l0Eyap4PNekwzAiQZOE7nycSyd
 VtWfsgCYUJLoG/BsDmEVU1d/TIif9fJ5SlXhRwohLjXI1AY6Gi/lq3Hf/VD21m1pLRb9
 n57jXRPlpqILwTkkmnZECtlg64ltWRnQEERpmev4e8T2pXYC/sm9tf2ABKigCIRKSeA5
 Xl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776699104; x=1777303904;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPq2KWyVdJ/QThETfa/aj4GaL3KGHo2jIAgQ+4vtHSY=;
 b=N9EePBWgPr9LkJ4ML62ZWLyx5DROVrSKRTEgAoiHmMZ0QFQxCWMFa7v5qQ60pg0zz6
 NhmNv8xMOqEvvhZll6MSm/VsA2izN/oywTShhTnhJf/27RXDtAzYL0/dtw56qV2pEqJp
 wsXuuF4pklxc+hDJo2y1vJvEF3te+CkAg8X/mDvXKcEkVkyjc6tJG8fBG2z6IFPz03qt
 UdeXzsb8QgZFl5IJvte2RCEyvv/Ks+lODTnpx0LsegV5LHrIH+FIoDL+j5v7XuFskckI
 L2I90t4znQ4oppTAGo5VJwz8aXMuqtoInh8cYs9D98VmtdaNYEion/0GT9xYKlbdp6DA
 xuOQ==
X-Gm-Message-State: AOJu0Yybtfd3EMKEOhxNC5LIqg9qgg9RmuXySSuoQXysosT5X+EC1mGz
 k3sc4ndFwI7kLAp0hNg1Maw9IXEO6asfC2oq6uKyoHJTYj9oZvVqRbXY5Zy+dOkOAQ4P9ubMUUj
 4h9kUwKfoE9iQXxWmg2DFbAGIPUSHl4eBkIPceSn7fl5Diozuh69FXmgRFjqtsPXGOxWcjhk=
X-Gm-Gg: AeBDieuHjvygXjVfsUYSClLrubgaU44hJJDJ1RpQbrCiiBKozTRCWSIPGkeE/fGHwzb
 CngvJhWQfHorMpvog636roHh9KPWOBiWhRSpchVDGT2CVq7MfVlA5AiUpLhjrsGI1KG0KENln2k
 r/M0xhulj1C8qXMJITTRonmB2o1JZxY1IDqnA+WQV0BWPyT49y6xn/tFXbuj1lixORR3oGr1u63
 26ca5pfeLxMC3ZhGCZgdF4QoRRGVE3/Iu7fKg5+e665psXd/gLx5IImc7LqImZ5xWCj2s1B9O6L
 6HCpLiNzdprZf0+ZB8UcP9r/GEFbZ684YbTVnAKQndM/gGo2uq84NHUihbMznt0zSF2ZQlWurKJ
 xa4wK1w4qICSMb0NFEJRaVug7v7u0vb2BizcspJHUc4PxF3UsiR0MhPa9j1WrK0sAyFVP4lIca0
 5dvgCEA78UCafgTIpwoBtInTXlUvoMB4Zthk9/feu1pWF/zw==
X-Received: by 2002:a05:6808:8888:b0:479:ca20:2904 with SMTP id
 5614622812f47-479ca2031a6mr1688417b6e.40.1776699103477; 
 Mon, 20 Apr 2026 08:31:43 -0700 (PDT)
X-Received: by 2002:a05:6808:8888:b0:479:ca20:2904 with SMTP id
 5614622812f47-479ca2031a6mr1688353b6e.40.1776699102944; 
 Mon, 20 Apr 2026 08:31:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc31dsm3071171e87.22.2026.04.20.08.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 08:31:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/6] drm: handle IRQ_HPD events correctly
Date: Mon, 20 Apr 2026 18:31:38 +0300
Message-Id: <20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpG5mkC/12NQQqDMBREryJ/3UgSrEJXvUdxkcSfmlKN5sfQI
 t690dJNNwMPZt6sQBgcElyKFQImR86PGeSpANOr8Y7MdZlBclnzSlSsnzrmwsww4RiJYSO14U2
 tzlZAHk0BrXsdwlv7ZVr0A03cLXujdxR9eB+PSey9n7z+lyfBOBNKCyuM1VLLqycq50U9jR+GM
 ge027Z9AAYPTRzFAAAA
X-Change-ID: 20260414-hpd-irq-events-e72bc076a5f1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2944;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UvPqtcBs6t12Cb50UIargyyrmizVDFL3lnz93lf5dTU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5kbcZbi/KWXeOsOVKc0R63XrtFjzk27ElCmXg
 o1hqq0c2AiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeZG3AAKCRCLPIo+Aiko
 1crcCACcPmDWi1VRXcgFtEXlo+5T/J8Fo1YheczB5Yf/UcL5kzeG1wYdBh80oB6i8rpfl3PAIqI
 OtE0Vs3/R3OyrKQWM6mUEfbofHykn/tlnQdokPu98hSVlATQyeKrtfLI5o40Nrdwxz7PWCEhc/d
 CcHkRkkhNxWNDiQjJQATtm7QgXgteXtJVp0OkDMB3NWa4Mif6sOwMvfCWxGS0VsfgmopA14BWm8
 iMV8J2GhiPTLlcAWNcpW0UCaRV9Las5xLHFCFyX4DkL0yvG7qFApbn/YIQtAUQ9wVya89ZSPODt
 cAE6lzXZZ0TY8jCDbiqtMt2ZWZkXJLv9TxbTNBit8UHk4MZH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1MSBTYWx0ZWRfXzBLgg6pJJITx
 U6vcFSbn9X4jvsHFzhDMN3QNFI26hueaJNU0tKUul/QAshb9LFzKjDd7cTuXcqtYTtOns5pB773
 tg0oBtoWqIjbuHKiojbikMmHJRjcZQ4a6FM2BNhL+qXH/lGjEosRwNCP22eJLgcAt0HuwTihTJV
 dXg9X9KURmmCq5Oj0xOOZELDt3q/zAe5U+J2VqdbvaJiT/HPoF3cQI+ApMNvcEHg4Gr78MAWneP
 qvrg6FpCbXYx+qR6w4zN/scI3mvp3Jr/mcEPMiq6Q7Xo/QzFKhP8J4AgH40oKazjKWK6gbmMUGT
 gu+0xpNRMSxWFr/ngVnWcKl7r4jAPNsgTQOW3RMKDsCiYcRh+dQH+jIkoaPWCgthEnS6aQx5xOX
 vSSPbf791mJ9KOvVSjqsx5ysTOo9iGzgvR8D4bUW1RSKMT9BIsITu485zBklwiWh1sNpzRoFTqV
 CLTc5hUGok/E7QbKhlA==
X-Authority-Analysis: v=2.4 cv=BPmDalQG c=1 sm=1 tr=0 ts=69e646e0 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=ST8Y6Hw29dmLQzsKkX8A:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: kTvGDx5U0quD0UChmM7Zu4UvDAflmtL7
X-Proofpoint-GUID: kTvGDx5U0quD0UChmM7Zu4UvDAflmtL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200151
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

Both DisplayPort and HDMI standards define a way for the Sink / display
to notify the Source / host about some kinds of events. In case of HDMI
it's as simple as singnalling changes to the EDID. In case of
DisplayPort it's more complicated and requires actual checking of the
DPCD registers.

Currently USB-C drivers don't have a way to deliver the IRQ_HPD
notifications, leading to missing MST notifications. Provide necessary
plumbing to let IRQ_HPD events be passed to the DisplayPort drivers.

Note: the Yoga C630 UCSI driver and Acer Aspire1 EC driver are not yet
enabled to send the IRQ_HPD events. Both of them would need some more
reverse engineering to find out how the event is being reported by the
EC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Change irq_hpd arg to be an enum, possibly desribing other uses (Toni)
- Account for that, chaning the API accordingly (with_irq -> extra,
  etc.)
- Wire up AUX bridge notifications
- Link to v1: https://patch.msgid.link/20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com

---
Dmitry Baryshkov (6):
      drm/connector: report IRQ_HPD events to drm_connector_oob_hotplug_event()
      drm/bridge: pass down IRQ_HPD to the drivers
      drm/bridge: aux-hpd: let drivers pass IRQ_HPD events
      drm/msm: dp: handle the IRQ_HPD events reported by USB-C
      soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
      usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

 drivers/gpu/drm/bridge/aux-hpd-bridge.c        | 11 +++++----
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  4 ++--
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 ++++++++++--------
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                |  7 ++++--
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            |  6 ++++-
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 drivers/soc/qcom/pmic_glink_altmode.c          |  6 ++++-
 drivers/usb/typec/altmodes/displayport.c       | 15 +++++++++----
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c    | 11 +++++----
 include/drm/bridge/aux-bridge.h                | 13 +++++++++--
 include/drm/drm_bridge.h                       | 31 +++++++++++++++++++++-----
 include/drm/drm_connector.h                    | 22 ++++++++++++++++--
 19 files changed, 138 insertions(+), 51 deletions(-)
---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260414-hpd-irq-events-e72bc076a5f1

Best regards,
--  
With best wishes
Dmitry

