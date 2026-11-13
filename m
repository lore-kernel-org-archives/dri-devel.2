Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79460A3834
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FlQglaKa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UI2XDk4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A6E11274F;
	Fri, 13 Nov 2026 18:53:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7BE11275A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:42 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRJ071725087
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZiJ2cGdx8A1
 D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=; b=FlQglaKagUpZEUdwHsKRxWfwJTd
 uDYB+0aAyNZzPFH175mwxz3BJqPwv5s2jMDIFqyuCzk3yachMUCiXbgEJ8jtK8en
 njaYIweUasFR54cbpGpZQBUFocRLz5s8kh9dpZYuugDu/kcjgbAi+oQVJXzVSX10
 m3ep0d3TrgIe2Ztc+DhhBlZYS7NN/Eoxj5PGFiBZULVvCKa61/dejSnLQoxSXft0
 GG3q/5uQUXai64IwiZHQl+me8mZPlbGXgWhwqw6OT81Hbq+YIncYXXQrvet+58p2
 c2+dE+wG4tVng2F+RpmLExIqlyKqq/nP1sCVOfettrpnJ++qfwdiICCWSgA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp9q2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:53:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so643432c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794596020; x=1795200820;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZiJ2cGdx8A1D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=;
 b=UI2XDk4bGnnUUEiPpMseYf16vXWc4Dx0zchE+THmWTLnCsNObWJBzEViTrng7x2LvT
 GQ7ONmk0ecCRJu5QgjTmuUvOEyCQHvRuSAaFI4Q3Ngg4nvlHvUxC1+pbduQ7mXvLtCnW
 MqQj6KbNOPDzy5l5PhEB0VbGafiIr/yJX10Eg2oF0jORfVjFerk7g6aFk726wkeCC1SM
 sncO34MFh+yuNuLmHTZRnwyzYHom5L5KcoRNlGRSXrn4rh5nB56A6qrlu3HxhPqg9wjL
 IHtksV93LPgoj2pdc5esGgPPuiLVxHjaQ583S3O7xD6WREA3oT4q3ftot6xuqanihJzy
 JNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596020; x=1795200820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZiJ2cGdx8A1D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=;
 b=KvIXQx5TeyBovbiL6fiZ/11ct4BH00fdpYTJ5e7q8VC5DoxEFmx0VVJfODM3tZPZsO
 Av5HFywylFZ9RKXr8BQSEjqZbp4SHHx7ZoTrFEUX69xdOtGn57wxVV14/EsTqVmsfigj
 DLKe2Petu3pRQ8JW6pLc2ZvKyZNeFMjmIUjyTrJMpEaD9fVT/ywdPH9up8jy0PcQG2b7
 RuNdZFkunTqEiLEXsYwxA1JUgMZcd8ndZITGIjqMA2BUhn+MCuoVyldXjOiOhmmxxZYs
 W3ioUy2mLsng8rUKNaHFlqzbWIDFlR0TajPym07UZbIYOmkdec86U2xJRbfT7G5gH8co
 pxGg==
X-Forwarded-Encrypted: i=1;
 AL+hErGGEJxcnypmcnDt1DcrjsxweRHokVQonh6prPsStGS3w7NpBgJ0TGX8u3xO8amTyvxyBrm2SwysRfE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/x8/0943NwRUP/fS0Wm8DKZJounTiDYHPJy+puUi64/6mppFg6
 tLnmyuEEhTAEzKzjr/9HN01NG71PzlNw9w7U77kGVKEjOvsUScQRB5iDW/AK7kidLETBj/E9gS6
 kMQdvRGWN1krjNAEQU+z4bA+W5uLMuTdW+D+6hPoyayNhDalaLWVfiiPSikKj/JTRgmXHzbg=
X-Gm-Gg: AYBFou1VElgO/IuHEFR4P0K2E2k4XWzk7i8PNb4eoYkrhDNRqgBpEEMLeer/zpQOJ2v
 HKUUh5DkpeUa2jVrxQxCoKC+be3Ue/2bdPK6CMKdrmQ+oFglcpTN2mkr/7yJTOm6q9arY40+WCw
 Y6afDyX9kx3lvvh2Yz24WK3TEVyJgj27YTd4YZqDGLk+uKShhDBaFL/oOed22gClGj9ypSeGxtU
 gUl4846/F/4vS8x0/wsfEGnbM9nXQWjzruyEyRv/q29mbh7y32wsUe2FtDj+TPHzbfwksaYHojI
 3VpDYvcxslLuus2r5ssGAYBF+4pp/IbvaqVRDvjeJlOa2DjwcUwJJxEoxqsTflAR9O6iCP91MN6
 tw2KKzbTr5SkZGK6139d4ZGdhYa4I2APTvecM45MRRe/4RfP0Jtd9kkWoF12oncjhfzRM1zfLwR
 Y=
X-Received: by 2002:a05:7022:b054:20b0:1b3:b6d3:b91c with SMTP id
 a92af1059eb24-1b50314c8b1mr3584825c88.7.1794596020004; 
 Fri, 13 Nov 2026 10:53:40 -0800 (PST)
X-Received: by 2002:a05:7022:b054:20b0:1b3:b6d3:b91c with SMTP id
 a92af1059eb24-1b50314c8b1mr3584783c88.7.1794596019294; 
 Fri, 13 Nov 2026 10:53:39 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:53:38 -0800 (PST)
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
Subject: [PATCH v2 3/9] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:03 +0530
Message-ID: <20261113185009.157893-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af75cb5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=zg618T-2U28-L6wfSYIA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 11dYo75DUfu6BgwJ6M9NsGbDaKXAegH4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX5gAcYhExhD30
 VrX3F0j0JkNDsW3QIRPd44jQ9YMJ5nGMIVcyPxyhzh7gAUvcWMhCn5c7pdcQuxE6ruKfYqz9GWW
 TOT6q4rMXULBPUzjZJ9h0BDgO6mHDeg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX+Srp1lIKBMp5
 bgPil1HfcsSuOJQGH4dPVdbdwclinsiZaYdiSzVorTN+Vj2x8KOLte6AksnldsZcEd8ofZhmVsc
 7PZ+qYTpaxGBD5VEyNczsr3PA7BJ3RLAi8B7DbLqdNempUna7UQGqM/KxI2HVDiniQUIRO+zMkg
 ZZQRvCoZ3wiWgnjfganaxSa+wDiIxY5zZKPndtHBtoZ3nihYaANk0nqUmidlxMDXYF0pTZQPdpE
 C1rizHxAhf36he6wKQ6D6oVp1Pmdi5dJUWhPZFxX75mNyAH4O3ukv1IQD35zjWnREDrkGK9yfJQ
 vN/Tpv60x7hKHTz78Yt4rtzCG+69yvooI27ng9kcKYURBUCRXJqV7g1C6s7+ARN4VWb+eV4dgLU
 MQt56Cxrt5muP1U/jMyNbgK3z94rVv5yI2kUlJqtCPo3dyJILPDJfHSWYaTDN0b4gc7h72c3zG7
 kQx+lI3gdr59LkZpaMw==
X-Proofpoint-ORIG-GUID: 11dYo75DUfu6BgwJ6M9NsGbDaKXAegH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
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

zap_shader_load_mdt() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context.  zap_shader_load_mdt() also calls
qcom_pas_auth_and_reset() for TrustZone authentication, which is the
intended behaviour.  However, a new qcom_mdt_pas_load() has recently been
introduced that works with a PAS context and can handle everything
qcom_mdt_load() provides, along with additional functionality such as
shmbridge creation and retrieving memory from the shmbridge buffer when the
same remote processor needs to run while Linux runs at EL2.

Replace both with qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
using a stack-allocated struct qcom_pas_context initialized by
qcom_pas_context_init().  zap_shader_load_mdt() is guarded by a
'static bool loaded' flag so it only runs once; the stack allocation is
sufficient and avoids any heap overhead.  The manual memremap/memunmap
pair is removed because qcom_mdt_pas_load() handles memory mapping
internally.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 54f337475231..8e4aa8e22108 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
 	const char *signed_fwname = NULL;
+	struct qcom_pas_context ctx;
 	struct device_node *np;
 	struct resource r;
 	phys_addr_t mem_phys;
 	ssize_t mem_size;
-	void *mem_region = NULL;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
@@ -121,39 +121,32 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		goto out;
 	}
 
-	/* Allocate memory for the firmware image */
-	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
-	if (!mem_region) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	qcom_pas_context_init(&ctx, dev, pasid, mem_phys, mem_size);
 
 	/*
 	 * Load the rest of the MDT
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
+		ret = qcom_mdt_pas_load(&ctx, fw, fwname, NULL);
 	} else {
 		char *newname;
 
 		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
 
-		ret = qcom_mdt_load(dev, fw, newname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(&ctx, fw, newname, NULL);
 		kfree(newname);
 	}
 	if (ret)
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(&ctx);
 
 	/*
 	 * If the pas call returns -EOPNOTSUPP we assume that this target
@@ -165,9 +158,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
 
 out:
-	if (mem_region)
-		memunmap(mem_region);
-
 	release_firmware(fw);
 
 	return ret;
-- 
2.55.0

