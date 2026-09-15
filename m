Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D91C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D69910F3AD;
	Tue, 15 Sep 2026 09:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jleppPbP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fynD14zM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EAD10F3AD
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F7WnMA1790828
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /hiyQ4P+7WwRfDmLuLdvleudas7ax3CqEMt1Rx6IvKE=; b=jleppPbPRFIh3Q3q
 57WL5c4/32TNG3MX00IFv9Xfq3E/rP7py7zHTibAbSMjafCGI/KfwTYD6xoYajKH
 +QvgLwAaWtyRs/lY7n/iyMBLuUA8DbUzIhqlU7z3HZXpZle7h8aFCOOKeihU9yPL
 PTwJbS/YURgZ+mJGSOzUMF5GiRcy3+x+HXosr/h54T57WN9+zGVnly0zGNoCTCOT
 JQSrooTtv173G7nuGq45UPDYcrdbeLbMyqJTa3DhP9xlJunWY3ANyCty3YMf/qBa
 TXpfgJSmm5He5aDC6skcWrwHy9x84py50w61uHBqM2PGCNTNEI814bioV0TuGB1f
 bJmWzQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qp8j33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so793032285a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789464496; x=1790069296;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/hiyQ4P+7WwRfDmLuLdvleudas7ax3CqEMt1Rx6IvKE=;
 b=fynD14zMdKfdZHnLTGi5xMMQgYZ4FCuEMH9PsQETteCF/b+BpTPGXqsk1TzOZ51i8F
 QbvMv21/J77qJG7GHBx5VXXQ++q5nKQJDAaOtuQ8RrJru7niH69AUcAfu9KphIgbaO61
 rWzjt2I9KExJq5Zt/M6Sofzu6GMsKVR9STFpUW6fwqljrhlYQbAb4j2r1P2yVoFZ3Sjt
 Z7CEUY8Q9OqkEZFH9w7o6zyyvrRpjR/fcIGimvrwjNvzOB0iu5h5OYQ6jezOZ2wzVtip
 RtsGyh4iC43Xa3n/pMJmJYs02ZipCfTOt7EDThwEw5KYO6WPr3exj8QHvCZsOYy+FQnq
 GqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464496; x=1790069296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/hiyQ4P+7WwRfDmLuLdvleudas7ax3CqEMt1Rx6IvKE=;
 b=2TupsuqMSKPzsOOcbRdvOTYaj+SmDOYBrL0Sug8Anufc2YDKD/8vVuNpZxk3MLIVM/
 GPjp00Cem8XuGIEnIJWa1Y//PZFS7h30Ea4wLu1IO3Ud1wtSpLnqrGISGi1NGBggdk6u
 QjVyl/IhCB3eAkWoVCKBp9uzpuQQR8C0uQ6FEpHWqXCjPnS8RbTT4uX8uF4TNJcYdkOe
 Eh42860IuMf8uYRuwcXxwGHeCJZiWwnX7x9lTSWrpo+CItoGA2uZ8gpbkCZHd4EiRokL
 mwNe/Y6BMqV0wkzZFktpdPT2zN+H+iq/N0xFqsASKuz4SAu49KSJSYZUkZXJi9vUWSsE
 +zDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0gyunOB3VJYRIDcgXEkfLwFm3H4OYgg255PduU5cO1/aW1JWoyWfpMacf9SDk7qAyhhFbbCvknwU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9xr2FFaVHOHPCEmc35leQbKs89RGpyvXpugOe0OAUmQOfiIuK
 x5YIeZI5sN6SCQoPJxaGY97LoCxICW1EFMBZO/wM4A/1aRnjdbg08FCuoBKbXyk3Ep3ig+ZVu8p
 pGkVQtIb75jYZkZD27oKxAx2as7BHYEEL6OfXCyOUXfeFqMCPMtuVLIXCaIFKzGEXNFchBHY=
X-Gm-Gg: AYBFou3jvXIXVi70tj7e130NS0i3nLxOU/VpFz9dN6xO5fNv/d3YCW58G0XNacfz0rD
 kKYjt1lbxV3wKnrO+bBxIZN0UV5/yP3/Qu2lkW8xLqKtXBb+1uQi/tFtsbYhFk634tKNk3JSLwC
 sV2fiA0fICcnGVkUtdYFW4u/b1/mmWWEqQtTroPKPvvWGVJK5HadmhuKF8ifuZbDqapqYsnwCvl
 F/GNjUbSbnV99agi+72hJuMPh7Rxgkc/MdQaP1UR1yZozy0ZzQRSUYasYgdx3uqHmUuXP+mtM/W
 pTHOYmzlED+xZKdyoalseWAlmdMRuxib9ZLyE1TU0//ulzRSsWePuOgT5bySE6MxD6mhVjwYClk
 m/9HdUDYAUMbY6JsZZxTMOxEBobktKkk6CeXaeQ9x5/ICXUZImuCT/zJo4DBVHHg=
X-Received: by 2002:a05:620a:4384:b0:939:ef88:4af4 with SMTP id
 af79cd13be357-93a296fe008mr946228985a.10.1789464496261; 
 Tue, 15 Sep 2026 02:28:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4384:b0:939:ef88:4af4 with SMTP id
 af79cd13be357-93a296fe008mr946225985a.10.1789464495891; 
 Tue, 15 Sep 2026 02:28:15 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a3f467566sm18939785a.39.2026.09.15.02.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:28:15 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:27:49 +0800
Subject: [PATCH v2 2/3] drm/msm/dpu: Attach INT2 power domain alongside
 MMCX on Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-msm_gdsc2-v2-2-9157237b8382@oss.qualcomm.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
In-Reply-To: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789464471; l=2660;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=a/E+GFuEyBojJjqli8EcWUYHUw5NvaWdxGvcEkYtpmk=;
 b=rIBAVjyUmU4tm2T/6JX609jxHAuF7gTOziWHFTv6j9t57tjNdwhapK77O/RzFfdXcWuzJQJEm
 GM4es91488XBgEQRxbBmzeOdmazqy1hLbSTnRKp2NIkQI1zL52d4uLq
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfXy8JzcYHAZJSq
 9S9C8+BHI0IfeAAJT7y6X3oWzg72W1Pw6U0SNxQduEYBpXNV8IeLnewRPGYx68pNBu4U1qlVR4y
 MgBTyncKKd0bqQWpWHPiReCjUJ+4L6I=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa90fb1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hNyr2f_ZztDnRCZExOcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: EmUkwLCGATYERDXj9THUrvJP4KSv9rup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX/QdzHGdj0M1g
 nBbG/t4M41mEGzDguLyxVPD/WCmrbSXP7XdyUCTkkTEkxU2zd89FPAgc7D7gD6yql4QVC4dCQMy
 SnMRS2yGxGeuEQf/uLVGHEKIxeO/BwIuB4UcyHOzYb2H+mYs/CT04x1YCaNAHjNTDNlBiFk6YpY
 4flQ02Od9zdw23uKk6THcoF/seYIHZ1GhdrL+UPfxhtEv0uXMiRQdKIiqXnMXLdvwBbkSrZhKXz
 AX+K7vypPZ4V0/dkp+55MD6/zJndBjaIG3kFJKzEteKYYjcsysIZGM1yQPP4+YUHNmXglRJ1YLV
 7hOy3a5VAxagi0NpCaRsGiyPtnUaIZqmOJ4k/wo97p2a2p9xxC2Y/3DIr+i3Funb52QA9A8MkG0
 8YNpqPckd4ba+2TzuLX9qvp3a0v/m5+0yYKx+8OK4FqbhbkAsNVGiU+2Y4VxXO7+2s7aSsYKmvi
 +nsCwaeirHzoS791eVQ==
X-Proofpoint-GUID: EmUkwLCGATYERDXj9THUrvJP4KSv9rup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150135
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

Kaanapali's DPU node lists two power domains when its DT provides
both MMCX and INT2 GDSC. The power-domain core only auto-attaches a
single power domain; with two phandles it leaves the device
unattached to either, so attach both explicitly.

MMCX keeps PD_FLAG_REQUIRED_OPP, preserving its existing OPP-based
performance-state voting. INT2 has no OPP of its own and is attached
as a plain runtime-PM supplier, via the device link the attach API
creates automatically, so it needs no manual pm_runtime get/put in
the enable/disable paths.

Platforms with a single power domain are unaffected and continue to
rely on the core's existing single-domain auto-attach.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..d9c2c8d680fd 100644
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
+	static const char * const mmcx_names[] = { "mmcx" };
+	static const char * const int2_names[] = { "int2" };
+	const struct dev_pm_domain_attach_data mmcx_pd = {
+		.pd_names = mmcx_names,
+		.num_pd_names = ARRAY_SIZE(mmcx_names),
+		.pd_flags = PD_FLAG_REQUIRED_OPP,
+	};
+	const struct dev_pm_domain_attach_data int2_pd = {
+		.pd_names = int2_names,
+		.num_pd_names = ARRAY_SIZE(int2_names),
+	};
+	struct dev_pm_domain_list *mmcx_list, *int2_list;
+	int ret;
+
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") <= 1)
+		return 0;
+
+	ret = devm_pm_domain_attach_list(dev, &mmcx_pd, &mmcx_list);
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

