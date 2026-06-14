Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A79CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1F810E12A;
	Sun, 14 Jun 2026 21:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z+RhBxCF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wj4YwYh8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07BD10E12A
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ELEn6o2668255
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Bur06zKcsSYkJsUBV4uhT7
 g5E5SB6XYFrjgclNHkfuY=; b=Z+RhBxCFxckpOJbV1njc6mIp0E4/+fGHcovYc+
 K3FPG6MVBZxPsFHAwB8EJ/NY/Ky1PbWuQPNQXJiqU/+DOZZnV/knvzJrJdiECK2s
 OUg4rE3GQEtwVizx9/w7UrQo7TzfY2R6atbIbTwrnsarPn7Pa5Ovi04FM76NhdIF
 6PbAkPSYB/xYJZXVfCgoyWiEpyzVmn6tYzgjXZPdZlOH0jhFr6q1xdxDMe43hNet
 dUZyflkZ7YjuvkPU4rK5dsqRb18g3RvSo2FRvV7UdMubLiX465/Dn4Eu1WyW8Rmq
 XEMnGonf1qNYv2kkBLgiHhhp737uIvntI/Ipqy6R/UHrobZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u4jt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0bf6904a6so46003065ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781472790; x=1782077590;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bur06zKcsSYkJsUBV4uhT7g5E5SB6XYFrjgclNHkfuY=;
 b=Wj4YwYh83a6YL3kGZaM6jlYAJ2wW8U8P/xpoZUc5A9m3SdGp3w8JsmsMTgWU/ZtrLk
 qcHkfAq6x510H61Xb1J37bti5XSL+hsNvXxRB7DK6/e723GPD5g0WPI3Hm/LaRGnNG4V
 bll8cvf3Vvd3XkQMDZ9drPe3bYLXRa2PFsjKI6eihMdwmAPxDcfSctA5EsIkIDSZGPdT
 nvfsjY3kVW17166asjnKLxv/6qWiIOnKTb617STalI0rQfpfTjg5BoIFOHcDTnnDt4mu
 YMr1auVPBwhitymRa+wYgkuRCiFHHUm1j4vCm9RxQuxI+69ULcn48ldPrL/tEmx6ZR8y
 CBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781472790; x=1782077590;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bur06zKcsSYkJsUBV4uhT7g5E5SB6XYFrjgclNHkfuY=;
 b=CN2C+gZiXyuE4oNUpR2kNawjJo7JV9UGhQc7k7a4LLtnxwpA8TvNiifxVMFvaThowv
 aoVaxNto6X+C6cmxqp8OJztvSoi8MqA+8B1uX/P4JBtXTMunozPG2McyhHpexHC+VlEN
 DXFgZTnd9HheWYTHnJ09VqRk9zuX2B/BZcyyp55iZgnHyWPWptiLJrydNC4piF+cnZMw
 R74XBQGvOCbldfKX5r4WyGgwRkATlaKbWV4wuJwtHKHzrJm+mcxdu8AB1AnSgYvXGBgs
 lvvph+ZGP61LvrRoEt+SA5aPJuca15sSOx8534tqkNXDk0ln3SrtqJ3R7nCD5oeh1Fzt
 md6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ88jYF2HyKYLtAu7apML2O7aqk30f4AG0hfHRCpWOvzeSux03PCo35eZI/i3lHDAocJD7SCBsWpfpE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwetCDaS2Z8WFaaPCIWVB+AbO5VOyLfZLDt/mwZhW3bN7ylmxUk
 nLNFIBGzw3pxV652/eB0xn4E3iCYBN9ABe3rkqKxFOCa1NXVPKYp+vF6DcbuZioByIqLCoxI/He
 Rg5N/k8pL3nxdCgrvZkWJpHLiA8fzrc/LJZdqj5slNPv7B5ZhhV35iqLJGaUfpnMEYrLqhLA74I
 REqSQ=
X-Gm-Gg: Acq92OFWGA72ZDWSowRPKGmG6bApe6zTG2b9qrX9itfSFAj1WaqGnR9SR8uHH3R7+mx
 eh0k9KgSxWQyydsBuNDvX9l2adXTivltW4MNBcc/VW/4X8TcCmx0H7fMyulgD+FZ9SPJuDYI14+
 oHyweKiVjvB0eSsCr+q0tdtIDmNXH0MdMpR8l2cBavxDYss3xhWjDUGwzdMeoqk7sfbcz9ugBFw
 SyBNekxXGYSdapCduwX0F0AkrP2ml1oI1HgPaHmeE4r9BEbnTBgyWUXQpWN5cr+5FG9Gdv8f2wu
 1wz34Rx+OtN5ROB+emcwjZw2Z1oqkXGajJNbHq99yFOFwRTSggFV7CRVQdjfPomnUOBN0v/77U8
 pwMGkfRznSq+EVMiCszQutBaEUKtBvGHTFsyFJVOd2uJekA==
X-Received: by 2002:a17:902:c941:b0:2bf:222e:455 with SMTP id
 d9443c01a7336-2c4109ecfbamr130763475ad.7.1781472790197; 
 Sun, 14 Jun 2026 14:33:10 -0700 (PDT)
X-Received: by 2002:a17:902:c941:b0:2bf:222e:455 with SMTP id
 d9443c01a7336-2c4109ecfbamr130763165ad.7.1781472789777; 
 Sun, 14 Jun 2026 14:33:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 14:33:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm: Add support for Shikra GPU (A704)
Date: Mon, 15 Jun 2026 03:02:56 +0530
Message-Id: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgeL2oC/22OMQ6DMAxFr4I81yhJCxWdeo+KIYCBqIVAHBAV4
 u4NsHax9Cz/578CkzPE8IhWcDQbNrYPoC4RlK3uG0JTBQYlVCpSkSG35u00NsOEye2qiop0Leo
 7hMDgqDbLIXvlgVvD3rrv4Z7lvv2rmSUKzCpBIit1IWXytMzxOOlPabsuDgPy7dQ7GqdQ0Z8/o
 NBMuB8Z/4h6WjyefqlCYvsBCVDfttwAAAA=
X-Change-ID: 20260609-shikra-gpu-5432bdeaf0f7
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1310;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XhaeUKD8ec4SllC82vt0xlcd0hBy+SDeLmBke9XzXRk=;
 b=ivyhD3XZRXduZdfDnTiKOjDQ59HNYEZ7GA0ltWYmT+EzWj6f47wF+hZ4wLfkRqiJC/Tx6fMpp
 zKINriZeE9UAw4pN32kSFUX/mmaWRexd0I7ddS8cJ00O4Hv2Zb9G2a6
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2f1e17 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vtaXLjJ3spEbOLdMN1IA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: hqBjZzI92X3ooq94CsGDjxxIbj47tHN0
X-Proofpoint-ORIG-GUID: hqBjZzI92X3ooq94CsGDjxxIbj47tHN0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX/mthAUtgeV6W
 uqEFIkbaocnXlehd26L1uRVbuFucZikkWq8goO4n+qPGK2JJg4mxb86Dao9Uv1KPF8DdoDxkxZp
 DiDxRcM54sRt4A2Zk/ovXqH4OZbPIwKkJjiJgvu8bkcEOMZl1DX5gia86YVuxsgEh5K2lgp6Wwb
 l4sXQHM5vu6Z2AC5yg57TQWVQYUkswcrtqR408veQHOP3sqImVZq/4fYTq7uaGd3mtLsV8BuXaQ
 fbS4w8Ipv1Sx0CXMNGajikh0OR/ZCIhYS+3mlG49aQ1VFXwVsb87RvFx8CHo9nj9m8efgtD9KMX
 0qxtMMx0oic/JL3Ldr7flRWZqi7unMG0xh3Q5MU7IZ0/aZDEX5kes/UmHAoOIUDMwYBputVZBHc
 G4RRotwhhkyXbBeNHBLxxunLRjQziq97/siiM3fAXTxheoumRnPDhUSnA+BmChUOx8smnDqr/6G
 kICTkxH7eiPVVU7+0Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX1YJQo7B3m/Kl
 tfNqwEfH4V3wBc4W1mYXuP3MH0diFWAVb2+43Mfv+z339vHcScLyhY+xMHknJbUA6gb1tgFoROp
 DY0NWKHVx8GnKwKDfL572qjeiSJQZPE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140228
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

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very 
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Mesa side support is already merged:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41762

The dependencies for the devicetree patches are still on the mailing
lists. So I will send that separately.

-Akhil.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Add a new patch to document the GPU SMMU bindings
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com

---
Aditya Sherawat (2):
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      drm/msm/adreno: Add support for A704 GPU

Bibek Kumar Patro (1):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC

 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml  | 2 ++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c              | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 61087e3a8490908a65da4e2d33fb5de6eb888982
change-id: 20260609-shikra-gpu-5432bdeaf0f7

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

