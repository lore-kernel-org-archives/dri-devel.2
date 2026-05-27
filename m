Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C67CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 17:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D9C10E808;
	Wed, 27 May 2026 17:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SIp9istw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D332110E808
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:18:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77CFD44268;
 Wed, 27 May 2026 17:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D221F000E9;
 Wed, 27 May 2026 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779902310;
 bh=OaYEVa01C1fbNgO8Mv5tGt8BTdhgdWVcSikLut0VmS8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SIp9istw/5p+c+Le+xoL8j20HDFX4V4aqhBpKMprcc5cY+etxRqsaG1uegeHpuEQj
 4ciC7G3QrzVZBqYT6tevwO2hOUYuJdFph3e3p7VcLfj0eCQJDf9uo35nBTDgngqAPh
 ILQeZfo8/f5t/j2qc4G9hjlG00bMOmlxlDzH4p6qxqu95N7tBCIxEFCtrNj8Sg5pVc
 T9gS3I9mW/0ZNxo+dhb69cTPs8IewviJ8x70fLVEZpjasNOBZNumu6EU4Nx/V2WL+N
 u9LHp2gx/0FBa5vaNVwQbdHD80B3e4jcJkOnji2xCLWTeLzm8RUXrkJerxYvvxlCZq
 FCHESrk9Sr8Qg==
Date: Wed, 27 May 2026 10:18:23 -0700
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
Message-ID: <20260527171823.GA1893026@ax162>
References: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
 <20260527-nova-exports-v2-1-06de4c556d55@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-nova-exports-v2-1-06de4c556d55@nvidia.com>
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

On Wed, May 27, 2026 at 08:52:17PM +0900, Alexandre Courbot wrote:
> buf_printf() uses a fixed-size stack buffer. vsnprintf() returns the
> number of bytes that *would* have been written to that buffer, which can
> be larger than the size of said buffer if the formatted string is too
> long.
> 
> The problem is that whenever this happens buf_printf() currently passes
> this length, unchecked, to buf_write(), which silently reads past the
> stack buffer and copies invalid data into the output buffer.
> 
> Fix this by detecting vsnprintf() failures and truncations before
> appending to the output buffer, and report a fatal error instead of
> producing corrupt symbol names.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/mod/modpost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index abbcd3fc1394..0d2f1f09019b 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1689,8 +1689,17 @@ void __attribute__((format(printf, 2, 3))) buf_printf(struct buffer *buf,
>  
>  	va_start(ap, fmt);
>  	len = vsnprintf(tmp, SZ, fmt, ap);
> -	buf_write(buf, tmp, len);
>  	va_end(ap);
> +
> +	if (len < 0) {
> +		perror("vsnprintf failed");
> +		exit(1);
> +	}
> +	if (len >= SZ)
> +		fatal("buf_printf output truncated for string %s: %d bytes needed, %d available\n",
> +		      tmp, len + 1, SZ);
> +
> +	buf_write(buf, tmp, len);
>  }
>  
>  void buf_write(struct buffer *buf, const char *s, int len)
> 
> -- 
> 2.54.0
> 

-- 
Cheers,
Nathan
