Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A41DC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D195810F328;
	Wed,  2 Sep 2026 19:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FukJXx7d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F7310F328
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:30:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4011C600C8;
 Wed,  2 Sep 2026 19:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883721F000E9;
 Wed,  2 Sep 2026 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788377445;
 bh=pNGlzmw8zAImIDBEXnKUJlbc5s2v2mcl15GfhX5nDI8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=FukJXx7dyLKDrk34O5Ee6DNxm15IyEvxJaMw0ZN5j/VV6SG4RrzYsTne/N9kL5MiW
 ko5EcIOw8wsApIyHIrsLlZJKRvre9XoTt6t7IwiYTqatgQ8+eXgGftJIxBY/PgqCG1
 DpJdTspUPw9ibBrNhCr/mBgW8IaD4OZnf1OSBCaJKK1Hp+IOAWETBCIGZSbAeJ7GCz
 NWxPD2kuDF5LWeA/I9aQJ5zpSVpf+BkhUCBKJBwClb+/L+Mubtsdc199Jcw6JDeSgd
 AA/IHvPcfFJDd5grBxULdk6AcVbWh7wgPqJTBE6/tZwYXF5v4COUWlJArStfruF5wR
 2xQsJduZqqcsA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 21:30:41 +0200
Message-Id: <DL52W6KOLJIQ.1JCEW8T6036A8@kernel.org>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org> <apfHOxl6uB8xQHBq@nvdebian.thelocal>
In-Reply-To: <apfHOxl6uB8xQHBq@nvdebian.thelocal>
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

On Wed Sep 2, 2026 at 8:57 AM CEST, Alistair Popple wrote:
> Not being a Rust variance ninja it took me a while to figure this out :) =
But now
> that I have I agree the projections for 'static at least are quite nice a=
nd I
> think Gary's suggestion helps a bit as well for non-static. So assuming y=
ou're
> ok with me adding this code with your Co-developed-by or other appropriat=
e tag
> then I will incorporate this idea into v6 so everything keeps working if/=
when
> Covariance no longer holds for Gpu.

Sure, I'd suggest to base it off of this diff [1].

Thanks,
Danilo

[1] https://lore.kernel.org/nova-gpu/DL3WPTVM033J.33RWYCZOC67Z1@kernel.org/
