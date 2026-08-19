Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E7BC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0761610E5BF;
	Wed, 19 Aug 2026 23:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="KubzRYAi";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C6410E5BF
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:08:56 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=rnuOfcEyeyPy8nGovAIWcRuCakwJiXhJPAgh8G2CGw0=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787180934; v=1; x=1787785734;
 b=KubzRYAi4DlXGs8Z/l/tgyjzTOtq1mksHOny+fs65t0ZOP+xqW8MZ7eBSCKcYt2FqolFehjV
 eji+Rxx7a3GudralJjA0kTGc59/gGZcIXEyFQNjrLNjaRKoQjS0goT4v9Cg/MjxmjzTH7Qof0II
 5BVMN3UP/qOA7HTCuMXrWSbAZ3lxqVHq3lT7z3WOpnN5GqVFg9c7B8B2Nmc+HM6C0+zVQGAPRWZ
 Wn5S9yUhC+FXbpUfrPwNPzOfR0fYW3LSla2zmJVsrhugXx79M/b/xC0UGdQrjskkLpAefpZKb/8
 XbG/+rzG1xCtCMinKDXnpwch9j966J6H5GEBEnkzMWEgQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 4a54417d3b890c1f;
 Wed, 19 Aug 2026 23:08:54 +0000
X-Mizu-Trace-ID: 4a54417d3b890c1f
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: put the chained BO when its mapping fails
Date: Thu, 20 Aug 2026 02:08:52 +0300
Message-ID: <20260819230852.287751-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

amdxdna_cmd_set_error() looks up the first BO of a command chain, which
takes a reference, and drops it at the end of the function. The mapping of
that BO is established in between, and the failure path returns without the
put, so the reference is leaked.

Ordinary use does not reach it. The chain has been submitted before any of
this runs, so aie2_cmdlist_fill_slot() has already called
amdxdna_cmd_get_op() on that BO and amdxdna_gem_vmap() has cached its
address. What makes it reachable is that the BO is resolved again by
handle here, and the handle is userspace's to recycle: closing it after
submission and importing a dma-buf whose exporter implements no vmap onto
the same id leaves amdxdna_gem_get_obj() returning an object this cannot
map, since prime_import() types every import AMDXDNA_BO_SHARE.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 855da8c79a1c..4e4a9cf5c327 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 		if (!abo)
 			return -EINVAL;
 		cmd = amdxdna_gem_vmap(abo);
-		if (!cmd)
+		if (!cmd) {
+			amdxdna_gem_put_obj(abo);
 			return -ENOMEM;
+		}
 	}
 
 	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
-- 
2.55.0

