Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4594AC79F82
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 01:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC1B10E229;
	Sun,  6 Sep 2026 01:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oRlnkD/2";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984E710E229
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 01:49:23 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d58efc7356so28557825ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788659363; x=1789264163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S0KhFClpzBCgstI8o1AR/vkilR/o3vMPMYTkXSYpO4U=;
 b=oRlnkD/2a5i6FE5Qb5mbo/1/StYyCYumPlqcHWhg0yE9w4xBGvXWCseM2S+miSmPyf
 eyY3i44a9zKLi4m4929ASrCOWSf/u+Jmb/I1g6Fx/rtXVg0ZftfhUFrhjrKJLBJJ94KJ
 XEkVm8vqPIme7s01SNISPNYNNS3Wokxjs+W8mMoOjgB0yfWcHH7cubnyAG+WgskEfMTY
 Jk2DzBLjCrhp2CgRASQfdYthNf53H/dIAAxK/URcJNSDwb4BBUpnfyVQk+gjHzVeQOb1
 hZgQhrpDlayJrCjs7420rxTLdodToglgBoXJVJotWi7By6rMB4yosbhi6bZ6LTZZ6V3O
 0HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788659363; x=1789264163;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S0KhFClpzBCgstI8o1AR/vkilR/o3vMPMYTkXSYpO4U=;
 b=okZF+mNRpLSqczHC1YWNk1x/NAAqFNFi67fmjudlrF3gfaWj2aQA3EWaTSke+YQgIh
 tOsGEHMvcMmTJKcIzTBCss5XE2JIr9j57H4PnQMwuaslDf4Z2iuOISCsIDi+J8PJZ9Gu
 gZxq4AvfgvQ3kHR3yfWlUfddjrwtVhgSktjdTQsIsmUxsdJG9Nxa/nVsChpx3ul4P7+V
 28nIJmNmrU+s8w9AH9ZidHkNKLbX46lnBAhzPt1RpePCEPtP7NaQrk0D+LwcPUWTzVfO
 XW/+c9T/xUg2UwAPN8BLLOwGeG0MV2rDq0J6EDskfN7957yBhGEdLBkBNelM0Q6QYLL9
 IXxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzV7wSu4X0KYL9D8wY/BbPiCnE3vakTIP89wmUkImACch8/3oM0qGCPbGG+llLhKWWbKcD2eYc9QE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZJ7xpszfUWoeIdjXed/lWMHTjxy2Ro39OuF3lIC1shyYzawro
 4EcpL5v9k+PmRFZxyvLDz+O08/f8MDU9hl0hQs02X99CpDqbEwLEtYVE
X-Gm-Gg: AYBFou2BSL+Wys1V1IFUTyQJcBPa9dtfXPeXMMlwzXi2jBkxcFNK1j2FBTK7J8+yO8h
 2TfQ4mfG2r2M+o2+Mz1Q76GDcBB+KeA/BUY2fx3sCc3MYdI0Xh1adrz2BEQx2nrnTasJJ2xfV+z
 JHQmTC+CZrU+0NMWeNOJvVI51rVl1yczCzyDQ4ojkqYL1EloVeYi+dmk56tw6SH732D4qnf/cvO
 B9s+nDhf+hPkurX9EdE1s4G1OmbWhkIwz2EMTVmXdL4mn9VTRvBIsKVRxlvUMZKnsuiTjiiitV5
 lBj+ATGzdab4j5soQ6R7pFgMA5iiSglMZcJDZIKhLK5eQOwEF1lHo+PUUB6YkUJIQQcDjFGefrU
 GkS46YrnGQuHwKgQDhnPmBxmbcZj3F2O3nQnaeO8PzV4puStqTtfDVUsnqLb4+ukup6OzprlSZs
 Tv3JrtVVxkLcUTIDHsb7k5Zku9YR5JDBkSuz1vTuJCk9s22enLErkTlnYO10hND3yD0LK6ubPq5
 FJ5ZTnUvLkL/26fmIA=
X-Received: by 2002:a17:902:ebc3:b0:2db:20fa:9443 with SMTP id
 d9443c01a7336-2db20fa96d6mr161492935ad.13.1788659362933; 
 Sat, 05 Sep 2026 18:49:22 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz.
 [122.59.250.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149ccf2esm27008175ad.73.2026.09.05.18.49.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Sep 2026 18:49:22 -0700 (PDT)
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
Cc: miro.kropacek@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
Date: Sun, 6 Sep 2026 13:49:14 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20260827093948.2825531-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Linmao,

thanks for your patch!

Am 27.08.2026 um 21:39 schrieb Linmao Li:
> The SuperBlitter operations derive an integer byte count per pixel.  The
> accelerated fill path handles only one-, two- and four-byte pixels.
> However, the operations are currently installed for every external
> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
> truecolor modes accepted by the external video parser.
>
> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
> nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
> incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
> despite advancing addresses by three bytes per pixel.  These cases can
> corrupt the framebuffer beyond the requested rectangle.

I believe 24 bpp mode can be rescued using something like this (entirely 
untested):

--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
         case 2:
                 memset16((u16 *)line, pix, rect->width);
                 break;
+       case 3:
+               memset(line, pix, ((rect->width * bytespp) % 4));
+               line += ((rect->width * bytespp) % 4);
+               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
+               break;
         default:
                 memset32((u32 *)line, pix, rect->width);
                 break;

Can't test this on hardware, and would need Miro to confirm it works as 
intended.

>
> Enable the SuperBlitter operations only for the layouts they implement:
> 8-bpp packed pixels and 16/32-bpp truecolor.  Keep the existing software
> operations for all other external formats.
>
> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/video/fbdev/atafb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index 5bca34c45cef3..c3011b61a94b9 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -3360,7 +3360,11 @@ static int __init atafb_probe(struct platform_device *pdev)
>  		memset (screen_base, 0, external_len);
>
>  		/* framebuffer in SV RAM: enable the SuperBlitter */
> -		if (external_addr >= 0xa0000000) {
> +		if (external_addr >= 0xa0000000 &&
> +		    ((external_pmode == FB_TYPE_PACKED_PIXELS &&
> +		      external_depth == 8) ||
> +		     (external_pmode == -1 &&
> +		      (external_depth == 16 || external_depth == 32)))) {
>  			svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
>  			if (svblit_regs) {
>  				svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
>

Otherwise, LGTM.

@Geert: can you remember if pixel format or bit depth of an external 
framebuffer can be changed at runtime using fbset??

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
