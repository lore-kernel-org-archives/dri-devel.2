Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7E4CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 22:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6965010F2AC;
	Thu,  7 May 2026 22:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eGn1A6dx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242BB10F297
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778191276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zKAcFOrw3UOnhiABCMSyb2Xk9WWZbNSVVZtY6eioZ3Q=;
 b=eGn1A6dxecClRTimpKh7giF3I5GS+cWf/V5ihfTErEpF8BbiW/c/n/GyRC2msKm9ryHYKn
 WGMxBLWHW1/rf+KysSkm6juEX9qPohf8eHbH8x4LXKHWA8yW5dgGulWLvQFmt8OFLH2WRu
 Swem0C6JaUh2/HaSsAlSS6f7Yk89X0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-I5Awh4lLPBOnkIhWD5hhqA-1; Thu,
 07 May 2026 18:01:12 -0400
X-MC-Unique: I5Awh4lLPBOnkIhWD5hhqA-1
X-Mimecast-MFC-AGG-ID: I5Awh4lLPBOnkIhWD5hhqA_1778191270
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A7E18002C9; Thu,  7 May 2026 22:01:09 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30BD6300019F; Thu,  7 May 2026 22:01:06 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl" <aliceryhl@google.com>,
 Nova-gpu@lists.linux.dev, "Shankari Anand" <shankari.ak0208@gmail.com>,
 "David Airlie" <airlied@gmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "Asahi Lina" <lina+kernel@asahilina.net>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v6 0/3] Introduce DeviceContext
Date: Thu,  7 May 2026 17:59:18 -0400
Message-ID: <20260507220044.3204919-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Zd1krHezuBicSVsbfd-_6-1cLAvNMBb3-rnFWIZUQpM_1778191270
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

Previous version of this patch series:
  https://patchwork.freedesktop.org/series/160217/#rev5

One of the unsolved issues we still have with the rust DRM bindings is
the ability to limit certain Device operations to contexts where we can
guarantee that a Device has been fully initialized and registered with
userspace, or vice-versa (e.g. must be unregistered).

While the previous solution for this that I had was simply not exposing
drm::Device at all until the device has been registered with userspace,
unfortunately this isn't enough since:

* As we found out with Tyr, drivers occasionally need to be able to
  create GEM objects before device registration
* We would still need to be able to handle KMS callbacks which could be
  invoked after KMS init but before userspace registration (not handled
  in this series specifically, but DeviceContext will be required for
  handling this).

This patch series provides a pretty nice solution to this, by
implementing a very similar solution to kernel::device::DeviceContext:
introducing our own DeviceContext type state.

                          Series-wide changes

V2:
* s/DeviceCtx/DeviceContext/ for consistency
* Move private driver-data availability to the Registration
  DeviceContext
* s/AnyCtx/Init/
V4:
* Split out DriverAllocImpl into it's own patch
V6:
* Rebase

More changes described in each patch description.

Lyude Paul (3):
  rust/drm: Introduce DeviceContext
  rust/drm/gem: Add DriverAllocImpl type alias
  rust/drm/gem: Use DeviceContext with GEM objects

 drivers/gpu/drm/nova/driver.rs |  10 +-
 drivers/gpu/drm/nova/gem.rs    |  15 ++-
 drivers/gpu/drm/tyr/driver.rs  |  12 +-
 drivers/gpu/drm/tyr/gem.rs     |  11 +-
 rust/kernel/drm/device.rs      | 240 +++++++++++++++++++++++++--------
 rust/kernel/drm/driver.rs      |  37 +++--
 rust/kernel/drm/gem/mod.rs     |  72 +++++++---
 rust/kernel/drm/gem/shmem.rs   |  57 ++++----
 rust/kernel/drm/mod.rs         |   4 +
 9 files changed, 333 insertions(+), 125 deletions(-)


base-commit: 37f748ed0c19e007e7c5677f5d605d6b93841792
-- 
2.54.0

