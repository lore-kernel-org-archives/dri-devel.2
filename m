Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84595606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lDCGc4Da;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D2sSgRiU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48BC112765;
	Fri, 13 Nov 2026 18:54:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9925112761
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRSWv3296060
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1pg51pe/31R
 dnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=; b=lDCGc4DanLItTTOu1ctUWq1jtJ1
 8Mcr4M/OWQsWRK74Oy0WG7wmQlJBJiSAv1+kcfVmGq/eLGeucU3XBnA4u2e8/PJ8
 1udRvJL4lLFj8n6/h43MI0v2u3v7C6IdV7XR4tIXuplhwdVVYWiTMdd/8pcjuRWT
 ucsf0Zj5k6lNsyZ000zx8HCiIczfeMe6KGW0SWvjGx2bqkTXSeTRyeRDRm8qBJUH
 TD11VyNs2XLxm3ag8IYy7VynBWFNiurEX0CJUXS5REBMps9HBhWbn7AdZqR8ckg1
 kA3NBuGaNMX+4JXUFOpX+sSHHEDFf7DY1+NzKNdx8vkDY+OIhBfUB3KWC3g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6tps9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so1305691eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596062; x=1795200862;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pg51pe/31RdnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=;
 b=D2sSgRiUikhZ3kXGZC2LIIAH4Kq+lfJGzT4GVBL/3H3QR+f4ribFLhT/85RFI8oNcA
 T5xJOnLqtEFswVIfpVN5eOHOajZN3WC1IBHY9pVwy7/X/sj2aUHSlacf/F9mP3c/VdFn
 aVzUElIWhnwxVBAsjEhNvRx2oeOEe5W4G6Pv68m42+eLLy5E+EJxZOe6mdgGRLH636pV
 Sf1ZDruDHBHxWvwjS2h9V+IPqDh7+wLoLdrIDRWO0h6pQvjvdBcGsGfY+/4rEAhO2Brk
 471Wf6VF4Q7b0K7WmMVvB8FeWP5qn2BZFGrZ6EkKTVGZXGWVzMarlKb2fnhH3OJyvJZq
 yPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596062; x=1795200862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1pg51pe/31RdnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=;
 b=uCYvH+Yn1KAC2HzX2iztq4gLHRMR8iZNX31wCTU0c/xNXJNXRE/Gn0dRRRGuxJTIA+
 YnbJgKelluuC/AYLgTKemJXk+3mDCrv22uMRquDrWf9UPLUCkusYSYeIPRA1ESrsarrm
 Luw0PbRV1V8iPFGvsip2a4CblZYIXj933desRp0L+WhOK5prR/XDyZjTt0Qtv95o+//H
 WjMU6MMGYDJcJVH4hhXMtReHB2dJh1drIgNEyId1IQyZ4zg9NegmRIpHh54uyTZRuzsC
 ycRscRQBGvH1BSitqGcsQ7EUVIm55/DwuQcs1DGWui20gyoGsEISq7t08af1Bp1PTRss
 t0+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGHqD4xdyxdHWfpFwc/YLhTTtwHvFyFjKHyQ/140dMNyJ/dJqPlaxJyZtSizaW0TwUbGSXLq5XNDMk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZCVdaoHYdWNdvulng6KSHJEdcR2sf+BsoP9NRnk0Cbb4MzrhK
 OP7xDzrdg37LGBB4T+kUKJixmipOI+Ucv4WnSjd5XLoCrZb/vhlPvjXCp38p7H6WVCfiYNQGDim
 wQY3TEBMtfQpDo7J8r8K6TgPI7khSF4K7+7u22DxSDUhVOcOaT/AOULjk3h6VyM11cG3Zrfs=
X-Gm-Gg: AYBFou3B3LHW4P3eLos3cNtafU2VMZYRPv6qAR3RltvDzCf4D5qXNUipCddB1vM7tl1
 YV5hH/ROPfyuSLsuGU/CudJRNXepJi589iCEM8GhxSxGZeig9kLwVzyiX76n97BlBBXLD0zU+Me
 9BVkEWhTmJ4xcyTcQVM5f0ff/8bN9khwl2+Znw1AQt3Mo63Lq5DnQdzkG30UYmwbfvUhuKg3TEd
 p5aIpWYK1fbjDWc5WgKjJCcm/Fe/o/MzGLaDozCES2sLHT3G624ru0SeiweVo8f4dwHJJV/EPC3
 GqSOpiBKOeHg1xsvhLtmx4CRd1HdQ3IxkqEUjvcdTNyLX4viPhOrQ9/eVhG5N1CgeowFnADWbbF
 Gl12FVOEsKp9/IWldt05ctmc7Y5+rMy230r5kvIhiTvemMeMo3DHrwWxZLH2nA16KoJWwN0QFZD
 E=
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id
 5a478bee46e88-37967506841mr2876445eec.29.1794596061509; 
 Fri, 13 Nov 2026 10:54:21 -0800 (PST)
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id
 5a478bee46e88-37967506841mr2876388eec.29.1794596060847; 
 Fri, 13 Nov 2026 10:54:20 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:54:20 -0800 (PST)
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
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH v2 7/9] wifi: ath12k: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:07 +0530
Message-ID: <20261113185009.157893-8-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX9n8vTbyYA2r2
 IPmiXhsMB8vYBy0grDPeEiH2+T0Lpn5Nn0eTCxh5L6sCEX1d4fbnY9nXlxhBSUF2ZGRNWvIbFG2
 QwAVpFa7/aM5Pie2v2m6DletvuAQIoyaQ8iZ40apShZY8o7C/NfsDZUp1jub6MTqQF5m2thi0Ea
 oDvyfYsGLogOQ158jI9zEWaAkqQLntqtm/C+85tOa84bV1vat3DwyzAAUacdUp0omnQhtZDFQrT
 /wgPBZWD+C4nJ3K4bOMLauT/t4C4SgR4TNZphKZAY8ewW3BscQ7QLQObBy8OBb++40PsfpohD3k
 w8Txem925zXw/Q/KFIcZ1OpyzfRI6bR7NrAPC/zlUVrV0mj1Nm7BVOmgKhafLlR/GVXOW+FYmrU
 3ijECMsxvAsup3AZZCHzLJWRR3Y6NyWbS2H3vi+oR6E/6QXW08ilZ9sRqoRIIHyqrOVS7hWYfLN
 SZ+4DfqNFXd0VKBpZZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX/rUME/+YSFHN
 Kn1laW4Ul7my/7OdPlD4ZwrCIR2mQEBxgcyxxveKZDbcPaAyY0+WypuskY9x/RhYSm+Ol7VghCA
 gbziB/dLNjd7W8zDQdIR/WB3cIJ5Jx0=
X-Proofpoint-GUID: NvJgk8GwCH0Z3v_BCPxspbhE5RzexIz9
X-Proofpoint-ORIG-GUID: NvJgk8GwCH0Z3v_BCPxspbhE5RzexIz9
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af75cde cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=tFPd4D2tFowRDCwbfnIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ath12k_ahb_power_up() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context. Later it calls qcom_pas_auth_and_reset() for
TrustZone authentication, which is the intended behaviour. However, a new
qcom_mdt_pas_load() has recently been introduced that works with a PAS
context and can handle everything qcom_mdt_load() provides, along with
additional functionality such as shmbridge creation and retrieving memory
from the shmbridge buffer when the same remote processor needs to run while
Linux runs at EL2.

Replace qcom_mdt_load() with qcom_pas_context_init() +
qcom_mdt_pas_load() and replace qcom_pas_auth_and_reset() with
qcom_pas_prepare_and_auth_reset(), using a stack-allocated struct
qcom_pas_context in ath12k_ahb_power_up(). The non-scm_auth path
retains qcom_mdt_load_no_init() with the caller-provided mem_region.

Apply the same pattern to ath12k_ahb_load_auth_shared_fw() for
consistency.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 8a3919675134..75d3141f968f 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -418,6 +418,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	struct ath12k_ahb_rproc_info *rproc_info = ab_ahb->rproc_info;
 	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
 	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
+	struct qcom_pas_context ctx;
 	struct device *dev = ab->dev;
 	const struct firmware *fw, *fw2;
 	unsigned long time_left;
@@ -451,14 +452,15 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	if (ab_ahb->scm_auth_enabled)
-		ret = qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
-				    rproc_info->mem_phys, rproc_info->mem_size,
-				    NULL);
-	else
+	if (ab_ahb->scm_auth_enabled) {
+		qcom_pas_context_init(&ctx, dev, pasid,
+				      rproc_info->mem_phys, rproc_info->mem_size);
+		ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
+	} else {
 		ret = qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
 					    rproc_info->mem_phys, rproc_info->mem_size,
 					    NULL);
+	}
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -492,7 +494,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 
 	if (ab_ahb->scm_auth_enabled) {
 		/* Authenticate FW image using peripheral ID */
-		ret = qcom_pas_auth_and_reset(pasid);
+		ret = qcom_pas_prepare_and_auth_reset(&ctx);
 		if (ret) {
 			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
 			goto err_fw2;
@@ -1056,6 +1058,7 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 					  struct ath12k_ahb_rproc_info *rproc_info,
 					  const char *fw_name, u32 pasid)
 {
+	struct qcom_pas_context ctx;
 	int ret;
 
 	const struct firmware *fw __free(firmware) = NULL;
@@ -1074,14 +1077,16 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_name,
 		   fw->size);
 
-	ret = qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_region,
-			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
+	qcom_pas_context_init(&ctx, ab->dev, pasid,
+			      rproc_info->mem_phys, rproc_info->mem_size);
+
+	ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
 	if (ret) {
 		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(&ctx);
 	if (ret)
 		ath12k_err(ab, "failed to authenticate and boot shared firmware: %d\n",
 			   ret);
-- 
2.55.0

