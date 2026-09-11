Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A105DC88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B91510E822;
	Fri, 11 Sep 2026 10:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqEc/AEu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWqC+jQX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FB410F01D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kofq143903
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dfXCR8WLAG7aE7tsDiN6RRiR4IoTNhMtx0emBbiNuls=; b=VqEc/AEuTF7PpT3X
 olhkf2h9Bdq61NedwcggjM/bzc29Dqz8ssNS2ZdN1ZiCfLeSmWhxSzcXQdH4I3+o
 yzKEeScTa4eqLab3dXzV3JdHeElrraduNIQWSjE4Odv4OIFTL6Rcf9sVq7MQZwjQ
 GKAf5oooGSPR5hmf5/S7Jc/n5wLAICX+iB6rEnd1B3UonuOR6/UCMyMC/QhxPrtO
 x1I+5DxSKopjcWAvKpBbdir7T4WmIXWYl7f23ld7zJ8tBdeftMI1bMdL3VkNpe0B
 GiUZOF+//fEg2XroqxH30WeGrhan++NEkZTcIp9lGTyLO4orabT+NdHadu5cR2E8
 AGI/Hg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd396uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9393ac4961fso89862085a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122600; x=1789727400;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dfXCR8WLAG7aE7tsDiN6RRiR4IoTNhMtx0emBbiNuls=;
 b=TWqC+jQXspKye+Q5v1bX1jvKmKmR/6Xhqz9FwyfHgRhpJwWv79ISxUrBZVCQPAVziN
 sBD4SLujDL5FMuvZlva5ytUS5+DIQPGfhrU9DHLmHWeq3aBJdVIiFicIhhkJ7NpRETC9
 PlhZcRW5O9ulciIfRkDUDl5PvvVYYvGXhkiAlekaqxMQZSCE7KTPsT7wlRsFchd46AhD
 Wn99t0VLY34SqFcfOG2Tn3C86byh41aV7wre2rUPDemGhLrwijxcXZSTnft6Kgwt96+W
 /GPKq56nmuFy0ZYoDIIZQaooYqYtccMg6tnbQzm/5t6qlhG47VqwAdHWccJraeQYyNFZ
 sp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122600; x=1789727400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dfXCR8WLAG7aE7tsDiN6RRiR4IoTNhMtx0emBbiNuls=;
 b=O4y6H3dSGeaM3DkR7iGnVFtxhHK42+hctaDSNQjajkqw+9Y4bmF4UfM2aCqzDfvcX0
 Ayd3sE4j9gcO43z7zc2ZHoL4lamJwpv9xThOygwpLQUmXqDQDEYEuRBQn7gffSdNEoyL
 HUhz6Ay0gSnojsoHTrzeIya98/xihOwbkiM5gg4jhOVKP5Zet8dfzcG/eresZdSn7STS
 kzBVfFhP44zaXGcKOF4o32rajtLWOEtwPy1TiDlDuwwU0bAUNxYZOhUCsOuHDuf5NV0z
 SlTxg7HDfuslYmZuVnWye099k2JA/VYEk/+nO9xXhh5mUG12qhHXX5y6naOSgfhVoVcF
 atHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5g6HtBAgAKdPrhgGqfUKbVJBppY2si+rUNpokcURiPn/GRwWZQ0XGPnSl9Wa4s9+RJoNIg5+AMRU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5/0E95sycU2FxfojNrBLW22UM2xGOHNQXoUe2XG20BqJX7Tfj
 UJ6Wq1bpJdrbHA4d0nrRjyOEf0uGDUU83gCRQfysvHFcgExyHTAhM5nCC1aI0ra6kBmVOckyd+Y
 n21rSqp0e0sXVKCBPBChVcvadcWVkPEXcILSw3ubsbdtDC+O+euxELwbDlg7HIVNM52IrUZU=
X-Gm-Gg: AYBFou3GKDb+FbY4WaDwjPwFBPtDHn39iMu3/Xr48P3YEya0lo2pQhuKxQF2oIxwEox
 mjUleE0bxrYYAH51tq1VqTCyu+TCBIeryH0cbgANnoZxWnzbixtW9DjL42YX8/q3DSJ7Cziu+EF
 Xpsi9d/py7PP0QhxFp1gc6M0pbzYJ0LfeoN3qPF3XExg3HT/s+sJy9t0itnPxznS7hZszf31sHK
 uQ7jRhCKn5juFUW+5WoEZuWkP9vMN6pxYRGsW4J38o+ro1v6MuLNWN/FsSiism7b92/J81tZScX
 49HlqkaF51PfK/IQbeLNJy4oQgZnEwfabT/IVrjkDjIPkMKgCckTN+2hVeeaB54Y0gGrnSGcT4z
 L6EEVokbdrdV66tVtt65bA2s=
X-Received: by 2002:a05:620a:710d:b0:939:5c30:fcb8 with SMTP id
 af79cd13be357-939ea0e6e28mr448598885a.6.1789122600574; 
 Fri, 11 Sep 2026 03:30:00 -0700 (PDT)
X-Received: by 2002:a05:620a:710d:b0:939:5c30:fcb8 with SMTP id
 af79cd13be357-939ea0e6e28mr448595185a.6.1789122600092; 
 Fri, 11 Sep 2026 03:30:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:38 +0200
Subject: [PATCH v4 5/7] drm/msm: Properly handle msm_ioremap() without name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-5-87bdb9f1987f@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pt+Rkw+jgQanPwhA/NuvAa5qnlnZ01yZY+rh1utI0Qg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gU0RExYusnudZ0OMSrcweBZUWjDZMb+M8pu
 xhoxU79/VWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYFAAKCRDBN2bmhouD
 13VaEACFaCKDETdpPto0n8tND9AnmPJrBouZ3DiV5VMplFHEEzVYq79foQF2rjqKv263AU9zq+3
 JIWOx+5BF73BcsRrq5QIvQ7blWqANQTHgHriYqXprcy5baVa0he5oIynANoIZGXzLWLj54C08yK
 DpFvI7aOZpAchp0JCUbOtgLMdFHZI2j6EdqSJYa5xOKIvokL26l0WkT/lA8fQ4ZQPCcMUUhzxYT
 iMYAc8UDbse3YaQUCjHZS3SLsQcKQoYSgHE20MN7beFK5f55ru558QjCN/lWb9wluhSw6V7jgyk
 b5h+6TifujFZL3ipkLiEEBDx8Sncin3+oDzNqgKc+5t+WBWSAOIO7+/Y2pwulk3+PDd9y0MSjAW
 QR2gmN27rQ/a62pMIJEDJEH42LjUjGUESrCUWrhKWxhgvmrdZDpttf1Hdf+6PdXyA45f5jiMwJ2
 IC5/13KIi+FWip/HxEMPIurxCj7mKgKAdyqpVmgcuBk1nnvxa3I16OcBy8nMqA2r+LBFet0gfUq
 XPB77l7QlFmKPKqFiAB7H6Ik3As0cPkYgkf0tiRrNG4L6z7zbELYeppwyVslAZTimh1eOGeYF/8
 TbTVKCmSzSeT7WEHoe6FY3Qu+ITbN5AJCECIuR7C50IHN3ul+Sp2Bfg/rfOKUwUg9Kc3RMCiRk1
 Jw/7z7tye3JvP2g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa3d829 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=or9nyMeYumr6D7LEzWYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: eq6LsN_oUKuCWPhdIKzLDYUrauoqbQ67
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXw/Tor52/jQtf
 3HFzXuA7GbCFgtrNt9IOjkEDyagh/m5diFyXQ+YO+FVr1khKUUr8uLm0bjwhTgQQCB6HB+vrHFD
 LDt/lUtJvCwiiuUOdUxOlJCHeJNom8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX4OsBPGuVvRiz
 56iJT3qvuYg0PY8JkLxBJKQIbhKvFMm6RNul1S+qPuiHVo4HQ9H3IlLri0jJfMGpKyJcwVdrApM
 YtWvlw8FS+XgxM6c4rmXNwZE5XZo3OnAkKuA+O46SWsioqBKE+S67wPZxMt4tRKlot7r100OY0r
 6q4wsaDRtlWcPKYpn0jMlMLDsPUgn7jhXdAbubgSe6xgtP/LVqzPe/sQIPYugnmP8Y72Z2Vw2/R
 A88EcRMZ/WqzyXun7eFEExwXZfdph7j0DTZxLB2S4oNUUP80JOWE0ikAhPnfVUGLIakxKAt1VXe
 C1/4YneJNLhVzvqzmlpWCBRYHmdYAJaVdhsLD9Gq86sjT0NCId61FRx/8N88Sc0sjS2aXlJVst+
 SNGUxPHfgeSoub8BPWke1u2+Ex1HTtFPwXKzRs8MYWecTSyZO013Lv3Djze8nmtojZiCKcYHIba
 4pAU8sO8ibTfeLjZh1g==
X-Proofpoint-ORIG-GUID: eq6LsN_oUKuCWPhdIKzLDYUrauoqbQ67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
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

msm_ioremap() accepts being called without name of the region to map and
in such case maps by index 0.  However error paths still use the name in
error message.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index a6efe1eac271..99221b0d7e3f 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 
 	if (!res) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
+				      (name ?: "#0"));
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

