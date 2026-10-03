Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51952CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6549410E6FD;
	Sat,  3 Oct 2026 00:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qy0YgqEP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J0sYxCOw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C19B10E6D6
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne7242943133
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wczBi2a9P7MYX7mLDGxMDUnPkgfHZyh0xycifYmGbOw=; b=Qy0YgqEPqG35XS2W
 biwvJ3oJ1gfgjSocLTNX56DrXV8GLPxV9SHtVUtdo76neuSpf63GXTfKQS2soqI9
 zPJoA0BNUxWqRdduCY59sFoGHZ9wz9ZW3UsI0plCmYN2t40gLGyzdhobh80TPZNc
 //F2/WNtwxDlYfyE3L8V+GTjcfkRHNwEPC41q8yZhpeXMhtktWTWS1f1rO4xc3N9
 j7ogxyvLG85Aa01ssq81VisgTip4YmmAHifxWfjQ2jSmdOnXbhG9mhQRwY/fhRTf
 KGwRGgffRlV+9Eyk1HJnV18UbUME4LEoiGPFGtNDfYHT1DHn1YtxRxFp+KZVbmtJ
 Tkckdg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2h4ksbsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc40759b2so9579985a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985786; x=1791590586;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wczBi2a9P7MYX7mLDGxMDUnPkgfHZyh0xycifYmGbOw=;
 b=J0sYxCOwp3CH8UtdnlNb53aYCRlzwr33A6wGwahSuMW0L+q6I06utopboHGv0abGVM
 jzguusUZxZuCPGio352o0nRRuvWRDr8uwhdAa8OYzQgd+fwGEfyZmXMR8BldPSsKO3Ct
 eVX/EdB7IXpdFkNFlydG4xp+RBYvw1YHfWSMzXUmaTCFzUNwj76oNY9h18ZPIqnAqqMB
 ui9fhjCLJPjWR79RwtrfkECgH9vdM+wdbE/2Qub98wudXHSm373Gk3DZ6/oI+6RlbMBo
 JimFONZA7XtupbxZxLVsHmn/fYkLZZXMKzPOHGTAIsgD3TcxjmQk91I/Fuk99RV1Iwde
 PzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985786; x=1791590586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wczBi2a9P7MYX7mLDGxMDUnPkgfHZyh0xycifYmGbOw=;
 b=uc2s5aeIKHDdZL8cZ7mX4o+ghmMPrcnwa9HGnJRix7hh4JDoWaEGS8ziYSD2iApnfa
 YCLWx7qgqjCV1eTVHYt+GUUCBm5AEqgpURjtFv89qbaDjBB0Ceerw9RJAAw2jmuzNd5+
 l3wEoS8p+SHriM49XY/FwapVhgc7qzieDEkKppb84x3UtWb6tiHgHnkXYAzimhzyyHKK
 NB+0D3yY8t1MSeOLNS5DI6BahVFti3T5ydhbQnjySQutKnbVCqzqo4hTov6cgt9WbBCx
 yTef5D+Bm/kKQihjF5b1XZ3UY536miaeJKg5WA/0cj+ljdeR/ZRk+4ZcOH4onCDiMTvF
 q5qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9r9IE+mLVqCmbZ70vY1mNacXFIZtrSncB9hBW1RqRMKki1aF1ajyv5z7wcKU5TtWoWeFs0JWk900=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcZIjuvKW0vKYO5dN2f6/OJGLSVMXWGTRXmKUPBESpQokrUzr+
 ILWpu/0/TUp9yBSbvF6YWuOcPmbS5mULXVwBCfa4EFSueA7h1o28uBWcfU8+Vxm1EbVcOH9mvzi
 2L4Q8shQ8AC3nqXBa2zVhshb43Hpa7/M3DJKq4gK7mMZlXpFpEQqWyGLBFYeUfBYZIYnHEgrrd+
 Wtdi0=
X-Gm-Gg: AYBFou0PHuAIJswiJV/dwK96S9RGBsCxbf8TR7DsaOEXu9THVsBt+tkcTYXDkgQt1iB
 BkSwjD/uE2E/x7R5ELk1tO8gvchFo6qZvyGqrjSE04AWCyAwSEU/j1jssDNZdQ9iQtPKSx0csGt
 xIsjz7ysoNY/T+TE3aa7C4aC0yQjTKfsv9t6DokunSyE/AN5RmSw6q+SWWXjYExQFFhVRP3PmO2
 yZDUWUuF+JnfhwoyTWhBqx/TsI3nzw+OJ3E4mH6tqwEjDPbt7YyT5yG22ML3KkOvdF8vPVwwOp9
 oN+wupg9p3I/TkBD0b80KvRb3QJ0z1JJ427YstcQ5bmqzG+XywKWtqwdM5T/FvgthHAOQ96VkOU
 jGcJGjD1vrEO1COHqoiLzmKYuf0pDs8FfpbJKuDzom4y8WYiBh/ixaEXeC+W76oY7E3n57jUn3d
 IkOkFTnLOxx4xp
X-Received: by 2002:a05:620a:4481:b0:93c:c6d0:195f with SMTP id
 af79cd13be357-93cf1700bafmr843689585a.27.1790985785822; 
 Fri, 02 Oct 2026 17:03:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4481:b0:93c:c6d0:195f with SMTP id
 af79cd13be357-93cf1700bafmr843683485a.27.1790985785212; 
 Fri, 02 Oct 2026 17:03:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:03:00 +0300
Subject: [PATCH 2/5] drm/msm/dpu: don't count the cloned writeback as an
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-2-6a6a00917b71@oss.qualcomm.com>
References: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
In-Reply-To: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4PIx9upT4F6pj1ce6EleCxtYsao9DCXnF1q1zAJD6Ac=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEY0+f0uLreMHCTz8j59t+OQQktW6Nk8dWtvL
 99sEhiLULSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGNAAKCRCLPIo+Aiko
 1TO2B/9n6KoJ07l+ZoFV5Nma+JosA2OSKUDzxQvdwLH5hUKPnQCq79UaMdgsU6v1g+vfs9U8DHg
 pNVW3S0Tp1UUKoNOsroNtFt6k25136ty32ZQldrQawutiYJ4aji2YvSv+VUKLKQmQ7iUm8LWlno
 vdHx3Q+7/M/YvW+VbXJxmXszXq1VuqbhPx6ibaMWseYLPnCEGj3Gwl9ohD1/SPO/23kiA36Gr1q
 LyXOoQGFUwY10ebJ+izZo76ilaaLAsqaJlPUg9EcLqn8f0ll/m4MFOecOq1yQFzy2CBwq++CIkA
 EqMsNmdVGVC1R7nutCfgxA0prdJc8qubVK8SRs2fPiPtSA3t
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=G46JgNk5 c=1 sm=1 tr=0 ts=6ac0463a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=rwtzSE6-eAm3UGv2b74A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Xg-YGZ3bsXqj_TxhdcTPjqr_0S2jDfKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX8g4jq1NuEwkB
 lGk/USuTN3FDzP3ZSwhqATgFDMnrK1uDZOhS0Rt3I2NKMjCaBXcVTxBTLxwqNHS+VP9R/167qdh
 mAAtFYvlWqE0UjlWxdI3j4oXyubfHhKqI+cobnG2htpkWBonIjarfFBHAQAUgA895xCL1mmFn1K
 JlIWrOrUxiBG/DR2N9Y/dNYCpNe6ol2Bksn6gbLAX4y7rerq7F69GKHIsGQOJbpEM3enVZSK2yH
 XlQL5qlxcF1p6RQZswpdYaCD+jdFvpstEmihLoPxZ5EiYHiPsMCcoFKjs2Zk+s265XyLGfM2ZBX
 VVbvyDCGcWoXLdkQ7GDWKayG4qTRvjOmtyw5SPneAx7sSUTbLoAwrTm+uPZYRSo6g5aFCJzY0u3
 miscyb5pkQuOizqhlVJAofT+oaRpj9pMHBXvuiwdhFjwEZtYZaohT4XN8eEdAueP4h8icyfjjfe
 gMV1zUHMvdyZFq49GCw==
X-Proofpoint-GUID: Xg-YGZ3bsXqj_TxhdcTPjqr_0S2jDfKC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX1D/SlKhAidVY
 cfWl2VBjHz65uzh8QKQh12n0Q9AENM24wxl6k5Ugl/WZBMLsFNq/Idi2To34epgvLFaArVtrDmS
 cwCpcDrokqGSrwW6O4dJMky7I6ZtcDk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020095
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

In the clone mode dpu_encoder_update_topology() is called both for the
real-time and for the writeback encoder, so topology.num_intf also
counts the writeback. However the cloned writeback has no datapath of
its own, it taps the mixers of the real-time encoder. Each user of
num_intf has to compensate for that, and not all of them get it right:

- dpu_crtc_get_topology() skips the "two interfaces use two mixers"
  rule if CWB is enabled, so a dual-DSI display in the clone mode gets
  a single mixer for its two interfaces if the mode is narrow enough;

- _dpu_rm_reserve_dsc() compares num_dsc to num_intf to detect the DSC
  merge, so it doesn't allocate a DSC pair for a single DSI interface
  using two DSC blocks while being cloned.

Count only the real-time interfaces if the CRTC is in the clone mode.
The standalone writeback is still counted as an interface.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 13 +++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  8 +++-----
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4d5..828187f46eae 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1385,12 +1385,12 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	struct msm_display_topology topology = {0};
 	struct drm_encoder *drm_enc;
 
+	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
+
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
 		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
 					    &crtc_state->adjusted_mode);
 
-	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
-
 	/*
 	 * Datapath topology selection
 	 *
@@ -1404,16 +1404,9 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	 * If DSC is enabled, use 2 LMs for 2:2:1 topology
 	 *
 	 * Add dspps to the reservation requirements if ctm or gamma_lut are requested
-	 *
-	 * Only hardcode num_lm to 2 for cases where num_intf == 2 and CWB is not
-	 * enabled. This is because in cases where CWB is enabled, num_intf will
-	 * count both the WB and real-time phys encoders.
-	 *
-	 * For non-DSC CWB usecases, have the num_lm be decided by the
-	 * (mode->hdisplay > MAX_HDISPLAY_SPLIT) check.
 	 */
 
-	if (topology.num_intf == 2 && !topology.cwb_enabled)
+	if (topology.num_intf == 2)
 		topology.num_lm = 2;
 	else if (topology.num_dsc == 2)
 		topology.num_lm = 2;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5a06a0fbc7e1..65161efc4294 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -667,11 +667,9 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 	struct drm_framebuffer *fb;
 	struct drm_dsc_config *dsc;
 
-	int i;
-
-	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
-		if (dpu_enc->phys_encs[i])
-			topology->num_intf++;
+	/* a cloned writeback taps the datapath of the real-time encoder */
+	if (!topology->cwb_enabled || disp_info->intf_type != INTF_WB)
+		topology->num_intf += dpu_enc->num_phys_encs;
 
 	dsc = dpu_encoder_get_dsc_config(drm_enc);
 

-- 
2.47.3

