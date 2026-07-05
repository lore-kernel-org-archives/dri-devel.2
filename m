Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628D1C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA6210E4AC;
	Sun,  5 Jul 2026 19:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVhvB4ar";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WM33djbi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C3E10E4AC
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hi4WA2343641
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VVldA6NTRnp
 wPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=; b=PVhvB4arTRaJVhF2SofLv+u1aVD
 jK8zIqELdsOTMECr0irbXF13Py7AAvUWwCcgloBqNe5sydVgobN3ykdNbR62SDhl
 xSdi8gXykZAYDggG/l29V+pDv8vxNl/8bfs3RsFDtihqoBwh9TvV8ccwG6jurLqz
 hXyA3tzVzG/9j/LFOunKeib03MEp2rrcHiuWykXLV2BW7biJwWZULRxuE/380H/W
 jxvEJrmSgF/oSVLpQz6WOjtRFsfVbrSe0a7iY0325hYiJ5tqlT9bhtEQhpDaeG/2
 q5Zdnz1hGEN80AyPY0gPhol8PR+yZE2CguSboTpYR821bg4icMzfKXPz3+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3ba33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:41:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ca5d2474c7so54521635ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280478; x=1783885278;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
 b=WM33djbiOPxhjPpgKs2AGBOinJWXaPTfqJyW0hUm97kYzaqfZnBoi9QI9SfQqnAC3n
 FXzRv1JJQSsPg0rNPSY4ZwyFc1wwMTX16nxH7qT2CfThM1xs02zq2TcaG1zsE+pWmidj
 HvdeIa982OJt0NVhne0BxA9/xKVZJz2s77QNj26ysI0Xa4KsnxGgzVpC+Yn+kpceIv6p
 ZWzd6nbOIu8z4YFD1iMj1132dUrhQ2NgsOKSuWcW0ZpW0tbK1PAyKhbvwBe6KzZQSMUl
 6NY587EDzHJCXijlJooAq0/4m+uZxBrxMfoO0NGxfqIZMoNSWcutgoBAxWL20TlbR3tI
 ahqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280478; x=1783885278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
 b=kvsEuXlb93yZWCC6ekM2r2Iy/sweVi3bCKps5PHxYu9OQ7emUo2YQZtMYpfIWXlo2w
 zwwEzPZquCO+bKnM9W4R8Taqe6qxFN9JjHtVpuXE7clIxIdpze3HO3rGs4/D/woj6cNy
 q1a29oGDTfp9KaJCNRyAply/sX1u2MalOqsoFJRErU9/QuOleYnWfgkvcu8VTs1pGWkm
 4ghlWlrFVw+GyvW0LfiYxc9SWKV5NgggXDfMDPaB/Gefd3NJ6LHlyFNoVYvP16vhCiXq
 3w6OLQMNZXICZcb0vUjkqCqw03/gW0D5O1n4YKqdJ9N3++EIlJITgGHvYDJt5uK8PmnA
 Ltqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RruozT7P0m3j0u4qO4icelQB71p3NSneRCXEI43CpdDeXJdmiTwt37LGq6bWELtHehRueHvAiJmhjw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEwiAD/2hGD9bgXGRnfwcnXUGO4Nyyq4o5FfgNYK1PZzfUoGOi
 CKAYp6n+DAn18n1/heh/iw+fyp1zjSEGijim0n41+D7U0RR0o6XNLpEfu9pgpVVLUNACxctTDch
 exFDRLiIw17AG6ejZgH5BlJWQIN5TEghyljmHc87LG1+MSxbZpKQe9NkDxVDQNOrZefGQbsk=
X-Gm-Gg: AfdE7cnrrEtqIntk023+iBJqogIDtQ7fz8Br0wjZZV1GYF3b8HsO3ZLJssqJrxMEb08
 fqG4K+F8wYrBqrJOXJZ/zz7lwNoIx/BrgjkbuhpENG7bd4K5UYicGPZ6uo0D/pxZ0d8ZlzTOBJq
 rEOFBbUtJqcbXr6VVPnqlA6O4ZuAbcUEmhqm3LUXaev8i8+cn7HYAlgrpeMolxW4w9/FVGbyVdm
 5TU9lnQXxrMBCGlD2OibRZBk7LtSS4uJ3s+Few3L8BFw+zVz3tbIwIOd9BWT6uByVOXUMbIOngX
 LzAc/STNzQVFg+gq+qrfrbUWt9XNYZROyH7KOYNMUYOsPDPIhfzGVsjenVViZ9rZP9T8GtnqkFf
 RofTeOt9r4RqM6mBINOKcqo+J2aw0nyRbfVqCCw==
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id
 d9443c01a7336-2cbb9eba53bmr79826045ad.34.1783280478034; 
 Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id
 d9443c01a7336-2cbb9eba53bmr79825855ad.34.1783280477546; 
 Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
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
Subject: [PATCH 40/42] misc: fastrpc: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:16 +0530
Message-ID: <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX+c+7YdPYl3ix
 hEV5AzjMoy4pB+zFkD75ZJU/vfubTCnUzIfHjtuquZ9Z22zftK4xfyW9c2UDD6hBGU3KMPpX6nt
 X57wga/+VQ4pRS3w6qtpbxdHiSCeaz0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX/mNdvF3dH1oI
 wLy7fkZK8KSgDjagbW6psKakN9Fl6ViBKBSBYYruQVXhgiZh8Btk9xhGq7/vWg0RprFj3xMjd9P
 yneER3E/XS9mUU5m6pB0O7e4NjwN+XeGm+OYPVCpohY8//5/FyBPK5sAzrbW23O/cJGmq+CUTZS
 rajjfbGPV4xq6Au8ZB69KnhYp7DWs2twTaywJ2kpbdllILtv4nVMxSckciwId3PRYXngDhDnRBW
 oHWpijK5cvY1CfGCQI4saOWVMOIcvRSlTkMt+TFsorFOrnyEMsgHKKLIUQubNG4qW84YROYJr3S
 w4AnRDjnf10QCxIVyA9BCjf+GVHdbi139M5QmIM3mAaylSHV8XaKipm7v57RShd7xEUXwrR2SOX
 sM4aisW4KC9IA743wxrtfR9+5EP2sk/G9Kf9li+z/bmmReOSqlvkCWpdGZJ7RXtKA7iJA+nKA0S
 XCcJwTFidIMFYvnNk9w==
X-Proofpoint-GUID: jcmW5FXN6-YtC-MqWgwO0invMakA_bLv
X-Proofpoint-ORIG-GUID: jcmW5FXN6-YtC-MqWgwO0invMakA_bLv
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4ab35e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2vM2yDDFhuSsTauGYd8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..c4e05b0db527 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2396,7 +2396,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
-	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+	if (devm_of_reserved_mem_device_init(rdev))
 		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
-- 
2.53.0

