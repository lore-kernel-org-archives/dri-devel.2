Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B1606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpxg33ha
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7D210E667;
	Sat, 21 Nov 2026 15:47:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42D910E3D7;
 Sat, 21 Nov 2026 15:47:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CAFA45718;
 Sat, 21 Nov 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795276041;
 b=SEtpyNy82YZA3jONWZH9AOnWosOTBKYDhZHUlIlGR4bcCqDh+Kyr0RCFFy4CxsMuAPxG
 I3sGQbXo/Oe8QqfEOyvxMSwy1P2nplHKBggTHV4Mg05J+cjEtGxYWWkQtkjqf1gjkEe6S
 6CC6i8+PniN22rm2J6fQ4GLSPW97fl/6WX4fx2o9sxRoIhvFI9Qeeh/Dk2eHFnERYBHAG
 tt8dDnKY7A8x3nFO5gSZHM9wgWCvOH60E+uR+OdBuNDxsWrFikOGp1dQBWV4i0gEw1A+q
 OtMI8DcBepfrj69behnJazk4dsSkaVqg3h8l1z9sd4REgvWjH+vI196vSvBPnNjSChA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795276041;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=HBSWhLpR35zo6U9WT1n8EOKDBlN1p/otYxjn8MP/fRQ=;
 b=TjwS5QkmDDaWI4lEHjIRjjs56esojNtXgycXcvuVSqnWSrDFS4JgEhLePJdokvr76kTG
 dTRGT7HlF07TqulwKMmrzo3eYH1MIC+KjlR+UXe6Wa3Aa+Sll0BEp1ni1UMOMo+1LwltP
 eEi/7ywH91qSeogH3DqgCpHIbOzOlQAMIj9RvvZ2B/0qhkaeAxiuC2Bs104rHH6H2TPBO
 JuojyzJnNd2EUG2ATRFy9qZQbodFtsjmHttovwK/892q2+9HRf3GhSHZCjaob1e4ZxlNG
 c4WBoZyhYhGJzp/R0ujBnl4bREXbVPNPEofKrHx3mwMIM5qsSShynFtHou9qw8Erj7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 341F81F000C0;
 Sat, 21 Nov 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795276041;
 bh=HBSWhLpR35zo6U9WT1n8EOKDBlN1p/otYxjn8MP/fRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Gpxg33ha+v9iHGRDw6xSauoDB76NnuOPvsdksrFz4xgApTvYISu7qRpboEIe7dJRf
 MBuwkgQhlUrdw/PFmHGNqyB9eek4sr8Tb1jhc6jq7Qwj9c1Z5KJP5apQFTslDj1awZ
 rfc7btW74JNBMe4xgXJfBv5MkJfSuGcmZOZARiD9bj/DNwK+G6bY0BDF18YdytzDw/
 v1wToL23BM6vW/Eq6oLIwy4sKZMXU/TpKByA3PtbjvCfI0rZ7E6sD2e7Ywjh1srfje
 F6zJr+B9IKfAYgBAfAyxOoCjGC0rBQLlMaKj1LtpSE2I5oO3mf8Aq3QWnvp1R0xV/E
 f+fPzNJ456nQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B78644BCEE;
 Sat, 21 Nov 2026 15:47:19 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:47:20 +0000
Subject: [PATCH v2 2/2] drm/imagination: Don't truncate the layer count in
 max_rts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-pvr-hwrt-common-v2-2-9f53bdf954de@gmail.com>
References: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
In-Reply-To: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
To: alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Cc: donald.robson@imgtec.com, mripard@kernel.org, 
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 airlied@gmail.com, simona@ffwll.ch, tzimmermann@suse.de, 
 linux-kernel@vger.kernel.org, imagination@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795276038; l=1689;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=o9CYMe+Nds/S6RqTPnGZR4pVb5VMi2qOsqYHSAh9ASQ=;
 b=PN14VgJ1BlQIAM6U2DDGPcc41e4M99u6xxvK7PdP5tg6I+L4uPQ7E7sFuRL3LGTzVG0sXYRYO
 GaQLLPkM09JCMD0/KyVPn0DA24dRqlagax3fkHUkAfs9xwScNAyCf6S
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
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
Reply-To: shyckless@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suyuan Wang <stevewong@hust.edu.cn>

hwrt_init_kernel_structure() stores the 32-bit args->layers from
userspace in the 16-bit hwrt->max_rts:

	hwrt->max_rts = args->layers;

hwrt_data_init_fw_structure() then allocates the SRTC and RAA objects
when args->layers > 1, but hwrt_data_fini_fw_structure() only frees them
when hwrt->max_rts > 1. With layers = 0x10000 or 0x10001, max_rts ends
up as 0 or 1, so both firmware objects are leaked when the data set is
destroyed or its creation fails. Any user who can open the render node
can do this with DRM_IOCTL_PVR_CREATE_HWRT_DATASET, and the objects
grow with the layer count.

Make max_rts a u32, like args->layers and the max_rts field of the
firmware's struct rogue_fwif_rta_ctl, so that both checks see the same
value.

Found with a static analysis tool and checked by hand.

Fixes: 6eedddab733b ("drm/imagination: Implement free list and HWRT create and destroy ioctls")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
 drivers/gpu/drm/imagination/pvr_hwrt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_hwrt.h b/drivers/gpu/drm/imagination/pvr_hwrt.h
index 676070b20c3b..7c215e2bd35a 100644
--- a/drivers/gpu/drm/imagination/pvr_hwrt.h
+++ b/drivers/gpu/drm/imagination/pvr_hwrt.h
@@ -74,7 +74,7 @@ struct pvr_hwrt_dataset {
 	struct pvr_free_list *free_lists[ROGUE_FWIF_NUM_RTDATA_FREELISTS];
 
 	/** @max_rts: Maximum render targets for this HWRT data set. */
-	u16 max_rts;
+	u32 max_rts;
 };
 
 struct pvr_hwrt_dataset *

-- 
2.34.1


