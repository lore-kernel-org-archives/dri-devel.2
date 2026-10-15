Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2331CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDAE112114;
	Thu, 15 Oct 2026 07:41:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DA0112114
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6vPUY2121588
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=; b=PJvwGzEvtYVYkYTp
 SHinAg5IXPtETn3dk6XSbm/EZUHpWNF6wKR0V38xO96AqMtfvBZDEUTosHkxXwvT
 iV82LGLxtfGUSppdy3nOYnyMBCagh2nxm5eODM+hqOyM0rW2diFTG1Gb4L1mMSYd
 Qpqn1RnEwaEaRJVALNvpTF/1jm6ZbZ5/0+6/5ury5ytEu3L1bX7iWuM4Qb5VNNsW
 Vngc4zM8WzTdjVfXn6kqPNusWUA7SgMrO+IvHU8J0ssKNKMQC37lYK5C91Gz5LKo
 MWpm0nvD+NBYUOL1ZrENIRGv/QKDyavMBQjSOSDvGwW0n3PyOId2oTIjBwubkj49
 JSapvA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1gn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1130992a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792050051; x=1792654851;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=;
 b=flkcsLXGQ53Rx7WFlkSKwX4c8EOBmRxrPgDx9s1i9Cstcz0daokgGybxCQeWdSgaqf
 S8Jy2imnLEJ/WQ87Cjxbw9b+Od+UzJpwjxD9aKdloet98/Hcc3RlKy6TasNhaRGu08BP
 bjUH9GElWyoR0GVY4dRAOPF6a1RaMhr0H2rxVxur+/jV2A65+N6JW+k+0JTwEx3FSSwQ
 A2XZxeKHBQwgyBml5jSD59sRfuA5hdTqn5K/KDfqe8OkzHwK0RzneNGJxAGYrXMePFyq
 dJHttxd7EtXmhqIyNKnrql20M74bKWesR/6lkEjOLFXVPZlQ4gD4/T8db5AZwT2bU5Fn
 jbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050051; x=1792654851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=;
 b=d4YX11RHQyMSyIQCvjZrUrGZPQ2w7hMd5zLymNhSVo9fv+iYJgxasCZpZk4e5p8OpD
 3sTzsU+DB9e1smrPx4HRoNYJrWyt0L5Dp2SRR75Ap+iJwC96hZj/Ai5Vcp6LFGXCcuys
 zDGmlqCuVnJWK/oLkZtaJQG779NKK5rfLEYIKHU4Yw9i0o+YzMOGF8xlkWEPQFDW4L6o
 N7fOTpRjTw5ZQfT6jQi/B0HC655MDckK3KjEDwQ98BS/CTx9VFLYdoGXSgv7EUcDgX6r
 At3bWmCiknEYbeEEIE9UCEV39+AM4dX0ADToZAg6L+N0k+jEOPhheUYu4+3MHwzM0O1z
 pn7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByiVtSs32QXJraY1p1RMaSrLTljdFQ3J2nNw1PiV0mcbdHqJIwaTMXurGuJQgWY52gg5OMAg1/IpmI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIWa0m3o+fg6XJUtY2S1B1Av7SDvF/G4IP/L5XVkS1gQwXwOfLG
 huvOPm2bpN60WJyBJy7g3TgoUzVeeCzQuK/RCoIwoi0p/vpuOZe7xW6vDg0qfgzeuiKFnZIvuqo
 ujXStxvdLHUE8TmGzf9hYfskx/UJ6qumXgFDddTUxG0vHjGHDS8UVzGVuvs98XwTwU0IQqXY=
X-Gm-Gg: AYBFou2xADt8Zrnh+8kdMcyogZrN2ry5zbAghPndgu/3SBYVMR6xZz3rnhf9aLJ8Y36
 sK86W1WlLMRTDnhXaqPlrBaeIkl2xikHoG18gzEpYKKI0GarEfjrwbWjsMmMe58E1mRtqStYgqb
 XTcc4DaJgnBu60Kk4YIo1pkaJ057BjFA0idH9czCiSZGOyW2BwumBuHPQoLm5j/1TvXNT98IbzG
 ehtvLC+i5R9UB7YyyxTlONGcAjsFXJWPuZrJLggjPbwCqOduOQYLtwKix3yeZKfPZ+U23gGr3Uo
 8nD9AaYpR4RQadkwPFc3Tt9YsXu9EEUzjU0CGbc12pwrrrjOKmWXFENck/cb4wePUOEhKHh++pK
 pghFBpiEODfPXWJOd15xDBJVqL329DcCVgWw=
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id
 98e67ed59e1d1-3ab3a9128c8mr15644331a91.14.1792050051160; 
 Thu, 15 Oct 2026 00:40:51 -0700 (PDT)
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id
 98e67ed59e1d1-3ab3a9128c8mr15644306a91.14.1792050050596; 
 Thu, 15 Oct 2026 00:40:50 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:40:50 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:32 +0530
Subject: [PATCH 12/13] drm/msm: Register the DCP backend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-12-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=1867;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=KTdIkjaGNgd8M+aQhN1Sliw179pZI7BN3p4JO2Z8Txw=;
 b=gZH8cI5MZKuwSBGLRmM9KBPrUf6xwCojXAgQ86ziJfC23p1ZjpMksabwSdcHJeay6I3FXyCi3
 zeauB9NbyiqBIdzvpbDLVgDbBWtAjLblZlEpRE2DFZ3R2V/NRucRNca
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX6nUhXXoMG04+
 oK2cgAJVMD0/kqfm2TOR9NHq4p4QTsgnOdx1aOwvaq/d9UmlUl+LB0HLmTdGvv6NipMj4iouvMB
 m3CFnJ9flt4pAnsN05d4KKM7VgPAgvdcK2aZ+7DaNPk3fHbTgRHaQmshGN8KvY0Fvt2Rqmcmm0n
 QULeTFBXmE8S61WXUFmSjoKozNbF0cizFpJWlX5Ha2ZzxurT9P+7/kXpHjm/OHsM+OAmRAU5faH
 LFYyWv9AskLPH9Z6rVXM4M5kGsQ5HTwRFG3pfHNQ7VabbImgd7LMSHHeFWCvfihiW4+o767M/CG
 nJelm4vwH34rr7j9gG9DKIlIcuKPVZZgarZEvMK9xvbgdPlY2gx8XwnD/AhqBHQ/l10RJOTLFsU
 lb1K57meoA9hithGr9aEufXuJUvtX4wIOjfh4hlGxlGrRcfNSCKBuSo19teZWUI0j8N5wZa3Gqd
 tB2yrUj8ZYmDaEsqqeQ==
X-Proofpoint-GUID: R9NlFIpwfY5WWbSM3TCiIKqUkdTSfwID
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX6M0C+j0Zmkil
 bez7lp0D4YkE0bfHdzXCrBvbgJRF0htRLfQAuRI+BS1A2lKz3+tILrvD2kEawIrEFT2PFINPWx6
 v+d6nYxw4yoxwLwbGWupoudB+h3335E=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad08384 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lVH-uUz8Z5eEn0x1YxIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: R9NlFIpwfY5WWbSM3TCiIKqUkdTSfwID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150030
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

The DCP platform driver provides an MSM KMS backend. Register it from the
MSM DRM driver init and exit paths so the VirtIO driver can use the backend
when the DCP function is discovered.

Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
disabled. This keeps backend registration consistent with the other MSM
display backends while allowing DCP support to remain optional.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f3d2eaa04f14..04c31596d6d4 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1135,6 +1135,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1156,6 +1157,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..39954932b91b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -415,6 +415,14 @@ static inline void msm_dpu_register(void) {}
 static inline void msm_dpu_unregister(void) {}
 #endif
 
+#ifdef CONFIG_DRM_MSM_DCP
+void msm_dcp_register(void);
+void msm_dcp_unregister(void);
+#else
+static inline void msm_dcp_register(void) {}
+static inline void msm_dcp_unregister(void) {}
+#endif
+
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);

-- 
2.43.0

