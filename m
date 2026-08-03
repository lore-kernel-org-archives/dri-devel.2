Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EB0C55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6252A10E05C;
	Mon,  3 Aug 2026 17:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TvMpFpXq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F11D10E05C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:55:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E48060AB4;
 Mon,  3 Aug 2026 17:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217431F000E9;
 Mon,  3 Aug 2026 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785779734;
 bh=Bs9omKOuO/YbXE1jcD+DjtVKx7Ixyy7wG2xDQE2HuCI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=TvMpFpXqLHpBFbqCfHpCuPpW7//aKSt/yP1os62tazvapJGbejD5FDsuT/kGCSG0K
 JQ/9KQp2MuNFEGO5a0TLrdQtt1ZvC+dsdjD8Ic6tCC+lj09MTUZz7bs7fW0PJKs09y
 cJscjkI7kXiBgKFhZcryiwi46dXyEOyIqQsH8TeEJlGwtMsABXTMpxTCRRQdRQICYD
 iEm78BOKdv/MbxNiHgQrvuZSOLvSIvvo67aCPa5z7P/l0iQ9X6LA82JXS9wm8scpV2
 RMTdxeBjXJvRN6vO/X9YPvJ+bt+6ko5GUNwevnNndDsFGqmux4WL5Do6iS8Oxrg7ky
 lDprm0PF7g/bw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 19:55:27 +0200
Message-Id: <DKFI2XHD62AU.TP8WZCRG5EIW@kernel.org>
Subject: Re: [PATCH v2 3/9] rust: debugfs: add Entry::from_raw and
 ScopedDir::from_dentry
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-3-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-3-aea19eccb996@linux.dev>
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
> +    /// Creates a [`ScopedDir`] wrapping an existing debugfs dentry.
> +    ///
> +    /// Files created under this directory are not automatically removed=
 on drop;
> +    /// their lifetime is tied to the dentry owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure the dentry remains valid for the lifetime=
 of the
> +    /// returned `ScopedDir`.
> +    pub unsafe fn from_dentry(dentry: *mut bindings::dentry) -> Self {
> +        let _ =3D dentry;
> +        ScopedDir {
> +            #[cfg(CONFIG_DEBUG_FS)]
> +            // SAFETY: The caller guarantees the dentry is valid and out=
lives this `ScopedDir`.
> +            entry: ManuallyDrop::new(unsafe { Entry::from_raw(dentry) })=
,
> +            _phantom: PhantomData,
> +        }
> +    }

I think what you actually want to express is that the DRM debugfs root dir
represents a view into an existing scope, where the data is T::Registration=
Data.

Additionally, we want to be able to derive new debugfs::Scopes from this th=
at
are shorter lived, so we can create new debugfs::Scopes e.g. in
drm::DriverFile<'a>, which I currently work on.

So, what I'm thinking of is a type like:

	pub struct ScopeRef<'a, T> {
	    #[cfg(CONFIG_DEBUG_FS)]
	    dentry: Option<NonNull<bindings::dentry>>,
	    data: &'a T,
	}

which has a corresponding unsafe constructor and provides methods to e.g. c=
reate
a new directory, returning a new ScopeRef<'a, T>, which can be stored in
lifetime scoped data.

Additionally, but that's somewhat orthogonal, we want debugfs::Scope to sup=
port
lifetime data, so a scope can participate in the driver lifecycle; the
corresponding synchronization is already in place with full proxy fops.
