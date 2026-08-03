Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53073C55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A990B10E06F;
	Mon,  3 Aug 2026 17:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tnd60swh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98CB10E06F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:55:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1398141A6B;
 Mon,  3 Aug 2026 17:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1A51F00A3A;
 Mon,  3 Aug 2026 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785779758;
 bh=V183rzhhugBwg3vh8YfWq1iT/27aLeKbPvm0NIc25+Y=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=Tnd60swhIZLFBtpdJjnNdNWzlFvA6hx1Mhjogl5Ihx88RLTYYwPErXzNP7dWv5kFs
 IUlU2k7VJaditjVTRNBATsHcGM47qfd4feQ6UueXJj76fg6xY117xfqLBuozr97HoG
 aUO28JvN8jFbCAzNHB7DaP3tim0KpjZNWyhjZ31J2YRay08p7B+7Wuzoh+A7hdYJvW
 fjSy18CK4Jn9bANDkRmLHcRybw5dQflyWd+nUdO/dPtFprr9nFGbTKFAwN48kIKbZ6
 WjFGJ1lo0QYZ4t7lraKb7Cw7ZRfoDuI5+5ENzTmuxDDjwC2M/tKeXvtrcSZhNQhVjl
 W4SvcbWIRXDtQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 19:55:50 +0200
Message-Id: <DKFI383UHNXW.2X3OG31P5QAJZ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 5/9] rust: drm: add debugfs_init callback to Driver
 trait
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Melissa Wen"
 <mwen@igalia.com>, "Wambui Karuga" <wambui.karugax@gmail.com>, "Eric
 Anholt" <eric@anholt.net>, "Ben Gamari" <bgamari@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-5-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-5-aea19eccb996@linux.dev>
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

On Thu Jul 30, 2026 at 7:05 PM CEST, Alvin Sun wrote:
> +    /// Populates debugfs for this DRM device.
> +    ///
> +    /// Called by the DRM core during registration, once per minor (call=
back
> +    /// runs after `dev->registered`).
> +    fn debugfs_init<'a>(_dev: &'a drm::Device<Self, drm::Normal>, _dir: =
&ScopedDir<'a, 'static>)
> +    where
> +        Self: Sized,
> +    {
> +    }
>  }

This could just be

	fn debugfs_init(dir: &debugfs::ScopeRef<'_, Self::RegistrationData<'_>>)

as it is only needed to populate files / directories for exposing things in
RegistrationData.

Subsequent debugfs::Scopes can be registered from drm::File<'_>::open() and
IOCTLs (I also work on introducing HRT private data for IOCTLs; semanticall=
y
equivalent to a Vec in DriverFile<'_> or RegistrationData<'_>, but managed =
by
the subsystem).
