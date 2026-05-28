Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27217CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3188610E6AD;
	Thu, 28 May 2026 20:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AA9ndMU3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8F310E6AD
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 20:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFC87601F9;
 Thu, 28 May 2026 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0B71F00A3A;
 Thu, 28 May 2026 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780000658;
 bh=lBQFmlJkIY03bGn3z7m6Bp8+38mA0GSOezm112+0BWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AA9ndMU3ravjprEKcEuxXpb2rM9dh0TPDOq5o6abHGngUaOgI3PGtGja0PzvhnLLi
 DoeiD7VLDPtsJcZhZERpKVOcH+DpO+lawiMFJkb9tKi+V4kosh8MgCJQX7npaDRd2L
 kz3LL1tsEHt77w2DJDrUwkS+40ywFrR5x5YgjP1HbqBzVTCNVMdNZfVuGfzJ2ipSoJ
 JQ4P5CYRqXc+JvVn6WDL9bR2kTUoT9Fp79HYNRTQpmrdIXWQ47WZ7b83SU+glRpA36
 76eZJtMlPZ6/qGEzN2uR3D9pTLc5bSGDUhN8bUrLpFbhSC/L2NJkmSDyDzyyQ2VtzY
 cf+7nWhmgczog==
Date: Thu, 28 May 2026 13:37:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/7] scripts: modpost: detect and report truncated
 buf_printf() output
Message-ID: <20260528203731.GB3100532@ax162>
References: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
 <20260527-nova-exports-v2-1-06de4c556d55@nvidia.com>
 <20260527171823.GA1893026@ax162>
 <DIUCC1RFFE10.1LJ15YI8ZHPOH@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIUCC1RFFE10.1LJ15YI8ZHPOH@nvidia.com>
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

On Thu, May 28, 2026 at 10:23:18PM +0900, Alexandre Courbot wrote:
> Hi Nathan,
> 
> On Thu May 28, 2026 at 2:18 AM JST, Nathan Chancellor wrote:
> > On Wed, May 27, 2026 at 08:52:17PM +0900, Alexandre Courbot wrote:
> >> buf_printf() uses a fixed-size stack buffer. vsnprintf() returns the
> >> number of bytes that *would* have been written to that buffer, which can
> >> be larger than the size of said buffer if the formatted string is too
> >> long.
> >> 
> >> The problem is that whenever this happens buf_printf() currently passes
> >> this length, unchecked, to buf_write(), which silently reads past the
> >> stack buffer and copies invalid data into the output buffer.
> >> 
> >> Fix this by detecting vsnprintf() failures and truncations before
> >> appending to the output buffer, and report a fatal error instead of
> >> producing corrupt symbol names.
> >> 
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >
> > Acked-by: Nathan Chancellor <nathan@kernel.org>
> 
> If that works for you, can you take this patch through the build tree?
> I've included it in this series because it detects the issue that the
> series fixes, but it is not a dependency for the next patches. I just
> wanted to include it for context.

Sure, I can pick this one up through the Kbuild tree.

-- 
Cheers,
Nathan
