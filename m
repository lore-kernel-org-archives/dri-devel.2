Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37F606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXlg67En
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218EE10E1A3;
	Mon, 19 Oct 2026 21:25:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E6410E1A3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 959F260534;
 Mon, 19 Oct 2026 21:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25A31F000C4;
 Mon, 19 Oct 2026 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445143;
 bh=LnbL2Qy4aOtp99Oxyh8NxAazgtHYMt/GuKPuI+ulARE=;
 h=From:To:Cc:Subject:Date;
 b=YXlg67En4U/K0gG8XNtO7lBQWJVRq5q01WXDMR5sKCyD8C9Gi8ZRCod9p0mTX4ZBN
 r7Gs1l14DSrAmdjJPSalA1Z7yU7XqOKV5nRkBFLKLG1dgmZAWObNEqWnSNv+RgxJ6F
 dZVThNK3jOal62IgpMExh/3NgVjt4hIuePKPmfy8MYuCNUvOzjmspLSNybafK51sRQ
 XLQGjXfI1gWyn0VPMgGgvbyDyexxDLMDIJKimUVPm1M74pROTnSzYrms6WphSWyt4C
 wSQUCQtZ97vatXN9XkaQA5SnvYY5uUXjeRS5vdx5tngmXSzk2Uey93WzZkGbX29EEv
 2mAp5s9ZtempA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, jhubbard@nvidia.com,
 apopple@nvidia.com, ecourtney@nvidia.com, lyude@redhat.com,
 kherbst@redhat.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 0/3] drm/nova: make unstable uAPI use explicit
Date: Mon, 19 Oct 2026 23:24:44 +0200
Message-ID: <20261019212535.88390-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nova and its uAPI are under active upstream development. We want to develop
these interfaces upstream while making clear that they are not yet stable and
may change incompatibly.

This series makes that status more explicit and requires users to acknowledge it
before enabling the driver, tainting the kernel when they do.

Introduce a minimal Rust abstraction for kernel tainting in order to support
this.

As individual interfaces stabilize, they should move from nova_drm_unstable.h to
the stable nova_drm.h header. Once all interfaces have moved and all
stakeholders agree that the uAPI is stable, the acknowledgment requirement and
kernel tainting can be removed.

(Compile-tested only, as I'm currently travelling.)

Danilo Krummrich (3):
  drm/nova: mark the uAPI header as unstable
  rust: add kernel taint abstraction
  drm/nova: require explicit opt-in to unstable uAPI

 drivers/gpu/drm/nova/Kconfig             |  11 +-
 drivers/gpu/drm/nova/nova.rs             |  55 +++++-
 drivers/gpu/drm/nova/nova_drm_unstable.h | 212 +++++++++++++++++++++++
 include/uapi/drm/nova_drm.h              | 204 +---------------------
 rust/bindings/bindings_helper.h          |   1 +
 rust/kernel/lib.rs                       |   1 +
 rust/kernel/panic.rs                     |  50 ++++++
 rust/uapi/uapi_helper.h                  |   2 +
 8 files changed, 332 insertions(+), 204 deletions(-)
 create mode 100644 drivers/gpu/drm/nova/nova_drm_unstable.h
 create mode 100644 rust/kernel/panic.rs


base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
-- 
2.56.0

