Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5905C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C53B10E630;
	Mon,  3 Aug 2026 15:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="McHnZ3pC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B532710E630
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:23:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5996F402EA;
 Mon,  3 Aug 2026 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854601F000E9;
 Mon,  3 Aug 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785770600;
 bh=dZYSC8erIMTeSh377JsLNybfBrVvBlw03e2MC63a0C8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=McHnZ3pCySk8fLXiiGo5wXe4OJjJWo58uagpdWKQDFTAx4nQ2d/r+SnOraAkdLDB2
 A1/6uqdxAYJe+ts8DdgzcmgBs1M6SsykUmM6TY8LA9NQ21G6N24VLiu09lnKjz4E8G
 yu54GeI9py8SIpx9PkYNtM1dStanHHKTqYhy1GVXlWRouNoq2RpzJOSu558rndcYwe
 JRJfuxQc+8ZpHXEc5lBNnUMabSud9oBVFOqsYcML9IQpUVvvf4lQuU97UokHm8cHxj
 az87oZgxYJkw2hWxktzPnQxPr353on+nyeckr/kGMTtP/IgE1sWlQkXGNgyttr0FvC
 0LmxW7b/V05Lg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 17:23:12 +0200
Message-Id: <DKFEUD1RMRZA.2ILHJ8I3TPLUR@kernel.org>
Subject: Re: [PATCH v2 2/9] rust: debugfs: add SeqShow trait and seq_file
 file operations
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
 <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
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
> +/// Renders `data` into a seq_file.
> +///
> +/// `data` is the value stashed as the debugfs file's `i_private` at cre=
ation
> +/// time. `show` is invoked on each read to produce the file's contents.
> +///
> +/// `open` and `release` are optional lifecycle hooks called during file=
 open
> +/// and release. They can be used to manage the lifetime of `data` (e.g.=
,
> +/// reference counting). Default implementations are no-ops.

The open() and release() callbacks shouldn't be needed. The existing C (pro=
xy
file ops) and Rust code already ensures to wait for in-flight file operatio=
ns,
so show() can't run after debugfs_remove().

Both the existing Rust debugfs code and the DRM code use the full proxy fop=
s.

> +pub trait SeqShow<T> {
> +    /// Writes debugfs output for the file.
> +    fn show(data: &T, m: &SeqFile) -> Result;
> +
> +    /// Called during file open, before `single_open`.
> +    fn open(_data: &T) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Called during file release, before `single_release`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `data` must point to valid memory, kept alive by actions taken i=
n
> +    /// [`Self::open`] (e.g., incrementing a reference count).
> +    unsafe fn release(_data: NonNull<T>) {}
> +}
