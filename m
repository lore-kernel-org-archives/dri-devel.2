Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A6606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=IQwBHvJ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1969A10E5FB;
	Tue, 17 Nov 2026 13:25:50 +0000 (UTC)
X-Greylist: delayed 1799 seconds by postgrey-1.36 at gabe;
 Tue, 17 Nov 2026 13:25:44 UTC
Received: from 3.mo528.mail-out.ovh.net (3.mo528.mail-out.ovh.net
 [46.105.54.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25AB410E5FB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:25:44 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPj36sYjz67FT;
 Tue, 17 Nov 2026 12:50:31 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:31 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.184])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPj33vhCz1xqd; Tue, 17 Nov 2026 12:50:31 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id AD7368E2103; 
 Tue, 17 Nov 2026 12:50:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00261387e59-c792-4975-b455-eba492b4718e,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Subject: [PATCH v2 00/10] drm/amdgpu: Rework VM update ops for batching and
 explicit sync
Date: Tue, 17 Nov 2026 13:50:06 +0100
Message-Id: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhSAVNX3sOwgOkAYxSathII4
 e4C7l2+5P33FwjshQPckgU8jxJk6DfQpwSoq/qWUezGoJUuVK4NOh+RJ/cSkohh7gkv9prVxtp
 MK4Jt5zw3Mh3NR/nj8KmfTHEP7UYnIQ5+Pk7HdPf+9ccUFZompUKZPKeqvrfv6WwZynVdv7CNT
 MvBAAAA
X-Change-ID: 20260529-prt-explicit-sync-3d74b9dd420c
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 5590937466612572476
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE9CL42WbiiNjq62Y3EgWHYd+nZJRL04fx2AcfGf8qEm7aLcS9VU3O+ooLpNIw7Vb9knZJb7z+RhMav0r2PLmN/1VB/wTyayn4tlK8dlv4kFOSNbudmd5vque5m1zJKlBx1VFGXZMS4qRBIByhJdUO5Y6waDHDKA/dAZfjhh+GoySOrnD36KzYgb4tqQm9t82pxc6ZV2EVYAeIZhfOiSJxv/7AANKUhfiI12lmsSQCbkY6v4XiOIkdW7gpDalpttV+Ye1MGrXgd8xK2XXRHGiqyMVOMqejbLLJ9lR2DYjVwoSDSYwLiftbY9LNIrax1xpXvL4Pt/MY2Aoqh4AuIqPcTfT2UFYDqyn/i3n3fcnqslCw4DZhcyUtBnau9Zb47RCvm8m0QMEwBmztRJA54TZQlhnUHRESQ5Cjw5+dbjtVyCx9eNcVrq0QW16k5jkKDlPKhrXC9g+IzZx3G818dlynO2gHb0kEPXwlJGiV10xrDoOBnSZl5rZggP46kGYG4IxkycIo2Y2323CzBTYPfHSO1741SNKOw6gNAEZZOtDX91YxP8mj4DloB3OiMbAWbEO/vOFNJ7Z6HlSQb2R+5DlfWuWvZdJzyEvUBtiKJlo1uxt3cTBxXCzjEMeh1sllCLV453ivT2XIbCN0MHkMlq9TcEJDD0uKCOuA5PYxbcxAp/g
DKIM-Signature: a=rsa-sha256; bh=T1fo11ryOcvRUuQCrIAoWwsH3IF4QmN8ZLQhyisTeEU=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919832; v=1;
 b=IQwBHvJ+TsAmk4IsmcI9Pk1zw8RN3GCTMDbm4LCiOr7gZsogXyrgzx8kIwUmFuCCWzSU9J+v
 WhJsuw05ER5jttuRKDufsONN7UncO0Y5Qa2vN68oV0aWHGlugjXod3cSpDVMQQG8m7rcK8TvRTU
 cPWIirLuWMO/gDG7m9BMCNewU3jBPaWWAA0X9hQvAtuxfkggU6KBO7HMa6fE6aL2eJn+uRBXr1B
 De/LIhdrAZ+XZWVlgyLOwbs0ZFIu5GJUU5YqBAA153JIDJrtLPdNd5Zl3783ll3BPXLobRzP60A
 +HVwNT9DT3vuqT1H417w6QF+7HJwBSHP+Kd5IScfnNeXQ==
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

Hi,

this is v2 of my attempt at improving sparse binding perf.

The motivator is that many games have come to heavily use sparse
bindings, and they often rely on being able to overlap frame work on
gfx/compute queues with sparse binding work on sdma. If PRT mappings
are synced to every other submissions like they are right now, heavy
sparse binding load can stall the gfx/compute submissions for quite a
long while, leading to very noticeable stutters and hitches.

Another problem is that each sparse binding update requires a separate
ioctl, so the CPU will also spend significant time constantly switching
between user and kernel mode to execute the binding changes one at a
time.

To remedy this, this patchset introduces a "VM update context" structure.
This context encapsulates some state that is carried around different VM
update functions, in patch 1 this is the mappings that were freed along
the way. amdgpu_vm_clear_freed then only clears the mappings that were
actually freed in the update operation, which is a requirement for being
able to explicitly sync that unmap.

In later patches, the update context is expanded to hold a set of
pending mapping changes, so that a future ioctl that changes many
mappings at a time has a place to keep pending changes while every
change is validated, before applying everything atomically if things
look okay.

Best,
Natalie

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
Changes in v2:
- Added pending change structures to update context in order to batch changes
- Link to v1: https://patch.msgid.link/20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de

---
Natalie Vock (10):
      drm/amdgpu: Remove unused parameter from amdgpu_vm_pte_fragment
      drm/amdgpu: Add and use vm_update_ctx struct
      drm/amdgpu: Make VM maps pending per update context
      drm/amdgpu: Make removed/cleared mappings pending per update context
      drm/amdgpu: Track dirty bo_va structures in update ctx
      drm/amdgpu: Add function to roll back a VM update ctx
      drm/amdgpu: Move some VA op validation to a helper
      drm/amdgpu: Only reject conflicting mappings if they are not cleared
      drm/amdgpu: Add new AMDGPU_GEM_VA2 ioctl
      drm/amdgpu: Bump minor version

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 477 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h          |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 660 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 100 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        |   8 +-
 include/uapi/drm/amdgpu_drm.h                    |  46 ++
 15 files changed, 1099 insertions(+), 311 deletions(-)
---
base-commit: 65b7b0d2cf8c3cba99d599493ac96f3ab32c0a06
change-id: 20260529-prt-explicit-sync-3d74b9dd420c

Best regards,
--  
Natalie Vock <nat@pixelcluster.dev>

