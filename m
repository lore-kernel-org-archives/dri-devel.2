Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B260A3830
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIbPYjf5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S4jMOK5a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159F411205F;
	Fri, 13 Nov 2026 08:29:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBE311205F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57BD83283384
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G7cK0ZBgqXGKQz57bcv4YJRSGS3cGEHifmH2X+pL/NY=; b=WIbPYjf5j1Iu33J2
 duxfRNQsNY81YwiWRjtDeg1WmrvcI/8QN9HlBsgx9NZQXSR78tsFuksat1nwK+q6
 8hOzezkg3uX10jOXCI7pUhf6yAxYnQG18XD5yfvcljBMjouqlEcERvWQA+BFvEJn
 eAOrp/xg8E4y+rsLxGieFoMn6P71VPEkgiY7v48hhKiJEEw92nRwCwE2XQ7TgVdl
 yuGWVDBXN15EBOWk3emfax2PgK8BOZPH06LrMbXKDzRe9WVdfEWO37ix1sY0iwfw
 AJY4TjklzwzTVR5fdDPm90Bj8X8g9VKagSp7uE6506L5jZ4x9Hd7Bqf4/mTmqqje
 rGcVOw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37gpsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5364f562140so16593461cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794558559; x=1795163359;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G7cK0ZBgqXGKQz57bcv4YJRSGS3cGEHifmH2X+pL/NY=;
 b=S4jMOK5aDLkypT66QIjvxcRUcW2Fuv6GGHGsSTk/N3X4Ykzr97/STOE/5gAkRCgVPA
 BYpJ55zg4wWMljT6VxO5hBOy64Q/SzoZlJ3hqvjgYKsUsqvNxRajIg/KaQqMkQNVXIjQ
 Q6qnemGV80RA6PKaQW4VRdFmEGslsf6lmlKqTjHQO5JMuQIcRPwrAsRUHcFXIyphINPG
 dymQqIR4iFFE6uT+yg+FAAvpGWN7UraJzSpSpibgsyv18MYa2J+3fmAwKMrSHuXeWiiW
 OJFrkUppQDhgY83UU8gt8eA8cRuz0RJdiWz23oIicJ0UvoxuBxcUpLyah9IAfUYZTzOc
 jnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794558559; x=1795163359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G7cK0ZBgqXGKQz57bcv4YJRSGS3cGEHifmH2X+pL/NY=;
 b=DPTuyBhPDTMy8EY3CHhyt8GhqyqIi+zTICr3gt142ShS+bg6Z41DL3vE8zfK0C9hCp
 7K6Q8Xx59lbjh0L3PAIq9wQR4r2Xv7Jm125rz4d/Ouje5zE0iuQ2tOcTo96sFDkG6Qbj
 UCXIPQuiXH6ZLOpEwKpGXxwKEzLYu4hOYqIZZ0mMPn2EzxNMbt2q9fzsqIRW1EVLFmF2
 uJYJZLwK/ac4xoM5qjAf1X9SIbItJ96qU7IncBBoxQ+2Jnu3vEYNpcmqQ/wU8t6WpZwE
 LFunIihB58GqkRxJ4e7dFqF4WXmuYNj8aLrJk3vdA5s21XdV77myHC4PJIy0MZjVlUW3
 c//w==
X-Forwarded-Encrypted: i=1;
 AL+hErH4BZd41RAPSpEhx26iF0aRoqv331IMHRwvOnHYWMDSG8BRIEmYbkItmm7Y+/xUmOfzGAc5Wi77+7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9nTbwi2UgOCPl8U8Drj+HimXUSgjBFJsh+Mj6xYQVQshCWTZNG
 wQax5V4UAlp8XDhSiyURYSb1b8fH7+xMGHMFJuEXcjn5Nn9oD83R73gFrz8I4GprhwcoexTIfh0
 YuQDtDHXou6obdsj6vxmI4bWTcjED2p/gqgFtA6euqSVI/O5XX56x8BiGclkSpihMHGADEQs=
X-Gm-Gg: AYBFou2DxM9Ybg3YnelDHXmUB38Gc7Yd47UKi+On1cGp2PUHqSJ3XkpSG2HjHkYK4BJ
 A6BFpvi6sRUHPT8IcmL6EaKPUrkwdWMZkhfbLr9IMXYCrGplK8T6lT65IrXCQ5kL1siPCoBGk12
 RPP9BwbVuao8rAQhgQoERRMrSH3UiKiLB1OrryI88LQ+Dpc4ZPE/y17St4CV22y2oXgeB4EoaQt
 5r+9JXxp6RAA+Q8VtukmKl77UC0l60WoMfIRT3OGQQAQg+ZYR25H7Oi5aiv/BVqfgRe4rzEHPqs
 2Kx7HYMA3s5CmlrClzvfAlQevcGARrXRcEzriN1fgwK9th8n4FNEEt2nB7HQeucBf62C3RaJMci
 FFEQv9zbLJ17yqonWSCMduhLA2zLMPeo3r9fiX9FMdu1YRw9omsIfhRA1EtIFHJlxQxv5UfP07/
 o4/8V5vlx1nv0+mmO0j75hT0pP0qSQwsKDRec8
X-Received: by 2002:a05:622a:5ca:b0:536:6013:be95 with SMTP id
 d75a77b69052e-5595644e72amr84314071cf.16.1794558559148; 
 Fri, 13 Nov 2026 00:29:19 -0800 (PST)
X-Received: by 2002:a05:622a:5ca:b0:536:6013:be95 with SMTP id
 d75a77b69052e-5595644e72amr84313661cf.16.1794558558503; 
 Fri, 13 Nov 2026 00:29:18 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad1b13917sm13524491cf.29.2026.11.13.00.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:29:18 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:28:52 +0800
Subject: [PATCH v6 2/3] drm/msm/dpu: Attach CORE and INT2 power domains on
 Kaanapali
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-msm_gdsc2-v6-2-17adbce47220@oss.qualcomm.com>
References: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
In-Reply-To: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794558532; l=2645;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VB9FmrjQ44Q9qoohUmrOvqxRlHApd+R+blJvgNZ34tc=;
 b=46Av5g6VzcUfFjfsoz5zTzkfm4h+tFp2LHO1XA2cbXDpVJFeB5TVUPBKq2eyRMkKMS/ty2StM
 BzXUlmiaElYAVWkfcUNhpvYe8JzFN9lo8wc4zd3xmPKnAWUtRBqbHYL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfXxCshu/KzKkGA
 gSI0EmC45Looc9+vqgKOTEDZDNro9z4se1E8SzIZAZcYAvxXetxRIs/rkiYlAVaDZVYmwRtpw14
 TJmnys0QH1VK3JpOtcT+fjcubot4MuQ=
X-Proofpoint-ORIG-GUID: tGNx22Ur_Khur4d_Ky1ZXjfaPT0yIlCW
X-Proofpoint-GUID: tGNx22Ur_Khur4d_Ky1ZXjfaPT0yIlCW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX3V+t2qNcPGss
 qTFvsgmi5Jg7LHnJGeoMUwDYc61fJfXl3FG2/p39SjRptMcryTDv1haQ1RirZSoxqVZytw/UOtY
 fuQ4gqV99TsYIK72vy3cp5inqCYST4A+nAB6tP99K80FRJGaNuQyja7dG9WKGLtsuDv5s5g+MkV
 w4Hu6451t8baX3h03WpC5D0N1tYHRQBfI78jjbMNudL7vKN2EHbmIvXU8wxWB2DHWlarLp9jzxg
 +oXGuUIVdRRfflIJ1s8ITH/l4m5gKUglIfoJ9QC9XhV+6x9gwwNK+d1XYHzIim8soL+qH3V67W9
 0w93SuPttphs5YowVCbjKtNy9HgX3UPNFiitTrcCuSN5wNin5/hCKBBQwq8odjfVykJVh5QaAuF
 Edm/ZITXVC/kw7dSI2SKXcyaPc/OpsIrhkzzH0Gbq+k3sEgAmk+CvfAa2l9caJ5xTpRR6fSH9jo
 ladPA/SjmXwPAXflvBg==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6ca5f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hNyr2f_ZztDnRCZExOcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130033
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

Kaanapali's DPU is supplied by both CORE and INT2 GDSCs. The
power-domain core only auto-attaches a single domain; with multiple
domains the device is left unattached, so both domains must be attached
explicitly.

The DPU OPP table also needs to continue controlling the MMCX
performance state. Mark CORE as the required OPP domain so its vote is
propagated through the genpd hierarchy to MMCX. INT2 has no OPP of its
own and is attached as a regular runtime-PM supplier.

Platforms with a single power domain remain unaffected and continue to
use the existing automatic attachment.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 1b6286dccfc0..4efcfb559d53 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/dma-buf.h>
 #include <linux/of_irq.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 
 #include <drm/drm_crtc.h>
@@ -1376,6 +1377,33 @@ static int dpu_kms_mmap_dpu(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static int dpu_kms_attach_power_domains(struct device *dev)
+{
+	static const char * const core_names[] = { "core" };
+	static const char * const int2_names[] = { "int2" };
+	const struct dev_pm_domain_attach_data core_pd = {
+		.pd_names = core_names,
+		.num_pd_names = ARRAY_SIZE(core_names),
+		.pd_flags = PD_FLAG_REQUIRED_OPP,
+	};
+	const struct dev_pm_domain_attach_data int2_pd = {
+		.pd_names = int2_names,
+		.num_pd_names = ARRAY_SIZE(int2_names),
+	};
+	struct dev_pm_domain_list *core_list, *int2_list;
+	int ret;
+
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") <= 1)
+		return 0;
+
+	ret = devm_pm_domain_attach_list(dev, &core_pd, &core_list);
+	if (ret < 0)
+		return ret;
+
+	return devm_pm_domain_attach_list(dev, &int2_pd, &int2_list);
+}
+
 static int dpu_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1392,6 +1420,10 @@ static int dpu_dev_probe(struct platform_device *pdev)
 
 	dpu_kms->pdev = pdev;
 
+	ret = dpu_kms_attach_power_domains(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to attach power domains\n");
+
 	ret = devm_pm_opp_set_clkname(dev, "core");
 	if (ret)
 		return ret;

-- 
2.43.0

