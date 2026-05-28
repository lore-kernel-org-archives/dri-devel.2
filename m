Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FF1CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1D710F5B3;
	Thu, 28 May 2026 19:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i7WgIx7u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22D810F5B3;
 Thu, 28 May 2026 19:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31C21601E4;
 Thu, 28 May 2026 19:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CA61F000E9;
 Thu, 28 May 2026 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779997496;
 bh=Al1Rdb0qP+tKYEA5EKgoaK4bwuBTFrZINc4pk3eqfec=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=i7WgIx7u93jihOGlS5GspsKjabCLij0u1nfESdcJQM9boPVNsHzFgmJNP29FW4scX
 VezJW37R8sJfQv4/YtN0rxZseENN+xhdCoMong9NuORcDhHWGVihrF7cE7eOQk46kI
 xzV8ftI0TI/ubVNDNBz13zAL0TgFgRz+W7D/+ogNC5Oj5yKySNsoRa47heYGKfmTLV
 LhAH+GPoEKq4NmQYIw94WJd3CVa3iiF0LN+JUikwmkXjeunokxTnnVNZUQUukyopeA
 EJ4e+MSFG5YCi3LWXHGso7ip/8C40NcxIAdVXN0XXhUJDhOvFc0PeFTdYhLMM9GGuy
 6idtrbPntPJuw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 21:44:52 +0200
Message-Id: <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Cc: <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Dave Airlie" <airlied@redhat.com>,
 "Qianfeng Rong" <rongqianfeng@vivo.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Kees Cook" <kees@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard" <mripard@kernel.org>,
 "Hongling Zeng" <zenghongling@kylinos.cn>, "Zhi Wang" <zhiw@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, "Timur Tabi" <ttabi@nvidia.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
In-Reply-To: <20260528192847.4077458-1-lyude@redhat.com>
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

On Thu May 28, 2026 at 9:27 PM CEST, Lyude Paul wrote:
> Lyude Paul (5):
>   Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage"
>   Revert "nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation"
>   Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
>   Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd"
>   Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions"

Reverting the whole thing for now is the right call, as it needs some more
review.

@Timur: I do think cleaning this up is the right call in general though, an=
d I
also don't think that the whole driver necessarily needs to be consistent o=
n
whether IS_ERR_OR_NULL() or IS_ERR() is used -- it depends on the context
(although I usually prefer not to mix up NULL and ERR semantics in the firs=
t
place).

It should however be consistent in terms of what functions can actually ret=
urn.

	ret =3D foo();
	if (IS_ERR_OR_NULL(ret))
		return ret;

If foo() can never return NULL, the above is misleading, as it puts an
obligation on the caller to somehow handle the NULL case and come up with a=
n
actual error code for it.

So, I think it is the right call to align that to what functions can actual=
ly
return, but while doing this, the contract should be properly documented, s=
uch
that subsequent changes can be properly validated.

I can pick this up later, but in case you want to pick it up Lyude, note th=
at
this now has to go into drm-misc-next-fixes.

Thanks,
Danilo
