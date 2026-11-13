Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD565606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op/RFEmk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30F61122F0;
	Fri, 13 Nov 2026 09:03:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5AC10FE76
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D268262633;
 Fri, 13 Nov 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560575;
 b=uS0fcRaKc393tnN6F/9zoXPyKwoGcpacrjivPQWun0jkFQdtCtfwGaGMBAYUpg6mtmkq
 vw1Sdf19cAEatNOA36WnAv4NdsMXeYz6tBezHMJcDNeoKy8CsBqK6AstS6Vl2xXTUE9AG
 qhl/8E+57rzGEoZ1amFDfL7DED508a6Y0obd5EOfQVlv0IfCZFykh6q4IMOnOumbccqOj
 4Oh++fo4bipBaPnEOqCBuBfiyy4ub9THYmS+w5WXiaMBWtM4Vb7TG1iOF758A2GHK/ZnS
 R3cduYYvvoZqs/9lL258ru5RKzgqL5xlMsEySKX0sa9FK/PCGTXElU1sIX4DAbsN21Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560575;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=h0rYDz7cpXzba38r/GFgnFB2Vhx5F7xTBO6QnxI3CyY=;
 b=KF8Gtkap7HpfBp+lvfb/al5ryFfEyXA8Cb4SlnE6YXFbrfmbCycOxuMnwy86ufHAl9Cb
 Rp58lw1VLlCgyDr/BLKtcUpGjtCIPoCiZl+LH+lD8mJUm3e39iAm0BuFErPztcn7cSczM
 j6QnQt12Y6l6J+jJ8YZwAOHml9sRrVRA2Wqdud4LrJBTFZtDIpLEXVd0dmifWkdPcv0HB
 7obeCLUyj0ROdbeZLahp9GPg5ITXJUz8R6BLMzoLbBYHobBEQvETXlMKBxHpK2s+5Gsdm
 P5RhiENtH70Jh05Q0CA4djs5QaPH7U+RSrb/DzOjrAaw7jBMD095HxlP122XHYQwlIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 796211F000C7;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560575;
 bh=h0rYDz7cpXzba38r/GFgnFB2Vhx5F7xTBO6QnxI3CyY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=op/RFEmkSNHSuZpl2IMtUoEQL6Nf1CCOTvxDP/96alol1s0jzCtDk0eFcuB+m044J
 YZJOqwT9W9aJkFIZPskpRFvh6KGPZ2Nw+JoeAKLIBfRdeb6Ij7ireCW3i3Bd/yIP1b
 JAmIBw7USQGndhQfOrLhKBXEesA4+434fSZe1NCJjhWlDDXOO+caGzVNAUgYY34stZ
 urhVb9kUMWGlKxQDuWdPd6OqAhz70nxb+RBd9SkDREA7ey4z4/pfwVCySl96pvQjUe
 th+Q2B+ueAYu1dfYU44yhPHPU7IQaCz0Zwoy4cBi3I2eLoBW8aQ8xivVtsy8TAny4M
 RJUGbsWoIqwGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 069F7476DE;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:02:55 +0000
Subject: [PATCH v3 03/14] drm/panfrost: Don't take a reference on a mapping
 that is being freed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-3-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=1825;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=b5WA5vi0EwiXvHHxwNKezB3PYG2ZPzZFSsrErt1HQZU=;
 b=Sv88zJ5LVAd7XESsIuxNbFNKPf99SGx8nbIdEiVXtPB7UUnjLpZDVe8CWY7w0F3p60cbiXZFJ
 UtZqtUDnLydAl0wui9acx8wCuCnzP+kRZ20YNQgmksEB42o6LCJLUH3
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

addr_to_mapping() takes a reference on the mapping it finds in the
address space's drm_mm with kref_get(). But the last reference is
dropped before panfrost_gem_teardown_mapping() removes the node from the
drm_mm under mm_lock, so the lookup can find a mapping whose refcount is
zero. kref_get() revives it, the release still frees it and drops the
BO, and the fault handler maps pages into a BO that is being freed.

This takes a GPU fault on a heap BO while its last handle and last job
reference go away, so a job that uses a heap BO it does not list;
userspace on the render node can submit that.

Use kref_get_unless_zero(); the fault is then reported as unhandled.

Found by code review, after Sashiko reported the same pattern in new
code of this series. Not reproduced.

Fixes: bdefca2d8dc0 ("drm/panfrost: Add the panfrost_gem_mapping concept")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-206570@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index faa62643c..d0c6b6635 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -576,7 +576,11 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 		    offset < (node->start + node->size)) {
 			mapping = drm_mm_node_to_panfrost_mapping(node);
 
-			kref_get(&mapping->refcount);
+			/* The node stays in the mm after the last reference is
+			 * dropped: don't revive a mapping that is being freed.
+			 */
+			if (!kref_get_unless_zero(&mapping->refcount))
+				mapping = NULL;
 			break;
 		}
 	}

-- 
2.55.0


