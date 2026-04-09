Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F8F10FC460
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9E510E71F;
	Thu,  9 Apr 2026 00:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aypaYx3I";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED36E10E71F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775693826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nQ/kkld0vtHaBT8o/y52woZ43HcqsBt739q7XOTr3PI=;
 b=aypaYx3IVSWCeENsg+CSAOnAvaZcDxauE3DoQwAEQx8VyOaPef2bM2GHg2cng0u1tuDdrQ
 +MLPgZn/utzRa+V8OsN43ievDyxGoQ3lqDPnnJYtMg61LD8rjuVc71wc06WPr2ZJHyk8R1
 Kt3VIv3o7Z7SoTjh/1yDWaoEKQjnv+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-dV8j-oK_Ml2tpKVB0cpQdw-1; Wed,
 08 Apr 2026 20:16:11 -0400
X-MC-Unique: dV8j-oK_Ml2tpKVB0cpQdw-1
X-Mimecast-MFC-AGG-ID: dV8j-oK_Ml2tpKVB0cpQdw_1775693767
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03DAB1956060; Thu,  9 Apr 2026 00:16:07 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D91AA300019F; Thu,  9 Apr 2026 00:16:02 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com,
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, linux-media@vger.kernel.org,
 Shankari Anand <shankari.ak0208@gmail.com>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Subject: [PATCH v10 0/5] Rust bindings for gem shmem
Date: Wed,  8 Apr 2026 20:12:46 -0400
Message-ID: <20260409001559.622026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: KWW0e5w7y-PQQDGaB_XCFqw-o2ooWyaH7JKJ2YrinL0_1775693767
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

(apparently it mistakenly was not sent to dri-devel, so no patchwork ):

	https://patchwork.freedesktop.org/series/156093/

Branch with patches applied available here (+ a hack required to make
sure this builds:

	https://gitlab.freedesktop.org/lyudess/linux/-/commits/rust/gem-shmem

Lyude Paul (5):
  rust: drm: gem: s/device::Device/Device/ for shmem.rs
  drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_locked()
  drm/gem/shmem: Export drm_gem_shmem_get_pages_sgt_locked()
  rust: drm: gem: Introduce shmem::SGTable
  rust: drm: gem: Add vmap functions to shmem bindings

 drivers/gpu/drm/drm_gem_shmem_helper.c |  48 ++-
 include/drm/drm_gem_shmem_helper.h     |   2 +
 rust/kernel/drm/gem/shmem.rs           | 553 ++++++++++++++++++++++++-
 3 files changed, 590 insertions(+), 13 deletions(-)


base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
-- 
2.53.0

