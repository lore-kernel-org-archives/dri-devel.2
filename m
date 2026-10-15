Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1058CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14942112125;
	Thu, 15 Oct 2026 07:40:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD78112128
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:43 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xdHO2738735
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=; b=SIdTD/9Q1pJ7cRvT
 Ep5lZJ9TJoyJw65D5IM01kpMOplvmPeoPV+ixOSMXq6ROKKRAy6tpjON4a/BTQvh
 u2cnjPDWlEtH82VVQ1LHSmeYGj8yo8HJgZw5q5wSWMO1e/xNmmTbGQ/uZrG1Kqza
 VZFjusIq/Wzouc72g0bnJOApxNcMOJHRwQ83h0pdHv3Ud6MCjTupBxs164wMNfyp
 mg5aYtQmgOsfpmi2CY00Q+G8/hkvkaKqI/dT2VwNgEKup05JrbejAbp/LO61AJ6Q
 DtWAP9djkYOU6GyhQs5EIc8wT/KCK/85avZ7rzZEuSNAu1tuBH/DQ5YIo1a4KEKh
 O/ZLsQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds8s52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1130814a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792050042; x=1792654842;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=;
 b=M7XEGOvnjiSUJRKfJCjyDTgI+44kJL0T+3YYhmy2NemkNJ9WIy03GMIyqA8cKB/xFL
 RnwqKtkpJVvMFZsbjcZB0bgj9ElcPoRhWZ/q6yhJUZiTm+/Ibeixm8GdBLB9m93g2i7y
 7k6tOrGss0MKUARsr/ZiOl4PMI/zdpTaJ4s40AqbTi90Zi7ODUO32ZePyhGZa0DUYu7H
 QZb6gp3LWrh57WK++nOmBl1uZWBSUqwumvi2nH1SsTr8wHouNbk48o7gRb6dJCKSNPue
 th21l9V3HNkksVkiMZHhk4+6gE8QV/SYItdeqNTRY7SZRD8+8/t+7buvGbGTyLBulZWG
 VJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050042; x=1792654842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=;
 b=gFHRUdMvvKjuTlv8NJ/vfb+uS+nvKDKurn+fCn4Jdqm2X+PtnOWLWJWuEvy/H/0aeC
 uvQMQnXqudyKx49F6cLf99ESDQv3C7/YFmfnMe2525ZZnoWKnICZsGXvl/1F2ywWARql
 vyCrShfj6mJu3/oT7LtU3qRoKCehEDaE01Xx/ZTXx7962HDvdMtxYJOpFxI1WD2+y5Pw
 YUtm0lvti/sEs0WLkmt31TKJhfO5NW6NEw8B3yRwGao51rcnBGGrexMPJBw3LsBPwygy
 dBJVseqyUeKXNE4MWwSyV5/NeZCciKnCn+MhduuQnUxFW4CsGqrulrnVVZEbCA6+iReW
 P2vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAZiYFGto2gjs/GkyOLquEcHcL1J2GMmwnqRVhdLXj+e2Lkr3kxoPDLEfmzB1pz16mnM+Vl1iuQM4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ0/s882UsNHbuUigG2HhPtViD3UjJwntNE/qprgwuFmKK2XC5A
 ILRKACg/FAa4SM1RYP/bNqhaGJ2TQWPTcTzab5gfCRn7+5aE20/vO0NAZCRQmq/VZzA8lVr1mf2
 0JfckZsr10SqAc0Ax4vZWGraFxxna8jkmWwvVCC5WY9wYDI2h9cUkvWHuPGps2grwLGtypFZ0cY
 LlJXs=
X-Gm-Gg: AYBFou0LWeT1wRl3NrN9cw3th5FThCWIZayw0hObNL+UvGNIj+gxOwAMhKhRnYtJEm5
 g8j2uk9pjaHpIhAgXrrdTNIa8D18/N3HM+OqKKjlO/G5yA42h6ggEt++2cDCI7vtzV5pHaYeJBD
 QCO+z+T8fbDWzgAIK49r1SoSsmiQeZeh5s1rFLqmgDApL8sMHKUQrE+GHUe2vLs6Jxod7Woy7cM
 F2M4CMCkLE1oEodjjibjiyFz1fj6mmNsbkpz5Bb+CUpACtaXZ4BkRdZmYuA6EFJDXe0QO2p8il0
 2UXIfRQtrcwLFm3mg1HDqshJhQ5pBEX6WKhehjqsVhC6IzJCacc9yWczQUAIveWlw5PunI5kHW/
 RHVa38dWlKQ4yWRgRE3VHnHX6LnW3G6d5Mxk=
X-Received: by 2002:a17:90b:2d88:b0:3ab:e789:ce88 with SMTP id
 98e67ed59e1d1-3abe789dfbbmr10015455a91.65.1792050041531; 
 Thu, 15 Oct 2026 00:40:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2d88:b0:3ab:e789:ce88 with SMTP id
 98e67ed59e1d1-3abe789dfbbmr10015411a91.65.1792050041033; 
 Thu, 15 Oct 2026 00:40:41 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:40:40 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:31 +0530
Subject: [PATCH 11/13] drm/msm: Support KMS backends without a display IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-11-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=1124;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=pTPCAX8/CsBLoyOLjrC5Lj6V4R1as0wD8+LPwQqJmJ0=;
 b=bpN+2azNrend/0/v4WZOz4wDoLmEO8sJ90IY/xsoZK4QTV78nMaroxlzAY8V/oq+gXHAmu18l
 9Tt1n5goJYjCSa0YqzJqvqdZna5CUksVpN7ANJ0NieJo5BBw41WGD38
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: 7YDcCquHroBEOZ4k6hjzdNCXsLRZFGlq
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0837a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXx8qizyuHQyRY
 TwWwWuZT6mT9ndKVZXDGPJBm33Ry+C/EroxgK/iIVT2rUGqwlPF2ZRlIDZrVAuTsbqbF6qfkKY9
 9jDdGf8Kx+5tQjp2BeiPS1LhXeriQmWF89IxrK63zSCffAo3LVWkBS06AyEJYVykpPem1ETYvuq
 I05jjiuHgwYN7Zn6j1jOtWI+NR1z8dQGWO1+mpUDmwyowF7Jj0RThMh4QPz5KmlG1LsNiGN2cfd
 b+fI8vlvfiKeF8k+TiR1jd/A9ElJRCc0aMw4Z7vZa5CSjEwyKzKx027Y5RGPZZ5S8MnvS13iKXL
 RN9vrvbWWumL8mv3cSukyQCl3Ujqk6Hoza+iSUvPWqZJjfAETSH65dqOVuBfOtmnlrgiizOvz67
 fUD+CCejmdawLG+GWpFAk/wHPWyfuvLxbfV1rK5I0g3Yl6Ntvrvqu0MaQuET8NAvzb3AcexMYOM
 pD0YJwt/zE4Vd4bmL+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX9cZW8ea+iwVL
 0h2aeA6Xp7+REq8x1uEh7eEhJKqhnHY8k/vh5o82ltDJzZ0PQFVClf9ybj8uiiUjdRA90MWlahD
 /FrAr9zVMFAXaOBdM7wa32et/qrjxOY=
X-Proofpoint-GUID: 7YDcCquHroBEOZ4k6hjzdNCXsLRZFGlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030
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

Some MSM KMS backends receive display events through firmware or
another transport and therefore have no host-visible display interrupt.
Rejecting such a backend during common KMS initialization prevents
it from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/msm_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..1870a7008ead 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -72,7 +72,7 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+		return 0;
 
 	msm_irq_preinstall(dev);
 

-- 
2.43.0

