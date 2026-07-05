Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920DFC44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843C310E320;
	Sun,  5 Jul 2026 19:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtgGyEI1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZiGGy6Dy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719E010E3D8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:40:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiQs62273276
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hN6fEXJ0a4t
 H3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=; b=FtgGyEI14vKK9OqT430xUfOmGLF
 J5bdRwGnYlPPVp42isHulDlrVXRumzlXOnWaKAvEqFlOMf4WK0t/UVb0tPS4H/wS
 PtxzMba7S17DNMo9ExtOcv+rJsW93dNgj/CIpMpvyCzFyneGj05+u1GK8iECoqyK
 WM1mPqrqXajrrVrH8/J9pdvK2VoDaXNIt2t74egeo5x9BAqNhYqqiB5QdwrFv+QG
 jv/TZ5nh6enGJUvvqqxYx00YdVL+37mb/7PnZAc+8iS+maLp8PJIHST5NiO92D5M
 ugD1/b8iFPnLJM/Dv5JgaqSUO0Jj7Rg0n1nlkl2C0BeSOL69BMELnoL/dgw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnkmc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:40:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so3489409a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280452; x=1783885252;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
 b=ZiGGy6DyJ7x7ySWkYUUAThalYrV+verkRmiE0Ir4NOyOd9oTyStFuBoHwIduQhdioM
 ynrycZm0oww02BwKDDMYfuGEFEbvIzOYK3rEPU0KVC5v7wYQR6ciM2lIpJmFrOg8OhD9
 +zYt0H1sn70/Qp/KF3oL7pAMtObkhN/SdjYILq2AQ2vj2ZGIlwi9ZmFwOcz7y0X679nQ
 XLdiyzmtvv6VFIvErJef/jBQgOvztH3G2pQthfuPpE3tetlmTRGj5LS5JCfmtXPxnrz5
 8mj1dOJfVOTUBhnIoIBMkwjpo7QvszdwseKgWgw3okULC5vAVTS/cZ3nkc4KJB313IUO
 YmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280452; x=1783885252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
 b=CV0eKzkEbbBZU6H1Qse7QNqlRvDZTqthuWqXB8g/ZZMpVwd1sz1pPzgddJe1om17XB
 ZNw117nNMMoeiusyFA1QjQ0cKzM6vwI4V9zVFmUe0qyVPL41bM8mvLY6xNShmTNHZut8
 XZBK4FD+6Z6T/p5+WhM2ohoEungY+MY40rv+hSXWPcawnhTpxBFQ3yEGKxd2Qz4Oe25Y
 Zzxwof7kAL1EgatMW0vTEIQMRBod/DcMc6kcLZ63KqNc4dZfNK/6KuN+eikujzqZMKcP
 sJC612wbUlh721tT0W9EWqpaKBcbE6YZEZN61l8nfN9p/hW9Y3Z1gqzQxOaWKerqVHEp
 hNFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBRNOu98vqM4lojVWtON2bXPo75ttVrVzSuIzd5axYNZwKCLw8u9EdU2rsf4WsEGWBjCv1ZrYAxrQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ4mXsRQWyZPEiGt/IaHFgi7NrcWw6TqVUZo2d62Ikw30kLzKz
 U1aC4NN+i4C/ZOumef1Zd7/ZubS2qCP1AZN8VhTQ6bf7dmTLwDLt0o1j4YmjZD/Uyb0QEk2f5Oc
 5TZ1k4US7QcHt9gPsNnf0GGAhtitx5dApmmTfsiGIbBLHkLyBqAWRD9BCdFZmspYA60fRtNE=
X-Gm-Gg: AfdE7clLyQEKQj+LBd5DMn1BeB+1WvIkZmZe6jq+QHPQ5BfF6IxuiC4iSh8tgvzzuaI
 rL8m9aQcVxUQzX5lfyUIwhdtwkHsfutyg3/yr9JGWHFpqJLfcjjrFW9Exr3baMlthg01bDpza91
 obbjT14giqUEALH50BgSfWKwNtj7WhB3S5iCShUF4qZAvXZ+5lX/wngaVLG4sVCgA1SFNrMVLo3
 njywcnNUaiNJjmJTr7h5k/YoNWQJazF4cRNPRzEFKd2iY9smA6AjSfZx4kRz/deHToSNoS5O0sj
 g6g8sem+B+ws6Y2g8UAn98TS4iP9oNWOP2+VeTreqiEdc3R9qgu3O6NMaG4LOERdftP7cdHf20i
 Ya6rhBMKdpKkfu6o+gs7F0JCshLILmzmV9nE7+w==
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3c03e4218c2mr7386830637.37.1783280452364; 
 Sun, 05 Jul 2026 12:40:52 -0700 (PDT)
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3c03e4218c2mr7386810637.37.1783280451853; 
 Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
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
Subject: [PATCH 36/42] ASoC: mediatek: mt8188: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:12 +0530
Message-ID: <20260705194019.2565498-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX96Tk8Ov2HF1C
 E/E73y/bzvR6WPRlb1+VkQly4Gt+EsnR7b4XDgJnq1PHAVt/i4lNYyXYJgaXAjmVMtHcAIXqKfM
 e0s8P1HSq1Exv9T71GeLT3KF6++seqk=
X-Proofpoint-ORIG-GUID: aW7xz2gbzSMT6DdL9Io0bP0H7FP0qwgw
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4ab345 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=16fIdGUa3qEwhQSg-dQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXzo8xAR9JpHR5
 DSoLw3Gk/oQwQVht+FXfCjJFlWskIW5BwALTMBygSdCgbvJlHagkVXAgTREOExCpm9x7itu3e/w
 n815YVmqT3RoEU8Pd7nsu7FaiHuyJQGiJZr8/KnsCqTZ60kW6uUFynrF6MQntRLwDyKnVFg395Z
 ALwq0Qexv5DBvFarh7IUeQkr4AGfWvy5v3NEbPUVvIPFwqASDeSYDLIwh9NZN/UqPBd6iruHhO9
 WDug9WJBbzPRdKvNIXzZa4Ma0fhHdFWmBL4D6GgfpMfVNugOK1Bae0Yf1erwQtsmsy5w1OFPO/Z
 q/u661VAiKHMCSHCLsfeL35k1EZ7+YjX2QPcUVIZueWilTTk2gC8Y/l15lvRhGC2WxKXJ27o+IB
 wb6CzZOVXN2Au+Zanr7NhrHpSTAg5+8gM+PNSYJVSZP2WC7eR6ICNaRCi/IOU+H2BEiWDRsmv17
 MKQlkNOhuJg6fHf8V0w==
X-Proofpoint-GUID: aW7xz2gbzSMT6DdL9Io0bP0H7FP0qwgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
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
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 7b1f5d05f4d6..ab4ce5e86b9d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -3199,7 +3199,7 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct regmap *infra_ao;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		dev_dbg(dev, "failed to assign memory region: %d\n", ret);
 
-- 
2.53.0

