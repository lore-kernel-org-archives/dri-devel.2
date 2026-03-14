Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC71107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C3910EC2C;
	Sat, 14 Mar 2026 01:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlkxhFpv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KLqwnNWv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B61A10EB95
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DIseGO525821
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HA6kLTIje0xxpYAd7mSNxW
 wuLfQQ/iuxyv2vtM2X73c=; b=dlkxhFpvD3/N+gDFEf5m9duBanS7lPq929mx1D
 NnKTWksDVwLDJyrZyW7pAo/l1xSTQ/ZYeJ2OibOVTZl5O+RqNWOEMF7Ptn042l9t
 XNdBviK+0xgbpM/jIt0rCOJutXQ4mFoh3XpbuIidx6QJvPtJxRMJSzlxGyHTsDR3
 c6PPsAg5MC50dK4FNaCbjzt4tbXh5Wo5zfCGY3oO/CmggQvEQpd7j5ad3F36sBlS
 KNp1qzh+ArILz4xMPtb+jMULC/ZP9fqOp5YSh4iuhMw0OEKf4pVXUPLVpMIOjdH0
 MJ/gZcfktoBU+U2V2m6cakd7uEDV7x9Ks+HEqQwoxUoz8lRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84th7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd83cfb36cso1837859585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450553; x=1774055353;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HA6kLTIje0xxpYAd7mSNxWwuLfQQ/iuxyv2vtM2X73c=;
 b=KLqwnNWvRSUVNpD0Kqb/x/FvK/aHktof7XUfHRNSBm6KFgnFXapg7p7g5CxbRmoxmJ
 9DGLt3hwNEAB27xkP/cvVamlUsSccfrM7wef4RLLz9TJ3fYnVt6NzgxooWOf10Dd99C0
 nvwYBXsfhFqDpaePpagdkT6fTxL7appAJESJuTAlg0BwDWqICBFEoDjxuMrKEqm3Nz4A
 XVjc8Oo5zv01nHo3zExgcd08PRgfgV0dcdpXHukzv0Ry0Uyin+RlSBy9p9WOr++joRXl
 JKtG9ICUhGAleUFZk+SObyc/bHaKCnhfN0q+4qk7lNhCOjUKhu1wd9xjPJC4Cop59VkH
 U/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450553; x=1774055353;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HA6kLTIje0xxpYAd7mSNxWwuLfQQ/iuxyv2vtM2X73c=;
 b=Gxyj59zu05YcxP9+O0DT3FyCpVKiWMt3OU8ybgMEESopY2QCttm8D9+AYA/V0M88b9
 NHr0p63ARWLhhaBLW015eywsshgW4Nz6VhFc/laCmrHTFBi+i6Lnad9wFXOPIaoe4QmR
 irZzViIESa7qYlF1hnVGVxd+c6c94w+y0TnFzitQDOIqvIS09dlhr4SE5Kwv3NMyfK1V
 daauwjw8HqnTKxJJoQ0M8fXFIDsM0+Crdx+4+0XYD9FY1G3hNxu/dBhaPhhz12wd2z4t
 vTlI/16wbhy56rjZOFTkHf18F2eGveJH8HY8qGdl5wNrMAQ2mcba6oFDHJg79WCZZfUh
 6c6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWikDFYVMSS2gdl50hfZUG94ywQzVfpTLLMKQ/oLwOKL5uV/qPGwrLRAds00EM6FrtWxF29q74MuyA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmGuS/25TtcEBJGaYxRNoeMh36rLIXFjMbkCbF+jogFuYlhKiw
 T28gDH4vo0hj0zrF/ANfHJvl77TUwrfwTM0CacqsHC6D7fCI2yicjtIKJT5YCigK03kH0BTgwmq
 gLWu4R+DjGrqLaN9wWsPvwn4WEWEOrfIaOSX45pe0oimF8peWSWsKPwfkxHlNpMMl8ird2gqnKa
 pb6uU=
X-Gm-Gg: ATEYQzxMOB1kN7nluNvaUZg2yyPJi7VC88xNU33SpV/o1V1uVBryBbCKuRN1zRmk5Z7
 P0ycRyJbPKXxdXhrvM9nnHDfQdSoaTmoAdSTUUbVOeJSZSHXl5aeRrxhXV4KgjFyviEq/sdy9U4
 CbzFdXI1fR+VnSTOmtEKa6YInJX2jKpP45nRXzmx/XUULLJ//HwNUyXn6ijqAPwfH7l645a8xxH
 nd6ad4e9UAOxC6BWS/0oRTotiHplwRxkTmjvH2/BdCCgH6FwvsfcX4/1/+xtbQFGW8UKQnW3Q+y
 klnPC3XquWHZ4baaKXObDjElJyP3b+zF2gCXA66p52Y8Ztuz6f9WcNUwsAQhJHvIT4kmfpnJZbo
 5kdtFd4Z4tZ1xeq76++rjwasN7sT/1pee4HKUlaHVNr+6tEHvQf1Tv2GmVgDuKI+qgqUiZZ5FH6
 StKJW7VMUVKudZMZ7OsJxQ0dOkUhTNIipKFJA=
X-Received: by 2002:a05:620a:471f:b0:8cd:8fb7:7b13 with SMTP id
 af79cd13be357-8cdb5a41872mr743317785a.10.1773450552928; 
 Fri, 13 Mar 2026 18:09:12 -0700 (PDT)
X-Received: by 2002:a05:620a:471f:b0:8cd:8fb7:7b13 with SMTP id
 af79cd13be357-8cdb5a41872mr743315185a.10.1773450552374; 
 Fri, 13 Mar 2026 18:09:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
Date: Sat, 14 Mar 2026 03:09:04 +0200
Message-Id: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADC1tGkC/3XRyW7DIBAG4FexOJeU3cup71HlgPFQI9VLwLFSR
 X73jm1Vaa3mgjQwfMDPnSSIARKpsjuJMIcUhh4L/ZIR19r+A2hosCaCCc20kLQdGxrBWzcNkeY
 KhK61NoJZgltGXAm3jXs/Y92GhG1fmz7zdXaHcs7/QjOnjErpausKIb1Ub0NKp8vVfrqh6044k
 NWbxcMoWHEwBBq5V8AhV9xa+cSQP4ZhnOuDIdFgBQgva9cIYE8M9TAkOxpqfUvpyoZ78FLwf4x
 lDyvC5YqRT3tipLYJ6NoUpirr4Ta9djZNEMnv36iy/ViuaDNid9/Ddux6B89MCcbUzlhfYeDnZ
 fkGehb2YeIBAAA=
X-Change-ID: 20250523-hpd-refactor-74e25b55620a
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3608;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eeRWqgukNoan+mjBSybHhhzqIjokDqIPuabMTOAdphM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+aWrUZlMy9csnGPbQ57HdTaUbJxR/3sW2dYzl3vbnmx+
 M79rCrXTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBM5KMo+z+tbe0L7TtOzfs7
 d//kyrfNZf3HVBi7BbMXqeoZHNay16r68upWnKFYugNX0ZrtfD/lOdf9Ci3UXi/62O1k2OGkAJm
 otMCcaXXnH9zJeZUlyvr1MuO5NwXXNgVHqs9akrX5aUNZjsQdhyJZ18lbcyZ/F7c1SrqpXhKfJW
 t+SCY2+XmrXFd6llBawO8jWbtyYr9/Um7Za33wZojiTs/uAPt7H6su1VR6Bede3s9fzR5l0qIk9
 vVKcYjlE+lnbmct9nRMlQrce0WifP2D4lOaLA9YS9rv81mdrp8eLhfbxezJaOfC+ub1nAWKO3uP
 t3ZFOq+tXnzkouoSvl7hN8wPHHwl+fLf3NvQdHxZtn0IAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b4b53a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bp5APB5_ZGd9cemfosMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX8erOVzC28osM
 jFb0c6i7Ovg24TsxcZNA5AKEB9exJwcazHZz+A+TKlBLooBPvSwdofa5ZaN7iCWnh0Pqccf70U5
 GcdqD37F05atm7Z78+wvkYIXhxKQZQuK5EB2LBM6aogEUMyWENZEQqeBJ+/RzkLScEoB6gzza6k
 CastiwoHsSRi/oiyhpSrTMfAHHYNuW+TR7WSYxPiEdMoOt4ZtDvsrHkf3TAyYHfejUYDiQhyTo1
 guzxc1rO1Uv/WGaUY3oFRS24g9HZqSdhENfSwxirnm8wnRDTVTdz1vMIlu7S2kDgcTVF5aLh7ec
 B0DrPPTvcaTIkKtMyBmIow32fIFpM5IT2qnxrQacf07N0tu244xNH6Ikji0G/f83pUKEEY4bTWq
 0doY+I4X6V93rmXGZtYpW1+6m9VReJXwpVEUqp/1C9JA5vkaAoDh1h6bu2Y/28kLz+XvwHm+uHN
 mUg2GwDeTUKjSsI+35g==
X-Proofpoint-ORIG-GUID: mUQ9H3Q-6xylaj0weE7eBhGdJjkw36tz
X-Proofpoint-GUID: mUQ9H3Q-6xylaj0weE7eBhGdJjkw36tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

Currently, all HPD interrupt handling must go through the HPD state
machine.

This has caused many issues where the DRM framework assumes that DP is
in one state while the state machine is stuck in another state.

As discussed here [1], this series:

- Removes the state machine
- Moves link training to atomic_enable()
- Changes the detect() behavior to return true if a display is physically
  plugged in (as opposed to if the DP link is ready).
- Remove event queue and move internal HPD handling to hpd_notify()

To correctly detect the displays which are plugged on boot on the boards
which use dp-connector devices, this series depends on [2]. USB-C and
eDP panels are handled natively.

[1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
[2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/

---
Changes in v5:
- Fixed the EDID clearing on display unplug
- Fixed the initial HPD issue via the external series
- Tested on eDP devices
- Link to v4: https://lore.kernel.org/r/20260305-hpd-refactor-v4-0-39c9d1fef321@oss.qualcomm.com

Changes in v4:
- Fixed PM runtime handling
- Fixed several cases where the HPD machine would loose its state
- Fixed the case where detection was ignoring the plugging in display.
- Link to v3: https://lore.kernel.org/r/20260115-hpd-refactor-v3-0-08e2f3bcd2e0@oss.qualcomm.com

Changes in v3:
- Take over the series (thanks, Jessica, for the previous work!)
- Major rework of the series, squashed the set of patches touching the
  HPD states and handling, it is easier to do it this way rather than
  pulling the strings one by one.
- Link to v2: https://lore.kernel.org/r/20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com

Changes in v2:
- Dropped event queue (Dmitry)
- Moved internal HPD handling to use hpd_notify() (Dmitry)
- Reworked bridge detect() to read DPCP and sink count (Dmitry)
- Moved setting of link_trained to plug/unplugged handling
- Dropped msm_dp::connected (Dmitry)
- Squashed all hpd state related patches (Dmitry)
- Link to v1: https://lore.kernel.org/r/20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com

---
Dmitry Baryshkov (3):
      drm/msm/dp: drop event data
      drm/msm/dp: turn link_ready into plugged
      drm/msm/dp: clear EDID on display unplug

Jessica Zhang (7):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values
      drm/msm/dp: Read DPCD and sink count in bridge detect()
      drm/msm/dp: Move link training to atomic_enable()
      drm/msm/dp: Drop EV_USER_NOTIFICATION
      drm/msm/dp: rework HPD handling
      drm/msm/dp: Add sink_count to debug logs

 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  22 --
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 714 ++++++++++++------------------------
 drivers/gpu/drm/msm/dp/dp_display.h |   3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c     |  63 +---
 drivers/gpu/drm/msm/dp/dp_drm.h     |   2 +
 drivers/gpu/drm/msm/dp/dp_panel.c   |   8 +
 drivers/gpu/drm/msm/dp/dp_panel.h   |   2 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |   4 +-
 9 files changed, 249 insertions(+), 570 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20250523-hpd-refactor-74e25b55620a
prerequisite-change-id: 20260314-dp-connector-hpd-f069e66bc6af:v1
prerequisite-patch-id: 90db75e3fb8bc9c81c67547db7bbd4eefd5d6c40
prerequisite-patch-id: 1c4d030b93a8cc6c98b3447a8685da24eb1f24d5

Best regards,
-- 
With best wishes
Dmitry

