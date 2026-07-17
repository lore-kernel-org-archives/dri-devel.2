Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3AEC44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12C410E452;
	Fri, 17 Jul 2026 13:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UFaKp3K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D391D10E452
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:07:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F02A760204;
 Fri, 17 Jul 2026 13:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129A51F000E9;
 Fri, 17 Jul 2026 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1784293659;
 bh=mooRlPTlUqV1sVp6NuD8rb2bN7qHo0BLIrW5P+Xgh9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=1UFaKp3K1wugDE8JEb8ay0NtdC9vP4PtHFh0AE/O8qOH85sTTFovb+4ptE2qqLA0p
 L4c55q22J1kNNNzoHIBXMQiC9DTw6EM1SFK4DPR4NthzUte3gFETh0B4SOaNuMbcdW
 KYq2ylYlMHrAxWiMgrUYrCR/9mRDvjrWdvPQFyKo=
Date: Fri, 17 Jul 2026 15:07:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 06/10] rust: miscdevice: set fops.owner from driver
 module pointer
Message-ID: <2026071725-unpiloted-bogus-f1de@gregkh>
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-6-2495cfa82d47@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-fix-fops-owner-v8-6-2495cfa82d47@linux.dev>
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

On Mon, Jul 13, 2026 at 02:45:27PM +0800, Alvin Sun wrote:
> Set the miscdevice fops owner field from the driver module pointer
> via the `this_module::<T::OwnerModule>()` helper, instead of
> defaulting to null.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/miscdevice.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
