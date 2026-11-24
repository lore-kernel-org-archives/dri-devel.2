Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E6606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiVvCA//
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67EBA10E68C;
	Tue, 24 Nov 2026 05:50:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475A310E68C;
 Tue, 24 Nov 2026 05:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8C6E60D2B;
 Tue, 24 Nov 2026 05:50:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795499422;
 b=Ii1yaZ8Q1IFr9j0AC+A7QVqXHW+utSPgK6sgV2XoLo6brGrBK/EKpJHekYan12V6w5ei
 g4cIKNCX52c1at3Gsd4NB5BqFPeeymhEUtWwPz54BGb78dZkJO4UB+lKc5sjzq0kFX2hg
 zjazaYJ7cxVoMAZ3v2wP22tkWv4ctFTwUmAY2gvZDaYwUtt2ONqL2J72OvMDVOq4JRNJv
 G/w4gQJf2+4i7Qa2YKZWRejohAFsWTd7hLjOvYxJD7Ofenlg7ILquEwvkMs0PFaBzily+
 vz6kSMuu8ck/02ci71FLA8FYFs1PE9LgiM/Lr9Xa3WGUPuPEiYiLHiRHCRe2RcaCMQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795499422;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=dHQB1+DaSFFrpiufG1Enq9Ctc5JVvRXicADfOQ4dqs0=;
 b=kONmwLLDoxJkRMDFMV/aUCCfUeJpYpeNa21nkEfIaiScLzAXbPJtc9P3RQjzgzBQgdFk
 JBlT631VkeF8hzkK4EYWauoCf0j6+vI5XWrX5jsEEuJD2LauIqLa7tL4/D/6xLS3wtGTa
 rJiURAjpCwDOIYn6UPEK300YtybsIujNVzufHTkWw/QXK3/KxMX983A6+chdhMcf/vm6k
 uSjQRU1vEU5iJlMNNB7euvKTI5xC7c47OP+mrm7lH5pLAubyIoukVcQGdPuW6GUZB7LBi
 9oVD9GuXnLJaWIHX0qn7cwUZetX8l7VazqAuhisL33PQlEF0stdNOKFLf+x4syM8lvQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8BD9A1F000C0;
 Tue, 24 Nov 2026 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795499422;
 bh=dHQB1+DaSFFrpiufG1Enq9Ctc5JVvRXicADfOQ4dqs0=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=CiVvCA//a02Rvuz9UoHe3zQf/u1dx7G3QjXz9W1GVZ828404igbWVb4K/ScP2GkSW
 d6dSXt9r30nwtXGeWcyGGFJLugWCHyLVb+tfGCDZ0jL/vuqPvpvR1SljmVS4bjtdJQ
 Idw+2pc26HEgQOazMb0M7Os0jvDnnw50d0wv6oYLQd0IYyjShP4TLu1MAzMq8MNHmU
 Me4mJ4fFQqFScWMdMD/Ok9EPhfvR+b8Z7cwQ5xqn33UXPYF5mvG0W7I2uAuvr1CAQf
 fdxH9BJRYUh/g62UZr6Y1ZfX/qFZjzKZmikcokypYE7miW3JQtGXO5LceyfRV5yJxY
 K084Z+S4sSHpg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E188D4C8E7;
 Tue, 24 Nov 2026 05:50:11 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Subject: [PATCH v3 0/2] nova/nouveau: add configs/module options to control
 binding behaviour (v2)
Date: Tue, 24 Nov 2026 15:50:01 +1000
Message-Id: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ6CMAyA4VchOztDu02GJ9/DeJijwA4yssGiI
 by7g5MmxkuTv0m/LixScBTZuVhYoOSi80MOcSiY7c3QEXdNboYlngCg5oNPJo85kZl5F0cOZas
 rjbLWJFk+GwO17rmT11vu3sXJh9f+IcG2/YMl4CWXtiG8Wwkg8BKo6c10tP7BNi3hh4Dih4BZU
 KQtVsZopdSXsK7rG+d5zgPzAAAA
X-Change-ID: 20261119-nova-nouveau-gsp-10f8782498e4
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=BZXGlfXXCG7eCTKLww014DE7HV6m3p7Wje5A+Rg73p8=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrBSWOFSwK6lxURuYvQ5bWlKqsfnsppYaaUczIg
 LMhdBezKWKJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawUljgAKCRAMdPNZecSG
 vrAID/93OnZriA540yJJeh3VlC271R8JLiItQlm0KoVrTcVEhFKuGg9A5qgtKj8ApNUS3SkUO6G
 rToJLzQmeYLt5KpwhcgxHr5AwIXm/66JCDiMlmEYuP38Wc6qvOYS0+SGDqcV9cUEPQ6G3IEr02e
 UgWZlTR6eAnDdDavLZfPUkV+kbiIAtJ2Yt4EwiCl+0LljN/y49mfr577xB+sI8Dlbvp9DhD8yYt
 trPRqmh+osAEZBd4fjauPRXRGJfi9wAsc6OpcxrJytypav6ZqzezPq/9lbQvBCzfZLp+K01i6yZ
 l/Dv7MWEYu4bRbEwxYXseKPULvAQsPtGqabAEppxAsqm01X6U5G4dy1kZrUpXUjOOpozFfuuhW9
 GnK8Cgrm/kqN5KqxjDSRNnU/pA1CgJiuznhxbcCtO0e3F5MXew17zsGsJYwpMHddDHBZoRW/j9F
 It1N3HZWnVIpJow95pI8Dda+ads8EHUHaU1sQ94vKqFAas/c3aWP7wVIv3nCSyX5LfIRlDMlf0A
 LQB7gPdxmOb7dhloKyUhhPDjhdhTMm69CLzt8Kdy8pcthiBbpZtHf0S2oILwn2KECFjz4TeRnau
 CZghjrQR2VzMnLJkyZFcpgWOtCud+IpDxH6PxeTrOnfhGOztdse+qFast3XXCznZqQTg3SKYgsL
 Z7JC+ucr2+bXYfQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want to be able to build both nova and nouveau and maintain the
status quo for now of nouveau binding to all GSP enabled GPUs.

In the future we may suggest switching the default to nova, but
for now the default is to let users use command line options for testing
and developers building their own kernel can set the kconfig.

This contains a precursor patch to fix the nouveau device cleanup paths.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
Changes in v3:
- back to single nouveau patch
  - fixes ctor teardown path (Danilo)
  - fixes passing bind_gsp flag (John)
- nova
  - move to using a function (Danilo)
- Link to v2: https://lore.kernel.org/r/20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com

Changes in v2:
- nouveau dtor path is broken, so fix that before adding the new code. (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261119-nova-nouveau-gsp-v1-0-4cde2bc41132@redhat.com

---
Dave Airlie (2):
      drm/nouveau: add option to leave GSP-capable GPUs to other drivers
      nova-core: only bind to GPUs when explicitly requested

 drivers/gpu/drm/nouveau/Kconfig                   | 17 ++++++
 drivers/gpu/drm/nouveau/include/nvkm/core/pci.h   |  6 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c             |  9 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c | 67 ++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c  | 11 +++-
 drivers/gpu/nova-core/Kconfig                     | 21 +++++++
 drivers/gpu/nova-core/driver.rs                   |  4 ++
 drivers/gpu/nova-core/nova_core.rs                | 23 ++++++++
 8 files changed, 139 insertions(+), 19 deletions(-)
---
base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
change-id: 20261119-nova-nouveau-gsp-10f8782498e4

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


