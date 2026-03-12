Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF63B106ACDD
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CE010E1D1;
	Thu, 12 Mar 2026 19:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DaInQI0w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2FB10EAAA;
 Thu, 12 Mar 2026 19:48:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E52860054;
 Thu, 12 Mar 2026 19:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC371C4CEF7;
 Thu, 12 Mar 2026 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773344894;
 bh=W4Jp6yZmE/mcvnxtVjIKwwqHA5bULQpY4kKR1xyLVEA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=DaInQI0w8THjKsyVNUtCrsFKt9B8SnzhAhcnxEQd74zVnWaEKzqaQlqtm5PIOqQ8x
 35p/ZeEduH6tCiaGeWT7HN3g5atUUkye8UMRusIzhCZwpbverPxQAIxesoFXRHpprI
 VKWCAQktLywIbThs4tVOMOruTssHNEgx1k97Z/40qpHJ8U+y3+m5EZt63NhemfsddD
 +vYF76/5EdHtTG9mn6F9OHUmH7mKlyo691x5SrUjDre1XdhRfvtAcBvLGGF2dU75OH
 KZO1bHdpqutDijBfPEgQNnqD8LodGPVas23HmQu8Yl2pxaIzldm8dEQ6DNOW13DduA
 u7TEnK25KwopQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 20:48:11 +0100
Message-Id: <DH12ASFNVZD0.3986IKB8HOVIK@kernel.org>
Subject: Re: [PATCH] gpu: nova: rename drivers to use kebab-case convention
Cc: "Cheng-Yang Chou" <yphbchou0911@gmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <jserv@ccns.ncku.edu.tw>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260310062443.2763230-1-yphbchou0911@gmail.com>
 <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
 <abMJsUpvcUrITCVi@eric-acer> <DH11MBCZFQIJ.33U3GFVI1HFZF@kernel.org>
 <f1398086-ff75-42c8-ad43-97077dd22267@nvidia.com>
In-Reply-To: <f1398086-ff75-42c8-ad43-97077dd22267@nvidia.com>
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

On Thu Mar 12, 2026 at 8:21 PM CET, John Hubbard wrote:
> On 3/12/26 12:16 PM, Danilo Krummrich wrote:
>> On Thu Mar 12, 2026 at 7:45 PM CET, Cheng-Yang Chou wrote:
> ...
>>> Would that work for you?
>>=20
>> I think the module name should ideally match the directoy name, i.e. we =
have
>>=20
>> 	drivers/gpu/nova-core/
>>=20
>> with the module name "nova-core" and
>>=20
>> 	drivers/gpu/drm/nova/
>>=20
>> with the module name "nova-drm".
>
> When p
>
> When people do things like lsmod(1), they don't see the directory
> path for the module source code, so if the name doesn't include
> drm, then no one knows that "nova" implies "nova-drm".
>
> On the other hand, I was OK with just explaining to people that "nova"
> is the upper layer kernel module, and that it's the one that does
> DRM things.
>
> Which is why I'm merely "OK" with the name change, as opposed to
> thinking that it's required.

Just to clarify, I think we should change the directory name and the module=
 name
to nova-drm; the above is what we'd get with the current patch.

>>=20
>> The reason why this is not .../nova-drm/ already is that I figured it wo=
uld be a
>> bit redundant given that "drm" is already part of the path.
>>=20
>> While I don't mind changing this, I wonder what this would mean for the
>> Kconfig, CONFIG_DRM_NOVA_DRM? :)
>
> I also worry that we might not have enough DRM's in that
> CONFIG item. haha :)
