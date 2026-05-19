Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04364CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC3510EC36;
	Tue, 19 May 2026 10:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WlzyzTrf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364A910EC34
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E26D6021E;
 Tue, 19 May 2026 10:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C81C2BCB3;
 Tue, 19 May 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779187164;
 bh=5J8hmX1CCU0iLcpPMu5NtOM8FHJanErUGlCyNObqAGo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=WlzyzTrfiapXBcLy/6izyhFaE+Ulg7HRdIMadQ7hTDarGnJnez4IPmK3n3+FbUfEX
 0qCGQS2eEE4Uzmqq4tltIvQLCfObxCmFIn2R8idpC/VvAmw8bf751KtnrYk3y8e8xf
 puwIBSuda04tXtpDp/1k37aHCAp2Nezb0a0TdrIBn7WZ5bvhQnCm4wqetagni4o5yt
 1LOWieJIVCn7g+Z7zBAuUjUpGvPSWZG5bpdIqJ3vDjWMLIvurI31NerM+pInCA2fkv
 QxFzIaYcjvwpYJciL5pSSZlE28Pj5ZYUy4pZHmD0G4HKc4n2nmQnk+kBO1/7a1g4hf
 j2eAV1vQ7jG+A==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:39:15 +0200
Message-Id: <DIML7JNOV84D.1CK4G9MBZQJ3T@kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
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
 <20260517000149.3226762-18-dakr@kernel.org>
 <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
In-Reply-To: <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
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

On Tue May 19, 2026 at 9:56 AM CEST, Eliot Courtney wrote:
> For example, in the next patch on the sample aux driver you can do:
>
> ```
> let data =3D adev.registration_data::<ForLt!(for<'a> Data<'static>)>()?;
> let pdev: &'static pci::Device<Bound> =3D data.parent;
> ```
>
> and mint a 'static reference to a bound device, which seems unsound to
> me.

Good catch, I applied the fix.

Additionally, we could probably reject unused lifetime binders in the ForLt=
!()
macro, which doesn't help when used with a type alias, but may be a good
defensive measure anyway.

> What about requiring all device ids declared to be supported by an aux
> bus driver to have the same rust registration data type?

Please see [1] and [2].

Thanks,
Danilo

[1] https://lore.kernel.org/driver-core/DIFBME3GXDC0.14UHJTPD6TTAE@kernel.o=
rg/
[2] https://lore.kernel.org/driver-core/DIFXM2N21Q5J.2RIYLU11C5FR6@kernel.o=
rg/
