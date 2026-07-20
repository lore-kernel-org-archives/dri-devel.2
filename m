Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF60C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACFB10E12B;
	Mon, 20 Jul 2026 06:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptWTidbL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/l/z3J7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA1610E0BA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:10:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNthVS806605
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BxqLZ7hRz8DxawPShTOWyx
 1Gx5YiSN+QI/HdPPVSBxU=; b=ptWTidbL6sraJI1cUEYGj9uIgvk4FlGuJfLqsf
 2hKXEPngJt/KZS1GemeOF4FjryLhPBFOSIv/UBmkh4Yo53WZtQ5rEaWNZUsUMUd6
 w6nmXdLSlgKG2u99dM6MN9yrclbNGBZNPPNWIw5LcHt/2FJ8iGMwy5qk8IOG/Y6o
 BuS+Ji1b6XUnatKmaKp97BaiNuPJb3z2R72Vdt7UBdFM7F2pKDc0sAQSnZHVmAoS
 uofh1U8JNStsT0kiS67/BL1FZ5lNmEGANYp+8F7Bkk+q7Me7wpRTn+63Xx+it2zs
 Dv1X/NK4iHqFrOkscsjRjDk5Uks4WNcNj2RiLTh5VdFYEb3w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04umea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:10:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso216578616d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527846; x=1785132646;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BxqLZ7hRz8DxawPShTOWyx1Gx5YiSN+QI/HdPPVSBxU=;
 b=Q/l/z3J7/ZL6Adv0e7KcwX9VOn4DL2DgKBcLoaCSJRSSh7HsSQ89pUWCr3lf+I+nXW
 AiA2dZJ0t/e58ozQZutthFpx/+kA6xfuw5QI2W9S7KiQI5HScd4lSmPxkiOLvj/6C67z
 FRSOCmBlyFdLKsNIQmjR+Lx/J1pyc9dq42pXD9Z2aBhEOVQCMPELNG/jxRqQKTmLwyHd
 7xXirZLEP7AHfZpXrs2XUhlxnJtA/lKfNcS1/ZlPWJB6omlNXY/mgFLuMXQZojzSP/HO
 ctWnl+9MvpvOw2OF7NAxFM+zg1lzcxGRAbWedqywlDjuTIkUw392J0nwfAzg+LBQwuno
 4EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527846; x=1785132646;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BxqLZ7hRz8DxawPShTOWyx1Gx5YiSN+QI/HdPPVSBxU=;
 b=gvVznesSxs/GCd8HyjhP6+0AB868hnVcw7REuQ52LcwM/IxADlyBLQnb4BFxuuJA8t
 VsZJWRzP/wyaH7Ash9iGrCgULIO5a3HDq+m6MhH23XetWQcZHzL/GLzthcQsnjZ5bIp7
 N2x3oW4+fF/a/mc3S+bTHpZ7nJPmeCb5m9nV9Tgox7jKJE9dZQSiiKOkhj2Tp3LwBllQ
 gBJCzsYbSW0CG0z2nEcekOOHA2vGHi49s3KWvklFkeJkhwEKr4VYbUl2q48URiUAnUEq
 pTIR47xegJ9AcHciq8bZGJ2m10QU4myQVa02DkmNPRIE7jUqzAjUSNv6M+WP7kmL+MY9
 5EMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkRxpypdQaJgHCwhPXwItdRUzHVABJJG0yIovq2YpphZhsTotUCiY3ENwfq6Ne5nVbTqB/zynGtI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrqhtab97jy6vU4ljVd3MNpMjcQFxFCogS7np73geQzvnK52an
 JAlBDQfc3chFPBpD3DXZ3XRNwN3gr/AO6kmrkcfiDB51ofxVwys5xFEvxNIW97I9l5yfvmHVmBr
 3Lz0itPy9UDAn8v4q8OKLX6Ztp4c0yQnOpstTtMhMXpq/OYmcqUwD2Ro3nLL8s/a7/Hhq3sg=
X-Gm-Gg: AfdE7cmZzvBVo3delwI1k98f83z2MKvcazNGh+bdFgciVajM594SP/VhRhjhFRt0k3H
 jpb7qCm1RCca1Gk0NcKYwyliTJEmGsZI550pfD3oPZAgzLShlchwhxujhOR/CqBZ1mvEMvh7Ueu
 mf3rA9ea5QDsFP0PiSAwplAZPRJcAdYhy9VYP1ppKlJOxtwziBsuwUQoHuRAAv6OcjCdUVaNh4z
 UaYkEaKh1Ml28aTjfGnDpC+bH6bz1xxTQlzb0AmCxXo7DgkFj7hnj3IrbRgjMdVC2Gx3hR5UKAU
 qSB1nU7iPEOXeC5IEC4wEJaLjyRPcoYVIKqT/CrPTF0nEBpjV+jAG8uFJ2Jwqc8GRU9pWqWA+Fc
 DRrWkJLvNIGj3LglO6OA8/WNbeRLM9AORfIkdvfFPRXi3NwdevUCHBm3ykuGw078=
X-Received: by 2002:ad4:5c8b:0:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-9077836870bmr133324836d6.14.1784527845920; 
 Sun, 19 Jul 2026 23:10:45 -0700 (PDT)
X-Received: by 2002:ad4:5c8b:0:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-9077836870bmr133324596d6.14.1784527845427; 
 Sun, 19 Jul 2026 23:10:45 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:10:45 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v8 00/15] drm/msm/dp: Prerequisite cleanup for upcoming MST
 support
Date: Mon, 20 Jul 2026 14:08:07 +0800
Message-Id: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEe7XWoC/3XOwW7DIAwG4FeJOI8KDAHS095jmipDzYrUJC2k0
 aoq7z6aHrZK3cXSb8mf/xsrlBMVtm1uLNOcShqHGtxbw8IBhy/iaV8zAwFGtOD4/rTryxSOhAO
 PotOB0AUEzerFKVNM36v28fnImc6Xik6PJfNYiIex79O0bYSVDpxCD84H1QlLUngj0XjtyUSKK
 IP3ENndOqQyjfm6Fp3bFXvZaW654NgByCCjjMq/j6Vszhc83t9u6li52fwSRsAzYSoBQdoYtcD
 Owz+E/Ut0z4StBKHQUipyoNQLYlmWH2P+2/p/AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3646;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=PJ0sxFhnEHsV2GmP43kohhZ45+dKgPmt9r5NIhHpWo0=;
 b=AI1oX0trYhPs09RMZ1NA0wi/jsPxNHf6r0C9aDwI90c51QoHy2sgaApG7SdeIaTolZqxp+dEG
 7orulGG6Mu9DZGZVrtuxAHs7T9s8DamOuqUxBGNYkG/E4UpGkuEYlDd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dbbe6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vykuwZLdp5Yjkddl-pAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX3m9poBFhPamt
 P1xiRnGb5grpLXNf1bPI0Z3EwUGsv8g9YMjuiaGRFzADPkHpL4vfvMCmqF/q6uldklB6/Wnism1
 FF/oP+9MeSG1MgKDUY7HKZdFjaVnT1FWdqLboKtReBKpt5w3rRaI5PW6q63dxgBgB6TQ8dEA7GB
 Nju5IpbdC7bJNsqQe6qF3r7dCKx0xizqfGcf/5IcAY8j4uPFh9nsLoeFOp1Sr1d1/T9i9aIieln
 231Qh3zFbh/XL1YPPx4yPIGwzY7QEG5fjOCTTcMLR0SUeMEWq9lNVPTcqZG9qoxXvV2Vh+aAfgF
 7azCAdHvTXlbT0aAX7ZcUX5XlgdlXgPuJTKK7FXQ4ooZdCOiif0GBbVUpXn/1L0kUcf0j+mnhX+
 zjB/90P46AHMR/+Xy+FHbDAJpScL0KA0dq6ZQFVlP0Neemzy/bX+2zL9Z0dZI1HPH3x/mQJsfEQ
 UmxE/ueCH3DFl+R6GEA==
X-Proofpoint-ORIG-GUID: MTmIeeoOt8MYWqxmLBPFYnMSRF_rK4FT
X-Proofpoint-GUID: MTmIeeoOt8MYWqxmLBPFYnMSRF_rK4FT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX233O+adDuX6z
 dzK4a8XYyZsKLp14rzQFD6EChjCA5+ZcCDHJ+w9KcsS54F5jAJRzDgQbAmres56TsC5NBXG9MD5
 JTMU6DKT63+Ch4LXMxys+IyeeXOd1vQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200066
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
Changes in v8:
- Rebase to next-20260717.
- Fix comments from sashiko-bot.
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
 drivers/gpu/drm/msm/dp/dp_display.c | 277 +++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |   8 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  43 +++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
 drivers/gpu/drm/msm/dp/dp_panel.c   |  77 ++------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
 8 files changed, 456 insertions(+), 391 deletions(-)
---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260528-dp_mstclean-f094cea8ca24

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

