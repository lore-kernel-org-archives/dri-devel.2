Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83142CD5BC7
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925CF10E257;
	Sun, 24 May 2026 10:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJ/aG0dP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zps0cEk0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0807E10E348
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NNwRTW3212903
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LIovE62RVN0QdCt+WmtKx5cgzNYUayKB/BcGmgYe/jI=; b=fJ/aG0dPyN9+sj7z
 MtpM7c9O10QAoRoZ7Cn3mNYqauiDf2UFakFqaG9+VgsarR0E5ylYtd9oy/DCjOFx
 C8dA8RdQaAgGUHeKcmW4UWt1pmDxlMDz2qqck0qqCGx0bX7zPoG7EUi4A0IhR1IC
 aIKJhRLdxka8ctCVfgIx90m7ikY9hfvLNyxtHmqd61PiG31JYp7E0k7HXdpgzNI7
 5VpKLFtcFnZViAe40G2/hWF8EBncRt2rAFyXRnkoJK79UsWQtiwSqqUS1HVEjgxQ
 06W+XWQIDMjxnTciIAupYdM5MPI1XummovTNoGxjrvQa8rTov17oWLPrvS9l1X/X
 iCkoGQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w2esy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:46 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-57563cc7576so6866252e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618825; x=1780223625;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LIovE62RVN0QdCt+WmtKx5cgzNYUayKB/BcGmgYe/jI=;
 b=Zps0cEk0wdntkZkQjbpiMcQzpvuyFAmAV8zb+BAKSNwSg+N5FmWXfthOGTNCR1OhQ3
 zGzlu53N2bTt+ERSp5FA/Q1sBwGLDMA+gZxhWd/h+uOf5GC64F1dn/Ij36mbkhxUAxhe
 3olig2CtBQ3Ei+6TzIVSiyJOEaylkt15J8TlnXvn5Xnzfy5TIW4i08SNxWohCr/2j2jU
 mOCglsqQdXr2FvGE1J4KfBylwtQ/1lY/SZzDw/1y2dRBakwpP25/mpkToSmRGx135A41
 skq1W3yCagzBG3Q7hNoyBLuk/oUtnYfLuA3RfUfsmNWE3cwTxxJf0oPnu7B7KUKr9fZ2
 nlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618825; x=1780223625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LIovE62RVN0QdCt+WmtKx5cgzNYUayKB/BcGmgYe/jI=;
 b=jKUEgF8iCLz8webV6py9yBmX8/aGrRQsZEP0+BELlgNIg6UXWpeGoqPNN9k5Ku0pAe
 mx4xfe8edMPnjygVOh6BrzuRZ2XtfoYisYtItTZOi7tH57HIkdmNYRqyEHI+H4yN0EJn
 +xTibnjqCqrMaVb2utvkMPxXZCZ779pzvUs4wiLyLJDzOT7ZbCGmuklBJTNEfiteCpGq
 Q+hu0RsR1OvOJvCACV0I9Sb7RUkrZ4NLlFXUWfNTEzbKxr7A+St9fKJ+0wg75/Rb5Msz
 up4CgCfIEhlcWsSY1fLCfDEZ2Ke3E9UXMWfO1+w489sn9I4HiJHNiRfVXzkAJ6lJzMCk
 2UMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x7JbspH0HrNtGW0YhG4w2D+/lEKJ1MtYJAo37R9ERJ3Z/HLHr/4FNbgWTslvxFlJmf9Zy9KA6YFk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVH+iRt0o9LaL+Mul9EX/AlgO8Fh3UtG8SI5CXbvwgUCf2MO2B
 9BjbaMbkmjvzbi9O27Ry2NyMB2fJE/2S9SnWJB4gKd6M1lY1l5NOP+mbPVfcb91qiktZWcRrew7
 dcTY5CelahXCTpksMyl5nDxfqL4K/0OCj5sV2GsgwrzVBVDLTahtxCs0xatuuz457qTWC+SY=
X-Gm-Gg: Acq92OEt3GMNXXifILjV2jlRg12PVeeJx69CgBVRdxh4jukoLBXojOh0TKkjKxypYE1
 CVU3Y19ekQPMKZ+LWu7fV/Rbb4QeWmg67EQtymD94OXM5+3BM3oQvYYPGLxlWiqLrSCe1xN4RFW
 msi6rRg+5EVibkrD/WUlEHhBtm29MLtnl37wFyroMoZvsfxvplQO8KYx92JO9TU7BZA4+X1bKDd
 Iy30tliDb9OrX77eeLpPtTijPGCnYNKld2UhODagqNZUNXkm04t9AbcHXpN3uSh3ds1xwFpU0n9
 nDI48GcQ4bMg48Y00Z/fnTati1OkXkgkn+Ladr34xphoFzRc8ZBPZwQahUBfhg/YubZ19r4Qq9s
 a7ErXd3uWiWEvF2tZRfmQ1DTr4Hh8EhkESkc1p58DpCRjkbRoiHeo7djR4/1AUX5uqs344vF1AJ
 +4EMQvxRhVomfIfUABOXCF/FR0osHLaHRIflM=
X-Received: by 2002:a05:6102:3f86:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-67c7c0765aemr4824001137.19.1779618825594; 
 Sun, 24 May 2026 03:33:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3f86:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-67c7c0765aemr4823988137.19.1779618825197; 
 Sun, 24 May 2026 03:33:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:32 +0300
Subject: [PATCH v6 04/10] drm/msm/dp: Move link training to atomic_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-4-cf3ab488dd7b@oss.qualcomm.com>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
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
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kIfgr1TXlKJmMBrqjAe8XvEofIv6a7FFbjhSIdx8oFo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8rFYr9RxFhNyHvTDkeW6A4+2lNu04yxSnK
 yFxC1+HFiuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1VN3B/sGoDcfMNPTG+CrZBca9Zt21qM3tfIB8ERORfHAdmuNpv4jUPqDFKCf51fceatoNyPbKyk
 ArSJAGtbi5d0L70U4B0BtowxEBvvVIQkPtXt9woUQO5hJwVYgXHMx1talX4TuH3rND658Ka7bq+
 nAOcohmah1maXkO2khjmDP5F/SPgpeJ1j1k/tbSmWUT/ZERZ59VjMNzYj66CqiJp7i06V/tTI5V
 WAQCXYkfVxm8EGYIG40O711YRQXopeF/coJuzKnvAQ2kMqHBw4MrkjcD1Z1SjX/bTrlv9s14drI
 PweRo0priJUp1oXHmv30xxbeVNIErtwp5p8rQaSMYaAb1gCE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a12d40a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=IoBVowuyLm_M3JZO-XQA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX2fJNRpqJgGFf
 +HMt/8jbBrx5vMO+MmQ82UA+y392dMMQl0HveAQbdiQCqMRBjg0tPcv6mQZh2Oqim6zjRB5SA8w
 YLwrgPQO53dWvYNU7qAAzNFO8xhV1+wTWHHFJFi/AIPjfowvTuolF2SzWSUJKZkXQRPrFFaPuAW
 Fh7erJuB5Z9DZaMcTwv0dYpfCe7QXFiXAQChYBV+U+XKp7WS2lT/iCEmAocPxsA8souA8Zbet80
 wKOvcwppM5LtZqKvL2CmF2gcEpjNBO3U9CWyHvmLuiqzRWJz1Y7MSjIZQ6fZ9oz26Ud95jzHNzD
 Ck0408jeMoVpmQ86oLd5LM0squDxRGL0D5VorGjQC8rBnB8nGHC2D3rKhHlVfSIvdyi6Fw79ppU
 SgTDp/+1rMTigUsGQ3DK3b8HYTL+G3zR0DIYwq3v/zF3SP9KzkQRw4+oGehBnyZwqN3HRbEeNlM
 BdKxt5aG5XMqNFcGQRg==
X-Proofpoint-ORIG-GUID: jhFePrh9lSYdC3E0mIOj0QymUJXdddDN
X-Proofpoint-GUID: jhFePrh9lSYdC3E0mIOj0QymUJXdddDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240107
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

From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Currently, the DP link training is being done during HPD. Move
link training to atomic_enable() in accordance with the atomic_enable()
documentation.

Link disabling is already done in atomic_post_disable() (as part of the
dp_ctrl_off_link_stream() helper).

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 97c4752005c0..036b4a5cece5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -437,11 +437,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
-	if (rc) {
-		DRM_ERROR("failed to complete DP link training\n");
-		goto end;
-	}
 
 	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
 
@@ -1699,6 +1694,13 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		force_link_train = true;
 	}
 
+	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
+	if (rc) {
+		DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		// TODO: schedule drm_connector_set_link_status_property()
+		return;
+	}
+
 	msm_dp_display_enable(msm_dp_display, force_link_train);
 
 	rc = msm_dp_display_post_enable(dp);

-- 
2.47.3

