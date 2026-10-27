Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A634606A33C
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FdWgw+Pp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c2Pcp6pt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F8110F880;
	Tue, 27 Oct 2026 23:05:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E96610F890
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtUYC3892869
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vX8c2uJChbI
 30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=; b=FdWgw+PpXn6J/CF4tNwu9METkaf
 QOA+pcwLyluXjhQF+3OJS0UDlabDf2o2G7FeMUNyckMZmcFpNrv4p1XCVqjux15W
 sScjrlgYJH3nh0atMIn2Iqp5B2Lb3pTq5pRijRh6z5Yw4v5dvLR8yjDXroRSWkF9
 KZkG/u9ITM0/UiQg22jZP4pBTq9n+AiaCQuy+Eab/cd2RySO1XXJCxelOzCDHIRi
 GQxSqFlXMH0FgOyNm9Bj7Cq/svdlKA2//r8N4lZmrR2SxLv6gYwdhW8BZazEuvQC
 sGXdyc8SH4grJKVJ8ZmTQFIo/0d4E64Nvabgtnkvqzh/EXZ7sCVYARIlRpw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw23k8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae59682799so79779a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142317; x=1793747117;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vX8c2uJChbI30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=;
 b=c2Pcp6ptsfwob2uorgKXYGFT0vNckp6VwEMGKpvJj9DAb0xs66Egm9q643BESztuGX
 Y7w4LgzB8DDRKnh105L0f4mKugdObDM382UOy3S0Uctl3kBxaXYxnWdy1EiJ9h6253dk
 71cWHiRgohKBRK4uHT0gBSEDjatN8qmYuC9b7y+pOcgvAycOK1+lI936irjEUE5STdC9
 U5iaTaChYbvcwMmnAStf//ERfoKcvws7w0qhH0Jd59qCN4LpgaqOquNUUFimu6SsdD/m
 JPwNdZkDezt7T+ExGTylRTBCfw/5Tv7zrfNUaSV8BwBLiXifpjVE8E4epH2k2F+gqYR5
 sdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142317; x=1793747117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vX8c2uJChbI30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=;
 b=Rp7kJuZhXLpqslHe6ZnFFc68PfadoSuG26GUAGpwW7urpJdRkIx/6zZX9J/mMv93rQ
 URqx1dcAwfzxiSNf6raiK7e6DU1/Am+1GMdIiyiuQBfvpjqR0O9AsMqLVr2vTtt5x1gm
 P50FRIczdXZWmGdeZ6Wl4xNPxGNnoTD6sIsV/JUlkCbryr2iQNgh5yCjE+SqbtiZ1n1y
 ++73ImEv7o6ZeBXeA9IJjhpCo7f+qibDnOwQ/s2r2nRvWi0BMKvMO2W9musJLp4NQHS3
 C1I1EGKWwO7LyGz5B4H/nM4P0NA6HjBWdVczv77KK/NOYb145IwEBuhdkfH7lWfhJfNI
 39Qg==
X-Gm-Message-State: AFq9FYITYwSr9i5/YOE8J+bSSrezlATiBlXZ8dfAxiRxV4W5XXzOSsAR
 qrRIJUorDHBnFbJ4YsJl3/qE2Q67jS7nvGVi01XZKkHEx0XjC6TLBctRKKh8yKGkVMbJ5NqoMWk
 W3FlcA9djaU+qScM43T9QJUdU1AyQjCz4yM/CZyqnCHWXSdNkQHyypjnJoqoFEW8OtIk3c8fMW4
 eVqEQ=
X-Gm-Gg: AYBFou2y+GsGdfveSXKi8h1zrc5qdJIroMLpORn6qcnWxXJ6IeuR5BK7A1zSn5BQwoX
 jJC2c19KbHBnmbMSGmrDkcEY8Mlf6yvn9eTZELiRpIw9cg31NwPV1fekhgwlqtu/wIiFgq9VFDP
 s80n3s4lixsp9IVKi+NjF8VYE96I0ZqS8MeFAEIZWoxDpSrzRbKXdZVcEtvWeFNRvKpPaU2AI93
 JzlRSprVUkNU0NPmg3M1n8po4OPzrLkBi6/EkqtwCrhkocIR0eNkyz5Ze/6uIwmkLDXGpArqpBj
 sYo1UblAqmjkLfQr/beLbPxRcaZxfz6IJwIFvMv2IKzmRgqf91wyFU6nivVShvFNyC+ZcSf81US
 HipYmBuytEjt8YCoNYpTOuLcgoddJ5zSSF6rJFTIq4fg4NZeubA==
X-Received: by 2002:a17:90b:3c12:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3ae57f9b47bmr336475a91.19.1793142317194; 
 Tue, 27 Oct 2026 16:05:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3c12:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3ae57f9b47bmr336461a91.19.1793142316753; 
 Tue, 27 Oct 2026 16:05:16 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae55a6859bsm510639a91.0.2026.10.27.16.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:16 -0700 (PDT)
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
Subject: [PATCH v3 5/6] drm/msm: Convert map helper to use dma-address
Date: Tue, 27 Oct 2026 16:04:48 -0700
Message-ID: <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX7yB88fWsfJdt
 jfOcdT/QZdhwXb7DDOXe4u+/EOGmqOZekECe1nZUrok9MEXi+r12UkCS74CAItm83UTwG3n+xsY
 T6VGTtvfjC9eMIYh3S1hsWdk1bxonXIExU5G+LkylbRlByFo3A2GkZor+Cl4KlgDMccY/m/HFtg
 kObqvH3hdJT4wjvQjggmzTfoZjIk3bL2uCjToUpZ0eXHyTjnhw+qA8AkoogfKlWiQHeYLiibZnW
 Y9Nc+8/Jiqyl25SZDw7pgHwAhGQ2EPR+IV94tJaPTFJbelUoistYcxHVtmX2fv6KQI8gOEFZkG9
 yXvigUkgUlwGYoyzhY0gBMe737K67RLrM9h00hLVkZY6sx/O73HMNUcqqTf2EZYDaeTE3Tuap2H
 9A8uKaVpuDkQ3uZjzyshumZbDJUKLr1c+4Soc+LTZnOkpEC40kYaGZRaS/iRcz+d/fLNVTqJUpO
 mmSWcMSlhVNe9xZ36Vg==
X-Proofpoint-GUID: uywNLL_roGNqRUlFGAhM2vPbLT6A9uw0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfXy4mB13doHX6R
 VF1ZDBw0ej/sXApKW1VC8l5IK7InHyVbn0NkuOoncL2Pm5ayx+EJcA9Yr4c6bDlnRTN5EdoH995
 Y65ejU9wrv7yVRov3peJgTgptIJJf68=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae12e2e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=I_bc3XnsTyL_mMZFCHAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: uywNLL_roGNqRUlFGAhM2vPbLT6A9uw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270093
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

Now that we have everything unified in one path, switch over to using
dma addresses for setting up the mapping.  This avoids issues with
CONFIG_DMABUF_DEBUG stripping the pages from the sgt.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 479e5450a4dc..c2950d32c507 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
 	u64 addr = iova;
 	unsigned int i;
 
-	for_each_sgtable_sg (sgt, sg, i) {
-		size_t size = sg->length;
-		phys_addr_t phys = sg_phys(sg);
+	for_each_sgtable_dma_sg (sgt, sg, i) {
+		size_t size = sg_dma_len(sg);
+		phys_addr_t phys = sg_dma_address(sg);
 
 		if (!len)
 			break;
-- 
2.56.0

