Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D923606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Za9hpEHX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B0310E490;
	Fri, 30 Oct 2026 15:42:27 +0000 (UTC)
X-Greylist: delayed 432 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 15:42:20 UTC
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru
 [37.230.196.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872E910E490
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
 s=mail; t=1793374489;
 bh=YysBt3IelcDmCs41LNAfyqOxcxszE1ekBHh5iJlfQS8=;
 h=From:To:Cc:Subject:Date:From;
 b=Za9hpEHXoF3QU2UoEXuLToeW01ZtQ2NrDhJmouhTldxTFEloRvgHTN2HD+3vGsAYk
 rla0FrkMcjNy0NfJckQnEyvQvlwtTadW4Pe9LXYN7JlKh73F3x4r/C/XGg8D/N6l3G
 vSzHL04N2ticeQ8KncuEEIff+46G0Nu3AysJOQQIGqiEx7GTp3eAqGg2oWx2H9gOoJ
 J9CCadt3sQX9hlZmmRviw5VqInh0yDn0SUEYDfh6cZLlfZZkHvQlQJ5QEqGXk+Ivum
 k16TsTcZ1EIQRFtixhQfSUm/PazPqOQHqnajG0+vb0r6dw65mu8d13Vm2ArTJwUVmx
 i3kON4GDO29tw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw01.astralinux.ru (Postfix) with ESMTP id A43CA2659E;
 Fri, 30 Oct 2026 18:34:49 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
 Fri, 30 Oct 2026 18:34:16 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.26.228])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jGQ8k3fwYz1Y8j;
 Fri, 30 Oct 2026 18:32:54 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
 Sasha Levin <sashal@kernel.org>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>,
 Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/vc4: Supply the overflow slot size in BPOS,
 not the whole bin BO size
Date: Fri, 30 Oct 2026 18:32:32 +0300
Message-ID: <20261030153234.1098-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/30 15:11:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133
 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {Tracking_one_susp_tld},
 {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to},
 patch.msgid.link:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; new-mail.astralinux.ru:7.1.1;
 astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207146 [Oct 30 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2026/10/30 14:03:00 #28765267
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/30 14:23:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

commit 6395789e4739aa5177bbec0fa0f07ccc38d249b0 upstream.

vc4_overflow_mem_work() points BPOA at a 512KB slot inside the 16MB
binner BO, but writes the size of the whole BO to BPOS. On every binner
out-of-memory event the PTB is therefore authorized to write tile lists
across all the other slots (which may hold the tile state, tile alloc and
overflow memory of in-flight jobs) and, for any slot but the first, past
the end of the binner BO into unrelated CMA memory.

Since CMA pages are recycled into page cache and user allocations, this
is arbitrary memory corruption by GPU DMA. In practice it shows up as GPU
hangs with corrupted control list pointers, userspace heap corruption, a
GPU that stays permanently wedged after the first hang, and occasional
full system crashes, whenever a job overflows the initial binner slot.

The bug dates back to the conversion from a dedicated overflow BO (where
writing the full BO size was correct) to the slotted binner BO.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260727-vc4-bin-oom-fixes-v2-1-0d8a5eddc7c9@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
[ mdmitrichenko: Refresh the hunk context for bo->base.paddr;
  5.10 and 5.15 predate the rename to dma_addr in commit 8c30eecc6769. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74454

 drivers/gpu/drm/vc4/vc4_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index e226c24e543f..e985c603fbb4 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -101,7 +101,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 	vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 
 	V3D_WRITE(V3D_BPOA, bo->base.paddr + bin_bo_slot * vc4->bin_alloc_size);
-	V3D_WRITE(V3D_BPOS, bo->base.base.size);
+	V3D_WRITE(V3D_BPOS, vc4->bin_alloc_size);
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-- 
2.43.0

