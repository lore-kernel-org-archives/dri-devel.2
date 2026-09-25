Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64156C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE62210FB82;
	Fri, 25 Sep 2026 15:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Je5YtJ+Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqCzEwyz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED0410FB66
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDkRQT3628372
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p+LQPvJJTeU
 1GNlByxbclHTDDGT157UOusSi7k44uBE=; b=Je5YtJ+ZLvxiFAY66mMnDfFDIQN
 R9qeiE+x6COa9tg25fml5sOLY1QiFg24hhrXIruKfUNtaKbitUT6no5g0XOTJOcB
 EFcm6/LaLj3XVn595RsvDa/Afmkmw68JlIvx53aBg9smhjQ92PhP5ZTV6tDmqr99
 21njqzbQ9k/Lpvo5QnrpunBoc4FaTYMtv0zGxTJl/RiTfBOjIsMnWiACLxLUeF8L
 wbVas0Rf/I5utcdI3brpB6B+TY5M/+QWQJCNYcAjE3hu/A+sNeN/qyXRM36f8aVe
 LKgfdh8K5Ks0+olNeJw6im3zs54wUQhAvbbMJ93Gght8pmCmfSMFmLMgNHA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3a3un-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:59:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8663802b58fso803205b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351942; x=1790956742;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p+LQPvJJTeU1GNlByxbclHTDDGT157UOusSi7k44uBE=;
 b=GqCzEwyzvznPqMAa8FRn7COUxgtOfDZ6VMoeCaOUB6ayZQ+9CDb5k6iNRLwae/GW31
 WAXAqCS5Al6V21ne3lMZelScJsruUUdH0KmhMy+47I0KxF37MG998DA2mxMkTMLjPFQx
 on/C53z3JwxCTl+advExFOk9bGmlaAqGzBEgRejti8NuOlFAfNCCCALw4z4iOJTIbe5b
 CURuiOPQs8lzYzhYlS/ZE9L/CJfPukcUTS68SJzH/rIr47k+P2loQt9BYUfqeOEtST16
 TZ5h4eRXne9XuoYCgjU5J5OCTk7U9HFQhayTGxci20IV7WQVuU9ZaabxTzoAQBXbUf2R
 E8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351942; x=1790956742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p+LQPvJJTeU1GNlByxbclHTDDGT157UOusSi7k44uBE=;
 b=sMmn5WOXHcoGeE9Y10hn6uguXn9KBNdUqgTaleVjA3/ls5rjF+f/2blClgGFW5kwwV
 gNXsG9cA3VsumQpv2h6eB+pmbUkXA51Nst2Kyhf2TY5ZvQSleAdq+e4gCPjVyzD0RMnH
 ZWxak0ekEVu/UTnUjnRDqpmBsQggNF8jqGMgVQ6NBk+GiHykMwhTF/u4epZ8F5Amk0xv
 CEzNyeAInAxkAsxhB8hlt3CyFu1qAByGW3uTIyQJcQDURT/wN6nKJFZpNLAedST0Po9/
 BVauEwTeHO4ngcRo4b9oOdN5+aQ7HIOOplPFZLEfJ3IJ5HY2sFshDGwJiep6xHeNgBxm
 2C7w==
X-Forwarded-Encrypted: i=1;
 AKwUvByL+61Sdx10PBrw9RvBUCad4GtG4PFb7GYI+cnL/+rwo8TYW8quP0k4Gtg0m8zniFnWN9zoG8C3ZTY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mno8PMJr50A31dFODqi4dSZIf3wVYe/WVnHGN2EbaIr6zMAi8Q
 +N4aYpP0HArLFQs0tWQoNemMfzmZx82HrwlpnuqCJGB/Hulzz1f2AQvXtbJa1YjigJBulCVFa7w
 lzd1zBcxXz2GSyh+KcdOFzLVLqHsfShhJlUBr38Y4frJUUcGpkbeGGz4qtL+is4bmTGtuta0=
X-Gm-Gg: AYBFou04ELqt1XPZZMCTy32eYIzyELDDIwrBVhE96Gs/SJsBlabi1NH+bybIco2D0qa
 azq4ZnPjbk+ZeWjDVBmOTIZquR1bljUCMhA+ldY4lcc++Qte8Ba5UN7CGsRWGLiIIDnEQUBkKbe
 5x2sLSCk4Tbm2RlLJ4PRBfOAQYM0sHAn0qKNcQiK3vf+EnS2pFoSg4RJwysOEsQPxjdlfkmphjC
 Slb4/XS7esxSiKlsfv28xjIgGmzYCOuKHsISSBCE5D1jDvueI1sKeqtK7x6U8vPpbL4lEe4e4T/
 zIexNw+hfLbwWgLTIJQgqvKBzKeOYdRP/jPlgRDN0B78TD74KyIs5lI5JG7IBNm7HnWBkSfPGDU
 3V6rReDlY4JHvmwGfTNbr4WoJkS0=
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f640 with SMTP id
 d2e1a72fcca58-87e9b89660dmr4973913b3a.34.1790351942090; 
 Fri, 25 Sep 2026 08:59:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f640 with SMTP id
 d2e1a72fcca58-87e9b89660dmr4973873b3a.34.1790351941480; 
 Fri, 25 Sep 2026 08:59:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:59:00 -0700 (PDT)
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
Subject: [PATCH 6/8] wifi: ath12k: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:35 +0530
Message-ID: <20260925155737.4161358-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX9BhMqsy9N6k+
 d+6bK/wL8zQpMOt09NU2L7NXRWq30v6HWjQ4weFjmQRprOHAqUY/nSkD81QMAZfwpLn5+IhiD1X
 olX/uahQQtn6+VCikHKi3jJmk7f39T4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX/D5CIAJ0rbIV
 hNI+OG7FnXEKqZdwBmrsmeZdUqz0ehIXsfrPSe7uM2YMo78YgeTl9MqXI13H9pIbHBy4zwt013D
 joYEpAux+D2B6qMNpCSf0remPZeWDlBNOwXIy+erERrCEMskOfP8rACMI2ZpmuayPE7kOQHq4fs
 TRln3JiuO7JP+CUb7tvGGWACl2o4MFYnRizLixYAr/05dJnC+NFpMpCQLEIIVWIkclpEProgvme
 T0f4gOXzgAj+8b3UZQGg0CW8WpjnoMM/jO2mgUjsoMElR+StuY7Gd1jIqjBiNFn9lZ3Axd9JVXf
 K6fdGSh06pMOTlo7k/f7omKS29D9IWoiuJ9W3Cy470MKtAO3TDW4phbyaWLY4jVworTjAQFARml
 kTIJEBwC8otYuMRZwmcLqd5Ha11cikoLkyPVeBTmdAJ8G1ZelKWvNwPcHmiOmkPKssrK1Cy0oqy
 g7uf4/upa9Z87afrSWw==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab69a47 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=MUQpB1KlM5cd8qnWRq8A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 0fvSRKf8jIWKRE9cp6vgGodeGiHK8U_2
X-Proofpoint-ORIG-GUID: 0fvSRKf8jIWKRE9cp6vgGodeGiHK8U_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063
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

ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw() call
qcom_mdt_load() for SCM-authenticated paths and then
qcom_pas_auth_and_reset() which skips the shmbridge prepare step
required before TrustZone authentication.

Replace `qcom_mdt_load()` with `devm_qcom_pas_context_alloc()` and
`qcom_mdt_pas_load()` in both call sites. In `ath12k_ahb_power_up()` the
PAS context was allocated inside the first `scm_auth_enabled` block; hoist
it to function scope so it remains visible at the authentication step in
the second `scm_auth_enabled` block, then replace
`qcom_pas_auth_and_reset()` with `qcom_pas_prepare_and_auth_reset()`.

The non-SCM-authenticated fw2 path and no-auth path retain their existing
qcom_mdt_load_no_init() calls with the persistent mem_region mapping.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 85360365aa4b..6f0ad29a83f8 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -391,6 +391,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	struct ath12k_ahb_rproc_info *rproc_info = ab_ahb->rproc_info;
 	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
 	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
+	struct qcom_pas_context *ctx = NULL;
 	struct device *dev = ab->dev;
 	const struct firmware *fw, *fw2;
 	unsigned long time_left;
@@ -424,14 +425,20 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	if (ab_ahb->scm_auth_enabled)
-		ret = qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
-				    rproc_info->mem_phys, rproc_info->mem_size,
-				    NULL);
-	else
+	if (ab_ahb->scm_auth_enabled) {
+		ctx = devm_qcom_pas_context_alloc(dev, pasid,
+						  rproc_info->mem_phys,
+						  rproc_info->mem_size);
+		if (IS_ERR(ctx)) {
+			ret = PTR_ERR(ctx);
+			goto err_fw;
+		}
+		ret = qcom_mdt_pas_load(ctx, fw, fw_name, NULL);
+	} else {
 		ret = qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
 					    rproc_info->mem_phys, rproc_info->mem_size,
 					    NULL);
+	}
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -465,7 +472,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 
 	if (ab_ahb->scm_auth_enabled) {
 		/* Authenticate FW image using peripheral ID */
-		ret = qcom_pas_auth_and_reset(pasid);
+		ret = qcom_pas_prepare_and_auth_reset(ctx);
 		if (ret) {
 			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
 			goto err_fw2;
@@ -994,6 +1001,7 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 					  struct ath12k_ahb_rproc_info *rproc_info,
 					  const char *fw_name, u32 pasid)
 {
+	struct qcom_pas_context *ctx;
 	int ret;
 
 	const struct firmware *fw __free(firmware) = NULL;
@@ -1012,14 +1020,19 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_name,
 		   fw->size);
 
-	ret = qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_region,
-			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
+	ctx = devm_qcom_pas_context_alloc(ab->dev, pasid,
+					  rproc_info->mem_phys,
+					  rproc_info->mem_size);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = qcom_mdt_pas_load(ctx, fw, fw_name, NULL);
 	if (ret) {
 		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(ctx);
 	if (ret)
 		ath12k_err(ab, "failed to authenticate and boot shared firmware: %d\n",
 			   ret);
-- 
2.55.0

