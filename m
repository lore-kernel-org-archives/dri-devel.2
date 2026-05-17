Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882F1CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9639B10E215;
	Sun, 17 May 2026 14:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b7hn5KyF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAC110E215
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:32:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D40F860125;
 Sun, 17 May 2026 14:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A257AC2BCB0;
 Sun, 17 May 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779028336;
 bh=ulaOuKvCeT6t5jbenSb1LbQU7lp8mpBN6cfjZZoeaOw=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=b7hn5KyFLmpCLuD3zK9Svmq9lIXAno/+es90/BP2+vlpLNcZVDHpVD1P+Je8H1j7A
 3uhnNDNQxihXm10aFTSJ9zEvo2h8iB91wrpUdRqP5yQGKhrc02O52UHmADR6/yrlEY
 Ygpk51UPFE9/iMiKddQLVtziwtaVwY/8rLgVLeR8sG0Lr7gU5L+XYpbHwSUR1dBwR7
 rE5V84b7XieaRLK7+0tZXUUShD/vW88LUIguHXd5MGejGAJsXrwxhAUmUbCdBk4xp5
 P4UUB8RvE9/P+vY9VBAO3VKq8sVkJjWinWYjd5t+biZbp8UPCwc0hYJUhNbY6b3izq
 kBAHFbMBrhCeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 16:32:09 +0200
Message-Id: <DIL0WRS36ZL2.2CT5UNXVH8VKE@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 03/27] rust: driver: decouple driver private data
 from driver type
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-4-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-4-dakr@kernel.org>
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

On Sun May 17, 2026 at 2:00 AM CEST, Danilo Krummrich wrote:
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 586091cfa45c..3506b4e8bff9 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -17,6 +17,9 @@
>  //!     /// The type holding information about each device ID supported =
by the driver.
>  //!     type IdInfo: 'static;
>  //!
> +//!     /// The type of the driver's bus device private data.
> +//!     type Data;

Should be:

@@ -13,10 +13,13 @@
 //! The main driver interface is defined by a bus specific driver trait. F=
or instance:
 //!
 //! ```ignore
-//! pub trait Driver: Send {
+//! pub trait Driver {
 //!     /// The type holding information about each device ID supported by=
 the driver.
 //!     type IdInfo: 'static;
 //!
+//!     /// The type of the driver's bus device private data.
+//!     type Data: Send;
