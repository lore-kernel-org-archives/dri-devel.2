Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B94CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 08:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9636510E36E;
	Mon, 11 May 2026 08:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPRnR3co";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e/Oj6adI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7CE10E36E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:36:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8EheF1358568
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8CFeAPjvnNUNUQRjkTC0u2
 CkdRKw65Q2AJD3I3iWzcw=; b=pPRnR3co7WesETzFc/iUoJbLRSfNmPQs8aIxOG
 86kZKoj6UKlt8LS5V4EXK0VHcbLdPJBNPTaJzeke2pZFe/kO+08xrCRLeO3bWbyC
 S5tt9wdyDMFpfdMao4dHrklmSC2c1Dn0Jf7FrxWVo1Nhkm/8e6YVkWmmDtG2fr9g
 8KIMhmqGGPhG46vNbTku9lJVh44OwaYGJN2hO3nTF2m+yxbt5mo5DcopNMsmq3zZ
 zJyVsoySbiklgR0w7g88UPvxgBOcdLcP1o1Ih8/CqsL6mnjloyFWjtBYzcINA00X
 Nc1KQfX6LuECsREyPGgid1THSe8vejawRZIWm1CEcd9jxoiQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e240h4cq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:36:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso67124871cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778488573; x=1779093373;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8CFeAPjvnNUNUQRjkTC0u2CkdRKw65Q2AJD3I3iWzcw=;
 b=e/Oj6adIy+MaZdXVSIm3OtuEu9mA4096TANnrQzsLeKAX2aM0npwxJCFhI2HnAP5xK
 eQZ1ofpSfBg+ouw9wSPlkrQ2Cin2KDOgvjMJ4jU20KTNz1euSHYYjj1AoCNMIVXWuf9b
 v7p6f6/pbW3phQKtUVkb6LAWOjlKVarvkifw7+FILDPQgPCm62xcTXQHsd+Jyc2/zRm+
 G+4jJLyxCJfPluypJyiec96o3E1dT/R8fUGTUcIPoKSnhaoSdTRU+NriY/YMFSf3gDYJ
 FdlCTPT93qUiZvHnPlP+VAIkicEfaW8+kt6WdCuR5H3BF1w5E+foBYQDc9dCjhgtBWwy
 S1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778488573; x=1779093373;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CFeAPjvnNUNUQRjkTC0u2CkdRKw65Q2AJD3I3iWzcw=;
 b=PrkY13RxJL+hGVaMJoouw4oh2aGU9cysMVBcrt0cvzTXvqr8Hd/lhxdasgLt66BLB0
 lQXIxIyr1jVuZP3Xk4rVi1SJ1ErY6gaRn3N4Wb85OdUyPxMZq6/coBibCxEQw4B6HWQK
 1yJWqWJwnjAkW3eBaTwAn7t9ZhVdrK6es0QGy5BoWNVCkjLDZT2dinW6QuB+sIjK9vrU
 Ob51CvRvTVKfQKfBpHCfPjXWxy3fjjk0wsEWteBE04FQKEcUOO2vj6vt6U2yawD0JhpO
 n7eXWwJnqeNXzHTmJ3S3AdfKt7kbGCRKU/giE4AUPm3v6I7eFPt/XQhmWafXLe0ftVPe
 xw5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q9rHT172hEshAxW54PSpjbPYdZ9iWPfHxzRziNuQ31evVSQUFSUnKJ7FKBZmfb1JhxKiUjwlw5LE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsoediK36CoyQAbFCXgdAGYfcVfDu+cmpchX7eZ/9vcJokTNxr
 9KRHx9AxU+O540sUr4jRZo4FOk/EKmlu6oy/dgMhG+ua967W8JEls5dSNr+4hpEIh2blJNClz5t
 l4meyOWnytoBwyHVWqvaoM0QfGzvya2AoDFouIExJ+MjY+2MBITlxVdYEqm0Hgcz1h9jhyBY=
X-Gm-Gg: Acq92OHDEIDe/ocGuAFaNpaNUeE5pzXtljiqz7IyH/YV4Gbq9KWKccfPZEi1v7cFvWr
 CKrGMDdPDvObUMw98M5SWsYW47X/6hdfgx2FNO6F9oEtYHet1zkOy3xoy4FIbfTAYdGjdMcoXLL
 fMs7Reff0YUxZJiRu98daYgf56Yh6tD1ClYMWTlXRqbHXpr9T1z01ypuFbNHtce4OtjmYkxmhDa
 lHHAHkDjB78bj/IpKREcBuzcsEiHJgJBpq+M+AyU7cWECiLOV/0SgD3G+G8+xc9DihhFo8yLbMZ
 fBvhOQMGjEJ5yeS2bQeItQYD8Vwx4eWAqSCvvG9plcyKgJHCX2/OVAbim3b0GqH4xrpEV3UlI45
 03OEm6+kN8lAxqqfOh2snuxQgWvYuxxL3Co109KxNPlzSnajFIEWw+rA982w/BxelsqKPOb3o8e
 jVm6mg6gU=
X-Received: by 2002:a05:620a:414e:b0:8cd:d872:c2c9 with SMTP id
 af79cd13be357-904d6cd5d09mr3515027185a.50.1778488573463; 
 Mon, 11 May 2026 01:36:13 -0700 (PDT)
X-Received: by 2002:a05:620a:414e:b0:8cd:d872:c2c9 with SMTP id
 af79cd13be357-904d6cd5d09mr3515023785a.50.1778488572998; 
 Mon, 11 May 2026 01:36:12 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b8f96cfdsm1033134485a.15.2026.05.11.01.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 01:36:12 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 11 May 2026 16:36:03 +0800
Subject: [PATCH] drm/msm/dp: Skip push_idle in atomic_disable if display is
 not powered on
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-edp_suspend-v1-1-128555968d7c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPKUAWoC/yXMywqDMBCF4VeRWTcwk9RUfZUixWQmbRZemmgpi
 O/eUJffgfPvkCVFydBVOyT5xBznqYAuFfjXMD1FRS4GjdpiTaSEl0fe8iITK5RrzUiE1hgojyV
 JiN9/7d6fTvLeSnQ9R3BDFuXncYxrV0nbsCZPN3RIzBKMtQG1cS74YJ2hGtswNAb64/gBnKnkP
 qkAAAA=
X-Change-ID: 20260511-edp_suspend-0e45d0110633
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778488568; l=1630;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=G95APcyEFp0/5bJXcgSBrF6MgJZerwq0+fxABSPj5n4=;
 b=0PsT5i264kqig8JC8UFwbXDdRx0p/GuaCxwrgySL2KQGz4npCalLRT7tI+3sx5kk4QEDumKJR
 9OygBOxD7DiBSW8ZwnBqWAMom/GJAP1EcCI0NFPQoyrAFG1QVS4N0MU
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5NCBTYWx0ZWRfX6i4LWb0/5LHv
 Ewll/NhgfIahYabRKRjjv+vlCULRoLmDxZc5I3noLlHWXeHM0KuedoYSiJC5f/6us+ojRgoxLNg
 sPyi7CFhtudYU2Dq3EGyz4HQLucqCWZZ5qTpPSUUpcvkvmdXDyAYS0h1jqQEezW709UMSIJRcvT
 2E9WXpoHq+ebX3yydjgiGoUUuttZS15RuP7OgB2SptY294Lf4BMDb8hbcNgbdbMaP0aBSyrX5em
 QK4DBjR7IGfEJDgBHET2ngExscqngU8tMUV9Yx7CyznHWUX3IBEn2X5kaM5Xlx1nXfhBw+GpcAm
 4vj6Y5X7fIzAweDHI+ud6vEmTzTQZfRFzTIBOqIHbA5I2Y3ApJGfeSsY0qGPw9zuE29Wi270kin
 Fy4IHlP8ymqV3IsLtfyNdQYdcVlbLRsK6hIwsFutC1/Ajy+sp3jQXSB6kChLHHrcB6uoIlB+Cgu
 CzmwFaYKBgkZMkJO+HA==
X-Proofpoint-GUID: rV7IXFiMo86epGZOhNl5ePuD1wfNNcAn
X-Authority-Analysis: v=2.4 cv=X5Bi7mTe c=1 sm=1 tr=0 ts=6a0194fe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aJ8XEeGOS4McOtPK9YYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: rV7IXFiMo86epGZOhNl5ePuD1wfNNcAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110094
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

On eDP interfaces with no panel connected, panel-simple-dp-aux fails to
read DPCD over AUX during probe, leaving hpd_state at ST_DISCONNECTED.
msm_dp_bridge_atomic_enable() exits early as a result, so
msm_dp_display_enable() is never called and power_on remains false with
link clocks never enabled.

During system suspend, drm_atomic_helper_suspend() still invokes
atomic_disable() for all registered bridges. The resulting write to
REG_DP_STATE_CTRL against an unpowered controller triggers a NoC slave
error, causing a fatal crash.

Guard push_idle with a power_on check to skip the register access when the
display was never enabled.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1b3cbf4016ef..51b60eb9c2df 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1660,6 +1660,13 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	/*
+	 * push_idle accesses link registers which require link clocks to be on.
+	 * Skip if the display was never powered on (e.g. eDP with no panel).
+	 */
+	if (!dp->power_on)
+		return;
+
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 }
 

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260511-edp_suspend-0e45d0110633

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

