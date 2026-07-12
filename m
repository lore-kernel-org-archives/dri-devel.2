Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB14C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 00:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A9610E3C8;
	Sun, 12 Jul 2026 00:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5SWi+hF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6DF10E3C8
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 00:08:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A0B0600AE;
 Sun, 12 Jul 2026 00:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084891F000E9;
 Sun, 12 Jul 2026 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783814880;
 bh=ttgZInexN3hBBgwLbtnF4oTV34tO3wrwFS76SfDUJdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J5SWi+hFTQYmZK96ZeOkuaP58ZPKDKqRb0r3g3ok0mZjX/unGMJng2mIqq19Aoeqd
 wyM9jUfIYPsl2T1yEW9hRGnwbalsQXFUgeRI3pMJWyYIyhm9iLBVKMkhpbSemU9B20
 ZSYSkKD6Wb+TTkYtf9fSpD1xB4Z/8Cw/+GeDuAyiBhEQLzM33jxtEaZAuQM1gEo8ak
 +FpazN01QDRXCq1b+x27XlVX2tG5zLLvKs7RfiZ/grZng/+9sFSyZN4gVVAlR4aBll
 mqmXdaee6/OAnPW8GwqudeACohryNO8NRsWyEShSxXM5tXNpUgTOiMBLAjzEEyXi6N
 72+HzdUlSPHvw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com,
 m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com,
 kwilczynski@kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/7] ForLt/CovariantForLt split,
 auxiliary closure API and DevresLt
Date: Sun, 12 Jul 2026 02:07:51 +0200
Message-ID: <20260712000751.749981-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
X-Patch-Reply: applied
MIME-Version: 1.0
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

On Fri, 26 Jun 2026 20:36:07 +0200, Danilo Krummrich wrote:
> [PATCH v4 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt

Applied, thanks!

  Branch: topic/dd-lifetimes
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/7] rust: types: rename ForLt to CovariantForLt
      commit: 2c91f57e81a7
[2/7] rust: types: introduce ForLt base trait for CovariantForLt
      commit: 1b56056294d4

      [ Merge ForLt pub use, inline resolve_hrt/ty_static, add intra-doc
        links. - Danilo ]

[3/7] rust: auxiliary: add registration_data_with() for ForLt types
      commit: 491784c54cc1
[4/7] rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
      commit: 6763c8876d2a
[5/7] rust: devres: add DevresLt for ForLt-aware device resource access
      commit: b85f672a3e68
[6/7] rust: pci: return DevresLt from Bar::into_devres()
      commit: e7e6bf5af80e

      [ Add default SIZE parameter to DevresBar. - Danilo ]

[7/7] rust: io: mem: return DevresLt from IoMem/ExclusiveIoMem::into_devres()
      commit: 7488dc14b05a

      [ Add default SIZE parameter to DevresIoMem. - Danilo ]

The patches are in the topic/dd-lifetimes topic branch and will be merged into
the corresponding target branch soon.
