Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CCAFF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6639D10E57B;
	Mon, 27 Apr 2026 06:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C32//Zer";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOW3UvoJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BDA10E57B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R3MnmA2526400
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Hc0hzYvnf7Enn+b3y97rEFqe8dZnu/3813t2l1Q7ag=; b=C32//Zermcpsa+jx
 GsUJtf59SDcBxsoUyyTcCKLD79nVwErA3LUsUuqaYb+6zmF2amaSZdba5EtMxMZf
 n6YTA4t3ZP8nazR0BfpuOVoeFo57agowX+gosTdfJxyxfSj4w8jEtUbuBK8dzung
 lf2QsRpVhSxK08dbaSuzo4VIGjgWKJMKQ2lG4ujNmlVUPUlEFoLytIZPrWHGZOR7
 Mei/cvTwNJKzXS8BYGOSl3HHKQMuLYiUVkv/Uu2heDI1PSS/keS1NhShVHN3t6/b
 6RTLHYbIDt1Co63t+nckKycSNSJXVals1qajElQPsjxNaVuTBxovk4pRKAlMCG7u
 bBG3FA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrmptf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fb6cd0879so9075464a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271969; x=1777876769;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Hc0hzYvnf7Enn+b3y97rEFqe8dZnu/3813t2l1Q7ag=;
 b=KOW3UvoJnEAchX3VyXFrSsbAqoDQKNMFjr84FA2Bt/adP/RinqvVaNFoBV0FYvYYXo
 Zliu7ylj62pYOfwNP5uuaB/Kpt1/vOcniBc/6SHjzrAb61zFe+kDVDXLrSNnans9+vlt
 kf5WeLGzwX/EaRMKhrOGIWMNtfA/OPgLBLJvieQzizTDQ09U9JAdbH6YEMAEQsWdIIj4
 62J1ZtkjoNwJcFO2jRJbMdBsZmNrOkSwUaDST2fISiLEDJYlJAVs1x4PB+KlNYpdDn1T
 PGIA3fJLwmdz8VFIv5KgzLUN0SiPuy/DP6XewhyQdv7+Q2jaRtUPfBedWgl5L4fM+0Yh
 lDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271969; x=1777876769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8Hc0hzYvnf7Enn+b3y97rEFqe8dZnu/3813t2l1Q7ag=;
 b=LPv0iKVwkBZLXp4pZ21NVtBzVkV3lRy0VLNzhncUpGDKHgtVOJnnAId3KbV0sFYr/W
 IV98p7YATx8jDRvO7hGbZ1E7P0VX+r99V8ckJv7cBrMKA5wctr65S6XD8x3K41L0zWzU
 NcwN+LFInDbZGP4y8Z9hjJWg2NF00DciEYdYATJXShKA/4s/LAmpd9hmugSkITMSg5Dq
 P3q0OgSO9Cc86Uj/5eOchmKwhUfKkK57TsYCVXcKoy829Sy+xHi/v5BECUOfAVhx8GeZ
 brSII3yNBV9RZwqdFPpEpcY1VDNfNr2CzrLLHaD/bdiu1er+UK2fiNep0DmMiWU5jFKV
 eKAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hOWm5UE6/kpNPNH2gdbaAvUGOVxoxgI/xGHjU0zqYoc2uP/0/vOxLnwq25qks7LL/W2g0CF9S3D4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVrc3nJ884rZkMBBXn1sN9dceL7RvGniLUkv4II96kQw5G3fyL
 tWGTfouia9mW4ZyEyxkNj0pcojIJ9Tgc+0fu89Eu6/my3qG9CwW7V47kQAmMRlvLIAJjAtG7f6Q
 yeNQK9l342Gku5cXg00fiosfIOlAUDop4zynl1U6ELOm+sSN8sCys50Uwfp2kQzHH36Kt/bk=
X-Gm-Gg: AeBDiesXal3vAicMzj6QXJwhz7awAa5p1EPts1ukML7ODR9KstVij7ceY+OR+RWi0Cr
 73jBFFj0TfLjo9CLDnIBYzgYyHRkCyAN08NODErLlSfRB3Y75S3Yc5kibxdUcO1ZQVD9oSiOsYK
 wFIUijUrC7oNe/frHWWyU9Qva/HlamNwe8EY455iLUFcFDVnWiNalOByLwRhp6hz4LY5+Vek2HA
 HU0U4f0fw4AExsy6bqR8pSGS3WiU9BoEmloyvYoo/YKz3Kn1wUaLcuXOs4Dl2LEhIzx7COJ9kZg
 5o3o2f0OQ2ZSc7ZkbauqeII46Spv2z7DxlrIthozSttTkrHtHg4Kk0k1mCm4c/kus3H9L5KSh5a
 UHFp4ssp1Vy1BqcZuE39rYY29TFtB/EzQ2OVtZHL1AHtnGD42vpCPJcuJ
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-36140402361mr42035902a91.10.1777271968389; 
 Sun, 26 Apr 2026 23:39:28 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-36140402361mr42035867a91.10.1777271967886; 
 Sun, 26 Apr 2026 23:39:27 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:27 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:08:57 +0530
Subject: [PATCH v2 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-gfx-clk-fixes-v2-3-797e54b3d464@oss.qualcomm.com>
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfXyoT2GpuSlipq
 gJeOmOXFz0FdESlPWAczdOMRMMZ4NiC8sYSxKg8v/z0jc3FuT9whp46a4bq3kI2o2cKAHZh7i5s
 P6wFU0rhAN3DJG8kVfBouLcFtvvPy0lbrz5IIzK8p/aghRy6kjeRm6QAlkve1+XGpdlralp2ZRe
 vsYr2TefT3oHVnXG4OKqvOvTbU3LzksiQc4gZAPRF+Arn8s7jt77rFdS1pbRojwa03pp0hgp3Tm
 9eHp69kWZPxMMLqZHLft/Q31uXucCU2WsZo/Oheee3vL9jftgwa+fDTs5+j5WN9vTLXtw+D7814
 9bpf4NXrZ8VT95574c4VnRyBx8AlBFpfK43LVbi28rdSU0ayKrWwMSdDd0WBR98h2jd6ZZLOVZr
 4QhAFD2EofMKUDVS0LbVbAHQBpXVo5OlGwSs3iMfMwXpS3hMGaxOnenbb2jBaAIL3ApA85n79G/
 Ye5CADEI/iVEzj/5qiQ==
X-Proofpoint-ORIG-GUID: namegrHtgcqXNFo0Okn0jWLLkzb8b7vD
X-Proofpoint-GUID: namegrHtgcqXNFo0Okn0jWLLkzb8b7vD
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ef04a2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=b5psBqh-k-Y8K5vD8YMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
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

When the clock controller is probed with 'use_rpm' enabled, the
runtime PM reference is currently released using pm_runtime_put(),
which may return before the runtime suspend has completed. When the
clock controller device is registered through this function, calling
pm_runtime_disable() immediately after pm_runtime_put() prevents
the runtime suspend from completing, leaving the clock controller
active and the HW rails in the ON state.

Use pm_runtime_put_sync() instead to ensure the runtime PM “putV
completes synchronously during probe. This does not have any functional
impact, but it guarantees that the device is fully runtime-suspended
before returning.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index eec369d2173b5ce24bc1ca860d2ac1bbdce04524..2c09abaf1d2a15b7fbbbfeb67c03075381185a00 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -428,7 +428,7 @@ int qcom_cc_really_probe(struct device *dev,
 
 put_rpm:
 	if (desc->use_rpm)
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 
 	return ret;
 }

-- 
2.34.1

