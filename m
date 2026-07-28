Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFBDC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3A210E545;
	Tue, 28 Jul 2026 10:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPJZmu95";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/iagPjZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B750610E42D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82uHO2276192
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=k8XTLlBbBhkHOutm9hULJG
 eDDzcY4ZTHIOHZViR0U8U=; b=OPJZmu95ErJ0Jle4ahjW/+fqD+SOPtJ0Bd/TRM
 haYzXarxO2uIBJWB0oJAg3VoT8Ndsw51Pct/dciiZ3TQskIVjyI9QSQM0JzBEOkU
 G41VSOVPjVDtHf4mGaSo2Ku0klbJwp/hC/ppkXKEwfW5PF1h9ygw8sGuX7ZCzdPt
 HeIzygMX9EIN5f0rop3dAeEgkn/Q0hw8IRv0M1BfjE1aSk3odT82uwp1J4dXqerg
 eVj34oTHfjz21+7hcwe5MrjYL3WcJ1Kb8QfsHZL2Yftt/J4cuMEs1z/XMNESXwvd
 c5O77Q2b06b0TEa2MMtEKuMONpEfNS/s+k6jfassqUcF5J3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsupuw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-907c59bd73bso72332516d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234101; x=1785838901;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k8XTLlBbBhkHOutm9hULJGeDDzcY4ZTHIOHZViR0U8U=;
 b=A/iagPjZRF4qXELhGfBwNx19/K7TMzoWlOLzMHpuMrgglHPc/QKvjvYi/EaH3XnzK5
 t5M+z3v7HNEnET1fEeEOupQJcU6LAPY+49BB6q2UC4VbXOHz8HQCcLU5w8uEZj88Oi0O
 jGsAiPyRitJw3DEXko3gHg3giNjIM1D0AKydGVbg3BTL3emzsbexWmadfQtX4Hla40HY
 PXfhKC4Q5ULsFJepg7u+FpeohLxzHuwCzv/qGSuogjtghYIR0RrFRCaG66A4eZBzS0L+
 Ec5oTHJvKbE+x+PTPZ5Aa4pncfh4E2IK6jYHQvXhhxxYTMQd3eKZ9os8Q2R00S4gJ/3H
 Tzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234101; x=1785838901;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k8XTLlBbBhkHOutm9hULJGeDDzcY4ZTHIOHZViR0U8U=;
 b=lHuNZ5NrMM35Lde7w+e5A14vxPUXZJoKGA1rijYBW0Tx51ai7zxVsQX4JtB4xc613c
 /LerJjFhP/hiYTzWPJYIgUvCvaJWCK85MU+OkTZg3HcfVLQZG41MlStGYTWus4tul9FJ
 lDoNPl78rVK+sFmsMvbJrWJiBUUy0t138/1zuZrz0r/dXmDHxoCG3jO/Ki1gEGrk+Aul
 Lq5axhP2wEWpJknuKvO4A0ahd6LAgtX5WAAmqUJTXfbp0iB3+/Gw+Lkz6FPoymbNzN13
 hBgr/FBHvILqyo1btqNwjPUEw3Zqcn/em6IozFJqB2mM0wJYmWD2R4W8YP+EAp6WMzGQ
 Ga1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUfiu7HBBrqTBJ2WgNKoCFosEAgK/NEer0rWhFxVOw4sYR9S+TWsl33IMFCp/n7kWMWXM9Kzp3vvI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwntqMzfiRAMO/6GANxxHF83i6TxWVAqH6VoFsFJwVwLFMYDX7S
 ljei8phmxMKcAQzHGMWL7/LOda4zATcg80IVHMUpkrTgaVOt91UPubDKfLe7vEkXpKj3ZNUmUNg
 QIjQBIl5MAOS2phM5n53rTuuU9LvNsgpJtuOwHHSwYSIMjyaiSCWDZZuNojyWZVkVTpdGLRo=
X-Gm-Gg: AR+sD107x/nG5oYuokyaAI11aoah7HCTP/NlM3vtw4E4jcufTAbLzRKtg+q52IBv6Ba
 utaW4C3HOcn5GEI1jx8qC/P8eFs3V/IOytf/Y3L2wnJBixS9n9ryZ0p7OCv7xY9GYe18GEplerS
 r7gcqMtQXOnosdwhnlOenZ5Z39qSCgDi6+STAQ58OkrBARs/fBBE8QF5lMpiVKdTEJkjuEApvWM
 hz568P6lkJayj0azriTxAqiz+rX5GDSJReNGBn6y179hCwuPfePCAlAwZ4n5mh/rh8hm+/nMDhj
 Xmh7YSui5IXxDr7TzNNPH6Jcg0m1D1qskh0f4GOedmYt2zAibCuZz7LyEduHPgLjv4Z1Z3c4+zN
 iPRuih4atlBYY5MkW5cWIpCbqjLJ629D8kSmSpgdLxtcTpRGP4uL3NdN0/R51EAw=
X-Received: by 2002:a05:6214:328a:b0:8f4:d86:ec0f with SMTP id
 6a1803df08f44-908172f03e2mr16435416d6.27.1785234100753; 
 Tue, 28 Jul 2026 03:21:40 -0700 (PDT)
X-Received: by 2002:a05:6214:328a:b0:8f4:d86:ec0f with SMTP id
 6a1803df08f44-908172f03e2mr16435176d6.27.1785234100331; 
 Tue, 28 Jul 2026 03:21:40 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:21:40 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v9 00/14] drm/msm/dp: Prerequisite cleanup for upcoming MST
 support
Date: Tue, 28 Jul 2026 18:21:29 +0800
Message-Id: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmCaGoC/3XOTWrDMBAF4KsYrasgjWz9ZNV7lFJG8qgRxHZiO
 aYl+O5VnEVqSDYDb2C+eVeWaUyU2b66spHmlNPQl+DeKhYO2H8TT23JDARo0YDl7emry1M4EvY
 8ClcHQhsQalYuTiPF9LNqH5/3PNL5UtDpvmQeM/EwdF2a9pUw0oJV6MH6oJwwJIXXErWvPelIE
 WXwHiK7WYeUp2H8XYvOzYo97TQ3XHB0ADLIKKPy70POu/MFj7e3uzJWbtYPQgvYEroQEKSJsRb
 oPLwgzH/CbQlTCEJRS6nIglIvCPsgDIgtYQvhCUFLH2sy7RNiWZY/JU4jfsIBAAA=
X-Change-ID: 20260528-dp_mstclean-f094cea8ca24
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=4913;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=gtymclkuEBC4Gtb94q3hrKBPv0k6dPhp4Zvr7BCSBZc=;
 b=oegzPO8otejUM5f4IcbJYl4OPhMycVz/WsBZm7Vs0UxhdDOBrAhCuXOs0BaA4gslJ6kZNbQl2
 WaG5Fj7c3f7CFiXJFl7KHkjw5JBQqKGkocYi5w/+TV8Jq86a8DR/JQs
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfXx20nOI7uEkHL
 4azfBBqlxuDBw923qTTVZNmdfJsc2VDOVT1mGyyHiYHgEEkPznv4ZcoQkhGk3bD1tAIwf7R1SzT
 j4eddknC76FoFcs/BLe6hYgzIXP4q4zRb3TuS4ClFbKg+0nYdFJnTJQvZtRXLUeCDE6GL6FqSo8
 1bXwc4mGM2TC71LxH5oFKDXDJgTlAYjuAhkhLlyNVHJXhqSjpLwLH0B9pz5pJcl+9Qx+iWiDMv2
 H4WO0Put59qUXaWoCUqzsnF22J+BIj94gaXl19DTEYNLxBpw8aJlJ8B6ocGokwchavp4+fAfGrg
 c9wOn155DvWtUv2rUW/rhiPe6yXD8qzmG0T/QCRkh7DdcXIdtYNu4MRxbZ0grsphQtA+2ek1Cml
 eUv4fhruJifHJynN1HrKxQlmwKMYHc1JgS2f9p6hsLTuVE4sPC7AZ2kEudY5RlO0T0y+s/JgcSv
 aE+Jc5EjSdbuseGVGNg==
X-Proofpoint-ORIG-GUID: SIkrtTnK8vSPcc2uwGM0Rnx_F9YEwPPz
X-Proofpoint-GUID: SIkrtTnK8vSPcc2uwGM0Rnx_F9YEwPPz
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a6882b5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DCnoF1gdW_jtja5s6fsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX3HL1uO1DkPPy
 lsMJ0922L/v5Or3jDhJZiDxxVNN8J86FkhG1SkVWiuaNP8kSVBaN9xk62M+llJ3dVONSILhdiAT
 gN4Yhnhk3mn77KN87FOGAABS5SIEVYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280091
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

This series is the SST-only prerequisite portion of the MSM DP MST
work. It refactors the existing DP code paths so that MST can
plug in cleanly in a follow-up series, without bundling the cleanup
with MST functionality in the same submission.

SST behaviour is preserved end-to-end; no new functionality is added
here. The intent is to land these refactors first to keep the
follow-up MST series focused, smaller, and easier to review.

Patch 01 and patch 02 pick from Dmitry series
https://lore.kernel.org/dri-devel/20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com/T/#t 
and no code change, just rebase on top of it.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v9:
- pick patch 01/patch 02 from
  https://lore.kernel.org/dri-devel/20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com/T/#t.
- patch 04: clear Clear the stream-specific fields before
    OR-ing new values.
- patch 10: move the panel->hw_revision assignment outside the conditional. 
- patch 13: also move atomic_pre_enable from dp_drm.c into dp_display.c and leave a thin bridge wrapper, matching the pattern used for the other bridge helpers.
- Drop "separate dp_display_prepare() into its own API" due to patch 2
  add .atomic_pre_enable() and don't need it anymore.
- Link to v8: https://lore.kernel.org/r/20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com

Changes in v8:
- Rebase to next-20260717.
- patch 04: also call msm_dp_ctrl_config_ctrl_streams() in link_train(). [sashiko-bot]
- patch 07: propagate msm_dp_ctrl_on_pixel_clk() error. [sashiko-bot]
- patch 08: return -ENOTCONN on sink_count == 0; return on link-train failure. [sashiko-bot]
- patch 10: pass panel to config_ctrl_streams() in link_train().
- patch 15: use passed-in msm_dp_panel in msm_dp_ctrl_off_link(); fix kdoc name.
- Link to v7: https://lore.kernel.org/r/20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com

Changes in v7:
- patch 7: Use WARN_ON_ONCE() when pixel clock is already on. [Konrad]  
- Link to v6: https://lore.kernel.org/r/20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com

Changes in v6:
- patch 4: fixed the RMW comments. [Dmitry]
- patch 10: do not rename the existing struct. [Dmitry]
- Link to v5: https://lore.kernel.org/r/20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com

Changes in v5:
- Split out from v4: only the SST prerequisite cleanup (patches 1-15)
  is sent here; the MST implementation will follow on top.
- Rebased onto linux-next-20260527; adapted bridge callbacks to the
  new drm_atomic_commit* API.
- patch 3: added Suggested-by: Dmitry Baryshkov.
- patch 4: fixed "splite" typo, reworded body, added RMW comment
  covering both SST and MST paths. [Dmitry]
- patch 10: drop cached panel from msm_dp_ctrl_private; pass panel
  explicitly to all stream-related dp_ctrl APIs. [Dmitry]
- patch 13/14: introduce bridge wrappers and atomic_prepare with
  drm_atomic_commit* from the start to preserve bisectability.
- patch 15: fixed pass panel inside the func. [Dmitry]
- Link to v4: https://lore.kernel.org/all/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com/

---
Abhinav Kumar (5):
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use

Yongxing Mou (9):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_pre_enable
      drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
      drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: split link setup from source params
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: simplify link and clock disable sequence
      drm/msm/dp: pass panel to display enable/disable helpers

 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 390 ++++++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  30 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 283 +++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |   9 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  52 ++++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
 drivers/gpu/drm/msm/dp/dp_panel.c   |  77 ++-----
 drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     |   2 +
 9 files changed, 477 insertions(+), 395 deletions(-)
---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260528-dp_mstclean-f094cea8ca24

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

