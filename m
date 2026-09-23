Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5821C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29EF210EF63;
	Wed, 23 Sep 2026 10:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqfEM/dP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YL0O4TtD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE5910ED4F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA31nT3936250
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mYtm1eJOTIqsmCeFZXGU6ez6pqCT+tJ1aFb8+8lzjGs=; b=SqfEM/dPwnhorwBi
 UxbPCSqj5ZYcaKZ2Ap9I1Ae9bmaYO0LTAlW/d7YEP561DNovMjZyeSrL/YkFI51K
 PV1/U8DIatH/RFkDXdR5gpha53dB9sYYQG/qFsIRRJwbyjWY4PtnZWCvPpcEq9MF
 3Y3YfzephMd2zQue0CNzj7u8YAwnEg1n2t+jEBRZgFebHIgxs3MLSSQezoJIa89+
 qhV4uqhjolV2UEOphs8bTmB1Hpd/cnXnkUj5hpnTijBfkD702oF5o3FaF+wiU1lD
 duX2zvqRILFd0l3BkQ1/vj3Aqe86lIVHJ8iMCrRcpvWfNGKEOVAp06Iik6x7+TT2
 Ec8SGA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428t846-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33310847fcaso1306243eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159216; x=1790764016;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mYtm1eJOTIqsmCeFZXGU6ez6pqCT+tJ1aFb8+8lzjGs=;
 b=YL0O4TtD/Is4eRdu7lzGW0vZa/beCmwShfKIdw2Cp7+wO/LMFfycuysUqFTfRu5fml
 nYFgQD0YVP5HLtcYUDy60OITdh4gLu03XN9vhVnjhAAP+YITqsVfDJtlKL+oXRKQ14DA
 vVRtFpQUldivQMH9rX3DGPx0aUgW+umefQz06ZwBezbo5yj/A3vNz4rYyg4STgBbC6+R
 PVBWwsMkVw3utyU6DYx3Qwt8miByC1sOdCFDLkBLYAaN3h7O9FHAgn1ThekOfINfc2n1
 sIyGtIpDGWb+TZLzhYAcZLtdhEYIsqmd3RPy89y4fA9RlDKp/zA981MQEytUQJC+rwjD
 OpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159216; x=1790764016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYtm1eJOTIqsmCeFZXGU6ez6pqCT+tJ1aFb8+8lzjGs=;
 b=HugY9vfNOG1EvAGKjpr2aZ+JJeHhs17AeH75+640wjyOijqwaloMYAcaJqHZENMTzz
 qHNnXZPv8G7F4o7czJ478EOsh8pH2gtGvtYSiTEu3TGv3LcpdEhj5iDGGNTG0+9XWwBm
 6x1h1VXEsyX23ffNt+lgUOSD2A+zGVaLddRWpBhju93kcqDDO+37E+B2gWkS9NQQY9m0
 t0qCgLArN3or0S5tjfxy1ZlSXYQjjVhG4O+Z+E8eRNDsjLwf2rPW1xYrCtQWaBMwBTna
 gGt3g3WPvNDEMk6k1CSFyORPWl8Ba51DZnBnnQ3ZKreUJNKlS/d2OyuS7tyfge60oBNh
 Uu+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByekWPuu9D/YOpUQDlXPwDunNyjaRn6DNI3EOzOCCuHk2wwgg+5qgrPS2SD3DiOlFap4nH8p5e1e34=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mR3bck29QQN5ogwMI6dIyswXQLTw++DW0jhjD3Pi+NqWcwNMfH
 aCCdtKH7102GnHaiwmpldwd8lG0h3ia6PhLuu66O4rLzQ9K5KdDUCs69OVuPyrqQrduC29S7lNR
 NMVpUctqQuGFAS3MbX7hUex9vOQXuHqcf/6HNxLLUpurN7n92FbJhRMOzYD+0ryQvLWdoP4w=
X-Gm-Gg: AYBFou2xxaooYygQ9ZdZg2uiwnLb9YMiomX6Vdfzmwm+bCj69I1DGt7PlZ92utSMnWG
 jS27Ag+Qrfhr6PXcJNDXhxZkUzPDAfTy8Pgn3gIGKkABY9QBt7Gl1FWOZaXIqd0BOMcCg/wbHLm
 BdNfrdGdNsug/GVF/rJKom0nBhRFX1LWjxq2bDkg/GXrffL7YezllD7oJYAFGh3yqFJhqKu93fw
 amHXjoeRpDvHfuUZDgYWX6WtQu8QF7qRVO3UC4hb4VLNuyo9+ALttNOh3zpB0qEMcFS79d4SxqU
 ujhYXA4I1EE4A8ZBUyScLRiKws9sG4Onm6Yv5f9ugBHEUw4Y5P8ng//LvJ3grN4Q0VuAuxsPMyn
 h/FNJ2u3EHcEbRDtzhXHSCYw=
X-Received: by 2002:a05:7022:3c07:b0:144:f8a3:2eb8 with SMTP id
 a92af1059eb24-144f9086e0cmr2388176c88.9.1790159216321; 
 Wed, 23 Sep 2026 03:26:56 -0700 (PDT)
X-Received: by 2002:a05:7022:3c07:b0:144:f8a3:2eb8 with SMTP id
 a92af1059eb24-144f9086e0cmr2388140c88.9.1790159215758; 
 Wed, 23 Sep 2026 03:26:55 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:55 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:46 +0530
Subject: [PATCH 06/15] drm/msm/a6xx: Clamp MX dependency vote
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-6-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=1006;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=y6Olh75Fc5VCdWLQG6EWVT/Oxp2EPOrAyCE8KeR1J1E=;
 b=EsDOz8yeV+c3gpSP6baw1ovG28clMjsYZni4lG6rN/FJULX99TZzacIk8ZsJLWufpEOi+PvmV
 2Cw4rPd8btuCPeWaGinzZWxb2wY+olFO74PiH2SuMrA5mubIRElH2Vh
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab3a971 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=MBm1Spx5gLoAAc79GfsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: p60Z5wK--rSVjNpMJT-8YN8Tvbx84jHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX29kehr4qxlpr
 EHZgvU8gKs1K2bxcU2fw+uYmJY9VC+vfWSyhBhethBbLccjMcjEgcH9sDRDUEsW0R2Z+zHo7LXx
 RT22dFNJPrh02b+/QUX+RKeiWA3CbnhmqYuND8W2tlb8p6D6WGIHy797ZdOY50wrwI/sDTwEFkY
 Z2/mLT3kuBbg7arFeO857EtBjdzOX2yKLSVyxQnjpezItCcwxRcCcMtJSuYjWrPTVgiFdYxtgdi
 rW+XiA2Upv0Z5mH+rnA9wegOHzmhgY59mCsv7supQeoVEEB0FRSZh9hGJDgQma8TCpGnHbzUHq/
 T/uBCnLs9L4lGCWYNMT1bvq9GnSRVZmJx8O0qkC604y2q/eq4aLgHzwh2eLlwI7YTw0Es53vIcI
 PeW27WjIFbDP8DfiLSXcrSsYgWG6fF1fPEMsJ2f8LNZvkHZsT9YmLxxNrFrMzHZUBtZoBZGBuU4
 VRpoS3pGxVAoZ71k7wQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX/8zp+nr9R2ji
 9RdgApDB262YKf//vv8ZDpOPPyOlE4dSx7hQgxiDQraZVYTb2qnD9UCEQva3WLFK8ppzNvLmwGH
 S+mjppkYEZ/5l7kKls6H8yUrVSH90PU=
X-Proofpoint-GUID: p60Z5wK--rSVjNpMJT-8YN8Tvbx84jHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230041
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

In some chipsets like Hawi, the GPU arc level can exceed the highest
available MX corner. In that case, use the highest non-zero MX vote instead
of failing GMU initialization.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2b66d6c7fd19..14d422d7ab95 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1833,7 +1833,7 @@ static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 	/* Construct a vote for rest of the corners */
 	for (int i = 1; i < freqs_count; i++) {
 		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
-		int index = a6xx_gmu_rpmh_arc_index(dev, mx, count, level, false);
+		int index = a6xx_gmu_rpmh_arc_index(dev, mx, count, level, true);
 		int bx;
 
 		if (index < 0)

-- 
2.55.0

