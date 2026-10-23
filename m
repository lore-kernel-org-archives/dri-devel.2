Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E7606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OjWxWVq5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CiD6D9Ce
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0DD112D43;
	Fri, 23 Oct 2026 23:26:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20812112D24
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv9Mt4006312
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q7EDIi+tNkUmEr6tJ9z3I4I6TwuiM0qEzoqHgAUC25o=; b=OjWxWVq5sZXvXfdv
 X/RtLBmcID+sZj75zetAGs7GWnr8JW0NS1lTaxU/pEMJOhn7+H1aSwrr75LrQaC7
 gmvsZTZHb9IwnR/LJK7wddikL9JSCwRGD1u/ct7fQiX1ooTH6BGDVxnoa3UjqLLc
 jsqlt51H35iUNFBVU4qjVxBmoKUuFPxSQuqoMYhZGAo3BtNGbhZoCtlbc1J+bFN8
 OG/KyzbhuxI0H5wKJjr+NugpF4BDo88jFK15om27Wo+wYglspzGoEHGv/wrxeP7V
 BH6VD8hm1NBQrdJloaAb4h1AhsYBC2pbLzX/iaR21g//AXmRixexldrGxcdU/cZs
 WXMgxg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn26e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so317102685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797950; x=1793402750;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q7EDIi+tNkUmEr6tJ9z3I4I6TwuiM0qEzoqHgAUC25o=;
 b=CiD6D9CeZftnzopJ4+3nUBTvrOKDzhxiIvZE0Ah7QWU3B/iH0WQFJEgL9cECEqqbxk
 0bVgtcekCAh+7cQzneTFNZX+cU8j8+MnYdyv1FC8nPzyhRD7sRh1iVpQiDPuUow6pW3y
 ExPaHlokH4ocP9sve5hyHxWpMMCV3f80imREPQMYuHvWMSzaj5MAXJt4JdaLATVtx4N4
 bCQaPCB1DpAeSh9fsYaZnElA9Q6H9YYLPqPxCqHLa0ANByBL1YjbXq7f0H36I9uO9TwN
 bzNwlfLg4iqKJCb75/IbFkv/KnZpJTQmz4G62QcWm92+SXAn81Uda/hep31yfTEs7a1j
 YCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797950; x=1793402750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q7EDIi+tNkUmEr6tJ9z3I4I6TwuiM0qEzoqHgAUC25o=;
 b=BeErKmRjjSd5YqFjYhGK8u604lry6tDEeNZjlrS6/qugRHJ5aMeKw15yWVMeQJj/7X
 4/H2RCxIx5Mm5NxDoHUIMOiIBPBQI2vSpXTBTNacreGh2X0ANFS2Y/YiPvcyLdsuVsUb
 eRFpzTympsc6ZbFsjC+zqUF8Kp5ekpA+4pdU4iP4NR7p2H5RaM+fSFZymo//fmwIlhNu
 /JCNP9qP1oHx2ogLpAKeMXHIxa1zmzMc1EnEAXh1bu6hgxWOWeZPNNrjPxh7/PP3sW8A
 lmhuHvXhPjOudJulAxgMMo/wpWlI0wDGa/kaAKrdb+Eb0H2bg9nfcBpRKo7/ocUbszXH
 jcuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8QBZ0GzhiyBsS+CXCrIvNvHtSpxyi0h8bQVfowbHX4OTSYhpKVek7ZVbL/h4hJ15mSiDc3IBz3GY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIVpWfXlnr0B8OKOCk9FjhLsLIxnIKTPAWb7Y4gtZkdzCpkH1pD
 5TSydjcZU/gXjY+2mSn/OKfY3qHrkqJ+KGTDjtvbOpzXZPlVdAtLoNDfUCzwofJgFIfM3v1EHJ9
 uYiNBjZH57x81+27/RXAsnfFGH7JWevMkGmA81TgwQcxlQ6IE57vuZ1vXcJeCyHLhmesnqRQ=
X-Gm-Gg: AYBFou3zwxI5ap2n0wL3Ax4YpM2HZTNpbNQNu6Cu3S+4CY1xiynrdPFF+AMadx5YnOj
 4CAo+spc1eZ3CEOksl2x7Bhfo+02fyDzNMUbnMxGA5hNx89zRkaLDYY6M7QGd7wrAfo7fSKv033
 /YFXjMNLelHivLpYXMqm8aJo48mXscwFGOffPt694KwPtCa3FmzqCiHFwoSRskf7VWpC7xXjGfd
 MDa+MP3aJgeom23AHCv7QuPlOYBv7vNOyTo0HVg82F7uhoXpM7hz/LBi7s1r5Ezk/uzOlrpowg0
 QF7K5cfipiC2MpzjJwpLyJJS1CVcl2sDrUmqQ7UxiMHD3W1U+hShtvxLhwNDEZ9t9J+ax4Y9EjX
 IZFzrNW9tAoTOFyzZzb6HYDXrhmEHY2eD48q/M+SkPPRwevTIcV44WTmB3zBNVASnIyS+Z5+S+D
 eG3cfAqq66x1jV
X-Received: by 2002:a05:620a:3910:b0:93e:c12c:f12e with SMTP id
 af79cd13be357-940ef9b19f5mr80355785a.73.1792797950395; 
 Fri, 23 Oct 2026 16:25:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:93e:c12c:f12e with SMTP id
 af79cd13be357-940ef9b19f5mr80353685a.73.1792797949899; 
 Fri, 23 Oct 2026 16:25:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:26 +0300
Subject: [PATCH v5 05/10] drm/msm/dpu: clear the CWB blocks left by a
 previous reservation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-5-a5b0b284aead@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xs/CwFXdBTjsc3qfr5DTpttfpNCZgIxVn86qi7QYupI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zpIlwuhppzIxkagYZyU4H9WCxeEJ4vvij6F
 pdj5FaoneKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs6QAKCRCLPIo+Aiko
 1cixB/0QMpbpIymUJNF9EEhko2ZwTHssN5EYk+Zo+aMBPRGQtCgOnBpZtiSlP8U2vOWXcCjtg+W
 bMA6UVbdeUsNjC4i4DKoSlJ2t1ao6Cueh9Pv7sBax4n6+l0vPWFZ6kfXy73rtSfoRPI7FPcpo5b
 VO4Jh5IAuTr2lKyhLs/mNjPnogcyQ4i/e3OT6468Cfah+0TCSP+8JSMEJV0OglYIb1R9flI0hhG
 3FugHYeYcWuvBPEt+mg/rMdY6jH0ayBDYVg9k5OPhw9GgWECdTqemRGaXWVOktLlSwirLmE61j1
 zG3BYcYb8F9buzfzVeRxgRBlo9MKeYiGhR0n4/K90vnPMUKW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX6Z8kxkDP0nq8
 QjV2L8bxpLZTDSTxrRF9kyX0o4+lSSlX0D8y55XhLjOsXQjVu7Ses0LCMPMkt8eCOS87U0EnO62
 uynhtXHNYiNFdjh1zGI4OUCl676Li+1aYMI6UpfDDuyAxQhPCQqqG+OpTBJsJwBS1RrQeqRQUH2
 1jFFG83Ws3x4bkaO+YkRbmQ/Z76zAEjlbBgoap75kTPgerAo2FfTQ4s7zcJyuO87OcHEIcAksjT
 YkKiQ46fTTqiEm3/Rlf0NRxLcphPO3G871YrupJgElDvqvag6MRj/mTVpPgdMGMeGItNRZxEtjC
 2xDzL94VNsLZUecr6ck0OseeZCJhRgu8QZD4BxYtHPUhOdpLuaWOU7pxmNssG3djm1l55cXXBRh
 0XmEyqo9TzbY3LBTbCg4ZUMiuEusnZZ0JdlwUZU9fZ1HcOt9e3n4m0C3LrWScUGGs316iXQ2I7i
 bS7Zfun14QtFZC3ZouA==
X-Proofpoint-GUID: Ay2HW-r46kFeQQlMlDthI8eAMui2VcEk
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adbecff cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=00kiT5jbeo-7mEmJU9cA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Ay2HW-r46kFeQQlMlDthI8eAMui2VcEk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX6GQF/w219xam
 XaC91K/gYCsfpRqI67aMi5FQAnxGrwY6LuAs/1S6XNqia/6VTGYjbdkLk8B5/+r7WCO5fDsrotZ
 MUAACSLXaGLp7hBayNeuRyzZThPN+yY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

dpu_encoder_virt_atomic_mode_set() only writes the first num_cwb entries
of dpu_enc->hw_cwb[], and not at all when the encoder is not the
writeback of a clone, so a modeset which drops the clone, or reserves
fewer CWB blocks, keeps the pointers from the previous reservation.
dpu_encoder_helper_phys_setup_cwb() then walks every non-NULL entry: it
programs a CWB mux the crtc no longer owns, and looks its pingpong up past
the pingpongs actually assigned, in the uninitialised part of rt_pp_list[].

Store NULL for the entries which have no CWB block, as is done for the
pingpongs.

Fixes: 5008375443ed ("drm/msm/dpu: Reserve resources for CWB")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0a6be69a3e83..8fcd0b4e266c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1205,9 +1205,10 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 						       ARRAY_SIZE(hw_pp));
 	}
 
-	for (i = 0; i < num_cwb; i++) {
-		dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
-		cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
+	for (i = 0; i < MAX_CWB_PER_ENC; i++) {
+		dpu_enc->hw_cwb[i] = i < num_cwb ? to_dpu_hw_cwb(hw_cwb[i]) : NULL;
+		if (dpu_enc->hw_cwb[i])
+			cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
 	}
 
 	dpu_enc->cwb_mask = cwb_mask;

-- 
2.47.3

