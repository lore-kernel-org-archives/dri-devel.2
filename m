Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A68E88D6D
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 00:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894E210F4C3;
	Sat,  4 Apr 2026 00:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NS7u+XgK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAB110F4C3
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 00:06:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 376844044C;
 Sat,  4 Apr 2026 00:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BBC4CEF7;
 Sat,  4 Apr 2026 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775261161;
 bh=jTInPCwhRuOQdrg+QrOCWa4rIxYaBSc3pV2W1y4XObw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=NS7u+XgKzbokQFQQWNw2O4AYIw60GyCMrEBtObJarUINcAlRMTnITO1dpjrbeTkz7
 5S/MwUlTEyjd6iMw5A/TVVnqF7riOJuE20DBl3n3R26PlwRpbHcWMk/SUt7PireBw5
 iheGMudtfGlrdaEOk2pfE5tvUbfiSc64pmC6zTbfEY+B+8qQBxHuY8vBEDhp42OIVZ
 Jqleo4V8J/7wct6pF6HATJO3UJ4E4SphlmZkp7Y7DHiCRrr9Vm3MkxKhGpoBVHSwCF
 Wk7YV5SyCdegjqh5eKxUrl+Hfk3UfMsSiS55xYbVWFyaZ3sEL5fzsGoKk7gaPXtJC3
 zWK2h1LLqogew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 02:05:56 +0200
Message-Id: <DHJXK4PAD7V0.3UYK35FDHRNIK@kernel.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
 <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
 <11466450-aeb3-48d3-a86f-934346fd4172@nvidia.com>
In-Reply-To: <11466450-aeb3-48d3-a86f-934346fd4172@nvidia.com>
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

On Sat Apr 4, 2026 at 1:47 AM CEST, John Hubbard wrote:
> On 4/1/26 7:29 AM, Alexandre Courbot wrote:
>> `driver_read_area` and `driver_write_area` are internal methods that
>> return slices containing the area of the command queue buffer that the
>> driver has exclusive read or write access, respectively.
>>=20
>> While their returned value is correct and safe to use, internally they
>> temporarily create a reference to the whole command-buffer slice,
>> including GSP-owned regions. These regions can change without notice,
>> and thus creating a slice to them, even if never accessed, is undefined
>> behavior.
>>=20
>> Fix this by rewriting these methods to use pointer projections in order
>> to create slices to valid regions only. It should eventually be replaced
>> by `IoView` and `IoSlice` once they land.
>>=20
>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue binding=
s and handling")
>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.or=
g/
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++---------=
-------
>>  1 file changed, 65 insertions(+), 49 deletions(-)
>
> This is causing a build_assert failure in the latest drm-rust-next, with
> rustc 1.85.0, and also with 1.78.0.
>
> rustc 1.93.0 does not show the problem.

Odd, it did pass all the testing at my end. Anyways, it only proves once ag=
ain
that this is pretty fragile.

> I suggest that we revert this commit: we're very late in the cycle and
> it appears to be relying on fragile compiler behavior (my best guess so
> far--I don't yet understand the root cause).

As an exception, as it made more sense in this case, I dropped it from the
queue.

Thanks,
Danilo
