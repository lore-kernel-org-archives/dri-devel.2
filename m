Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C2FEC11B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6135F10E189;
	Tue, 24 Mar 2026 22:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJAPU+pY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c3NvIInf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089A310E189
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCeV6989019
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IF7sm6F9k2U6hKgZiGl+W/MIYZz3asqaIEZ
 HCpg7snA=; b=fJAPU+pY/CmU0q85qCBPCNS3vAhNPTZqhzGSNkY1LXGwSwvYkRV
 bY2Wo295vdqSqpspOWVhFsZZ/4RON+4FFJu6YBnWKNg84NNGsfXepHMSRIGl9ICt
 iAtEsW3qxpKLh1YPNYFmTGqAYpxIumrOvoiSNu1kZckP3t8LI0zvKVHprVpvE/BE
 R+DcTJ4zsvFa5qGcypysrAj/NqBimRZm3GNN+S2TZ+UX61wjYhxdtIipWs++Ge6e
 30x8VgSnMiHUZPQEw1C4o4gJnMj2g7ZYy/eik/cQc0W7YGez/sUHXxg3ZIljSfmh
 1YBqFMjAzvhCEOA2ThIFiDT9vsE0690DHXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m21n0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b051befbb8so55021065ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774389926; x=1774994726;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IF7sm6F9k2U6hKgZiGl+W/MIYZz3asqaIEZHCpg7snA=;
 b=c3NvIInf1G1bnX1hfGORnBGmUUPXqjPmypcrTFbgWGkjgI7y7UAJFDb+tBODbtPaOO
 FGye5QuPIW9YMlM27cQ392Up0foAJn4U7XD3CXSg+7kkgTpssNAdnHg91/TmHXQslKt8
 MsnfNM5wQ+364caAOTwHAs/SgWm0FRL18YPmHq5DL/7SczoOy2Vl3sOJlGvune3mYg9O
 HGplQns3n+oHJwLbjrSgiKukoETVmZB9AkbG8ArIhCRNvlo0D5Vkg1dhhuBsAIiECmgY
 +X8hc16f6NJ4IfI3zDKVwiGXJHZFKl9Y8DXIKGFjqGM6XvsL4VYWdSxkSe1FN7icxkxp
 LFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774389926; x=1774994726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IF7sm6F9k2U6hKgZiGl+W/MIYZz3asqaIEZHCpg7snA=;
 b=N623rV/2Ejj1Q2wbaNUo6gr1xcrsrZcYHCEIDSzJ8xGN9C6meqoVQ4xd2Ap///TrwY
 yOSFxaQQjbxPZlsDQ4yNxeFeZCtHiQZPgGxZZSAdeoy2LRP8LIM/KsIa8JTEYCzXNelT
 ns2Hf6ogpkiZmBZK2CPDBmVaosVJU34muDF6bwk5hNA5YeJto2JlIs8iYP91DnD97Fyx
 rZ7+LqqABflNgkiAqHedeNwqqEpq4LiX9WPHvGKichemfRrFg6HQYxEzUD9wjc4Mk2uS
 Yv1Dl4s7iKcEeagl7b4ovWZu3W/yAd+i69Q1dz5JdGc1U0lh7nZlzLNsQGW1AW35L6ye
 UhIw==
X-Gm-Message-State: AOJu0YyqH/gAWInAwVT/n7nxq+zpA8pa9Bb7zQ9Yt55MEkVsZkRJIqUk
 A/EJU8mfKvYtoZ8RgrlK+m8XDLhPHjVHU5vZ2ms8T2tAjhu9LsG3PHfbb7CmMDfQhjJRBlsv9Qc
 cyC/kTRfIVR44esEFN9zxKM8obDNlNKamMUdUVlB5TsNI/YjHQJElc5f2DPB/XAin/tE+11TU9t
 Q4SlA=
X-Gm-Gg: ATEYQzy4VlcLLRIxBGOik2EAttXj6/UvvldIu5HeZcCsQ6ptWBAAknVWxu6pKjNFZEX
 LQe3xFK1Fc4uaJ3wO+xInLeKVd9K/lCZPpQoG+360dUW21nwPWzesmGTDMHWGPtcq+JL/zOaLP7
 +I3Y3HpCEJnGsNYgCAFt0IAUh9cnLoX98b/x9q4stufjr3QeahYF3rSuuMmklk2ZHf8xnJ47DSr
 WaDNyimYJ4IqFEM0AIigR0U5xfbd+Nz+A5NuD2UzdJHLc2z8BnrrjS5+G3me6brbBjjRRA92cVa
 MWmazipBjBUnCDX0BOW1kEWkBkyVpTD1e9gv6TqoK87SM/xsTHspBafy0S5y+4bzqed7xePO2il
 ZKmv1uwW1FS4aDkDZYtIc9hP8XDDkIYCD
X-Received: by 2002:a17:903:3808:b0:2b0:a957:302 with SMTP id
 d9443c01a7336-2b0b0a03c9emr11997535ad.20.1774389925313; 
 Tue, 24 Mar 2026 15:05:25 -0700 (PDT)
X-Received: by 2002:a17:903:3808:b0:2b0:a957:302 with SMTP id
 d9443c01a7336-2b0b0a03c9emr11997335ad.20.1774389924853; 
 Tue, 24 Mar 2026 15:05:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516400sm154973585ad.11.2026.03.24.15.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 15:05:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Disallow foreign mapping of _NO_SHARE
Date: Tue, 24 Mar 2026 15:05:17 -0700
Message-ID: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c30aa6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=rycHe8qCt1V8VBfbKgMA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: F29PvpETgfQcCFYKxGuMsX0qnYazAo-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MCBTYWx0ZWRfXwI30bObsUMnG
 e8BHnCqv0AS84QxmLFd0GKqBWVT2nXJa36IjegPIYt1rOjlIxpLzzVoBPTHlbRsNrixI42fXA/t
 U/8507b4MxEjpQ3cEhhr1aro9p3ex8aUHdn4vybt+KzD7Kkv1H70jIMLD0V6Clbg01Lz1x9VGti
 B3+BbrRRGnja37ucjQhhPW6olWQGqBqg0tvieUB84oN3vi6cgxPx7Y8E6mRCkV3gnQbXM3ABGT1
 QpUaGTrZBdj8/xG1+O/V3VVM5A5dRa0Xn1BLuT2NUhuE5Y9p/4obqUiFqL8N9rHcTYB3HPRrCLI
 5aaCv2gxhEdlBD3DuuxlgJDjUjNa+/hqUqtN1BjTpclg6JDPmig72hKdQ7jrDlOf1d2EynJLsKM
 /gQmzhgx1eD6ejAGtUX02AaGEONriFtA1Nibu0VZPsStPYkfGB33n0ZQZ1Opr59rehuysmZwDSj
 ZzHvyl3gNYWzgZAfp+A==
X-Proofpoint-GUID: F29PvpETgfQcCFYKxGuMsX0qnYazAo-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240170
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

This restriction applies to mapping of _NO_SHARE objs in the kms vm as
well as importing/exporting BOs.  Since the DPU has it's own VM, scanout
counts as "exporting" a BO from outside of it's host VM.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
v2: Fix issue with MAP_NULL

 drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1c6b0920c0d8..43d61e0919bd 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -373,6 +373,12 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
 	struct msm_gem_vma *vma;
 	int ret;
 
+	/* _NO_SHARE objs cannot be mapped outside of their "host" vm: */
+	if (obj && (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE) &&
+	    GEM_WARN_ON(obj->resv != drm_gpuvm_resv(gpuvm))) {
+		return ERR_PTR(-EINVAL);
+	}
+
 	drm_gpuvm_resv_assert_held(&vm->base);
 
 	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
-- 
2.53.0

