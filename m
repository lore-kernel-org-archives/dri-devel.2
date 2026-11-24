Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7256606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=XxFmsbPn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2Sc5ife0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C80F10E0D5;
	Tue, 24 Nov 2026 11:38:15 +0000 (UTC)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B9210E0D5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:38:03 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 03510EC0D00
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:38:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 06:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1795520282; x=1795606682; bh=C2
 944LViUXuhVQQh3kuRid+kOVXNWADbSL1+qewM1/U=; b=XxFmsbPnSvL8zEpKB+
 X1EAioPRPkPih0oi1sRXvKbRg3MZWWzeHWputww4C+6VNgtzgSTcElo/k/x4f3n9
 LQfTl4XfuaXQbjFADR/Zjaab7zMIF/+okEwAzuYcmGD2x6AFMNY/gaRbZB3HLzeV
 D7ktELfgqj3u3cE+xqcLIy2S9uHqK4rk+qojPsoi5xVJqEVhkoCmHxJ6hvNaWwUB
 6r1fAk2hFxWmp5gG0I0i7Kfihj8PSAKL98n/7ut5LC39QJPjWZzBJPm8LEwVTBRn
 aqXnDYzUummRP5WpsuTwnaZrVQiquFgG7FqY0GfoPYW8dXXBGxmoCYzM5sPCSQAJ
 COOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795520282; x=1795606682; bh=C2944LViUXuhVQQh3kuRid+kOVXN
 WADbSL1+qewM1/U=; b=2Sc5ife0/rBQw61D4zzt6f3xguyv/CtLxTPklFJxZSVa
 ksDd3ux+p6gY+S5rYpNL8B7GY5kehEZOx2TxQUBe7Dc5LkPiPCH4JWNCtlW2ut5a
 RBM34QgSzjbYSq0ijC1nZkKxvTtRxzaZWmsn361c+N8qHSuUitFyOZpwkivGIFjq
 7SzvQMd+gAejkwi+g/ybT3e4jnbAd2abTk2IPGLn4erbRetC8a+57anVSQRW8uwI
 /c4znQowF6oGwlyqhhHM4pBQi1dYmqvnOO4d3Uh/YLtArFfJ+Jnu9uKsdUwTMnDm
 YnNZmi25I8y8rAtk84GSOpYX4VjDO5om3xqpAOz7Rw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795520282; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:oz6Omb+ZkKZEMQ4EcFeJfBFBAucLVXCGLLnR/kxpgvAYOHg
 hw3QTjh1q8KaLpRjFgZEnCoq1hG/dBoGvIVBm21+44rXrWCjWv/XyhPLFzO1paRS
 iQNUdJkbyGDKWEULjVdPdHoFD1A1RRS3OwZUD67118XEv99ALLMbSEUzcyaeSfNq
 yfQWm7O0t+qocovi/vRJ76jPlFGtg90bKxt+HyYSlL+AlPwEQRnmnIKeteOQr0SO
 BVRWGC7Z44sEPCet6Xqm+dCLSeG/bXOlmvWeuoZhqLR4aeAzX8iyrP8Wcj67OXDK
 1DY8SJu+lpIfOh+tIe5FdKj6hv5B3rmCjRC/7VA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:eFleW6nXxJ0WQwxPq1NVe/Lz93xgini0zo4V8FF1FP4=:qYSEWd0wxgi54NJUMvMh6kG2mgQyLWUBWOf9eqbDruQ=;
X-ME-Sender: <xms:GXcFa-1uIYtC1wTWcJbkYriYpBbmjDsGLZrwWQWYehiu8aJElnqbSQ>
 <xme:GXcFa4mAWMezIkcbZrjrk85Kwt4EICNWX10_JkHGONivTyl1irY5WtJR55QkD5p2-
 JZYzE7eJATD6qg2vlejgwkBYlYmOecNKviGfbLcmWHI7RsXKX-18jbA>
X-ME-Received: <xmr:GXcFa8_mGTq37CP9cAe_Ys834LcQHZd0sZ-FjQwG0J1hG1J8ipR3gFjPnAYLhJUXTrVzY8gD4tppdcDlEzTtP2qZLhqPCQ4umjHt_Q>
X-ME-Proxy-Cause: dmFkZTEf2hY6aefQh+yq0RC6zE8mafYVbye9/UlL/rslaFef+HJfWsTWRAS0vDVfDG7Tay
 qPW8YjgCfLUKQUXWLDaeNavdcPKkRFDaqBgdVGVhC577xxJ+yiLMj1VQK3oTLZwtzabwuE
 clSkhL/Ej+VL9I0w6z2tLe1SekGho4/2Urb6cwYJo1xP+v14yIO6Lci7VZ14HEMdqRQHTu
 ZbvO1Y8+KpGhvcSqwzoWATNgKJHs2f7uIN807iXVhFrhMc3JB8i739YoenmFP84uuwYAif
 XDyFip2nIUmOF8fM8tCC3XhW2FZoPeBZdFqv/yAqf86BOMN+xmouDdamrvBa+An9QAeAke
 zcX3Tw+Y0ArdAci/qQtO2QEllg0r4MkcZLnSTg9MsrvaZvchSnpRKrlyE7ri3TpQ1+Vv6T
 IHCmnTw3Y9oR5cQhLqaxNnj8aOGt8PKrn/qHArloGNHEF6x24oezwFv7yuCu/zWOQVv5fO
 xASQP6uIooNafXjQ/eVVw92LHBAy4B7EFD4VzfdfEho2xiZ8tFnJrRAGdrdtm+iHmiHDdy
 lLHRLFxAhzhYaaibALoKlPSrqlFU9SibzlHpOsLfaXIJyQW46m0mA4OQ2n+vLy0f578CAV
 W7TOIqi+z1vJGtRGr4r69B7lmv+ZWZq6BVCl7l/7lkTRTpiNxyR3Ygewxl1Q
X-ME-Proxy: <xmx:GXcFa95J6prARl7TYLiYvDiAQ2CtxL-Hk9gx_iv8TJ5wUt5IlWvu7Q>
 <xmx:GXcFa8LIdA715jt28MIxzFuvy302LVpByqu2SXKY-ws7TIc6fJi-eg>
 <xmx:GXcFa9UZE6DIGxi21vlcsdZskWFnHBkFKP3gWD85jBoymcL3XSmIkA>
 <xmx:GXcFa9JHbrzLFoISbDo_hBgcB42yUuxaQSXlMNf7kpDBjx4-INZUbg>
 <xmx:GncFax_XEjxhb7_0MrFO8zDAhJrtCVkghMNjXNoazCo8GqcjO2PJ590c>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 06:38:00 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/5] Fix import of dma-buf buffers as DRM GEM shmem objects
Date: Tue, 24 Nov 2026 12:37:42 +0100
Message-Id: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43NTQqDMBBA4auEWTsliT+Iq95DXEQddQqJMonSI
 t691BN0+xbvOyGSMEVo1AlCB0deAzTKZgqGxYWZkEdoFFhtK6NthbLHhKN4nMljXDx5ZL+tkmj
 EOCesy6FwRdmTrXPIFGxCE79voe0yBQvHtMrnBg/zq/+/D4Ma82oypRtIF715vlwIbn8EStBd1
 /UFrpAW288AAAA=
X-Change-ID: 20261026-rust-drm-gem-shmem-imported-sgt-85c4a45be283
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3363; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=qYSEWd0wxgi54NJUMvMh6kG2mgQyLWUBWOf9eqbDruQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmzWcjGr7is6PswVIQ6zD2+NnveXi7ljUfR5qWeiYndPm
 B+89tyko5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwET6Ahj+GXTO1238fJGR8VLG
 BDYv0R9WMn/vr9FZ2qPTkeyRaOO8nJFhM3P4MdNe7+COkOsxFe93fIzhYEk6Lcy7yH2pyhOGohu
 MAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Hej,

this series is triggered by the discussion of gem/shmem.rs SGTableMap
issues in [1] which has an additional issue with imported objects.
Imported objects are supported since GEM shmem's AllocOps use
drm_gem_shmem_prime_import_sg_table() as gem_prime_import_sg_table which
sets the same function pointer field in struct drm_driver.

The code is broken in two ways. SGTableMap::drop() calls
__drm_gem_shmem_free_sgt_locked() uncondiftionally which it must not do
for imported objects as the object does not own `sgt`.
The second issue is that the imported object is allocated by
__drm_gem_shmem_create() with sizeof(struct drm_gem_shmem_object) as
size instead of the size of Rust's Object<T>.

The first issue is fixed in the Asahi downstream driver together with a
drm_gem_is_imported() wrapper change taken from the Tyr downstream
driver.
The second issue is fixed by avoiding to allocate Rust GEM objects
from C. In addition to size issue v1 addressed Rust gem objects may
contain fields with non-trivial `Drop` implementations. Those fields
won't be destroyed in error paths in C code which "destroys" the objects
with `kfree(obj)`. Solve this by re-implementing
gem_prime_import_sg_table() in Rust.
The same issues apply to drm_gem_shmem_dumb_create(). As Asahi and Tyr
as render only devices do not use the `dumb_create` callback just drop
it. When a future driver uses the callback drm_gem_shmem_dumb_create()
needs to be re-implemented in Rust as well.

The series is tested in the Asahi downstream driver. As the prime import
code path is unused in-tree I marked the fixes as not suitable for stable
backports. The known downstream users of the code are aware of the
issues and carry fixes downstream. I don't expect new Rust DRM drivers
to be based on (old) stable trees.

Link: https://lore.kernel.org/rust-for-linux/20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com/ [1]
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- Switch to Rust gem_prime_import_sg_table() implementation
- Drop unsound drm_gem_shmem_dumb_create() as well
- Add `#[inline] annotation to BaseObject::is_imported()
- Drop typoed mail address from To:
- Added Alice's Reviewed-by tags
- Link to v1: https://lore.kernel.org/r/20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net

---
Janne Grunau (4):
      rust: drm: gem: shmem: Do not use drm_gem_shmem_dumb_create()
      drm/gem/shmem: Initialize private objects via drm_gem_shmem_init() too
      rust: drm: gem: shmem: Implement prime_import_sg_table callback
      rust: drm: gem: shmem: Do not free SG table of imported objects

Sami Tolvanen (1):
      rust: drm: gem: add an is_imported() accessor

 drivers/gpu/drm/drm_gem_shmem_helper.c | 34 +++++++-------
 drivers/gpu/drm/nova/gem.rs            |  4 ++
 drivers/gpu/drm/tyr/gem.rs             |  4 ++
 include/drm/drm_gem_shmem_helper.h     |  3 +-
 rust/helpers/drm.c                     |  6 +++
 rust/kernel/drm/gem/mod.rs             | 17 +++++++
 rust/kernel/drm/gem/shmem.rs           | 81 ++++++++++++++++++++++++++++++++--
 7 files changed, 126 insertions(+), 23 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20261026-rust-drm-gem-shmem-imported-sgt-85c4a45be283

Best regards,
-- 
Janne Grunau <j@jannau.net>

