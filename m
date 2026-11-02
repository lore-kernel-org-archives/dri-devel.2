Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DD60A0FFF
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oAjqQaar;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=esn8KeLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D44410F0CB;
	Mon,  2 Nov 2026 17:20:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE47D10F0D5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:20:11 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2GZO8b256684
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 17:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e1U31KgLCeK
 QL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=; b=oAjqQaarCSj1P2bwGT8MJwy2/QI
 BYvKPJgBj+YEkBF17vxaEzendMtTc9uzVPCUr2R1fFawFOYpjjyqyDTu/wgRbZdW
 Gkr9EwrdpRx7WPXLUdyM+L/tewGzqkUX8I/A7663fijePlmYToWgXCQPpeinExtU
 KS6D6CMV/oSu9QX6OoLrXiVIElj8iB8wwB+0mg49BfrfvVmNNAojhsC77EoOyTle
 QbXDqcgXKHTX1C5GRPrNyu9aJch5qcj/hW2oyz2hbdfYJdliSZ3O+z8ln4fQZ9BB
 vDN+X6HKGAPX87T1E1nhtOVoQFT06JkcvtlMD3+wgVglv73yDc6sizpxJxQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5hgh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:20:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e987ec84afso27835255ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793640010; x=1794244810;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1U31KgLCeKQL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=;
 b=esn8KeLe9GNiY/blI2GWfypaEI92bdce2HGaGYzotNDq4Wb6PKs9ydFoZx4oGoqg6b
 iBq+pMuec+tssg/TFrWXtf/+E7FStj6dGLzACA9XgmvZbXo/81wP+kswKT+8Qdj89dhz
 +6cCISKRxCV6NhLRaNFJXPJ2jt2HoVft1l9HrzxXgwcTgd/luwz+Qr2cwdoNJz4sfS0u
 jU4uiETBfZ0BoMiFOvCWHMeYf9RkS4TEFJFhgYM6mcFBzFIeo4Hs3LxfEQmXGRs3paFz
 X/UsD/coyziZL46MggJ7LX0x+V8mFozYBkC1j9ExXxinR4zH/ydmdcjHvrDBHdSGBba5
 PPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640010; x=1794244810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1U31KgLCeKQL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=;
 b=GOkY3M5xuxoogcFFVcZpPf6Ukn6OT34CKltey56NZ5drCL7O7lbwOKan0Zmy4BEgV8
 +0CydUPxoB7IK1jq3uMeXqdRiyZF8xbAE/6l/eB5IKUa7GjHn9u1KI8lwleYmC0a8xSf
 08FsJ5oOfNhfpQbeZ0vsdZTD6dOM5qYwpz61cGVuYlxPNqPAzAGbAw0YUwmlEYrxBdzF
 QNEOmI1ncki9jZ3tA4JzOv9CbMtqvTviue8Hs2vivxEXF8mQrnYIbcqpvZ1UWPRtjth3
 LjgPsfP6CEEXSq2vtubzuH3uycCcrj07pCOjM8zvcGYsvUK8ZX9Od+zXFoTvJkZfq0cE
 zLng==
X-Gm-Message-State: APuU4Z8YE/H0aUyZdBBOD/+qFB3drI7/8FH/r61c2z/qmlPnLjTzYeU6
 Ag6jPVHfpIHS4S51kQLS5Vi7UXUEjgY4UqhfKUoP7I3njVdP9vrxCdUTultOBDuOtWl+FvBcObK
 KfCKid1MKRn2EPMRu63e2mNjsp0MOO7tlCOvMcvvlGWjIhUkjY99jzsr2+hHLLGFQr7xXlxb3na
 5qZp4=
X-Gm-Gg: AYBFou2Kw1b/5DPnPSQTCeFoGOm1ydE+w6ZDMJRGymMt9YpM6+1mrHhVUH2afwT5big
 js2hhBUjtPI6aSPB2ZrXcSWbHUay0qDODKaEnLvxV8Kr87mjdvpiuX/W9V4P5pgZaWQtYJoNDwU
 itfBRUV9ZAtu1icCr1uWRo2bDyPRZyx/wUz0zo+HEJFSmrV5eg63Cgqg8TqDlRgSXK64n7pIJ1V
 OEJNvy0w5SV8+fIfyt1oezfP4hrFwJj9TzphA8JjB7VDMLUuzpbbSLC/Wqyi5PREWmc+GaXANRq
 eZja7PKcweiSI2HsAZci6uKj+xh8jjMD62clLLbAp/XaOyjrERuHAVN0ELY5TtcggCiy5aEI9GJ
 0XNBSJt9UEma/L9VNNDCoFmoBLzdFxtqO+cVJ0pWxlIGPLfkHOd95q4JUr2oe+DL8kAbMWJisTl
 VoIm3eUtbL2GYmPbPgaeaEBg==
X-Received: by 2002:a17:90b:55ce:b0:3ac:9a5e:9cde with SMTP id
 98e67ed59e1d1-3ae897f390emr8325400a91.30.1793640009350; 
 Mon, 02 Nov 2026 09:20:09 -0800 (PST)
X-Received: by 2002:a17:90b:55ce:b0:3ac:9a5e:9cde with SMTP id
 98e67ed59e1d1-3ae897f390emr8325371a91.30.1793640008558; 
 Mon, 02 Nov 2026 09:20:08 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb363a4c2fsm159495a12.1.2026.11.02.09.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:20:08 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] drm/msm/gem: Disallow nr_bos for VM_BIND contexts
Date: Mon,  2 Nov 2026 09:19:58 -0800
Message-ID: <20261102172001.508440-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae8c64a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=5-JVGYL1QLZbPSRHqMAA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: QM95nFIUrIkqV_KPvNGrUbVohLh0Azgs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfX2oqjTdPbOy6d
 tjtps5ChK1MAgn6wtxqjFhhOoHc5J0kHY1TejMCcUqRfai5R6Bxbw6Pqb3dC52oKC/tpIsdT6uk
 /ob2/KkrFWkmhn5E8Cmaod6qusFABrtbJ3TQK/XsStzzFRu6b7jZQzegAjsLdIaXIV4vEMUP0jQ
 9MKLalRO79XNlROuLCC1KpHq/IC6P3Du0qnxzLHsqbWwLk/+S/z4YCmqpzpeYOJX8k8EjqESA0C
 JF8GjEigdFwpVYDOxyOij+2LgDE9X/YG1dI/4QpjyCEUl/k28blrr7NT9pCu2EYqiB7jnqNsdwt
 8Ci2707lTDWJ/i1C782xNZyEI1vlfC07lvwLmc+m1IzWau7YnKDuArOnOGy2AiBNvznNBdVnpHf
 72ufeW4S7lZWS3hvd+LZgV/7dwo8/FIioW2HiQl4cApfbPzbD7iNSP8De1QR7dbVhyjxyekzG4A
 DcbFhmmdBuABUbKUbOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfX+ttgb752nJcm
 wkytxnQE5BPD9ECbTBKS/p1RFJ2UbSlb+TzOmH8hBFTlirYIo4tHC0cQIzMTdLtNpSOSMMqZ23a
 KapQ7xkWTVe8ChhY1ywY11RCamedHrU=
X-Proofpoint-GUID: QM95nFIUrIkqV_KPvNGrUbVohLh0Azgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020069
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If using VM_BIND, it is invalid to attach BOs to a GEM_SUBMIT ioctl.
Only the VM_BIND ioctl should be used for binding objects.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index ff6cf39587c9..b558d07ed2b6 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -272,7 +272,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
 	struct drm_exec *exec = &submit->exec;
 	int ret = 0;
 
-	drm_exec_init(&submit->exec, flags, submit->nr_bos);
+	drm_exec_init(&submit->exec, flags, 0);
 	submit->has_exec = true;
 
 	drm_exec_until_all_locked (&submit->exec) {
@@ -589,6 +589,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
+	if (msm_context_is_vmbind(ctx) && args->nr_bos)
+		return UERR(EINVAL, dev, "invalid nr_bos, must be zero for VM_BIND contexts");
+
 	queue = msm_submitqueue_get(ctx, args->queueid);
 	if (!queue)
 		return -ENOENT;
-- 
2.56.0

