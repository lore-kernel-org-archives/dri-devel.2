Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE631CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3156D10E918;
	Mon, 11 May 2026 22:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aTkUrt93";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E381010E52C
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:56:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AFFBE600CB;
 Mon, 11 May 2026 22:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33552C2BCB0;
 Mon, 11 May 2026 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778540180;
 bh=QWVDVaeWXV4GbyWgoNQbtUfQbuZpi8pMwF5GmRCH69s=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=aTkUrt93T4INKuz/JUkst2NoH/4WTrHZDn5J6NVFkO0Sjkv21Cnt18j1Q+2KOlFLA
 HkueXpk/4xIJ8PsT6YeQ1Wq6Ge6Al36L+JoX1wjcDplLOtT67dYkISlPXGRwELUwZv
 sAmSeWIPm5V/1bDyxMjQeUdiANWWWZZ8F/NWQMNYqRoPydnalHvLGnyg+viK1hMBDa
 cwkIAHNtXdhP1jw5GjPkDTafDVJJPM6AyFFCsFKXbZU0xegQ15GL8sqYF8VBYfzTQu
 3g/fpf+u9BtLBYNIpwtsRBCQy7pjqKvEq8x91V6w3iiuqUPCnBxnpoWng5fN3A0GRV
 /utGGdamwtkvQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 00:56:11 +0200
Message-Id: <DIG7VF8XA0KX.3GLHRET0SLOTN@kernel.org>
Subject: Re: [PATCH v2 00/25] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <2e1c9a71-46e7-4036-91ac-86453564b223@de.bosch.com>
In-Reply-To: <2e1c9a71-46e7-4036-91ac-86453564b223@de.bosch.com>
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

On Thu May 7, 2026 at 2:14 PM CEST, Dirk Behme wrote:
> I have applied this series together with [1] on top of 7.1.0-rc1. I made=
=20
> some adaptions to local changes (e.g. my ARM64 TMU interrupt test) and=20
> boot tested it. Several parts this patch series touches (e.g. PCI,=20
> auxiliary, gpu) I might not use or even don't have it enabled. So I=20
> don't know if this is worth mentioning
>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> Please feel free to ignore this, then.

Thanks Dirk! Any test coverage is valuable and much appreciated.
