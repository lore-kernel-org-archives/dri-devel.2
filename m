Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66775C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE38F10ECC6;
	Wed, 29 Jul 2026 15:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzNILbgf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZEja9xo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5966910ECCC
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF2Y8b2396598
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ss8T08lcQRu
 h4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=; b=DzNILbgfKW78+tLPUtiCbtGflhN
 Tz/XvVk97izyIUHbklt0XAt9d+WcriUW4s5GVya3/NQ4KhV0EqpoVoiThe1i3Jmx
 E7psVcT9EJpZ+svd/U6ROffu3yiNWFxzU/JFlcLhVPVeBniU4Wjbkeygp0mzFW5z
 wv9CWV7UN8CxfQHvEAYRZDrpaZZ5LzzUGtomS9HNQzP8PBqZVlXO0bdbRcofMjCc
 JLmiCZbjODMCLxClSGfqLp1HcNWGyb3QCeZiIJea5+esUz4c47bRDu/wYnu/3FyH
 Kf5oylTLw8ipIKYixhIRlCRlRw7sbpDju155k4y4bOyag/DXopg6Zk0+IAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr69amx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso1899331a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340618; x=1785945418;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ss8T08lcQRuh4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=;
 b=BZEja9xo7MITFOBzKUF0ABWGfoJumRwpymZxpkyZ/IJvWEpf5KC2kWn7zhlHLG71td
 iySRE+UhYMSqCoXrnV+5dN5QcgsmhLFd9VaBx/YV+hOTpF6A4wDCPcLRrqJE5MEXuyNK
 AlX/uTdF9jqku28WNszfWpMPwdBWCk9Qp2tPzi+kINgNVOSQdcmFUazPt/kL9RW55UYC
 tJ2kGNMrvJlUhNjlO8Ed8hkmXdDwngoMoRgU5BEjK37Y+5E03UmrS1y8p62+lnVmCHoH
 5PnKMQ5Fu94IxEI44xcDB5jSRXpxpRMvuvsCOKaml9Re5/dRlzqfyTXCaZq27P6ar1nc
 Do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340618; x=1785945418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ss8T08lcQRuh4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=;
 b=TF5+HwD9uhqrZ2DGkVSAqXWCkzvddgrijHmcYAChW3zNcJGBUQk+VPXSXaBJ+dgHzy
 o6wwwr3ZU3s63bk0zlbyBv2Ys6KF4MsgKtSo2RffF4tZqpg+NqWuLnxhEPbDdw6Ni4jn
 pFeLFKte+tx7qlqIwnuUv0D6XPZyuyK0IDefc5b+eMv/nqeTnRCO5wpAnAwqIOG0AjL8
 0t5HwhaB5ZiifVK2XBj2KYuneQXnTjHxMQX5jn+zdQeM30e9ykDJemaTYw3HmCPSv4yE
 Ki+uew1QrYA/LMiKSBpZafSb4hfj/c79nIQevWDlnh8caLVQ70+0oI/n37yB/qY27sxt
 sIsA==
X-Gm-Message-State: AOJu0Yyz5gq4W3v26Q9imiFq/HbbBgvElPnvXaDBLSvzx9lZqZzYpb0U
 QrJx5HWItnSQ8cpKb8Xlq3O/olxYAmoESfBvO0P5hsvZURiAEDKGQRWZn3RGB//12n5QRH8gJWB
 zRfctHZBqOLprxBWFiOKw7N2JOs0qRa/N9Gddez95QTaDJRnHYFG+CFSC09SIXO/SgeYY+cApaw
 nt9oQ=
X-Gm-Gg: AR+sD10uzp+NC+DDixZcLeV0O2+nXNTGMvrsd8sjD1J7XmUxtWzMWcL0AAM796drKfU
 t6/E4hAB2klRPwHEMYPZAaF8bjYeREnfDP4Q3smixhMeZYEGX9UdDjbgQXyvuPiWW8mWsDkw783
 o28w1k7Cz11p/I3HsiWcaI0TvaKwY1vmgQuuhpq6Yj16jgATM9UlZSdZB69Mx0BkpAMaPdKKHau
 LT0xtMr8lfMQ9ElBiuKI6FtZYaFKm7dOocIYqRLnvk64O/H3HaKNBS+317cNg1nyYbc4Z2objYy
 3U6vH81SN63+AD2k+o7t4UsBC0KWENuGtJ565+tnk9o1zQ9qmrMwc+i5yRmLl0khdCSKA6QLGkg
 f1ADvd8SYj9uFOB5eY8/7VP2CJqB7adkOIm5P/I4s4JgfU2M=
X-Received: by 2002:a17:903:1a84:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2d015ee21e8mr88173295ad.22.1785340618387; 
 Wed, 29 Jul 2026 08:56:58 -0700 (PDT)
X-Received: by 2002:a17:903:1a84:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2d015ee21e8mr88173115ad.22.1785340617955; 
 Wed, 29 Jul 2026 08:56:57 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf99edsm13505125ad.67.2026.07.29.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:57 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 04/17] drm/msm: Synchronize set_sysprof on ctxlock
Date: Wed, 29 Jul 2026 08:55:41 -0700
Message-ID: <20260729155609.20190-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX4T49Ohhvd1QQ
 VEUF/KQLrwRM5fm+/HJYU1DuX9OgjvPrQ8l4Lccr5gjsrK+fUNWfRHKUwBYDt/wph+1OKooW591
 lqm+/XboFh2RmJwg8q1HrR+4bDtT0/5YIcnmm80TmulXpj4XP934dRMzwZ1DaCDdtyPHd4LmATK
 j3sPBY4cjMrfgl+qRqIMu2YEGhvzTJj93LvP0I5Au6BJ85O5FNUeLV+H0jN9Y79z62Jz55y9KDj
 WlSL5qYgXthKWo6309+yzit6F+7HVfEfEt8S9V+9pZehMfjPwxB1vXLuCx748JlBkxC5ph1VCPP
 4jTZKCnv7F93+VnWCSfXDj7ow7j17zJVKbAqSSuXBkWW4nT5wm1dmD6tKJ+UFWB3iObYmSdlMcu
 GJpd9vUlKpbNrFB2v6fTho0nWXaL+8thbS/1cvgpPMBc/+BX7SbEm5Xbz2DlJtW5ZGAwXWahpdn
 aq60AYKFVE08ziBIrKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX421leV/exH2q
 w4WBYeJLICtkjgmLVNEpmS43PrqGd01gaImqSXJ0hlVrH5jzUYhrrjFja7CwDvl/42Mp1wll11u
 e2UDzGzza/MS/SawcxJV+dj2TolmHuw=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a22cb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=A-0ye_aN_Dr-yZQka4YA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 0ou9vRQfz0z__Z7K_cQlYZZH03KEybhy
X-Proofpoint-GUID: 0ou9vRQfz0z__Z7K_cQlYZZH03KEybhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

A user that was perfmon_capable() could try to race setting SYSPROF
param on multiple threads to trigger a reference leak.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 8b5980d5a6a7..233c4f35ab12 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,6 +9,8 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
+	guard(rwsem_write)(&ctx->ctxlock);
+
 	/*
 	 * Since pm_runtime and sysprof_active are both refcounts, we
 	 * call apply the new value first, and then unwind the previous
-- 
2.55.0

