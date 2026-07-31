Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89AEC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2A910F17C;
	Fri, 31 Jul 2026 06:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YwVsiwOn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A4B10F17C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:57:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CE15600BB;
 Fri, 31 Jul 2026 06:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363AF1F000E9;
 Fri, 31 Jul 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785481047;
 bh=r7y8VIynFCQHZDQCckL6hl6AfuEFGx1T8F3uIT1Oe74=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YwVsiwOnsvhGApnpL8F7/m32g24kkCSvv3TJzuMoFnAM4OAmxlYGJB3JIc+1+IEfj
 XKxWUZL9/oE19g9GxwR2r2XLx5GI1UW/t24gvn3d1jjjaD/izpuzatoXGj5JTndkAL
 ESUEQ2RPBh1om2SsQuJRRDGReoFnlp/EyPABjhCY=
Date: Fri, 31 Jul 2026 08:57:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, lkft-triage@lists.linaro.org,
 patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com,
 rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Joel Fernandes <joelagnelf@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
Message-ID: <2026073106-ajar-mantis-9f4e@gregkh>
References: <20260730141445.110192266@linuxfoundation.org>
 <20260730181717.95457-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730181717.95457-1-ojeda@kernel.org>
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

On Thu, Jul 30, 2026 at 08:17:17PM +0200, Miguel Ojeda wrote:
> On Thu, 30 Jul 2026 16:05:30 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.18.42 release.
> > There are 675 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 01 Aug 2026 14:13:45 +0000.
> > Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64 and arm32:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I detected in the middle of the build lines like:
> 
>     find: 'lib': No such file or directory
> 
> It looks like we need:
> 
>     ee8bfb15d02d ("drm: drop lib from header search path.")
> 
> to go together with the one that was backported:
> 
>     5e7b3c10420e ("gpu: Move DRM buddy allocator one level up (part two)")
> 
> Having said that, there is something going on a bit confusing: commits
> "part one" (4a9671a03f2b) and "part two" (ba110db8e1bc) in mainline seem
> to have been merged into just the "part two" above in this -rc. Is that
> intentional? I am asking because the original removal of the `lib`
> folder happened in "part one" in mainline, so I was expecting to have to
> point to that one above, but it doesn't exist on its own.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org

Odd, looks like Sasha did it in one backport instead of two, perhaps
because we wanted a real patch and not a "move" patch?

Anyway, I'll go take the fixup change now too, thanks!

greg k-h
