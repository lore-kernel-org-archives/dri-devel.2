Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F98C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0086410E5F4;
	Thu, 17 Sep 2026 07:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pr5epCPz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F8710E5F4;
 Thu, 17 Sep 2026 07:38:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6024260200;
 Thu, 17 Sep 2026 07:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652801F000FF;
 Thu, 17 Sep 2026 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630696;
 bh=1za/h1JqMSh8ydtjD6biW2XlouFz44i3Cz4r59QO71k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pr5epCPzMYZ6XSf+JImspZtbZuHwdfMEYWYDnSbgz7Rc5PRbOUl2XEa6nyzlahdK1
 IUXTdZ/Rt6anzSYHnZdP/X8triKOoAao8+I441SyPmcwG3XLyvJ6nrbMYJfEVkDg3k
 fzWUD47zu69gD2sJM40+D2j+Sqlni/4K1eK1BCevg7uX5d/bD6hjC+x75Ij0w2q0+M
 3/lcWI5d4vRfmHpSVO0tutalOHlmfQZtLn2iJVSzd//6SM48V7fWLFco6bgs39YMml
 9nDTpze0BkXbX2YIIG5L3rFyC+wZWL/MbQzZtIFXTideIXGYAAl+iUgSmRgLj1iqzJ
 XbC4a5nWxfGpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/28] fortify: Convert strlcat() to snprintf() in strcat()
To: "Bill Wendling" <morbo@google.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, intel-xe@lists.freedesktop.org,
 media-ci@linuxtv.org, "Jeff
 Layton" <jlayton@kernel.org>, conor+dt@kernel.org, linux-scsi@vger.kernel.org,
 dmitry.torokhov@gmail.com, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-input@vger.kernel.org
In-Reply-To: <20260915081910.4142719-13-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-13-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:38:14 +0000
Message-Id: <20260917073815.652801F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] fortify: strcat using snprintf causes major performance regression
- [High] fortify: snprintf in strcat bypasses FORTIFY_READ bounds on source
--

commit d5360c3f44eeb8b6f9cd8cc195950107cbfe6556
Author: Bill Wendling <morbo@google.com>

fortify: Convert strlcat() to snprintf() in strcat()

Replaces the strlcat() implementation inside strcat() with
__builtin_snprintf() when the destination size is known, and falls back to
__underlying_strcat() otherwise. This prepares for the removal of the
deprecated strlcat() API.

Link: https://github.com/KSPP/linux/issues/370 [1]

> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index cf841dc71feff..0b489124bfcb8 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -363,7 +363,12 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, =
2)
>  char *strcat(char * const POS p, const char *q)
>  {
>  	const size_t p_size =3D __member_size(p);
> -	const size_t wanted =3D strlcat(p, q, p_size);
> +
> +	if (p_size =3D=3D SIZE_MAX)
> +		return __underlying_strcat(p, q);

[Severity: High]
Does falling back to the unfortified __underlying_strcat() directly here sk=
ip
the FORTIFY_READ bounds checks on the source string q?

The previous strlcat() fallback delegated to __fortify_strlen(q), which saf=
ely
bounded the read and triggered a panic if q was not NUL-terminated within i=
ts
allocation. Could this bypass allow unbounded reads if q lacks a NUL
terminator?

> +
> +	const size_t p_len =3D __fortify_strlen(p);
> +	const size_t wanted =3D p_len + __builtin_snprintf(p + p_len, p_size - =
p_len, "%s", q);

[Severity: High]
Will injecting __builtin_snprintf() for a fundamental string primitive like
strcat() cause a significant performance regression and stack bloat?

Because the size parameter is dynamic, the compiler cannot optimize this aw=
ay,
meaning this will call into the heavy vsnprintf() format parsing engine.

Given that vsnprintf() has a notoriously large stack footprint, could this
increase the risk of kernel stack overflows in deep call chains?

Additionally, does passing q as an opaque variadic argument to snprintf()
defeat the compiler's __builtin_object_size() tracking?

Since the vsnprintf() engine will process "%s" using an unbounded strlen(q),
could this bypass the intended FORTIFY_READ mitigation and leak information
or crash if q is missing a NUL terminator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915081910.4142=
719-1-morbo@google.com?part=3D12
