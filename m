Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26D606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V04Pfiox;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gd1OiepT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9B9112D45;
	Fri, 23 Oct 2026 23:26:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE35910E736
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvHj1297453
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=; b=V04Pfioxj8k1fKUp
 3sRi1STuH2LOJKE0oJTK0b48wW4ANxZZPIeIUYRte8SJF8OgqhQjQUG1H15O2o1D
 aLw7fdZCC8zSU16YInqe+hvs0SUW6MDR48XFimzHJxKJHrn45Ts65XdWJWHIm5IV
 uatWLTqBmw1B4bNOyfZv4ZwLFHA1XAlfhk9xnypAzIkyloHa8aPx7RR/0gAh0xdB
 A8wsnzTX+dSAo4oy4ZEfoKsXR4DUzzl7dH+vY97kwLiz6qN3fYorfcIuC5B9fNTt
 Qd+0RercA9t2lmgSj7nzueYSjuToeQIulmzoCU3gd4tWGO+jOzRg0UL+luHQ8iZ0
 X+CDAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhchx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb6391e89so302985585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797948; x=1793402748;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=;
 b=Gd1OiepTERrPHx3wI4+4psqlAIMMLGneapcQYFWPF4DRPc2tCmj0KTqPPjpuMM/+wq
 KlriqdBL1CXDv6sqEmIrTzSC10b3ztSJEqiB4+3OXJy5C75uT4hrWVrdUzau1oroC792
 4yO+0bpynvMEUovSLJuXEpGTUyv6VyD9r6hPeHfp6wzIq26K09+qvctA9GvLMlQswQmA
 N+KqnXSKg+7w5WANuUOsAZ3PsZrn5qUy87lGzOvXzqoF1swRxvACserpseemC6KWZYrc
 sUiu2+f8MlA5NHH7Vl/doeyXYyQfewZsc6FYhWk4hbyuLI50BtTUSTL6DLsOaUuBDFxm
 IOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797948; x=1793402748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=;
 b=xvSEIahP0qRUrN3tjKM8d7BlL0pob15xaH9LH5fylyyVbk7cw8PsNWM0mR0dwuGycK
 XeJQhVW/TrKySTWcCbbpMVEbd4yDHt85tk73JSQpwOiv7YbrhYFDdyEbZbFXuZip/xM1
 AWY/8PmPvTsXS/0v9zZnTJDE2IywUSgOCtelHJY0bUD90d1ncLpQLAt6HsQOiUycOQbC
 wmfMzNDPgDlc99FeqpGVZ3169kKQkZJlTnWyWaOE5IDdr6GApcJntcyANVTRmqfxsINQ
 VXMfeiFtlulhstnFlPIU2loyVNpMDqFF75y4U2fztSQ88JD8DTzVTx5UV5d7qiQUI+Up
 e9IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhkQZpZMN0glSHx6Ox51ryI8H5huZdsZKBz55UmUN4UImepVmVupbkg60jYhIsHzHWQ0eOD7vtlMs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJN6S8+A4dIYNIgiIW7dxHrorZksAW2zArB3VZxy8/lgTTSmp0/
 8HCwj9YVy3bvRkujJOLwm/XavORibrBWDviU+OKoOeocLsm/eGe0Ntm0+adZ4v2Dzi4JQ+j+Bxj
 YpLyviI968Y/xMhLtkCifJS1KssPr0svhGziFio9wLGpQbPvgjQECVxJ6w46UgeZI+zXPXIs=
X-Gm-Gg: AYBFou2nPKuXYchYFSPQPMgBdsjvwL74k2N/6VvLRnM+5+PMB+ypVliISLrRKRbPQo2
 291SRqRyILIIyVtJkiSmGQ/YmygIhciLvbRPqmoXQSook1nsuzAe47Jr3iPK32faWFS4vW27ct2
 8lRdcZ5tvSYQPKUuZeiTWz52U8Q4JtUThjUeSRyxHNx8XdSHnHaQS3UrGOXYwxrSlQUJ+6L8dkW
 aD/1baaPShOUm7MzmhV5RQt87HzLLQuAXSLXeL9lWRmU28OvJXjfnPZo6iC9WAY2u+fUmUgcs1F
 6XwjeJL0K5z4G+58K5Upx/uS7eIkqIPTLjYBSSYzEqJK4NVc5zwSX6vTNOrDTLSAozWsTRivS8q
 GqdlWJsOA6MFwt4wJVJClfSaaPvqXKGUCAJmOwckaF5lmVQsAMkus+677tOQCk8Ue/F6eBvHuGY
 SIkfrfbFuInir+
X-Received: by 2002:a05:620a:8399:b0:93f:2ab9:729e with SMTP id
 af79cd13be357-940ef9151f3mr89905685a.21.1792797947859; 
 Fri, 23 Oct 2026 16:25:47 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:93f:2ab9:729e with SMTP id
 af79cd13be357-940ef9151f3mr89900785a.21.1792797947330; 
 Fri, 23 Oct 2026 16:25:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:25 +0300
Subject: [PATCH v5 04/10] drm/msm/mdp5: flush the interface before starting
 the timing engine
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-4-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GGiCoTigCncSjQExhHlehqh6DW7zeUi0eG81bX9nqSY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zoUiRvfbDYHpV9LE67/Lgl87snKY7KSX6Cp
 ajd5M075uSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs6AAKCRCLPIo+Aiko
 1a+JB/kBim54MBDcPnKmvY81X/osZL4jlanUdIktJbxgIkba2Vk3PY9z3SSU3Hd18WdYdQwd8VY
 9OQFLrAax4lr1myST8pKoBiO6huDgp32IrYfp5qKvntvPUfWVQt7nYlzI71CNKQWP//90NVh7Eb
 0Fb4lVIo0JifNZvYqT3plCdK4FQSEVU2Gav1NIktwUQho59AjB2ggqO6eC6lMg9eqF2kYSmyVUR
 8SCq+f4h7ObU4XDM1oKmND+40wHZQ3P6EpVLCgLhqERQ9q985vMjWL+sHPZWQgya0x2iBRLHtF5
 0QEoZFIjBviXpozUHh/6xtL8+StpIjL+fXEsOBfc/6p8ckMp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXwhxfGQi33l/3
 S4pVMiHxh2fISHShnmhMdonOfp46nsa9/6tm7iXwmjcErfbnDYX8aJBkR+661qxmb5j/ggxtsHd
 2g7IAlRxCtz++sspCMjrthauUzdGbMc=
X-Proofpoint-GUID: 8uMhmzXCsZdwBmFflKEOG1yUgyTxrv4E
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbecfc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=H8EOZ7U-Vh7qnyOv3DwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8uMhmzXCsZdwBmFflKEOG1yUgyTxrv4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX2Wj4Tab+IgzN
 at2kzYTGQzEsSIWxWbs8nhGAS7In2jBs+ovOOSdtzRs66235G1lj6E2X3PcK81yC6W05KyI/Pe8
 ZO6p+7hCPIrxzf0o2Le9DfFyZmN5YbQumcsILIkgOB7C5oYIdLpVrdlTt9ELUPdtaXEvOEwOIoi
 3vbESRrojZTMVIGzsPdA9bbvpKrgM5BhDxyxWRvvsHsYAMGI+EME589AUQbXd1VBCM4LWBcnLlF
 bZXJNCFBExt8vCopMk5/IKkiqJKYO4h2JBervuJF4BW6bwiIrGbcah1YteMyVddLrMUKC19plVQ
 T3z6WGBFworm/MiFBD1mldKm9VotRQyexIXLytLAG3gR+wotmS+G139MqYAji6uFlNq3MhKR3ty
 zoFZbiv+AwpW9YmRKyFC0RvJz9gBGfAdnpsuok5xzS/hJco5Y00ta0z9VhY80c4tVua3jjuacfQ
 BKx/oygtzHwuus9Lv0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

Disabling a CRTC and then enabling it again can produce an SMMU fault on
MSM8996 as soon as the timing engine restarts, e.g. when fbcon takes over
after kms_atomic:

  arm-smmu d00000.iommu: Unhandled context fault: fsr=0x402, iova=0x01fa6e00

The faulting address is inside the framebuffer that was scanned out
before the disable, which has been released since. The pipes keep that
address latched (CURRENT_SRC0_ADDR still points to the released buffer)
because the plane removal flushed after the timing engine stopped never
takes effect. On the next enable the pipes are programmed and flushed
before the encoder is enabled, but that flush doesn't include the
interface: the encoder enables the timing engine first and only then
flushes the INTF. The first frame is fetched with the latched pipe
configuration, from the released buffer.

Flush the interface before enabling the timing engine, the order used by
both the DPU driver and the downstream mdss driver. With the INTF flush
pending, the whole pending flush takes effect when the timing engine
starts and the first frame is fetched with the new configuration.

Fixes: 06c0dd96bfbb ("drm/msm: add mdp5/apq8x74")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index eaba3b2d73b5..e9eb1db92775 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -164,10 +164,11 @@ static void mdp5_vid_encoder_enable(struct drm_encoder *encoder)
 	if (WARN_ON(mdp5_encoder->enabled))
 		return;
 
+	/* the pipes fetch the first frame with stale addresses otherwise */
+	mdp5_ctl_commit(ctl, pipeline, mdp_ctl_flush_mask_encoder(intf), true);
 	spin_lock_irqsave(&mdp5_encoder->intf_lock, flags);
 	mdp5_write(mdp5_kms, REG_MDP5_INTF_TIMING_ENGINE_EN(intfn), 1);
 	spin_unlock_irqrestore(&mdp5_encoder->intf_lock, flags);
-	mdp5_ctl_commit(ctl, pipeline, mdp_ctl_flush_mask_encoder(intf), true);
 
 	mdp5_ctl_set_encoder_state(ctl, pipeline, true);
 

-- 
2.47.3

