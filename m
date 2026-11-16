Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8B606A89D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ImKUP3Xz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5eEYvIW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7794210F277;
	Mon, 16 Nov 2026 16:22:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C6610EA52
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGK70w3692982
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7/5IBT6uyH8
 wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=; b=ImKUP3XzzkcWGQBIHDld29kSpW1
 3G0uJ7xw4IKj6KnrhZDSfB9JFndd77V8uovcWSGwnRjYp6meXxZoJBI50ayEkCIh
 I330kLlI+/Ar3WA9eAymEYIX5A/kqaKYXMhTce83OnuGUbV62i7e5GZ7CKjqm7aK
 QF8Pn+N1ZojmqzzYyrfv/WTtBipZJUibUu/LVq72U5a0PnScjI1uzPbuh7NmL4o9
 B8ItKnCP9ocyMAghENDK6IwB1R6i4ADTkilLUnXEeH+jN+LYIeIb2Lc6KproX9NV
 2VR/aeYO4AzSy0m95rDre8ROZELsYzIzCRFwC+uWejLqZtliMUhFFFdJEew==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f81094-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so2108418eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846164; x=1795450964;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/5IBT6uyH8wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=;
 b=I5eEYvIW+6dcYRFlsCZBASyDZGputVBZvHb2BvgHOR4XCTFO9EahLkxWHpZP7KKZMS
 98pc4kpRWbnzuKRLG68ffOKzoqXKf876atM6N5dQQE16d/isZtQvxtpgnA4QcvJJZ6Fi
 RAgLjp+7b7caF8Q3E1X8SxFvxNWaP+Sr7rDS//KBoPuJmXTubTi4wB69D5tPLy5444b3
 wIkUMGuQH3U7WOQmK5w8hjHDd2WxHr33UpLd5+cmfxGnVI9Z2Sv67pi9OIlQ5Cdq7iXp
 psVKrVIY3/kJ3sceL0Z4Tuorb9k9obqo+6KfxL/nuiMiMoMaruqJwGruSd7mPai4d5jo
 gz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846164; x=1795450964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/5IBT6uyH8wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=;
 b=yUkIwBREP646OmcMjplk7p7CZJWR8KsZBdgIv+PmsGufnhkPsqtjmkpLKhLx4xXHHV
 Z0UxKFe8H+wVSRwiOE5kRvDNa5JLSVK4MY80emZ77RmwPoA+rCuOSJavcmekxh9UPP95
 gUeMJRNzBJGeIU3/O0/VEUM6IL9hwBJ7D8yCLTrYPxbaARtU54suvIuFjaoECiv7LMV0
 qjruD5A2PQmrk33gdkDSkaP5fj94kYg6vfXIiz2js2BpkdcddnKC5ijx0fGZ+nYLOcA7
 e6tLCJGk/rGSH0hBcDfcVqItgmnN79yBvf3pmwS5tNMgtqw4oLwOVtj6++av1GsCyNGm
 Chow==
X-Forwarded-Encrypted: i=1;
 AL+hErF7yRtix0765U0bVYUatXKdIE7EtoP3yU/kQCoQqB9VLqEEOYZsYkJKiIbilqsSDmRgurCyHBFP70Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/CCt8LDvFl6+ygWznSD1pHzcGLvdXFfGUbW6jeS17hc32NV9ti
 JqKmx3NFKC+XoYNhZ0Ygpk21UleDuHGWxi3yAp9Ts9JaFOpKtIdsyXEGRks+zzlaaKpct/ILza0
 r22lpSjjGyiR50LZnP4vJVeHFoq2XgvPoGOjnKAivkTw5K9nrH03LJqRdaTkGef1e492bHsA=
X-Gm-Gg: AYBFou1uw0aQr2ytq47mIDmavbSIojYwnXMUvl0QvHMHBu/21L9NobT6Qg9AQU897Y8
 fQvDkRQAPIp/NHuALY6NnAdi1FxJifpCWdF8vFdpE+NnVYq/+BT9vMsh2IFrCDDisH7GbehgdNZ
 4/vpGmmFT0BVSvOg8zads++Nj33W2w5OF5EzWAn0kueYef4c3lBOwoXx+mnm9DfbifcXSWaHQyl
 ixAJCtqnyRfDJOzvs8VBacFwL63H5yQCAdiAgDy8nLVX/LXI4rxCadKV3GTDzMhPU56uy5+02rS
 nPuoZM9Q6yBH1inIGnJvFxRcwhkrgfBQWBWAqpJGANaDx/Godm1lgMnwOsUyRFdPZRh78HbQE9l
 5xveFdHaUMgaZA02e8og6XVDQ6/zqEl2eBr4ryF6wyY5NUOKMiNtRBi7Hw9Uk1/lyiE1CW5YXM+
 Vg
X-Received: by 2002:a05:7022:2594:b0:1b4:caae:3324 with SMTP id
 a92af1059eb24-1b5030ad1d8mr12473133c88.21.1794846163636; 
 Mon, 16 Nov 2026 08:22:43 -0800 (PST)
X-Received: by 2002:a05:7022:2594:b0:1b4:caae:3324 with SMTP id
 a92af1059eb24-1b5030ad1d8mr12473081c88.21.1794846163018; 
 Mon, 16 Nov 2026 08:22:43 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:22:42 -0800 (PST)
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
Subject: [PATCH v3 4/9] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Mon, 16 Nov 2026 21:51:43 +0530
Message-ID: <20261116162148.2864501-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX5/VASiyYrMrh
 e/7lOVOMDgry5iraX+/Yw0I0kthgzm7VeIRJgZduHlqdeZWNLiPF/cnzsoGJjJW+YaJeakC/NYh
 JxmdFeDXhQdmb+GBrOtDloAoEs6SjmaISkSmVRPoIFZ88zgccEAdm6/926OeEwYViRIo0Hb1MyQ
 fU0XyeJbW6VMrS06O/vHaXG70s6BtCmODxOMj81+rqdws3+q1iByHNXLxQCyCpIcTpdhQKmKWvV
 4CgoMDkIzdnJ10WOp8g+0bavikkt6TnpYRkL4P0tODrxUg8QTL0khdrGKNUJ4pE/yd7jqHD1xVG
 68zuJjPsiSNXwbIz8earYwA8IqyXjM0SJX45tLmjuIU3nXA/h6PkVRSUVOyiF3JfUdPNRgMUeJ3
 i/z2PqjQ3XkkBs+UuO3I/cFWHqueURE/Ah3lXRj6tdaerewmVn5ZcnqAcYSb5Gy7+rqTv9apni3
 g373Ryzm7bB+lD+B2Rw==
X-Proofpoint-GUID: 2H10aFK6oH3_SgSDEOI1yXUQtwnuesYX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXx9yitVjHduDW
 UM6plmoC59b0INuid1JnCnNsFo/XHyPzY3qXfnk1g9YyB4JbYHBYXV0FOjxkpcgEaF3fx1qcdYd
 v/83saffhOTI7Nqt46gVJNWwpld43Wc=
X-Proofpoint-ORIG-GUID: 2H10aFK6oH3_SgSDEOI1yXUQtwnuesYX
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb2dd4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=0taKFLn-hLWpjNWZEgwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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

iris_load_fw_to_memory() calls qcom_mdt_load(), which bundles
metadata initialization, memory setup, and segment loading into a
single API that does not expose a PAS context.  iris_fw_load()
calls qcom_pas_auth_and_reset() for TrustZone authentication,
which is the intended behaviour. However, a new
qcom_mdt_pas_load() has recently been introduced that works with
a PAS context and can handle everything qcom_mdt_load() provides,
along with additional functionality such as shmbridge creation
and retrieving memory from the shmbridge buffer when the same
remote processor needs to run while Linux runs at EL2.

Embed a struct qcom_pas_context directly in struct iris_core and
initialize it with qcom_pas_context_init() inside
iris_load_fw_to_memory() on each call.  Replace qcom_mdt_load()
with qcom_mdt_pas_load() and replace qcom_pas_auth_and_reset()
with qcom_pas_prepare_and_auth_reset().  The
iris_detect_firmware() scan retains a separate memremap window
after qcom_mdt_pas_load() completes, since it needs to read back
the loaded image data.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  2 ++
 .../media/platform/qcom/iris/iris_firmware.c  | 27 +++++++++----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 3e4cf652bf39..ac73bda072f8 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_domain.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/v4l2-device.h>
 
 #include "iris_hfi_common.h"
@@ -129,6 +130,7 @@ struct iris_core {
 	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
 	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
 	struct dma_iova_state			*iova_state;
+	struct qcom_pas_context			pas_ctx;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21f57d37da18..b701a7f43514 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -201,21 +201,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 		goto err_release_fw;
 	}
 
-	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
-	if (!mem_virt) {
-		ret = -ENOMEM;
-		goto err_release_fw;
-	}
-
-	memset(mem_virt, 0, res_size);
-
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
+	qcom_pas_context_init(&core->pas_ctx, dev, IRIS_PAS_ID, mem_phys,
+			      res_size);
+
+	ret = qcom_mdt_pas_load(&core->pas_ctx, firmware, fw_name, NULL);
+	if (!ret) {
+		mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
+		if (!mem_virt) {
+			ret = -ENOMEM;
+			goto err_release_fw;
+		}
 
-	if (!ret)
 		iris_detect_firmware(core, fw_name, mem_virt, res_size, desc);
-
-	memunmap(mem_virt);
+		memunmap(mem_virt);
+	}
 err_release_fw:
 	release_firmware(firmware);
 
@@ -233,7 +232,7 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(&core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
-- 
2.55.0

