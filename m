Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6508C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369AA10E1C1;
	Fri, 26 Jun 2026 13:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="me3CdhPW";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCFD10E1C1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782479517; x=1783084317; i=deller@gmx.de;
 bh=AjSVO+3w7YHc0BBsKrWWzGvDXmfX8rVTtFxUUFkwtzA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=me3CdhPWZ0on8QVS/gUWuddZMycBjoSb0GH9ZGXucn41Ii7HosoTDqtfqSXbgV4s
 O6hapk9A66TgVjbtWX2nKBDV4HAMRiJ/ySyXNtWfwf792gUMIH8uuLpfC07LzbPHO
 zYWRYK+eLZKuMMmRi4hRaMM9bCWTX4QKkC694gEWZDdbfnUvqP/Kymj8rWVM2UJia
 mN290RIL7Zu1b1nmpz5S9eJ1KbTqTYaiIwO7hypj8Nq/0dciDYI+Lk1Lwhb0UVTG6
 ypkUwOqTnsXYx7YU62H76KaVUZikuth8idjitfIoJ2H2tRfuW1DVVJN8W/Qj/tMda
 q/E45n6EQSbvHpR0Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1wmdPO0gVr-00Vjgz; Fri, 26
 Jun 2026 15:11:57 +0200
Message-ID: <e94105dc-dd3d-4b07-a310-85ebc298230e@gmx.de>
Date: Fri, 26 Jun 2026 15:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: fix NULL pointer dereference for a console without
 vc_data
To: Ian Bridges <icb@fastmail.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ajxICA0v-_5NrqhS@dev>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ajxICA0v-_5NrqhS@dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:41fPp1Bls+JBDUFkK1G7VL3IsO9y/toK8nRPEa4GZ3mbs6LU7WZ
 Vxmt5q2q2PEXKYjlfzvC20rXzV7Q4lTT9lf4bBAdv5jyuJU14w4G2NyqXInchyobRLjQZ42
 Ze1LafLC9F92sBgy7IddaYVsOEu1RTjpUBK3EB6uzNUbgas4mHNxo74i8jjnB4vDSR4fiLS
 +BtYsOqHd2iiIOi58ALEg==
UI-OutboundReport: notjunk:1;M01:P0:tTOrcn6SO1E=;j5h4SDR8IBWz1b13Wd1uRLzet5r
 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
 8Gog0Bfis4GReiBFRD5HzzyUm+jZOcMMDlUdnqh
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

On 6/24/26 23:11, Ian Bridges wrote:
> fbcon_new_modelist() runs when a framebuffer's modelist changes. For eac=
h
> console mapped to it with fb_display[i].mode set, it reads vc_cons[i].d =
and
> passes the vc_num to fbcon_set_disp(). This assumes a console with a mod=
e
> set has a vc_data, but it can be NULL. fbcon_set_disp() sets
> fb_display[i].mode before it checks vc_data, and fbcon_deinit() leaves t=
he
> mode set after the vc_data is freed. fbcon_new_modelist() then dereferen=
ces
> the NULL vc_data.
>=20
> Keep fb_display[i].mode set only while the console has a vc_data. Check
> vc_data before setting the mode in fbcon_set_disp(), and clear the mode =
in
> fbcon_deinit(). The existing mode check in fbcon_new_modelist() then ski=
ps
> such consoles.
>=20
> Reported-by: syzbot+42525d636f430fd5d983@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D42525d636f430fd5d983
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> This patch fixes a NULL pointer dereference in the framebuffer console c=
ode.
> fbcon_new_modelist() dereferences a NULL vc_data. It was found while wri=
ting
> a reproducer for a separate use-after-free in store_modes(). Sashiko
> independently flagged the same dereference in its review of the fix for =
that
> use-after-free [1].
>=20
> The dereference happens when a console has fb_display[i].mode set but no
> vc_data, and the modelist is then replaced, as follows.
>=20
> 1. A console ends up with fb_display[i].mode set while vc_cons[i].d is N=
ULL.
>     Either fbcon_set_disp() sets the mode (fbcon.c:1446) before it check=
s
>     vc_data, so mapping an unused console with FBIOPUT_CON2FBMAP leaves =
the
>     mode set, or fbcon_deinit() (fbcon.c:1268) frees the vc_data but kee=
ps the
>     mode.
> 2. A write to the modes attribute calls store_modes() (fbsysfs.c:91), wh=
ich
>     replaces the modelist and calls fb_new_modelist() (fbsysfs.c:108).
> 3. fb_new_modelist() calls fbcon_new_modelist() (fbmem.c:770).
> 4. fbcon_new_modelist() walks the consoles mapped to the framebuffer, ta=
kes
>     vc =3D vc_cons[i].d for the one with the mode set, and reads vc->vc_=
num with
>     vc NULL (fbcon.c:3046). This is a NULL pointer dereference.
>=20
> This patch does not change that line:
>=20
>      fbcon_set_disp(info, &var, vc->vc_num);
>=20
> vc is vc_cons[i].d, which is NULL.
>=20
> syzbot reported the same crash, with the call stack store_modes() ->
> fb_new_modelist() -> fbcon_new_modelist() [2]. That report had no reprod=
ucer
> and was closed as obsolete.
>=20
> It reproduces on a KASAN kernel with two framebuffers, two ways:
>=20
> 1. Map an unused console to one framebuffer and back to the other with
>     FBIOPUT_CON2FBMAP, then write a modelist to that framebuffer's modes
>     attribute.
> 2. Open and close /dev/ttyN, then write a modelist to its framebuffer's
>     modes attribute.
>=20
> The reproducer was written with the help of a coding agent (Claude Code)=
. The
> patch is against commit 3726ce7f6cef on the for-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git. Th=
e
> file offsets above are from that commit. The dereference is present in t=
he
> initial 2.6.12-rc2 import, so there is no Fixes tag.
>=20
> [1] https://lore.kernel.org/all/20260622080749.D7FC61F000E9@smtp.kernel.=
org/
> [2] https://syzkaller.appspot.com/bug?extid=3D42525d636f430fd5d983
>=20
>   drivers/video/fbdev/core/fbcon.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

applied.

Thanks!
Helge
