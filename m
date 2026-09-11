Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C7EC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141B510EFFE;
	Fri, 11 Sep 2026 10:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pHksfQeY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FlCxz+qr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D5C10EFDB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:09 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kquh3513962
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=; b=pHksfQeYf+c/aAK0
 N6tQXPebPfDYihRs0gnVQe/eqzFFTjAB8xAzmnM1YHLbYxJw+DxXVzC/80mhbH4I
 BXRnlakj1LB8IQrGWdsCpYEbKmOZB9yTLuLn0YbRvPECzZzQLMiFrU3Yp3NkeOb1
 pBMdk7NEnG1IALukD/ZEoPag1T3r8Rv+i8XojZORFUdEVwPEIKIadbwHIG94rZ23
 SuD5VwUoZ4WfKYKdqq2LOZfZLYlri6UlTBoEuVBk99+oZQIKtT1HoG236X9xqJ47
 a50oV1cqqUjLzIDsk58okArCct/ViYflsBt7jlCb4ffDZ7DNeOSnTG7jTzdUSyyP
 mtmCcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd51649-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930b571432fso155740185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122608; x=1789727408;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=;
 b=FlCxz+qrhReWQGePtZkOt5SNfPrvPMURMM2li9++k73BeOvGWy4diKbAZhUad1DWuH
 FTiqsa9OzNYApvPPbqDaNdC2NiLF+dOXsChjPXi7om5ccwEtzqQ503k5RyZs98ALycrw
 GaRb92+qPosGajRTvqU0ERKABKbv72tmQOZXBPHJLAcBAnDO3hitE4at05/RkchMydtU
 x5rg8L7L9+aRm/MpXmkbVNCVr7y+x9LMy9E9MUlQ71p4njVy4ylvwVjKd21drRtjah9s
 V0HtcDMiQKzHGLhV0uFdwrkvZJquGIgvYTH6wlho21zium/WxCk8ZPHncP6J97chP44D
 Nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122608; x=1789727408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E0C2reVv1oSwnphcZX04pJknqbbG7msmctVikhe2z4c=;
 b=OF2juo2W3ETW7ZfVqcj5+hrzmY70xGxuc5pHj9CKILYyR4vfCrmaWhPVCWBiYvW0jR
 pBUe+CoE92IR4fQx4tCNFLYln+DcvZpzEOkKS2UNlInzk1S6vxrz5adBWIT/46FIJWsU
 djjAO2W0b0U8djMK/MEUOkII1QsaXTUP40gkqiQt/Ki9aoO5VOEfCm4wNlIvOnrD04ro
 WKKB5X5MYPbcRtmUNWHiGPbdmDosE9Z41uyuObJXuB1HOd7sw2qkCe2zU08C9t9+PsSu
 PgZZc4BDYwCFhsfyaWMyDW06w/2an+CT1Usim0nlQ3/6flo66SXbI4bOPfcETA9YhA9C
 VJtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylW/ksTaDS20ritNf9IqCbB9B13sLzcQFdejaNLGe7dZDc2Kg3+f69+H92VbJALOcbrYxGFQTZ/XU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5sYXEjIUr6EkvT5T4sF4DRh2GvsPIhuiQOaOwYm0J6l7WIAVR
 O4+ANReQWJHkfNzJ2j9JtTJCJcUZBKQYGKZvx9zSPHttoF62/Pwggp72xQ/UYtglYaM4zSmrS13
 FnzjoMkQAf24eV04EQG4wGcvEpVS2C1xvk74R3yEimEz5S96In1q5K13UHoRq+wYKsa+HneQ=
X-Gm-Gg: AYBFou266MKRgI9bdwLZPdBbNGMNHLS5xBzU7t9y/Z7+NQn8Sv4zDNTahmHlkrzm3Ea
 5di0zPqZ3BFtaVhHEN4jRsvd+CgPidyAg7gG2rr9kCj6ZZlbO7A0Tzv90U75Y6pky78p2o+zE8j
 EPAf0mAsc9vjYk0uUkvUOw9llzRMH2zXjHrus7ijJekImBzsVo6jXWmEZXlTfmA2zUGCvIFBlS5
 WEB1a+X3q3u/lwDKWIi4aVm/DKxuv5o2jSht0edifMlXGQfH1yJUQpUeF4u9wtQ1MMRdJ9CBIrY
 3ZVflQepnibJrjAOZGGoClwWDoZpEAq+HH28aGieSC05BRsNQOHJjcrbgVcmVrdnQcKTHJr1KU9
 U726D1dDJTTxQo6cI1NUmDUI=
X-Received: by 2002:a05:620a:450c:b0:937:6f98:c68f with SMTP id
 af79cd13be357-939d7e3ff2dmr1128935885a.1.1789122603192; 
 Fri, 11 Sep 2026 03:30:03 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:937:6f98:c68f with SMTP id
 af79cd13be357-939d7e3ff2dmr1128904385a.1.1789122597996; 
 Fri, 11 Sep 2026 03:29:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:37 +0200
Subject: [PATCH v4 4/7] drm/msm/hdmi_bridge: Drop redundant initialization
 in msm_hdmi_bridge_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-4-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DVXNSz/QqITCQAR3c9vgiIReGo6sp1REqUL1NIZWtK4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gTV0/YW3nDgV588FrAxTLe9cG52WMzAMMYr
 NKI84Lz0GmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEwAKCRDBN2bmhouD
 12GBD/9RqSUlV9uXlVhuHr2uUrrhS6rxshyiGQqKwcZ7ksHEN5NVwnshts1XzecGukzkys9Jjl9
 GoTlteAOfZpaYwvtJ9iN+XLFs54jScHcP/7eqO4R6Z/cKzQjeB2HGzaf1UTUiHRqBBVDQMhUo+A
 RBtZcL+7XmiQVESJ9ZpMmyo+0xejSPquCYO45iV3Np48YlEA1Dl35EjkLhuPo5XU4O7/WrP8tH7
 lts6l04ekv7YMO97ElLTS93qNnMuZ/MuR99FosbezHM59KO33o4XtwVqJGDQsxEiMY3ASamii9q
 5Ljuho09Vs3yTJCvKgNDmFWKxcj3TyshRUfuy00mRPnF1AnpoTPNPjDxU1o0AoX/sCXovf1rc1+
 pkrsI/9joUx0hs/2AX/9HEkoTJOZCxeOstg8vPkIBLY/OQl4HY+6coP9jkOwP5Hkiwy6U5ad/lT
 CFzm6wyEkaEixq/tq8YJGrkPA2oRPWqzD0vJUtxIyNmwXX+gvd5fbSSNhFaET6RdNjci4/8REGc
 zXAtOBPUBFKr2QR3L9hJ4QTKTRmjjBguyU53XS9CEOscIWKaqPXi23wilUDtmts2WJ7fSEnbSGr
 X4K4Ic9vaJpmQZom4HKVt4NSBE4JA++KrmJ3vmJ6nSWR6NG/Vybn8Kuaoo+0nVncsVlj6eKN8iL
 zd/lzs+F9i6/8aA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: nQabiYin_gQI_EJGhau7dL7Mwanpan7u
X-Proofpoint-ORIG-GUID: nQabiYin_gQI_EJGhau7dL7Mwanpan7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXzLtWboTUciM7
 7bVIiBCoHIxpf/mtOvFyzyUfmMGcPS4uWfnTDkz1b59RBoSQ7cuh8u5vecHF/r+pu9xW20XUrrA
 uHEabb9JMUAUpnJlnXZegYD8jDpb29Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX388ubG48dOxH
 LJp98L1elRc3I9aIHe91dzDqYSaTLTsIjAr66gg2kg3mJcy1br1htCYOlZm2vm9LE6GPyhkBxu+
 8G5PW+5jSWWQ/WsWzRPbwwi83fySLw/AEqqCvT3uPWPt7CnwHcP6MDdFUt3EiotcCWNbI814tpL
 8i4dF9X5Xzan7iaHt92HZp+yeUvBx/7hfQZ5Oc76RrM0xLiouMWxgRJ0mo5SLKlz3RrVttRY4sd
 9AsBq6CHQpEYwftuGYHAbcjQ6xJZlvDjYoRcZQXQcMZQ4IR0QnZfuf7VAVsLUsZyNWY6IxLw8wG
 1VHGTy5rljQ74ELK9ywqPXb35iMh5EIttnaAF7X2O0Rse3OBNnLxow9oMisOyeX0TQ3V+HPacwO
 DZ0y+gBGY+KhQ4WxiyZXHN+Qmk6gxH0w77EQeZ0Gkr2dUrh5/3ufhh5F2DxSiW+2WHUaj+4CHZv
 MzBOsXltV1KqUnN8YtA==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3d831 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RZP3y24nY_lDZDhlvS4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146
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

Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
the function, before any first use, thus explicit NULL initialization is
not necessary.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 1860605850c9..49587927e8a5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -484,7 +484,7 @@ msm_hdmi_hotplug_work(struct work_struct *work)
 /* initialize bridge */
 int msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
-	struct drm_bridge *bridge = NULL;
+	struct drm_bridge *bridge;
 	struct hdmi_bridge *hdmi_bridge;
 	int ret;
 

-- 
2.53.0

