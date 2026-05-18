Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F43CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9681010E508;
	Mon, 18 May 2026 16:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n6oBjBu2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA00210E508
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:11:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E988C60217;
 Mon, 18 May 2026 16:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D6C2BCB7;
 Mon, 18 May 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779120666;
 bh=T//OFr0mDkF3tjl7LVEO5CAeVXbcx9hS1UZdVnD6HbY=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=n6oBjBu2u5eB7+AzCKDXdsSysgW9ESFJCjw3WVuUNdCBHbWUXCdjX1Arojah/0BdF
 nKNBuUS5VOqDCgFOEZMV1yU9JkRhCsl8h9NawTLNDeE7w1I3bteaVKpduxkna8iFlB
 aeJ9dlodQK+ADM0SgQ99v0qvaFxHitbemJgWAIxq9ad3rnXru+dxFQR6lnciSr5D3e
 0mEs08OWS64wVltIxzrYvWEVU3TT6g++3+x27u+ef9Ru5OtEZ472Mdd9Xm50v8GzoC
 MNef426y7LLrakd0VPAH+efoP9eiJ0Enyl66yUIolFpGjhiUaOHbI1QiVkt99VNOS9
 RcrPOg2IoQLtg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 18:10:58 +0200
Message-Id: <DILXMZIF3NYC.2G7E0DEBJS90R@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DILWWIPKW00V.2W06IJU4ET4AX@garyguo.net>
In-Reply-To: <DILWWIPKW00V.2W06IJU4ET4AX@garyguo.net>
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

On Mon May 18, 2026 at 5:36 PM CEST, Gary Guo wrote:
>> +    fn probe<'bound>(
>> +        pdev: &'bound pci::Device<Core>,
>
> This is technically incorrect, as the `Device<Core>` only lives as long a=
s the
> callback. Having `'bound` would be incorrect.

I think that's more on the theoretical side, as Core is not Sync, but I agr=
ee it
makes sense to address.

> or perhaps by adding a lifetime to `Core<'_>`
>
>     pdev: &'bound pci::Device<Core<'_>>,

This seems reasonable.
