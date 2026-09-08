Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C407C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A360C10EA65;
	Tue,  8 Sep 2026 07:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d01t0aLc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZJzy3hl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605BE10EA61
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M1oj2979282
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=; b=d01t0aLckEBoXC7j
 nxjktvZpRydcpmhlamcAjJTIc3W4sje0zKN52B91cYt4i9cBIBwPOuyyPI0GeQe/
 x68hWIoJA8heF0tVkI4RC+D1Vv2KelJ9xixSL1YHMvj0OcW/MfyrpfmOnWEvyJkB
 WGJmu8isy1wRKn6guD51kZDb55xEI/xq6nYMnL+AEznwlZObGBh3mNa07xBWgYkl
 uPCZGtOPrVVvM3xai32j8q6jAgdw3b4q6usiOQjRoB+vQ89Sq8tb+3ZOKJ9nSe8d
 F6RmogpBPWzNNQ7EyH9pAHDi43IwOisAUoDjR++LLIz5NRFMDUXZ2LdCW/SgFoC1
 TcN4tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuykbka2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:10:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494cce712so744034285a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851459; x=1789456259;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
 b=bZJzy3hlIK1B4wDCU/QJFLOwd7Tz/+3PvdB4fKumLDO44CzlWaPpxOCpNUogDSLA0g
 gqsWzkxLqoWixTBfyKhYcT8AcAk53I+IbA5rDt/xCY1LIUmW8a6GaBP0Uaw/TYMfZsw4
 HIUe39sbN2+IlD8oVn7YYj+n4V8enwkvbVroByxD08Gg63KPKPwxYh1iXxm0N1Q7jpJ8
 3V91RMi8ThTei3MCvsREpr9OHZc1w3zJ01N7+SRpuaerwCtt/85RyUqKr1H/kVNuqpzH
 IGjJsb9pHvi64GgRnI3qfkOc29bMqAQvANZu+9tKgMwOLp4/rMMrEDj3h5WiUj/LepGq
 /plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851459; x=1789456259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
 b=c/xbjQ5ksJ+Y8Srab8dIAa10sF/pq+hM1zE2hTAvQA77odko1g6XzDL/I4Zcnfbaf6
 Wp+31ssC4Ts5A+5+faLXlxLaSGPYQFgLmBQ3tmC21P/QZysTKyfyQtmSMQH9W4oi7AmL
 GEqI3DbK+z0+4UAo+HvT8eJB3NMttpaZGmnWDXYOW6bFKdyUt9JZwlD1gyUKnW5KEsfb
 e+pROl47F2q2xv0o+GADww2tI1yYx86JM+nDFPWE7NKvP9tNvFEpy1VcG9bUJqRxPLi8
 pxxuEfNLvtEzMCuW7czl8ITwBdztnJId6yt/rtsnO9dA4jczC0K7KLfZ7nPNIz2iWGJt
 5mrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxD/Nhzjw1LlBbd7P72Sxux7BjSgmQxQRlwXrboyUwt6tnzoM+qzm4zWZB4YLeHoX4KVXSGcBwug0c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRzN/5LFxbwz0toZhpbha/nvEdI/zBccSBDGvBvqp9x5rzqSeV
 YzjjSKGOdxjlyBZgpPncWhbM9TOAAlIp1xqWdnWKSw+QOSelPsI/MF1LICRNNnDGMKlCZvkeMHr
 OO61kOBGSdZznXONbK8xXp1LX1tLro+aX5WXzgGEL7NNlPoWn8dk6vuMPsZ/p1VxGrfKhjD8=
X-Gm-Gg: AYBFou0QYG/t3q7bRUhoVRm4r/cvl5FlEAsYRLdv1A7NZImMWoqVY/jqjFMsG836rsa
 Mxs8EjGXe+QvBLL9fogjLicz0pKPUQ7ntUL72B6lStTabHoHVFtfCOLSXmc0cAQgp/SFdiRdkGZ
 Xqa6IiDAlM+YQPSpamCyYHz2Twkt5Jztnqdn8uk4jWM7n336XfeZ32GJMKobV4ktEIcjuKD9aZ6
 437gLYsCjZyg6pNS9cqLFeQAc6DAeK1d6tJw9YYwjLuPTUETfb8Fzkjy+2nSqvOkveJEuAUZU72
 mZkpbI4uV2P8RytykikifgUEjkeKMnrrOQI37pboynWtZTYQOcAYIcCu0nKKup20HxDfEgaYnAM
 KRxckBuuhHV444/Jjs4qt0tc=
X-Received: by 2002:a05:620a:3707:b0:939:ab90:8f6a with SMTP id
 af79cd13be357-939ab908fd9mr1195393285a.18.1788851458769; 
 Tue, 08 Sep 2026 00:10:58 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:939:ab90:8f6a with SMTP id
 af79cd13be357-939ab908fd9mr1195388985a.18.1788851458361; 
 Tue, 08 Sep 2026 00:10:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:10:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:41 +0200
Subject: [PATCH v3 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T3vtS3HqWXUdSsiVISeU47Im6ROW1p5A6Fk
 05xiUy9rpSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+09wAKCRDBN2bmhouD
 114AEACRO7SvCxub/ywNPr/vKZhyFhbU2JGDgp/FmhNnXiUs5W0/MpyTWB4t9M0ZLv1B1KKWqxU
 6cIujtV0TMmQv0UOUoNqd48IREUrMtK8loR+ocxNUeetJ4OrYGG1APFlVT3Y5fyfZtAT13tHDDY
 GS7PLrdz9xI8IjU0ctGea9dQg4KXS0A3gJq+bNlan7j/O0NR5nIonwMLM6TIU4joM10NR7flK/t
 owfigDxvRpBr1EwTuDHi3tcLjJAxKWhnyVE0U+NOvKVEF5us5Z/v2EPv76A1suO1QDV4IZYvaks
 E/zgnXRFI4bNDnNXpDsglIQBNACSK1OtWVP30eGoSi9v2ZkGwc2LoU0GtYRG7xa+NDVs1iIZ0AH
 aWqjDV1EoJfgcYsxZNZrQ6cw5uHFbiz8LFNXRsm1CyI+HCGThYI9b+x5pqJiKCtYhtkTolcRqFg
 S6TplqNWUYXsKOlhRlBqzLKPzPcqtgO4a9U4XP/bVD7X/whtZCvW6U7RKoXJrANsmRTMPrsVocz
 7/msBWD7N82wzP3dlOYnKFvPOvS0vovO8yYNcjCSyZka1mkX4yP1mIRAFdU0CEtnc1jwbyt0LYs
 5KD1cOlPg+2B5fC7ZuWtUiMbLVXt9BOjMPV30OCg99Qi0BgFI2MYvWDNVrwWZXr+Tir/3RAxN+Y
 LkgdcouDjYxwaTQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfXxicF+o0kf/eA
 As9+uQLqrDyrYQiAebQ+m+evirv+dbt0bXRxiT7QhynAd38MJJnpWKippELqAn0V0LLfhcTiriL
 1J6C4beRg1z6mA0l68kWC6ESpBgmuL4=
X-Proofpoint-GUID: C9pm-S3T_0Dz1-8SVzqmPuRq7PqrJ9V4
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9fb503 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: C9pm-S3T_0Dz1-8SVzqmPuRq7PqrJ9V4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX8iDU0k5gPns1
 VnQGwCcpHKWFvRX8CV4PTykRekdh6HO2J/GljAl0+9XjBg/cSBl+eFv/bxvmuwccJK2P0gc7Gpv
 mIyeQWiyY8soppiwmd5BxgAtIzA6SDL2/S6YIruVNZyZkTU4K8YWZzG4oOZzye1dT8nBwkK3X1z
 AruTyNDJ8GwWZj6ZH/bJXz4DZkOfIUuNk6aOGEAPd8tYydsSj/XJOsChFcXtkiv2COllS8BDa7z
 1JlQYLrsnLQ1a5QNbXEmrRsSIP42Jt5SgMvun0VNCQmGRhEEKH/A8guC4lqbWYDYl0ooJ+zRFzz
 ymJVmgLPk0uMYf4ocX6zthVJ10iVnt1pM59h2BrMl010WILb9eN2mSpfmqkZGbPDijJdHS22uJ6
 Q5IaqQvTmArNX1n0AC0GB+efTwMLVxwENmPMo9HHTL/AbHih8VPdqde2StphxtwSkwJ8tC9iOz5
 VN0uFOBsyxQQkMQhCeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..15e37596bdb1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
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
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

