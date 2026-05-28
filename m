Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B85ECD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADD810EFDF;
	Thu, 28 May 2026 10:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnHir+rh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iGUrtFGc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F5910EFE0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vc8V566596
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sQdpnw/ZbgoRCLUhyqQ1bw
 11r+G57tZO2IszqpbV4fg=; b=gnHir+rhh+83ORN3nT7P5ptdJ6U3q7mUQhXUwV
 wJvNF4bXLvR6FCC/GUejS7oAAdWBv7wdYLoKCa6awTFfPMtZzP7NEJUL+hwgTlQc
 69XhPQYzDEowSUj9DgMGWiafKCZKtjQulRPQN9INuVd5eegpjWwhudBaIU8V4Ix2
 PyppQk40IeztfbLEY7QFtI1gVSrGLuO8z4VEpZsSLHnZhjKLoEEiYBjmSqhm5zY/
 +FkqnjPa+7QbHCy/UWp7DGKb8qRXU3o/umP/NWY4oxI/xkRhL5vrnNKABz8jmH3a
 A4mGzrJKO6COexFU2mOi8lOLttmezLm5nnex9xE2KDPyU2uA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjd6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914ac72db7cso130716085a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964837; x=1780569637;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sQdpnw/ZbgoRCLUhyqQ1bw11r+G57tZO2IszqpbV4fg=;
 b=iGUrtFGc190eUB8AbIztCZlpcYBB1rPor9v3lH4kKmf+KhjppqxypbKbncyQHox+H9
 PUgtP2b6Q7mg5fQ2afhPS75p8j74C8ui6XVP3WWsylGSKeveSGvOP+pUKSqQtkv9Fz+4
 L7CQbnKTQCzVx5tLqa29zMRaoQy3bplJN6de1UBWAb9uWaHphO7DGRvHbFRmHNr+8upC
 kWRyfSdLyoFwdqDKEd4i95L1wEIJeRdbMYH0mf5AVQF2gIucg4l7HCjr2i7OlMB0gVFl
 RNhqHVNXkklkD048pbIQfbjbDit12cfVNtJD8/vP2CZwTM0RP+FE+6knI2IkWtfWQZLZ
 W15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964837; x=1780569637;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQdpnw/ZbgoRCLUhyqQ1bw11r+G57tZO2IszqpbV4fg=;
 b=Wl8bk9i6q30mZ4V2RcYgsyBeRNfisgAmOG7bh0y0hp52Ql5Vl2Y9Tnh9293UGp9LUW
 MzuIgd56B3kEZzWIUoy18oXfIPEmjh1W2wmDVCm0NiDIkt8mHZ2VYjCEZAlB9c3b/R3R
 uw+tSFN4RJ0+OISGDmB7t63bMLW6RdxSP22XODQ5hvO6ZOSUJI2UxtRZUDXGElkK4HFN
 jZtAJxpGZRbeCYPelHfGGurWIhXEMvbw9vIweBZ8MUOloMdtQAX/wGEqCwxkcgucfvKP
 y6/zSvRLnmpfFzjabYEe/RziNnEmDPCh+ohVBzM6Uc5VKyvXOtYCUjt7jDUllrlmZkzc
 LRHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8woKoL6bcEaQgqWFOv0FQR3OuAIoDGFBF0PyRFSrbr7DNUV9xNztyHkaAEpfrUpipI/GPbsMfuswA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW5sJpGxGxVZVlmyRbafcuQDBtPxAKCPToaxukGxL0V174XDf0
 ahUqFrGa/k+MbcC/Q8rzWFHXMm78gpy4NsKftthMUjc1sqYlhKGYcsVaJhjuj8ePh79vVnHkMJA
 4Ve7nwCKMm2aHolWEmu/lKuqkOUJ2Gufol/B+oa3UDZYx/fWUZ9PyUMOA9e9Uk6u+mft766M=
X-Gm-Gg: Acq92OHBcfaa6/HokWFc/gqF/5W+8e3iCjgrBdHZWLEWglF3SKGcbOr+S2IxAWJC8M3
 snM+HbszGzjHsmIvIH42MzQFRU1MAvswGNjT8itSx2sKCiR/LaJ2t+TBieSMiSEm4QjwGGWKRdb
 glwYWBi/B5bGDeaXODMRiqQqe0Jnd6upol9mYlAElnOpIOOzccr/JX1UURFJZMFS1VkZY36DdON
 YLTyvFQjnO32/eRqckPKErAQXq26WvyPAwkPtxtfISZ0WauuLPhB6wzeE2O6kjsTR6nazOkzcFh
 HOTzJsrCx7Q4VzIZpp3mXvypR22fFSjoHuApF+QHoO5JbO9ObzH58ugivmGF1BzM5BuRL8837OU
 lp9oTY7BECAt/zBkdJpPdiNfe8eSTelVX2omIS/R9OE3ByCkemSjGBpS2ehpU7Mr8dckZ+stYdW
 3lBy+xtnTiCQc8uTLcbw==
X-Received: by 2002:a05:620a:1d0d:b0:911:449d:98c0 with SMTP id
 af79cd13be357-914b46b6157mr3793352785a.7.1779964836737; 
 Thu, 28 May 2026 03:40:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0d:b0:911:449d:98c0 with SMTP id
 af79cd13be357-914b46b6157mr3793349785a.7.1779964836297; 
 Thu, 28 May 2026 03:40:36 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:40:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v5 00/15] drm/msm/dp: Prerequisite cleanup for upcoming MST
 support
Date: Thu, 28 May 2026 18:40:21 +0800
Message-Id: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYbGGoC/yXMWwrDIBCF4a2Eea5g1IwmWymhmMnYCs2lmpZCy
 N4rzeN34Pw7ZE6RM3TVDok/McdlLmguFdDDz3cWcSwGJRXKRjkxrrcpb/RkP4sgW0PsHXlloDz
 WxCF+/7Vrfzrx612i2znC4DMLWqYpbl3FdrRScm1abRhdcKi1owZrSUF5tmhbNyBq6I/jB8ORl
 tepAAAA
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3056;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=xuue7tlOaj84hkqTXFUwbQubbONow4b2zdH/SbNbEeM=;
 b=6AiqXsyN5m/pRFuE6vEOjwSl9kyRI5HWtBsC2kxqIl+6AhBydbz8qrD5s+3//lYJ60EHHGIs8
 ENBqHg++ChIAoq6GcqIHHCzKaveamV6dH498RDeNsvY4oOWsGXgw7jQ
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: eCPVeD4E-9z-dbZ4dUmoyQqCr36YMh0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfX7amzbB+J75wx
 bmLiYv9pEIytQhuS6vtEbY+Si26rKi3m59W4PnBhUBMYTiamhbX3IKxC6mxKUniJ8f5M6wjU23z
 sNFb+XWUKH352i15i0Zp6XmAd+zKP6FyLo5ONLTy6m7WsDwfG7FWSxb2bg44hlaQPOLgEseAn8M
 /7I+aqlBBXks8p7mKcIfb74ZUWMUJn5pH5aHEKk2RxAvnTDBd3umPrFOlideud6xjP/DreyJy9l
 h/fsxzJKVQbmKQlmWy5rm13cd+uQaYnGCCSbDHsMzjgPEFr4bvzCezu3TdwPnCKcM2vzPlLpAdX
 YqNP0WupSYWMsGLFBl1IDNruja+7bp4KPCILLRPItxBzcpaBbscr8baMB/qujq66BoRIiioslsQ
 PugyJumTJ+GzswVibMsOro2y6JHGtrIjZDeADOtBjfNwDOyTgLsYeZgIkOzH9u9/xC2xIRWmM9d
 6wV4dJeuDOyYDwL+LqQ==
X-Proofpoint-ORIG-GUID: eCPVeD4E-9z-dbZ4dUmoyQqCr36YMh0B
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a181ba5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IAIk9fEXjUNtIRNVmKEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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

 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 384 ++++++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  30 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 273 ++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |   8 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  43 +++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
 drivers/gpu/drm/msm/dp/dp_panel.c   |  75 ++-----
 drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
 8 files changed, 453 insertions(+), 389 deletions(-)
---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-dp_mstclean-f094cea8ca24

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

