Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD1C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B8510E658;
	Mon, 10 Aug 2026 06:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=surriel.com header.i=@surriel.com header.b="ScPc/lfG";
	dkim-atps=neutral
X-Greylist: delayed 422 seconds by postgrey-1.36 at gabe;
 Sat, 08 Aug 2026 02:27:26 UTC
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E53B10E374
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
 ; s=mail;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aS+8umnirCVOqmOWTTwMPe+YY743AtN0N7MiTrBSQLk=; b=ScPc/lfGajyFfBoJq6VglFRe1f
 yhP5bGG04OuW9UT+eOJozTVRSM37YKwzbG1oBqu/MCuVip0RI1vdgga3sKKXcYsz2cUTs7LaAV65+
 Fwa4z9xgTgGXNRSkMnuC0pk5XU/z+ZDzkBhvxinV8wq53wFsK+GmgOpHvnEoE/+cBRZ1LGC4+XvKy
 7ZETNeoqq6Kyvg5IWTOt/2gVx3Sxi+YONov4YRM731B1BLNInkAKbTGvHA8XZGRUau+0lASnG0wWl
 DP974VYl1RbUpa69Bz3EVoqi4dxVBzXAoveWHIgvgH6HCDfaWEGPg3vN4PVWew6PTK2SKxrNZbUeX
 4BvgF2nQ==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708] (helo=fangorn)
 by shelob.surriel.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97.1)
 (envelope-from <riel@surriel.com>) id 1wsWfF-0000000035Y-1DX1;
 Fri, 07 Aug 2026 22:19:57 -0400
Date: Fri, 7 Aug 2026 22:19:56 -0400
From: Rik van Riel <riel@surriel.com>
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
 <simona@ffwll.ch>, Junjie Cao <junjie.cao@intel.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: bitblit: bound-check glyph index in bit_cursor()
Message-ID: <20260807221956.4e9dde5c@fangorn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

bit_cursor() fetches the glyph under the cursor with

	c =3D scr_readw(vc_pos);
	src =3D vc_font.data + ((c & charmask) * w * height);

where charmask is 0x1ff when vc_hi_font_mask is set. The screen buffer
value comes directly from scr_readw() and may be larger than the current
font's glyph count.

Syzkaller triggers this via vcs_write(). The Call Trace shows
vcs_write() in vc_screen.c writing an arbitrary 16-bit value with
writev() to /dev/vcsa, which vcs_write_buf() in vc_screen.c stores via
vcs_scr_writew() without checking charcount. The stored value is later
read in bit_cursor() in bitblit.c.

When the font is changed from a font with 512 glyphs to a font with
256 glyphs, the screen buffer can retain characters with the high
bit set from the previous mode, which could also produce the same=20
out-of-bounds access.

  BUG: KASAN: global-out-of-bounds in soft_cursor+0x378/0x6bc drivers/video=
/fbdev/core/softcursor.c:70
  Read of size 16 at addr ffff800086c57970

  Call Trace:
   soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
   bit_cursor+0xa90/0x1108 drivers/video/fbdev/core/bitblit.c:365
   fbcon_cursor+0x344/0x498 drivers/video/fbdev/core/fbcon.c:1427
   hide_cursor+0xdc/0x2d0 drivers/tty/vt/vt.c:883
   update_region+0x100/0x18c drivers/tty/vt/vt.c:669
   vcs_write+0x8ec/0xaf0 drivers/tty/vt/vc_screen.c:685

bit_putcs_aligned() and bit_putcs_unaligned() already clamp the glyph
index to vc_font.charcount. Apply the same clamp in bit_cursor() after
extracting the attribute and masking, before indexing fontdata.

The fix completes the bounds checking started in commit 18c4ef4e765a
("fbdev: bitblit: bound-check glyph index in bit_putcs*"), which missed
the cursor path.

This change should be safe because the clamp reuses the existing
contract from fbcon: charcount is maintained under console_lock in
con_font_set() and fbcon_font_set(), and hi_font_mask is cleared when
switching from 512 to 256 glyphs. When stale screen data with high bits
remains after a font switch, or when vcs_write() stores an arbitrary
value, clamping the index to 0 prevents the out-of-bounds read without
changing cursor semantics =E2=80=94 the same fallback bit_putcs uses.

Reported-by: syzbot+61b1db46218109869c14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D61b1db46218109869c14
Link: https://lore.kernel.org/all/6a75205c.01d0871a.3a0d52.0032.GAE@google.=
com/
Fixes: 18c4ef4e765a ("fbdev: bitblit: bound-check glyph index in bit_putcs*=
")
Cc: stable@vger.kernel.org
Assisted-by: Hermes:muse-spark-1.2 syzkaller
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/video/fbdev/core/bitblit.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/=
bitblit.c
index 65681dcc5930..39f44258d793 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -273,9 +273,14 @@ static void bit_cursor(struct vc_data *vc, struct fb_i=
nfo *info, bool enable,
 	if (!vc->vc_font.data)
 		return;
=20
- 	c =3D scr_readw((u16 *) vc->vc_pos);
+	c =3D scr_readw((u16 *) vc->vc_pos);
 	attribute =3D get_attribute(info, c);
-	src =3D vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+	c &=3D charmask;
+
+	/* Clamp to font size, same as bit_putcs_aligned() */
+	if (c >=3D vc->vc_font.charcount)
+		c =3D 0;
+	src =3D vc->vc_font.data + (c * (w * vc->vc_font.height));
=20
 	if (par->cursor_state.image.data !=3D (const char *)src ||
 	    par->cursor_reset) {
--=20
2.55.0

