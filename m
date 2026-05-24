Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A098ACD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C9E10E348;
	Sun, 24 May 2026 10:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQLe+uDX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGQ6Py2F";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5CE10E257
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O5brd62813854
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rUWlPZ/QEyxKEroL54OXFIzBc1cA35ddV/uy1RfQebI=; b=JQLe+uDX+o8oT808
 aOOY0B74sM++WMNBVSGHIzyayEwjWyr2pFUfDuxdMChnBa4pRHCcNPAeKyGraQmQ
 w982WA7Oh+fmry5Cdu58uPxJSYscyjWgksr/aip0WMfunlqNTeGADMs1IR7MgE2C
 ByaNzOp/G52hLJaOymrQDoOscKDdzjlAyts4lQyLRAsfUvRXmLK9OGdkJLdzUvm9
 bP7mfUuL9Lm0PTW4Z46DaM7E/VPGvrtYogteaOOz+u2jIuE3AweGSjrGqrraYrFu
 p5y80LzAWNKvIexgh5nnL8s0VTwwK59CFVgGkF3zEMMtdcYpMIuVLcmaWRU6ZYAI
 Agvmng==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9jt5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:39 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95cf2f6a8d6so12717662241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618818; x=1780223618;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rUWlPZ/QEyxKEroL54OXFIzBc1cA35ddV/uy1RfQebI=;
 b=WGQ6Py2FNUgH/94V5J/X2G3Cg7D16YidfGTRQkk/QEPc9Wnzv2CsKRupb/d8Z8vFWR
 pv58vKJKwxKkYtCtMvsn86tHDjWusbnKsiEn5lUvjOY2FXlBescat8stwYWLAsCq69PW
 1HCxJOaOG/FcL5Dkff8mhhzt+ixZFKX5tO/+QmzqbRgS/jO//mDnaHGVqtZBSVZPjjPO
 AitGyrBcWGIYBfrjokVUzJVKOPXNq2IJJaZ709v9yL4hRoWK+KiSUebGOD3tKAykQxNe
 d4KsrQ4aYwPJ7Cja+0uYsFlJE6RCSshmUBYUrIegYLzxhTrZNKhlxBe6ZCXmDowLyfFv
 E4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618818; x=1780223618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rUWlPZ/QEyxKEroL54OXFIzBc1cA35ddV/uy1RfQebI=;
 b=l12fCS/bMbVJCGJvGsltH7+jXyMs8bhjtEi+hHU5YhxbCkOG/FJ2c6u0ZP0r45aVup
 dLhmJP2F9dSp+C4iZ184DGMwCnZO9MBX3ZdXLpx0RyxYVN8u+X86YXBZSPZvp9cegHfz
 us/s8Qw5XK3+INoV/opr97lA8xRhuZBudlMzJQ/Ep6Bddopd9N6y+W32aLEMmrv8VTTi
 3zvSqXtLHU4SKCoC9U++n08QMc0YfrB7mtD1u3SxBta5pH/PppsSRZOnv8q4zr83XVgR
 EEpzrXjxoYlxgRw8g/BkU4709nZ7NqJ7QT+6adnHSVf2BHMRkhfQr6+ORVrWu11O11HD
 f+RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/59v9k8yVpKz4antR9q0fZ683/RLZTGpMo4jxrHgZ108KyfcLen8tCQ3bSSNeOS+mdeBYq4uHhw1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0Z17TpFzkcr8cMH0P96E0+2xcZ4Ws/8OkM3jTRRGLuKnnxfOW
 k3Fq2/CkC9cWIWbVt7bTEmv9BXr2srhkKCEAbqMPBSiCywb/dbvd3uI+2k1X0dewtf1VOUXn8JQ
 pkF64ZM538IwkbGuCwlc8IloWzLOU7rvid8przwMC63V52BFDAzUQeKC+BhhBnZH7eMZKeW4=
X-Gm-Gg: Acq92OGUrIiph+GbUUAI9ohKmxCE+zZuvgY1s8963vhjzoHqGm4hMVd8mqGCeNIVTeP
 zQSnMYdG56RIyM9A9qz8TiHekRavALmaG3TBsA1VL1NPDMvta+ZQLMi274jO1GuVSk6WbtJQwKg
 B3cfK3ChCYaKZpmC3/Yb5egdztSt8+xcy1QeWmN+SQ7Xsm/eo1DMWhOMd4fw+yilY95MxysSEeM
 f7lutoQSdPFIodLZitbbc5peyDbEpyHPKsxOZSuKAdOk0e0UJvXdHkGT/TWcp0joDdqGPUJ5n62
 8FLrdyTuUF9+9nyahJkwRU2OOrU/+97KOeS2UwQ7oDO0F2sTNeN0c8MFAStenbXRZUfBFFPB7SM
 iZ/jbBAULmqi9LW5ouyFZ68FPnANGvJvvGEQulqLD2H5q7eL+X8h9hZvN764y0NAoWg6t2EvPSq
 7DfMxUEDIL9b4eIVLFtkEys9pbY5fVGHynQoM=
X-Received: by 2002:a05:6102:2c8b:b0:632:b111:965a with SMTP id
 ada2fe7eead31-673cbd0ce4fmr877000137.11.1779618818672; 
 Sun, 24 May 2026 03:33:38 -0700 (PDT)
X-Received: by 2002:a05:6102:2c8b:b0:632:b111:965a with SMTP id
 ada2fe7eead31-673cbd0ce4fmr876982137.11.1779618818286; 
 Sun, 24 May 2026 03:33:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:29 +0300
Subject: [PATCH v6 01/10] drm/msm/dp: fix HPD state status bit shift value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-1-cf3ab488dd7b@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Jy2G9A2/jlpjEPih2lVO1QErbvDF3fvHdd/w5FC34jU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8wFGMU4tIiJ5/Lc3BYbRwQXr4awMypM566
 5fMSLf/kW2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1RQUCACTjry843wsUM10VlJdaBz7l2Aq5aCNjGVjkkCwvBKif5qljEfaH810d/wq5qPcT8+9AqW
 oA8UbPEFB9SO2qpTeosO1ce1Kjg0m1UxlVyyTrTiYPvq3nyj4C5lYyeXV9v366kDZ0iRq/pScL5
 sYJSBeZazUEQck1OCm1IrnCoKki79G3UUmhLdS5udCY4T+SGXa2LfqfZGLRdznh3cfRCxC9E4SM
 8n1MB+dE81a/QdW/UTf7HeJBBb/mC9ujC3duz+JuYwUDay6oUOiY0gKagTnpDoeHAjgBS+Fl3Jy
 yJ6+OX5Lpjg2c/ANchHTMoJpW3kxcjiKAWEIYixqVNdEHtxG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: XI9OyndVyJ52wtJJ900AkD75SN-P5bFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX2ZAQym/HZmsP
 kRFeer57KYJydXUIlewrlEYgmbPPeHQZW96QM6PSt+B92RACbgNzJxKh+5x/7Hgl0iEWc8mbzuU
 g7sGKnTLmYiv0VoHAd+la60uCle6i3D1tMait7DlBca2cO1PB123Vwkaj6BbcjHPe/Y9MUyljq7
 CQAdEd/z1P8C7QMbPy6zxN7zfRBuesVDsR9ah1a1OcmiQ92BWyRQTQoJYEohvU3SK3Uj5mMOUbb
 T911T8fxyq3lcn4owd16cdefDBm7sRimz41IW8g8spED+zyk7bV0XLA7fveQG2eSGXjpJU9ERam
 02cTnM60UZLEVfC0Ac9mKc3ULfJ0EvNAIOBLakAJOS0c3OHwoCgYhxuq/2cRHal/Lyai6jm+1nU
 /81K+9TdUTUOEKG8OEvD5yTbNr8nScsb1BKJEmobyVv/ZLeH7HbiBeXAp63XU1Cosn/21l5MSM0
 2XVYehxBfbRzPSp96TQ==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a12d403 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=IBRk8GtBIsankUNt0b0A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: XI9OyndVyJ52wtJJ900AkD75SN-P5bFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
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

The HPD state status is the 3 most significant bits, not 4 bits of the
HPD_INT_STATUS register.

Fix the bit shift macro so that the correct bits are returned in
msm_dp_aux_is_link_connected().

Fixes: 19e52bcb27c2 ("drm/msm/dp: return correct connection status after suspend")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 7c44d4e2cf13..3689642b7fc0 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -68,8 +68,8 @@
 #define DP_DP_IRQ_HPD_INT_ACK			(0x00000002)
 #define DP_DP_HPD_REPLUG_INT_ACK		(0x00000004)
 #define DP_DP_HPD_UNPLUG_INT_ACK		(0x00000008)
-#define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x0000000F)
-#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1C)
+#define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x00000007)
+#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1D)
 
 #define REG_DP_DP_HPD_INT_MASK			(0x0000000C)
 #define DP_DP_HPD_PLUG_INT_MASK			(0x00000001)

-- 
2.47.3

