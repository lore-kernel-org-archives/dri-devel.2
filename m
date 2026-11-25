Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9106606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=H915+J9n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F026D10E15F;
	Wed, 25 Nov 2026 19:28:59 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E76010E15F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:28:53 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795634931; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:LVerkcmoNxSsOAAt9ZxWU1IZn3O0
 KLD6m5TYLF+eRKTMiRkdCoV7+iGUKZNBG+uRLjN0syeBKEUNWcNoDSWlQu/Sa78a2DbFacxb3Eg
 Nx7MrBkpRVMyKUmaVRDH3Rr4xfe6t95FbDy3jftR4jTb5dCzKcToTyr9uCTb7iS2GYsPP3vxOEP
 kGFnWT0AVTWzVoIZvXvfTnbca9ffTKzjmNTnDUB3fgYrjzoqCCMJ2aZ85wyz7XdKeyLeo713ivr
 pJ24Nu1ZKZ7cIYNS7Hj8hA4cPY+KZLuID5ze63TJ+MYGpHf/SmZ9KjpC6hNAypGJjyGUOI3P4lG
 ki+jy3kRjggOww==;
Message-Instance: m=1; h=sha256: YS32ySsRE43y/5Rezzp+zBbBJ6q4htvxCLY2Hcc4tfc=:
 Xh6XzqO2+Vm//KHZ5pved4V4Mpq4w+3aNKVdi10Z+Tk=, sha512:
 lNlKIZT/S/9u9sftDtjqKx5gUIwEohJUVNrZQsGwcXHykugz0G0jMEryc7BvNqQg9bBVZQCb63S7daHs31aRbg==:
 YYOHL5A7XZxIRhBD9/4UaXaZAf6HYmCseJcucJbfmFzaSxQPsau+36p8oBnHfM4ixDhCOUgmbur9htxHvtPEvA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795634914; x=1796239714; i=deller@gmx.de;
 bh=2WBB1RIYRDYsoH+pAHFwBnXjsfJK/r9Z2G+7py6Y+PY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H915+J9n0wgCquIXNyxVNsx1vmF6EL6jc5WyAHIN46rzVLcicyHK7DFWhX3imH0v
 xcHSv402ccGRLh3sE5AaN1p9L0ihJhyWtT8CquFDkF62pwVViEM6aW5la4f6cmQlm
 rsagbH6uanU3EJPaMk4vnshj8P0UYZuQB1amRVaNsQIBQNXx75ZRxG9xntiYc67pK
 D8kxXxpUKEVEgKU3M/OsvNt4BUbI2U4rG7bhRp3fzwLPcckxWzyBVYmdGBQbh/QHs
 iQQhA+i/WAiy2W/s03FmkjG2bmHgF/TROr94sDkhmsrC+ShBDbExXKgQFhBh5wR8k
 4MyCTS4bJ6L2ecvQrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1ycNsx2nof-00ukac; Wed, 25
 Nov 2026 20:28:34 +0100
Message-ID: <ed7fa7b4-93af-472e-89cd-2a1c7120f2ed@gmx.de>
Date: Wed, 25 Nov 2026 20:28:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: radeonfb: match a display mode for a zero pixel
 period
To: Zou Jianqiang <jq.zou@outlook.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "byu@xidian.edu.cn" <byu@xidian.edu.cn>,
 "25181214217@stu.xidian.edu.cn" <25181214217@stu.xidian.edu.cn>
References: <20261125135233.26656-1-jq.zou@outlook.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261125135233.26656-1-jq.zou@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V56ymJC8ubi21EQGDhCAShxyAfFgdfeqSoG6YWVPQQ9X3sJ6Pbd
 +Oeq9CUUap06TiNf8b9XzGHz3LBOxAAYF+8p6aZEwCNYzSHS1qwWbYjltWDs7MCp8Kj2c0g
 iGfNQsL0+PhKqKAIeHD/RqZta7zR00Xwo8PW2siCIHp3/OEf/zepdzS2WlGhYYKv1kYddU/
 MSo8+sqx6ItMscqtFRhVA==
UI-OutboundReport: notjunk:1;M01:P0:uTp284ZFI5U=;nkNrfskroD4/DUpmfpUX+Y9SVs0
 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
 E11EW0G0y+fBUMYQcgZQIQ5DYr/Je565Fl
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 14:52, Zou Jianqiang wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
>=20
> A zero pixclock was rejected in radeonfb_check_var() by commit
> b3f1631d3625 ("fbdev: radeonfb: reject a zero pixclock in
> radeonfb_check_var()").  That works around a division by zero, but it
> violates the fbdev API: a value that does not fit has to be rounded up
> by the driver, and -EINVAL is only for values that are too large.  A
> zero pixel period does not fit, so it has to be rounded up as well.
>=20
> The check was added because a zero pixel period reaches
> radeonfb_set_par() and makes it divide by zero:
>=20
> 	dotClock =3D 1000000000 / pixClock;
>=20
> radeon_match_mode() already has the timings that can replace the
> unusable value, but it never gets that far.  With FB_ACTIVATE_NOW or
> FB_ACTIVATE_TEST it copies the request unchanged and only validates it
> against an EDID-derived mode database, and that database does not exist
> when no EDID was read - which is exactly the case that divides by zero.
>=20
> Drop that check and let radeon_match_mode() round the request up
> instead.  A zero pixel period no longer takes the short path, so it is
> matched against the mode database and a complete set of timings is
> returned to the caller.  radeonfb_check_var() then hands a nonzero
> pixel period back to fb_set_var(), so what reaches radeonfb_set_par()
> is usable; how the mode is programmed still depends on the output.
>=20
> The lookup needed a fix of its own to produce a usable mode.  Both VESA
> searches stopped after the first 34 entries, a limit that predates the
> widescreen modes at the end of vesa_modes[]; the other fbdev drivers
> already use VESA_MODEDB_SIZE for the same loop.  Use it here as well,
> as 1920x1200 is otherwise rounded up to 1920x1440 and 2560x1600 is
> rejected although the table has an entry for it.  Entries
> without a pixel period are skipped, so an unusable timing is never
> handed back.  Requests with a pixel period and FB_ACTIVATE_NOW or
> FB_ACTIVATE_TEST still return from the short path above; the ones that
> reach the lookup see the added widescreen entries as well.
>=20
> When the request had no pixel period, the requested virtual dimensions
> are kept, so rounding up does not shrink the panning area; a request
> that does specify a period keeps the previous behaviour.  The panning
> offsets come from the selected mode, so a stale offset is not returned
> either.  The first equally close mode in database order wins, so a
> request without a pixel period does not end up at the highest refresh
> rate.
>=20
> A request that matches no mode is rejected with -EINVAL.  For a
> zero-period request this now includes outputs with a scaler, because a
> scaler cannot invent a pixel period.  An output with a scaler still
> accepts a request that carries a period and uses those timings.
>=20
> Tested on 7.3.0 with a QEMU stub device for 1002:5955.  It has no EDID,
> so mon1_modedb is NULL and has_rmx is 0, which is the configuration
> that reaches the division.  FBIOPUT_VSCREENINFO with pixclock =3D 0 for
> 640x480 now returns 0 and reports a rounded up period of 39682 ps,
> while the same request on the stock Linux 7.3 driver, before
> b3f1631d3625, still triggers "divide error" in radeonfb_set_par().  A
> request larger than any table entry, e.g. 4096x3072, returns -EINVAL.
>=20
> Fixes: b3f1631d3625 ("fbdev: radeonfb: reject a zero pixclock in radeonf=
b_check_var()")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/r/20261101104107.33909-1-jq.zou@outlook.co=
m
> Link: https://lore.kernel.org/r/CAMuHMdWyrdpVKvs=3D8Q+B-Syo1ZdAJvfJXFv0q=
iNtR9z4VnwnBQ@mail.gmail.com
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> ---
>   drivers/video/fbdev/aty/radeon_base.c    |  3 ---
>   drivers/video/fbdev/aty/radeon_monitor.c | 21 ++++++++++++++-------
>   2 files changed, 14 insertions(+), 10 deletions(-)
applied.
Thanks!
Helge
