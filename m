Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A6C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 20:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB2D10E027;
	Sun, 23 Aug 2026 20:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="TRZ3c307";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Sun, 23 Aug 2026 20:56:54 UTC
Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E70F10E027
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 20:56:54 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=gxqPYChqK2WZhq2+aWTnLqgJWZH99pipqmeeppQldow=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787518612; v=1; x=1788123412;
 b=TRZ3c307BBD8Ua551swxJ/Fx8DflyIszhiUclxSDVEQSqLXvzblg3MRIFnQOGS8FJMEAxb+C
 vNBCDdlTUjRnuqfYMxvcLvU8crIH+4lPgCJ0kgDaVju4n8GrA64XkHeKiURSEqw95w82e/96Cxn
 Buquuf4LAVelj+txvSSJmnFs=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from fedora.fritz.box (62.216.208.217)
 by smtp.migadu.com with ESMTPS id c201919d757f101a;
 Sun, 23 Aug 2026 20:50:48 +0000
X-Mizu-Trace-ID: c201919d757f101a
X-Migadu-Flow: FLOW_OUT
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Fix memory leak in query_perf_config_list()
Date: Sun, 23 Aug 2026 22:50:28 +0200
Message-ID: <20260823205028.178597-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=thorsten.blum@linux.dev;
 h=from:subject; bh=gxqPYChqK2WZhq2+aWTnLqgJWZH99pipqmeeppQldow=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFndsSKr1zS+fS/dMz9856t9G/wftZhzfpx4UMyBZU/Sw
 rwF/jPTO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiYg8YGTZFrDd3SOTyF2bo
 fSAvvvzrtx8+egHPHZWOB4fdd2ZNkGFkOH+z6cKE0kMeLxoXiajMepv87vVruZUVpqqlJlHes4I
 7WAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When krealloc() fails, free the original oa_config_ids before returning
to avoid a memory leak.

Fixes: 4f6ccc74a85c ("drm/i915: add support for perf configuration queries")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/i915/i915_query.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index 0c55fb6e9727..11157fb14db3 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -403,8 +403,10 @@ static int query_perf_config_list(struct drm_i915_private *i915,
 		ids = krealloc(oa_config_ids,
 			       n_configs * sizeof(*oa_config_ids),
 			       GFP_KERNEL);
-		if (!ids)
+		if (!ids) {
+			kfree(oa_config_ids);
 			return -ENOMEM;
+		}
 
 		alloc = fetch_and_zero(&n_configs);
 
