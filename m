Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18B606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dzSRXlqL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yh/pn+jo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFC910EAC7;
	Fri,  6 Nov 2026 23:23:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E02D10EAC3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoUlO766841
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kova2M5LKwq
 QTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=; b=dzSRXlqLtK4tSo5oFnZgVnDk1Ep
 FXJmzS+1FKMfPkunILQbwcGEZmfYE+eTJjGYQ0jXfsxL118+tgFesmGw/CDBf6ZB
 G3QGZULoizNlT4AmUpWB91MPwYgvnnnlPK4KMD5PQ1VmDdcBg/EsP/jQJ7YYoKjB
 nAIeyhYQmWMUK2AMF3ZkFkk4yZESG2UwjdVy5KGpKp5AVg13zzws1e+Nmuj/vIlf
 ywKzDP7odkFaab9eSJExiro9b5+RJVNKvibBzz9aK1nRYfhFtErtNMaGYXGIihbv
 O1+mdVgOw46sSYZTqmlUXeSRp1kRewEFLGz8JEB3aTi9qHk9qovfdbCF/zQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48s8rc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b0a098dbc7so806739a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007370; x=1794612170;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kova2M5LKwqQTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=;
 b=Yh/pn+jowMGY57CQGjGf68wy69Ut8ciVY7ZI9ucX8Bv4V14C9F9UbtVnEuG8PYblx3
 FKrB6/OESg4Vs19ObQC0S5IAgUtSF5X91qgd99rBZ7PWzbnJ86ShKG0IPF6Gp7/QJrCH
 RmgR5zvhwLvHJn/Q95ITiFgJKDdk336B92B9WqTfntVp+bn6u0WzjzxTkvSNtLDUh8CL
 yz115rig5L4wR9EwmHyZdFx1mmR7qL3s/J03u5vPAaPxTCXVzdgZk/H98LfbJ4GVTvJ0
 l+6RnH1D7JW4uc7cgs0k1i6M72OjBnL1pDgY179Pn/OdpnvT+oHWUDPI9lP1y5Lbpy2L
 OXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007370; x=1794612170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kova2M5LKwqQTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=;
 b=ieCaJ3O1Hr8iVhi8JfKCohUCeZVy+YH0ZSykNr4DruKqw+U2OmX6zjy7GYiG/rtYiJ
 J6L+Zvi/4pX6TUUTkD/ydDEUkPCB8nDKbEA0SsKjQLACxftUvL+ZLzdQB5YMr/AjnvLk
 hpRiNIWXgIgNjMKzsMvi228E7MJ6a915qQUrRXQ1Dynps0SqLzTJHjLrPxyancdb2vKx
 kamYxRe17hpT8jWX+BjGkuIHSZKcPhZF+xR1szGilly2pPDz0GCjFIPSEitbqrAiPLYv
 CDhVGtsLQ26BVb/5iwm5e3Rar+JDuksmM142O6Dff3TnokzT3D1IrL7C0KlUSp5nPVFj
 O2uA==
X-Gm-Message-State: APuU4Z8vXL8pIFr5Lu2A54QHJ/FB6eI3RQJhPhIK7O6b9d6HMnqGuu6B
 5Iqy+4jDxzmb7Tys0TUK33an4i/weJ6KWyDzvj4DbvQVJWO9FpnNbbQLT+y2QndSljV46E1cqfc
 Iyt3VtP/HUsy4LItPIkkI3mhAG3Fq/O0d02J4Fkj0eKM62v8s9u/1PVRooWR3Mirdp5Bf7rXePw
 37vDc=
X-Gm-Gg: AYBFou1AkvS9K0MPCg4/cukMrthgMAbLV3JFp9Is4KjwdMYr7VGiFly4GPYW0GhLQsI
 bdvKs62XBQPa3auOOh464bPwdobbF09+m26IoA/3kKhwetsRp02E0oS6wUa1SOvm7OvYjg8dbya
 r540WQ5eeYjbhGwXGp6wDSZR3Ck+mAcF+8tJTM0ogdpYPTi/D71er6i7sjJmC5rg4Xp3ib9YNXu
 XfNGeeJHtuORCExunROFe+WcAsP7jF4o7h9+jbfrmNyE/Xpla6xVSiH6JyoCddO0E7YkOqj+dOv
 Ibcwlmxi+ZnJI61jeSYu8kO56c4N5h7nqFu1ElPL5oqU3gHFNXPRf+RJFnwH1pUfu/cY0iV5q+3
 1hmwXpAqNpIy0DVghJG38uSg0qBj7ZBeevAfbzhcHGh+yF23xG1kPFlAgTNAGOwzAKeyAlwmGSm
 eS8gApiHBCwghI7lBIRvOAwJTJu4NnxjGWhijin0f5v9leUn6UTYnfO0WmHTE/Cg==
X-Received: by 2002:a17:90b:3ec7:b0:3ac:8af9:4a77 with SMTP id
 98e67ed59e1d1-3b0db6d78f1mr3995908a91.10.1794007369635; 
 Fri, 06 Nov 2026 15:22:49 -0800 (PST)
X-Received: by 2002:a17:90b:3ec7:b0:3ac:8af9:4a77 with SMTP id
 98e67ed59e1d1-3b0db6d78f1mr3995881a91.10.1794007369158; 
 Fri, 06 Nov 2026 15:22:49 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1057c2bc8sm664748a91.3.2026.11.06.15.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:48 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 08/15] drm/msm/adreno: Fix PROTECT span length
Date: Fri,  6 Nov 2026 15:21:00 -0800
Message-ID: <20261106232220.47602-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfXxnTwDvzCJvjp
 Q2D0ZSx45hsWuCH5XDFghcu+EkFwXUIm+zNBNbYvEHjPQYQ4N4TmapOoW+1fMk1HVkKMHT/3vOF
 augasMB1O0kvYTMbmUnNKyNql72TmLiNxdGbPC1ooZc7J4ptoMTJ6Ga0YJWg2jyOVM+UmfgYHJh
 wXILxuXifd4Do5VpEOOP2pfWIBGMb9JwJ/IJ29uoOSeQNjJTj6ijaVi+l2c35KYLMr5eySK7z7+
 AlSLGazhGn7w714E69COyDYiNqlUnscDrZnAwLP1dpF//GjGXax+wocdx2AfKmaczAW5Z7Bm82T
 vM8AhjlRG4XjNHfjtBkHGD2vdwYtUqW58Ay5Rgw8Cqb/0gI5CtNeI4BQ8BY9P0lY53vR9k+stTV
 Q9oCrbEZMyTNmzvz/70EgYBaeGte34851n4Ed/22HZKD8uPdJ2rMli1qegXTCYaBcGemDCnSbQq
 FqWJxiu5pP+pR4vonlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX58gApKcgEjPT
 j9wGwFuAw2f37sbFx6MQCCfK8D0O1WBo9cEshtnICRYvuKhf3kEsQ266DxEK24OD3A4dWivBU2b
 vpQs+Sb7gpO1MUWoeQJdyj62hx1heRo=
X-Proofpoint-ORIG-GUID: mFwGtQ5VU5qn20vmtNZdyZy31YjJmezW
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee614a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: mFwGtQ5VU5qn20vmtNZdyZy31YjJmezW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
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

Don't let the length bleed into b31.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 4a3898e58aee..cfe7a3ed44c4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

