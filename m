Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818DBF483C6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C030010E539;
	Mon, 23 Mar 2026 16:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlDN/qJI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Agcryi8M";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A3510E539
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:16:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFGaSs021528
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YJGPCUwwxRql3Fl302RF8N8GbMb2NM0tHY0
 3zzpwF3c=; b=nlDN/qJIaJeqKuE6kr+Wfovowu93jLWVaHYWALCAApojiJV8vlq
 OqYNM6G0Yq4bRd8EC09XLcpEIzz/n4KMyBX5RNh8QFjIEYjcvf4p7GCM7MyPQ0oI
 3IMyhf0BtQPLX5OeSFhoiazVoy9f8OgU3riHVeN9XBVy0Xy12V9JpOBq3hPaHjlW
 kH5GP6UUodlJsThChriPXdGz5sTabn6D0OOkBcstPiHNydd086+QLsJ1SmHZ/9K4
 hhKWXhZHyzLFeUTpScYofVrMPzncQk/Q+XM7pd1TxcQkvI1RRPaPmt//GaKKz0dB
 WgMglCKAnuvB9BK73uhpA15vevI4S9qyoYw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k317vb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:16:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35a1e725a8fso21683597a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774282570; x=1774887370;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YJGPCUwwxRql3Fl302RF8N8GbMb2NM0tHY03zzpwF3c=;
 b=Agcryi8MORTwEy4A2lo+dj6T826VJ1tg1dLqY76eg3pUJ/ZPf/M0yVvAx7ACdFYsyl
 PuMmIH2trFZfUlDT1AXGvrh1BlfO/a5shbFURc2Lrzv8ysU0hRAGXFwL/SIjFrbazxJT
 7e/Ncf4xtsqduKuY9b+iOY4opFMkgZWM1W+sC3R5P6/4zsfVuUaTLbjqeZra5gXTHI8E
 rV1NfUvIWBSWTXMLmvr76QSbQd1DbF9/C1ewLd4V/msv5BqD/Sd6XrnIp1bmd65apBws
 JmsHR7mY78Fa8RqEgoD5fzcF+uJIiN8+N9yYo89XRPyYv2WX8s2mv5Lah/CIyK7FceDo
 BVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282570; x=1774887370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJGPCUwwxRql3Fl302RF8N8GbMb2NM0tHY03zzpwF3c=;
 b=KHi4Q9eRPsqXxZvtEbWpjbl/gX29MwaKd8za8Ihhhat3xZcbSLhwbOV6czp24Z54K1
 ssEBb1UdR1UauDw8xe/kqFNvSbMHPHrqZZwXHWgHfZjagLpjk64nDDYMDgPAhGWwC24w
 RQFvhbVWqaRn/RbFFRiYBuiGhUwzdqTVDMkorYREVPTF4wBkMvlqIrFaOVTWD+X4aGL9
 Fl0ticnU8eT14paZbIv/0tTQfpmwkAmU4VvflkyrpS4icvVrJw/OGXOCUjDDygD9vs+G
 2QYFCKjwqLC1shh14P5x1eFq8lnFjn4iyv0BolYUco+ZAkh2Z29sFyAifL+JiYWwx/lF
 pj2Q==
X-Gm-Message-State: AOJu0YwbmoWW+TT4WR9A4tpzhRbsKCJ2+x2NILqeAiEYl6Ue3rLEodPR
 LjEjvA5sjp627yXYu5kLyuU9vMrk4Fqk52kCbSuzocpiTJ7mmbU5meoaoDCS9DzPQVaMj19ZgEU
 w/xPlRBpI0GBrHMPmL2a1k/ccxztI3KHQz/xwLaGKyDpdcTGqcZ9AoWJ19+WRWv7yRt+vSwD7Jt
 Ls+14=
X-Gm-Gg: ATEYQzy3q6PYkyobbaDDzqsKn8YNhJ1+zpHTk5VGjJwWRVlq3XIhQ7Sh5Ul5dlpDvew
 HwaZYzzc1atdQ+hkLP+AQBBcWhiAr2m0lrUaJFfEYGV9/uZSDV8ItyAajMkuDKEBbl+BEl6WEVh
 9PVtMNU7oc+WawsEytDnhpqH8CTZ0tnKhnav7vcY6pWMDls0Ly6SJcHS0fb0eztTijhUseVaVAl
 BnJuKEjxLq3mKb2AHZWseRhfzHkjheRoSkwNLHRRxw1YH6+1i1zOsZiNq7vacmPYp96cr/tLSXG
 P/l6CUsaqyP6k4o/qvlJP5yIf8fgc2mVG95SPeaULuSsyleGIlV8G909/mK9nE9q8yzWB6HO13l
 UrZQ6M7MQUO4AobGcWRvXfhi98k0HndnP
X-Received: by 2002:a17:90b:390e:b0:35b:9682:51e6 with SMTP id
 98e67ed59e1d1-35bd2d21ce8mr11383179a91.16.1774282569948; 
 Mon, 23 Mar 2026 09:16:09 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:35b:9682:51e6 with SMTP id
 98e67ed59e1d1-35bd2d21ce8mr11383148a91.16.1774282569479; 
 Mon, 23 Mar 2026 09:16:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc610c232sm12295993a91.13.2026.03.23.09.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:16:08 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Add missing aperture_lock init
Date: Mon, 23 Mar 2026 09:16:02 -0700
Message-ID: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c1674b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=SI4bJWXHUBEfUJKjJlYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyMyBTYWx0ZWRfX5dv9kJQV24k1
 L4mWo5OSRlWzpjafhtwicDsPUtRr25DrgLGy99B5Eg5f81+49/b+wRzKTnEknPVeY5LayrVSUVN
 CS94aDI+Ii/hy2/w36drP7nlXkHXnf+X5nJE4W1df4AGw3qFfi7yDbyJWmWWb6qPUGP+grMy1rn
 Ril2z1daH49baBdMSEQuo+8NFVUpQVrPy+e6pWKOjzXirFzKpOoaZUQXmLc1WdWAEM5Y1wIFrHY
 LksKiZKWMCnKlrJE1Gqhs61w5Ds5o0Ug96Wz1RMCeqxcTY9zmQ4pXYcUMk+7YVUOga4OfFLGRte
 hP+2KTWZA3A20sfXQAfW7GMguTjHHWIIjSpLxP18Oz7oPnvJdwLLaVWDspDvLt/N3QHEzPojiEU
 Y+jk1HS0y5c/QrZdMM3CrrSiDn1wzK2EY+eklEtqO/f/8I1vbF1tRhjWEN6sojzrt87YjRV4aqa
 NQ7yVbzqLep9PsTVJ8w==
X-Proofpoint-GUID: cpxEaJ9c8RSN4ly5w5ljYKdk1u2fFqoe
X-Proofpoint-ORIG-GUID: cpxEaJ9c8RSN4ly5w5ljYKdk1u2fFqoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230123
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

Looks like this was somehow missed when introducing gen8 support.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 2129d230a92b..a00215b7bd1e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2656,6 +2656,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	gpu = &adreno_gpu->base;
 
 	mutex_init(&a6xx_gpu->gmu.lock);
+	spin_lock_init(&a6xx_gpu->aperture_lock);
 
 	adreno_gpu->registers = NULL;
 
-- 
2.53.0

