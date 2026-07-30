Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402FCC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597D310E1D8;
	Thu, 30 Jul 2026 18:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fuXCm1mL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBFB10E1D8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:17:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE28343853;
 Thu, 30 Jul 2026 18:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F6F1F000E9;
 Thu, 30 Jul 2026 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785435464;
 bh=6R6dAzebd0lU5AFh1vm8XcRfXETiBlUdRxOXlhLQ9dU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fuXCm1mLoqc5U3HXHSVUiHIjwDassHB8iSnSwNq4WhbmdXls3Z/2rBcJQQryry0MQ
 d0/5PoQ4wY1kXlywpxQCvpsKPiMhJPYwXdKaTtnn4ZkrDnUy/qUhdtciMN4bkCWUB2
 UxyJhIaQl4tedm4dCpOaRXe2lNKkO7HwUeOlA7P4jjJE59v1utLBeKnNEzjeVX6J9J
 rddw/X8gRdnv87M//z/5Vi15Mrs9YHzBlWvHxQG70tqI5fSchBSokpp/u0pHWO2vM2
 VzXYjm0e9qd9kJ3V7eR3+yo5W1sbmCjfCPjDRm1umjoiaj1J5PuVngngXMpH3w1+dj
 Pg9O90dBhysgg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
Date: Thu, 30 Jul 2026 20:17:17 +0200
Message-ID: <20260730181717.95457-1-ojeda@kernel.org>
In-Reply-To: <20260730141445.110192266@linuxfoundation.org>
References: <20260730141445.110192266@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 30 Jul 2026 16:05:30 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.42 release.
> There are 675 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2026 14:13:45 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64 and arm32:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

I detected in the middle of the build lines like:

    find: 'lib': No such file or directory

It looks like we need:

    ee8bfb15d02d ("drm: drop lib from header search path.")

to go together with the one that was backported:

    5e7b3c10420e ("gpu: Move DRM buddy allocator one level up (part two)")

Having said that, there is something going on a bit confusing: commits
"part one" (4a9671a03f2b) and "part two" (ba110db8e1bc) in mainline seem
to have been merged into just the "part two" above in this -rc. Is that
intentional? I am asking because the original removal of the `lib`
folder happened in "part one" in mainline, so I was expecting to have to
point to that one above, but it doesn't exist on its own.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org

I hope that helps & thanks!

Cheers,
Miguel
