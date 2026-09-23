Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD995C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1927610F22B;
	Wed, 23 Sep 2026 22:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dr3LswCz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2D510F222
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:47:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4056B434B3;
 Wed, 23 Sep 2026 22:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199F1F000FF;
 Wed, 23 Sep 2026 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790203643;
 bh=IHObVpVN7GLkzsy2GB4r3uxwfrR4h6KX4J1xjRiVKkM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dr3LswCz2+u4fZo2FIew6BbDCRWFnuQPrUH4S6J4EjMaUL79OMzD+xuxgtTH2mefx
 RYSDnBeV889ceMd+1tpWBSdoW2YBjGlq7g2lp63seqz/AnBwuUdExCRtBTCcB2z6M4
 USqGodeL5h0WeBgo1tDRUep0IAwnIIdoS5Q0SiSVYi7ny/5A7q+4PA8otmtFllR16h
 RvxGVQs9B6WKfkPkruktkfHd4vBuj4Eae8urflSAsEQX1Mr8Gae8SU8+1S3YW7OY1F
 O1YB5EMvpHcPItfFVnUwHvvc/vjy/CZUlhq6S06uANRVWlh8ls+d6X8HtzqWYs7Ao7
 Qy1iMOizmFGJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 31/38] dyndbg: split multi-query strings with @
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-31-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-31-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:47:22 +0000
Message-Id: <20260923224722.F199F1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: UAPI break for boot parameters containing unquoted @
--

commit a948e5ac96c252adcbc1059b7607e6fa7aab2b9d
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: split multi-query strings with @
   =20
This commit adds '@' to the existing ';' and '\n' separators for dynamic de=
bug
queries. This provides a more shell-friendly delimiter, reducing the need f=
or
quoting and escaping.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 6482fd28def46..636a88994a774 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -622,6 +622,30 @@ static int ddebug_exec_query(char *query_string, con=
st char *modname)
>  	return nfound;
>  }
> =20
> +/*
> + * Split multi-query string on delimiters (@, ;, \n), ignoring delimiters
> + * that appear inside single or double quoted strings.
> + */
> +static char *ddebug_find_delimiter(char *str, const char *delims)
> +{
> +	bool in_quote =3D false;
> +	char quote_char =3D 0;
> +
> +	for (; *str; str++) {
> +		if (*str =3D=3D '"' || *str =3D=3D '\'') {
> +			if (!in_quote) {
> +				in_quote =3D true;
> +				quote_char =3D *str;
> +			} else if (*str =3D=3D quote_char) {
> +				in_quote =3D false;
> +			}
> +		} else if (!in_quote && strchr(delims, *str)) {

[Severity: Medium]
Does this cause a regression for boot parameters with an unquoted '@' symbo=
l?

When a user provides a kernel parameter like dyndbg=3D"format i2c@1000 +p",
parse_args() strips the outer double-quotes before passing the unquoted
string down.

Once ddebug_exec_queries() passes the string to ddebug_find_delimiter(), it
will prematurely split the string at the '@' because in_quote is false,
producing invalid queries like 'format i2c' and '1000 +p', both of which
fail to parse.

Could this break existing boot parameters or modprobe configurations that
rely on the '@' symbol in format strings (e.g., matching device tree nodes)?

> +			return str;
> +		}
> +	}
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D31
