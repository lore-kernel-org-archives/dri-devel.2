Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B678C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8887F10E9B2;
	Fri, 26 Jun 2026 13:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="nBS7/zFw";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9B810EA11
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782479702; x=1783084502; i=deller@gmx.de;
 bh=vkh2X/mm2HXwC5A+TxpGV6WiDNGSad8edNU4yH+26jg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nBS7/zFw1vyGAUIvCoD7D9Ww51Mu306BEhEZMOMr//NwW5NhYqi3VuxywKw9pclr
 HaNoEDSGlqtdwvNv5P/7l0LFKBWAE+x6RLSQd4mqo5KOKdlBkpGGpl1gLOvRmljt/
 pHzCkTM18RTBXOP1kGMZbzdY1c3KOZSVi6XelX2yrWU3eGKdpHPUGfjK3FqtYfTEZ
 PFnJ3GXGMOWEcCEroFc/uc0+NKaUWPingF/YlslRRGiqlD0AHOzFkzTtYj+Tyu+HO
 s97IbL0+DrnuUSDkcZHjC+IL2mN+ciFrrh0psrk3buHjn5q1IDy1LnMy1j9/ATX+H
 lA0xMtztgAzhZ9hpwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1xC9xt14Ql-00mIuC; Fri, 26
 Jun 2026 15:15:02 +0200
Message-ID: <be5e8295-487a-4943-8e0e-b26610e7fc8d@gmx.de>
Date: Fri, 26 Jun 2026 15:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Fix fb_new_modelist to prevent null-ptr-deref in
 fb_videomode_to_var
To: Ian Bridges <icb@fastmail.org>, Simona Vetter <simona@ffwll.ch>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <ajyq2Fr-2fMfftGC@dev>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <ajyq2Fr-2fMfftGC@dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MxsN0OfOdF+9FeUX0sQh5fwQo5NJY0He39AegLkEjmNWiCSZyZh
 YSWOhbyHx2iIEf3OSuQuyaSmgP5MOmHXcfFx2qlKFiIMWiXGSNsTEBL1DXTK+9y30fTkFUT
 TMDwQ4XzG7KudLwzRBYy8YcJHhQ1TeIJqb17UyWLzPBluNjjSCqXSQ3FZ1u2wbA8oOC7QbV
 AlEyu6bRmsfMU28UnVdJQ==
UI-OutboundReport: notjunk:1;M01:P0:ekD/fY9CGi4=;sL/kIBrsOjhlfARXveRa93VWbiD
 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
 NZrCEsqy7PGdQqBAFs=
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

On 6/25/26 06:13, Ian Bridges wrote:
> info->var, a framebuffer's current mode, is expected to have a matching
> entry in info->modelist. var_to_display() relies on this and treats a
> failed fb_match_mode() as "This should not happen". fb_set_var() keeps i=
t
> true by adding the mode to the list on every change, and
> do_register_framebuffer() does the same at registration.
>=20
> store_modes() replaces the modelist from userspace. fb_new_modelist()
> validates the new modes but does not check that info->var still has a
> match. It relies on fbcon_new_modelist() to re-point consoles, but that
> only handles consoles mapped to the framebuffer. With fbcon unbound ther=
e
> are none, so info->var is left describing a mode that is no longer in th=
e
> list.
>=20
> A later console takeover runs var_to_display(), where fb_match_mode()
> returns NULL and leaves fb_display[i].mode NULL. fbcon_switch() passes i=
t
> to display_to_var(), and fb_videomode_to_var() dereferences the NULL mod=
e.
>=20
> Keep the current mode in the list in fb_new_modelist(), the same way
> fb_set_var() does.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> This patch fixes a NULL pointer dereference in fb_videomode_to_var(), re=
ached
> through the framebuffer console. The fix is in fb_new_modelist(). Sashik=
o
> flagged this dereference while reviewing the fix for a separate NULL poi=
nter
> dereference in fbcon_new_modelist() [1].
>=20
> The dereference happens when a framebuffer's current mode is dropped fro=
m its
> modelist while fbcon is unbound, and a console is then taken over onto i=
t, as
> follows.
>=20
> 1. With fbcon unbound, a write to the modes attribute calls store_modes(=
)
>     (fbsysfs.c:91), which replaces the modelist and calls fb_new_modelis=
t()
>     (fbsysfs.c:108). fb_new_modelist() (fbmem.c:746) validates the new m=
odes but
>     does not keep info->var in the list, and the fbcon_new_modelist() it=
 calls
>     (fbmem.c:770) only re-points consoles mapped to the framebuffer. Wit=
h fbcon
>     unbound there are none, so info->var is left describing a mode no lo=
nger in
>     the list.
> 2. Mapping a console with FBIOPUT_CON2FBMAP takes the framebuffer over,
>     set_con2fb_map() -> do_fbcon_takeover() (fbcon.c:930).
> 3. The takeover initialises the console, fbcon_init() -> var_to_display(=
)
>     (fbcon.c:1113). fb_match_mode() finds no entry for info->var, so
>     var_to_display() leaves fb_display[i].mode NULL (fbcon.c:988).
> 4. The takeover switches to the console, fbcon_switch() -> display_to_va=
r()
>     (fbcon.c:2181), and fb_videomode_to_var() reads the NULL mode
>     (modedb.c:905). This is a NULL pointer dereference.
>=20
> The faulting line is not touched by this patch:
>=20
>      var->xres =3D mode->xres;
>=20
> mode is the fb_display[i].mode passed by display_to_var(). Instead of gu=
arding
> this read, the patch keeps info->var in the modelist in fb_new_modelist(=
),
> so the mode is never NULL here.
>=20
> The same dereference, fb_videomode_to_var() on a NULL mode, was fixed tw=
ice
> before, by CVE-2025-38214 in fb_set_var() and CVE-2025-38215 in
> do_register_framebuffer(). Both keep info->var in the modelist, and both=
 are
> already in this base. This bug reaches the same line through a different
> path, a modelist replacement, and this fix keeps info->var in the list
> the same way.
>=20
> It reproduces on a KASAN kernel with two framebuffers:
>=20
> 1. Unbind fbcon, so the store in step 3 does not re-sync the mode.
> 2. Set a video mode on fb0 with FBIOPUT_VSCREENINFO.
> 3. Write a different modelist to /sys/class/graphics/fb0/modes, so the m=
ode
>     from step 2 is no longer in the modelist.
> 4. Map a console to fb0 with FBIOPUT_CON2FBMAP. With fbcon unbound this =
takes
>     fb0 over, sets the console mode to NULL (the mode is not in the mode=
list),
>     and switches to the console.
>=20
> The reproducer was written with the help of a coding agent (Claude Code)=
. The
> patch is against commit 3726ce7f6cef on the for-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git. Th=
e
> file offsets above are from that commit. The defect is present in the in=
itial
> 2.6.12-rc2 import, so there is no Fixes tag.
>=20
> [1] https://lore.kernel.org/all/20260624213027.6C1E01F000E9@smtp.kernel.=
org/
>=20
>   drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

applied.
Thanks!
Helge
