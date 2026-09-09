Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6ADC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3540410E1A4;
	Wed,  9 Sep 2026 13:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkDwwsHi";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF76010E1A4
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:18:13 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so9393255e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788959892; x=1789564692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=R4bCu5HRDrBYxQ3ZQ5U942enQUCmlULb13io90gargA=;
 b=QkDwwsHiDD7m9CdKR3a4sD3t2uHiyXhWlXSm2Lx5FqvNsoVZ7konNXJWwVsottgh3/
 nAWK5QTPzf/ByDi2rvd/FjvBt91hgTAVZwZjC303RQXs7R/K6q9N7HKlHI5qSMyMgy+Y
 1PyejrEkFLW0661egAAz6CrUDLOQIevYdt3YIMrXTUr1uIgUlCMnylhrYUCCGCd4a+UG
 1bD569m6TSbM49s5JJRQ3DOSdW1lRfKIzFARGWVWwYpNrqTdEYBekgifY76bsG8w9u8k
 azOOsSQmDajeybYpcVWKO3uZvx8Xfp50u3Kd6EzFmOJ5SybOPhOaLHfG7+nIuLdONde7
 DoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959892; x=1789564692;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4bCu5HRDrBYxQ3ZQ5U942enQUCmlULb13io90gargA=;
 b=tGKSEAgylw3X3ZoJtZmaGhTkHPdyaAuClky7ptgOCHL286FQJnZqMBLtO4gG8R/ixX
 9mv6A7Gmzt4g+1tvu9vMMWD2wo/QnPaUO/1qSFgTV3pbeux3+8n7cbWfKT/+h6OQ+JS5
 hiV3Sgnf3m5Z6L33sTh713NMcWURMVHzasPW3NGm62phVwMj7IOD4dNfFFf/2Sh5RQIU
 p/Aq8Is1N8SDUT9op6YWnHZFy/WFw9+EPf4OUVIUBgEUNSF947mU36PGxP72wIZHnsT5
 U+JuOaQtpBOB1HyetPCrolrZjHtEfae27sHtmSEDtxJqKhVFEcueBzvEKmOo7HMLhjB3
 l7hg==
X-Gm-Message-State: AFuF++mq3RxN1fp2k2+/7UnPntQ/wN2k/dyKaqXAT/kEC+XM3O0HNAa2
 seFD2/eRjZ/Xc5eOV5Z+ZwyQAdAk8eL+wE3D12AFq3Bb9QWD4JxKjoWe
X-Gm-Gg: AYBFou2AIuQteofQ1ZB0Z2CuwKh+0jvM5Hncti08KwrzGghm9r/WiMghw9D7GO5RwYR
 2mcEzrexc1OlIfTMKYDDAmo+5BW4bwmK0eJ/KKj39+qj/twBPWW1IGUbaPdk3F7TC5bo4FZaKly
 10LEvq3TJaoXiLPzetD0W275kK4cUeKbSbqlZXh3fGHyJX47Q1ppUpVIbEpSinCq77dUD18cEnG
 cST+o1nFh8Pj1OjG0gQKYdE0oVYswBiwbUiPF1Q5mOXl7hdOHFUnYNdXixezc9Idic5ijSp2bN1
 8vU09j3RuTY6zs/roC4ErVkVSG42MSxUuEXqsw0BKJe8QTMpe3ZdKf7n/6Mmfb29X5w/pVCm0Ca
 sdRdZ1+30+GxtvIVe4BO7bvAskmPqWuG1YJ/hnwfZQ9PgBIAJfV9T5gud5DZFug2Ept24Ovgfpg
 8hZdtZZe7NUR4+GAuWfjbJhj0HLf3hUi3qaYMI7mJCnipouHSkqMO8Q8mZ0QXAwfuOCXYzVfjX9
 NUPAre/RLNO
X-Received: by 2002:a05:600c:b8d:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49d1754e950mr144997695e9.4.1788959892008; 
 Wed, 09 Sep 2026 06:18:12 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1568:cb00:7389:2b93:7e4e:44c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm555457755e9.15.2026.09.09.06.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:18:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: [PATCH 1/2] dma-buf/dma-fence: fix checking signaling bit for
 timeline and driver name
Date: Wed,  9 Sep 2026 15:14:23 +0200
Message-ID: <20260909131808.2201-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909131808.2201-1-christian.koenig@amd.com>
References: <20260909131808.2201-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The patch "dma-buf: dma-fence: Fix potential NULL pointer dereference"
changed the check to test for the ops pointer instead of the signaled
bit to avoid a potential NULL dereference when the ops pointer has been
cleared.

The problem is now that the ops pointer is cleared only when neither the
release nor the wait callback is implemented and this isn't true for a lot
of dma_fence implementations yet. So those implementations lost the RCU
protection after signaling of the returned string resulting in potential
use after free.

Add the signaling check additional to the ops pointer check so that we
have both the protection against NULL dereference as well as the RCU
protection after signaling for the returned string.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 035219a760ed ("dma-buf: dma-fence: Fix potential NULL pointer dereference")
CC: stable@vger.kernel.org # 7.2+
Reported-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
Tested-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 05090fb0fd5a..e92f9df8d63c 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1170,7 +1170,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (ops)
+	if (!dma_fence_test_signaled_flag(fence) && ops)
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
 		return (const char __rcu *)"detached-driver";
@@ -1203,7 +1203,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (ops)
+	if (!dma_fence_test_signaled_flag(fence) && ops)
 		return (const char __rcu *)ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
-- 
2.43.0

