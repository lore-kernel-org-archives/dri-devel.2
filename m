Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7B5CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A669610EC38;
	Tue, 19 May 2026 10:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H31fv2H7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E64A10EC37
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 856D560221;
 Tue, 19 May 2026 10:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CCBC2BCF6;
 Tue, 19 May 2026 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779187184;
 bh=8d9cpV7MYabXiaU/WPwazqmKL15k0EHx4/GtitV+QU4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=H31fv2H7Ias22CXBpSvo+ewqfFwVMzz7gnADIyQKS0WjPxHcwn4Y9f9IWghXxGQ4T
 g6ZtDZP354KXG6/9XPA6DNIoE7MMlbcM3bJx/engJFqqD9O+UmIpCtsJB98sPRmG5N
 3IDAD+V+Br5uYM7gEN/epmZwIc8Hxlr2/8BFjiBcWZlPwo60Fp8Llby2uAhwfiFLhe
 HPhGYBNxwEie/cw527WdH4byKYHRyYRU3ecjDFFHjiy0EA41H/4DV08fYrhEKGzaep
 jXlsz/Fyufsk/Gi92Fd56mtpb+/KWaK3t4HuQByRxJ2Tu9oRZ9i+SwJxpbqQddZnq/
 lAojQ4HSxpc7g==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:39:36 +0200
Message-Id: <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
In-Reply-To: <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
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

On Tue May 19, 2026 at 6:52 AM CEST, Eliot Courtney wrote:
> Is this really sound without a covariance proof? For example, with this
> version you could stash a Cell<Option<&'bound pci::Device<Bound>> (even
> with Gary's suggested Core<'_> change) and then observe that reference
> on Drop of Data, which seems unsound to me.

The Core<'_> change seems unrelated, Core is not Sync, so you can't store i=
t in
the first place.

Otherwise, I don't see how one can exploit this. The formal invariance of
Cell<Option<&'bound pci::Device<Bound>> is not practically exploitable beca=
use
the framework controls what lifetimes are available and everything reachabl=
e
through 'bound outlives the data; something that is shorter lived than 'bou=
nd
can't be stored either.

Bringing back ForLt for this reason seems undesirable, as it has a real des=
ign
cost.
