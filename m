Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514BFC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD6E10EC4C;
	Wed, 22 Jul 2026 06:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="axgYQO/D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jWh+c4/u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FD310EC43
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53fmQ4027263
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JG2b+5eP8LBC7VH//lLOF3
 b2Ezw8Zppg2nAXqPwttGw=; b=axgYQO/DAbo83b9JFd1i3/i2dG2r7vkmUK8hrU
 zMIF+aqIqnEstI7+ObmpEYRYUcsQeI8qIL0CE+RIshTcfe56EEdliBg9up4ytpIN
 5fKcUTWLMbs8arVH98mpRY/kG+JVnx0VUy+T6ewJ+W5dM5S3L3oQ3OEJ75+hc8k4
 4qJLJyLiNMr3GcO0Y7w42XG0qoXtciIS1GU0dipXS4SdDCNbXY46jrEFSap6MMVk
 U3VWK7b91Ovy/nxahYB5f78CJcf6kNoC/zQvVuRaaFeBN1N6eF+lAhlkk2KDdSPN
 BcVFLuB+xVCfily6UzwO+r1z5BnylsGBy/6IWi/r0DU93khw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbvg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso247017331cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702188; x=1785306988;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JG2b+5eP8LBC7VH//lLOF3b2Ezw8Zppg2nAXqPwttGw=;
 b=jWh+c4/uZglelC38VYynLOqINrWzCTKkua6qSzpXtsPLEashgEKEc3txA0gVnHdkwQ
 P69LB5GinROR6ZZDEaSBXEEzZ8sSoEf+P9LE/Cxpm5a/mA2m5YvEj95ED8uJFA3ZDuWC
 blCEh3VfKPqzq9wSVJ+twtGhTMYKPCiPhzONZOCMwwfVOLTsened9BgWPnois/XWArFd
 ArlRVWEGcy8ppPa9I+fsaveuGQQazBWMR3zSxQ+lgkvnPCgqpxR3xqmoYNhTVuoNp0SZ
 fsUgs7q8o/78d2v7WhSSmQVAxFltlJZVDjgCg16aHzR6wdm6CVMkI0hz5eTbybzBTb+v
 w9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702188; x=1785306988;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JG2b+5eP8LBC7VH//lLOF3b2Ezw8Zppg2nAXqPwttGw=;
 b=kWLcbok5GyQOW7dYyQgTHvoKSYkS4ubdO38IfWAMRVedMDD8G91xnpu61lrzoAcmSb
 ZDEWH/A5/it9Vn9CtBq2prxtUSrsZR0/IrZF6XZqsWWijycltywYkDgTqAKgAg1atTHN
 is66Gbclxh6Jl0JqxHcCms/TdeMQAM3ycqb+iii3RN+ortP/j4cxvMyjkfiZZddNZpjZ
 FlJg5ri7mG0sw5DN9Gzr66Qv89uoi/wUpy2wC6I6kRmEpHREnxcxI5WgLoOQWV5LTZeu
 69C3cchtTznh/VFMIAQhXCRX8+1SHTpYdar8SnDTinDYzPgfydh6v1N2S4B70NaBNayR
 B9tw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzyMLfrcQ8MLrpnnb14/hCBesPEOY1QQeW2eKlWIJKY0f+XQ8lgcqSIBRBZweba4IAikMKlymNycY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzJcrcJdMrO6hFotxGOKF9luyuUtuJ+no4sJVOHu7KjN/eM7w+
 NxguWS9FSxavGV4+HxtnEGoEm3HNB4BQsX/NKesr6XwAXSvwlRTNf4HtCW56KaK6mkk9YqR2CkJ
 xJxvhQ5i5wcJLLiCHTFk0c7bkRMsNpdX+KveAQFseYNOUAlCcTJnw89fTvFsRt/utZXyOw1I=
X-Gm-Gg: AR+sD11ofrfP/dDWAX/ErXNDcV2tlIBRfjvN2FLdNeDvrhq46ifcyyHG8oblctl16Px
 Ay6F2NqVGHlXyoXPIjOnh7NWbSw+857peLDKfibT7VM6g0879cy61wXyUmmvob83PYRegFC0bNt
 mP/+pkjuSFG7QFaGOkENL1oVGIk2ng6ZwTAFuN324g/fnj3Et2KSjfWXf05MLcAaytJsj1SoW2E
 ehPiB62m4+idHkZ7O07ayFScjY8aTUjYkO+dMjjEbWrANv0JAtfCiWjPxrVQzONvDIe6+XcR+uM
 9UKE/vQbx8hFh8EweSAEe4G3VKJC3l9uWX4x4iOlNASVlcVgUKL9DfaYIoEnD71NzSPhD4YAN65
 VNyU35gjeRmp94ZI56X7R8MIYvhsWUnTw9r4nBbqmWp6g+GHFLFODhPw2HraPD9UuNSoka1DM8p
 Hpq0qboK+esxjwMQ==
X-Received: by 2002:a05:622a:4c8e:b0:51c:9ad:d77 with SMTP id
 d75a77b69052e-5213e082205mr201712521cf.51.1784702188241; 
 Tue, 21 Jul 2026 23:36:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8e:b0:51c:9ad:d77 with SMTP id
 d75a77b69052e-5213e082205mr201712341cf.51.1784702187807; 
 Tue, 21 Jul 2026 23:36:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/24] drm/msm: introduce the struct msm_display interface
Date: Wed, 22 Jul 2026 09:36:15 +0300
Message-Id: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9kYGoC/y2NQQ6CMBBFr0JmbSM2gpGrGBbtdNAxtkCnGAzh7
 hZx+ZL/31tAKDIJNMUCkd4s3IcMp0MB+DDhTopdZtClrsuL1spFr7x45ViGl/koDoliZ5BUZRE
 Jz7a+ugryf4jU8fxz39qdZbJPwrQJ/4tI45SjaZ+BNUIKe+85NUXOHLdUoDlBu65fVwp3/60AA
 AA=
X-Change-ID: 20260722-drm-msm-display-interface-5bccec4b69d5
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5209;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=g5zWr9M7trO4ZkcWkuzmoxKaNBkS8toEZhFm1G+4kKc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTmbP1b3GbMS2/NRkl/VAvyRSzGH+Rz1VjZM
 NoVGhlphyyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5gAKCRCLPIo+Aiko
 1ahtB/kBDCSTjdGegh4fTT5OexxU23T2bkgKDVfv6dtpCnuPhSe4V+JsfONoEZ3/edbEfTNj11J
 W1NBu0vdMpj0iB78txUGoW56l0ZDu81L7JDON2AhwrSzl+0k1SSSXrQVcJrd4K14SMzhsMkTSWW
 rw9RzV8AwTxlNZ3ppwxc+VeUFGa2z+1s5Fi9cJzuNw00rLfgGkyjp82XPRszqips1wvIJG4Evtj
 B7knmqGeR50EWfaPMg54B9ElCVFk9GOwNQYp5XrW1aLvg11NmDqRyKCZW8Olwnozk1WJvCc5AnT
 tF/7ttQ92T99yLohHQvmpa+RKTd/FunUFgOJxhA3CTS0Os9X
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: -Nm63QJtLGWMORAMDyOGFq2-6nOUQEA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX9npW3DIbYw+6
 UAqAJuPxS5Ne2rJhBZzUJfBXE0jTpIFb+k9jsfisuFiV3aEJVckwBZS4czk7RiEtvLZ3t/96OMF
 Nlzv28OBoHxjPsuh3dxOPsXHsSd/DQ6cnmqSmODqIKOTTG2pSuGHSKapvGuxfeefGhm2WKb2xuX
 jnO2EE+l35uKGbeNDrSdViKkmxM4MAO6XEZPusEtO7RPUREsiHu3+GCmOzq8UfbhHCc/YZJSiaQ
 7DFsJOBhMT+/ac7055CrWdy/LUAQv+Zw/0KZcZIpgDbW+13StGJb1Mf69aZM6XyC+u+BOUwi6a3
 wlVvBv9Z7opUJOBYqDaqLqopOpOjBAXma508HjbAsWjiYN2lXgmb9mRsPYK+IAJMMnXjAD9jdym
 GUjBPcmgf/QN+tpiABuGfT8P3zgbabFpdFqnRngHscSWU45C4dTUkeTE1DGXBMkf2q+Uigzxnst
 on64WqgYwMId9NmbBzw==
X-Proofpoint-GUID: -Nm63QJtLGWMORAMDyOGFq2-6nOUQEA1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXzVjSaaRtE8h+
 IjW0j+N92celoshYUErNF0m/TozpWWu4XzXyI25X3Bk+OHuSKS15emJfqGvNromr1ERsM293VH6
 xfkzmKikIq+jBN0DgZI4BzKq7HXw7JA=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a6064ed cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0w9IUoAH-FZ3DHrqiPYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

The msm KMS core and its DPU/MDP5/MDP4 backends reach into the concrete
DSI, DP and HDMI sub-blocks all over the place. Connector creation is
open-coded in each backend and in each sub-block, the bonded-DSI dispatch
is duplicated three times with subtle variations, and every cross-module
query (command mode, wide bus, DSC config, tear-check source, peripheral
flush, snapshot, ...) is a type-specific msm_dsi_*()/msm_dp_*()/
msm_hdmi_*() helper reached through an interface-type switch. In the
other direction the sub-blocks cache drm_connector pointers that the core
has to hand back to them, coupling each sub-block to a connector it does
not own.

Refactor the MSM display / encoder interface. Introduce a small struct
msm_display interface, embedded in struct msm_dsi, struct msm_dp and
struct hdmi, and fold the per-sub-block operations into it one callback
at a time: modeset_init(), snapshot(), the wide-bus / command-mode / DSC
/ TE-source / peripheral-flush / bonded / encoder queries. Once every
cross-module call goes through the interface, struct msm_kms can store
the sub-blocks as struct msm_display pointers and drop the concrete
accessors entirely.

On top of that, move connector creation into common code: each backend
now only builds the (genuinely backend-specific) encoder and attaches the
bridge chain, and a shared msm_kms_init_connectors() walks the encoders
once the bridges are in place and creates a bridge connector for each.
The last DisplayPort-specific bit, attaching the DP subconnector
property, is generalised into drm_bridge_connector_init() so it is
applied to any DisplayPort bridge connector rather than open-coded in
msm.

The series incorporates two patches by Yongxing Mou from [1], one patch
is added as is, another one has minor fix.

[1] https://lore.kernel.org/dri-devel/20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (22):
      drm/msm/dp: reject YUV420-only modes without VSC SDP support
      drm/msm/dp: drop the always-true yuv_supported argument
      drm/msm: create the display connectors from common code
      drm/msm: introduce the struct msm_display interface
      drm/msm: route the display snapshot through the msm_display interface
      drm/msm/hdmi: capture the HDMI registers in the display snapshot
      drm/msm: add the wide_bus_enabled callback to msm_display
      drm/msm: add the needs_periph_flush callback to msm_display
      drm/msm: add the is_cmd_mode callback to msm_display
      drm/msm: add the get_dsc_config callback to msm_display
      drm/msm: add the get_te_source callback to msm_display
      drm/msm: add is_bonded and needs_encoder callbacks to msm_display
      drm/msm/hdmi: use dev_get_drvdata() in msm_hdmi_unbind()
      drm/msm: store the display sub-blocks as struct msm_display
      drm/msm/dp: do not reject wide-bus modes while a YUV420 mode is active
      drm/msm/hdmi: cache is_hdmi instead of storing the connector
      drm/msm/dp: drop redundant panel->connector
      drm/msm/dp: use drm_display_info in mode_valid callbacks
      drm/msm/dp: guard subconnector setup on the connector type
      drm/msm/dp: stop storing the connector in struct msm_dp
      drm/msm: create the bridge connectors from common code
      drm/bridge-connector: attach the DP subconnector property

Yongxing Mou (2):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_pre_enable

 drivers/gpu/drm/display/drm_bridge_connector.c    |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  64 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           |  52 +---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c          |  26 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c          |  11 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |  19 +-
 drivers/gpu/drm/msm/dp/dp_display.c               | 353 +++++++++++++---------
 drivers/gpu/drm/msm/dp/dp_display.h               |   7 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                   |  30 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                   |  10 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                 |  62 +---
 drivers/gpu/drm/msm/dp/dp_panel.h                 |  15 +-
 drivers/gpu/drm/msm/dsi/dsi.c                     |  71 ++++-
 drivers/gpu/drm/msm/dsi/dsi.h                     |   8 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c             |  18 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                   | 101 +++++--
 drivers/gpu/drm/msm/hdmi/hdmi.h                   |   7 +-
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c             |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c            |  16 +-
 drivers/gpu/drm/msm/msm_drv.h                     | 135 +++------
 drivers/gpu/drm/msm/msm_kms.c                     |  90 ++++++
 drivers/gpu/drm/msm/msm_kms.h                     |   9 +-
 22 files changed, 636 insertions(+), 474 deletions(-)
---
base-commit: b2128290c29902315e632ea59e0504d6bc9e9b42
change-id: 20260722-drm-msm-display-interface-5bccec4b69d5

Best regards,
--  
With best wishes
Dmitry

