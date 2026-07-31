Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1FEC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F90B10F1C1;
	Fri, 31 Jul 2026 07:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="ZliYq7I3";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3F310F1A9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785483078; x=1786087878; i=deller@gmx.de;
 bh=po8u5PwC157U2mHSwhsDpz36ttkI427MrnMynsBF/rI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZliYq7I3imJzbSWP9vV0rIMftST/t0hu/fL5qzXreFMlko9CioyhV8pSQr3NP+OA
 oTuqSIfY4q8FW6UwXuyW0lqGeD82SZNpKIzU06g3RJy4oX7Vc3Lt0RW9AnUZgFj8Q
 rSM75qCQya7b5VOqR9v7m3rRHbV5GuAt7PdmpapelEA6/ZtLMpDvdVGbwRiBloXZ8
 SMZFAXb+wFIiyhRpbgHufCImnsn6oP5ZXpBrEZEyFau9omRXypSGklml+qvPfgR7r
 1g3EooC7N1fuPb2xxiyes88umRzWpj4bECPpTldE6H3a5X+c8Ti9rS6xdxcIZl73l
 BGrr3piPG/5RUC7V+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1waFEU21Ye-00Uy2W; Fri, 31
 Jul 2026 09:31:18 +0200
Message-ID: <f2b8299c-306a-4b20-a1fa-95b0d64e55c4@gmx.de>
Date: Fri, 31 Jul 2026 09:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] fbdev: Fix out-of-bounds access when rotating console
 after font resize
To: Zizhi Wo <wozizhi@huaweicloud.com>, simona@ffwll.ch, tzimmermann@suse.de, 
 sam@ravnborg.org, ville.syrjala@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260729021204.3385299-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260729021204.3385299-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fS7Q8OejDEV00eVu8grXe7mH0HUL8GnmZmBJWZX6oyBURxX4YqG
 x9g8WqEy1UXhS+aPVxAhEVJpOwXeWm1cOW4iw3J8i0k6NGMNwoh6r1MouNp0SnKemTiA1HK
 MXrb2OTzrx1+GmORNPJhO7W/M3wrGE+xnjOI1F4jEUFW5WowRWfu4tgSOaoO8m3lW/p30vB
 PbYMj17xq4W+3YWu9C4zw==
UI-OutboundReport: notjunk:1;M01:P0:rEEhtkdupZw=;y71PGtREbnBIYxfL0rL9C/QE/ik
 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
 ZQ8
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

On 7/29/26 04:12, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
>=20
> [BUG]
> Recently, we encountered a KASAN warning as follows:
>=20
> BUG: KASAN: slab-out-of-bounds in ccw_putcs+0x8bd/0xa80
> Read of size 1 at addr ff11000110067100 by task bash/1209
> CPU: 10 UID: 0 PID: 1209 Comm: bash Not tainted 7.2.0-rc3 #69 PREEMPT(fu=
ll)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc4=
1 04/01/2014
>   Call Trace:
>    <TASK>
>    ...
>    kasan_report+0xf0/0x120
>    ? ccw_putcs+0x8bd/0xa80
>    ccw_putcs+0x8bd/0xa80
>    ? __pfx_ccw_putcs+0x10/0x10
>    fbcon_putcs+0x338/0x410
>    ? __pfx_ccw_putcs+0x10/0x10
>    do_update_region+0x21d/0x450
>    invert_screen+0x29d/0x5e0
>    ? __kmalloc_noprof+0x493/0x640
>    ? vc_do_resize+0x17c/0xe50
>    clear_selection+0x4c/0x60
>    vc_do_resize+0xaee/0xe50
>    fbcon_modechanged+0x2bd/0x640
>    rotate_all_store+0x298/0x380
>    ...
>=20
> reproduce:
> 1) issue two ioctls: first a KDFONTOP ioctl with op.op =3D KD_FONT_OP_SE=
T,
> op.width =3D 1 and op.height =3D 1, then a TIOCL_SETSEL ioctl
> 2) echo 2 > /sys/devices/virtual/graphics/fbcon/rotate_all
> 3) issue two ioctls: first a KDFONTOP ioctl with op.op =3D KD_FONT_OP_SE=
T,
> op.width =3D 8 and op.height =3D 1, then a TIOCL_SETSEL ioctl
> 4) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
>=20
> [CAUSE]
> The root cause is that fbcon_modechanged() first sets the current rotate=
's
> corresponding ops. Subsequently, during vc_resize(), it may trigger
> clear_selection(), and in fbcon_putcs->ccw_putcs[rotate=3D3], this can r=
esult
> in an out-of-bounds access to "src". This happens because par->rotated.b=
uf
> is reallocated in fbcon_rotate_font():
> 1) When rotate=3D2, its size is (width + 7) / 8 * height
> 2) When rotate=3D3, its size is (height + 7) / 8 * width
>=20
> And the call to fbcon_rotate_font() occurs after clear_selection(). In
> other words, the fontbuffer is allocated using the size calculated from =
the
> previous rotation 2, but before reallocating it with the new size,
> con_putcs is already using the new rotation 3:
>=20
> rotate_all_store
>   fbcon_rotate_all
>    fbcon_set_all_vcs
>     fbcon_modechanged
>      set_blitting_type
>      ...
>       par->bitops =3D &ccw_fbcon_bitops
>      vc_resize
>      ...
>       clear_selection
>        highlight
>        ...
>         do_update_region
> 	fbcon_putcs
> 	...
> 	 image.dy =3D vyres - ((xx + count) * vc->vc_font.width) [1]  // overfl=
ow!
> 	 ccw_putcs_aligned
> 	  // old buf size is still being used during the read!
> 	  src =3D par->rotated.buf + (scr_readw(s--) & charmask) * cellsize
> 	  fb_pad_aligned_buffer----[src KASAN!!!]	[2]
> 	  info->fbops->fb_imageblit(info, image)
> 	   sys_imageblit
> 	    fb_imageblit
> 	     fb_address_forward
> 	      // offset: image->dy * bits_per_line + image->dx * bpp
> 	      unsigned int bits =3D (unsigned int)adr->bits + offset
> 	      adr->address +=3D (bits & ~(BITS_PER_LONG - 1u)) / BITS_PER_BYTE	=
[3]
> 	     fb_bitmap_imageblit
> 	     ...
> 	      fb_read_offset	// page fault!	[4]
>      update_screen
>       redraw_screen
>       ...
>        ccw_cursor
>         soft_cursor
>          memcpy(src, image->data, dsize)----[src KASAN again!!!]	[5]
>       fbcon_switch
>        fbcon_rotate_font
>         font_data_rotate
> 	dst =3D kmalloc_array(charcount, d_cellsize, GFP_KERNEL)
>         // the new size is allocated only here!
>         par->rotated.buf =3D buf	[6]
>=20
> [FIX]
> A fairly obvious approach is to follow fbcon_switch(): in
> fbcon_modechanged(), call rotate_font() before vc_resize() so that a
> correctly sized buffer is allocated in time, as done in [6]. This fix is
> necessary, but it is not sufficient on its own.
>=20
> In [1] it causes an image.dy overflow (ccw_putcs: vyres =3D 768,
> image.dy =3D 4294967040), because vc_cols has not been updated in time a=
t
> this point (it is likewise only updated after clear_selection()). This
> allows (xx + count) * width to exceed vyres, causing image.dy to overflo=
w.
> Subsequently, address in [3] is incremented by an even larger amount, wh=
ich
> triggers a page fault at [4].
>=20
> Therefore, a second fix is required in combination with the first: move
> clear_selection() earlier, before set_blitting_type() in
> fbcon_set_all_vcs(), to prevent the out-of-bounds access. fbcon_rotate()
> has a similar problem, so add the same clear there. Since vc_is_sel() is
> not exported, the fbdev side is currently forced to call clear_selection=
()
> unconditionally, causing the global selection to be cleared prematurely.
> And this will not cause any other significant impact.
>=20
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
> v3:
> Add comments.
>=20
> v2:
> Fixed the issue by calling clear_selection() earlier, and updated the
> related description in the commit message.
> https://lore.kernel.org/all/20260722062216.2574546-1-wozizhi@huaweicloud=
.com/
>=20
> v1:
> https://lore.kernel.org/all/20250905024340.337521-1-wozizhi@huaweicloud.=
com/
> ---
> ---
>   drivers/video/fbdev/core/fbcon.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
patch applied.

Thanks!
Helge

