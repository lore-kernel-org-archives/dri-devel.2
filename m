Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C17C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1687B10E7F8;
	Mon,  7 Sep 2026 13:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqtCptda";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFHaPQ4e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B4410E7EE
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnRmM3863358
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGtKVbi4qmH7perY7eTj05kWZ+nIVJ906qYqVXk+WkM=; b=eqtCptdaQTArUrq9
 g+YYDgNZL8xz6P55yHV8P9TugFEVvLfjnZG9WaD6pz0SXa00xXJCmf8P0NXmzKNk
 dKjozeCc0EhLW5lDT0zS9PjwLCUqS+9IAjE19ql9DRDLZpT/DVG4R33Uca5oXe/v
 vhrEtKJJEaU9Xm4nHHWqA8sACbErCenB3DlCSEQI2xTjYckmk2cRqcO7XJPMlLGy
 fz+hrqdyj07xAlTCggL2WFxaaQyZS1zMWPRP+LHDFm3yL58lbPUmrPhik0Xc2/HI
 eH+S6YQrfyuGFFiqmeeG30zXFDXpqv1obIKD4VhZlPHHDUPFc3CMbduRO9RlbGme
 96lIbw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghq66hwdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:44 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9e2deaa4so2714585241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786044; x=1789390844;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NGtKVbi4qmH7perY7eTj05kWZ+nIVJ906qYqVXk+WkM=;
 b=GFHaPQ4emEVmK406huhXx6FvRIbSDLttSHQUSsYfMZmQRSwFWmelvLOQHWqKy6HKj4
 Rqe3TahSgbYPLB1G478sSDJP0yz+86S7JwLBehcqBDHKZt0I1wHbZqYrDgFh4gj7kK3p
 F+Y6bSDrom+KhNvGPsgqaRc/OrxngwYs9LWVc43HSVoQAYoIMV6cpfPw0lQtuZ1JDnJc
 rsNyfEa/iDMLwOLTUEV0FCgaA7b+J88q+vqOH/tUSy+txLlYmgf9SYnYCjZnr7N9EEiE
 61WnfAi30mzv3QpkOq5nKqioCbhKDGB5gZDldVC21A+4lIFo7hXPlL0910QhBqEc4K0u
 vqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786044; x=1789390844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGtKVbi4qmH7perY7eTj05kWZ+nIVJ906qYqVXk+WkM=;
 b=AvCbyTQhtc3JN2aLVp6ZaRxqKzlXS3zpo3AKu0euBLTShzFbWUMn8KKsN0NIkCLK6T
 EyHVfiCAbxp3IzsTgAPW+plc2xqWBYBrBPd7yrzb/ein7WHIms15XVLseAvuESvu6YAX
 pEHNYsbT01KgOKZDeOcJTYeQbc8ylZtysrt2Y6ZoJ4DBBAuCZpxHLMKKMrw7qXSiY8VQ
 rc7F0Vlcy3aJFaY5LmMs45ylQwj7pnPVo/HvzE2HvSWNZdRfH0nkmaFN7Q45I/IN/CsA
 BSK5vNwE7hxC5QwGXceuWNlU9BUJwzajULOV83tO/C/GiUjqpbqySXgSd3tYwYan6LMa
 cHig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZXIGHuHnlFkEwRHUBWpmlE6zo/N+xQTzaaBRuN+VKrsZJtjttkdrc/JD2Fi5n/Lpqp6ZY45Qn7RM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpIdzgXkpnn9nSYZGIhlVCKQoN+hU0HNeBF5RjPU+cLG+TY1bC
 iHmZthHCPkfERpQ/ItgR16BC1lVcFJs9Cx93dsIvC2q5wEfNbUliXhc5C9U+Y6np4Px8SHzZbwI
 esKJcpScj0RMlcsfPgM029XugZsztsA8jG9MhfbdAP7mkT8dp9HEL0jW8DKC1xyO6Gnb5x4g=
X-Gm-Gg: AYBFou0lIQUlX8y+IPdue/uTs+DkTY/QGcogYo2lZ8HcbkOpRverFIrAyQbvPqL53Gp
 lmHEjhSBp9r8HRpPpP/1XWH+0P+MoFxHPbzw2OEi9TI51Je7YV5BJPTQYwXl96CCXMom0ByalIZ
 zH1ulnaH0JvZuRuiFuDWXAWE8VecGMXttm8odONhE6wGlTArNO4tBG5Yci9ntXz+oB5PcB6TGU0
 v0pQcufWHRxH8dAjENYPxQLCQGTa1lj6MjoQfswUgxbF4DRUDjASk8nNZEp+Amd2h/c6c68fAB1
 hVrSLwE+MixeH4k+brpbGNsMMbUNESZhLNn+XDy9XqZBASd160u3z4W1y6qMcXMbaDFLcflcRaj
 8ljcnXDGFQXwJg0eylKewYRo=
X-Received: by 2002:a05:6102:6b03:b0:77b:ae7:1bba with SMTP id
 ada2fe7eead31-78a4a72eac3mr10147549137.3.1788786044404; 
 Mon, 07 Sep 2026 06:00:44 -0700 (PDT)
X-Received: by 2002:a05:6102:6b03:b0:77b:ae7:1bba with SMTP id
 ada2fe7eead31-78a4a72eac3mr10147506137.3.1788786043927; 
 Mon, 07 Sep 2026 06:00:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:19 +0200
Subject: [PATCH v2 5/7] drm/msm: Properly handle msm_ioremap() without name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-5-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
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
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZRj0b4CjBJiY+zbzfjhuo2OcOIwPPNsvrYbekJ6R8r0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVnrY6Un3qGaV6R6PpT9owSV1PPsQRqJT1Ex
 C2z7Fs67BuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZwAKCRDBN2bmhouD
 1205D/9oWdKMeZv4Gh96mdTXW/owcShNTFOLsw4lBV1YwwAj4kNcymfEgy2EQ+YIaU+Aovimm/E
 t4YfGU//Ef5YuFn99vyC63ba36uJ0Ym1iC4htCpHQ23dv5s8qJBhobHPRFoetDR2MphnyIBAhWs
 9ODbrE+woaW8W7gqhAxhiNmMZtS+TEUMdX5BJTEQ7th10nq5BcPx2tEbjgIegl9fwXvprv70WkB
 r7cZVQqUfC75A+Fq9G5vJii9nlLWZoTkrbQp3OSiSO5G5d03a2AY0VMB4WhU2z1Xjp52GpPl9YG
 SNiBoFtffa4SJ/jrl/xsPV3uO+TNt+Du70F2GTu9Vfkn+mC5dz4GgUcn5X3oqJ9BMCZNmaeUFrN
 VAgPMpfPMWJTYjw0VxGK1/kV2rZ4iMZrmD3nvaAKi50JIZbqEjjvKM7ZURTehO8apsMIK1Uypd3
 SNN8Pw9o0a5oDhA82eGLQM01Gb+IdJoegdBCmJGm8jnOWvIDLJmE/I7f0H38IdDlnOQKkVPtIEL
 0bVuLgxfq9rfD6FM/a0vrICd2Bcs2ReYsXeNUoAhKiAPz08WhnDxkdOKA0u7jfwL8HRj7+TPEKD
 nzZ8sUPIS/ewcSwFtvdxnbplBnnOneM/1WlezQfRxHzprfKcMjrCVLMAX+uzCgxIF7YAKxphMg3
 Pm5R9KUrUBX2DyA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=QPhYgALL c=1 sm=1 tr=0 ts=6a9eb57c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=or9nyMeYumr6D7LEzWYA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: Y0Vxdoz5L9Df_MDjRiACYbLabS-0Wtgf
X-Proofpoint-ORIG-GUID: Y0Vxdoz5L9Df_MDjRiACYbLabS-0Wtgf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX5APOfyKcaOBO
 dPQFlUmejcHF487Q4S/guxmlrO//xVKIstnznyyOrAztEoeXor+k+rrOQIKSc1kVyEJEfmdhO2g
 91VKRB61YjIhrc6KKtvnJ4TiR21f7Vg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXxpQq44io6wPA
 dKQ4k9CHOZ7Ep1Nycd3SINOmgWSZ1Q9ojcva17Vh3K925HYEkQDKJC5lJSgRz5QHdzaYErE5c0L
 vhU6TX3zHhfDBzb3UteNFm+UD6opuzXGe6531O9ein5DIaV20Hm1+sZsUAOz+HZuufkdhlQvLWb
 LrMNGysrvS3VTVdZkMlaEJLU/wqtcwYyesnyjTYvaB38cccQIjV0YgIETgIaAx08va1OY+cFTEW
 tQVAll23xFJOkmKJ+2JLGZpWTJTFA5jrALk3O88uEvtMBYfLrdthnqmqobvX6Yz6A07KH3ZB6rE
 GMz0jBPmOMJRdGn7xQidPboSvTnQMgmLy11YH2COChkxzLOQInGNoIsV2qnzbwAnORdYVOPQ3GL
 j2SCZDu5lfHoR6nOIuvNJFFhZpPdCd66QE5xlOsZY87PIZG8nuPYP7E9vtiMvqLixB5HEFn5wHW
 CPzR85k5IEgDX9iwvQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

msm_ioremap() accepts being called without name of the region to map and
in such case maps by index 0.  However error paths still use the name in
error message.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index a6efe1eac271..0a4ac0fc5fb5 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 
 	if (!res) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
+				      (name ? name : "#0"));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -86,7 +87,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 	ptr = devm_ioremap(&pdev->dev, res->start, size);
 	if (!ptr) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n",
+				      (name ?: "#0"));
 		return ERR_PTR(-ENOMEM);
 	}
 

-- 
2.53.0

