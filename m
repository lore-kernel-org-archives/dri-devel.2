Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B54105D9B9
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D4110E677;
	Wed,  8 Apr 2026 14:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VJkj7JIX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE75910E677
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F1004600CB;
 Wed,  8 Apr 2026 14:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F499C19424;
 Wed,  8 Apr 2026 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775657426;
 bh=7mobTWvqP8lwlg0dJRWwGCMEAcHlqyzmooECA6LLTII=;
 h=Date:From:To:Cc:Subject:From;
 b=VJkj7JIXy7o2L6LPWNxptzHRc07FQHJ14eTeYI9cAtKEDX+xajUAzmKjRTPFSTyIP
 v+N8qRzNfoXSCzTYHL5GJKf7ongKVDO6y4lY3n9ubKm3s0bhtR450m+c+pvDCVQzxN
 sG7cMv3fFTezB3br7yyjWKZxeUnuQauDkqpJoc3JAPfix5jSskyYxmBf2z+rRYq+JY
 WtScNE8n2761FNdnhSxkst94sW0tTMtS08X6ZwZ1PiOPtzTM8/dzENcYgCNT6haMf9
 PWCKL0919xtfLXZ5y3ZOMSwZ6HOZyyKqNz8FCvZ4c6/VR2vyQj2GR1ZO4F/XJUXZHy
 4NYvWowikYrVg==
Date: Wed, 8 Apr 2026 15:10:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
Subject: linux-next: manual merge of the drm tree with the rust tree
Message-ID: <adZhzvTbFS_usXsX@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  rust/kernel/lib.rs
  scripts/Makefile.build

between commit:

  d1aa40daa777c ("rust: kbuild: remove `feature(...)`s that are now stable")

from the rust tree and commits:

  80df573af9ef3 ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")
  3cc319d5f433a ("rust: enable the `generic_arg_infer` feature")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/tyr/driver.rs
index e833e9f537b02,6114346415805..0000000000000
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
diff --cc rust/kernel/lib.rs
index 0fa9d820fe7c8,40de00ce4f971..0000000000000
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@@ -16,9 -16,38 +16,12 @@@
  // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
  // the unstable features in use.
  //
 -// Stable since Rust 1.79.0.
 -#![feature(generic_nonzero)]
 -#![feature(inline_const)]
 -#![feature(pointer_is_aligned)]
 -#![feature(slice_ptr_len)]
 -//
 -// Stable since Rust 1.80.0.
 -#![feature(slice_flatten)]
 -//
 -// Stable since Rust 1.81.0.
 -#![feature(lint_reasons)]
 -//
 -// Stable since Rust 1.82.0.
 -#![feature(offset_of_nested)]
 -#![feature(raw_ref_op)]
 -//
 -// Stable since Rust 1.83.0.
 -#![feature(const_maybe_uninit_as_mut_ptr)]
 -#![feature(const_mut_refs)]
 -#![feature(const_option)]
 -#![feature(const_ptr_write)]
 -#![feature(const_refs_to_cell)]
 -#![feature(const_refs_to_static)]
 -//
 -// Stable since Rust 1.84.0.
 -#![feature(strict_provenance)]
 -//
+ // Stable since Rust 1.89.0.
+ #![feature(generic_arg_infer)]
+ //
  // Expected to become stable.
  #![feature(arbitrary_self_types)]
 +#![feature(derive_coerce_pointee)]
  //
  // To be determined.
  #![feature(used_with_arg)]
diff --cc scripts/Makefile.build
index 57cff77c28973,010d08472fb2b..0000000000000
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@@ -310,13 -310,19 +310,14 @@@ $(obj)/%.lst: $(obj)/%.c FORC
  
  # The features in this list are the ones allowed for non-`rust/` code.
  #
 -#   - Stable since Rust 1.79.0: `feature(slice_ptr_len)`.
 -#   - Stable since Rust 1.81.0: `feature(lint_reasons)`.
 -#   - Stable since Rust 1.82.0: `feature(asm_const)`,
 -#     `feature(offset_of_nested)`, `feature(raw_ref_op)`.
 -#   - Stable since Rust 1.84.0: `feature(strict_provenance)`.
  #   - Stable since Rust 1.87.0: `feature(asm_goto)`.
+ #   - Stable since Rust 1.89.0: `feature(generic_arg_infer)`.
  #   - Expected to become stable: `feature(arbitrary_self_types)`.
  #   - To be determined: `feature(used_with_arg)`.
  #
  # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
  # the unstable features in use.
- rust_allowed_features := arbitrary_self_types,asm_goto,used_with_arg
 -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,generic_arg_infer,lint_reasons,offset_of_nested,raw_ref_op,slice_ptr_len,strict_provenance,used_with_arg
++rust_allowed_features := arbitrary_self_types,asm_goto,generic_arg_infer,used_with_arg
  
  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
  # current working directory, which may be not accessible in the out-of-tree
