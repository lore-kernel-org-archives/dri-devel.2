Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE0FFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69C710E345;
	Tue, 28 Apr 2026 10:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CW32II6V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E91B10EAC2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:04:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DC0160142;
 Tue, 28 Apr 2026 10:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7495C2BCAF;
 Tue, 28 Apr 2026 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777370691;
 bh=THDA4pSnz8O0I8vbRxRJhS+Zowg7suy5Oc816KLBmBQ=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=CW32II6Vi5epjGbH85TrnoRsJam4VJ57mGOa8wDqbkmv1awiASfTD6wpYZ5Xgo7gt
 cveKQQkEkfPH6nqNJEpBGD3g+Xnw3q4COpis2etqpyJYseDnU2crRhK4BJUB6izqT/
 BBGFZyvDciDPMPrGIRRmf/jR+HyOo8a1aePha945K9ehKl7CF2tXAMe48rJbJRd6vI
 AOh/9OwF+UjCPr9FFE4UHOd2DyvzX8ENL/aZeDmhpQWHfPJbe8/01pckTaAR3t87cB
 U+DRN5WryXLuj+jE4XBHoNLE7CFUPXylmoECZcniahdwBsDXTMDqij3eepjht1fZGQ
 QitOdXqeyWx5Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:04:44 +0200
Message-Id: <DI4PBO6KS860.1699VQUG68OI0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <m.wilczynski@samsung.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afB-p7vhyVYlcTn6@monoceros>
In-Reply-To: <afB-p7vhyVYlcTn6@monoceros>
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

On Tue Apr 28, 2026 at 11:37 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> I didn't try to understand what you do here, but there is nothing
> scheduled so far for the pwm_th1520 driver in my tree, so

Compressed to one sentence, it is driver core plumbing to allow bus device
private data (and registration data) to represent their lifetime being tied=
 to
the device / driver lifecycle with native Rust lifetimes.

Drivers can take advantage of this subsequently; for reference see the nova=
-core
changes at the end of this series.

> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> for patches #12 and #19 touching this driver for merging through (I
> guess) the rust tree.

Thanks -- as mentioned, it is driver core plumbing, so eventually I'll take=
 it
through the driver core tree.

- Danilo
