Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC50C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F9110E502;
	Sun,  5 Jul 2026 19:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLn6zhut";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gFi5ijyD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4965610E502
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hi3BS2353124
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=; b=TLn6zhutzCtePBXP
 eApN5L/sdm3XfMAHOZhP82YsbqE0e2xRcEAFk/+OzouZNGNfc26qhw5knDcbPcel
 BP5iZZDUvJOH4Kdt2QhgKPJOeoScqNJcXRyWCHIYBBbsIEBD0ZiVVQvHgMHBpB06
 KDdBLLvkRr12JNjMqEtNLmZCzmB3HEASAP+zwk9LWIkse6JF6XJ5aE2oTFOlREXB
 HWsjh1ZGAPgsRx3a1N+Une0Zk6nBS+M8q7Nzxb/+beCfZqlUhL0J/8be0mCDgioR
 WDJzt0GGrulk/kLFg2I0CGVxAo6WNnObMHMMKTDfE+fIZHUMdON7dtl7vgqPIl6I
 fMEfTw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sudwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:41:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8894570b58so1575783a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280485; x=1783885285;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
 b=gFi5ijyDCNE6JlSxd8ZAbCsbqq9+n661yMvfEEqI+zb/y5PPPVVH3hFAVSVYXXXyyh
 zB4W+tVHoqIG1cVqGKPpPR5JfI2ubZibuzxooim3S+Pep36eLeuPu0nzWOXlkA9/5Vyo
 spNC/urUBBghxOaxdMtGJdBAyVfJSFvO9YQVy+zA6TAiEKBLCnaicpsBAiYAn+PL0FS0
 7F2q2VrXveFN7JSug4Op/zPMkWJ8m6zQwRA6++EtHsC6mTFL35vhI3e/utxSRlDl8WHh
 dFjXqTbPb/yFTyeIresYUrM0S7N5Igtf/zvr2ihSMNhjY8ivOaL59h4tIPLMYnprATh7
 vnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280485; x=1783885285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
 b=Wn+uy3Xcb4oE0A2sCabxZQ+nWxV4jKLTdgqj+ow8YJQraWhVtMOM9H6EJDYnDNM5Ut
 H7kTBWP1DC7RF37i29uU/m0UnbytEJBUh6hO/zubDwmC51UwWEv9fxB8Wcm1iUsvJMpG
 bB/4mVyHFtSzJzBkbnoHVLbc6ehTBN925nByqaA3e/6O3gceBWgzVGcI+C71LpXzA3Gp
 C/EAu6HJuZcrBLD2eQURh6aiHwHshyAnBDA6GX+rQhTZWjxY+V0PSt9IHfl5DsVjBFEX
 0RGYwp2SMeNmEfRy3qv/Y3qTOVUTh2XlGxiAsRDjNHA9Lb2l6IB11VbzO8zj/306lJ0C
 PJhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZuSTT9L4nE0kCfg+7K30nGuCMDq7Jlz4OufhqlJ68Bw89ALdnPTiy0SLBT6MUYchveqykyOxFM6Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3tHtG4Xtzd06jgW4EryTI0sFpYPbnro6qGOjyFeKwyQNtlXBQ
 QY6UIzGXpBdWp0sWMZYudDRHQA5hpJUwQYlPcZTA9RV66hCwdhNgplFE/bTfd6NvDBF27XcD8If
 UpbCo04ixBN23/x0pGud0jbzqhtIYRybL9DEN+oGKtBPNbw7AJz7CugS3Ou3i4VGrlTnIZ6c=
X-Gm-Gg: AfdE7cmkIrkhnYQ0BaSyOTkaaOAXcWF2/8Y/BsfTbjOyCC43AC4o9ZcJlsx87YkN70w
 kmvHki6PRHNA0mzUW5og4Yo6vQ2XQd95DpG5pKz1Ye3EAj7+2m1Y3wea/YhIN1NS8IIq3lrHFng
 xmQQQiTt98EaqdAWF8KMvmunn0LtxkVhVMZk25YZicotCxhcuq7FYUoVStt0AlECvj6TeMqZq6Q
 blrwMd+SvamP9AXr0bxeO+YDlaD3ZOlYeAeLJgJSvUf0FP7QBaNl1eD9L5WU2Vg5k9ucRrnpg/1
 rVxZZxeFvBG9vN0vLnVsy29NivbF9fXt/0Ec1DGi5zh+Ql3jq9s6XMTBjwdYbcu38i2h40VQaAD
 DY/zubi79fYEaSWZT33dnLBqXu9zMqKjM4SF4cw==
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id
 adf61e73a8af0-3c03e26ff8cmr8745227637.15.1783280484465; 
 Sun, 05 Jul 2026 12:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id
 adf61e73a8af0-3c03e26ff8cmr8745209637.15.1783280483924; 
 Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 41/42] ASoC: fsl: imx-rpmsg: Use
 devm_of_reserved_mem_device_init_by_idx()
Date: Mon,  6 Jul 2026 01:10:17 +0530
Message-ID: <20260705194019.2565498-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX0QBn0tRqGeHY
 Jl9wTzuOWm7a5Nyw6nz9FZpEyD5xeRyDTxg/ChVgpXvThyx0hRG/IdVBHsPdz+QSxZnTHSnc97B
 ZOMUr6SWM7BXtiIsD5u7JAttbFQYwYo=
X-Proofpoint-ORIG-GUID: IQbOiV46hPGjz0LxdcoSRxbvJL1QPeRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4yIg4q+Djpsu
 0Ww5g3iAXGjtEspKdu/wjiuXxMukxXijIbyADWH0JyIBoGfUtxvlvI0kpcNaf0TzAbL7ehYHJcK
 b6GbmLl/1/SxfQ8LrefDqx9bn6xWefA4oDDrBleoItYtV9xlN6fFYwCpmh0m6Ig9y5ppdco8nFG
 AOIe9wGzyY7LhvfEUSFlYUw8C9zpABxx8gXfjXYJiVQFNa/bxSanRba8pWqZQaLFyZeCs6aljlY
 kX/CddbjsUaCB7qyXGAkCvm+RD8L5GtWc110PNDRHiuQKFdAMwmdEI1efOnymBHW+hIp5bJjkBD
 Vrk3ukdaDHVsC2ZLfMwWYCVNMfSF90X9gXDAOgUCPxRDHVslbmQ2bxHCcc2Luaj2i9NwYnDRXvg
 xm2ez8GH7TbgOHE1+c3hUidw0Xel4NXqA+6De6FDxc1Q0KfebhOCErq7OnIGFF4rz8pQVNgWAee
 K/a+/aq17OANigvBMLg==
X-Proofpoint-GUID: IQbOiV46hPGjz0LxdcoSRxbvJL1QPeRt
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ab365 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dtkDxOtodmQ1SLiiO2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212
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

Use the devres-managed devm_of_reserved_mem_device_init_by_idx() to
ensure the reserved memory region is released on device removal, fixing
a missing cleanup — the driver has no remove function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/fsl/imx-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 5f1af258caf2..f504d94c4f68 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -199,7 +199,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
 	if (ret)
 		dev_warn(&pdev->dev, "no reserved DMA memory\n");
 
-- 
2.53.0

