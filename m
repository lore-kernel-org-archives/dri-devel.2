Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB0EC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFF110E7D0;
	Mon, 28 Sep 2026 09:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LXLiLZ1Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896DF10E7D0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43F194380F;
 Mon, 28 Sep 2026 09:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F9C1F000FF;
 Mon, 28 Sep 2026 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790586564;
 bh=EDW8eGFj3iAwrJCnMTfdzYDceSCzmQAIJYT9L4Va3Xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LXLiLZ1YsKeXRyElXFbQwbSclVLt+L8XusT5NWrtQlwSAcu2/XYibvwrlRM7Gj6Hf
 ONGVqnnzhL3fPjgJC6v+4S1YdjYMCJOunb+PxJG/L/owAfIkYGF30d5ALVTL97LKTY
 N/21tmWC5Rs/r4kKkiBDRU/Jpl4Ov9YpH9ZGn7jzflxxV9cW1vT9dKOzQlDs7jakam
 KU20GWrWXAjBpP38XRLKu75w36gDQZhkAoZRUD8iKcw9xPcQTQoy202w5+V6JaE4v9
 6xIiOgwgvakrN8lyIkih7Ddf5aJMEz6V4GpsP4sbChDDHA8x4qm6qPmGNHIBSh7lvm
 sdncUYkeCM9Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928085724.41660-2-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:09:23 +0000
Message-Id: <20260928090923.E6F9C1F000FF@smtp.kernel.org>
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
- [Low] vt: unprivileged log injection via pr_warn_once in cursor sizing
--

commit 4874174842fbef217a6215957d5bf1bff1442b36
Author: Thomas Zimmermann <tzimmermann@suse.de>

vt: Add cursor-size helpers

The new helpers vc_cursor_start() and vc_cursor_end() return the scanlines
in which the cursor block starts respectively ends. Users can control the
cursor size with the vt module's parameter cur_default or with the ESC
sequence \e[?Nc. In case of an invalid setting, the new helpers fall back
to cur_default and then underline cursors.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf37495a81..8141296ccad05 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c

[ ... ]

> @@ -264,6 +265,109 @@ unsigned int vc_font_size(const struct vc_font *fon=
t)
>  }
>  EXPORT_SYMBOL_GPL(vc_font_size);
> =20
> +/*
> + * Cursors
> + */
> +
> +static unsigned int vc_cursor_size(unsigned int cursor_size)
> +{
> +	const unsigned int cursor_default_size =3D CUR_SIZE(READ_ONCE(cur_defau=
lt));
> +
> +retry:
> +	switch (cursor_size) {
> +	case CUR_NONE:
> +	case CUR_UNDERLINE:
> +	case CUR_LOWER_THIRD:
> +	case CUR_LOWER_HALF:
> +	case CUR_TWO_THIRDS:
> +	case CUR_BLOCK:
> +		return cursor_size;
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
> +		fallthrough;

[Severity: Low]
Is it expected that an unprivileged user can trigger this warning message?

An unprivileged user can write a specific DEC escape sequence (e.g.,
\e[?103c) to the VT, which parses an unhandled size into
vc->vc_cursor_type via CSI_MAKE.

When the console driver later updates the cursor, vc_cursor_size() hits
the default case and emits this warning.

Since pr_warn_once() is rate-limited to once per boot, it cannot cause
a denial of service, but it still allows local unprivileged users with
write access to a VT to add a warning line to the kernel log.

> +	case CUR_DEF:
> +		/*
> +		 * Use user-given default size, or underline if
> +		 * the given default is invalid.
> +		 */
> +		if (cursor_size !=3D cursor_default_size)
> +			cursor_size =3D cursor_default_size;
> +		else
> +			cursor_size =3D CUR_UNDERLINE;
> +		goto retry;
> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D1
