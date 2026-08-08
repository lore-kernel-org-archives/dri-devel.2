Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8189C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 05:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F4810E0E1;
	Sat,  8 Aug 2026 05:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="owuUf7E6";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534EE10E0E1
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 05:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786167856; x=1786772656; i=deller@gmx.de;
 bh=Y6ndFd0K+Ui5j+P7AUsA4oPv7cE3yjCnSLpdqFQuFh0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=owuUf7E6hvaxLiT78ZAy2tb6yOFsmpyFcjtf3mzj10LjKKVOJWoedc4kfcoaszum
 Chmxd/2pvZqalRDEAUt/1nkwxJ+DHo/t7PqOj239Q5qNUhnGj4iRFFBqVIlzF+Apz
 FJh2HAG2fKGyAAKTQcsfnkNsRFwvCHj5UJUCf0jbXfh/FtAXj1sqnt4AzEuw/A4nF
 ZQnL0z1Fkt3oWteYBTIlpC3X1rJd8fS6k1UJKdlQ3VBP5w6VBGNX554Uu/FSoJ5KU
 nevjI/zBwlRLLahbH0oCiIPa3eV3BkVx3gTcgwFfNJv4U8P8wdB1KyFuXddjG4omZ
 HWl0ltNg4TdT4bcE8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1wizbB0QNh-006eQ7; Sat, 08
 Aug 2026 07:44:16 +0200
Message-ID: <79d240b9-3b22-4280-b15e-cf3f2bae983a@gmx.de>
Date: Sat, 8 Aug 2026 07:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: bitblit: bound-check glyph index in bit_cursor()
To: Rik van Riel <riel@surriel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Junjie Cao <junjie.cao@intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807221956.4e9dde5c@fangorn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260807221956.4e9dde5c@fangorn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ruGUkklf3YuqOHefy51FCN/V/B/DQFpkXk3+xDsS7svbrXSbq/B
 A3ijGvzgwWjPptDFLHeNXmuC/FN3RVt/draghelFdbpUznZCTvLNfj4IR2W/WPC3+Wzti4n
 4ZYzFvBEFeb50Pi1Udx6jzcWowXmP7javezXsrAQKBNeJWmMqjde4XE2pf2Nh4YMqSHPhgM
 gbZgc5J/ERTvHWXi3Ux4Q==
UI-OutboundReport: notjunk:1;M01:P0:tLglxcC1jFk=;eqjFcTlKFh/kaoYDmg4CyKwb5FZ
 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
 zBjuHWdnBgE4XVvJluQ=
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

On 8/8/26 04:19, Rik van Riel wrote:
> bit_cursor() fetches the glyph under the cursor with
>=20
> 	c =3D scr_readw(vc_pos);
> 	src =3D vc_font.data + ((c & charmask) * w * height);
>=20
> where charmask is 0x1ff when vc_hi_font_mask is set. The screen buffer
> value comes directly from scr_readw() and may be larger than the current
> font's glyph count.
>=20
> Syzkaller triggers this via vcs_write(). The Call Trace shows
> vcs_write() in vc_screen.c writing an arbitrary 16-bit value with
> writev() to /dev/vcsa, which vcs_write_buf() in vc_screen.c stores via
> vcs_scr_writew() without checking charcount. The stored value is later
> read in bit_cursor() in bitblit.c.
>=20
> When the font is changed from a font with 512 glyphs to a font with
> 256 glyphs, the screen buffer can retain characters with the high
> bit set from the previous mode, which could also produce the same
> out-of-bounds access.
>=20
>    BUG: KASAN: global-out-of-bounds in soft_cursor+0x378/0x6bc drivers/v=
ideo/fbdev/core/softcursor.c:70
>    Read of size 16 at addr ffff800086c57970
>=20
>    Call Trace:
>     soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
>     bit_cursor+0xa90/0x1108 drivers/video/fbdev/core/bitblit.c:365
>     fbcon_cursor+0x344/0x498 drivers/video/fbdev/core/fbcon.c:1427
>     hide_cursor+0xdc/0x2d0 drivers/tty/vt/vt.c:883
>     update_region+0x100/0x18c drivers/tty/vt/vt.c:669
>     vcs_write+0x8ec/0xaf0 drivers/tty/vt/vc_screen.c:685
>=20
> bit_putcs_aligned() and bit_putcs_unaligned() already clamp the glyph
> index to vc_font.charcount. Apply the same clamp in bit_cursor() after
> extracting the attribute and masking, before indexing fontdata.
>=20
> The fix completes the bounds checking started in commit 18c4ef4e765a
> ("fbdev: bitblit: bound-check glyph index in bit_putcs*"), which missed
> the cursor path.
>=20
> This change should be safe because the clamp reuses the existing
> contract from fbcon: charcount is maintained under console_lock in
> con_font_set() and fbcon_font_set(), and hi_font_mask is cleared when
> switching from 512 to 256 glyphs. When stale screen data with high bits
> remains after a font switch, or when vcs_write() stores an arbitrary
> value, clamping the index to 0 prevents the out-of-bounds read without
> changing cursor semantics =E2=80=94 the same fallback bit_putcs uses.
>=20
> Reported-by: syzbot+61b1db46218109869c14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D61b1db46218109869c14
> Link: https://lore.kernel.org/all/6a75205c.01d0871a.3a0d52.0032.GAE@goog=
le.com/
> Fixes: 18c4ef4e765a ("fbdev: bitblit: bound-check glyph index in bit_put=
cs*")
> Cc: stable@vger.kernel.org
> Assisted-by: Hermes:muse-spark-1.2 syzkaller
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>   drivers/video/fbdev/core/bitblit.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
Patch applied to fbdev git tree.
Thanks!
Helge
