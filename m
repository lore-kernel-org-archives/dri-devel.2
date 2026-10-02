Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89317CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CC010F8D1;
	Fri,  2 Oct 2026 15:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LI+BHTHw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iLujUyjK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0077510F8D1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:29:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGcb81042848
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lL9LxccpmF76VS5eD8CEC9JA6/zL6aQP1sNdFqAIvMc=; b=LI+BHTHwrZxYR1kW
 MOD0uRHAu2a2R+tGgm7fqGsjl9rY5l3h/BBn7UffV8FsInKTJcegICwMXsX6PviP
 Xj4dRlrw3rftrYfscS558V4ktad6EM9IuitUQ7jIQK+JgcK5MgbeesZB2f9xwSdL
 OwSYeiHVD8bRuGIZ+f5jZtqfq59Hjfo/xhnX3OPz4+RfjbU0giWebmFLHdnO30vT
 7UwERaKi7pCVq8raIO04PWo/gW9eEev1Y2ncGAs5MinzfFVABvK4lJRDP/dwWvJR
 2Sr8WAUXVYeLvjnd6JZdpbifiWgu9mM545YRLxiFrGIXasSCEl26/E3FNfzKSNgq
 IsWjRw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdgc04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:29:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso47298a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954995; x=1791559795;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lL9LxccpmF76VS5eD8CEC9JA6/zL6aQP1sNdFqAIvMc=;
 b=iLujUyjKbsMmaAkKVXoHA+LPu7EVS/J2ygvbQoOh+NVXuLUi5K7gedlA8nOaNSZUWf
 eYc7j29KaGKxV66kUS1YRRt7zUvGezZ+fQtiBFjGyXuFfm2NxB2jPOHbE/GJ4c6iLxbk
 fVpQpBs540vO4jK6/JoFRcxegDMLvBpzzLgk1nRWn84xHUY5fcR6vhRleYXm71mbs7ks
 TdgBwD59wkP23fzFW3yMeFv+HsNseMRY9iNVPeTz7KB4om7InpUNyaVS3G/ddfDpSsqm
 BwugOe/wKvSQNicYjiBY9CHU1aLQCU07/1bDcdGSgWr1prb2IrAMPnCo3+F3BqSrXBtH
 hQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954995; x=1791559795;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lL9LxccpmF76VS5eD8CEC9JA6/zL6aQP1sNdFqAIvMc=;
 b=EUSUeBN2qSim60KYHH3K+KBGuQ0gQZERAOqQwi8eLgwcPh4312dTEcihGQzNLQIyNv
 44CmCcy1pB+rl0iJDmaDgZXGrDvFnSz0ekQxwiIfGFqCzbXs93R/hViHpNd9aPwKeCbm
 OM2TNGYJlNe0dZMYBqKCVwi+LVzLILv4Y/4bynNMcph2euS0y0nEHKQpgxdQwol02+2b
 jNNYSQPzYltv1FJVyVeEyHF9MQIJXLNhHJ6DatIIEF9z4sN9OYBGK90XwJwfcAXJN2/n
 PVmP1EwId7IEtrwEs0BKNJ78Uf//7XfWBTaPNY7/gyXWezj0RrjffHvz3FrDg8XT3mc6
 SLOw==
X-Gm-Message-State: AFq9FYLxSAwQVLOYjfDWr0VZvU1uG7bzRAXfjz2q3SEWV1eOPOaCuJtY
 WOzpGjF71cKbEGwhdYVZZAYhj841geYV7naH1SDzmg4HM6L9CvYZAOK4CXg9ANlsDi7ybJZNXB+
 AhjGekiXqa13/QrwGUrAqd/GMEtGSi/Ni5bfhAsYHaeotJcbUYpPJH3o7MFANIWobapqKaOz8rF
 6aDmc=
X-Gm-Gg: AYBFou2xnU+Sci625Hnew7C4xyZwgMFeAR6I2FNrwALpGG2xbcGbnhL3ylbIs5klPUL
 hQEoZGAwe70NcH7u3AKXvb7NjEfHaGBgpmFNQiS05qKGySwWUoKBBP7WLytU7eYLl/hyzZV5bpj
 f7Xy4dwT0yVzqECFVctehDRCUPcnpVH2V78lCfDVIM6tpi3W982RYpqOVoosBt49oKAK8ohOb03
 W82RQ/LKn1Dz+ebLIv5BFkW5WI9y5cYmZYo5CGSEB0Lz5B4EwFvAcfrT6ExR5dJxh95pR4CAtVS
 GPGR1BHq0AHxX+xgVPgUHDzahBtaRp0PLFruUNKz+MVy7gxOQ/VRiB8HfnamPeRTUgDF7c7IZcM
 dfYnIxdzZa76fF1p39SmrZ8ODqcL3tHQSZM/tsv0az8pK68g=
X-Received: by 2002:a17:90b:268f:b0:3a4:e735:b3a3 with SMTP id
 98e67ed59e1d1-3a6cec8cd26mr1765388a91.40.1790954994387; 
 Fri, 02 Oct 2026 08:29:54 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:3a4:e735:b3a3 with SMTP id
 98e67ed59e1d1-3a6cec8cd26mr1765372a91.40.1790954993839; 
 Fri, 02 Oct 2026 08:29:53 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm9657791a91.9.2026.10.02.08.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:53 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] drm/msm/gem: Add helper to check if resident
Date: Fri,  2 Oct 2026 08:29:38 -0700
Message-ID: <20261002152948.85308-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX5CLq486Ju7L0
 TKOyNc+eqsBFcSTEDF5ZSgVoGZIA9zUUlLVu4SaOZU2bQyeXW3QyWOTXXzu7Mll4tRLNJCDJII/
 jREqVjInNPcg8V/1hJnWMAmUC1wS3mA=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6abfcdf3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=Ql1oLI5ppxrsW8Emd60A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Vg8yZPlVbIVCSzvl7OBhut_QzS82r5Go
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX3MdQO3Dd0Vb7
 /JdDU2AH2aGEB4NZtJtjgJv7Es0HqSgHP9Tmbj1dAorQffkpYYTtLUHpUupWgh2fVEw5oDE+SEg
 k1Ab9T37tzgLtaiMYBEu4jrLz+y74e9mtoyvCNEN22R590jhID9v6+9YTqEXAM/8+uD51PsTT7f
 Sju9i3+foWWl53UB3Q34OOdr+iJNca/BHqif1evNwO0GzSLKrXMs7EmtKF3eUszk1tkfopn5PVi
 +Ov5yciI1sC0/jBUQcCSbm1Srq2Ev+DOZ1s4M4AAPyhhB6LZCUDVQQjIROt2TKItauVdoA4Nn3Q
 4xvV7/WgcPIvrYovwYnNmR/kDfZrbDPaQzsuYjmg9b05fzlE+TNYK7iEDVMQuBWhxjl0N3LOW90
 /APHiPldN5iAmil9M9Nh27lzZ78FMMXo15Nx4Ju1xBZPvnn+BBAbtz9FoRJ8jE78uhoWbXAiw0f
 uMFXMwGw17j7fHaZaGQ==
X-Proofpoint-GUID: Vg8yZPlVbIVCSzvl7OBhut_QzS82r5Go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

Mostly we don't care about the page array, mapping/etc works in terms of
the sgt.  Add a helper to prepare for allowing the page array to be NULL
for imported dma-bufs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 8 ++++----
 drivers/gpu/drm/msm/msm_gem.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c4cff3d53d81..e8390ebd5dd5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -147,7 +147,7 @@ static void update_lru_active(struct drm_gem_object *obj)
 	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_obj->pages);
+	GEM_WARN_ON(!is_resident(msm_obj));
 
 	if (msm_obj->pin_count) {
 		drm_gem_lru_move_tail_locked(&priv->lru.pinned, obj);
@@ -167,7 +167,7 @@ static void update_lru_locked(struct drm_gem_object *obj)
 
 	msm_gem_assert_locked(&msm_obj->base);
 
-	if (!msm_obj->pages) {
+	if (!is_resident(msm_obj)) {
 		GEM_WARN_ON(msm_obj->pin_count);
 
 		drm_gem_lru_move_tail_locked(&priv->lru.unbacked, obj);
@@ -949,7 +949,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 		stats->active.size += obj->size;
 	}
 
-	if (msm_obj->pages) {
+	if (is_resident(msm_obj)) {
 		stats->resident.count++;
 		stats->resident.size += obj->size;
 	}
@@ -1172,7 +1172,7 @@ static enum drm_gem_object_status msm_gem_status(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	enum drm_gem_object_status status = 0;
 
-	if (msm_obj->pages)
+	if (is_resident(msm_obj))
 		status |= DRM_GEM_OBJECT_RESIDENT;
 
 	if (msm_obj->madv == MSM_MADV_DONTNEED)
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index dff60cbc9d95..73dafe080bfd 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -419,6 +419,12 @@ static inline bool is_unevictable(struct msm_gem_object *msm_obj)
 	return is_unpurgeable(msm_obj) || msm_obj->vaddr;
 }
 
+/* Are backing pages/sgt allocated? */
+static inline bool is_resident(struct msm_gem_object *msm_obj)
+{
+	return !!msm_obj->pages;
+}
+
 void msm_gem_purge(struct drm_gem_object *obj);
 void msm_gem_evict(struct drm_gem_object *obj);
 void msm_gem_vunmap(struct drm_gem_object *obj);
-- 
2.55.0

