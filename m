Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DA8CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 17:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F66F10E7A3;
	Mon,  4 May 2026 17:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfVQdB2S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/k65i2M";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AA010E7A3
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 17:17:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B4I9w749360
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 17:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yBTfPe5yUoE
 GsgDSiMIe7M0rHkLENgYzLNl7AyqRuE8=; b=gfVQdB2S0kXcvC7hXFi28+Zbmmf
 JrSyxSNRjdOEwOR+ORye/m0A3fQjUmwBz7AHXsEIe/y2B2kFpJtgKOMvXcQH/p9P
 sl6GLVv/uOKnfD33wFQTV/V3BTPOvccMc8fX1VX84WaT1iHeYZiIlmKoYRv5kdEk
 ULXcBZmai3u8Qr+OQaBq3rfM5GnyRK2IyG0vXOlBJw9nFysKAwCpR+E0NwJO6hxu
 X0HnZRfLTV2yu2Szq2/puT2u17PfFTXbZOLhRBk/MJTAZGFI+VW0Yktaub0gagQj
 JL2u4JeDAxEckV3L0fM70PBfIOak+tjKB64O6YdF1wLEEHhuREQfwQZvbdQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscf1fad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:17:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630753cc38so5700964a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777915035; x=1778519835;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBTfPe5yUoEGsgDSiMIe7M0rHkLENgYzLNl7AyqRuE8=;
 b=i/k65i2MB8zRjyQNhYcW4iHJtXdaOQXtxoOXm30ell23qFOSl7+7kUoX1MwcU+Q/FZ
 hIza5ILyp4V4v9a+CA0pqmcVxB8q17fbOst+sTJdWJswV+JSXd00sVic7auf5yqX2uHo
 8IXP4nT4xYKXJ1tkZyG/IUzT7ToKuAI5WVBpZH4+h6qZky6UNNYQMvfiwYNBPZ8d059D
 kdi9IWEPN5zwS2IaDc19/IF4NXxHIMsSgW3VSRha4h3WQcjQxc9XazX3Iq3otouK3NEX
 nk1AX8b6u2DUqU3iUHz7zExbj1ZPs/BEnqSKAQyY8nCamvm59rU+fEPaMK+FDpBrQ1X9
 kldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777915035; x=1778519835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yBTfPe5yUoEGsgDSiMIe7M0rHkLENgYzLNl7AyqRuE8=;
 b=LYEpob7LWKuKpUhwd0hZflLxl9HX9aaPS/sIzyyHhsBbnLJqOw/x1TbBjWsKeuZIUo
 UqTf+zDfQHF9mPDqsLkHN6e3H/BVCZ05OrfEJW8MLlP42cdVVVn77zhOa+gy3ynD2Nw8
 7h8nML74OPXeh5DHKnTf1J9FAY3wCRcFRCiovUg+HPGMBXxkUQYrtk8G5G22sWXxIbrj
 v4BCtyds94TX7rIziyMwwnxaGNsIHbBdg2jyZyWb5LMWOlDD5xY6G3gWJ8qDXLOKE/2Y
 Zm11iEbjVyq8RbTjpdu4tk5eJR6F2/wXJ06fHJ3ZO8bGzUp/adOICSXq4leYx6OayGvd
 i/bQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DnZB9up4T9yMKtIFN7BMiByRCwY2ttJulwfedOK+2PpOc+R1xvuI091a5RT7/KFyZup7tnaut3xc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw25bInexCbCxB4QWfygFitSCcZGpzMQ4tTNX8YeM/b6QGAW6di
 j1aLVu4tPVPKP3yUVXikKatsE2rQ14DVBRrvZoTi+iT86XQFSnsfZiqIm1vnu7+gbfgBknMKK30
 5G4ROopoQmIFOAlzWBektFXJesero88N7kYx1Dkzzq5p/XZiAZIqDqnKmj135fCvdeZFkpiE=
X-Gm-Gg: AeBDieusHynRWmJ0mS/OGmlefcyFAQJ+BuJbTOo8SWfdaojQhhRNNQhuy7gosBBOtoc
 mlxbucpQ4kYVtuM3JMPW8Y5b/oTXnL3mFYqTzhiMWNO1FF6k1/A6dts/CJMm4BtEYGL7gYx2++0
 FF0/wtYG1tFGel6nJZplGOQ+gXUOFt9JcXS8VVZCZzg0OV3j6JldmFZRJn1pBYuh5uOmt6EYIvz
 0dta+RL5AoNVQ7oAGW0m3lor9rKL+lvOTqUzMjWQ4yFssd9m/44QtFY3CZsdgw9iglmR5OfMXyP
 RUrJZSjw6ZNNZqjuYTM0f6vHpVK8zX3x4PbAVwBQoMPjMBHrj5dhyvwGD18U7J5luiCN5WdY/gs
 q0Zv398u8ypb8nMQDMQzNUCWMlH9aqBYmZzOCroCRfIeUhvzR45gKf3h/l6Y=
X-Received: by 2002:a05:6a20:1584:b0:3a2:d838:bfc6 with SMTP id
 adf61e73a8af0-3a7f1c392d9mr11544525637.29.1777915034606; 
 Mon, 04 May 2026 10:17:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:1584:b0:3a2:d838:bfc6 with SMTP id
 adf61e73a8af0-3a7f1c392d9mr11544478637.29.1777915034013; 
 Mon, 04 May 2026 10:17:14 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc6f063sm10398240a12.20.2026.05.04.10.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:17:13 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 2/2] misc: fastrpc: Move prints outside spinlock in
 fastrpc_cb_probe
Date: Mon,  4 May 2026 22:47:01 +0530
Message-ID: <20260504171701.18164-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BcvoFLt2 c=1 sm=1 tr=0 ts=69f8d49c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=6S_dsKRq4wc0odEj1ooA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NyBTYWx0ZWRfX1gpJmBsKT247
 ayEngqBF90wEO+g5ti6hPeoHuF9mxwIWfW2OaZkHrjkI+Hf8WnqDbZeS7WCZiaVs2tOllXkR2oU
 ajRZrerMNqAv+XaWoTvGuWA1LAhBMfEb+1aVl8vQPEFBF1DUP6vn9GLUxagB/LR2M0oBjMkX0Qt
 3uI2qT5mcqundJlGE0Ia8kRWqhivkpGVk9VrU7CXgNfk/JxnnuASL+pRzviKsx+90yfXwSVwScC
 8pWe9fBNGO8kun65yAmArewO5wYAI71pNxn8DO7clwgUpGOB+vmjeSUWJDmtjpBUSRg0SHH3ExR
 vpIhYcKBusywpLmIJQVVHl9/4NYx+fhQ0PCNwvgOTHdpAEbXA3nDoi7B47Vas87jFZ+eTdIdhHy
 Rgmvfep5EOd/cpbtddfCrd569iJK9sJQ2L4CA4lQSHQbx3tNCBFUmhAIlaUnljXCVhHyMad5k/M
 IQ/iZKmmLzow5GpttSQ==
X-Proofpoint-ORIG-GUID: 3f8qLPnn1EwpuEctKv__fqfczQTCV7Q4
X-Proofpoint-GUID: 3f8qLPnn1EwpuEctKv__fqfczQTCV7Q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040157
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

dev_err() and dev_info() were called while holding a spinlock with
IRQs disabled, which is incorrect as printk can be slow and should
not be called in atomic context.

Move the dev_err() for the FASTRPC_MAX_SESSIONS check to after the
spinlock is released, and save the return value of of_property_read_u32()
to print dev_info() after the lock is dropped. Minor variable style
correction in probe function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - New change.

 drivers/misc/fastrpc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a1a54453bb7e..d169dea961f0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2197,19 +2197,22 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i, sessions = 0;
 	unsigned long flags;
-	int rc;
 	u32 dma_bits;
+	u32 sid = 0;
+	int rc;
 
 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
 		return -EINVAL;
 
 	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
+	if (of_property_read_u32(dev->of_node, "reg", &sid))
+		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
-		dev_err(&pdev->dev, "too many sessions\n");
 		spin_unlock_irqrestore(&cctx->lock, flags);
+		dev_err(&pdev->dev, "too many sessions\n");
 		return -ENOSPC;
 	}
 	dma_bits = cctx->soc_data->dma_addr_bits_default;
@@ -2218,13 +2221,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->valid = true;
 	sess->dev = dev;
 	dev_set_drvdata(dev, sess);
+	sess->sid = sid;
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
 		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
 
-	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
-		dev_info(dev, "FastRPC Session ID not specified in DT\n");
-
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
-- 
2.53.0

