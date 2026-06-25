Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0EBCDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A9110F3A4;
	Thu, 25 Jun 2026 22:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="myM28uFv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYD/kBhQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C412510E2C0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe4PL2161554
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MBmzUwdpwOW
 8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=; b=myM28uFv8n8UWaXZYxfhIindakH
 nWfZW5fPkLmlhcWJ08s4odSUI+PTUt1fJlDXs0xycsUgRkGNEVfA5HbmszEYwcZj
 +m6gnO5LaAJ8R1iMANajWnutUrFeETZ1APeysrh5Z+eq7YIPSbhNwjQtf9uNYYHi
 5pB1KSrxztmvhZIoZYAsX3b6fhXkFvaByNs8oLsjpUIUpWJfjmwWioS4BhC+bNfR
 kJvVgfR+64mVNa1i6IU5AaGI2nSmTgaTXhzeEhc0uQsTKxEpCEo8mnZU/pnkoIO7
 mkNRaO99vV576BEbFnDHkcaR0tUioYbqLGQXXaqogGjEHLOPtIdHMiz2qUg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv3fu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c7ee3952d6so2864965ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426473; x=1783031273;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBmzUwdpwOW8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=;
 b=jYD/kBhQ4+SOKBiz6MyOJNZx6zb9Be8ovkJjtVgTO9GQ//fpfLOOTqRPWSN6Pqrzt5
 NG84InpWVvrturvyhaAfiDkD6D7m7sczq5lP73qnb6yfBVZCZqs/d0GVLXhxCLupU5R8
 m95+q46SE3sChhYKhFr8qQYk4B3wXOqt3Ay1OUAymsUEqIu/UTtn3YTSEMYjpxXECoJY
 bt01dh3NdESRNKKi4J0vdLVWCXk02WJd8vZG20GeJ5uk/7CgLSpWsrDPRUpLsBn55OQR
 KuA19UOo5qLbi4pX6YUzFpNq+Zmp4G8fZUl5QJT1rlShlAthD7wJdI9B/qOfPbIajuNa
 RuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426473; x=1783031273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBmzUwdpwOW8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=;
 b=PbhSp3Kzi9wqFoPsn0hOdc1KbFjlR4hxRyBvnD7Et76SrtlZQLLpS8/yuJvwx3Lyao
 S36AYWbPPAla1OGQ6ZWaG470lS/dwWcMIjUaNEvBWaHA6YcDxwvH6AUytq25hM4DfO7a
 5v0MOjNQb/mRL8sr/BTb/nFW1qr0whglLMwO0FRlJggijzm8cHp93jlQSHkH0FiI5OKx
 F7RUDUxMMbLekdeOfCnS//9yGP3oL75arWozSHnu7L37d5AQPccSQbxNTWsKUdWmagt0
 MVQWzeZWCfPwx65OIHYhTsaY0gDVynWj+ez9Y+DlGIyc9R40hlhIWIkFuA8v4ZXS128t
 XDXQ==
X-Gm-Message-State: AOJu0Yx08QD8oeU8tu43kxWs3zkrxr/cKqiqFjIBknX0xurDXVVJCuFf
 3jp+Ssz3rDjtm8FqWIbzag5qEF5RjFtpLDqKMtcSecZ6TZ7GIUOa5907Qc5yqjXuZZk2ciiW8P+
 B4W4OpiELRycihkop0v6ScoH/pS86+Kkgh+lqwh4HZ4xDsZxZTt3o7K7cMrarmzvFkCB96zsqWD
 eGBdY=
X-Gm-Gg: AfdE7ck8CcVLvSW7t7O+QjYvG6xOxXVlyc0vUgsOc3p4frse7Pr69ELGs2mB8LXj76h
 44LKkgp95jX43dsVoZ3y8bGSlmPcen3hgev/t96m/Qzyqx1rE55n37qul+XNaqyiLoPiQrJ5Oqg
 qZ/IxqmZh/GFeuAz/KeUxRx0OVKoQBxfZD1Cav8qNi6f9BBVN8F5c0AXviWJirWbwtjYgEGVFVG
 iS6ol427j3VEnIbWsBYaMgfyDq/l86hJBO+dWfEakpSCpE+mS9g6uzLpJUdSt3O8O4LOKNJ4ati
 cUkH7AI3SkHxTZ+UzGmirESlM7tADfhXcr51Wr1SJHFy3HYVkYYZq6Z+TCLrRWUmH416yHouqti
 IAGdnX4q3NuXSt7UIC+0EH8zUmeSTeqBZMvMpUXzCKf6HGRl56DCQBu/Vsw==
X-Received: by 2002:a17:902:c94c:b0:2c0:b081:84b1 with SMTP id
 d9443c01a7336-2c7fc681c93mr39522865ad.10.1782426472628; 
 Thu, 25 Jun 2026 15:27:52 -0700 (PDT)
X-Received: by 2002:a17:902:c94c:b0:2c0:b081:84b1 with SMTP id
 d9443c01a7336-2c7fc681c93mr39522645ad.10.1782426472202; 
 Thu, 25 Jun 2026 15:27:52 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5b04be8sm27459425ad.35.2026.06.25.15.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:27:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm/msm: Fix barriers accessing ctx vm
Date: Thu, 25 Jun 2026 15:27:40 -0700
Message-ID: <20260625222744.22254-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3dab69 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX2ObtZjiw3vAh
 un06ocMlJZEGOxPAsp8uS7cw5gbF0aE5cBCwJUhmuQMxxKp13U7sUcF/YVoQk37qkHPp47KQjLM
 1Ydh3+3AWtHCm7NubA9640p11hXgQNo=
X-Proofpoint-ORIG-GUID: JRATW5jANSXS8q_xGB4uSinJL_V27bxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX45cQxFJDV4Uu
 0Yg/j/eJBUjS1HafVmwSmj4Agt+7mKUrmNiqoZjQjMCoeSRtgZt8fN/eaH9Zpa1qmfFOI1gui68
 ZXrfyuXBHXCX0mg8qJYTWTriNXLraDbGjk+OQ90TaHZeklWkjgtPOAhl83uuKEjbLIqI/khfge0
 N+lHwIiliULEUg0zmP9yhCnPAbI3fbT8gqAmdrki+fky3NbNmHLwo/FOdDTTrvAoOMDh/JC1CrD
 3Htvo+Qke9HTElW3efG2FAYtugElaW89pBXISltUf6Y5ZaY25rnvTFsGZ001HHcuDbKJnNm9mlo
 1oFWblvU3HWbw1wa7Nouk6rdKzpXcIuMHod9FruwSvcra17sHiOw1Uvz4cwB6GXtvtGpm4ZsL/G
 ba25V0SJgm7So5qhGqvPCqXYjnIH3WFFqFWARc2y8kGMCBUAgzq+rhOrxuD/VKwKFcF1F00KNgI
 0813ZNlcLCj+cV3TAkA==
X-Proofpoint-GUID: JRATW5jANSXS8q_xGB4uSinJL_V27bxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

Don't rely on store ordering to protect us from caller seeing a
partially initialized vm.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 32d5ebea2596..ec88155e0ed7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 {
 	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
 	/* Once ctx->vm is created it is valid for the lifetime of the context: */
-	if (ctx->vm)
-		return ctx->vm;
+	if (vm)
+		return vm;
+
+	guard(mutex)(&init_lock);
 
-	mutex_lock(&init_lock);
 	if (!ctx->vm) {
-		ctx->vm = msm_gpu_create_private_vm(
+		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-
+		smp_store_release(&ctx->vm, vm);
 	}
-	mutex_unlock(&init_lock);
 
 	return ctx->vm;
 }
-- 
2.54.0

