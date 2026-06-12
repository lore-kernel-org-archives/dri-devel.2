Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15648CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E38210EB6B;
	Fri, 12 Jun 2026 20:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GdpxwRGB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FF510F5D8;
 Fri, 12 Jun 2026 20:17:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9F2B41665;
 Fri, 12 Jun 2026 20:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2371F000E9;
 Fri, 12 Jun 2026 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781295456;
 bh=pJzuNVWTNf+53sy5yuKPcqhP0sKI2LYYj8cvjNu/tSM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=GdpxwRGBrf+qpXAR4d0Nz/svA8GnlSNp4xm1JkRSb71qW3Vv6kndMHbj1bAUWD/NM
 clLsSWhWXgMw0G4JPYmRM1CVs9R4G39GEuZpZ8fhyLOmcvFBNi/AdHdY76Jjw9J8le
 HVVbR0yVWHjAT7t0VQT1yh5x+i4wH10aW4joDeSLt0a5oqmAlMnSdwwk6OBm4FMmF7
 ap9Q4T0B+POpHfHaBJVwAdSxLuXzvSiaMfoJvQP2RVNluhx8jpaR13jfqs3ewInCWY
 7PYGYcg87etPCjusox7PGggnG6MQ9ng+hjaQeZQ3PMA9sVyoKm3sDk98mVHBeK8PkO
 AN9JkZRDDvjNg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 22:17:30 +0200
Message-Id: <DJ7CJCZRHT1R.3LZDILZ7HTXQ3@kernel.org>
Subject: Re: [PATCH v20 3/4] rust: faux: Allow retrieving a bound Device
Cc: "Lyude Paul" <lyude@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <driver-core@lists.linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Simona Vetter" <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Benno Lossin" <lossin@kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Asahi Lina"
 <lina+kernel@asahilina.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-4-lyude@redhat.com>
 <DJ7AXOH0W92V.1L1869KO4C1H9@garyguo.net>
In-Reply-To: <DJ7AXOH0W92V.1L1869KO4C1H9@garyguo.net>
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

On Fri Jun 12, 2026 at 9:02 PM CEST, Gary Guo wrote:
>> +impl AsRef<device::Device<device::Bound>> for Registration {
>> +    fn as_ref(&self) -> &device::Device<device::Bound> {
>> +        // SAFETY:
>> +        // - The underlying `device` in `faux_device` is guaranteed by =
the C API to be a valid
>> +        //   initialized `device`.
>> +        // - faux_match() always returns 1, and probe runs synchronousl=
y (PROBE_FORCE_SYNCHRONOUS).
>
> Please quote all code with backticks.

As far as I'm concerned there's no need to do that for things that are not
rendered anyway. But also feel free to do it anyway of course.

Thanks,
Danilo
