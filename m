Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9166FF53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C1710E311;
	Mon, 16 Mar 2026 18:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIeuQN3/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fgy2o8Eo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF6D10E30F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:44 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GF2h2M1534048
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UhUoaqMDDgYxAD50EqOlz+T5/cx2aWxQ94W
 Q56aNaoE=; b=NIeuQN3//GmHLFATmu7wKxi00TLBPzjUocnjj7svOxztTcYGHPX
 8j2Uje6E2aVA5Wcvdblt0ZqWz8wv18gKnIFuTFLK+2cn6nKPJ1xR5rMI/AaO72xl
 wW+KrYaGoxRtfqPkbf+1iSsAJZjDdVvXBMi4t7HdfGIrYj1rc4tDVcVHWck7kp6I
 75FQHp8WDV+P44yR/Tkxo66DTLDIbQHHbJMVAtuTksj5Ig0E8bvuFcpAkMRvamrA
 k9Ymo/ct2j5vd11TLq8k3og+orRBnk2jUqYNyeFxdWyXfzDltA4Roptoul9789yc
 mXpjCOUTVmQMaG+PPDlefBbWM+zwh+xWjPg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k0sdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829ba0e63e8so2376695b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773686083; x=1774290883;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UhUoaqMDDgYxAD50EqOlz+T5/cx2aWxQ94WQ56aNaoE=;
 b=fgy2o8EojeM1j95ymk7ve5M0FHnMgelhGN2/bXwVA7VPMVcyzLcKOfZrtklhg7YH+d
 c7M3PKsrN6sjO13Qrtwokdmbk/GE9N1VqtjKwwwQ6QZOwJ9EKHN8q/jglg7kmZprPABs
 bKg1/xUzfSF2477JGh85BQ7b4XZ1ySUmJvE87/s7WDN77mt4Etfk2xZ1XzT3sRKGwxd7
 IWuHjfrk/n+P1SPkyfvB+tYGlxwIte9+R8m+juIdAbQ1haBWL8VGrt9LlwzPan6Xn71F
 ohwZG5HGfD9qMOx2PjO87AIxLY4YYIUWvvpa/LilSaeI62jTydRQY4uIsoKXUhQlTGut
 MMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686083; x=1774290883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhUoaqMDDgYxAD50EqOlz+T5/cx2aWxQ94WQ56aNaoE=;
 b=IYtZL1VyOA9jwBGwk3AbVgPJK9R/ep+G07MFafFfGimmg5aDz4LuDu53U+FWs0NdF3
 AZXCaxNNjN2oqRwDu98k6hZCIGeNip46H+VStFGT4blKbfhEMezvrUZM8kPrEbi95AGc
 DqLTdnaqtb7ewQ9Peiw3s2CEvdvk1wH2zh5kvWoBQhEndMl2E5K3XP85efUgSXIStZu0
 3WsZ7+jPn6IZDGhBV9vDAHHrXVSyKdcC90GMF3OThquEubSj4ZNPl4myZcapijSOAC3E
 8yYZ1wkXFuqLoceI6aqeJvZYDnkq81gNMUNXYdAbB8mt0UL+crENKd47L1oX0q6q4ISd
 pm6A==
X-Gm-Message-State: AOJu0YyEk+uLi5Uif51Ql15/vpgiousRwhTPWmo1Tcy592V8Z1hrhump
 NL9XOP2YLBHyPXvmv5RFotzMWJb1culnLoNGWSh+fIpruzuBn9rSzhxYfvE2XSWddrDW8RWowLU
 OtNBWI9UKq9KsD9RmQh2P0VEi8Kvj47TC2nZ0PoWL8Ycw7jQH2mc4ibZ/gM8uRRJEuxWdqwEcjO
 iyVJ8=
X-Gm-Gg: ATEYQzw2wktzdy5QDPmqYq6kDOms9+dkWozRhlZI7bqr/0w4O1Fv2EN6+EAQePTISt1
 zcJzFH0+8Rw+l7/06+XjJy1ASpghHRa2KlJDpYC5d5qnDTTEYKhqOfsuFfxs05FVCfYnQb7VZQr
 sgei4fDftpoDBr/0rEF0j8EEYVnvsX+H9rBPdTT+3H+pLNe8kIrXWmYhTSvmGFqoxJ11COqC7x2
 Qw4PrtjLQ+on2iwezsUdLrjwM6NaLvEnFWPIHWbR7ePiEkHntN+A/LxDySUQUFcCprjOq8sf/IT
 8v7WLoIrUensD75l5XrJq7c8hfNSqevwbctva7k6x0vcgUIY6pRH8K+YgcGji8vTg6R69Dywcv2
 S/MulBCNpR/9iVZ6dIR+mnyor83pZNUJY
X-Received: by 2002:a05:6a00:2e9a:b0:7e8:4398:b34f with SMTP id
 d2e1a72fcca58-82a198c6c3cmr14086616b3a.34.1773686082819; 
 Mon, 16 Mar 2026 11:34:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9a:b0:7e8:4398:b34f with SMTP id
 d2e1a72fcca58-82a198c6c3cmr14086585b3a.34.1773686082329; 
 Mon, 16 Mar 2026 11:34:42 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725da07sm14144189b3a.19.2026.03.16.11.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:34:41 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] drm/msm/adreno: Update GPU name format
Date: Mon, 16 Mar 2026 11:34:32 -0700
Message-ID: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b84d44 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=QRM-0k98RqYhvG7qax8A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0NyBTYWx0ZWRfX5z3OXAV+uARS
 3OnCjCGmb9r36Glz9kL8cJbMnHjsZCSx45YaeYDJ9U6CSUp3PCj6m2g16cHkwXmlVDVurqQTd5S
 5g+/iBEApXCEAPIOk6Zl3Oxh38iJq7lUuBTOJHNDjV5/p/ZRfljkUtaba8MgFSzAk5N6pw8xYcM
 8ZPtkXTWPzKeZYnGiLAEzwMQ0ycMk9h8acSX0pzVcO+fvbmazO38Igt+VN66SCshFx0yXGYeeUX
 87oMzcEzjy+/MxaFAxr6RFa7MRVzkx2zmHHlPkuvFdY36hKlQQqpbtaHHtQnjMJ6P2/grxK4OFj
 GjCCu0jlmiV8Jj7oFW83PLVa/69xlxjARpVpIdhuc4AFcnv0QL/DqMkFrjkmTs2rPLjxdP6aVXi
 L1TB0WFZsDL5xVqwT0FAvpO/QWJJrHSneWyoCm7DruR4Id6dR46UWbHm1l2UyuiWc5+UCvqTWxb
 3iYxSufdWyaoAvqausQ==
X-Proofpoint-GUID: kCyfBo2SBC-cVOFX81m1hN--RT29h9Gv
X-Proofpoint-ORIG-GUID: kCyfBo2SBC-cVOFX81m1hN--RT29h9Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160147
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

The "ipv4 style" of formatting the chip_id is less useful after a740
with the new chip_id format.  Rather than doing dec->hex conversion in
my head, just switch to using %08x, which is still easy enough to read
for the old scheme.

Also, for a8xx update the name after patching in the slice-count.

This series only changes things for kernel dmesg.

Rob Clark (2):
  drm/msm/adreno: Change chip_id format
  drm/msm/a8xx: Update GPU name with slice_mask

 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 10 ++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  8 ++------
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.53.0

