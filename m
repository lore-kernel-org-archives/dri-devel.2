Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C80CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E51210FABD;
	Wed, 14 Oct 2026 04:38:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04F910FAB8
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E4awLo442761
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=; b=hJJZ/i53cIo5+/22
 BeWvvPuIpu8u4RwyXQofeDB0F87/Rx2gzuIJagCy2D2aaVenUmW9UrBfGvsitGt/
 +JeE6hSuLH3zAI8l3oP0z0wv8bnxNfvfnwUKVfAAwBHplIdjlYyc/E4lfcD1I5CW
 s6PUwGEEB2tUCWpXRi9suuS6NeICUMIGqCVSzlfrIpHP/x6PpeipfIlBpCA+TIZJ
 qnHTrC7yW9ede6IvH3mnoq8vWLDsVAok+rUgW+k4JfmxcermRZHt47URcglylPVm
 NA4TP9VSqQFWaHiWYiYM5RQnC9wcduUd+vMdr4OwRWVqnSr8ui4IYpZXICKBQCOx
 C6Dr0g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71kjp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53390e79a19so62714701cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952726; x=1792557526;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=;
 b=XqFjj3Cegs64MnYpRHrC1k0Vg5Tfpk4A5WAUECHKWdbkMj5fxv7ejRMa+mSehA+Rje
 ot3A7Iw7UNBSlUYMOrZ8KfZ7/aYC8NxpuzzaRqVLxoK/ukzP0s6Jp/IU5BQN3z7diq4T
 3qfhxcIfrtVoAO5FVyxDnr+ZVJi2IpjZeN6w9acSWID1X9QLkhb+Dxms6fpP0OblGJbY
 AUfCUVCOlP0ozmcKmCyJUDTSEbMmOlns7qGXXNqflihgJ1A+HziDtuiYINRcUuV6H7z8
 oOhO/hgxjYF8Y/RP4cnPR7mnVvt4NBldt6A58jVwnOEW3F52oLMBJCNNzRJjUOGuOcLy
 q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952726; x=1792557526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=;
 b=hVMYnd3NzalUA+geuj7cJUECUBQ7yO/uivYnaVr7eLPyXFm5HFvg0WG6CfQbBllvt8
 AndxSo9DTt/wJjoU0qaoFCD3Nf0PyK8hmmLaJY4JJS8zVWLnh0kMTjYsCukcGEXSFsRn
 LfjTnlqLdfFNV9RfpvJlPlrZodq9KMsfdKTTPNpMNiMCE/N+TGW5Iy+BA5Own7ZGEBD9
 S8cbY0xsTJF5ElRZqSM0KITcv3GL8kxQWtKslrOpL72nvA+q+m3al4QKmojVTmxqLYry
 GjJzCwNmA1xl4xUKSc8HHkMXhwDLVSuKPFpReZrAOQobBbnES2qqfb+5COfmqvBjzgpx
 WZpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlTb5Q9JtDmAmbMzZkx+qZSNPVZ6dc7ebVxCP84oar4M44Sv77sOTqtmWEEgDliOFa7OMFka8fEIs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqqbkKy33JRqvslINcGdJtkE4K7wZXsDKpkvyKpPd3VOhNyNMA
 5DjbltxG3hEoSvHOJaiOI/DTFicwNzM9dkcpT1JFYRTOgW9nXY9EEnrAazQR2pZmJn7JQQThX+3
 yYQcfw8OqJBXOudig1zRZucTflxRVXkC6mmrrQVRcEk0HuOWjTlUNNSjj0W7UY8fzBf4YoVY=
X-Gm-Gg: AYBFou2bKj+MzefRB9KkjQ1uTFGDvEPv2MCEQ7JUdW81pNkXosn2uCQaeoNj3d6t7gE
 6kdHs9TfBuQ/0EAD9mcoSDZVsc4VEd/9Ykdsm5GVHDGOS4LPv61WkPj64Xh+EuuPYrtPYfsMitO
 LFbh00RjU/JfcAmwCeg0EsG3FUPK8AeF3vnp0/My605TiMN83IgIX73KC/IU8MhpT+ww0OmUxcM
 dKphhfaq0HwpZxLecGsnpxe96Aov2zsRqQe9g+yut1s3j/2EJ8aW6GO8U0rOPrm8zYUlbyD0XXI
 ++XBbAEHS2JqfOuTg6LDWtMm2o2Ts+IFHEZjYhLXsNwR1rp7KK4eWD+k7HACYzSmgEFaXS5mKm0
 OtTYAwpJLgk8OQDFJ/sFbOzVFyeSpwuXYQdhee8nkKYIVa0LQVIvKkyN8mNzUxQ==
X-Received: by 2002:ac8:6909:0:b0:533:9826:a9ac with SMTP id
 d75a77b69052e-5359faaf08amr233599001cf.20.1791952725604; 
 Tue, 13 Oct 2026 21:38:45 -0700 (PDT)
X-Received: by 2002:ac8:6909:0:b0:533:9826:a9ac with SMTP id
 d75a77b69052e-5359faaf08amr233598891cf.20.1791952725198; 
 Tue, 13 Oct 2026 21:38:45 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b755c35sm116809651cf.15.2026.10.13.21.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 21:38:44 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:38:17 +0800
Subject: [PATCH v3 2/3] drm/msm/dpu: Attach CORE and INT2 power domains on
 Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-msm_gdsc2-v3-2-f1ed69014416@oss.qualcomm.com>
References: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
In-Reply-To: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
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
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791952700; l=2645;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6TSsqvMj9lDcUSrMsfgqAH+EDW5aP3WVFlch5mtFZ+A=;
 b=bM4X17ClG4AjBu26M2WaD2Ua4l2Ls36bd3kp2AEcnK/AcrUpMlMJ+kVuWGxgGbVkAJynm69vL
 VWTnLXCK2rkAmFycMAPQMqWoXuixSI19UHQrweVR9lojL6k008/hQp4
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6acf0756 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hNyr2f_ZztDnRCZExOcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: IZNYOw0zzpLKr3r8IoWuCjsbWntzQarn
X-Proofpoint-ORIG-GUID: IZNYOw0zzpLKr3r8IoWuCjsbWntzQarn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX/YgfR2vOC64O
 YFBgcn4McIw9lFMtnBjgVFQo0LmAKAlCl03ijrGEzjK15nna3xY+KOMz/3r5vHivFGaVj86qT4A
 //5x4PMwApOUFKW6BjA7OP8MPo0lXUlmwEYDCUyMFy7lHlUeDJqpsks0sKjIQlFzkmFVd5axgpW
 IzfagBwLqmrYY/cwUJzhtVKYiXRkGmU0fydmw5GHB+dfs1nA7sv7eRpGwJ4cBcZBbmyj2jobNUI
 Tyu3cYZ47DGrKLuT3uNuNbFmlUd5Mn59TH3VNx2RwBxTqzq4R0Yw+uqnCTG/kyRKBfHw0rhEBdM
 4O4HvSXTdmMM6eoC2hGCIsCaCvqFDAo+5c7ZRM029EQx5ThBlI15QaZK4eA4fF/voMKTGpvRLQL
 HczPoLoDz6Y1puxAcDBjyn1HIZDAjPF4fIkYWLNS7ppf6Ezn9hpc9bklGgEmczndvWPeZ4ckySU
 ZSiEMJSo47qMoLstejQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX7muzRpB56XFx
 J55b6kwOD+MMZVbg2aifhidUqqUBaqxrRrixDqAr2NlJB6VC/fjJo/RW9cAQG59MNrKvrsPzjuE
 +kDkmQPg5jH7meTntg9FrxCGGEGW/58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140018
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
index da3556eb6ecc..502e50ea5aca 100644
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

