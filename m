Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA81C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FE510E3D5;
	Mon, 17 Aug 2026 04:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6OWgqQo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCPB3txu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F7E10E3D5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCiua855296
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yCIa0tqjHElgbgb0AfTikV7EqDsfsowgkNcvnaxzF5w=; b=J6OWgqQooQ/gjJ0D
 1npGrsLwqRYD4bz7tU/atzjJynju00cIfiTQaAdgo/zq5JN9/fUJQ22Gvrm7X75i
 AV5KCfSxa7db3/LNOM/g8wIJgddB2nP+E0mJos7rvwTZ9ie7GaOVbuT3ghs1GAkc
 0Zu6TxU2vC1PlDJod8bennphPbHGoPz/MBJJ8e8JcepnGZweDGuUDUzocWWARn9Y
 P+p2cI5KqsEcZ8Q9Yajz1XT1oJYg+RMi7ad0FBwKD/UvHDIPWVsiJ2ka8Hk3rpy2
 389MEfu8qcFRpskh1NdNTYmreeV7jIbSmv1r8MzXXDkC2/SnbxIn3Xsacggdda58
 rRQwuQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwn54s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbef1d25500so2982590a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942110; x=1787546910;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yCIa0tqjHElgbgb0AfTikV7EqDsfsowgkNcvnaxzF5w=;
 b=PCPB3txuGT/XYJrhm133To+WfZoBK7ENJpe50AaDypKUupgpvUVy/MaTSBgzqKx541
 AZKmTA1c0JHK54N7SSHA3YllU4AvQIADog3uxQMkXhaYUfdrTTIbz4AeCtOXWgqetby+
 32pVyxUp04r9mZYVXSZVBVwVbyuo9D0z1hJDCYKsQtsl3K7IU7hDluXUX8V9al8jmbTN
 1O4HKGSjovd6xuAJBEQ8cCuHrSNn03m+uHmp67mGmdsQYA7KGKZMSjTM0eN7q91PrdHT
 yXTR8v/Bqhp+LiiFXbffVpCgQ9svvIZPH/J/O523uDM7d+LQa8XULl3egBr8KbCJINa0
 Zuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942110; x=1787546910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCIa0tqjHElgbgb0AfTikV7EqDsfsowgkNcvnaxzF5w=;
 b=BpxivMtt/qJjSJUQPiH83y51S3aJ5GIbxh6ylDhBpHB3C2XQlTWk4v0lMEG3fTw9w2
 uknjlX38FZBeQis+v7JTlQztsESO6BOCo+9yYcCXn+et+5Wj+oaYIa5eU8mkyOmQXpAo
 BMFLojt8EfJmwcVkQQ1xKT2+P4BXzOFnoMOOMjhqCYvXdWdMfl71jx2tB/LB5I+vdB/X
 R/ddk4Nbmb2W6UCQj1yRUO8SzAwJc/t0zOQQnbms+ZaJQKPowHYXsVZVgafOd1TP5yux
 ehN6GCMIXjhvs9kSrWDpAfuSfvgE0+r5duWPH7awavzTtHA8MisoVPgMPKRV2VNOIl1G
 1ddg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGInd/fznbCihV3PegcyuVkv+anGDwFwsKga2qAdBOJ/SZVLGsl6dxMorA5g2XfGhOLK+beUcMlhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxw6mhDR58f9/+51Gua5bRtXPRE7YToQgIk0cQMlJPTx8S4gurc
 gBYEPgVn6c5auFtBeFCUa4f3ubmKFhj1BkULLxUOm0IrOOh7NhZ2Z8N7XKBNuwFNecv2MHrMGv+
 LqRMgeSyJWkukQgZ4NlojljzkGg4tut8slzV4OFXUD+LtJfzz4gbmoXtcTYf6AYaphq2F9RE=
X-Gm-Gg: AR+sD12w+GWJO1l/SFEJASPMpFHIV2JrDU05ThZgHU3F+YvMoAMgGFGFPkX4IarSOUS
 iDGaEKeConOWjJUMbeb/mMpTlqb8PJEnDZW7tH38dASizWq7FaXa/3sOdE5OJ+Jd4g46dMmue5d
 OMZidGurZdXXi5X6MEHes3bJK1ytOy3ZFH2dnmczLz/o+BBd0JT49+sHepfo4oyW0RAKrYkgRbC
 b+25+RLxTyVSykExXssH/LzrUJ42i12FwKn2GhPX+YJkizXumDG8aeQJRYD1rU+nY6Ba7SRadrv
 My3anx0d4JFfl98jd+8Q+DuIDIP8c+xclKp+tnztJCeKLttphnnxN+CpTa4YuPIXD/obbtccbJN
 /qZA5Duo1WJg99rg27Gr6fZ/BMFWeHSpD
X-Received: by 2002:a05:6a00:3cca:b0:848:2c5e:305e with SMTP id
 d2e1a72fcca58-84fddfbf1a9mr22168484b3a.6.1786942110189; 
 Sun, 16 Aug 2026 21:48:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cca:b0:848:2c5e:305e with SMTP id
 d2e1a72fcca58-84fddfbf1a9mr22168441b3a.6.1786942109648; 
 Sun, 16 Aug 2026 21:48:29 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:48:29 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:40 +0530
Subject: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=1398;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=ZCBL1c+Td4SRNnF1oGxWDvquDAKasF3yV4ZUllxnUMQ=;
 b=Ff62ct5FmLcrlR2W0PjFIkBz9F7OfuR0BbENpIURCRwvY/7zltm8SoqrH5Z+oE3RorVE+0N1m
 xMOtTZldlZKDrKhhHfkpJU6wCmrnxMlgi6CSe/Y8KovXD4az5vfrhhD
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: EBlSWvoCcSlvHS5rTLYp5vZp5JEoVM4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX8bIX/HqpYzmC
 IgUSGI9n2MJmqntQV65lNcK6kWCUK3LPRR2K1moPOntbdS3mTDXptyNbC9hKvDfnzyDnK+h6+fd
 BQXRpDGgm7qI6g3TC9uy5dp4/1lzF6IorYt+CUzUgy2oDdDDSuG5YyV5SspynJL0HvFTF96oRbd
 sUCEA7XNMjUgAdgbFMNbVcGmxGnV271Bq3GDgtiAFAkuWP06OLKEjXuDED9aE/2YIOEaA0ES5B/
 pV3nNAzMG5db6jKrQmkOeWW38bQBQFkB8K1DuDl3kPbg9yiHNZBIYnvp81wWFQwHt9aq0lVEN0i
 K8XCkPQOpe7WNxrQDF5ytu0DtyRiQivJHwPvueUPBYlJee8H6uWPhoP24frcaTNhaaGA/nHNtRv
 bCwLg6Fet/R01cp44m3/gaKRbkoYhTWFBVJjTvjrLh5P3BHulJJr5iV8Td3o8510UEDtQjKKbmi
 0L+T3gTeo5RYEoZ/f9Q==
X-Proofpoint-GUID: EBlSWvoCcSlvHS5rTLYp5vZp5JEoVM4V
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a82929e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Spc4k6fihxjec1dDB2sA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX/HceYVgYWseM
 sxOOa6hL7H1nVrX4DVZNI6ntbglyOEAJPQV6i4JRcOjna1EhyU8jUBMaH+VlJymA37h2poy9gO6
 ssKVnOEQnLoiVMR1pF7kjEtRvXwg47o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170033
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

Register the QDA compute context bank bus (qda-compute-cb) with the
IOMMU subsystem by adding it to the iommu_buses[] array.

The QDA driver creates synthetic devices on this bus to represent
IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
so that the DSP memory manager can enforce per-session address space
isolation. Without this registration, the IOMMU subsystem does not
probe CB devices for IOMMU groups and of_dma_configure() in the bus
dma_configure callback has no IOMMU domain to attach to.

Assisted-by: Claude:claude-sonnet-5
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..4c4f7e732773 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -26,6 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/qda_compute_bus.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
 #include <linux/cc_platform.h>
@@ -200,6 +201,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
+	&qda_cb_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

