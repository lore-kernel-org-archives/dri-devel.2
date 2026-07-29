Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC62C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6D810ECF1;
	Wed, 29 Jul 2026 16:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ccZL0I7o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A824710ECF1;
 Wed, 29 Jul 2026 16:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8916C600AA;
 Wed, 29 Jul 2026 16:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B262C1F000E9;
 Wed, 29 Jul 2026 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785342784;
 bh=GYLFiDFsWgnuZLLVzeRXadaPHD177OU5vyLefNhw9pQ=;
 h=Subject:To:Cc:From:Date;
 b=ccZL0I7oU7gJO8SbYYNgsHXpG7s1CiU3VhQ4YrjOPqT0s2Blek9DBLM28OYTavFRf
 o5tF2aOSlpjxv5ArXwEI2LTZ0JLilF7ZfQ5aXFUf/nHb+J6ruM+c+Jtp3CnV2SXCjJ
 zqXEm8JFxkwYTEfseS0neENFUl2bUFPLQ8bVAX6I=
Subject: Patch "drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()" has been added to the 7.1-stable tree
To: dev@lankhorst.se, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, imre.deak@intel.com,
 intel-gfx@lists.freedesktop.org, jonas.emilsson@gmail.com,
 luciano.coelho@intel.com, lyude@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 18:31:43 +0200
Message-ID: <2026072943-lullaby-tapeless-796c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_queue_probe()

to the 7.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-dp_mst-handle-torn-down-topology-gracefully-in-drm_dp_mst_topology_queue_probe.patch
and it can be found in the queue-7.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 613059875958e7b217b250ed14c3b189f9488421 Mon Sep 17 00:00:00 2001
From: Luca Coelho <luciano.coelho@intel.com>
Date: Mon, 22 Jun 2026 17:03:58 +0300
Subject: drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_queue_probe()

From: Luca Coelho <luciano.coelho@intel.com>

commit 613059875958e7b217b250ed14c3b189f9488421 upstream.

A hotplug or link-loss event can tear down the MST topology
(setting mgr->mst_state = false and mgr->mst_primary = NULL) concurrently
with a caller invoking drm_dp_mst_topology_queue_probe(). Since the check
is already performed under mgr->lock, the condition is not a programming
error but a valid race -- the topology was valid when the caller decided
to call this function, but was torn down before the lock was acquired.

Replace the drm_WARN_ON() with a graceful early return. This eliminates
spurious kernel warnings and the resulting compositor crashes observed
when connecting/disconnecting DP MST monitors, while keeping the correct
behavior of doing nothing when MST is not active. A drm_dbg_mst() trace
is added so the skipped probe remains observable under MST debug logging.

The existing WARN_ON(mgr->mst_primary) in drm_dp_mst_topology_mgr_set_mst()
already catches the case where the topology is initialized twice, so no
diagnostic coverage is lost.

Fixes: dbaeef363ea5 ("drm/dp_mst: Add a helper to queue a topology probe")
Cc: Imre Deak <imre.deak@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jonas Emilsson <jonas.emilsson@gmail.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/all/20260503034533.1023686-1-jonas.emilsson@gmail.com
Acked-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260622140532.526722-1-luciano.coelho@intel.com
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3740,8 +3740,10 @@ void drm_dp_mst_topology_queue_probe(str
 {
 	mutex_lock(&mgr->lock);
 
-	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))
+	if (!mgr->mst_state || !mgr->mst_primary) {
+		drm_dbg_kms(mgr->dev, "queue_probe skipped: topology torn down\n");
 		goto out_unlock;
+	}
 
 	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
 	drm_dp_mst_queue_probe_work(mgr);


Patches currently in stable-queue which might be from luciano.coelho@intel.com are

queue-7.1/drm-dp_mst-handle-torn-down-topology-gracefully-in-drm_dp_mst_topology_queue_probe.patch
