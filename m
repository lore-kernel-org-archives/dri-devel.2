Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE75CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960A410E3A2;
	Tue, 19 May 2026 12:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pXdkD0ON";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8945410E3A2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:36:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 39798416F8;
 Tue, 19 May 2026 12:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF43C2BCB3;
 Tue, 19 May 2026 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779194213;
 bh=nJYV/ap6zHLvQFCShv1/uTv1aMCcDLeKnHs+8n4ntjw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=pXdkD0ON+gTtqAfmHdV2+ZlJJdoHdFQI0lWKl2u+WYWQMoLn7gbY7EPrs2eSe3szw
 vH7vAu76tm5kEIjgDVABxnCGJvcXk+cVx4atcbY/dRM/247u+aecXZaa6Ey2m/Gieh
 P7bQjNQ6dC/7ynOZAhCNBPXQZ6WrIWJ1gj/JZbRN7ldklXmjrDeTvn2c+agudMk79N
 nuNRqoZPfbqjZtKbwa/pNSs/WGEuBxKzFkxN9GrEJIbK9pYHMFlYLNDncJMiOn8nQm
 jM7ds8QSjCecf0syRnMwaKhimwaXpklCU7tLUKZr2im5PUaSwqJHwobZwDenbDOHdE
 F95Qt0z7yLb5Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:36:44 +0200
Message-Id: <DIMNPI2H382T.2U2OH39B7C2B4@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
 <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
 <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>
In-Reply-To: <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>
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

On Tue May 19, 2026 at 1:48 PM CEST, Gary Guo wrote:
> the callback should have `Pin<&Self::Data<'bound>>` instead (the outer
> lifetime should be callback-scoped)`. Did you forget to make the change?

Yes, I thought I had that staged already, but forgot about it; good catch,
thanks!
