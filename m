Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85133106ACDD
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD62A10E1CD;
	Thu, 12 Mar 2026 19:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AlsDiPyl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3B910EA95;
 Thu, 12 Mar 2026 19:16:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A2D444514;
 Thu, 12 Mar 2026 19:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0989C2BCB1;
 Thu, 12 Mar 2026 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773342977;
 bh=jlyx9l+qGp+RWiemW+VcSfXUDZgJ9xq/VQap7qzq8dQ=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=AlsDiPylrriqz02nX09F6Dsml7vaxeR0f7gbhVVvsEV/Zz+hLha9hIIfh3xiogl7f
 B2KJuPJjb5gvfwFCqVxhqkHzVTdKoUQfGun8vDVXYopcJlnuYZPTlW1V7mNoB/RS/4
 bPxlEk1dMNAbLYjrdMt+Um1UPAIsHa3xef/8lUcdO41JCyoxKfZY5jCKtZ80W/RvaL
 3eD6tbWfoyasy6ZN93LBr+lWBRZhvxtWQvZMe87ED0/9oeZT0RMiHu+GMFi+3hJ97A
 K2YervJTOJvLJM2Xnv58MBNKr0gzzWjEY9/ntYZbA6A2LMkFkRzFDgsMmW9wO5PMZy
 xa1t4ArO/0L8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 20:16:13 +0100
Message-Id: <DH11MBCZFQIJ.33U3GFVI1HFZF@kernel.org>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova: rename drivers to use kebab-case convention
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <jserv@ccns.ncku.edu.tw>
References: <20260310062443.2763230-1-yphbchou0911@gmail.com>
 <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
 <abMJsUpvcUrITCVi@eric-acer>
In-Reply-To: <abMJsUpvcUrITCVi@eric-acer>
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

On Thu Mar 12, 2026 at 7:45 PM CET, Cheng-Yang Chou wrote:
> Hi John,
>
> On Tue, Mar 10, 2026 at 06:34:51PM -0700, John Hubbard wrote:
>> On 3/9/26 11:24 PM, Cheng-Yang Chou wrote:
>> > -    name: c"nova",
>> > +    name: c"nova-drm",
>> >      desc: c"Nvidia Graphics",
>>=20
>> hmm, as long as we are fooling around with names here, I see that
>> this should be "NVIDIA Graphics and Compute", really.

SGTM.

>> >  kernel::module_auxiliary_driver! {
>> >      type: NovaDriver,
>> > -    name: "Nova",
>> > +    name: "nova-drm",
>>=20
>> Well, but now it is out of sync with the file name: nova.rs.
>>=20
>> You should change both, or neither, I'm thinking.
>
> I think renaming the file to nova_drm.rs would better reflect the
> driver's identity now that the module name is nova-drm, making it easier
> for readers to associate the source file with the driver.
>
> Would that work for you?

I think the module name should ideally match the directoy name, i.e. we hav=
e

	drivers/gpu/nova-core/

with the module name "nova-core" and

	drivers/gpu/drm/nova/

with the module name "nova-drm".

The reason why this is not .../nova-drm/ already is that I figured it would=
 be a
bit redundant given that "drm" is already part of the path.

While I don't mind changing this, I wonder what this would mean for the
Kconfig, CONFIG_DRM_NOVA_DRM? :)
