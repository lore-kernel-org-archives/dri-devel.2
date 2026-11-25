Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FE606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PwL8TO8o;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LpA73SlF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7AE10E365;
	Wed, 25 Nov 2026 00:07:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3037910E365
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb1Tp2656267
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D/hUcXy7mz/8ruNJCrFS9KeNwdisy1nQImE0w8zagUg=; b=PwL8TO8ot3tWUnvx
 sNdJRJn3ibfZXBJxMGbGv2hR7ZEZ8JiAQmiVOKJXZ3b0+XjfyCI5NSVz19/HMycA
 16crRKv0PUBqtxSx2I/MIdambV42GW5XX0O2uQ3ve2KdhmHGq79H00dAUNLTRIBA
 o/+IrpR+gq4iaesmmj3+vZTGLRH9ke/Rv+F9PYTHlS6dNwcxSgUjZfeYcoCtdE3M
 rtqsTyRUYW5R1V4vTTnJulgKbI35zaflTfRxTXIEsXQpWDTl+qxMdG/aNtpmHnjb
 shdCFROr3TDvE5r1tgnmiBmn5UqReH5ne4RkqdeNC8P4BWZABdr+S5WMfCdtjN5G
 l5w/mw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b802pev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so8047888eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795565229; x=1796170029;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D/hUcXy7mz/8ruNJCrFS9KeNwdisy1nQImE0w8zagUg=;
 b=LpA73SlFwyrCOnumdMG+GuMqSDy8QExtA3FLFnq2yA3A40DAs4Dl3MpBzLkLiiud6k
 E1kpGXegfNpiDu9QQtG0moylt5nN6Rh6eSNU8YmJcR/eyWhl/4znxsOgq8QeuIJMmAJd
 B0suITgUfoqDiq0p9hREO03q4ZhBTwh/iqkvwS1x21cg4/IItZoR4sQRvNkxDF2QujOK
 BsaX203WQ+oe+q0mIJs2IWgQXAd70cTdxjdUeyTwjXcS/dwp4Hovr8otW/mAa1sCrIlN
 3dqAHtTtFTv42j8UowITh0vX7JrO6PBxPSR1+SfxlhBzASTtTT1lubVjXOX1btOhKGE1
 l7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565229; x=1796170029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D/hUcXy7mz/8ruNJCrFS9KeNwdisy1nQImE0w8zagUg=;
 b=B13ZlyWBnF1p47u0c0mLUDBWxOnsw4S78cH4nluVzH/FqosxlSqbJ9EsuKjf3T4iiF
 4pjtzZZLkb+FcT0JVv5nRPxkvtjXWljJyXUSHQX1gXAlYcAVVdiwdHF2HQ1B6cBTAZOt
 Pa+FnU3Y78iuDWJLsPYR2wPIypqMMDQHmSp45iXbVPQdp54zuGSBYkdyHbRgn0FpoMiM
 tXVt0HmwYIJsbGci0fjLJl0k4gQL4suKwDce7vMDLPIgTWQrCn5FMC6H/rZdEK2SDV8B
 ohLAymWUllgllD1cbpzT+u/S0ZQ/X8TGGVyeby66Wte/bnQmEYRc2xg5g3jJIXeJGDjo
 tVbg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9YJNUc2cFzQc2RX4ikYspoXEEid9QzZdTxsZ7zd9qMZ3Z2DDXmFv0clNgKS3KVqxdNjaW8FgNd/0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Htf0XGBzITkr4x5VGRq23uLuYl1EZawLXdE7Uar4arbFFKW9Q
 ozIcp2UAYUD86A62HEGwnduWCkQv8uuBWt9YtTOYMOHYnl1JwFNtzhLhyKZOIPtEQ6YZptDpt91
 rRMPc9O2f9NYmPfjVsCUs41fcOabwocxE9QQ71hB6gZ68+aWMjpjjP+skryqd99FudMGeNVo=
X-Gm-Gg: AZFdTZeHYGfwSfCEV9Q8581npgwwYleYMGJLeE8yqj5Y+kXpg2AcG0XVj9hYXRjlRUL
 eKEkJSlt2ltBqVPJ7O/SHlzz7cHRTB6/jHf4TrBl31ULnO2UD/1PCFDbbLbxwe7Y5P1ymYHQoPG
 NEJTbHtTtXGCyoF0gHflMVgOrsDdU2ub7tKEOBXPDznBeIgGdju7O/mIn2LWssrzq+ovASWMulg
 IG/ETnEfPUHNmYeiiWUhEFWwdzV+2DW7GJAhdJHa/JIH67eVOCt1dgC/UnMAhd6Roqpk2luXk2o
 SvFpZYENZdtFlm0eV5udAaD8z3lDzLuB1cd7UnFqLRarUED6TDU7aY1ZeL0KQu+WVfg2gwpzXUc
 UcoPFGH2bguVgBR+H5egFw4htJ22uE7wBtIqkCp6+1JHe2ZOlcdZkBqpv1A==
X-Received: by 2002:a05:693c:88d4:20b0:386:a8de:2bfc with SMTP id
 5a478bee46e88-386a8de2f67mr9191490eec.6.1795565228999; 
 Tue, 24 Nov 2026 16:07:08 -0800 (PST)
X-Received: by 2002:a05:693c:88d4:20b0:386:a8de:2bfc with SMTP id
 5a478bee46e88-386a8de2f67mr9191445eec.6.1795565228315; 
 Tue, 24 Nov 2026 16:07:08 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm47494708eec.23.2026.11.24.16.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 16:07:08 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 05:36:44 +0530
Subject: [PATCH 4/4] misc: fastrpc: expose unsigned PD node for
 compute-capable HPASS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fastrpc-hpass-support-v1-4-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
In-Reply-To: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX7OzHjAeFbVmo
 aBbgAyhH2w78j+HqlEGlLfnDaM/o5mBvkZ98epOUVJtsD1PFdEFhdh1TJhRB2jrpKlilcKjTSEZ
 t4pIyCNY0mHYiGXaOPneVX+9O+PoVNTWVTs3M3ZNVYvPg/LxAmjaBWuAoZYScGMAgFSwaXXAZTc
 NUEnvIJrZ4osi4Yr62yWzbSd279rOkV4BEDcoKNFF8efsOkd1uKEQYGZWcLKKUUC8dYW3DVbrbk
 V10WFk11F1Hx/jkM27TzedvrMqaixfRXbaOts4Ga4Vy3AV7xBsWPIARO45D88HUvEqcMC4vu+jy
 2wknj0H8vSbH0BMYhXUlfRgHl0dtQDY7Qn1Vyp86d7a36GW1RsGa4SJDszUwpQy0SySsGzaZEjf
 eWsTMoh5RhnHdKXTpUzWE4PO8NqUtXMPzc7yTgpLcNTflI36pO5WjsZGrDcvJs5IPPk3HSfxIJJ
 vBEWIs1D/Qmwu+MUzng==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b0626ae cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QoXsROH1H4pbOw3JdpEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: fI0PVoHNj-JehKoXJ-W6VMjH9Fk_0lRz
X-Proofpoint-GUID: fI0PVoHNj-JehKoXJ-W6VMjH9Fk_0lRz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfXytWFj/lY5z0D
 4ygm5WFz0XGRq5V3KZ9vf1mEpgsuH1tmBpTeAOLL1HYlSuTQBNeP7NBxo0A7NHDiKHoqGv4ihoh
 /pnBKP1CJyw70IZVo8kZPRB87LBh/xI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250000
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

HPASS (high-performance audio subsystem) is a distinct hardware block
from the LPASS-class ADSP, described in the devicetree with its own
"hpass" label. Depending on the firmware image it loads, an HPASS
domain can run either an audio image or a compute image. When it runs
a compute image it offloads user compute workloads and therefore
needs a non-secure node for unsigned PD offload, in addition to the
secure node; an audio image needs only the secure node.

The image type is reported by the DSP in its capability attributes,
which are now queried at probe time. Use that cached capability: when
an audio-PD domain reports a compute image, register both the secure
and non-secure nodes and enable unsigned PD support. When the
capability query did not complete, retain the existing domain-id based
gating.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 59ef755feeaf..eb107d0f2bc2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -88,6 +88,14 @@
 #define FASTRPC_MAX_DSP_ATTRIBUTES (256)
 #define FASTRPC_MAX_DSP_ATTRIBUTES_LEN (sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES)
 
+/* remote_dsp_attributes[] index reporting the DSP's image configuration */
+#define DSP_IMAGE_CONFIG_ATTR_IDX (14)
+
+/* enum dsp_image_config: values reported at DSP_IMAGE_CONFIG_ATTR_IDX */
+#define FASTRPC_DSP_COMPUTE		(1)
+#define FASTRPC_DSP_COMPUTE_LITE	(2)
+#define FASTRPC_DSP_AUDIO		(3)
+
 /* Retrives number of input buffers from the scalars parameter */
 #define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
 
@@ -2713,12 +2721,22 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
 {
 	struct device *rdev = &rpdev->dev;
 	int err, i;
+	bool compute_lite = false;
+
+	/* An audio-PD domain (e.g. HPASS) running a compute image also
+	 * needs an unsigned PD node, same as CDSP/GDSP.
+	 */
+	if (cctx->valid_attributes &&
+	    cctx->dsp_attributes[DSP_IMAGE_CONFIG_ATTR_IDX] == FASTRPC_DSP_COMPUTE_LITE)
+		compute_lite = true;
 
 	switch (cctx->domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
 	case HPASS_DOMAIN_ID:
+		if (compute_lite)
+			goto unsigned_capable;
 		cctx->unsigned_support = false;
 		err = fastrpc_device_register(rdev, cctx, cctx->secure, cctx->domain);
 		if (err)
@@ -2726,6 +2744,7 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
+unsigned_capable:
 		cctx->unsigned_support = true;
 		err = fastrpc_device_register(rdev, cctx, true, cctx->domain);
 		if (err)

-- 
2.34.1

