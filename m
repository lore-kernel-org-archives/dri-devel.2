Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4521BCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB7611230C;
	Fri, 29 May 2026 17:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DEF80NRu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6864D11230C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780075923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TCbzlCqjTBRG2TfsDWMEQYTU39QbHkvS+53/vDLXzes=;
 b=DEF80NRuGCS27o3u2PRCD4CDNgESfGG4NcEuXhu785VeSvVr2ChcPJrPq8sqlATt/U74aw
 qSVSHkE+q/60h2ZtFU2AgJrTaDKnYGb1RU40jdeSNX+WgfE5elpGNSUegJZ6I0Q9qDhfwp
 EwAOUlN6FjsqgEgQxqCCGTUoWkdY8wk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-zB3bBx82Og2lTujoFF8v1w-1; Fri,
 29 May 2026 13:31:59 -0400
X-MC-Unique: zB3bBx82Og2lTujoFF8v1w-1
X-Mimecast-MFC-AGG-ID: zB3bBx82Og2lTujoFF8v1w_1780075916
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AA2218002E3; Fri, 29 May 2026 17:31:56 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50C6E30001BB; Fri, 29 May 2026 17:31:54 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: "Gary Guo" <gary@garyguo.net>, "Ingo Molnar" <mingo@redhat.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Benno Lossin" <lossin@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/2] rust: sync: Introduce LazyInit
Date: Fri, 29 May 2026 13:30:40 -0400
Message-ID: <20260529173137.303717-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: CDVMxLQWFXzP9aqMOTmtC_7WXE5KBwkcTdR1_n_82bo_1780075916
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
 rust/kernel/sync/lazy_init.rs | 352 ++++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs      |  11 ++
 3 files changed, 365 insertions(+)
 create mode 100644 rust/kernel/sync/lazy_init.rs


base-commit: 0e42ec83d46ab8877d38d37493328ed7d1a24de8
-- 
2.54.0

