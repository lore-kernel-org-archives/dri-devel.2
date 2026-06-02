Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C5CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E1410ED9F;
	Tue,  2 Jun 2026 09:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPWi6W7B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2TthHdO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571EE10ED9E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tna21855109
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=awHtfwv62FDYoJPHVP74JH
 igRujnG/cfDkq7vi9nyXA=; b=bPWi6W7Bcm9gqlft8aFY0OLMxyXLSp70l4Fm7d
 74G39AIzU7tRJezbt8TTn2PiH/89mxXnIZrwrgCEY7+mIuDqrF+t7d38Uxgd5Kdb
 c2T03WfXIMaBspyGwYyrJkCZPqyyCEdYXVljsdhXg8MwxF7GwlXOzF2yXIUGgpaM
 ntveG5ZLF8qRfbKJfLAANdCCkRtZu/HsKtD4WyMIhGmUMTqtH5xR9HrqIcKOpCwR
 n+vOv+IqP6TV8ymLOf/zHEkHQdYmmPDalryZ1GchGjGMqtyPlHQEnFft4uQTDdyw
 3+AIvlCbmN2JQj9SgoDzQyqiMlXqanEfq50qUzo7u/A0/w0g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf78st6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175bb9d47fso33388801cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391481; x=1780996281;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=awHtfwv62FDYoJPHVP74JHigRujnG/cfDkq7vi9nyXA=;
 b=B2TthHdO2Axx5cLuReQfAila4fH364qUmVxXhTQG5pvSHs7xHVKkESR5Kdtx8b3bPM
 B/dL/yJ0mlE/eDcA6+uSC4U06oXHicv5aM3WiM4TlEc5B91Cn8XuSwdSAx5QQCu8vhOT
 psZEVH2Zxc9jLLiCQ/jKtnzTUZ97Y/tmDvfgZO2HE0DEvX7ESVI1hkhkXMmAe/lNgLw7
 sW4JeCUMg/eTS4RgD9WIRR0C6JQro5+sNBVei6esbAmYwGL5bcNXRtpiJ6Ar7mxDbFTR
 LzOM4jLrpIfT1/f/uAwq5hzjkDF8ODYCH6NiVo2W0BRBE1/wLEJJqFDRbO7VKzBoV4LI
 n9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391481; x=1780996281;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awHtfwv62FDYoJPHVP74JHigRujnG/cfDkq7vi9nyXA=;
 b=fmvpQAL4lzKoeFRlAl0iYXjsTthavH4+sGstAwB3xKaBzVoBXa8ayPEK0X9mFMs37E
 1mKdIyVg5ik+/NMr2OW/XHZ8K8UMBx4GPzLDwGDp3Gn9xSuagax1oiVwR/UlnmRqUUiP
 0xamfxEfVMhsL/ooEwL2o6LorAof+gGKt9F76MQTt2mGaTYmPHA8/dqjrYFEGFHH48q0
 QIvhO3i1hpRclYYlam0yd//eg8MhFIzZImFd4lnsnrSAbRZbak0ON4RPXEFRclliTHNR
 0v3IzRxv9ePgbnY+KyGzgQzpPYMm0xnjsKSLI3Gl3cInoRSYNXo7H6rOQ8xLh0b0AS+G
 aa2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PMrNJMXU2YVFlnEoCFAknKuZa4vXJahNmu4sAoGqor3T4i58+9haNTCfv06xdJMspqzuNL++VCEM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG+IHQb6TPGg4vgnMOrJz3h6ydSEqEtLaru/ku/o16pFsMVSR7
 5lnYXsb0enQGuD6lKcr9cLmZMoFFU8DiX/N57Vp1NC0Jvs/ax5DyrGJiYmHkPvbjm+K7Rwz0mpX
 5TPBktRPLKa67gS4YOsfqD62LCpAk/JDfTyM8MqltYVa54saGtYYpWQUQfwc9RjEYR2HW77c=
X-Gm-Gg: Acq92OHGW1TVbWaCJhtX+5P7Y8rbcgwj7j7MMqHBz2yakfyWNTe8//dkcQz4yX3sbtO
 ByOaV5N/l13D1GtJe7E8xLku53Vm3k/BiE1kkn5rEZw8fTowRldaqAqmqM1T20Z+1oPyMplTFFe
 Ywh7ueXtuSq1lHyfh8WUlYNjAajLwk8dNKZ9dQxn7IlfLBaKUvYZGMw9Nu0xD28aSwM2EF7A+Hc
 bWfEC+4vCvHtWhwbipmxOsA0U5AUNTQRP9SBnitFuyGwKl/MzAtPTXdDt5kQCbeflWNUZXCgqwg
 zg7nXeqs4PSq99p1Pdn6dy8djthL00MdvOdO5VNI5TZS2BphsPThbBL8+TE9GuVvRLUK/Hy5yLP
 +h+PD2+rLvC44Xf3+DyYN14Cv1anD+kbyYnXgy+MaIRdROH2kGJZtq4ji4iMFaOAIa0AuQ6pLQq
 SyWUG0cyNVUO+fhINjyw==
X-Received: by 2002:a05:622a:989:b0:516:ce43:f4ee with SMTP id
 d75a77b69052e-5173a73a8c7mr201325101cf.20.1780391481559; 
 Tue, 02 Jun 2026 02:11:21 -0700 (PDT)
X-Received: by 2002:a05:622a:989:b0:516:ce43:f4ee with SMTP id
 d75a77b69052e-5173a73a8c7mr201324751cf.20.1780391481138; 
 Tue, 02 Jun 2026 02:11:21 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:20 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v6 00/15] drm/msm/dp: Prerequisite cleanup for upcoming MST
 support
Date: Tue, 02 Jun 2026 17:11:12 +0800
Message-Id: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCeHmoC/22Oyw6CMBBFf4XM2po+oA9X/ocxppSpNBGQFojG8
 O9W2Lq5ybnJnLkfSBgDJjgVH4i4hBSGPoM8FOBa29+RhCYzcMolrbgmzfPWpck90PbEU1M6tNp
 ZXkK+eEb04bXZLtedI45zlk57CbVNSNzQdWE6FagaRSmy0ogSpfZaCqFdJRl1nltUUhldSyng5
 2pDmob43oYu1Sb7u2mpCCXWcM4c88yL+jykdBxn+/i9PeaA67quX4ItB4T5AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3278;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=MvPTm+UIjOY/okBZfSTmYHFCIp4/Opc3YSafdUHz3a4=;
 b=EKTp8h2GS4NyoMMz35w3D43Rb65ZX5PCIiKJ0pdIRdFqY+m+I/GdUEGRzbcup8zxWixmVRcaH
 i2uNDWIvpNvAipnF+j5y0z6ez+C4qAJnm5kKUiL8PKbFRHrQqaIlQaY
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1e9e3a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vykuwZLdp5Yjkddl-pAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: RkhZ4Pam4fRrMg1_5DY8C5cOUIUzfS1n
X-Proofpoint-ORIG-GUID: RkhZ4Pam4fRrMg1_5DY8C5cOUIUzfS1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NSBTYWx0ZWRfX/lv0Z2MzmjJi
 Nd/KvH32AlfIMEbNhRT78rmmCHs0NS+waYLvsGkUSmf8VWlD/IHFcEk9DT8JpsjZ5MfbdjQyWvq
 Ufq14GTmPXt6/RRtvrAih5HyunAcJoUndHLECR4U+D4N2cT0A5UGJXhCUVSDgiGQtn3H6mMCobm
 AKZhuMa0J28A+UR4d2Xjf6Wo3pXoRgdQd1qOir+Yu+XcHrFmOf7Fony0VVQ18j3SXmxn0c4dsdw
 EFHkSYnkn95q6m5fhDia2wNrXUk0b+yMkoggYwHMgAZRADCpahS4ol+WQj6DLbe1xyIq3Nw7jXa
 m305/gJcduVcVDaj6UDCRdg8vXetOhGA0AJBuT89N1A9EtdMzFTPhxHzEHl6fNDmCgBHnP+aA0K
 RK84nbIRXm9XIyEEp6PZyqyKAFgaO4fHYvelELnismiu5xmHiZ6N3KMVCOcswZVlBTvhnd2GxBw
 H/Qal+5Iy24HhoztV7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020085
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

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
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
Abhinav Kumar (6):
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use
      drm/msm/dp: separate dp_display_prepare() into its own API

Yongxing Mou (9):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
      drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
      drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: split link setup from source params
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: simplify link and clock disable sequence
      drm/msm/dp: pass panel to display enable/disable helpers

 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 383 ++++++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  30 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 273 ++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |   8 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  43 +++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
 drivers/gpu/drm/msm/dp/dp_panel.c   |  75 ++-----
 drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
 8 files changed, 452 insertions(+), 389 deletions(-)
---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-dp_mstclean-f094cea8ca24

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

