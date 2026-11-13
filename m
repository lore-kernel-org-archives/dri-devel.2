Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F45606A899
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fURUUT0X;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LzS+kWcX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F589112768;
	Fri, 13 Nov 2026 18:54:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2DD112768
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFQxL12022411
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sFBq9fRHwG6
 vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=; b=fURUUT0XleKiE1C/Vux+befwt+/
 dPsCZuHNQAShw3zqmbbPvnkWmciAMOJmcPPjX/Ypz5i8xGx5igroHMccVx+b153T
 uIpQ7885fRsHjkWRYpoBVsESepqQQcYBw2TwRc+AQxQQzBPmipPxvz2QTuBrcg/U
 fxflhQRaD9AWLlT0VkEyW8xmO8xeOm7gg0EuYPIqqxROMDx8T0RNRi2GJT+72Zzf
 BRyN7VhBSQrTqV5w2Gbr8XxWutaOeSSTe4uIT86yAJhpD14B7KdLcqKJBttPaHBk
 Nu7PpBDZGbwJEUEyWxW2WkQw3GHZ29zfEI+9kF/mEEv+0sfWto/DrsKryPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g21vup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:54:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-378722fd4a3so1503899eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596082; x=1795200882;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sFBq9fRHwG6vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=;
 b=LzS+kWcX5WJcRTxorVnXKsCaHPN7CImL5XHya9a7nOeY7ysIF18rxio6I6aIoPmDE9
 /GHPpY2hNhz6iM+d4NTDgOlaTepYTB5tZB2zfmTWb2YyTld1dSq8Lima+sC8i+xuN7td
 1YzbKZIyBrNmDUCgAg1YGEjsQz1i5Xl2miMjZqDDXIr5tq+10RlxENVrE6y1yU795puv
 0yOV9N7kgLEAMIA+TKnh4Cr4YJCSj8xmyyXwCE5hsR1IS+jso75l78jiiPjE0hBB/XDi
 9+Gy46qc1B5FGXrNFhWiKioSYiY2C5VpBOpHI9b9n4ginKY3bdaYuyzXtq5fhXztd081
 rKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596082; x=1795200882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sFBq9fRHwG6vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=;
 b=ZvjqNH8H1C8A9Uiw7MWn6znharum6MfVnckkiXEYUyuD5EtwYPSWX9poSHjHb2BgOt
 KpslCpjj7Pi1FBNjzX/5/Ume0ZEvgjwr1uYHWvJmGanWUrK9NFasRq/OygKBdEGdff29
 MvrKNhsgFOapCycBnAL1I5HjG2RKAowSaS1mMetvskatvXcuoUuqCyh1ATHgmthyQ8TM
 HvU2QKQGUXfY7KLPKVWDOdTeqyCE6yzaOu/DAdgE4fIwk/9YIaEABM1rHIDk+M1bHTad
 KoIYoovVuYbt5RcUXkIXz2QTVNy+NduGsnmlJjmTuAhdiw8sAWvf2jyxx5v2hyFLeKgg
 8mfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHEnJXkjezs/nR3IZmJRB3fHjO0J3lCdjI6x6zhF9KGK+8kg3oE4kwR1YsIywWCRhMpgD2vBmTvwnM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9iJFFAc2l9l9VccMxVDoX4vzClABLZDUO4vB8PjVaa3ku4ONw6
 7+CAN0T9ZTDtCTDFDNJm1GLzW4Ux22Ro4/3dYPlGDz5YKJCDb6Z2A3oX/DqkPU3+ockMSujEyeW
 jStfQQe130UxCmRAa0TL5xIFm1cyQHEIzjdJINneNdHblF7xa57b6kMwh5VnIyd3VSSYibBM=
X-Gm-Gg: AYBFou2uQvxHol7MwmNielASR9BrTDxK53TW2y84IkO3mkKMW946sP93gGmn6FHkHQl
 m2YjH7GiSBEkvuulH44+bi3jleTLkOkFgu8nfYc1eY3pZtM8OEmOpymBZCACzs/fUzdmMmh1hIO
 hWoH/AlVPwV1SpIxw51tEGIYF1Yuyf8YoowV4IrgU+1LRnn1qiPiF+dLadWVfZrxv5dIfDdIMHd
 gEU6XKwRw6Q1rRrGtZiil74Yu8Ck1e1mKw8ZILZx2LX7o1jBU0Ro2WTF3uuOvWs38nu6p2MzJqm
 MUM+uPIIv6VAYqd4sOE7jXTCthRxLSeoGfRxUUx02CwD5w9i3TcGyJVBupj2ijilJnBRrh023Ug
 fyJ/6RlM49TkKcDH68mPae0elbdIONYSwGE6yoTgfiTQRWZ7/JN80AHnMezAqYPHRl6HalYEvt2
 0=
X-Received: by 2002:a05:7300:c7c3:b0:377:ee18:c290 with SMTP id
 5a478bee46e88-3796676b12amr2938732eec.21.1794596082051; 
 Fri, 13 Nov 2026 10:54:42 -0800 (PST)
X-Received: by 2002:a05:7300:c7c3:b0:377:ee18:c290 with SMTP id
 5a478bee46e88-3796676b12amr2938703eec.21.1794596081228; 
 Fri, 13 Nov 2026 10:54:41 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:54:40 -0800 (PST)
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
Subject: [PATCH v2 9/9] firmware: qcom: pas: remove qcom_pas_auth_and_reset()
Date: Sat, 14 Nov 2026 00:20:09 +0530
Message-ID: <20261113185009.157893-10-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX5/8eyIZBjACy
 IgN9bniBcVBPSs6TkhnZ8fni4oLDlH5BmhqRdJ5Ut4xg/OY4OimEjzTgtyjZHaPCbYV27LHBLWq
 oeZnu3aKyHmrAlnENR9IeM83I2uXnZE3Qqpm6DnQh6GLcd1zbbPeHpzEN0+VGSmdx+7vvWVtnHa
 uYZv03JY/9qZkktMefmP8szouqmTElDX9S0GivBDkrvUk3ZDkqVn8NHQOzBdYMBCrS6E86VJIe9
 6KW+KgAyIYcw+B/BiQXQKXzCjT4qsLeeGp1GTR420cegLYL8phbC8drdoFiWyX7Vr2vFMZxGYAt
 HOFq9cHQjTqvjHdh9utAtPbdSB9k3doZSpQI/FLujetXT41KQo1sAyBZQ8GcMhx76afYJ1lMDcG
 uhZHNoTzNRFf+9ugYWi9t/2wzRUU+2qrRX2RZV7mT8RH97kXRtIHpwE/mbHKSXbw02OxvPMTOnD
 qRlMPxcgXt7wZl7WEXw==
X-Proofpoint-ORIG-GUID: 4IJ0nrXPwt03jXJi0eHsNz1iky1FAGNk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX7op1iRNHoX2R
 w6QhPHZUuF/04zc3yu/iIRki69WDdoVnnRkNnD5C9FvohxiVDvYV6HZxiKE8bV11o6JSfPnoJw/
 kubwn4d37/nQ8mrKeE2yehcBL2kaVn0=
X-Proofpoint-GUID: 4IJ0nrXPwt03jXJi0eHsNz1iky1FAGNk
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af75cf2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=sV0Ut8U-cAKt8JUqj3YA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130075
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

All callers have been migrated to qcom_pas_prepare_and_auth_reset(),
which additionally sets up a shmbridge over firmware memory before
TrustZone authentication.  Remove the bare pas_id-only wrapper, its
EXPORT_SYMBOL_GPL, the header declaration, the auth_and_reset ops slot
from struct qcom_pas_ops and both backend implementations.

The internal helper functions (__qcom_scm_pas_auth_and_reset,
__qcom_pas_tee_auth_and_reset) remain as they are called directly by
their respective prepare_and_auth_reset implementations.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas.c       | 16 ----------------
 drivers/firmware/qcom/qcom_pas.h       |  3 ---
 drivers/firmware/qcom/qcom_pas_tee.c   |  6 ------
 drivers/firmware/qcom/qcom_scm.c       |  7 +++----
 include/linux/firmware/qcom/qcom_pas.h |  1 -
 5 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
index fdf62003fbf1..08bf3a8d3bf6 100644
--- a/drivers/firmware/qcom/qcom_pas.c
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -184,22 +184,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 }
 EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
 
-/**
- * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
- *			       and reset the remote processor
- * @pas_id:	peripheral authentication service id
- *
- * Return: 0 on success.
- */
-int qcom_pas_auth_and_reset(u32 pas_id)
-{
-	if (!ops_ptr)
-		return -ENODEV;
-
-	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
-
 /**
  * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
  *				       remote processor
diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
index 8643e2760602..a296be2be8c0 100644
--- a/drivers/firmware/qcom/qcom_pas.h
+++ b/drivers/firmware/qcom/qcom_pas.h
@@ -18,8 +18,6 @@ struct device;
  * @get_rsc_table:		Peripheral get resource table callback.
  * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
  *				reset callback.
- * @auth_and_reset:		Peripheral firmware authentication and reset
- *				callback.
  * @set_remote_state:		Peripheral set remote state callback.
  * @shutdown:			Peripheral shutdown callback.
  * @metadata_release:		Image metadata release callback.
@@ -37,7 +35,6 @@ struct qcom_pas_ops {
 			       size_t *output_rt_size);
 	int (*prepare_and_auth_reset)(struct device *dev,
 				      struct qcom_pas_context *ctx);
-	int (*auth_and_reset)(struct device *dev, u32 pas_id);
 	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
 	int (*shutdown)(struct device *dev, u32 pas_id);
 	void (*metadata_release)(struct device *dev,
diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
index 1fca2712d791..525b8a02ae82 100644
--- a/drivers/firmware/qcom/qcom_pas_tee.c
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -331,11 +331,6 @@ static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
 	return ret;
 }
 
-static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
-{
-	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
-}
-
 static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
 					       struct qcom_pas_context *ctx)
 {
@@ -412,7 +407,6 @@ static struct qcom_pas_ops qcom_pas_ops_tee = {
 	.init_image		= qcom_pas_tee_init_image,
 	.mem_setup		= qcom_pas_tee_mem_setup,
 	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
-	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
 	.set_remote_state	= qcom_pas_tee_set_remote_state,
 	.shutdown		= qcom_pas_tee_shutdown,
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 030e4ba90812..b0f96e751167 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -855,7 +855,7 @@ static void *qcom_scm_pas_get_rsc_table(struct device *dev,
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
 
-static int qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
+static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -896,7 +896,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -906,7 +906,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
@@ -987,7 +987,6 @@ static struct qcom_pas_ops qcom_pas_ops_scm = {
 	.init_image		= qcom_scm_pas_init_image,
 	.mem_setup		= qcom_scm_pas_mem_setup,
 	.get_rsc_table		= qcom_scm_pas_get_rsc_table,
-	.auth_and_reset		= qcom_scm_pas_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_scm_pas_prepare_and_auth_reset,
 	.set_remote_state	= qcom_scm_pas_set_remote_state,
 	.shutdown		= qcom_scm_pas_shutdown,
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
index 458075868bf5..53b8d9631f22 100644
--- a/include/linux/firmware/qcom/qcom_pas.h
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -48,7 +48,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 					      void *input_rt, size_t input_rt_size,
 					      size_t *output_rt_size);
 int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
-int qcom_pas_auth_and_reset(u32 pas_id);
 int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
 int qcom_pas_set_remote_state(u32 state, u32 pas_id);
 int qcom_pas_shutdown(u32 pas_id);
-- 
2.55.0

