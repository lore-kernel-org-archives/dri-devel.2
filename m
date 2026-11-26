Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1592606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWqcqI6a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3977011263D;
	Thu, 26 Nov 2026 17:39:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D398B11263D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 17:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA7242A2D;
 Thu, 26 Nov 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795714782;
 b=LZDJr16jNdttlJHmKfxTnmEmYFlmKU2wn9E1QgfvMMHbL5Ydg9A5KKM14BupwgtJZFQt
 rUJ6+r7YnQlOabm4TlvGd2dp3A/g7qqu5Gl+ffkEHlSFcawMvJ3gGDTc5Ea0S9nXa+XaV
 uB0zeA/P1UJD2+Wh3Ip2T175LGVWhYg12e5VzLxKP67xgixPRUYtasBGsLPAU3taPUC0C
 xdKhhNFIEFum2PIM5zI84m6mJQsAPtM/YpRzCYsWb0Di71b9thRatb01jbIWrqc/znP4F
 BGfzVt2VNnvxK5KR0+cM0xlQKpv7E9eBnjj5lZ/N9xKU6MCw4WGZDT1r5tMdohD+wSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795714782;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=R62Wh6i/3I5VkULThJ3xEjHzN2yym/9yj8wdhCqNoJQ=;
 b=FppAy+S1qlAYn3ywepHx1OOcD5g6kYj0TDNzDnmnz0NGTK3kZ1nC2jhiSpxuSAOnGFAn
 Ib/QoCMRVMhXPXkvuxERrbH8jmN8QM2Ss62qxFTXT9p4e0f9LuVo26VoDEV7wwmlmxrJF
 8oNWe7oS227E+tCKs/4FtFvmvjGZxNpXvHYEi3F0UxPVBZegInT1y0ll8usHeLMtbwUW6
 zW/nCApgDBCz6HH6uX39u6wtE9vCRDiw3UYNRyBdYqpYz+yNuy5FoqvrKMm2n+V+lkL6e
 dhorVPETgMbOKk37A3e5DOirTxMtP/9hu2/TGuDGzZJpQc3GB3aQ1HJEz6B8wxErCRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D3AF91F000C0;
 Thu, 26 Nov 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795714782;
 bh=R62Wh6i/3I5VkULThJ3xEjHzN2yym/9yj8wdhCqNoJQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=gWqcqI6aZ3VwxGb7k0iYI2trdIY9f8yad8Fz24+jidbs9QeTHhlHLbmOyVDg5g8AY
 93o/3aqeALZqvP4hI+4AWPIcQ8vA3HTJ3qMLztpxwL6qg29CunnqmcHSNRjE72I3mc
 jSMFUJSrp2WpnF8EKsZ21OC70lgt/enZxzNF6V9RYaro47gsUIvbD0aMBabLaoOWTy
 C2n8hpvsDoFoSJV79NCcb6KzS+Nd/yfP8B4HFfKlrcoZEt25zoDFppFoDz1os3uxzr
 UsshfySTszN6spRjWz2Kg083lrm4qOc92qduGXeuDcCwx5Hty83pmJJJd2oMZz4pj6
 ZAntm+Mn4RnJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4093D4D774;
 Thu, 26 Nov 2026 17:39:37 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 18:39:33 +0100
Subject: [PATCH v2] rust: drm: enable standard fdinfo for Rust drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-fix-drm-rust-fdinfo-v2-1-b1653edf1e4f@gmail.com>
X-B4-Tracking: v=1; b=H4sIANRuCGsC/32OQQ6CMBBFr0K6dpQBIuDKexgWpZ1CjbSmBYIh3
 N0Wo0uXb/Lm5a/Mk9Pk2SVZmaNZe21NgOyQMNFz0xFoGZhlaXZGxBqUXkC6AdzkR1BSG2WhIix
 ViVLWImfh8+koaHv11nzYT+2dxBhT0Wi5J2gdN6KPp2/w9CsbWsYo9tqP1r32fTPG4P8pMwKCw
 FQVmBdFVclrN3D9OAo7sGbbtjeTtMqY8QAAAA==
X-Change-ID: 20261119-fix-drm-rust-fdinfo-8e17f71dd9c3
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795714775; l=2361;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=Q2j2ETDtWfIZSvsCcbvYzOAWgDMeNdy/ivFkVQ1rlgI=;
 b=YYMlzYjjLBwQBVI/TNvkEOL/k8jXJiwB84BgOOL63cPbtrPY3kuMOpeybnCbtCTlUNTMtE5iS
 de4hmC1qM6jBEaYPOQWBjk4ig7ze5HxEge8udesd6l5BdVExQZ7ioNV
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: peder.bergan@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peder Bergan <peder.bergan@gmail.com>

DRM monitoring tools use drm-driver and drm-client-id in procfs fdinfo
to identify DRM clients. The common Rust DRM file operations leave
show_fdinfo unset, so these entries are missing for those clients.

Set show_fdinfo to drm_show_fdinfo. The DRM core helper emits the
standard client information. Rust DRM does not yet expose the optional
driver-specific statistics hook.

Closes: https://github.com/Rust-for-Linux/linux/issues/1266
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
Danilo, VTABLE.fops points to UnregisteredDevice::FOPS. Procfs calls
FOPS.show_fdinfo, so this patch installs drm_show_fdinfo there. The helper
calls VTABLE.show_fdinfo when the driver supplies additional statistics.

Matt Mireles reported the missing fdinfo fields on an Asahi kernel and
suggested using this helper.

Janne Grunau tested v1 with the downstream Asahi driver on Apple silicon.

OpenAI Codex assisted with coding and testing.
---
Changes in v2:
- Rebase onto drm-rust-next and set the callback in UnregisteredDevice::FOPS
  now that the file operations have moved to drm::device.
- Drop the Fixes tag and clarify that Rust DRM has yet to expose the
  optional driver statistics hook.
- Add the Reviewed-by and Tested-by tags from v1.
- Link to v1: https://patch.msgid.link/20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com
---
 rust/kernel/drm/device.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 1c5b0abb492be..c460ba3706bf9 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -273,6 +273,7 @@ extern "C" fn fops_open(inode: *mut bindings::inode, filp: *mut bindings::file)
         fops.read = Some(bindings::drm_read);
         fops.llseek = Some(bindings::noop_llseek);
         fops.mmap = Some(bindings::drm_gem_mmap);
+        fops.show_fdinfo = Some(bindings::drm_show_fdinfo);
         fops.fop_flags = bindings::FOP_UNSIGNED_OFFSET;
 
         fops

---
base-commit: 4325f4aad9727a6e8e7f10c5d2ebf490470cf938
change-id: 20261119-fix-drm-rust-fdinfo-8e17f71dd9c3

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


