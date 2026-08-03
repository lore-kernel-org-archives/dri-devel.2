Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C23C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D148C10E623;
	Mon,  3 Aug 2026 17:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fuFz+tmd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BA710E623
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:56:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7809243A0C;
 Mon,  3 Aug 2026 17:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE61F000E9;
 Mon,  3 Aug 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785779788;
 bh=Qvrs2oBboVMB507TatCgoFZaOC1I0y25AAlsZMSic58=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=fuFz+tmdn1gJS5SbwyUATSbpaBEq0otZ4K4VKTwmDHWnoxOwfCuemfOsEzo0u8YMj
 cP7X9rlSZJd5kezXZuUewSlPM0U7TIVTWyFp+vECqHmbTv4Nkg6QtrOLFfaWTMRU6I
 JQbefjoo+z8uRb/+uT6WpCFqGdiIdx9myxhVBm5cuU6+J8100nRlTRZU7uO4zQPriE
 kE42qw6IfsFzYgLIQRac2gjUzVOMy4l9gmPxkOTjm9bMz0ib33pOiV6eIdI6BuIDgT
 NdkW0EPvKeMD11BI4Akb+YfKhBoH2Mk7cn6Wt+Bqoja/4BevQSzlLBfcv8ggqw+BJj
 SDM+yzZAgWdng==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 19:56:21 +0200
Message-Id: <DKFI3M4IEPIS.1Q2UYQGFIC6EO@kernel.org>
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
Subject: Re: [PATCH v2 6/9] rust: drm: add DrmSeqShow seq_file adapter
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-6-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-6-aea19eccb996@linux.dev>
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
> Add DrmSeqShow trait and its SeqShow blanket impl for Device<T, Normal>,
> enabling Rust DRM drivers to expose device state via debugfs seq_file
> entries. Device registration data is kept alive for the duration of
> each seq_file read.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

This patch shouldn't be needed with the ScopeRef approach. The full proxy
already guarantees show() can't run after debugfs_remove_recursive(). So, t=
he
driver can just implement plain debugfs::SeqShow<RegistrationData<'_>>.
