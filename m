Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F6BC98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2734810E365;
	Fri, 25 Sep 2026 15:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeVZen3y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqUzrcef";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79CA10E36C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDjDd23627536
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zS7HAWLYB2K
 PmMHyPqOeaG0eVqDjrURQXru3PTmytm4=; b=WeVZen3y/kyqt4GzvLiaHTnoRyf
 0jttmCryP7WG2a5THrEeUc3ec6gLqFVdEKSR+yOohOfKd6lA0X/5X3fhIFI+ImTu
 qmATk3FdhnabrwfDEVerNCuQiyff1wqt7u5FO+rNOcsDR2t/OnVlnaDeVJRnZBmg
 1GSkG/4WrGVLX56iHdFVVRs2j94RpENvp6Xt8GxuktOt3eWPZbOCXKcpHAy1R8m4
 DglMg+jA6+oHofSdidaJFWRPw5sBwVSRSQ+mHSq28uUxI2Dde3SUVcW3gzhDavmP
 fTke5X/1PEu9HjjDJMudD0IiSiQ12cRZzrNZMpNz8lcWsuQQ4YziFxkmOgQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3a3pc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-877ef1457aeso953742b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351885; x=1790956685;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zS7HAWLYB2KPmMHyPqOeaG0eVqDjrURQXru3PTmytm4=;
 b=NqUzrcefFHiGzOnQz1Y8Us3IEvT676L1RfcRfDkNaFgTjDMkjZ42F9dXXYL59vciz5
 svKc6EnjVvubkkrKRLS7kxfWS62u2c956QEOyRAJTi+O4RhbMh+T6qaLLcEb0TRVGI4G
 xXbA94LUsBqsR/VFWWdd56cVKCx1IXeK9sgYqPSKID9y9Q4aiu7SLuxNO2hj+BwDLvGP
 fQ+2VehaFlv2Jf/HPUnRtMl8Iooc9JPM3tAlFdQ0/FZ8+tyz+Td6jQ7YDk2wJB1PNVBP
 P8vZkhEJGNKVj8J1+dt/6teWJAcoMFZlcjHcPL2F4IdLRhgSXEIwbN5Rwp5uRpqYm5GL
 mfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351885; x=1790956685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zS7HAWLYB2KPmMHyPqOeaG0eVqDjrURQXru3PTmytm4=;
 b=dvrfEQE34ThInbCiaHaR/dij0VbJw+96ZLXAwC3t1x41e5fWuptqE60t4s3BCGo6jJ
 DybCS0PcrlqnCnr/czKmYCN/AQdjTJGu5Y7FGtMSqqA6CTMCa+a3JFyQZI2Yoo/AhZ+v
 bgNaUPtyPsdBiTw8k2Fm8P5mMbPo9Yy4/U1Dt+szvdKLd0Zwq16v37qmMD3ZaUXhGyHV
 oVIgYW+Q/STuh6F+yK1Rd3GNWw6FXnggw+cSnk3Jb5yMJ5d1ym69dXfDimPUb1O+JMel
 lv1KKZKUJeKPj8JlWxLbTRJ7C+vFZiQ4dmfaFzoqCSJUcRleRKgYTil25f1r10NpSl7q
 ToLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6unsFoUpDYnVuTkMFqZfzRxqZZ0h1KFskPJLNrZzNLsjp2WdsiMxdj5kUhHzz1tVr/wG97fA0ZnU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8Ewq8yPFyTGQiDyZHHel3jO7zb753ULM40GbhPsy/sx7XL2vj
 vN0dH/ifz+TUe3DAguoGx1qyDcTBERV+IQDFOnxHAxnGp3cpb1gWA/PZaf+PaIMC2ntzf8zPAoV
 hsF/tgN9CjNxnHfKGsUfGmpERZRlrqXPXraQKqpqYoS4fpncMYhNyerKZd8snGx+9eYBNTGA=
X-Gm-Gg: AYBFou1fmeSZYOl2/7MM3X1HT1Oy9yllp7aLjFal8qBkb3MSp0nwIlLOGR/+wiWdca+
 fbMq2/oL/zeDMT1to9uvmZwkdEU8sr1CLP9aOUuBiA4e++C1u/xIKb2zNSUipPVsHcvvQdSKhjC
 wLqcJtUFG+3nhf2n/i+o7uctZGneLHxy5EZhdvIUNbeKR+tTZfpb2SeUJzmbtcWBkZ5d4gq4ph6
 x3TN0LB5IEn6tsIeMh3EZlM2HG/L0J1ygox5mlxMJGrl9VodLuT+OENEOJ7UBqq9Lb8XoEZN/1F
 WF69mvCzMbv42dh9hmZ9X2qMsChOKb1OX+zVYfn31oi1OYWh4uhtNUniwLyHOfrD3FwIPYbhkjx
 y8TrO8M2zAs7nZbryZFnAxwbDeAY=
X-Received: by 2002:a05:6a00:3e27:b0:880:fe7b:bc61 with SMTP id
 d2e1a72fcca58-880fe7c01afmr530736b3a.50.1790351884760; 
 Fri, 25 Sep 2026 08:58:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e27:b0:880:fe7b:bc61 with SMTP id
 d2e1a72fcca58-880fe7c01afmr530719b3a.50.1790351884190; 
 Fri, 25 Sep 2026 08:58:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:58:03 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 1/8] remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load()
 and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:30 +0530
Message-ID: <20260925155737.4161358-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXwU6/CWFed/6V
 weqeWHPbA6y2qZYX92uNRGWfskzwijKwEk46faMOZ600KbBkJWxucxopD3EhKagL2lXU7pTk85C
 aaQz26VouFY1Bvx/hfo7medtzPJKSKs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXxmrnT3738g1B
 CfCanEgaj0F3pPzRnihPr6ZUoXvm6SvplKAhoCweO2LL1O0AvOpmRAGElos3kaIeeYiPSu2mDOd
 feM5mfcDUjct3ynaowdv2k3QkNUQNl0M3sgoSy5OhRvq45yqVn7bvYEV1ohXPZ4jhA4rngq1ec9
 VfiAxJ1VSBIwNRjZlZxaJNxRTXJu6rvFEQYQv7smV8UXXuTbL2pZlFgU+DgbR/cbb1MlQ1G90br
 cG4GiQBaHwLqbEzo+XQibXgFYCuDeYfCw05RjjHHQweHcqyVDlR3f+ADMAYzUxVadZYPMK42RLt
 Tp9E7UCSXgMZQzsDXssnfUIUzHIFjjjlpyisGXgxYyHp6bM4EYT33d+AqtN/7CH43v7bL58l20V
 BEVyatdYXaUAhezmYhKEL23Td85cxLIoqAkydJjLbmIpbWkFTknUZxseMmfLfjjONzpZ+HDGDpM
 wb9/5TMZkljy095ceSg==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab69a0d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=BENypEIf3hN4rM3MEzYA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: jS0QpOaAnXjfqn3tqw8LE0sSLbN4GYSc
X-Proofpoint-ORIG-GUID: jS0QpOaAnXjfqn3tqw8LE0sSLbN4GYSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063
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

wcnss_load() calls qcom_mdt_load() which bundles metadata init, memory
setup, and segment loading into a single API that does not expose a PAS
context, and wcnss_start() calls qcom_pas_auth_and_reset() which skips
the shmbridge prepare step required before TrustZone authentication.

Allocate a qcom_pas_context in wcnss_probe() via
devm_qcom_pas_context_alloc() and store it in struct qcom_wcnss.
Replace qcom_mdt_load() with qcom_mdt_pas_load() in wcnss_load() and
replace qcom_pas_auth_and_reset() with qcom_pas_prepare_and_auth_reset()
in wcnss_start().  The existing devm_ioremap_wc() mapping is retained
for wcnss_da_to_va() address translation.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_wcnss.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index c856a92af43c..01f9076aa0b1 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -96,6 +96,7 @@ struct qcom_wcnss {
 	phys_addr_t mem_reloc;
 	void __iomem *mem_region;
 	size_t mem_size;
+	struct qcom_pas_context *pas_ctx;
 
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_sysmon *sysmon;
@@ -157,9 +158,7 @@ static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 	struct qcom_wcnss *wcnss = rproc->priv;
 	int ret;
 
-	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
-			    (__force void *)wcnss->mem_region, wcnss->mem_phys,
-			    wcnss->mem_size, &wcnss->mem_reloc);
+	ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, &wcnss->mem_reloc);
 	if (ret)
 		return ret;
 
@@ -257,7 +256,7 @@ static int wcnss_start(struct rproc *rproc)
 	wcnss_indicate_nv_download(wcnss);
 	wcnss_configure_iris(wcnss);
 
-	ret = qcom_pas_auth_and_reset(WCNSS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(wcnss->pas_ctx);
 	if (ret) {
 		dev_err(wcnss->dev,
 			"failed to authenticate image and release reset\n");
@@ -600,6 +599,11 @@ static int wcnss_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	wcnss->pas_ctx = devm_qcom_pas_context_alloc(wcnss->dev, WCNSS_PAS_ID,
+						     wcnss->mem_phys, wcnss->mem_size);
+	if (IS_ERR(wcnss->pas_ctx))
+		return PTR_ERR(wcnss->pas_ctx);
+
 	wcnss->pmu_cfg = mmio + data->pmu_offset;
 	wcnss->spare_out = mmio + data->spare_offset;
 
-- 
2.55.0

