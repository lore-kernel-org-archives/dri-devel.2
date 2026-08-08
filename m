Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DEC5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F3010E010;
	Sat,  8 Aug 2026 11:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBOyfSkE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926A510E010;
 Sat,  8 Aug 2026 11:17:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2564243EFE;
 Sat,  8 Aug 2026 11:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB406C2BCF7;
 Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786187837;
 bh=gc3o85B8Q3mCZJagtpIH3U1Y4HQoRkjaGBK0pr5KdIs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EBOyfSkERwgjILu38H61CMHh0uIDlWjHqqn7w3hAkZde+C21+I4xcPRkrU735Tm3P
 L3VkFUYF6kwr70vXH3RBFljrbCg8DS4ZO23B/9k3ltVv+9OEp4rrWXp3QW3RAonBpB
 Z4su0AHToEZU0RNfi9mD/lExwbBsPToIWfvbjChlFFwFw0FnLupNllh+6ihJEAXIOP
 PZqCWvy435fsEkLVAWjm+xHh94kLTC/lg1NQsEAhUZyNnz/Kh4DtQEoFAEnVa4lWzu
 jvqj/2df/y/Ay//7NPj6Sa/3F4t7UzwVeoI9AmCkpUg0GUQ2rF0hh9/6LLOB3IHFT5
 k1YDRHnv6xbhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC4C5AD4E;
 Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 08 Aug 2026 19:14:18 +0800
Subject: [PATCH 2/2] drm/nouveau/uvmm: reject a second VM_INIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-nouveau-fixes-v1-2-c3ebdc17a89c@outlook.com>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
In-Reply-To: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=kir+5s3fujjv8rmqeaXun1k1yrvbyiCBLh8cPyNLZQ8=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrHIBi6WxtVx5p//fuOjpXSW9d1dYj9jfeyFGP+1fF
 za9v/MmxaejlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJjJvOyPDI4PGSzyi0SHz
 JSX9i6Xecy3hY9pmn3p22apLf5x7G9RuMjLsrWCZf+hniKnml7y4aLWggInflvz8tULjb3kLn2t
 RgxIDAK7KSdM=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Junrui Luo <moonafterrain@outlook.com>

nouveau_uvmm_ioctl_vm_init() sets up the GPU VA space for a drm_file and
is reachable from an unprivileged render node client (DRM_RENDER_ALLOW).
After the cli->uvmm.disabled check it unconditionally allocates a
nouveau_uvmm, initialises its drm_gpuvm and region maple tree, creates
the backing nvif vmm and overwrites cli->uvmm.ptr, without testing
whether one already exists.

Calling DRM_IOCTL_NOUVEAU_VM_INIT twice therefore drops the previous
nouveau_uvmm with no remaining reference to it: drm_gpuvm_put() is
reached only from nouveau_uvmm_fini(), which nouveau_cli_fini() calls
once on whatever cli->uvmm.ptr holds at close time. The orphaned
nouveau_uvmm, its drm_gpuvm, that gpuvm's reservation GEM object and its
region maple tree are never freed, buffer objects mapped in it stay
pinned by the orphaned uvmas, and its nvif vmm keeps the GPU page
directories allocated until the file is closed, so repeating the ioctl
leaks kernel memory without bound.

Test cli->uvmm.ptr under cli->mutex before anything is allocated and
return -EBUSY, mirroring nouveau_svmm_init().

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index bced1481674e..26d2a57b5aac 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1929,6 +1929,12 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
 		goto out_unlock;
 	}
 
+	/* Check that a GPU VA space isn't already set up for the client. */
+	if (cli->uvmm.ptr) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	uvmm = kzalloc_obj(*uvmm);
 	if (!uvmm) {
 		ret = -ENOMEM;

-- 
2.51.2


