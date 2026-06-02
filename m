Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9ECD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBA310F42C;
	Tue,  2 Jun 2026 17:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dqIyZtfL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755EE10F42C
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hyCRQp3GrefoVTPCTFK8DAP9FsTwrDk6t14u2kcfyc4=;
 b=dqIyZtfLjYpL6DboIt7jlQnmR6R6HcgzwGU6KOaJgjsbO4NNupzSOB7uLN1NBnAD3Atge6
 U+bK/F6eCezekz42bimrTxAS8xx+NArrhErUuyKGzcLC0C5NJ0FoT+3Wdvj9t0mhBZMCJ9
 jbBZxDm2VV1S98IE9HCzU0omhLoqTm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-CBXskntOOLCcOo43wZ7QGg-1; Tue,
 02 Jun 2026 13:28:20 -0400
X-MC-Unique: CBXskntOOLCcOo43wZ7QGg-1
X-Mimecast-MFC-AGG-ID: CBXskntOOLCcOo43wZ7QGg_1780421297
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51F4919560A7; Tue,  2 Jun 2026 17:28:16 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.81.216])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26F4819560B0; Tue,  2 Jun 2026 17:28:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Danilo Krummrich <dakr@kernel.org>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v16 0/6] Rust bindings for gem shmem
Date: Tue,  2 Jun 2026 13:24:59 -0400
Message-ID: <20260602172807.1051806-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: IauoGospx7u0i9JaxLaN_LL1iWuIpVTIOJiJN9sFFDo_1780421297
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Most of this patch series has already been pushed upstream, this is just
the second half of the patch series that has not been pushed yet + some
additional changes which were required to implement changes requested by
the mailing list. This patch series is originally from Asahi, previously
posted by Daniel Almeida.

The previous version of the patch series can be found here:

	https://patchwork.freedesktop.org/series/164580/

Branch with patches applied available here:

	https://gitlab.freedesktop.org/lyudess/linux/-/commits/rust/gem-shmem

This patch series applies on top of drm-rust-next

Patch-series wide changes since V15:
* Fix some major rebasing errors I somehow didn't notice :(
* Drop the dependency on LazyInit, use the trick that Alice suggested
  instead.
* Fix dependency ordering so that Tyr can get the vmap stuff first
  without the other bits.

Lyude Paul (6):
  rust: drm: gem/shmem: Add DmaResvGuard helper
  rust: drm: gem: Add vmap functions to shmem bindings
  rust: sync: Add SetOnce::reset()
  rust: gem: shmem: Fix Default implementation for ObjectConfig
  rust: faux: Allow retrieving a bound Device
  rust: drm: gem: Introduce shmem::Object::sg_table()

 rust/kernel/drm/gem/shmem.rs | 507 ++++++++++++++++++++++++++++++++++-
 rust/kernel/faux.rs          |   7 +-
 rust/kernel/sync/set_once.rs |  60 ++++-
 3 files changed, 552 insertions(+), 22 deletions(-)


base-commit: b78dab829760aee9b83f5cf15550a0fe36c6f4b0
-- 
2.54.0

