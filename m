Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D07606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tP6vJ0+B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BC51120E3;
	Thu, 12 Nov 2026 12:55:15 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE65A10FB18
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:30:43 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so1419706f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:30:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794396642; cv=none;
 d=google.com; s=arc-20260327;
 b=OzZXpUEjxAuXv8q/lX+FxrxcS/+ou9yV42fgVMdbVxloJlLzDnEUd4KXv5v44pJGvi
 +mJ7KJdSXf7AMnx8Yygdrf6l/0LjsWZz9l1V1qorwzDzQ7MYjmBN+0ALWBgLIS+Jznph
 tUrEEMdMBfYVyKwpG36MOiN9M9u9y0NFDRG6gBXdcCzbBQTu5HsJVKMfNtwvQTLHB67I
 VmNM2KUglHYacGvCfYuwckGoFa8Q01atwSEw98cfj6z2vOi+FpHWtuOAHn0sfO2GuvHK
 aKDt80X3uD9Uspvl7eRz7VpkAKzyDShsYAR+rBrO1Omm4GoduQX5cw1VEkdHrncanz7D
 MVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
 fh=3x9RZZvXyYheiDb9SHVqLrFSOAzWf1iFIAbyWHYRZDU=;
 b=SFQlwENdJKqiEbTi5QChBK9OdltpIsSJ3CDsaoZzDjCA96hSCpEU7sf5JmvuiK5Ptj
 c/7LIz7lH65OKqeWCKSNb8CNHoEt+bX9bq/KpousHyPuOWvRNXZyLzrN2MJls+jsbGKS
 1owYmodFWeDc8N7e9gM6aivxF/QQfvjKuoS4o3sqz3SjeU33Bv8kynHvxd4+HlKECjes
 cTfzQZas/+ScgAQLjKt6P1dgEQBjkT9mkxsGNYEUo9BZS6r/rZBKHgqaWrJaMjBSFVb1
 qpPKkMjXDbZGeE42eO1BED0260/RRvEedStESK42zjvtJ+LMkxoJaEwBLxEecOIRJRyA
 KMRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794396642; x=1795001442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
 b=tP6vJ0+Bg4rb9GAR3IAgV+arqgBTbzu59IGk9+6YyZ6ZYQFS3/EnZi7/4hBdqUNRN5
 s1U6JNLfyXsybUf/n+pB6ZMr1GGwQfXGa0eHgGdpw4Y71bTwa8w4LQTfc3S2pXW/uHQe
 7BWf5IDJDni/M/olCJLKRWur7MCHolsWrBrDq5u0Rbx5BKQTp72Yl67FBX4oCsOj8Fiy
 l9G2+QIkI5DKscYiF7OGnsjt/jPcHDbmzTb/QX4QkcBQA0rxD7YoTkq2EyMOuvBXEXMC
 ELh1hiSAEVxhj28AJzT8JDi70z7FVTBCU+2Mf9X7UlVX/Um2z1Fgh73ftV4rVuDggju8
 aIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794396642; x=1795001442;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UgfkhFQDE5XUrpu/BniOwomSfmu/mN0hFz5scbETrso=;
 b=vdbM06W4ckXa6TFZZFtPl78Bj9ONYDJgTwGu46CKA8lYcbtsrMP5XxDy4D6SpmFEef
 hCnYiBeMsUf8BWPB6v3JhKXhXZGtK1A8OSrOsrZ/S8UgxpHqEF7UxwvXQd3uzdQjoJJM
 1x0kMOMFRwY+DB7vq1VfFiz4buFnw/u15n9mRX40dpTGylNEs2v57m2BxU0YhF2Aus4G
 exXpT2Cfnfo3hiYDXBQZh7l+R0pJgacuCfggNlDirhwrr5nMiw8+OLCDMPsdegAUEfFt
 G2+Dhj+CN3ei0DX3KHPU05/2Hn+nEx+4U1+Q6V2aNeWbKgLxY3fsbJrJHV9g/pqmct31
 m4WA==
X-Forwarded-Encrypted: i=1;
 AL+hErFs6S+GwAcoJqdrPIQGT+FWZnsFhxUunARA0kwdRVgQfXfCWHYerThKny5AgD1/6Mq6OOs36cq4xbo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/VcIbomXaE+vcEGrCOyEqQGBwyN5SANJhCAOgQlfg8gdDEoKaV
 SQdfHjNJ80+mfNFHMaQjKm6qRsk/KUhsM7lp3bxxhPunTqlwJ6CNerTAO3pB7iOznewsoZrILaU
 8uudu5OZaz8QESNj3YKwM5flRTHwKJX4=
X-Gm-Gg: AYBFou03EY5DLKPrDZTuTJZt+7buFf5lk+UtqCi96BoL9T4U3pJnJX3YA5HsDdUnAdH
 uIduC1oagH7Se5FKZyRGwKAPE+e2s/WJ4Gmwwfdtr80ej8Kv62kBuIX9qQrbXvkvH3P01UoJykE
 MtaMPqmwACX7YK6/uZgx71mJxM0KsWGB+eWGb1FgX2APlZHXuG+BWTg6+SD5kmmGa+uDTY/+Gbl
 0XNBXXCWr0+6SIF9PMfg7Op1r4Qu1E8LXjgcxRUu+PKey2cQG1VKKSHJhaAdpeBZCKNxcp8gmvT
 7AFe615+/eZoHIBQuRs/IyyJZNccvUGSAGLJ9gCoq3wYZM1jvGFYi63lhlLCCPph7M09VHlsHd9
 HjFMpHEsu4e4KHFsfn6JPma6afP3bYMqpm/M7Je5uiZMTVbpqqQgrgSl26d8=
X-Received: by 2002:a05:6000:4a09:b0:48f:e879:5890 with SMTP id
 ffacd0b85a97d-499c7368708mr3693601f8f.32.1794396641750; Wed, 11 Nov 2026
 03:30:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
In-Reply-To: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
From: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
Date: Wed, 11 Nov 2026 16:30:29 +0500
X-Gm-Features: AclHuK8l6XMFWNrCKlt8GZ3LUscrj4Ss66FjgXR0gQdCuuxpBLlr3WsNlgeFcLo
Message-ID: <CAKD4hN5rOFCczzdBzgyD15EWvcgK=KRgyXihqfE-hd1XydnLKQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: fbcon: Fix KASAN slab-out-of-bounds read in
 rotated font buffer
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@osdl.org>, 
 "open list:FRAMEBUFFER CONSOLE" <dri-devel@lists.freedesktop.org>, 
 "open list:FRAMEBUFFER CONSOLE" <linux-fbdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I wanted to follow up on this patch, if anyone has had a chance to review i=
t.

Thanks,
Tayyab

On Wed, Sep 23, 2026 at 11:10=E2=80=AFAM Syed Tayyab Farooq
<syedtayyabfarooq08@gmail.com> wrote:
>
> The root cause of this KASAN slab-out-of-bounds read is that fbcon fails =
to
> reallocate the rotated font buffer (par->rotated.buf) when the font
> character count changes but the font dimensions (width and height) remain
> the same.
>
> When a user changes the font via ioctl(KDFONTOP), fbcon_do_set_font() is
> called. If the user first sets a 256-character font, enables rotation, an=
d
> then sets a 512-character font with the exact same width and height, resi=
ze
> evaluates to false. The function then directly calls update_screen(vc).
> Notice that fbcon_do_set_font() never calls par->bitops->rotate_font() to
> update the rotated font buffer for the new font. As a result,
> par->rotated.buf remains sized for the old 256-character font.
>
> When update_screen(vc) is called, it eventually reaches cw_putcs_aligned(=
),
> which attempts to read the glyphs from the rotated buffer. Since
> vc->vc_font.charcount is now 512, vc->vc_hi_font_mask is set, making
> charmask equal to 0x1ff (511). If the text buffer contains a character wi=
th
> an index >=3D 256, src will point out of bounds of the old par->rotated.b=
uf
> (which only holds 256 glyphs). The subsequent read in
> __fb_pad_aligned_buffer() triggers the KASAN slab-out-of-bounds crash.
>
> To fix this, fbcon_do_set_font() must call par->bitops->rotate_font() to
> update the rotated font buffer before calling vc_resize() or
> update_screen(). If vc_resize() fails and the old font is restored in the
> error path, rotate_font() must be called again to restore the rotated
> buffer.
>
> This pattern of updating the rotated font buffer was previously establish=
ed
> in fbcon_modechanged() by commit ef7656e85f1a ("fbdev: Fix out-of-bounds
> access when rotating console after font resize"). The fix applies this
> exact idiom to fbcon_do_set_font(). By placing it before vc_resize() and
> update_screen(), we ensure the buffer is correctly sized before any
> rendering occurs. Checking con_is_visible(vc) is also correct here, as
> hidden consoles will have their rotation state updated later via
> fbcon_switch() when they become visible.
>
> Furthermore, by calling rotate_font() again in the err_out path, we ensur=
e
> that if vc_resize() fails, the rotated buffer is restored to match the ol=
d
> vc->vc_font. Without this, restoring a 512-character font to a
> 256-character font on failure would leave the rotated buffer sized for 51=
2
> characters, which wastes memory; or worse, restoring a 256-character font
> to a 512-character font would leave the buffer too small, causing an
> out-of-bounds read later.
>
> Fixes: e4fc27618b75 ("[PATCH] fbcon: Console Rotation - Prepare fbcon for=
 console rotation")
> Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
> Reported-by: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbf4020519fbd94b2355d
> Link: https://syzkaller.appspot.com/ai_job?id=3D59f0d7d9-607c-4497-b2e2-0=
b16693f9502
> Signed-off-by: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 01715873ea49..158b2f91d68e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2432,6 +2432,13 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>         else if (!vc->vc_hi_font_mask && charcount =3D=3D 512)
>                 set_vc_hi_font(vc, true);
>
> +       if (con_is_visible(vc)) {
> +               if (par->bitops->rotate_font && par->bitops->rotate_font(=
info, vc)) {
> +                       par->rotate =3D FB_ROTATE_UR;
> +                       set_blitting_type(vc, info);
> +               }
> +       }
> +
>         if (resize) {
>                 int cols, rows;
>
> @@ -2466,6 +2473,13 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>         else if (!old_hi_font_mask && vc->vc_hi_font_mask)
>                 set_vc_hi_font(vc, false);
>
> +       if (con_is_visible(vc)) {
> +               if (par->bitops->rotate_font && par->bitops->rotate_font(=
info, vc)) {
> +                       par->rotate =3D FB_ROTATE_UR;
> +                       set_blitting_type(vc, info);
> +               }
> +       }
> +
>         font_data_put(data);
>
>         return ret;
> --
> 2.43.0
>
