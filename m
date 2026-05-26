Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA7BCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 20:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE3210E559;
	Tue, 26 May 2026 20:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HZUaxNct";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7046810E505
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 20:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779828873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dS/ZL01Q5UiuDS3rO1Ng20MqodzQcdZW0zFHe5xf9VU=;
 b=HZUaxNct2vv/Nmg6W9YoufO0cYYXkILe3HNNW3cXXXzxSVv0EraYOVuB0s0TCQ63AVdnGa
 XBYfBcAD9VujUXuyYdW0cHbV3gYUnTjhj5+7qDlpVmWl0+oke1tF0emBZsHqfmSoVoGXrr
 LUEt5f99zfih7X+vuRLp+jFT8Ro6HZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-3Vb_iM1QOv6AXI0eKHKezQ-1; Tue,
 26 May 2026 16:54:27 -0400
X-MC-Unique: 3Vb_iM1QOv6AXI0eKHKezQ-1
X-Mimecast-MFC-AGG-ID: 3Vb_iM1QOv6AXI0eKHKezQ_1779828865
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3980D19560A6; Tue, 26 May 2026 20:54:25 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.238])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E526D1681; Tue, 26 May 2026 20:54:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: "Gary Guo" <gary@garyguo.net>, "Ingo Molnar" <mingo@redhat.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 linux-kernel@vger.kernel.org, "Tamir Duberstein" <tamird@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Shankari Anand" <shankari.ak0208@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Benno Lossin" <lossin@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/2] rust: sync: Introduce LazyInit
Date: Tue, 26 May 2026 16:41:32 -0400
Message-ID: <20260526205419.1055109-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: YIQcP4p-CahslTy_CND9sQWDLSJ13fWp8GZqDSRjnIY_1779828865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

While trying to write up some SGTable bindings for the GEM shmem
helpers, I discovered that SetOnce is actually quite difficult to make
use of in a number of situations.

For one: there is (upstream) currently no way to use it with fallible
initializers. Even with some of the work being done to add support for
this from Gary Guo and Alvin Sun:

  https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-1-074badd18716@linux.dev/

We're still left with the issue that if two callers race on trying to
call init(), there's no actual way for either of them to block until the
thread they raced with is done initializing the contents of the
container.

LazyInit is my proposed solution to this issue. It provides a container
which protects the initialization of its contents, without protecting
access to its contents (implying of course, that its contents have to
provide their own thread synchronization).

Lyude Paul (2):
  rust: sync: lock: Add Lock::get_mut_pinned()
  rust: sync: Introduce LazyInit

 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lazy_init.rs | 354 ++++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs      |  11 ++
 3 files changed, 367 insertions(+)
 create mode 100644 rust/kernel/sync/lazy_init.rs

-- 
2.54.0

