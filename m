Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C6C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0DF10E8E5;
	Mon, 10 Aug 2026 14:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxLniLvl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uhn0PnyJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D8410E8E5
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACigME1705118
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZSbHX3DBaWx0ew7RT4iT/N
 UH9SdU1Tfq8o2faGRyMbY=; b=PxLniLvl2UpMJUCl1Rs/471l7JjUcd9ihqJCKL
 IExJGAQvduVyvrvEPR3rJ47LLLyA2Gr5u978o2tSyY7tsYTVYLNcFfjfg56maN6m
 DQjXx3WqPvxpiUaPdIJwrW4tzhyk4i+E/4DVJhTZ7EV6JZBq4p6PhuZ/vIpe6feb
 aphTRCHZmChDalk/I1vC3RPpgMr7XoXkT6furGPZmOu+rrSqAxnQd6dr0lx/NbmY
 89Wc1Dd+zeri+PzvFEBM5innF99bQRFvcYvnlhb/ayF35fC+hhMcvpfofqsP/zJP
 75Ps+jo8k8iRyxtdOOv/Msy+FNZnxxpahficZY+zfZVmnw/A==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fybh59frg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:46 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6b5741bbcso761454a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373865; x=1786978665;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZSbHX3DBaWx0ew7RT4iT/NUH9SdU1Tfq8o2faGRyMbY=;
 b=Uhn0PnyJ8WSX+RXEnFta9rYxBwPRYc7NYpsyQ4Adr515l7XKe+FUoS3uIs13y9TFRf
 6+0Zs85c5sZOBu5JuZGA9m6/h+egAt5lbdP0D2+Pw+Cu28lffzJFRA1/KQUS2LU0zYVF
 PHReGKzu59PxS4tyIGhN+jXqT4KRVqVNZz7mOtz0YJ28h6HBujXWaBJc+afqyCJahVFi
 n6cJ3cq7Wf+g+wNBbKYtSjIIXPZ/BuKR+cVBjTlJ/76kxjc9Ge0rcWqraceBonD3dRjf
 LiOdKPMo9hkkVSs/ULix5v/F13/b6rsaSJZSMHrJvUwC0e4AZRLtXCxS++B6ibv4p6Pm
 LN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373865; x=1786978665;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZSbHX3DBaWx0ew7RT4iT/NUH9SdU1Tfq8o2faGRyMbY=;
 b=GlHZsq9WXOz+PRa3apvUI8buAohXWt5atVpr4WfpLkJNUSpGRWk6atVatPrHcpnYcm
 tQowxlck2TTOwfFKTuNRjnVKRiKpWEqtPisjQ/A29DY1+iKcd4BpGwbD/LN6qjOXNYxo
 5vKLTT2ZSyhRX67quc1yEb73CcQrCvAkohNifv7tG4kCGVXp5HcKp3d72L2CWt1LcRva
 IEXA903h4k5z3jiplRvXrCAI2IpdEiZOvMIC2x91158aHmZr47A5myjTQLOcVIjHUyf8
 H1zZvCivijagh+iSFEWlmGLBGJstV4tTF93iezWCBA6sB6ExIF3R/N0vPUjbFHc9jVbt
 7wbg==
X-Gm-Message-State: AOJu0Yyiu4Zv3BAsf4UyeJ3INCyj3QRCaNm9mwX1xTtNiPr1phgh6U/G
 b2Rl3DnID6oZcxvo2zGWvmnOkUEv+X05EXkdBbtvXI/dq19UZ5NB5uH5kApAu74uqcxiwIYclpl
 xs4HoIihE7HwSDm25dvo1R2O65UCyM+hae4vRL14x5GpN9KFZajrna76X4liRXjTmMjeEfKU=
X-Gm-Gg: AR+sD13gY7ce+JfYOsx8p2wmDCTHBiqp5DH0WJFn5whxlHh43CrHano6Tk6ifxDK/hY
 bbRBXYyJUy5v+KBVwaWOxOZ6dvQSPfjdaL1YB1tDBW8TczBjqD1NCVBdHvhK79A+7hTs/ywlNhC
 28o9+D0bMBjW8cj/GtYStn6QaZMMTnmOwkktgPMNOFeP79v5aTGwEUdmXwkZHWCF8CEYoPXc4v4
 OVdSEBNQTfqKSHiWJkvkUZU+ylncmNVukC+TZKLtr7QT9OD0t7hub8tT/7zDG96LluM/gfiHIgt
 YebwerJT77wEeZH3Mb85s/3ZXQXViiNWNdiQ2QG1lTPHLhjoLv7zFdQlV9MqdcWD2SbcjuPxnBQ
 ULmPnsi+nnztNCxzy/v1Yrk7gjG/IGA2U8DomBVj4vpmB3+0kulbkGxn8V6A8IFKnYHzF0zvHwa
 0E8UZ4C0UXVBqPOzvwM3oD
X-Received: by 2002:a05:6830:3489:b0:7e9:c6fd:c36e with SMTP id
 46e09a7af769-7f1e5ea9deemr15867472a34.3.1786373865604; 
 Mon, 10 Aug 2026 07:57:45 -0700 (PDT)
X-Received: by 2002:a05:6830:3489:b0:7e9:c6fd:c36e with SMTP id
 46e09a7af769-7f1e5ea9deemr15867429a34.3.1786373865044; 
 Mon, 10 Aug 2026 07:57:45 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b806fb3sm7609792a34.25.2026.08.10.07.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:57:44 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Subject: [PATCH v2 0/2] drm/panel: Add BOE DV215FHM-R01 LVDS panel support
Date: Mon, 10 Aug 2026 20:27:28 +0530
Message-Id: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjmeWoC/32NQQ6CMBBFr0Jm7RBaEJWV9zAs2mGQJkCxo42Gc
 HcrB3Dzk/eT//4KwsGxQJOtEDg6cX5OoA8Z0GDmO6PrEoMudF2c1AVthWPsBBcz84idJyR7LEq
 qrNGWIe2WwL17785bm3hw8vThs19E9Wv/2aJChbVRZ9KqJN3XVy+SP15mJD9NeQpot237AqWG1
 Vm5AAAA
X-Change-ID: 20260719-b4-lvds-panel-doc-cb503c4ba2be
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373857; l=1011;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=WVSREEobzWHvkHL2xKDK6zDLqjlIg9d537PhRn/W4mY=;
 b=fD/Yy0lCh+fpDNZscQJmHt2+tXoU2vo73ZfrWkJyRLfoPWGnqzigGr9rl5uPBGs76rEvj01Jq
 vzwnLFtLQ/zC0sjGTPM07epxPs6hWgUwD6V5uXUhvm+dm/02aUspou2
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a79e6ea cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RIij9G7mhg6n9R0jwBoA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: hU-mfV1TwXpB3XnU48cVmdbwNgppS5Eq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfX45tg6Z02HquR
 xYyj9TJjhoKiQaZWsbglYeg6zy48xRlXVRfcsY9F44btxHP3R7/nOPGpw/UCohn8CzcWD6q4mDo
 IKRFTcL0pvd7TALZKBRxp4lkf9C5f9E=
X-Proofpoint-GUID: hU-mfV1TwXpB3XnU48cVmdbwNgppS5Eq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfX66ouDnk3w2s7
 pFbj5JYtz4U5/6Jx+FTOKhYnQQZNxgRxnZq+R+Wo+KuxVBGvL5pz6a0mg0GjssE07QyuC73KIWD
 rLcIDItVILgcCBC/1qOkZNDYfOIbEpRfQZve1XrYf/yLy0mhJWZaAkq0o51vuTWZLWLaOZDsndo
 bo1U6vBGF85IBqNcOEZUCYFbcPIBXIGRNpj12d4wrPthPR5LXMY4wTd5FKgbwfsCIIsIMAt0UAx
 FB1I9bI0snALmbBgHi28FjB1dz5xnv3ukVTXnTr+VY3AfKdhZwU8C3eyeUD+Is85LMdvZeQkAMP
 kdj0gTvqD6JUGY4syN1aolLZ1lVz3M6O1ag3tUhfA3Af8n9Yg2ZKYHTP2ZWb2Fj2F5F6GenJF5w
 P615ExjxepESN+ITsbGGaf6tHw5qCVz73iD1ELMmj9/Cx7JMDApvUnPZ0xYd98KEn5B4mzLBaiq
 HAs1OfbjOLqnZrDRX0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100129
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

This series adds support for the BOE DV215FHM-R01 21.5" FHD
(1920x1080) dual-channel LVDS panel.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v2:
- Move panel support into panel-simple-lvds-dual-ports.yaml [Rob]
- Add  panel timings which were previously added in DT:
  [https://lore.kernel.org/all/20260719-lvds-support-v1-0-1f1aca3213ba@oss.qualcomm.com/]  
- Link to v1: https://lore.kernel.org/r/20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com

---
Vishnu Saini (2):
      drm/panel: simple: Add BOE DV215FHM-R01 panel
      dt-bindings: display: simple: Add boe,dv215fhm-r01 compatible

 .../panel/panel-simple-lvds-dual-ports.yaml        |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
---
base-commit: 104c00917264c5b9571072471e3a8689cd1a2c4d
change-id: 20260719-b4-lvds-panel-doc-cb503c4ba2be

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

