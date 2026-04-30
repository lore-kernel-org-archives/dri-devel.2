Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED041CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC4410E44A;
	Thu, 30 Apr 2026 16:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uo2y+bxO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A4410E44A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 16:05:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 232E34417F;
 Thu, 30 Apr 2026 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A581C2BCB3;
 Thu, 30 Apr 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777565131;
 bh=I0Hn6+UL9P7mFG6XXZHpwThds4PDPN5q1vkLTTgDkVY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=Uo2y+bxOm2Qn6x7k7/chYmmzqsW9W6qHCbQ1MN9Zdszme+dDUXno2NwyOPefdHpw6
 JsjqyeyiGiWlYyfLzxbhw0TzlFoJemCKGhTpGTiDJuL/LbXKWuNO3YoB1HNdVsNXLg
 0X3b4i8q4Nw0BezQwnW03Dzo3c7p5vd4M4DbJcUCqL08OTgJqp+1JbmVQpWHXdzMm8
 qGE3aJzF4P0VYW1ZoY+C5QEtYIryBYbMJoFQs1mvanhHP/KPyUSYa5a5RWLxAlz7UW
 BGojLiwL5AuNx5ZftMW4Dz1GqwRsbJkX1ePVmfqmKp+mM3UdPes2RqZvlflkfLXcsX
 Ok7r7m1b1HcYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 18:05:26 +0200
Message-Id: <DI6M8XMJUG33.2NYL9UVC0LLRM@kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
 <DI6L13A5LMOW.DU7ZTHXZYB0K@garyguo.net>
In-Reply-To: <DI6L13A5LMOW.DU7ZTHXZYB0K@garyguo.net>
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

On Thu Apr 30, 2026 at 5:08 PM CEST, Gary Guo wrote:
> I wonder if we could require auxillary drivers to specify a type, and the=
n the
> abstraction would check if the type matches; if it matches, it create a
> `&Device<Core, T>` and `probe`, otherwise it skips over the driver comple=
tely.

The choice not to type auxiliary::Device over the registration data is
intentional.

The registration data is not intended for the child driver to use, but for =
the
parent driver to retrieve when the child passes its device back to the pare=
nt.

By typing the Device over the parent's registration data we force the paren=
t
driver to expose its registration data to the child driver.

>> +    /// Returns a pinned reference to the registration data set by the =
registering (parent) driver.
>> +    ///
>> +    /// Returns [`EINVAL`] if `T` does not match the type used by the p=
arent driver when calling
>> +    /// [`Registration::new()`].
>> +    ///
>> +    /// Returns [`ENOENT`] if no registration data has been set, e.g. w=
hen the device was
>> +    /// registered by a C driver.
>> +    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
>
> Any reason that this is not just `Result<&T>`?

Mainly consistency with other APIs, but I'm not really opinionated about it=
.
