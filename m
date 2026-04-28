Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E282CFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D9710E9DD;
	Tue, 28 Apr 2026 13:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cTPK421+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD2810EBAF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:14:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB54F61335;
 Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30EC2BCAF;
 Tue, 28 Apr 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777382063;
 bh=fId8M51eLiEA5R+kZZRBfVGDoJPE40PDpQO/FvKYmkQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=cTPK421+E+jI8HRlmLTMG8MYzB5JhrIJ5tmsueJAozatUgbxEQ4wqkQqYzs7i+IHC
 w34izlUYoBbQgEcEMyKom24HUQY9fHdzABq2989Sxe6X/lwpUcZ326o3iFd/+tZOjW
 P7gPxvl6kmrE+CSeTCF46fjiuYeibf9V/NFKdpENecwovgqmVH28T4tUnKjDGl7dvY
 G/DaprRDa0T9Iirz4kmgWf4Zu7YJZ7cn4eCck005wN5sKyFUWS5YR7Dyrlm/Oe8wWw
 MmiOLjQmBZp4VkVPbHlaeXHOdW6ostFu7NUVoz47o7en03s+nCR5wMACMQYH5pBA8T
 PIToYoUajX8hQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:14:15 +0200
Message-Id: <DI4TCSCZ215E.16ZCXW7RSXBF@kernel.org>
Subject: Re: [PATCH 03/24] rust: devres: add ForLt support to Devres
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-4-dakr@kernel.org>
In-Reply-To: <20260427221155.2144848-4-dakr@kernel.org>
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

On Tue Apr 28, 2026 at 12:11 AM CEST, Danilo Krummrich wrote:
> Use ForLt::cast_ref() in Devres access methods, enabling lifetime
> shortening for types that are covariant over their lifetime parameter.
>
> This is a no-op for 'static types, but prepares Devres for use with
> lifetime-parameterized types such as pci::Bar<'_, SIZE>.
>
> Add DevresGuard as a wrapper around RevocableGuard that applies
> ForLt::cast_ref() on deref().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Please disregard this patch, it does nothing for this patch series.

It sneaked in from a subsequent series I work on which makes device resourc=
e
types, such as pci::Bar, ForLt!() types themselves.

One difficulty is that ForLt!(Bar<'_, SIZE>) fails when SIZE is a generic c=
onst
parameter, as it would require generic_const_exprs.
