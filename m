Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DD2C982CC
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A3110E231;
	Sun, 20 Sep 2026 02:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Yitws3sn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB5510E231
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789871049; x=1821407049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IqUBZm6toljkW8k8/5I7a+UOAFzxtA6+GzC6FLqeYzE=;
 b=Yitws3snA7GaNoGKiiRhLPpSwl7qvekycRZvC2inM5FkVtOrQ5kx2jmJ
 Sl31LHDdj7UzJJTwhkRkhUHocpU9SvZsq7IwZGt52sRGj+pJTq/eV5f61
 /jbWn4cYoB9AzmD/1RZd7d/m56R83yx+TBzSpSYSyDdfckZkW6xZZ0neI
 9WNkAcZ2h5Dce7HpoPzH+MnLvDmgCMgNIQ2Dlpz2asCae5zWqP6VvhML4
 VBnERP2IL0vQUjdPQApUFUWFJl4b9SCMb1+tlnUg615AIlzX/0J3VFczU
 2y2xfTSThPF0kk2qizt2a5E5gEpWJKgc2XZsrjkQoh3OUhJXI/zXHVLLf w==;
X-CSE-ConnectionGUID: 8DEV+QkkSKao8dXMjs4NCA==
X-CSE-MsgGUID: JjwVIJo8TYaGSlCwbnh/WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="90510467"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="90510467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 19:24:09 -0700
X-CSE-ConnectionGUID: gV3ovOUmTZaF+9fzgE2Fdg==
X-CSE-MsgGUID: drMIYFY7QVOUkithbUoFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271629567"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa007.fm.intel.com with ESMTP; 19 Sep 2026 19:24:07 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com, David.Francis@amd.com, jani.nikula@linux.intel.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
Date: Sun, 20 Sep 2026 10:21:44 +0800
Message-ID: <20260920022144.2209244-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
References: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

DP v2.1b specifies that REMOTE_DPCD_READ and REMOTE_DPCD_WRITE
transactions should only be issued to downstream ports where ddps=1
(device plug status indicates a device is connected). Issuing these
transactions to empty ports (ddps=0) is non-compliant and causes
problems in practice: some MST hubs NAK the request, and all hubs
introduce a delay waiting for the transaction to complete or fail
before the driver can proceed, increasing link training latency.

Guard drm_dp_mst_dpcd_read() and drm_dp_mst_dpcd_write() with a
ddps check and return -EIO immediately for unoccupied ports. This
avoids the spurious sideband transactions without changing connector
lifetime semantics — connectors for all output ports are still
created at enumeration time, regardless of ddps.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>

Changes in v2:
- Instead of skipping connector creation for ddps=0 ports (v1),
  keep connectors around and guard DPCD transactions at the
  drm_dp_mst_dpcd_read/write level. This avoids changing connector
  lifetime semantics visible to userspace, per Lyude's review.
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..b7fce0bf8 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2161,6 +2161,9 @@ ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux *aux,
 	struct drm_dp_mst_port *port = container_of(aux, struct drm_dp_mst_port,
 						    aux);
 
+	if (!port->ddps)
+		return -EIO;
+
 	return drm_dp_send_dpcd_read(port->mgr, port,
 				     offset, size, buffer);
 }
@@ -2184,6 +2187,9 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
 	struct drm_dp_mst_port *port = container_of(aux, struct drm_dp_mst_port,
 						    aux);
 
+	if (!port->ddps)
+		return -EIO;
+
 	return drm_dp_send_dpcd_write(port->mgr, port,
 				      offset, size, buffer);
 }
-- 
2.43.0

