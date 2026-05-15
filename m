Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF476CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 20:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CC210E251;
	Fri, 15 May 2026 20:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jm5zPgAj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIInxc6D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B44310E251
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJeqml3066902
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /na9U7CFhr7n8Z29qnWp4dlEpUEJzoqhKfGCJnPabJU=; b=jm5zPgAj7jDzpVI9
 r1gVm7Tg5yJnwK6qab0157oQyr/Bgv7mSV1ff+v4JDNj6QvBzMamyxyXzT2YHZu6
 oaVoDLUlMNnaz7Yf/M2CUZIuzt28FG6fRpXYigTi3whXgDzmiW3imdLZaP4RkM2+
 Fi64Yf4Bn+EBHqOhRvr3KDnmJKeAscbh0G8TIf6kNWksgySuLEUmz/Bus9QRo0Qw
 7B6qwD+UTeqnq1KXI/l7hi269mINPztCPQ/56NFQg9BmdCam8G1MI3Tdbkqqh8B4
 2JlkhyvcHjrrZk9TnGbrgnWFliUXtIEpGSe2t95wFghVy3akosY/xCXm2QcsSQWj
 GByrOg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67bernqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365faf6006dso119174a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778875696; x=1779480496;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/na9U7CFhr7n8Z29qnWp4dlEpUEJzoqhKfGCJnPabJU=;
 b=CIInxc6DAAGHts74Q5EnH+GEkSQNMR5ueKdmrv2HemWcUV9W8XJ6L+Swmkn0HGObi1
 YHmMqYqcOkcPFMj8//zb06QITtGWrCWmlDIFGeSJR7qnuK1LEmlWPx8hTidr+3ev0DRA
 BCQoeZ1v0G2Z5Kx3r6XKa31fXytLJ6rTv5OKZL4tXv7exRVWcGHExeAGv1VteYaIg962
 /+//qdKKqwEaZpar23WS6MuTPJ59KfuzviM3LJ2JZM5Ny7RzVj8dt5Za5KpMz9tvhU5E
 RMKvivesN6s65mPSNkopPi7hWZL9JzbdGQFvcxiRknw9AbPfnPVZlo6pRy9xzOL8zYMa
 nX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778875696; x=1779480496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/na9U7CFhr7n8Z29qnWp4dlEpUEJzoqhKfGCJnPabJU=;
 b=jnclDnsoDPUMUm86O/juERjTEsKknWCd9+/cv94RzejLj4NmFwuG+TaVzobh8IcLkl
 t5XACtgWUIRX4NHCCd/XpcvqY9oS9vYAGQOrdFmgFOyAHMbc+LAvTZdR92gUZFx+w1dA
 bt9y82pjOs84Oipuysj5sNJ0I58Tjn/1sAVlQYrFQiMsq0BCu7MXpb0j9c4hwOtC++RN
 XeQjBa2uR1WCljtQ2RePUEX8g6jpFeXSBmaGj7JSKbO97rNehFlQCPU4vq63opIShPJj
 mezIqIsGTn5QI/VsrdGyWnrZHZj1CmzSyoWteNBie3ikyFtVlQDl8OFnaBFM5cPxTGEc
 JFPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AFNGSTHWEGJJn5Wmx02ouXXwCpkSa3juXDpboYcmY/chlB0OkxzghZX64CGwAcyTJPMjzEkE//VU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQxXUGC4hdnkrHMpucZvxvkp3hYoe4tMcRU66n51i4W62k0wLJ
 wDgtQyCPrPOnll2N3uzbBPGzIDWoXrR2nlN7pRMC6vlF1d57i/RYV1TqJpELlorUlVUtEO7aFHQ
 Mx7iycabrmbsgEbt5igrmykpa8dL3dBdpv0V5laW8Yw5e+TUTUKJUrsWUkiQtIjO+I+IvWCk=
X-Gm-Gg: Acq92OF+KnimH83scd5QEUw2itu5qQ119qGpHn5eQVVgVhkf59ka7q+ampvi46aXeOA
 vBn6Tc10t0/OVSkgDraT/Xmd11uo5z77RFYNoVmVbpIzspqDewbmxEeSB7m35gxuCUs2crU6e96
 4Xa461parwcYWsJ178Djjesu3sbwGFAGPhll2mrISQDEyRmu8Iqm2YkvKXB496fWIMPaOfbPIhW
 skjvy1uz6L1sqJlvKdXU2oDkHImb2LFTXMNhD7UB1nA6pVHVA1xFsqk8MIGv5QjSSXqCYVPxcYB
 6ouxS1PTH9SJCDdnVuUbeScsqvDH57edK029D1dogBXZ2TCp13uS5q81SGS9boYRLzdLkC4mhgA
 NQwowCT6qekM4Z8pnzuD7Dw5XlHHLHbHC/SwWC1BapKl4Hw==
X-Received: by 2002:a17:90b:3b8c:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-36951ca09a3mr5628789a91.20.1778875696243; 
 Fri, 15 May 2026 13:08:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8c:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-36951ca09a3mr5628750a91.20.1778875695658; 
 Fri, 15 May 2026 13:08:15 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517a820fsm3518309a91.10.2026.05.15.13.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:08:15 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 16 May 2026 01:37:49 +0530
Subject: [PATCH 1/3] drm/msm/a6xx: Add HFI support for CLX feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-a8xx-clx-support-v1-1-62508bf651ac@oss.qualcomm.com>
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778875686; l=4084;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=FF4ikNxmqKbxzeVlDwEnNmtDy9ypLTHAu+k2VdryIes=;
 b=/U0PEHRRvS/YBsEe1rUn414dQRYpv8WjixpJ3vuKmGyGzo7UuqFiDqJ36atmIW1er/LgvBWje
 d6u0mOvlBKLDcN3mdGNIBoFTGRMht32I/GQUMVIF8bpnSb9/WUQSasw
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: Ju1NZbr5HsC3GhLe4dkbwA6RCc-KYnIb
X-Proofpoint-ORIG-GUID: Ju1NZbr5HsC3GhLe4dkbwA6RCc-KYnIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwMyBTYWx0ZWRfX7M2zi20VJPV3
 K3mklUXFbBHC44t395ZthKE49g5zYqrofF3iNzpJV11C3XGTjtIJtWsEN3fbhy90Qhfs1N8OJIe
 ZOPAqyGM/MP4aEJRnVlNHFzUVDvhK57RrH108LRWxnhBcTZkxv2PSucuvl2IvEFa+p4ND2qSo1A
 2FDZX2ulSEnNwfMGJpqWuTyeIWWTCD2uQ5WOinTJpnG30QahHqpgXlf7wYvAekPiAAMEkEaFqEO
 2rI52tkYSQ1iuv0itfVWqBd1JDL7t9ABm3K7Vu1UbN8t1+UCmxdBA2GWqegMv+Q19OXVssmkITN
 IfBDSmeWETE9U8KiAmqOBiOSVXBu1MlyRuEPWjMomLy9QQcOKGHBWG44lPfG2F1Ncy+r/VUrMWg
 rI111sJfn5zccMRgqp3AhdzDiUbZMl9QLkbMq7Oavy/huz0R8PetNZokJMGLnSaSwm106sZokwa
 hAzJ5N83m2DeEkxoURw==
X-Authority-Analysis: v=2.4 cv=IrUutr/g c=1 sm=1 tr=0 ts=6a077d31 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5Q0fzsgIy9hxAR0mj0wA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150203
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

Add support for Current Limit Extension (CLX) feature found on a few A8x
GPUs. This feature is required to limit the peak current consumption to
avoid HW spec violation on GX/MX rails.

Add the necessary HFI interface support to pass the recommended CLX and
IFF/PCLX limits tables to the GMU. Per-GPU configuration is consumed
from the catalog entries.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 15 ++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 71 +++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eb431e5e00b1..f6a3f1924bb3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -34,6 +34,19 @@ struct cpu_gpu_lock {
 	uint64_t regs[62];
 };
 
+struct a6xx_limits_tbl {
+	/** @tbl: List of limits table **/
+	struct a6xx_hfi_limits_tbl *tbl;
+	/** @count: Number of entries in the list **/
+	u32 count;
+};
+
+#define DECLARE_ADRENO_LIMITS_TABLE(name)	\
+static const struct a6xx_limits_tbl name = {	\
+	.tbl = name ## _tbl,			\
+	.count = ARRAY_SIZE(name ## _tbl),	\
+}
+
 /**
  * struct a6xx_info - a6xx specific information from device table
  *
@@ -54,6 +67,8 @@ struct a6xx_info {
 	u32 gmu_cgc_mode;
 	u32 prim_fifo_threshold;
 	const struct a6xx_bcm *bcms;
+	const struct a6xx_hfi_clx_table_v2_cmd *clx_tbl;
+	const struct a6xx_limits_tbl *limits_tbl;
 };
 
 struct a6xx_gpu {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 487c2736f2b3..13ae34d0d898 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -886,6 +886,73 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
 	return 0;
 }
 
+static int a6xx_hfi_enable_iff_pclx(struct a6xx_gmu *gmu, const struct a6xx_limits_tbl *limits)
+{
+	struct a6xx_hfi_table_entry *entry;
+	struct a6xx_hfi_table *tbl;
+	size_t entry_size;
+	size_t size;
+	int ret;
+
+	if (!limits)
+		return 0;
+
+	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFF_PCLX, 1, 0);
+	if (ret) {
+		DRM_DEV_ERROR(gmu->dev, "Unable to enable IFF PCLX (%d)\n", ret);
+		return ret;
+	}
+
+	entry_size = limits->count * sizeof(struct a6xx_hfi_limits_tbl);
+	size = sizeof(*tbl) + sizeof(*entry) + entry_size;
+
+	tbl = kzalloc(size, GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+
+	tbl->type = HFI_TABLE_LIMITS_MIT;
+	entry = &tbl->entry[0];
+	entry->count = limits->count;
+	entry->stride = sizeof(struct a6xx_hfi_limits_tbl) >> 2;
+
+	memcpy(entry->data, limits->tbl, entry_size);
+
+	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_TABLE, tbl, size, NULL, 0);
+	if (ret)
+		DRM_DEV_ERROR(gmu->dev, "Unable to send PCLX table (%d)\n", ret);
+
+	kfree(tbl);
+	return ret;
+}
+
+static int a6xx_hfi_enable_clx(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
+	struct a6xx_hfi_clx_table_v2_cmd cmd = { 0 };
+	int ret;
+
+	if (!info->clx_tbl)
+		return 0;
+
+	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_CLX, 1, 0);
+	if (ret) {
+		DRM_DEV_ERROR(gmu->dev, "Unable to enable CLX (%d)\n", ret);
+		return ret;
+	}
+
+	memcpy(&cmd, info->clx_tbl, sizeof(cmd));
+
+	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_CLX_TBL, &cmd, sizeof(cmd), NULL, 0);
+	if (ret) {
+		DRM_DEV_ERROR(gmu->dev, "Unable to send CLX table (%d)\n", ret);
+		return ret;
+	}
+
+	return a6xx_hfi_enable_iff_pclx(gmu, info->limits_tbl);
+}
+
 static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
 {
 	struct a6xx_hfi_msg_test msg = { 0 };
@@ -987,6 +1054,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 	if (ret)
 		return ret;
 
+	ret = a6xx_hfi_enable_clx(gmu);
+	if (ret)
+		return ret;
+
 	ret = a6xx_hfi_enable_ifpc(gmu);
 	if (ret)
 		return ret;

-- 
2.51.0

