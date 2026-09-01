Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F657C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E1010ED99;
	Tue,  1 Sep 2026 16:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BYbptYnR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVz36T9F";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D26710ED99
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:45:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681E8XXG2145823
 for <dri-devel@lists.freedesktop.org>; Tue, 1 Sep 2026 16:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=F4+C391BtjP1q9S4/6jLnVVE0nXicN8iK+S
 OD5Ru2jI=; b=BYbptYnRlz12I23yNM1lPLO6n9SI4boNZcLnsP4JGRFxjZw3OFP
 IHkHaG3RdS1Jkfd9xxDUVULG9ISl+B0T7oQ6mM6/FKXRDWSdzLTykYjlCSEYmv5h
 zpt1jjZb9776JZIADbsYSsJeBUeUtw64GogK2anQ6gTU+xc8tCNVP+AyEHWHSKrN
 8J+ERZSsHfV1zYZW0FtbxU/LHSAavrdPMtPlMrp1GZAD1mnKKxKUKTo1ve/9/Qnq
 DnqKU5PtgSW42gETvRGKuPpO2v01bl05Gyw7OesoGkP6EPk1vDrcFsZBYfde2wHn
 ylS2ujcj4AVXMIMTqZYCnYGc/+pZo4HuvPg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8uyvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 16:45:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-851992f22ccso29546b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788281151; x=1788885951;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F4+C391BtjP1q9S4/6jLnVVE0nXicN8iK+SOD5Ru2jI=;
 b=SVz36T9FK2hvwumnENDp/h56sJwm4hF5y5FHw5x7vKI7PFwwl/tPQkNY6F0fapeikm
 8ikUbwSS2YoQLnUA01aYP6v6UV6qm1yg6dxQ8EYK0qZBVWRhAoyfNkeQdNU7KYm9Sphr
 CYHg/LR78Cdy9TUh3z6oL7z7GJNr/LahYt+Q4iV4F+kjaRJzh1CLiccb84L6iWJ2Wr+H
 9YnpPBmcEdBcLXF1inQKBvtu0+f3oov2umthUR5jQRHAEthuzMZv/vDO1K6wBEYUAgMr
 GyOijlRHzKzhfPrYPiN57PfupoLHS//Yl3Epqtfgzq3dmF960kbhqcH7ADnSZP2YvvCa
 pMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788281151; x=1788885951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F4+C391BtjP1q9S4/6jLnVVE0nXicN8iK+SOD5Ru2jI=;
 b=DY9xXAmAWqkLMbV6Kc8q7YwxmJVWmFM4cpHOE8RFwlJsuYi1NX6BVuVhWqO6CRgGdE
 CX/hr7/Ysl7baC+lKkxUhXnS0cWcvtv/VYtBCZsWC4MnX8WIVsPKJwtw37GSaTgRQicz
 g3MEBDgcik35QYmx87YJ6JShr/1jcyObEWT/l6GBi0SuAGJxRHwFzX730XsVpx7vgsLB
 kG8usb+8SYO6K7EqjjTlWoAwe9VCY9Y1/8iq+rRQytxeJNsXVnBiuzlPaXhVoiXoBSFo
 o8znQcffWjzHH6EWK8jmf2RyGc4kTA5YKhSg8/dFSOQ3gdNbWsLVHa7X2qrIN8TkYiE+
 elMw==
X-Gm-Message-State: AFuF++nkB9RBnc/nw+FUJy+W4EHxSERjxv5G1nvO0+phfNpga3uX9gB0
 nbrZwv0rd/sNeZuP74sXwj1NSfStdazn2S5FLFbf5YWSXxSYYdaiNVUTg3Hm5rvSC/tnpkt4WnN
 tEBKdj80JfEQksCHfggMZG3sl5FuF81rtINK9v90XR20CKQ4F0gx+N9D+BZuxRWeVs98y2N+c3i
 8+nOs=
X-Gm-Gg: AR+sD12MhcXlFGb0bNA468mYfAmwelT3jKrRseKggFhmsDyRqWl9Nxbs5Wb/8ZcKKkq
 4HIr4WG7Sb4BKE5Uua22kFOE2VxkdpYZ3eOXQfoMdZAh+23z66MbLF7jN6bKOjP8dvfNgWVuaYP
 miyEIs5DGBJ4YyvTc/7X4/BjXMzSS2L1SmZ7H9YCD8dEN1VWG0iP3+Eet7OIRbk+vDuTQVVXtnq
 gvlDvRxZTL2cXeWQqYkxm5O08VBo731156d6Eh6xfzU3CT+yPQHBORdf96r3QOjDftF8KVz5jG3
 ux7xER1X2iNkf6ZS4S3rLnvSd7y2KfbLz7RD3hWb8yMgg+pSzW/QBFfplYz5JN7a5WbU+KPFBXT
 7bv0n2m3h66qsJh26RLoVPyj9C0TkKwBlaplDgCG9vLtiiyE=
X-Received: by 2002:a05:6a00:4649:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8562a1f6c2cmr52567332b3a.7.1788281150958; 
 Tue, 01 Sep 2026 09:45:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:4649:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8562a1f6c2cmr52567209b3a.7.1788281150271; 
 Tue, 01 Sep 2026 09:45:50 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc11fbc41sm163898b3a.60.2026.09.01.09.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:45:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Steven Price <steven.price@arm.com>,
 linux-kernel@vger.kernel.org (open list),
 linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display
 hardware), 
 freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display
 hardware)
Subject: [PATCH v2] drm/gem: Drop ticket arg to lru_scan()
Date: Tue,  1 Sep 2026 09:45:43 -0700
Message-ID: <20260901164544.642985-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a97013f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=7CQSdrXTAAAA:8 a=CpjeYB2KrTrYpFnhXQ0A:9
 a=OpyuDcXvxspvyRM73sMx:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NyBTYWx0ZWRfX3JfzXtjFpX92
 +M+sI5ViGyrYQChrtTUhAXyCpVxEdCfZNa4JTJNl1klvB2X2xPSEuBsQxo1cJvNcK3D279odH49
 Itl5z/ENW2NjSV6/dl4nJxfUfUvKh5wttLJlUpTOJznW5ystgGxVY1pTHlks4lpk7Ki/oAHjOqG
 imm7eiP1CEJzOrBNpEPui9kdkt1DXD1XcOYSTOyfK9Dy52mVW5cET6yF6EXiEHd+V7zwXZiTG/k
 SISAWhQK2YkFWB359ntxJk/jXSp2HxXMQqgzj6FgBeAJ5QVg3QF+J6UBlJumfCVGtxNRXxX+MuI
 GKWIyK+0gC2VrL7VxtMeydvAyS76wTjdg28KpgsrH/NCxQ31n6GYozDLsdESJp+hHRdqp8YOSDN
 nBZUsrBOHaYcWtWhFvwYYgm5teWYGUo/CzZEFOhs1Od5KWdgLqnwD7+ISTxpLSUwzet+EXohnwm
 PxgUc8ja+7c+DiYvD2Q==
X-Proofpoint-ORIG-GUID: dNJR_2RWGxLiE8Rb7-sG3_j72m-KgM9i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NyBTYWx0ZWRfXzAyoBwN1hkdU
 1eWW2Ut+AuVUSHiH/Tlg7yzgmHbqDNBgDts3S+9iTtbv6VaH7h75VdSY3XXmxtY88I03Fe+1x9s
 SaqD/DSddWUuyC8Ym5XvMc7TQ4j3x58=
X-Proofpoint-GUID: dNJR_2RWGxLiE8Rb7-sG3_j72m-KgM9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010147
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
to avoid conflicts with in-flight panthor shrinker support.  This commit
is the followup to remove the unused arg.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---

v2: Drop left over kerneldoc param description, fix panthor spelling

 drivers/gpu/drm/drm_gem.c              | 14 +++-----------
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 22 ++++++++++------------
 drivers/gpu/drm/panthor/panthor_gem.c  | 14 ++++++--------
 drivers/gpu/drm/panthor/panthor_mmu.c  |  5 ++---
 drivers/gpu/drm/panthor/panthor_mmu.h  |  3 +--
 include/drm/drm_gem.h                  |  3 +--
 6 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e3ed684ddcf2..3113b4a53b99 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1649,15 +1649,13 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
  * @nr_to_scan: The number of pages to try to reclaim
  * @remaining: The number of pages left to reclaim, should be initialized by caller
  * @shrink: Callback to try to shrink/reclaim the object.
- * @ticket: Optional ww_acquire_ctx context to use for locking
  */
 unsigned long
 drm_gem_lru_scan(struct drm_device *dev,
 		 struct drm_gem_lru *lru,
 		 unsigned int nr_to_scan,
 		 unsigned long *remaining,
-		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
-		 struct ww_acquire_ctx *ticket)
+		 bool (*shrink)(struct drm_gem_object *obj))
 {
 	struct drm_gem_lru still_in_lru;
 	struct drm_gem_object *obj;
@@ -1690,20 +1688,17 @@ drm_gem_lru_scan(struct drm_device *dev,
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
@@ -1727,9 +1722,6 @@ drm_gem_lru_scan(struct drm_device *dev,
 
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

