Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1441BCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B94D10E724;
	Sat,  3 Oct 2026 00:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d85+5KkY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHMiHSal";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842DD10FA49
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeOpS3884883
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ugPvZtZRftPV0KL0YY+nXHR/3ihrfuUddruoG/P+Iys=; b=d85+5KkYjfieP8GZ
 s+ach/NR2zwBy6DieUnrFCuwDiIpB2Hbxzy494AEcJQ6nWcEhZao2WP0ISF/5vtv
 KO3BRDg5pz8LrG6UHWyKW7uNK2LX7zDuNHI0kRR8bOtm7O8XhQ8R5c5+s2BlycIa
 3+5isix14eU0I8h86qH+MzrHLquiIQIl6p9raZbIsiajfqgdl8r4AqOG8NYHf2S8
 UdFpUUhZOStXsYRAurObE+7USbj2lEtWtHbo1G34MExmCdpkkp6vm+ufR0F/ZgQb
 FCdUbBPU81Bh62WmfcF+5WBdaf8EWDikgvrkJAW3C08BZwvkN+dYrJpkJu+OAGr4
 O7bECg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40jp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5328827bb8dso2333411cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987242; x=1791592042;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ugPvZtZRftPV0KL0YY+nXHR/3ihrfuUddruoG/P+Iys=;
 b=QHMiHSalLOfi4rM/vMLj4mPSRlkcpM2uDHFYxpTP5wpPaJpqy97XjzxG/kMxgvh2Tz
 URh0RdTsI2ydtH2+FyVxLZBs2BVDMoUuUKkMoW0BUOsQgGuc+ijLqOLmZnYw3AV/cp9p
 TlVXv3di8TmEEHr6fKiXm3193io/7V7MGDhAHtu6YbJFLeJLkfjKXBA8EO28y4/vKutD
 paXKeROhKhNM02NNkt8UB/X2e2IozqbrgkA3z5CnJ85B631Vp6bspKCnbH8w9VAyeTD8
 3+UZtukocHdviWQ1ZKYbXy9k5Cz/bk+nubiaUjcisOo4h70lYutIq9kx96FSHUDuExHJ
 XWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987242; x=1791592042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ugPvZtZRftPV0KL0YY+nXHR/3ihrfuUddruoG/P+Iys=;
 b=FUyMk565AEYSvQX4Fr2HLLBxHiSe43p/2K3sQOsgLsKoPdfUxrGlQlmWFD25gLRMzv
 pAVU/dw1Z6AiXj4+x58S8rNWDZDhlHyaYGuOO22i4jeIcOtqyC6QtJ0umu0z1ERDC2wJ
 RHBwbaBUKHS0zJltZOG5XzrXYXaqiMwKJmLQYZwh1HtID62AMTlf5kojRvUYC+Q8b+b1
 JGdFpAFlYniyYvO0+h6Z2iEClv0kSyUnOIe8n4+TIl1dPAH+6a1mZa8CuuC7kM/Wb4K6
 cl/SW1zp67AguoJDCtUbiMH8u8MwkIAYBIwXThyKCsgWim9OoycNfkQ34TDOcV6Yoirr
 jXMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDBBnhE0oPdHyfYnCqg0wlIiWRhOTNfeVyKhDsT26gY0VZ/NWCu7HcAE5Gfkzp2+XjCsNDg6MuHzc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUmI/cfeBPBQ84e3BNq9o6gCwRHaeFKy/sy6wa6QxdrAaRhKAm
 1rn9g80rW3v113L+FilmGMrrHCW1WehnO5Jc38IrFQyDCk0SuQW49ySYK1iBBAy3dP/IF497q61
 OV4TFDh3TJn/zSoz82XwpiOxfGWVKZ30LG6aswJwmSQ8+2Sz1n66FgYeqKIqeH7t0mwod35g=
X-Gm-Gg: AYBFou1nLemOgAsWrbIvaNkrJ23vTdsQIV430aTqnwNIa/zW2FdBYgQlxGctjzTHWCD
 kxKxLuEiWYFIm5V0IZldGAPrX/16wFmXYer7MtkWMEPybXM0otpBi3eaDE5d1npEOva7XOJeETp
 inZ8oFeuwE1XQlUsoyxUImFR13SxdYl90IYhK72irBeUEJgUf9OZ5xL0oHLJZZie087Mi7OiOOL
 8rxxaVHULzlsWFqn6BHcdt9Tz68d4qOiPsbJt1GG+GKKb+NeyzKRz4Zwv9JSMeYW1iEzN75bINh
 x8MV7XBr+xxcgtknTIfNddy0sSZ3kPrzMEnY9b+83UJC892VbPqlIoD1PibS7f7OL3NIup6d+pi
 M9afXUpMs8ifplXXEGuh8P8/fUHP3lEzwK/7799/rp1iI0IRa5NEh2WcVOEbGmgzuUzjZyYODR1
 QYBCZxcs951Row
X-Received: by 2002:a05:620a:c4d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93cf19eaaf4mr852486785a.59.1790987241716; 
 Fri, 02 Oct 2026 17:27:21 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93cf19eaaf4mr852483685a.59.1790987241260; 
 Fri, 02 Oct 2026 17:27:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:12 +0300
Subject: [PATCH 04/11] drm/msm: let the kms drivers clean up a failed
 kms_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-4-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3122;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pQ3ltdI40X3ctLCX1uAMzBt67JzA+i9lmpW9lieI8iE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9YB7wd+ahkl05/lf1h9Li5OmEHH4Eju5rc7uRq/iF376
 3m/L6Cqk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATUWjnYOjIMZEvMl7zaEN/
 4LyTd262XzcVLLuxqXr3ps2/9Rnr4lybXOtZZFglpKPk3p6XitwaMEH3WttXf7PtR9ZofczkqSv
 eZ9Odkt9hnXds5/HWglnPPRj/nw2uaTub9CLirKMB35qcin/qHes0naTsJ50qmf5ZWkJX7L0+Q3
 ZCLTtft03eVwXr92oB5Yr8/3Z6bTl77Y/DJuHvL0xUHjfr7JBaErxJKXmauUGZ4apli7rETVxY/
 +0prt/Ccowtd1uacH7VYqa6f96rHa9M9rEx5mI1kE55LrHw+l/36bVHv0sV14SXe82YcEN3x7N9
 /Tl5Ll2nTW09vnpvDbz882bfqs28YUKxN/w9lAI2SuYAAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Z_Y2H-rH4idggrPOQXcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: oWYp3wNhzn-srp8notS_ME9UdMgvnzjN
X-Proofpoint-ORIG-GUID: oWYp3wNhzn-srp8notS_ME9UdMgvnzjN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX9AsoymFX/DVa
 e4FRg96hqeCLV1oljvnkcCEvdEN+H5tswKy+4MzIZhc9zEIWs562V+6xtSVr5szTX47zxD3NvqL
 nTns5QScoanceJpYVWAvYS7f2csQFnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX0xAirwJb6vcb
 KqZZOm1y21XAUFfhLma4j54uX9k8JI/fpOXsKEXlJO1A9EJvA9iAsNewGm5Bxaukv36ZszgSFVt
 Man6G2yzsHIB6grC1y0Uabd+zBj8S7YcPTLWfp8jx1YKJQRUYtz1mI2WFkox5F/v15Tw3hCnu6u
 W4Mrvqgd+09vhbmS3xiGmyxh2j4T7dgaFOLjj5Dn+orj0U8bFt8pEkXCdh4GUrNWD6n5c+72BCI
 LP/Nh+bP381voNtSZK59fXH9KrrDZ+ylhnCWSN1y8E0RDJltHrQXADAlAatZmlv+ji1zGgrJA7V
 hIAygdAuOzJC/HxHGzaN85MBbWMyEa6CNXoqt9jyhHrDF1gqzlfWVkipgxwF5gYOAyD4rV4Ss3U
 CQIYg9cmJ2ql2ed5JOzfuqJ0ooBpc8gz7FYPT0BtyLXIiK90jlqXLtuqses6Fcz7DkHkwyFdqJu
 18L308RUam+z1c9MtyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

A failed priv->kms_init() or ->hw_init() is cleaned up by the ->destroy()
callback, which makes ->destroy() responsible for tearing down a KMS in
any state between "not initialised at all" and "fully initialised". The
kernel convention is the opposite: a function which fails undoes its own
steps, and the teardown only ever sees a fully set up object.

Let the kms drivers switch to that convention one at a time: skip
->destroy() after a failed kms_init() of a driver which sets
init_unwinds, and let the drivers fold their hardware setup into
kms_init() and drop ->hw_init(). Set up the mode config before calling
kms_init(), so that it is already in place for the hardware setup.

The flag and the optional ->hw_init() go away once all the drivers have
been converted.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 23 ++++++++++++++---------
 drivers/gpu/drm/msm/msm_kms.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index f3e39c3907a9..f65774b04c6f 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -285,12 +285,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		return ret;
 	}
 
-	ret = priv->kms_init(ddev);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		goto err_destroy_kms;
-	}
-
 	/* Enable normalization of plane zpos */
 	ddev->mode_config.normalize_zpos = true;
 
@@ -298,12 +292,22 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ddev->mode_config.helper_private = &mode_config_helper_funcs;
 
 	kms->dev = ddev;
-	ret = kms->funcs->hw_init(kms);
+	ret = priv->kms_init(ddev);
 	if (ret) {
-		DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to load kms\n");
+		if (kms->init_unwinds)
+			goto err_destroy_snapshot;
 		goto err_destroy_kms;
 	}
 
+	if (kms->funcs->hw_init) {
+		ret = kms->funcs->hw_init(kms);
+		if (ret) {
+			DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
+			goto err_destroy_kms;
+		}
+	}
+
 	drm_helper_move_panel_connectors_to_head(ddev);
 
 	drm_for_each_crtc(crtc, ddev) {
@@ -344,9 +348,10 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 err_destroy_event_threads:
 	msm_drm_kms_destroy_event_threads(kms);
 err_destroy_kms:
-	msm_disp_snapshot_destroy(ddev);
 	if (kms->funcs)
 		kms->funcs->destroy(kms);
+err_destroy_snapshot:
+	msm_disp_snapshot_destroy(ddev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index ee98393b9855..2f097e23e2e9 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -149,6 +149,9 @@ struct msm_kms {
 	int irq;
 	bool irq_requested;
 
+	/* set by the kms drivers whose kms_init() undoes its own failures */
+	bool init_unwinds;
+
 	/* rate limit the snapshot capture to once per attach */
 	atomic_t fault_snapshot_capture;
 

-- 
2.47.3

