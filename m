Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E460A5BFD
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPBcaMU/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A861122CF;
	Thu, 29 Oct 2026 13:36:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D8011229D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB02A605C5;
 Thu, 29 Oct 2026 13:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96401F031E1;
 Thu, 29 Oct 2026 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280983;
 bh=QILDmtc+8nRjK20h4sM+a1liCuVnE6PjgyOAFWW5stY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aPBcaMU/wwLRX0GNiO22rqEM2EdpKXp+KioUQI73hp/O/xDd3ZSBd1QL0c6tG9H2D
 /sVuhWSH3XcXEB2QB3HraFCkkZ7Jf2UHjI8gvAI3/it9y17+whyYa8OCfWETHMRoyk
 8wxfIL8iPJoaExXclyw7EHsCtfPo+gHivvZkZejyLPiEyp3qnKrbnvzOKXQj1K7U2/
 vrPohnI9EYUBemTSLR5vodLuvJqmnwMVUxbPQxgi9KiA0WrQiAISwncEDsHV4Pn1ks
 Mg4U8XljFNEcmDYuEK7XaHyO12hsTs0P4G8bpbXmpkudG67DBuQ/TnzEj6SaU3hnOn
 piA8+47/g+3JQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:54 -0500
Subject: [PATCH v4 07/31] accel: ethosu: Limit perfmon counters to UAPI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-7-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The perfmon creation UAPI has a fixed eight-entry counter array, but
only the hardware counter count limits ncounters. A device reporting more
than eight counters would allow out-of-bounds accesses to the request and
perfmon counter arrays.

Reject counts exceeding the UAPI array bound.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_perfmon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
index 0ae2df3ceac8..2a9b3cc1447b 100644
--- a/drivers/accel/ethosu/ethosu_perfmon.c
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -165,8 +165,9 @@ int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
 	int ret;
 	u32 id;
 
-	/* Number of monitored counters cannot exceed HW limits. */
-	if (req->ncounters > ethosu->npu_info.pmu_counters)
+	/* Number of monitored counters cannot exceed HW or UAPI limits. */
+	if (req->ncounters > ethosu->npu_info.pmu_counters ||
+	    req->ncounters > DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS)
 		return -EINVAL;
 
 	/* Make sure all counters are valid. */

-- 
2.53.0

