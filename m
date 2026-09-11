Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81221C88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B15410E70C;
	Fri, 11 Sep 2026 09:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IcSGku/3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA0810E70C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5456360230;
 Fri, 11 Sep 2026 09:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBC1F000FF;
 Fri, 11 Sep 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789120698;
 bh=baHUk9XK+QjBf5T9+7IHDmpb1au+ttmDjlX/GdARsEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IcSGku/3dyja91Cz6V+NYOceS9u4vBimSoViel33mRLdm6r37SZx+xL9lSVroB7cl
 gnY6+TDi/LXN1H/3It4WCpbbHwygGPle4uFUM1ldFAo6Jl/5cm/Pj7lj0j4wiI1fpB
 Mqx3A3a5eYWlSRYw/rKLxKxbsf66mMyerMIMur4zjtDSD5cLW3T15Ce3N4StM0Ktmq
 5CqDHpM+o0MjOaOKdKANloqRPbREifI5v56MdbqVopGG4MUMIwQfi5L9ZtDfmBTaOs
 oLMAsxk70EUqNHdVXhvuijUI2j6le7nAIEZNv3qeLs9xfGHhQLdoRlrtZ7pNYM4uQF
 8sMjSnRN0kWIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] vgacon: Use vt_font_cursor_{start,end}()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260911094518.78093-4-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:58:16 +0000
Message-Id: <20260911095817.D3BBC1F000FF@smtp.kernel.org>
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
- [High] Cursor bounds are calculated using `vc_font.height` instead of `vc=
_cell_height`, breaking hardware cursors when the text cell height is overr=
idden.
--

commit 25f4b9b96dc26e69ace4c42e72c99970c3c5fcf1
Author: Thomas Zimmermann <tzimmermann@suse.de>

vgacon: Use vt_font_cursor_{start,end}()

This commit replaces vgacon's custom cursor size calculations with the shar=
ed
helpers vc_font_cursor_start() and vc_font_cursor_end(). It subtracts one
from the end value to account for VGA hardware expectations.

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 536e7fe4d1426..b16ddb1b09a70 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c

[ ... ]

> @@ -524,33 +525,8 @@ static void vgacon_cursor(struct vc_data *c, bool en=
able)
>  		return;
>  	}
> =20
> -	switch (CUR_SIZE(c->vc_cursor_type)) {

[ ... ]

> -	default:
> -		vgacon_set_cursor_size(1, c_height);
> -		break;
> -	}
> +	vgacon_set_cursor_size(vc_font_cursor_start(&c->vc_font, c_type),
> +			       vc_font_cursor_end(&c->vc_font, c_type) - 1);

[Severity: High]
Does this code break the hardware cursor when the character cell height is
dynamically overridden?

If a user space utility like SVGATextMode calls the VT_RESIZEX ioctl with a
smaller v_clin, c->vc_cell_height is updated while c->vc_font.height remains
unchanged.=20

By computing the cursor bounds using the static font height via the shared
helpers instead of the active character cell height, it seems the programmed
start scanline could exceed the maximum scanline of the character cell
(VGA_CRTC_MAX_SCAN).=20

Since the hardware scanline counter resets before reaching the programmed c=
ursor
start line, would this cause the hardware cursor to become completely invis=
ible?

>  }
> =20
>  static void vgacon_doresize(struct vc_data *c,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D3
