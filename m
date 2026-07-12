Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA754C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB6810E0EA;
	Sun, 12 Jul 2026 15:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YM1SkcF7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2F610E0EA
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:36:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B641E6004E;
 Sun, 12 Jul 2026 15:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B81F000E9;
 Sun, 12 Jul 2026 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783870562;
 bh=/c8dQlrD+UopIRGkuo0OWH1leob6jgbBkZdHtJYCJ9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YM1SkcF7SY84HKWxBJqeyCkrPQB8hvipq1YbGjaTSOLWX2edqyfRC7/aRJY46FRVQ
 8OppOKhkEskZ1hFCJd8S15txrxcTrRJmIb/NqLzj49jVXwk3QgP4vq8zC4p9A8mBmi
 CxjTipfMBJocq1yS3ImtkUJJgX4VYcgU4E60RQRYVPmMFUv2j0sJ/zhOPTPedhTHG/
 A2WKkWkva4pDBjhwgQeL/3PwoU0A/3kGrtD8nLcDUrtjD6OG4vWC+JcI4QAwNZreMZ
 QU98zlLyaGlSsvG2T/X34wZJvv2XbSrTxW6uWGr8nrYkuhVbDUSKuvCM2U471/109U
 h1ezctZwG8/IA==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, daniel.almeida@collabora.com, acourbot@nvidia.com,
 ecourtney@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com, lyude@redhat.com,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 00/19] rust: drm: Higher-Ranked Lifetime private data
Date: Sun, 12 Jul 2026 17:35:51 +0200
Message-ID: <20260712153551.1097724-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

On Sun, 28 Jun 2026 16:53:20 +0200, Danilo Krummrich wrote:
> [PATCH v5 00/19] rust: drm: Higher-Ranked Lifetime private data

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/19] rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
      commit: 68b151bc6145
[2/19] rust: drm: rename Uninit DeviceContext to Normal
      commit: fd0f827c532b
[3/19] rust: faux: add Device type with AsBusDevice support
      commit: 893f39dadaa1

      [ Drop redundant 'struct device' invariant; implied by valid
        struct faux_device. - Danilo ]

[4/19] rust: drm: Add Driver::ParentDevice associated type
      commit: 49e27d58a06d
[5/19] rust: drm: change default DeviceContext to Normal
      commit: 903001300874
[6/19] rust: drm: restrict AlwaysRefCounted to Normal Device context
      commit: 506a7d63dab0
[7/19] rust: drm: restrict AlwaysRefCounted to Normal GEM Object context
      commit: ec8b2cc27c76
[8/19] rust: drm/gem: remove DeviceContext from shmem::Object
      commit: 7f994b8912eb
[9/19] rust: drm: split Deref for Device context typestates
      commit: 1c8a1f88ac32
[10/19] rust: drm: pin ioctl Device reference to Normal context
      commit: 499eb35cd477
[11/19] rust: drm: add Ioctl device context typestate
      commit: 86b20b11505d
[12/19] rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sections
      commit: 2455d5f2d5e8
[13/19] rust: drm: Wrap ioctl dispatch in RegistrationGuard
      commit: 478da53e5b68

      [ Use imperative mood in commit message; clarify __dev_ctx_cast() doc
        comment to reflect Ioctl-to-Registered cast. - Danilo ]

[14/19] rust: drm: return ParentDevice from Device AsRef
      commit: 47f600d40bc6
[15/19] rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>
      commit: 453197b7cc32
[16/19] drm: fix race between partial drm_dev_register() failure and ioctl
      commit: eb197f7d60f0
[17/19] rust: drm: Add RegistrationData to drm::Driver
      commit: e15b88223dc1

      [ Move registration_data_unchecked() to Device<T, Registered> impl
        block. - Danilo ]

[18/19] rust: drm: Pass registration data to ioctl handlers
      commit: 3ba210061c29
[19/19] drm: nova: Use drm::Device<Registered> to access the parent bus device
      commit: 354a8f8b098b

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
