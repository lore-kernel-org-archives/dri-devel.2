Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA38FCD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 21:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D56A10E140;
	Sun, 10 May 2026 21:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X6CActwF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEC610E140
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 21:39:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7538C4192B;
 Sun, 10 May 2026 21:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B477DC2BCB8;
 Sun, 10 May 2026 21:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778449193;
 bh=ivkV5xnwxUbw7dEEK4h8FHKMAW8JZ/SVIXnsE04kiFg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=X6CActwFWhZQQB7j52NkscIqvVWA52kx+SKHaT/RFXi5vQHULWcsgGQgtx3UmwdpQ
 6dhlivWfVvYAzF1tO0yguda2aRj1PyB/IYFHoyxjW383bAk/5lwL03HIAKf98NvSAF
 j1Jt6mh1QuLVpuA1sO8jx2LhxpW8qztLemhn0Q98yB18jCMMjY0875eMMUBpbp7YOL
 gNh5+vFA2LlmDxh7hUgYlfVPWekLqbRmaHVvnU2An7mUt9b44+p8uAJHYiTkY1orxX
 1lRTJQVW9Af1rSbqHWnghSOc6IzPDjkTqeR2csdBMCmlTM2CCVqYhQOBuxkSDv20n0
 n0h6spSBgDxHg==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 May 2026 23:39:48 +0200
Message-Id: <DIFBME3GXDC0.14UHJTPD6TTAE@kernel.org>
Subject: Re: [PATCH v2 2/3] rust: auxiliary: add registration data to
 auxiliary devices
Cc: "Alice Ryhl" <aliceryhl@google.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-3-dakr@kernel.org> <afs3Mz8J9oOeqF34@google.com>
 <DIBMXPC3ZKIA.1UQORYD223AY6@garyguo.net>
In-Reply-To: <DIBMXPC3ZKIA.1UQORYD223AY6@garyguo.net>
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

On Wed May 6, 2026 at 3:41 PM CEST, Gary Guo wrote:
> On Wed May 6, 2026 at 1:42 PM BST, Alice Ryhl wrote:
>> On Tue, May 05, 2026 at 05:23:08PM +0200, Danilo Krummrich wrote:
>>> Add a registration_data pointer to struct auxiliary_device, allowing th=
e
>>> registering (parent) driver to attach private data to the device at
>>> registration time and retrieve it later when called back by the
>>> auxiliary (child) driver.
>>>=20
>>> By tying the data to the device's registration, Rust drivers can bind
>>> the lifetime of device resources to it, since the auxiliary bus
>>> guarantees that the parent driver remains bound while the auxiliary
>>> device is bound.
>>>=20
>>> On the Rust side, Registration<T> takes ownership of the data via
>>> ForeignOwnable. A TypeId is stored alongside the data for runtime type
>>> checking, making Device::registration_data<T>() a safe method.
>>>=20
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> The change itself LGTM.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

>> But I'm not entirely convinced that this is the most convenient
>> user-interface. I'm wondering if the auxiliary driver trait could
>> specify which type the parent driver data is using in an associated
>> type, and whether you could eliminate the check and error path that way.
>> But then again, AuxiliaryDriver does not appear as a generic parameter
>> in auxiliary::Driver, so it might not work.
>
> I think that's similar to what I'm suggesting in
> https://lore.kernel.org/rust-for-linux/DI6L13A5LMOW.DU7ZTHXZYB0K@garyguo.=
net/.
>
> This does still require the type ID to exist and that probe of auxiliary =
drivers
> need to fail if type ID mismatches during probing.

Technically, this would be an additional driver match criteria, i.e. the na=
me
string in struct auxiliary_device_id *and* the asserted type of the parent'=
s
registration data must match.

Given that drivers can match against multiple entries in the auxiliary_devi=
ce_id
table, we must consider that they can have different registration data type=
s
(depending on the specific parent driver that exposed the auxiliary device)=
.

Thus, I don't think we can solve this without a runtime dispatch (over all =
types
that would need to be listed in the ID table) anyway; and having this dispa=
tch
in the child driver - essentially leaking an implementation detail of each =
of
the parents into the child - does not seem to add any value; quite the oppo=
site
unfortunately.

(OOC, I hacked up the statically typed version -- I think it turns out OK,
despite the fact that it still leaks the parent's registration private data=
 type
to the child, which I dislike, plus a few hiccups with the generic device
context infrastructure. But as mentioned, I don't think that's an option in=
 the
first place.)
