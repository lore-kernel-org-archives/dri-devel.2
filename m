Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A83BEDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E1C10E399;
	Tue,  7 Apr 2026 09:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzmRA1WQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MSb+qC/H";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C316410E397
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376L9iG3537351
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=; b=RzmRA1WQC21TiocN
 GJ0ald+eVXqwFx9+c/RuktHOrXgNsFoXWlk0PQrx8zLVS7uT8Jiy8aatFZujH+M+
 GOrQagM8No/lWDadgrDj+ehFnZTrwqMsrEswI4+Bp+bfxr/K4Hh5PkUqNCdUcKUF
 QVDfi45Z1yktVIUXq2U58UFdsHUiRGNTipu8fPF7ql8ZnwghRblLXC4YhecIWjBb
 GnnYlOde/eW6PgESM+v3CQ9bXEGF/pnzvhZARGERUMxlN89+niNEe3VV0FSJ0PPr
 toBIJaorlDrlughJaGDEJaNTUQozTvUlQJE/5FIXHz9dyhNc0eDlFZ07+KxNefep
 vDs55w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra22mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24308165dso124750695ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554289; x=1776159089;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=;
 b=MSb+qC/HvjSUalTa9hoy4b/OXeknpS94gWZOwXf0DkR1ZYWQYG8Oo/I37A2/X4o2/t
 y2vaUUc+8B8zmqZ363ER++qnlXf4zkGkliw5w+R5R47rG9FFQoOtV79VTjyY2dw+ez1K
 cEWPeLpy9w2UYmN3iSDRngnNCbQ7TobFGNUi0wHTY+cGndIjKZ7kGXmjEElYh6tUhtnq
 PnoGHq5XSQdV5Yqh9WuW9HxI9rfX0Gxt1BOF2VAh990UwwZtloNc7IQeaU7lu+O54nbE
 XRfhYJ31HSEtWj23Jf8m9UMoy9tU0Tl+45jknY6gHpMuJp0ZINvshYCT4q9z8oqFIEVh
 VQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554289; x=1776159089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=;
 b=m6JdxK6yeYLtwgmEs2atRCafGRjVAaJIjoefvkwSCbMESajgwvQ5QLAUSupj4JRqNC
 8xoo3ByQLD7gKlbmAPvIh/Qm6NOT59El87UiSNZP2gDvR8NpYcSnlY9qTO94byudhzzU
 IeWhIdDh1jpRmvyMZYGy2P2RaeFjI9yhHbp7zAfUYyRZslDOgS0rrnQ1YENQ9NQLLWvl
 JU6VpMa6OITERG9deIgTo+h83Uyfuu/a3NilcRsHcgDFWaY3cf9NLzmGDgsqgcMzJFs9
 EQlfTrkMn7lPLz9rNUhxf8+NKDFIooLiyT5DsgiDeg0wcSraBOlXDPGPdhENgtpMpnwX
 Z3uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmLs5HCsonoAmi1/YMqCgwVcEPiq+AYavMFpmJhRUl+FkN130PCOxp4oPYRvMCw6pcq2aILhSh7fc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTEKKmTF+KOQFfqtqr1mXNQ/FNPEObjZEC8Z2q+Mh8YUlvPHF1
 cycXf+NaO1LVDbxlCIVby0oANnXe4T+sqvmgAOCizn258oZkLu2EGUHlSP9SGXy6GNW5XbZJohd
 4vAep50AEFofjMo7vqV8Vze75x/q3UResWUiXDrWNrqOGVKymjKHBiWwBhl0J0zhN5HslAFY=
X-Gm-Gg: AeBDietKXvCSkuTo1Xy8/vJEnsovowE1rnbuq5ktoYqE2KsFoyjRqAzPIz1WEY8ncV0
 xlMefXaENMIpz79fq4uvxQQ+/XkFvPusGDCHF/LFDC0/15qzyI46w6/im6h25mJWEDyR3QpB0d+
 0oX5EyXkF3qRL+HRkLy0rfMfKcLyPo4xUbqm0nfuqLEIgGuAwgeIj4JEyOQcXa9wCSy1oBYtUpR
 X0MxfDnP3OqI2UGxld6c5FTaqZaZR57dxsNFP6969AM/dxiDyEgIQO3mLjpgFH+Tb3UI5xUZxQ6
 XskRro/2cb6UrZnoJi+aIBll3r5/JYbtgf54xUPZuuSKHARiZMH9SUSnFOSww3oHvdQg7f7SFT5
 yXfsT9ep5fDeB9XkenfaGMTj5ZlfTR0zz1vIjp3P3oaitCg==
X-Received: by 2002:a17:903:1b4b:b0:2b2:5c31:24bf with SMTP id
 d9443c01a7336-2b28175bf51mr176450225ad.19.1775554289486; 
 Tue, 07 Apr 2026 02:31:29 -0700 (PDT)
X-Received: by 2002:a17:903:1b4b:b0:2b2:5c31:24bf with SMTP id
 d9443c01a7336-2b28175bf51mr176449715ad.19.1775554288963; 
 Tue, 07 Apr 2026 02:31:28 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:28 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:51 +0530
Subject: [PATCH 1/6] clk: qcom: gdsc: Add custom disable callback for GX GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-gfx-clk-fixes-v1-1-4bb5583a5054@oss.qualcomm.com>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: DlyYgm1CVABCUlSmU1D7fGMZs69mi8Gb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX869XHHLRA7bA
 JP5rKY/NxAI3edu9eSEW5oiyfQiOkth3wDkuONNdkkhfdPV8qQveDWJWdE+Q9G6JnITBMqdEIIj
 PFIgyNKZzkkfH9SlsyxquAHoKZLDGpzJCh6pbd5XsxtbovtmFpiS5MK+VNzFHQj4RHIHuVd5x8P
 xFBGYcdLiKKnghaXbhEOBediQ9/ABjxRBZDoTeGEpPvByVrwSAG79c7kArwBKYTaZAGBVXXZzmV
 PnsJcGMpD4Ltu0mwx7Czr3e1ulBfBTKb+T4Y8QUV9pSBWU4SeXQ8gWol2oUY4wcaBcvJ86lt+mr
 apFCBernWARIUtUH1mRY9Xw+2h1W/e0cgExJUkzoUHpyQw9xwWNjh9I6eW0rzpCd2oGTJSAj8x3
 AKhJmBPyHy0f1HnD9rjndLtu64w9erG5xt3klj+oH9p7L8lCL3pgGx8rO37RnWnTS2LFEAinPS6
 DV7uavy1ASt1Mbm8pNg==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4cef2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6udHJU8j9nUP921WRPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: DlyYgm1CVABCUlSmU1D7fGMZs69mi8Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070087
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

From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>

The GX GDSC is a special power domain that should only be disabled
by OS during GMU recovery. In all other scenarios, the GMU firmware
is responsible for handling its disable sequence, and OS must not
interfere.

During the resume_noirq() phase of system resume, the GenPD framework
enables all power domains and later disables them in the complete()
phase if there are no active votes from OS. This behavior can
incorrectly disable the GX GDSC while the GMU firmware is still using
it.

To prevent this, implement a custom disable callback for GX GDSC that
relies on GenPD’s synced_poweroff flag. The GMU driver sets this flag
only during recovery, allowing OS to explicitly disable GX GDSC in
hardware in that case. In all other situations, the disable callback
will avoid touching GX GDSC hardware.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 95aa071202455421d818171d04f95d15e2b581fa..ab5d741a2e2351bfac06a6814c5a8ba7355bc8bc 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -675,3 +675,25 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
+
+/*
+ * GX GDSC is a special power domain. Normally, its disable sequence
+ * is managed by the GMU firmware, and high level OS must not attempt
+ * to disable it. The only exception is during GMU recovery, where the
+ * GMU driver can set GenPD’s synced_poweroff flag to allow explicitly
+ * disable GX GDSC in hardware.
+ */
+int gdsc_gx_disable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (domain->synced_poweroff)
+		return gdsc_disable(domain);
+
+	/* Remove parent-supply placed in enable */
+	if (sc->rsupply)
+		return regulator_disable(sc->rsupply);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gdsc_gx_disable);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index dd843e86c05b2f30e6d9e978681580016333839d..495daebaf99519ba0571070b41d133ee867c4fd3 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -88,6 +88,7 @@ int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+int gdsc_gx_disable(struct generic_pm_domain *domain);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,

-- 
2.34.1

