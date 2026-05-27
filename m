Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E00CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 21:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B9510E090;
	Wed, 27 May 2026 21:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CSCgBgiz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF94710E090
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 21:26:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 843F44470D;
 Wed, 27 May 2026 21:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0018D1F000E9;
 Wed, 27 May 2026 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779917197;
 bh=vNRtcKe/VrnPWd08v/e3phvPSfc8rENS+DLm2ORP08k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CSCgBgizbEY3kXallzJU7ibiCgwCJwPQy0QtOakmUKJRkkCI5LnTYlcyR0bM4nP3r
 mwHi0OBuW9Z5n2qZ5sA8MLq+OECjzujI4ubmbp3gsW27dJ0hAGGb0U88fC83g6LaEh
 bSIJINfBsEipyizGLj+V2Ax/0IpG+T7DtcbNhHB7bpPn4rNGX94nS+IPwQfuJx39IU
 L8oFStGOqsp3JowPO/gXoEYyEhd/toZjZ7GYVYW0NOBTw4fZHN8ESA+/3QiwDt48y2
 AetqVFudWqvRCAJbaa7rJ425ef3jDsIb1/uRelRgfxtaAfhRvPlWUw0ymdTc1thAWZ
 SXpHpmAJwxW/A==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Date: Wed, 27 May 2026 23:24:53 +0200
Message-ID: <20260527212453.1506899-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

On Mon, 25 May 2026 22:20:47 +0200, Danilo Krummrich wrote:
> [PATCH v5 00/24] rust: device: Higher-Ranked Lifetime Types for device drivers

Applied, thanks!

  Branch: topic/dd-lifetimes
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/24] rust: pci: use 'static lifetime for PCI BAR resource names
      commit: e566a9e17f37
[2/24] rust: alloc: remove `'static` bound on `ForeignOwnable`
      commit: e9df918d61e0
[3/24] rust: driver: move 'static bounds to constructor
      commit: c8a43666bade
[4/24] rust: driver: decouple driver private data from driver type
      commit: 7fdffdda630e
[5/24] rust: driver core: drop drvdata before devres release
      commit: be31fcf5af75
[6/24] rust: pci: implement Sync for Device<Bound>
      commit: 0b9a29c3a4e2
[7/24] rust: platform: implement Sync for Device<Bound>
      commit: a89111c00b68
[8/24] rust: auxiliary: implement Sync for Device<Bound>
      commit: 5bbcefe8db74
[9/24] rust: usb: implement Sync for Device<Bound>
      commit: 3bb1655192ae
[10/24] rust: device: implement Sync for Device<Bound>
      commit: de12e48a1be3
[11/24] rust: device: make Core and CoreInternal lifetime-parameterized
      commit: 24799831d631
[12/24] rust: pci: make Driver trait lifetime-parameterized
      commit: 16c2b8fdab7c
[13/24] rust: platform: make Driver trait lifetime-parameterized
      commit: 81fdc7881443
[14/24] rust: auxiliary: make Driver trait lifetime-parameterized
      commit: 46f651d88662
[15/24] rust: usb: make Driver trait lifetime-parameterized
      commit: a3f09f8e47c4
[16/24] rust: i2c: make Driver trait lifetime-parameterized
      commit: 71e6b6a80b51
[17/24] rust: driver: update module documentation for GAT-based Data type
      commit: d31a349a7fd8
[18/24] rust: pci: make Bar lifetime-parameterized
      commit: 8ea0b6d5bef5
[19/24] rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
      commit: 89f55d04c602
[20/24] samples: rust: rust_driver_pci: use HRT lifetime for Bar
      commit: e397d405c4c6
[21/24] gpu: nova-core: separate driver type from driver data
      commit: bb1cf43f2fa8
[22/24] rust: types: add `ForLt` trait for higher-ranked lifetime support
      commit: e189bdb687a5

      [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
        and WF checks. Since proc macros cannot expand macro_rules!, add a
        visit_macro() implementation to conservatively assume macro
        invocations may contain lifetimes, forcing them through the
        compiler-assisted covariance proof.
      
        Fix a few typos in the documentation and in the commit message, add
        empty lines before samples, add missing periods and consistently use
        markdown.
      
        - Danilo ]

[23/24] rust: auxiliary: generalize Registration over ForLt
      commit: 4555291ddae9

      [ Use PhantomData<F::Of<'a>> instead of
        PhantomData<(fn(&'a ()) -> &'a (), F)>], which also gets us rid of
        #[allow(clippy::type_complexity)]. - Danilo ]

[24/24] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
      commit: d18f3646184f

The patches are in the topic/dd-lifetimes topic branch and will be merged into
the corresponding target branch soon.
