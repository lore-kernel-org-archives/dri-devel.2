Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED38606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IJWHGY7U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dsEhhARb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09995112A0E;
	Fri, 30 Oct 2026 21:33:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727E5112A11
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:06 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAfHg235923
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s64e3dkDh8b
 RM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=; b=IJWHGY7ULHQoU7QAD34NnNEBZPc
 G+dQ23rqwp0I2FrbXe7f282DSCnH5ca3O23GKsgDecMzjxrleYDlmwpauQO4OmMS
 P0jqAl3w4ne+orXJgLY+95FrDfFRnFbwgTIT3dR1mux36URKraE0wyXU5KlVzIBK
 ubX3ibe/MG781RJeYfpNu7XwgUv3veojHTUKCI1cDXQuP8QWxsqHvJfd8jabBN2H
 qs9VJe2JxyRHUDnn8MUepPKPFOb5gCOEKimik44nQwhCIVejyYIrrAfGx4XHWmWn
 RBBkdP5x22G1W5Dh/G6AvJd5mJzPY0XrA7QJICCjmRG5iJRLD4XBRENF15g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x004g8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae59682799so960216a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395984; x=1794000784;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s64e3dkDh8bRM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=;
 b=dsEhhARbT1d26QKctMB3DTVHxZnAXEflYMeIXJSvXw0S1xYlHwj78t8358Ny4BxXKA
 SUrL+xHa/I+QU+qNib61xiuQmnJjgeiAk0buqeESPUlQ6kCeY4fxHkyg/INNlty9G+iK
 IPUA/i7rYDgTviJEuDtehjZc8b905dI9nWdlELqt6rEqnJYIM7qoAOSxYknsopj7DT2L
 TmPBbO4YI01QsMILl1BKgH3Yq/F4ovkPpjRW7DjBpELl8e2JjwBGtyKkmaEH4hTTDyaj
 sTkNjNM2ZNsaVkvEVHuCm1VWhyx4pvpSqHZeLrRhKagYabshIDAaD+Zfu3ZBEZO6zDr8
 XtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395984; x=1794000784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s64e3dkDh8bRM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=;
 b=ocgJDi1qf3hgH0Xoh5UoCdHurqHXGQUOQJwuVoXpZdv+reaa7zOfDwjCkz7f2JjTPD
 N8UDCbzh6JSLJ5cNmWAFDczhqlPxRsTZH4XwDfHUt2zg/P76t/ydyduMtqRJp+tW7LAz
 pYb/aEKDT2Pzxk/hooaxJSFHJcqws1hN6cLmj0Fibl8lvZ2KNLTTQbxivDyV2woUgU9D
 Ftba522mW5zntqXvSBGBP0ovRNuoqScJBJXpcSsFTcn7iXmX0aV7e34Ck+kmG/Kugi5I
 87j71XQncFnOjy8psM3vlA/uT+xEJmclg5HAfyLSn4Ts9z1JC7jjkoiKEtZGhchTwZwB
 yqyg==
X-Gm-Message-State: AFq9FYItW+s3+m/0YsT8BqJao6RZ333olBBBY6JR29ZrVjKG27jiXkrV
 yy/ByDn9f0GZkb2JmZNZDl23RmtwtlyLbib6LNogawwRWE7jft5nCH57J0dEVirqpjzegWdy6De
 HTBe+H4kNiKW2OoOxQnmiikvZ4HWOd+ZEsqFeuHUDJoq9otfGWLGHIilAmZUDiS2+irv1efSyTo
 fkHq3lLQ==
X-Gm-Gg: AYBFou2diw0BVSzi42wNpB2LkKU3P62LGjnhlvdZ781DEvmNNpuN30ALrzJk/1RJ8lk
 KHgeBAhjHiEeHXMQxmlal8JGGVEFFErEupTLPxYk02k0y0SuVFXp1O8ZCsyZZhHeE5sazPiUlP9
 tLbt3m3UJP1p+pzbfwnGARQzNWZyg4BZcMkbCvMJ7dUX9dfYPPYtiU3NBj0bSRDcMobwQMpTa9M
 yu5OGRjgavcccsM9QGyG9FRAMIasHy8sogIWhhn/TXoL2ZJBBNprQJcIdfcAhzVoRT2gC7vHgMo
 Vr1/qTm/ZtUADjvVHSX5ZI0hBXZVpObkswglYdIj/2bkEqz94fd5TFTlpnF6EPAUO4/6ehWinal
 vt83dDv3pSP5GUSRHrnI88Z2mL15c/lmk6SqdUCXcyzjFQI5SyugR406oVpg8yjDT1SbQcKW2hy
 Ky0SSsrw1pVg6a3TuA+DkWeQ==
X-Received: by 2002:a17:90b:3881:b0:3ad:5c64:c7a0 with SMTP id
 98e67ed59e1d1-3ae89814e7dmr2877732a91.38.1793395984586; 
 Fri, 30 Oct 2026 14:33:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3881:b0:3ad:5c64:c7a0 with SMTP id
 98e67ed59e1d1-3ae89814e7dmr2877720a91.38.1793395984160; 
 Fri, 30 Oct 2026 14:33:04 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d5b8csm10255599a91.1.2026.10.30.14.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:33:03 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] drm/msm: Treat !mapped as an error
Date: Fri, 30 Oct 2026 14:32:48 -0700
Message-ID: <20261030213251.55365-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfXxpr0EHBbvf6O
 eUD2FjWiiErzCUvDFEpYMPpOPaYfEYYDBBTlwa4INnxypnYOKf5If7afQ6umMdoCz2fK+R2/5C3
 OBOM/z00pF6ckLlgf9Z4hBc1pgGlc55ugMZINIQYURyfLsgrlyuJZFiJItphHoyPejEMahqjmw5
 Bohc6zvaFdkoe86jVDHznqC2MmA7mcCYL4U4yeEx5HqBiEwQa7OQ1kXiHZczThCKE//Q/0u1SeW
 wUCARWNR7vQmVyHwEy6AuaHUXDdDCUcQdSxKMUlpe44tE1muZYcErKfrvnWAx55dArcO8biMonK
 P+eb7yQrRPoHgXm6pqLWDOcGEzO0coT/FfG9dYwnSc+eTC9nGjJ0p+A3H7VCMQK0i0u1/Y4g1FS
 ZJaFfHUCL6kma2lLSLBtm/JtpJ1+7kzFBXjgZr/2AUfxJxjmreQKFTrfcGG2JtKbW4BkkQp05om
 1XSZV058AoeN9L5QOeg==
X-Proofpoint-GUID: gZD3F1TX-_UVxO-Wh9vfqoVp9A0wUlSy
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae50d11 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=IbsCIv0Bno-BzyZ2rGMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: gZD3F1TX-_UVxO-Wh9vfqoVp9A0wUlSy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfXyYEUO/CoLJKw
 hopiN7I31W+sVLD2oLCgL5IEgKXFVHBsqibldsmUE3R9EJ8RwNtnxQLJNDY06lSmeifVPIqRgB1
 aeS/QjbKHUlIdDWabKOW0saK0fy0wiQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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

Rather than silenty mapping nothing, treat this as an error.  It should
never happen, but if it does we want to flag the VM as unusable.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index c2950d32c507..255972323f9a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -186,6 +186,10 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
 			size -= mapped;
 			len  -= mapped;
 
+			/* If nothing was mapped, consider it an ENOMEM. */
+			if (!ret && !mapped)
+				ret = -ENOMEM;
+
 			if (ret) {
 				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, ops);
 				return -EINVAL;
-- 
2.56.0

