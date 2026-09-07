Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFB8C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755C210E7E4;
	Mon,  7 Sep 2026 13:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MtLu5hYd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i7HisDJX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947BD10E7E8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687An36U3230482
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=; b=MtLu5hYdHHBHD+Yc
 /wh4ApHi4GUAzU93qQZULgTnpk9hXgd1DZyqn0mqhJm+sQYmZKdSCAfJQklQBDKs
 Myuh+dH5Oz9LEipTM6rBykD+UsQtibUrvuPcdyguabknHBGifHG1ysEr/nezcvdT
 CgZ5lCIS4fPyi+g/fklNX8eOfLdl5DufSLk64ps4SG8hdg5MPbwM6VVZYsa56IXs
 KrhdGzaXMjJi1I3GV4vKhiJjWVUgGz07rKXdRbH9ttIPSfUNO7FPrK2OQOCXTGWv
 J2UVljv91S5iybpSz0IegQdwPEqqqrupQc6I4XPIg/L3GdeVfLi0PHehi2agOiDa
 dlJCFQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxktssn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:34 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e99aaaa6fso174802241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786034; x=1789390834;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=;
 b=i7HisDJXnzhGuPrJbdBtJDq6nWAbahgMbWb31Jz44pr6qoKlJdLRcR5AItkkDjSFyM
 xdbnEnt/v5FQsC7RNIucqxdwO0FUcaQExYM6IaaDqo30tUoKDMFR4YeZGDTnZgEzk0QB
 Rj4OHy1MO9cWQWWyrG0opMFq0Equzb+FP5QZRQIXYWB6FbkZSwjtN6B1WG7qJqVZoeRE
 6HBJWiZ1w0r/yvxOcE8NF5/znCugsc1Gi7CeRdgBP3Yd5Uh2xiZ2Zg4VtvfTiBofVkCZ
 F+QgE82o2LYpdMaH0Ws96aqb/Nm+09t1/QqYqIPOQCkppTOR3+1DfSBUuY09WP/RxOB0
 ar1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786034; x=1789390834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=;
 b=JQ4gMvdQjUTjARpH7FdugG8zEgFDrU9tJRaW2iPxpMKhZgbX8W5DdE3sZ6JonvEx1V
 FvG7IheWME4DJVljWT7AHV9IhPlCzIB6HMCDEyuUn1fDziwCOj0qtgDmyKRC3QkNWVX/
 XURvtzf+GWI7dOcvg460pyt9XovaIE/tCDvCLKmiybNSaBeX2fDCRfAQQ5qYBl0bZFKD
 3TgPOvjI7LCdQHaIOrnzns6OGuKY+S3Q1mSNFZl82C3FZ5TGPWCAPhKTKBOnZ9JzOSKV
 FfRwN5J2HJncFTHZVImKAFbxTC1syxxkRv7n1BmYY2ATEN4e9OnxqAxy5PCVdBTrEzIK
 CSPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRfbglQnugX3S13PyevL75NovEMH1ETl7v+E+0oYS3tp2zFv4Jp0m4vCT1Eialv2z7C7wPYXQug1M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nx3kR/p64VXqAFyYQ6EYqjVwJ+YsxM/4/PP75ulCo6Wuvorq4/
 dsrGHJ2RgkfXIBRzvYbMaJ+LwIvXF1vKG4V9Yk6uzdnaS+iVewrQa/bV69iqm5DelyuiVAyL1aN
 yiJ//3KTn5hRCEFA7ISEQcCM8Kadfq3eDGgzfjcuo15pAcCrd3Ex8biYn4La4WqSxhm0SkyY=
X-Gm-Gg: AYBFou13YkT+uoi2JRGDgbxcNTHyxxlUBSyKHykpeC8KjUovuJHrvyoC30PW404rq3U
 JA06vBbOdDBNj79nprDZZzHL9uwO71z0W23Y2SCwu058l8Zme2BPUrKlqm7SiAsCP/J0mu/z2ix
 XeW3HHQIitqalMyaQXaQFqb1Y1+nMTKRydRQWuFyMPOUoQ2GT/l6v1tAPWCQxWjfyzVbnTRt7fE
 iIAFcTFcdMLsBrQqt5y74Pkh5yMiAeErWHbEi9g0yob9qfYpRfW6ADo5rCq3tlGPBD4MpMYB5dE
 TzvHwLPW0gigVtZh3A94VfBcGDZslTw3gFG2eQNrIudwOzu6BWJIikOr0NzjuVb0hLojcwGiXc2
 g8LLLWTSlJKMJRrE7clCH3uU=
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr6602134137.0.1788786033598; 
 Mon, 07 Sep 2026 06:00:33 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr6602074137.0.1788786032993; 
 Mon, 07 Sep 2026 06:00:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:15 +0200
Subject: [PATCH v2 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-1-b097cf1eac77@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yyFXmjX5xn4LHf0Cfw4ccz4CCqq/j5rE2bpo1iUGClo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVklronCnP9I21nHkLe4UhlAuAhPrNlcB+Ld
 wfUHRDx96iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZAAKCRDBN2bmhouD
 1z8CEACWoKnaQY4soxW93YzD/YdKVaoCi4vf+eBJPUfeyh7K82OTTkysJ8cMtu/TQ+2HDBY/LNa
 DS1U3plaMTfKY1pTYWAEoE/3RS2mdncjoMDqXX6Qrcwwhv1KP6uOdn2ZO3qtrs8GxFiku4Lj4u5
 i3HY61pkGWkQLEQBhSGGcZbEALxnfchvx962Zz506VqDHTo7OxzS/DrG5icMcKFYgkPPLpUVbs9
 thZ8aRUKGXq+Kb0ER8sGiORDA6dcw3XL7MGcGwUDBDst/UNx1AEzeKfDaWTi6Vq02jFMSC2b9cz
 QD+Q81zprx3jlALkNZ60CGDWViwpZanrdZx8H2dUOUL6h2ymrSF9QFCoG7ycbro+ux+JE/Nn08Z
 tcbIofFFJauZcRazikXJBWdTfn6UOoFO4NMp3Swd+uQxscSvbfG45+WzCUSrAA2CyNNOJn/fXeF
 H44NRdjsqMnqUaPvX9tcmkO1A163kbbMK1yNfhp5NRk86ab1IXvH44dvGTMXbki4EAM8kzH2rpO
 tRjzW2p3M1TXIo3eUmjgY2BuYT0lRkUr/8j47MN7N0t8HBxXTPpX/YSxdYti8VUpBGLPw/gieOh
 D4VEdeMwkl5PCk2aJuo0baVABpwFFdemjhOtpVMJc5yoohP5nmP8rNIZxJoN7nXVTN0+WQcIBfe
 XpFkgulvgPJrpHQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX1khBTY23fhH6
 jfRdLj7BLXQv8IxLehURqE7eJAQfE+foMmuEWlZiGNziFoaDmR1LMdALzKdWaRx/u9h8svBWmXI
 KyYx7nQE8qeln+6h7QzjhLL/VevxGDnqQd2CNbVtXhZ+j+xhc/QNz/ri8cCNfC6im9ffqgRDRGq
 0ZlvVIxZZW/w6R2pk1YwjA577WH+Ed7Fns5wv6MGlCv27VqZ406FnZMnRl6vu8L5EoDwuKwmo+/
 rodk495Hs5jbuLQv0aRoXgsJ/f2bC/OHjI77UY2XbpgneMf9QP+C6h5JO5/vT7j26Qd8ydXA85T
 DVE4IRjvRDc4KfSNBN/TLVNLr91Yjes2fX/gMmMRK5BMspPAXpfbmVAqrKI4K48CztZHls88ApC
 odn0qyj61/MlfRDdLcO35o5ZDIG8bEivwTJkYzt2nyjyCBHsI3UPAm2UprE/X57vLLeCZiVSjWW
 qoh+CGuBDh7sMvksFrw==
X-Proofpoint-GUID: tFHwUgKRstBGi-YqDDiAcW6nittivYBv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX9aqLvU1EXNMr
 rysatgdQRqNSndrCxfYzNx5Y6DnE1AZORuoUODNbydES3MvdyDArdaMjrn2wskfpewGaywEH5Br
 6m4Cgc5I7CHw+c8Pf3doevnxGmu0uFY=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9eb572 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fGoX3SELrpdlimCKowgA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: tFHwUgKRstBGi-YqDDiAcW6nittivYBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
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

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..fd675f537f2b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,26 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

