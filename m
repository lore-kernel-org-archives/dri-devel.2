Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF3C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C3710ED60;
	Tue, 14 Jul 2026 13:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eq9DrFNT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D6A10ED60
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784036857; x=1815572857;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n9cCVYuuPM0Dnz0kn/VctvAQ6WLJatsDO30dDYNF2u0=;
 b=eq9DrFNT4Czi4+HNJUy6CFHuqjlT4rTfjLXDaib9TWRUL93+I+SS910Q
 T5DOUXNiUJMVQkKuQJabLHQRyjg9EX9EM/s4kikt+NqHxV6hW2pQXY0WI
 BrLj1EqRqP/GpXGy15+w+XMTYQsDv2ANOrHhUzUIM9mQ9cUpBJGDAKLky
 5A4Bw6mg4OLTJxFwV8F/sYZihhE7H4FOTOCcmNhZA4UYtHUqEsnIdZlzK
 oB4ZucabqfWBPA2RC2do6vBHwXUz2ylHRBiqs7c2+0ESdhq4jz/PKLjRf
 KnrlISwwmAjBzhuvsqnh3TcpGf7hBTvGpOIHg1SdkBtyrWWMhitXj0DKE A==;
X-CSE-ConnectionGUID: djtHNnFYT2yTXbGILNDBxQ==
X-CSE-MsgGUID: p4/+tEImReOY//FB42IElQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84679907"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="84679907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 06:47:36 -0700
X-CSE-ConnectionGUID: 8znTZVoHTtav2Iqu6z5n4w==
X-CSE-MsgGUID: dsEiQAvhQAGBdknanV7u9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="256506736"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa009.jf.intel.com with ESMTP; 14 Jul 2026 06:47:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wjdTq-00000000Mg8-2pQS;
 Tue, 14 Jul 2026 13:47:26 +0000
Date: Tue, 14 Jul 2026 21:47:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gary Guo <gary@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and `CoreInternal`
 invariant
Message-ID: <202607142146.1EoHdPGy-lkp@intel.com>
References: <20260713201455.640151-1-gary@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713201455.640151-1-gary@kernel.org>
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

Hi Gary,

kernel test robot noticed the following build errors:

[auto build test ERROR on a13c140cc289c0b7b3770bce5b3ad42ab35074aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Gary-Guo/rust-device-make-lifetime-on-Core-and-CoreInternal-invariant/20260714-041724
base:   a13c140cc289c0b7b3770bce5b3ad42ab35074aa
patch link:    https://lore.kernel.org/r/20260713201455.640151-1-gary%40kernel.org
patch subject: [PATCH] rust: device: make lifetime on `Core` and `CoreInternal` invariant
config: x86_64-buildonly-randconfig-002-20260714 (https://download.01.org/0day-ci/archive/20260714/202607142146.1EoHdPGy-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260714/202607142146.1EoHdPGy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607142146.1EoHdPGy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0700]: hidden type for `impl pin_init::PinInit<RustDebugFs, kernel::error::Error> + 'a` captures lifetime that does not appear in bounds
   --> samples/rust/rust_debugfs.rs:154:9
   |
   150 |       fn new<'a>(pdev: &'a platform::Device<Core<'_>>) -> impl PinInit<Self, Error> + 'a {
   |                                             --------      ------------------------------ opaque type defined here
   |                                             |
>> |                                             hidden type `impl pin_init::PinInit<RustDebugFs, kernel::error::Error>` captures the anonymous lifetime defined here
   ...
   154 | /         try_pin_init! {
   155 | |             Self {
   156 | |                 _compatible <- debugfs.read_only_file(
   157 | |                     c"compatible",
   ...   |
   176 | |         }
   | |_________^
   |
   = note: this error originates in the macro `::pin_init::pin_init` which comes from the expansion of the macro `try_pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)
   help: add a `use<...>` bound to explicitly capture `'_`
   |
   150 |     fn new<'a>(pdev: &'a platform::Device<Core<'_>>) -> impl PinInit<Self, Error> + 'a + use<'a, '_> {
   |                                                                                        +++++++++++++

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
