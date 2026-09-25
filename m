Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00213C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B5410E36C;
	Fri, 25 Sep 2026 15:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTrbhiXu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kj0XOBd7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148DA10E36C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:21 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCxsH81055608
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EwWgdkmodUk
 wOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=; b=RTrbhiXuprnEVvEXgCWrKWWbex9
 R2dTkucVuZzBnUe2kXl8Lru+KAJbJZt3UmL5bMjOmVHV9DUncg9b08tjjSa7QeaF
 Zcjfsj2Zmr+nq78ZOSGeYux5mr1J4exjxqtBGB0Z5MFxsNyYFsVlLUoomocIS8/W
 8zyu5t7eYDSLsLQPJ/8PBBdmeTkSs0x/OTLk2d5xLd1HEeKJI8S9Vc4XB7FrZvRd
 IjNITOrBSM0Lz8HUn4b+no7WADJnIFF0ctwxX2ATacLc61n+tRdi750Hkb6aBHZ2
 UWmv/z38bEWIeIhWoRCRsgTHAleAJcuDW/7kncTEmSI+K9uGwP815oJCcsg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b5tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1eb205d31so1100072a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351900; x=1790956700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwWgdkmodUkwOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=;
 b=Kj0XOBd7XR8ZFCah3cXfmsdjjiDCTJuHKmTgnQf/XxuLRYfYTfG9IjELpzVuuYpC29
 cBYHy8DUQW/tNHA9v6yrarksPvGGRjFnsp3mkFSQkbiTFT5+7HWZ04TG4/Ucii9lkMc1
 soUO/rbU4ZrVEZpb1c8KyzCyOR9NEKFxCNexUMj5HXag7qo6OvrrYMnjb0wYr3AzfCG5
 rm1t2lsQrdNR3TnMW3WPBRgwbBG6W3s2vk+vH1D14ZwVpo4X/ngGLA8if24LTYGYhAtg
 Wbe0mnq30T8FcPXXCdc/tjNjlM3HJ4qEAcI9OqymHKQqUoInNzJuUF8cUTy5z305m7JO
 wwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351900; x=1790956700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwWgdkmodUkwOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=;
 b=M6nwFsRiarKKMRzEFdJUx3O7OXGNhNN/yWYrJZdXxMmAOwpor9u3nt88UqtUBSGtM/
 fZuOuvp1EwuWiZ2YlMDkjnRHR4/8sTy2jKT2ZAmaGeSd25QgMJgwF0zTEVuccqmn8kVO
 NhxB5imVCG3iBlWs2Ih82s5DZ9xQObNxqqEFHCYrxXAdcK+aIESML/0o6ug5ngLdnZ8A
 4Yig1H9jimBOcINABq+6xJPmn2s17nnLWOFSOa+b1FHb6mgNwITOhAi/KKguremL51nb
 P8yUbQl0Uvg8ZJ7n3gMaWu7a/2AYe86T1jvQmsIsBgyYaL1vUK0OQ6CFQA76XzC+7y5i
 Yh0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9YSnJGn//s68gxPi9JH8GU5wk8VHg4qJzeYJ0XxheYbyY8OIrvhAGGkjUsLnykiz0ltDhRy7Uytk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kOhK22M38Qpw6HsJR1Kql9lSl+d4dd/xA1fsGNJVP8s4Oof5xA
 wxiPdrk4onwxa10QF/vZdzygSJZCZMH+Zr0dfpOuC0qDeitC1ucdBSFZDsiqy7Jag8smOIv5WTU
 uiFguMd6mnawFy8D3SEB9pJJhqkwwcUGFYrs7pE31mLmLLsqfI7x4II8/Tu+okTu4qrNXp5s=
X-Gm-Gg: AYBFou1I9bJ1VaZwCeRsoPDbMtwsJ+VqDMJ1DW6EBAaGeyI4QC8iVhaxjmCvcy7Karc
 8w7atUvpN5+e5vIOeZLQdkPXBCrfxoTGdaPNAohX7eBPuh6ZAXSCkaJ9Kaxuz2IAJeV9ufitK5S
 9f4eW3MQPzpzvUJJvGIltr+5H7i1xkMg6mEteOpXBRg8MAVsbZw7mMcPgk0t3PoKTgRi6ha3Iw+
 fEDchQnpo+wEUtVh/CoA7S3rFTwL8fx4cppUwYZASh4ocykHIeg2Mkgv1zU0RqN7aRjwtWI6S/t
 5X1nwB1zjiXfdjqYmeaFNg5e0oKvnQlpuhLoT9tVtPfpkiznsgbaf2bwpvhSNCtsKKrYn6IpkcM
 MNcZVOVJ62ZRHxSd+/avAuZbAAMM=
X-Received: by 2002:a05:6a21:7484:b0:3dd:cc61:c0df with SMTP id
 adf61e73a8af0-3de26c83b92mr2661224637.25.1790351899742; 
 Fri, 25 Sep 2026 08:58:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:7484:b0:3dd:cc61:c0df with SMTP id
 adf61e73a8af0-3de26c83b92mr2661193637.25.1790351899240; 
 Fri, 25 Sep 2026 08:58:19 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:58:15 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 2/8] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:31 +0530
Message-ID: <20260925155737.4161358-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xa0nUG_W8uRtNOv-pELN4tnjOYtC01ze
X-Proofpoint-ORIG-GUID: xa0nUG_W8uRtNOv-pELN4tnjOYtC01ze
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab69a1c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=heNUI75aw_s-mFou8AwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXxQsn2aELmKhx
 cavEHq9ydYISyH8sqaxCxmKjLl68PVl+E/uhGsOImBWX3eHk2PCmjza68Cpudrgnz9C+Ps4Lw5U
 Q0DC4RdAlkWlF8Kx41ouaXvFlE0CN11JRbhWwD5I5JMAEFW7y6vu0JG4rc7oXPx1jS4onjssK3m
 DWl/EGIoS1+QZsNpu0PC3qxggEKswMapYiRDrIrTnDGZokgLZtXf/6nKTiOFW0C5QNx7HgDCy4k
 aOqLUNk17Ye8FNzUGHRwN0htdgSg2jDs3YbGeokQVxkb+eYL8NbLFCovlS01Prttx25gvzV7v8g
 JCao3DWGioct10cSIl+hzlEdEbOusIKopgtY9GPgjDJ5Lkiz+qnKkK3EyGWjbEbniLiXwZznHRS
 Kc8cQwzftFj6S1hIoz/hE04FhzSjbBCb2eNHzX7vBZdOhqMIIfKr8CIuW/6pGu5ZfQkiD67fpRc
 tD5xiKJf3BRrOPKKcgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX1jdYuvEvwREl
 unMuT9aEpumeNXoe5AMVzDw9kJgZBSqJzmhOmnLCTNL0i2PX57EBbMlxHjDOMg8LIVFyvXToWdQ
 k+TM1CR83s+h3lHJBileqCE//mWwxSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063
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

zap_shader_load_mdt() uses qcom_mdt_load() which bundles metadata init,
memory setup, and segment loading but exposes no PAS context, and then
calls qcom_pas_auth_and_reset() which skips the shmbridge prepare step
required before TrustZone authentication.

Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
the same context to qcom_pas_prepare_and_auth_reset().  The -EOPNOTSUPP
handling for targets without zap shader support is preserved.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..d3e843220b73 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
 	const char *signed_fwname = NULL;
+	struct qcom_pas_context *ctx;
 	struct device_node *np;
 	struct resource r;
 	phys_addr_t mem_phys;
 	ssize_t mem_size;
-	void *mem_region = NULL;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
@@ -122,9 +122,9 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	}
 
 	/* Allocate memory for the firmware image */
-	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
-	if (!mem_region) {
-		ret = -ENOMEM;
+	ctx = devm_qcom_pas_context_alloc(dev, pasid, mem_phys, resource_size(&r));
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
 		goto out;
 	}
 
@@ -133,27 +133,25 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	 *
 	 * Note that we could be dealing with two different paths, since
 	 * with upstream linux-firmware it would be in a qcom/ subdir..
-	 * adreno_request_fw() handles this, but qcom_mdt_load() does
+	 * adreno_request_fw() handles this, but qcom_mdt_pas_load() does
 	 * not.  But since we've already gotten through adreno_request_fw()
 	 * we know which of the two cases it is:
 	 */
 	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
-		ret = qcom_mdt_load(dev, fw, fwname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(ctx, fw, fwname, NULL);
 	} else {
 		char *newname;
 
 		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
 
-		ret = qcom_mdt_load(dev, fw, newname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(ctx, fw, newname, NULL);
 		kfree(newname);
 	}
 	if (ret)
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(ctx);
 
 	/*
 	 * If the pas call returns -EOPNOTSUPP we assume that this target
@@ -165,9 +163,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
 
 out:
-	if (mem_region)
-		memunmap(mem_region);
-
 	release_firmware(fw);
 
 	return ret;
-- 
2.55.0

