Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715F5C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E7B010E635;
	Thu, 17 Sep 2026 07:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jckCPMXD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14F710E5F4;
 Thu, 17 Sep 2026 07:38:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C20441731;
 Thu, 17 Sep 2026 07:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987411F00893;
 Thu, 17 Sep 2026 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630697;
 bh=jpGqW+MfOshPFAQDSqOKwBdLG/2Mt9oKqLi0j+mvT7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jckCPMXDvo3wNKxAPzl89AuzzCT57RHDDpILaY+yDfyiARawwRx0VMLNGNwYCz1K8
 YY3B85URloPktb8hIaUs2A5ZrLyY1Hu6qHVoNfpB+Rn2iBdgvj8Bvk5Zx7cJ9xkTzk
 69RN8vPMiDvXzcaQ4FD7y0xxo6hCEO5AkudhwQ3NcuMi8HpD9hYQtHxlrjPJVv/RJt
 rcjLk4vsOXc/2nfIwRcm/9PfDFt0PzAS8jCaBSOo2gf4rC9dOdC01n8IBizW9YPMmH
 A8p3eNgOtM/d8tlH/F2hQsZCdB6J/Q3PgS31vrdI4jWW3nRNvZ6X/sUdC1KBdH2DrC
 Y9e3tZWuCznxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/28] ARM: atags: Replace strlcat() with snprintf() for
 cmdline extend
To: "Bill Wendling" <morbo@google.com>
Cc: linux-scsi@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 media-ci@linuxtv.org, "Anna
 Schumaker" <anna@kernel.org>, dmitry.torokhov@gmail.com, robh@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-input@vger.kernel.org,
 "Chuck Lever" <cel@kernel.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915081910.4142719-4-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-4-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:38:16 +0000
Message-Id: <20260917073816.987411F00893@smtp.kernel.org>
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
- [High] arm: atags: OOB read and panic in parse_tag_cmdline() due to strle=
n()
--

commit 9d3172b712a6dbf6594b26ae8fb56ebd952c7d66
Author: Bill Wendling <morbo@google.com>

ARM: atags: Replace strlcat() with snprintf() for cmdline extend

This commit replaces the deprecated strlcat() API with snprintf() in
parse_tag_cmdline() to append the bootloader tag command line to
default_command_line.

Link: https://github.com/KSPP/linux/issues/370 [1]

> diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
> index 4ec591bde3dfa..21140b44d96e6 100644
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -121,9 +121,10 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
>  static int __init parse_tag_cmdline(const struct tag *tag)
>  {
>  #if defined(CONFIG_CMDLINE_EXTEND)
> -	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
> -	strlcat(default_command_line, tag->u.cmdline.cmdline,
> -		COMMAND_LINE_SIZE);
> +	size_t len =3D strlen(default_command_line);

[Severity: High]
Is it possible for strlen() to read out of bounds or panic here?

If CONFIG_CMDLINE is exactly COMMAND_LINE_SIZE characters long, the C compi=
ler
initializes the default_command_line array without a null terminator. The
original strlcat() code used strnlen() underneath and handled full buffers
safely.

Under CONFIG_FORTIFY_SOURCE, calling strlen() on an unterminated buffer tri=
ggers
a fortify_panic(), which will crash the kernel during early boot.

Without CONFIG_FORTIFY_SOURCE, strlen() will read out of bounds until it fi=
nds
a null byte, resulting in len being larger than COMMAND_LINE_SIZE.

> +
> +	snprintf(default_command_line + len, COMMAND_LINE_SIZE - len,
> +		 " %s", tag->u.cmdline.cmdline);

[Severity: High]
If len exceeds COMMAND_LINE_SIZE as described above, will this calculation
underflow?

This would cause COMMAND_LINE_SIZE - len to mathematically underflow to a h=
uge
unsigned value.

When this huge size parameter is passed to snprintf(), it triggers a
WARN_ON_ONCE(size > INT_MAX) in vsnprintf().

>  #elif defined(CONFIG_CMDLINE_FORCE)
>  	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n=
");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915081910.4142=
719-1-morbo@google.com?part=3D3
