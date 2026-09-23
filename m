Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7225FC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1BC10EACF;
	Wed, 23 Sep 2026 10:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RidMsegH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pe5nLEiC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A7410E89A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2msu3208841
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hueBpJZSI73Jt1u8OsHLGqyaejzw3nzZoOfdwbdMyx4=; b=RidMsegHyDJOlqMk
 e0uVv769jwlF7ICnDIZcPtOmO7KGPS/L9wxSzxRh7lMkdqYpe4b03W7R/ZVTKUhE
 0i64msJMx1guvPdHfI8uuQ4qfvGGg41orKEwAQP2DtZegZkzY1IBjBwjZymv2+Rl
 BgH2L7l9sZOPCUVVpb5/z4xoQ7aTtVngE6Awzv9PjLFF0dAanahlLwuDvlsl13XP
 lHvFt6C+doVSEZ4BDCW3IGtWzbok8bJ1sNWwLoO3FqWqsqDZzpPhK3TvdrDYth7T
 /GlwpQSYFVJFyPcrIo+mn5C76/3BYQ7bEpVvKdyEfRjtVfNQyNv7UpDjvu55tLe0
 J2U/zA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n1gkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:50 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14364a88479so167559c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159209; x=1790764009;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hueBpJZSI73Jt1u8OsHLGqyaejzw3nzZoOfdwbdMyx4=;
 b=Pe5nLEiClYP/pzSOwDjYXi5Snl6hmNvOKv0BufOVvMpAiIWGL81WEFUQ/lKSf3nTHx
 E9MHANY/6OStr4HHBPmqtFs/wSTeK8hfoCvP6Sg/uPwsVlEO/WhaLY5c7DzC/W7ccFOo
 McdhfIkILHVD9a0pFrG0NF/TcQcKMkpBkwxhk9ctixzBXNo1hkKWchYBTe76mDjLKdr3
 VSK+imQhfNAIp91A5jdUR8ImnwXB7fNuMNdiXfRB815Nl6QVYSOORbyG3cuEulXTDFly
 PdxL8fzAGpnEodlxsse9GYBoNFtzwRCAozCOerrM4tT2/HSvyMgUdpw3pBVPNdwhXOeT
 n8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159209; x=1790764009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hueBpJZSI73Jt1u8OsHLGqyaejzw3nzZoOfdwbdMyx4=;
 b=2MVqMaQmQMLlyj7xvetu/9o3x8ficmNa2iqCwn7pRtqBn/wYwipfL3HiGKir8XlzpR
 3BNoR+8xtjAiI6g79sRb/qUzdGhVxCN0gF8sT6r6K9YQHjEJJOPUm9gP7wjWJnQfuQKD
 3H00fsticif2xYieZVOsorVCfSRpZVYi5nXklkHLKzQdPMngIJ6BSfQ7XvuVaylxG4iY
 nyWghYFHFveFDK2pt32deHjZ5YlqCoo+LB8JgzAI0WK9gPkabeyH3FVSPnuePRFYsbqD
 06kAjE/sVOCraUqUK1s40bdHTCmEhWnfvvE845owujsF0XWshA1S2fsT63tbJlHvT3B0
 bw9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDV0Fw42GZj7Q4BRB9jZaOYrgn7RozjyMEiy3HeER8tGgaOVJv40RodW9POU5j7tAm6BXUiMdmcRg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ldWZGHbdfXaSczy9Nl7lDocJQ9hYNR0tjvq3rgN2HmGZakYAT7
 0+F2Pk0pwiPdNDZlduoDF++cjPOlmSqlj6IlKjGs9tJGtLImmGfOaskvsFAHEfdTDY1JeELqIaT
 2BNF+eQriG8HQ6ZHRnK+zfO9Zc5SHIcnmEhCVuD/2Xmo6MVVXQOrj7ChJshJUBL/LTr8X8xA=
X-Gm-Gg: AYBFou0ZLkUkSU9hNzBWauidnpYvysDojB9drAjUP0PbgnfwCWI6abm7yajPlIVVP+G
 45JX60Kng342LFev4qUdrlIHU4qW0fEBMZtC4Z3t+70sZE5pLFCzh4qWUVEyeHBV8v48X372kFk
 0oop3hnHRf7c0qDjR4CkuwwxMxCRB2MI+sneBR+anQr+kJFtYaErPvd/JLvkembYmrd72iWZPOY
 JhqgOu5EMSjKzQWWK34SRtVSTYHueFbuRZwX9wRAkLpM0FQgSLpoXNHpoHHfqkI1X1sVMc4uTov
 yFRPi7pIfi0sNf2Yhqz3ee0SWKbqX135rzZNlQE3oGVLdllBbydLY5ThL/LtfjgJT5YZ1O+gZI/
 vhHo5ce+rucflUER4yAE22uo=
X-Received: by 2002:a05:701b:4291:20b0:141:9d33:f1b8 with SMTP id
 a92af1059eb24-144ef0eca37mr2418626c88.12.1790159209262; 
 Wed, 23 Sep 2026 03:26:49 -0700 (PDT)
X-Received: by 2002:a05:701b:4291:20b0:141:9d33:f1b8 with SMTP id
 a92af1059eb24-144ef0eca37mr2418598c88.12.1790159208743; 
 Wed, 23 Sep 2026 03:26:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:45 +0530
Subject: [PATCH 05/15] drm/msm/a6xx: Add BX rail support to GMU dependency
 votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-5-0c3c79a1a470@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=2678;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=kURPhCqwLXhWyHDPUC0FBQT0xU08pc7L+Itm6hSzjGI=;
 b=NWMeHEh6JevxUszMhW2aEo9xuwPWpJ003QMf9bmjaSM7H2sFolE7OUzs3B5B7nYc1829Pvnxt
 hBq+lahzKu8CD86SybRsANUAVOYQXh0bSvQkzX1i/KG8rgr7cH+8kxm
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX8R+X8rQyb868
 VFpp9nUEZR7vpc2+eiVmCjZMMU3YZd6tlybDzVTznoZbtAnETm4X80RcBE4VNxAx2yOEZPWyUFt
 zQXgMaOyvOkeXWIQiSi6YkNMc+048kM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX5uZGYfNc/cId
 qXFhlYfKfngmreEYkEe08wH38I/jk8axMC5ohnP0t/D6vHEOLu8///w0p33qf9lpQ6r2yW98V1e
 TLHpc1JFjSmgN2SozqMpEIbH/djh/izoUrXRsUUT7Jh3QyIkHQk2rg9tEx/5rCTM7l8FZ46jHF6
 M1xTXtgY5e0y3tw9cflPXrotfhAR9QwO0MImUC927+MPGRSM+flEyZ6MvJQ8/2k/mEZa0l/GZx1
 3ZrCIHqeaJ72jor96Cb3jj3lRu9furVsLp7keXazg5hllQNfF24rl9lOv68pgBVfs2SNITaGG/p
 YWXv8ibrkiyy2t7dW8t8AyE4R10GrDVmDdZaStT0KUdHozpf2Wma82IOkD/wgDZxMkFAP75mlKl
 ietkPOLb2N70Rhs6s0mnmwmSvg+pAoe9wCVAgDVii5nlbllG7GCYPFWWAdsB5EAM6q3RET5yXVF
 +AwLP3ah0MzSZlvRC3A==
X-Proofpoint-ORIG-GUID: amw7RgdiJof81AMwlGS8QtxwQ-RW0Qh_
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab3a96a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=55tSWijHQoufD_vR7dwA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: amw7RgdiJof81AMwlGS8QtxwQ-RW0Qh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

Some A8x targets have a third memory rail (BX) in addition to GX and MX.
On these targets the GMU dependency vote carries a per-corner BX vote in
bits 25:20, which otherwise default to all-ones (no BX constraint).
Prepare BX vote field to pass this new voltage recommendation to GMU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0ed01ce1c5c5..2b66d6c7fd19 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1799,16 +1799,34 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	return 0;
 }
 
+#define GMU_BX_MASK	GENMASK(25, 20)
+
 static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 		unsigned long *freqs, int freqs_count)
 {
-	const u16 *mx;
-	size_t count;
+	const u16 *mx, *gx = NULL, *gbx;
+	size_t count, gx_count = 0, gbx_count = 0;
 
 	mx = a6xx_gmu_rpmh_read_arc("mx.lvl", &count);
 	if (IS_ERR(mx))
 		return PTR_ERR(mx);
 
+	/*
+	 * Targets with a third memory rail (BX), in addition to GX and MX,
+	 * expect a per-corner BX vote packed into the dependency vote. Detect
+	 * such targets by the presence of the "gbx.lvl" RPMh resource. The BX
+	 * corner is matched against the Gx rail level, so the "gfx.lvl" corners
+	 * are needed as well.
+	 */
+	gbx = a6xx_gmu_rpmh_read_arc("gbx.lvl", &gbx_count);
+	if (IS_ERR(gbx)) {
+		gbx = NULL;
+	} else {
+		gx = a6xx_gmu_rpmh_read_arc("gfx.lvl", &gx_count);
+		if (IS_ERR(gx))
+			return PTR_ERR(gx);
+	}
+
 	/* Fix the vote for zero frequency */
 	votes[0] = 0xffffffff;
 
@@ -1816,12 +1834,27 @@ static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 	for (int i = 1; i < freqs_count; i++) {
 		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
 		int index = a6xx_gmu_rpmh_arc_index(dev, mx, count, level, false);
+		int bx;
 
 		if (index < 0)
 			return index;
 
 		/* Construct the vote */
 		votes[i] = (0x3fff << 14) | (index << 8) | (0xff);
+
+		if (!gbx)
+			continue;
+
+		index = a6xx_gmu_rpmh_arc_index(dev, gx, gx_count, level, false);
+		if (index < 0)
+			return index;
+
+		/*
+		 * Find the BX corner that satisfies that Gx level, falling
+		 * back to the highest BX corner if none is high enough.
+		 */
+		bx = a6xx_gmu_rpmh_arc_index(dev, gbx, gbx_count, gx[index], true);
+		FIELD_MODIFY(GMU_BX_MASK, &votes[i], bx);
 	}
 
 	return 0;

-- 
2.55.0

