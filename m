Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86F606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IGWs9USx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B058112001;
	Wed, 25 Nov 2026 22:48:47 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D018D10FFF2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646892; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EQgbQv5ge2ir6H8NNZrU9e+g/p+N5gabMcJ8MV4s5D3mcWSERzBjaYjDb3tS4ICH9gmvpCwO3dzAXdCJYZD8PLOYh3cmd5xAOJk/FuIk8AzsZVKUkz+EGGqLOxypTMWH0HlI4f7dpkGKUKBa6texTzeaomgp7X6f4X+1gc+YqNc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646892;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=89a+DyuMeQJsG4Oq5bs30wnrcAo2VSWhNCr/+dnzrqA=; 
 b=XqOZBMrO6mP4lYq/5sghitOR2VWKLvAFlF1gL+zjY45U8Z6AWbT/AQj7JwPgMEJQj15vbjnheIKYHkDZVT9otfN4InP5hWRpwpwIIADg5kexI2z0V/RkLZd1Ro+7g0+TlLkQRe0WcsLEYy6rNTU1g6+hTJKWZXsyHmaJyKSlmcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=IGWs9USxhQMoUKhfIHpO2NunOsVRzaC9xMrHPZJOnBk0UP7Wvj1QfT8r9qAz1mEdr6dV57uPUbeIiIQDauJWRx1LeENMTjgicv06lbLDFrxFHjrsOsotSrGCLXUWKmRkXuYWjUkgaj0n2sbIyGISiKRHdYaSTamk5OwHTznpAdA=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=89a+DyuMeQJsG4Oq5bs30wnrcAo2VSWhNCr/+dnzrqA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646890481658.6372610063196;
 Wed, 25 Nov 2026 14:48:10 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:47:04 -0300
Subject: [PATCH 13/13] drm/tyr: deny `clippy::as_conversions`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-13-2b2f53164d86@collabora.com>
References: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
In-Reply-To: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An `as` cast silently drops the bits that do not fit the target type,
and nothing at the cast shows whether that can happen. As part of a
larger effort to reduce the number of `as` casts in Tyr, deny
`clippy::as_conversions` in the driver, so that Clippy rejects a new
cast unless it carries an `#[expect]`.

The casts that remain are all justified in a `// CAST:` comment and
marked that way.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/tyr.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index e7ec450bdc9c..ced937af4c53 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -5,6 +5,11 @@
 //! The name "Tyr" is inspired by Norse mythology, reflecting Arm's tradition of
 //! naming their GPUs after Nordic mythological figures and places.
 
+// `as` conversions can silently truncate, so they are denied by default in
+// this driver. A conversion that cannot be avoided is justified in a
+// `// CAST:` comment and marked with `#[expect(clippy::as_conversions)]`.
+#![deny(clippy::as_conversions)]
+
 use crate::driver::TyrPlatformDriver;
 
 mod driver;

-- 
2.56.0

