Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CD3CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC7311241F;
	Wed,  3 Jun 2026 22:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l8RAAhUA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60F111241F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:24:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29C95600AE;
 Wed,  3 Jun 2026 22:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9702B1F00893;
 Wed,  3 Jun 2026 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780525468;
 bh=Kb7DLANZrh0uSUV/FMB6sG54v+634aEu5TRlzCENpd0=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=l8RAAhUAK6MntbWawBEqiUgzxL+NQCcWGP4ifYpEY2XSoR8rODZDsneb2mGXtk20Z
 3iVBxbWp0lZ4bO8ja+qsn2EwrmLu6hVKInu+VFcdjtiPZJ1ZyvlkrpDBQ55KwzZ4aN
 1P31DI2wLTDpbxc74LWIpGrXKA40uEj3G7S03XSmQCAmb/bvHDtf5qRiJ7p2pl7a/H
 7lDLu7LU+rIUfNASDz5uwDLWCxnpf8dnIwgp5GmedehLmNaBKk6GL+5sldrmfD28V2
 4CVsaRWXlr2LOfT1vVKQ6aZ4migElw3WnOPqxsf0Z/mX/ckKHO0CKEJtd9PwepC16u
 q3+jti5l0493A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 00:24:24 +0200
Message-Id: <DIZRLM5N81KS.DIRUHYO435XR@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org>
 <DIZE54GCJ9MS.DW75EP5OM604@garyguo.net>
In-Reply-To: <DIZE54GCJ9MS.DW75EP5OM604@garyguo.net>
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

On Wed Jun 3, 2026 at 1:51 PM CEST, Gary Guo wrote:
>> +    /// Safe variant of [`Registration::new_with_lt()`] for registratio=
n data that does not contain
>> +    /// borrowed references.
>> +    pub fn new<E>(
>
> This is currently unsound, as leaking the unbind guard also gives out
> `&Device<Bound>` in addition to the registration data.

For this to be unsound someone would need to be able to move the
drm::Registration into a context where its Drop runs independently of the d=
river
unbind, because otherwise leaking the UnbindGuard would also block driver u=
nbind
forever and the now unconstraint &Device<Bound> remains valid.

So, I assume you refer to the case where someone calls forget() on the
drm::Registration that was created without the promise not to do so, i.e. n=
ew().

> I think we should just remove the not pass `&Device<Bound>` to ioctl call=
backs.
> Giving back registration data is sufficient; if a device driver needs
> `&Device<Bound>` it can just store a reference in its registration data; =
more
> commonly I suspect it will just store whatever device resource is needed =
and
> doesn't need `&Device<Bound>` (with the introduction of lifetime, we have=
 much
> fewer cases that we actually need `&Device<Bound>` and cannot be replaced=
 with a
> direct reference to the device resource).
>
> Not passing this bound device allows us to make this safe, and also remov=
e the
> need of patch 1 and patch 5.

I follow your reasoning, but not passing T::ParentDevice<Bound> in the ioct=
l
makes Registration::new() rather pointless on its own; given that it takes
T: 'static you can't store &'a T::ParentDevice<Bound> in the first place.
