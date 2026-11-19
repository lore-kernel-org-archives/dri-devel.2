Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933B606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8iu34cB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308E810EE0C;
	Thu, 19 Nov 2026 17:28:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7254F10EE0C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:28:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5354F618B1;
 Thu, 19 Nov 2026 17:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1761F000C5;
 Thu, 19 Nov 2026 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795109292;
 bh=MBitJYL2/UcM46VwgXCfRsDu1jd7w3VQLlGcia31y9Y=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=g8iu34cBbiseCsOHSffAmyr3qpzB/uHPmPHo58aYmg764mPuvzTUwIwUobNPFVkxw
 1iroSANozUsXJybkR6WGHaYiD0wLduXLXLbPKpfpErZCb5r6jX49umF6K+3gqko52A
 WLOLTR0A7SNEIAwJVocWWFAWq0t+59MBRachTe219OYADRf0kF12/bnGzY6JRsZpRZ
 6MbOj4HFxyaEE86OxlGyMRz2iWmb1vO4Jg5jJ2he6Z/QxzxM75+YdnqtrtAevUG3KI
 gxadmmIRjA5mRuLAI+F908piEtCN0qLQkKOGKh+MT7M8X8cSSjB6IR9eMV6imI+Q82
 bpJBp/Mm48fWg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 18:28:07 +0100
Message-Id: <DMZD4TXCZSRX.HN0ETV0FWFIY@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
References: <20261118181245.2583303-1-dakr@kernel.org>
 <20261119111746.3049044-1-aliceryhl@google.com>
 <DMZ5ER6XTNLG.2ZJOF7F4100XW@garyguo.net>
 <CAH5fLghc63zD9c1F437pQiX+ohgSkYQe4nt3xP4gSTsqAVLzBA@mail.gmail.com>
In-Reply-To: <CAH5fLghc63zD9c1F437pQiX+ohgSkYQe4nt3xP4gSTsqAVLzBA@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 12:49 PM CET, Alice Ryhl wrote:
> Good idea

Indeed, what do you think about this?

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 774db3acb15a..8c48dcfdecec 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -158,7 +158,11 @@ const fn compute_features() -> u32 {
         open: Some(drm::File::<T::File>::open_callback),
         postclose: Some(drm::File::<T::File>::postclose_callback),
         unload: None,
-        release: None,
+        release: {
+            // The DRM core frees the device without running a Rust destru=
ctor.
+            const_assert!(!mem::needs_drop::<Device<T, Normal>>());
+            None
+        },
         master_set: None,
         master_drop: None,
         debugfs_init: None,
