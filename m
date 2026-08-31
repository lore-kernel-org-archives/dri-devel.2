Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A787C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07FD10E892;
	Mon, 31 Aug 2026 17:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEb6eX3j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TeSYbys8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A0510E892
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:44:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VGPTnS4073458
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tb6Old0Ag1lEg3tHScHhxpyXT5GNHcc8VNH
 j8DsUkAU=; b=jEb6eX3jnUvAy8R1MKaDv7FfFKGDl/Z/XmUmsi5jyYKmfoZQAof
 r1Mk2Mq+Ac9XmHMQbRgsBE59qcItpMqi+sari5jwEi/o4JwWBAdMLZcgCo1Z8dnA
 AqMA2lzQd2qQH/ry2sBOwc3vQKiTpHXNDdSprrIlnCu4A1+1An8e9mXVRQpHtz4V
 bjceksArlVmev6trF6dpTvBvJe7KB9LUnML2LQc0NksymODv9vz1ZSPYvaLn66pt
 PqWWFSX67ildBPbqWh/lQlfebXt9CWQBMNPgg/0NRKOiiBfma9Hil9h1lknSydKw
 fsrnspFgY5cgTo3Haufiv4KovjwE8Hy5Gsg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4drdt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:44:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso5324812a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788198267; x=1788803067;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tb6Old0Ag1lEg3tHScHhxpyXT5GNHcc8VNHj8DsUkAU=;
 b=TeSYbys8HKb6vALwcNQng0Ij3p2uT4yyQoslL71GLmhVYfwm9sbUhS4hiY/ZrGW5oW
 PvP9LtxKNsngFLDBe+Ycs1V4X5JZ6B43D0dcxAdfgZdjxfhcOgqBAtrqC26VqrVm3tr9
 i3TMwq6sY5o0RHNesMHMHYaclvJiNU1YA9MzVaJ98/VjOWoIEtvMmIvBmvAalyKU+Si6
 Rf05XDnWUkQjsPpNv0bkP9aDPqbaw3md8wedVkIMPHdNmnhaQaqoubtV/3PSi8EDL9fZ
 Gic3ryswWvXHV/Psg6aebYNCb8TkIhApf+eMA4UGAh1oNsRKoScpa+bxdQn2OlLa/O2a
 bGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788198267; x=1788803067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tb6Old0Ag1lEg3tHScHhxpyXT5GNHcc8VNHj8DsUkAU=;
 b=Az43ghrRaj+GPjS38WSRaU2hVlflHm8JswJWhXV4WM1g2CIbzGbsuxWDbAD71RzKE0
 2viO18iHb6Yg7QV05UAAiR23jff153Zj/+qL9deJ1UX74eYeCYO4CdzTCqvmUy1EVh+z
 YkpUMEMuyIUsSX06CkdviGapP0sM93a/mlKJ+Z8Q2ofZhTohbWRPqL1pPwS7rmhq9GOj
 iN4LevhSEiozlwE/KsqS88+smz2Azxl2kHnU0UIbZmwfQ3c4xavqswFxwqp3QP2RRNwf
 HP+PmZ8jHA4z9US/pUZ3BlK3eppGChqCBkIRnL8WpiPa6dEt4bSxZO2laDjBGEdSF1gr
 r3eg==
X-Gm-Message-State: AFuF++krnoWYvcWx8U44aI+9WjBGfHSFCkN1lhTD0TKhe+9R/NWod2KY
 mjbmx7KtWGksRYP5hs7qj1otHEnvZotUMRgrC3FBfxGc7Rq2qo1UdhL5UpoIvP4RsY41zsv0x3Z
 zs8S3sv4bIZM3VIeys+ch51/GZOass067He0BC1R9VFQsVdFM4ygNPwKSOBBS9pfv1mXN9RS9LG
 07CF0=
X-Gm-Gg: AYBFou3PTyyND0g377KIa4OU9G/ETr13n8kpfQVS4ceIrvKyx4CJLxCvpbAGgTEU6r5
 bOTBA3x8WGdamLlOSIfRU5S7E3zwUzMa8BW5gIymFxwHSpdN8AXuXYcQgcwoe9tzwpZDj+T4qGd
 ELeT1H/Ksj08QQvD2j+NCfODL1EZXQfOtg6oRQrtDuYdLChB4I+zAbAGiF1jZDXWS6i3WFnCMv5
 T1oC8lTAHyY7KpK78ohbu2GaqjQVQqv22YhxpZGNn2UpXqw/QEs2zI80Az5TIScX8SJWtGj7wE+
 UBLw7qk7FwkLOeTHxgVQp4E8WuLFGlsLGytlY/xvqSyhn1wvCIlB7x+C7sShkwlnYkqjiXvsJpi
 d274PDdFToymHjTGPVBWF9MTJrruxQrtsC1hSXkC2EX24Dbs=
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-396d0e5bbc0mr45970772a91.2.1788198267251; 
 Mon, 31 Aug 2026 10:44:27 -0700 (PDT)
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-396d0e5bbc0mr45970686a91.2.1788198266770; 
 Mon, 31 Aug 2026 10:44:26 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d4a1732sm630545a91.7.2026.08.31.10.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:44:26 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org (open list),
 linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display
 hardware), 
 freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display
 hardware)
Subject: [PATCH] drm/gem: Drop ticket arg to lru_scan()
Date: Mon, 31 Aug 2026 10:44:08 -0700
Message-ID: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a95bd7c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=tUov0DBtqpY1NIlP9OAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1MyBTYWx0ZWRfX1fem6krxBhxG
 uvN7le8Pp8BrXDVVDm6Mds92PA36hW9N9djOoBiPjivt58J9uyJxPgoP3pXyqyMCgF5ef3xIq9T
 WMTdIbKx7Nuzh47+RmSmKMraClr1EALTYGZZaJlGt3huunONaH3/eNyu4N28yTkWXzJ1iU147kJ
 fweC1gCGJewsDeQC68DmIvW0WqAdgUnFsJo4OlFmNyV8ky5iuXh01kNaNY6WZGYXJMcQPX+gtDt
 8Qlqjv/t1VRlopEMEKaySA5V1ZJiCSYlIyirWwNVD3lZjf/NeWXx/hwhDJHOVoKscA74YVB6NQT
 6lBroccwxdlXJ7dST9pnBqeeZE/OhVudd+0hw/Xf2JP1oyPoEJCRpDy70YcKtfXF247e+xLyjx1
 uYJc+jdJ2b0XrtcnifqwsqJ2ypNkcpBqFQV6xkXxuC5SaNButa5p92V+AgptyZ6WhrGE05QqEVz
 NjwbXsVoC++eLCvsnVw==
X-Proofpoint-GUID: zyJ1RU10BI8ht10AuUM7vrPLdjDSA5WR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1MyBTYWx0ZWRfX9xX1/imtG0DK
 Z8uEPbxBcUTspPoHCMG4rw4f1/ki4Cfhaju8conYI4Rz/1tdiWuG5d1nHoRT6W26sY5gBpUwgNl
 /wq2hD7q56mxMxaKMdm1Hd6O93Xvxmo=
X-Proofpoint-ORIG-GUID: zyJ1RU10BI8ht10AuUM7vrPLdjDSA5WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310153
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

Commit 3392291fc509 ("drm/msm: Fix shrinker deadlock") dropped the only
use of the ticket arg, but at the time left drm_gem_lru_scan() unchanged
to avoid conflicts with in-flight pathor shrinker support.  This commit
is the followup to remove the unused arg.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_gem.c              | 13 +++----------
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 22 ++++++++++------------
 drivers/gpu/drm/panthor/panthor_gem.c  | 14 ++++++--------
 drivers/gpu/drm/panthor/panthor_mmu.c  |  5 ++---
 drivers/gpu/drm/panthor/panthor_mmu.h  |  3 +--
 include/drm/drm_gem.h                  |  3 +--
 6 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e3ed684ddcf2..15acb958ecd5 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1656,8 +1656,7 @@ drm_gem_lru_scan(struct drm_device *dev,
 		 struct drm_gem_lru *lru,
 		 unsigned int nr_to_scan,
 		 unsigned long *remaining,
-		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
-		 struct ww_acquire_ctx *ticket)
+		 bool (*shrink)(struct drm_gem_object *obj))
 {
 	struct drm_gem_lru still_in_lru;
 	struct drm_gem_object *obj;
@@ -1690,20 +1689,17 @@ drm_gem_lru_scan(struct drm_device *dev,
 		 */
 		mutex_unlock(&dev->gem_lru_mutex);
 
-		if (ticket)
-			ww_acquire_init(ticket, &reservation_ww_class);
-
 		/*
 		 * Note that this still needs to be trylock, since we can
 		 * hit shrinker in response to trying to get backing pages
 		 * for this obj (ie. while it's lock is already held)
 		 */
-		if (!ww_mutex_trylock(&obj->resv->lock, ticket)) {
+		if (!ww_mutex_trylock(&obj->resv->lock, NULL)) {
 			*remaining += obj->size >> PAGE_SHIFT;
 			goto tail;
 		}
 
-		if (shrink(obj, ticket)) {
+		if (shrink(obj)) {
 			freed += obj->size >> PAGE_SHIFT;
 
 			/*
@@ -1727,9 +1723,6 @@ drm_gem_lru_scan(struct drm_device *dev,
 
 		dma_resv_unlock(obj->resv);
 
-		if (ticket)
-			ww_acquire_fini(ticket);
-
 tail:
 		drm_gem_object_put(obj);
 		mutex_lock(&dev->gem_lru_mutex);
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 9d2788f79ace..3514d5c84989 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -102,7 +102,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 }
 
 static bool
-purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
+purge(struct drm_gem_object *obj)
 {
 	if (!is_purgeable(to_msm_bo(obj)))
 		return false;
@@ -114,7 +114,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
 }
 
 static bool
-evict(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
+evict(struct drm_gem_object *obj)
 {
 	if (is_unevictable(to_msm_bo(obj)))
 		return false;
@@ -133,21 +133,21 @@ wait_for_idle(struct drm_gem_object *obj)
 }
 
 static bool
-active_purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
+active_purge(struct drm_gem_object *obj)
 {
 	if (!wait_for_idle(obj))
 		return false;
 
-	return purge(obj, ticket);
+	return purge(obj);
 }
 
 static bool
-active_evict(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
+active_evict(struct drm_gem_object *obj)
 {
 	if (!wait_for_idle(obj))
 		return false;
 
-	return evict(obj, ticket);
+	return evict(obj);
 }
 
 static unsigned long
@@ -156,7 +156,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 	struct msm_drm_private *priv = shrinker->private_data;
 	struct {
 		struct drm_gem_lru *lru;
-		bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
+		bool (*shrink)(struct drm_gem_object *obj);
 		bool cond;
 		unsigned long freed;
 		unsigned long remaining;
@@ -180,8 +180,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 		stages[i].freed =
 			drm_gem_lru_scan(priv->dev, stages[i].lru, nr,
 					 &stages[i].remaining,
-					 stages[i].shrink,
-					 NULL);
+					 stages[i].shrink);
 		nr -= stages[i].freed;
 		freed += stages[i].freed;
 		remaining += stages[i].remaining;
@@ -222,7 +221,7 @@ msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan)
 static const int vmap_shrink_limit = 15;
 
 static bool
-vmap_shrink(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
+vmap_shrink(struct drm_gem_object *obj)
 {
 	if (!is_vunmapable(to_msm_bo(obj)))
 		return false;
@@ -250,8 +249,7 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
 		unmapped += drm_gem_lru_scan(priv->dev, lrus[idx],
 					     vmap_shrink_limit - unmapped,
 					     &remaining,
-					     vmap_shrink,
-					     NULL);
+					     vmap_shrink);
 	}
 
 	*(unsigned long *)ptr += unmapped;
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 54535bae2b0c..17408f832af3 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1392,8 +1392,7 @@ panthor_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 	return count ? count : SHRINK_EMPTY;
 }
 
-static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
-					       struct ww_acquire_ctx *ticket)
+static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj)
 {
 	/*
 	 * Track last locked entry for unwinding locks in error and
@@ -1479,8 +1478,7 @@ static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
 	return ret == 0;
 }
 
-static bool panthor_gem_try_evict(struct drm_gem_object *obj,
-				  struct ww_acquire_ctx *ticket)
+static bool panthor_gem_try_evict(struct drm_gem_object *obj)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(obj);
 
@@ -1488,7 +1486,7 @@ static bool panthor_gem_try_evict(struct drm_gem_object *obj,
 	if (dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false, 10) <= 0)
 		return false;
 
-	return panthor_gem_try_evict_no_resv_wait(&bo->base, ticket);
+	return panthor_gem_try_evict_no_resv_wait(&bo->base);
 }
 
 static unsigned long
@@ -1503,13 +1501,13 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 
 	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.unused,
 				  sc->nr_to_scan - freed, &remaining,
-				  panthor_gem_try_evict_no_resv_wait, NULL);
+				  panthor_gem_try_evict_no_resv_wait);
 	if (freed >= sc->nr_to_scan)
 		goto out;
 
 	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.mmapped,
 				  sc->nr_to_scan - freed, &remaining,
-				  panthor_gem_try_evict_no_resv_wait, NULL);
+				  panthor_gem_try_evict_no_resv_wait);
 	if (freed >= sc->nr_to_scan)
 		goto out;
 
@@ -1523,7 +1521,7 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 
 	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.gpu_mapped_shared,
 				  sc->nr_to_scan - freed, &remaining,
-				  panthor_gem_try_evict, NULL);
+				  panthor_gem_try_evict);
 
 out:
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index e10dbd18d8cf..ab070bc74857 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -3133,8 +3133,7 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
 unsigned long
 panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 			     unsigned int nr_to_scan, unsigned long *remaining,
-			     bool (*shrink)(struct drm_gem_object *,
-					    struct ww_acquire_ctx *))
+			     bool (*shrink)(struct drm_gem_object *))
 {
 	unsigned long freed = 0;
 	LIST_HEAD(remaining_vms);
@@ -3160,7 +3159,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 
 		freed += drm_gem_lru_scan(&ptdev->base, &vm->reclaim.lru,
 					  nr_to_scan - freed,
-					  remaining, shrink, NULL);
+					  remaining, shrink);
 
 		mutex_lock(&ptdev->base.gem_lru_mutex);
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 3522fbbce369..abc36e7204be 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -52,8 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
 unsigned long
 panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 			     unsigned int nr_to_scan, unsigned long *remaining,
-			     bool (*shrink)(struct drm_gem_object *,
-					    struct ww_acquire_ctx *));
+			     bool (*shrink)(struct drm_gem_object *));
 int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
 					struct panthor_vm *vm,
 					u32 slot_count);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 8a704f6a65c1..ffa607c91aa2 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -616,8 +616,7 @@ drm_gem_lru_scan(struct drm_device *dev,
 		 struct drm_gem_lru *lru,
 		 unsigned int nr_to_scan,
 		 unsigned long *remaining,
-		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
-		 struct ww_acquire_ctx *ticket);
+		 bool (*shrink)(struct drm_gem_object *obj));
 
 int drm_gem_evict_locked(struct drm_gem_object *obj);
 
-- 
2.55.0

