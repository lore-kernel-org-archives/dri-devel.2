Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB45606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iioMTg4o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b4zE3YUL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D528112A04;
	Fri, 23 Oct 2026 08:13:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E933B112A12
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:47 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FOku1552878
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=; b=iioMTg4o88vJrWcv
 qokRQnEyIhyuU44Boa7MPEdCF3bSrIJ6ki/z3lSpw33Tx/hPvDe1xupsKvo6fDuL
 A3M4Zlb0NusESGvdEFRg6gS+PeaF1iVcRVQmV+P5aovWt2GLa8oVBAUu+3Tia+xR
 fz1XiUpXeiWQGFsfFcpZMI0hhZ01C4m2v6gNuQu1RZatkkH3sXd2F8hn0JEZUoZt
 K4JUTSx1Ig4MOgpm6JXu/4+M1bIOfs0B5O8AILTdz5+8sDSCIpl72Og3jXo6zzH8
 el7ZEsBJrAwHMxfmrrHhULrC3lxDdtZ2WopG2ivo+vTOSTovZr7IOKmq74Vu6muF
 9YjbQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttndy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so8713216d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743226; x=1793348026;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=;
 b=b4zE3YULOnofLJkvTh4dP0FARjNot0IIedXk28IiK4cigF9Dhf/Sui25b6uc6c86gF
 NHvx+7Cqt2n3ezKsx/Y7avA7MPwZtTI/ljYMFAwl9zkMIPx2bcpnWPS+0WFZ+1Nt1rb/
 lTqDLhiLLMPkqmRa8aKGgmzu1x1NVl2ZW5//gD6KaneWrnrX39m96VzJ1YRTtaXdAQx/
 0Cq8VOC+HFhdJCnasVxLXVv51uXHjrNtDOGb5UViewH4dLOAJ/Ms/OsxJRn0PJg4aGcG
 GUm/xTMQ+DYGkdVLMCe+iX7fIaVa8BdluRcVv4PljyE/hkxz+8MjJRG5kT4B2ue1j56h
 OTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743226; x=1793348026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FpN/KgqdSMvY2ICnYT0rgl6h6TLIkL58FaqsS5Ocbow=;
 b=muv8gkSBVPLO4KD/38MsDUAT/9J1bYLZ0zIYF1b807pee1u6JQAQd773SLOopnP1/K
 bKBHPuyZMTgivQqmFP3aztI5qgHwsiZRbJ2Q0Ts88jhGfzCkq6ClE+WwKWSEQmp0VJi7
 jZUE0br7dg3TzODFK9DhrXHiMXM2RXKe0tIia9JRlD5X5qlWbQECXcaX1NSnoBh1Vbc7
 AvDQMNs0hhVjwXJq5Fmu3V1zluY66Xlx+Qjv8/bFUBbWdfh5o1FrI4cjzizclUYkNG4k
 YxRBdvxmxhwX36iyZAuiEYCRZuIcP62eri0Ts2d1B47VAl0zoAlZiGJPmQ/JbIv7QBEC
 TRdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByx7/b4yo7mP6NLh84RHiTu6CsIzZNHTgO+mcrZvSnbrhOI/itO9zV+JIxLPnxJv6HhysmCZ4lJb5c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK1u0xDYCtRXJEqTCdHnGVVFQbBGAIfgH5tnvIs0oAFr/fbVdyZ
 HOB+8FRfwPm0SmIHs+L35y5KI5syxB+yAMInouZhTNSFv+bgDDpSFHUBL0u9lgnLXpgzOadobjP
 QfHHWSQSQQgdEoBvwOv6GMx1ylHuJv2FBkWbGlj1AeBkHi29jgI9Ii/1gpWI1JPc4IpBcwWc=
X-Gm-Gg: AYBFou0m/SndlV72fdOqRq30qS5qhryXY4s9VLBfMa05MRRjnzG1iQJ/6iAgJOOmsNW
 uZNHAKNix+4I0p0Esn00V4W5MGhQ5iVMi8h/M5v3xdk9e0bI/u6AIbS1IENNbxUryZdQGNZ5dYZ
 4zfJjwRqR6LFxwXFJ1KA44udxEqRoEDew09EFoFB0HeTNZbjkOICi5yAu3yEG3ckpOrAYDxBiIs
 ySBm2puUC9548TZA0mxBrgWRceEBchPC/Kc65dseyzxq1aYCkVtshEi35/Jik7PhO2ABf3MtwMX
 43RzsXuAkRtVywWTFqaiBRXgLScb5T0QB4ZkEtVEugEoYS3m5ntSY+x2WD2OdLWX+7c9FZqRtaP
 OdRDXgXs8m8FfIVZLRjVrOGAH3KcfvcmNtx6ZUl2Db/LOOJQHCgdGmCVKuJr44w==
X-Received: by 2002:a05:620a:2b81:b0:93c:6fd4:467a with SMTP id
 af79cd13be357-93f6f79e874mr277238485a.2.1792743226156; 
 Fri, 23 Oct 2026 01:13:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2b81:b0:93c:6fd4:467a with SMTP id
 af79cd13be357-93f6f79e874mr277235085a.2.1792743225628; 
 Fri, 23 Oct 2026 01:13:45 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c396af493sm14345626d6.9.2026.10.23.01.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:13:45 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:13:12 +0800
Subject: [PATCH v4 2/3] drm/msm/dpu: Attach CORE and INT2 power domains on
 Kaanapali
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm_gdsc2-v4-2-40b6a71d4e3f@oss.qualcomm.com>
References: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
In-Reply-To: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743200; l=2645;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6TSsqvMj9lDcUSrMsfgqAH+EDW5aP3WVFlch5mtFZ+A=;
 b=YxqUVnVMz0zHTCQ4ym+KlaNtNhpZ0/b3mrjirt1Shk0s/UWoPnLbG91jqQKbAk50s7p8IBIwq
 92yj4vz7rhsAN8tMn/GOkmbj/StNIrEJA8iYLXZlWH/cF0gO2gHnkIB
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb173b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hNyr2f_ZztDnRCZExOcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: XatcK_FaUKCQdp-Zsc8NgC_ueqjsWl3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwe1dDvIbKcVN
 XSylV0mT0h2H8jlEiruLQuZ3k6byk7HaWujKoj/mH6Kx5WZ1wMyLViV7UvMvQaQqOp4XtI9642S
 nPvN/lgRiQ9cFbNYm3AnSpKub6uy9Ckc45oRT2DHobDPQ8oYgC88w5l60WEEId9I6KEJiTBvak/
 jxQI6GVoS6I0gea4VhXQPzAoMSBF0cTQGGrOEAVEJl+SXfB2ea5dVRl2HM++7vGlxluNt8BRfke
 dqhVW4GXbU7gbN6woZlL3eRL9dMfNDaWuEbZ4qfb38mGUVk3EomQhDJ4ha03egE2mTWmX8fZwa6
 0dU7mKPCZxamrPoaQVevB7LQ2jOwfBab4EzFYIObhBaS1ztSj/HeyhJNWeWStLS+U6dW3DsrAE9
 OF75+04fw5HLAGAjMMTgQ+fWGhj1P7lIVYBmZlFygIB5DEP5qQ8Bi6Yuxi850xuM6C1FxFkGvaG
 jinRBaoDXsL+rCfVOqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4E/Gyny0dIJy
 spMXYqsVD9eFw1Mhx1i0b2Gb7NBKj/ONyfsmXeVs48DmskY90mGVOHvIlwhZP/aCkBuJmNMicfC
 fYg5IWYMiqhEUghG2QmQe/mh3a6rfPM=
X-Proofpoint-ORIG-GUID: XatcK_FaUKCQdp-Zsc8NgC_ueqjsWl3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032
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

