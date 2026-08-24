Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCCC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6A610E741;
	Mon, 24 Aug 2026 11:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkKc7P5T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRegPv3/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C785710E741
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMYwE2372307
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4CmRFowfZ47tSun/jApPDw
 h5aVgBOZwiAhT8GUQqJg0=; b=nkKc7P5TvknCYmEAa3ItX+YViPnb5DiIP2+Dv5
 7ewcO+RSndW1Sv4UCY8izU/UKR/JLcmyubaxXjXmFkp6QAhdoplhK3B8+oEunzoi
 tii5rqdRiLOd9EGE7EqFEzC+kapCYQ/o7I8XfQjiCRU6zGOmticuC4maxK8S0Mah
 5HGWlLB7sMy/ut3BPBSYvw4I8xo1gCwPa/rPhEbatWq/QqDBhcyMuVHT8DvUf0Az
 UvCTGOuzwS0dit+e9/r5MPLVTK4fr4H2WHK7eCSVHz46RR99auXfHuudaopxmySO
 N4PJ8SjhiAmnmhME9dQltJHJ4KVYuuAFgyEmdTvCTJBnza/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshbhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so4237982a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570909; x=1788175709;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4CmRFowfZ47tSun/jApPDwh5aVgBOZwiAhT8GUQqJg0=;
 b=PRegPv3/9HDOrTBnMxjQaY/Z5EuuF1BxYaksYr4MVRAgD/DW/WJ3kT6JP+WzT9hUeM
 2cWVGVjJABfmzwr2hBKKiiBuHZdfc4Ar3IpEw5XwL971x2kmgAUQfLajukTY/mGm7rOp
 nL3+VmZc2ECpDAMqL+H1oOwAFGoR/psgCwsHDmwQbWykg+1/G+8ScFsXaGECHbYDd39q
 PIrDJ/ZzImDMb3o2gGg6yujs4wCXFjKnU6Paio2ROPjsTbNJdf0IfrKh8IgaADNwE2qX
 6v/Zdbe13IhRYevLDNBfHsM0ILLWzr00swUm9jrsvrzBrsiXOQV3FTXvTHeeF2GJEclO
 3jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570909; x=1788175709;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4CmRFowfZ47tSun/jApPDwh5aVgBOZwiAhT8GUQqJg0=;
 b=NG4j+9ORVsMM/+y7IneHxPBhYXdoVdD65FsUGSPE1E+NsloD9PrrOiFNJJNZCAJnFb
 lHZhY/0KzdWG4apQCEOQRXYo8q7F8XGYwBqL1Ygvd2GztCXrsuIfcQsyhf+Mec2GsJsz
 U3jI7fDY6nuOnIqM2ilku7tylunilztlC/J4EL5ZFG2GiXLLZCC/8w4FPPebUo3/JUh+
 BMB63oJCuxmIveugTujt9ia8sRCP//53ILLVCkCPRB92S0UJo/gMfn3RWAx7wWz9lotc
 Xx1GMgpHE2MoaS1F14aPwhpKSJbs4eJ+MySEDEW4Z9Nu1mSqF2oGCi//kcxJhfh7Hxq1
 cE+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqF9BmUzg5nX6vgutdEpyZw9j8GPxvWEjSHaDgCHSObUj8IXt+bAC1+DoW/PuTAr3yMOK0aa9j/J+M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/3CMh7aqWcnO9Btk/o//58qajcqVsC2jVFIXYRpmd/igauIuv
 hldozJS+Y8hrHV8WqT/ke0PwNnZ+hw2otFbgbgggI9LBXrWNL0svprpf1HephG7H7vP0SvCAaKr
 gi6aOHP1vXJkY/QD23Gs27yW2wXoIdiraS0k5tpLfpAAH7ZRRRmWHUFepts7SdRy490b1Q6c=
X-Gm-Gg: AR+sD10IVmQnr95jA74AexJsqf+KNQXRzLw8VEQ8pMUWR5HF2RWANTJW+l0kG4FkR5J
 WTqzWw776MycCGstFXSTGOA7Kb/JnCdnX9Sy2hLXVZNwiadt2tMam30ukON4dIv+gjZHiSBeizh
 K/JqPW66OD4PLEFv0RZV6591+kkzrObCx3p+c42ZVr26bWlcoVRa4A1RdAWBVMGpYFHfL8KT9+/
 X03Wrs2iVzeiV/mJCB1TGaun817YhTPay+WW6xgOyC7tpBB5rrE+BEnGVzvfpNdoUAduF7dlAiJ
 E2J1iAXD8mIWDajf3Dv3Yf6bwE3WhGS25rzTvee33Dm9uEJjqZL70C0t0kP5GpQJQqkJIZv9Orr
 k09RB1v/UylXPaVNU
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-395c3a06ffcmr43323220a91.12.1787570908583; 
 Mon, 24 Aug 2026 04:28:28 -0700 (PDT)
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-395c3a06ffcmr43323139a91.12.1787570908109; 
 Mon, 24 Aug 2026 04:28:28 -0700 (PDT)
Received: from [10.213.109.15] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af750esm9825643a91.11.2026.08.24.04.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:28:27 -0700 (PDT)
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Subject: [PATCH 0/4] drm/msm/dp, phy: qcom: improve DP Type-C reconnect
 handling
Date: Mon, 24 Aug 2026 16:58:03 +0530
Message-Id: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMqjGoC/yXM0QrCMAyF4VcZuTZQu9EWX0W80CxqBNvaTFHG3
 n1RL38O55tBuQkr7LoZGr9EpWSL7aYDuh7zhVFGa/DOB5f8gA8qdxwrTp/KhI2p5Mw04VnerOh
 6F0NMIaU+ghm18W8wYn/4tz5PNzt8UViWFcsOSW2BAAAA
X-Change-ID: 20260824-qcom-dp-typec-reconnect-fixes-030767868837
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570901; l=1578;
 i=saurabh.anand@oss.qualcomm.com; s=20260824; h=from:subject:message-id;
 bh=PswsC0kHCstclWvWwSDNMuzSq86/iBtX2wdJRtaS5ig=;
 b=6hEfZ5576SLS82wemytMrt7rkgq5oL/XkzUgPwLN7shjG/6Cy6MS4tVCkL1DRpF1AySG5dqmq
 tJxt5o1FNx5Cm7QOaCyFHEuWKB8CvWmj0YNHET+IENlHWB+ag7vhu0Y
X-Developer-Key: i=saurabh.anand@oss.qualcomm.com; a=ed25519;
 pk=AzGwbGUPO11yi5XTeGyJKOJWLfzXp5Dru4z+PCg/uXs=
X-Proofpoint-GUID: _ZP1ppShA2LH4e4x1BVzyImA8_FsiKuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX0aCIV1TGMhD7
 d2ZnEOHMdkTskht4w1oD7tWfuvF0gXRmfATCMaJTelDBZZ4fcrZZOTghvTdujrxVoCHlbvWYl7d
 BQWkx2BrrBFjeBSeF5F1HHzRdByuZmeY6f7SM7d60Aq8QZPXqRVfmdc/12aMFR4gtiyGkha/kkw
 AhNrgeAQ2fQLpP/kCcj1XB0u6Aoi8Urw9hQbmFGMtB+YRtyaZoTfhzkECHDcXpo1rKxi1XDdEfM
 iWCNEFk/r9JgdnL+PBd0oCowxVsOHFBRVWK+Q2vrhOoSeVGlBfTCcxNVjTKdg8QXXyk9Qv1jg68
 0qhc1we5t+FISEY5E1fmZAJrPBgAWldCT4yBo5XzjISS5oT1HNEfVga07F+DIV8ZqV6MKy54Qa+
 8ZUcsvQPEnZ2jX+UdcbA911uuJ37/kJXp+cDd973Q/SD1R3Jrrvkq8SkbjhGKLTEF5l+ilFXSyD
 KRem3pHjzNgenUaj6XA==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c2add cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_V60umORN3TpBg0EziMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: _ZP1ppShA2LH4e4x1BVzyImA8_FsiKuM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX0+hQYtvQ9yxG
 JIhJIRcWRfroB4HVaDVaMDx0Q6Pf4NC7yXmwSrGCLZlKdnkieUAQZkDzAp7Jvy30/1L2cfdK1GT
 PIOhKslxDBxyIiSPc+l5bYcgYG2zFcM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

This series improves the Qualcomm DP Type-C bring-up and reconnect paths
by handling PHY initialization races and link-training corner cases more
consistently.

The fixes cover races and link-training corner cases in the Qualcomm DP
Type-C path. They prevent Type-C mux switching while the DP PHY is still
initializing, avoid unnecessary retraining after a successful link train,
skip LTTPR setup when no LTTPRs are present, and keep the downgrade retry
path running across transient AUX disconnects when the cable is still
plugged.

Together these changes make DP reconnect and orientation-switch
handling more robust, especially when AUX link status briefly disagrees
with Type-C cable presence during reconnect.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
Saurabh Anand (4):
      phy: qcom: qmp-combo: delay Type-C mux switch while DP PHY is initializing
      drm/msm/dp: clear force_link_train flag when link training succeeds
      drm/msm/dp: skip LTTPR init when no LTTPRs are present
      drm/msm/dp: continue link training downgrade when cable is still plugged

 drivers/gpu/drm/msm/dp/dp_ctrl.c          | 4 ++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h          | 1 +
 drivers/gpu/drm/msm/dp/dp_display.c       | 7 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ++-
 4 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260824-qcom-dp-typec-reconnect-fixes-030767868837

Best regards,
--  
Saurabh Anand <saurabh.anand@oss.qualcomm.com>

