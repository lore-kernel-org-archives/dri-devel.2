Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E0C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EF210E908;
	Mon,  7 Sep 2026 20:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EXuw5Oem";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD64910E908
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:18:33 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so4028004a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788812313; x=1789417113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MkTk6U8Hsd5NK/nm/H/rlcc7sKnrtC8ko7vuxkMvp9s=;
 b=EXuw5OemjKXiNxW3uQ4oPVSzUTalQfDd68tydQAbTvLHokOMo9d7X9JkkwTO9Q3qn0
 AgdQ8AHI0p+1PE8YVreKg4eNkg09uoKjROsNUvCr2OMM7tfIazMrQP+z2r9K5+49tcDf
 x7ectmaeDDHQltBoIcVYiRozAR7uNTpaIc9jnoB3RYKOQvnQfP/JhwP/MYFocrbM1MRc
 TgWFUd56zcQaFtgi6cmmtOSiWKy3Ly4JMAa46YvVBykyh2FkCl3BBGEGuGgasny+dfKu
 8mmZL2WEkmRz/Tv00wWJ/PEvcIigVXFSTPXtXrDVEFjkJy7bmHOai5uX2CeXO31l3etf
 YF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788812313; x=1789417113;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MkTk6U8Hsd5NK/nm/H/rlcc7sKnrtC8ko7vuxkMvp9s=;
 b=qoLJxGjak58y/RlAUOtnwb4wFE3avN5ysqBrKISGK3ZJFUxAp4jUmljrAUDal2mXeH
 1WfF1Avp4vTi3YhHNO/WM4LgUsOG28/Unx5yQwMnhK8xOlAsxde0daZAR22r6mdv1Reg
 S3kWGzqGLqkhizGQEaEZ21WGCl6hK60Hk3isIz3Wownv8Ysz9ittzm6OCj14OqnFIsas
 /4x8eba5C9mlfIItUzuXBiv3OdscIlM8TPaPM5+tsneFmPdCgvwE8oRW5cJkJN1kgnoI
 N+/iTGAKzOjr27X9T+0/P2Sr4yHqOTTsSW88+e9C7DT0mhx8f1d0CF6m2hg+jMRM1fIM
 yppg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7h29d9iZNHFurW/lELBAqA1Qj+y83v/zZXKv/m+y4KAIjJwl/0OjjQkofkGGKP6UZOZWdPSVpHAE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZYq2JUu5+pAqkkepDbdJOF8mJW9fP75qVHUqs+BavikDe62bQ
 j99bOXbmoCpxhGrrXtXX+8RDEorqVaP9lLr9qGXH9EK581O3CJBTKZmxgXva2w==
X-Gm-Gg: AYBFou2yZfBA8h6myRkd887RJjZeOm55MRqbrnz9imRemxfhfCdD6SZpOulaeBj+g7u
 ax41SA2PEOlgQg9SoCmAfOYH25bKXtccT1HB+WFaG3v4s1WZXq9b8uIZglVZ3MXjIWjOYNAsRiy
 65IMdE8VAh40Cqvqe1AfGvL9VDD9NvME2i+gSPfZQrjj9PP9pmZsTy0cAbPniCVgQP3CxuZ7R/p
 +5muEC6fC0XxHLJ4If9FGB7zxoQQMU+6AzKLpa1RxmEvg9i2Z/ngiErBEOmf7YKcOl5hG77QzMs
 YhF1WD6lepPeT06F2Rl67Iu/gPsuaubE94PQW4OQbLPxozYEhG/W5UmSx3OTg6gBfd0ZgAyU3rW
 p03PEdLaPHD703z8ZAo/RpwYSbYtsllXJIqLx3FaR6B2ugkYjUu7s0k0g/scKbkl4cgCt2aEQJf
 8lgqbZqlpnpc+XzhK9oy9pzcuDKRwlyMoGRHlYhX0g45V9Da8ZFheXxXSPrLiUrZiZMeKjTKjfr
 b0G0aFJ3+QWjGmvIBEilu+jfd++3l6KIDXxFSUJFzw7x3eNoBI46vUg8xS5hMmionS3IQBDYtJR
X-Received: by 2002:a05:6a20:7350:b0:3d3:aec2:4dc8 with SMTP id
 adf61e73a8af0-3da3a0c510dmr36997103637.20.1788812313022; 
 Mon, 07 Sep 2026 13:18:33 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:e5ea:1a30:7c29:cd76?
 ([2001:df0:0:200c:e5ea:1a30:7c29:cd76])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-338778fb926sm4986048eec.31.2026.09.07.13.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 13:18:32 -0700 (PDT)
Message-ID: <93ffe3ec-bb45-4c10-8d78-0cd23c9bb61e@gmail.com>
Date: Tue, 8 Sep 2026 08:18:25 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, miro.kropacek@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Geert,

On 7/09/26 20:38, Geert Uytterhoeven wrote:
> Hi Michael,
>
> CC linux-m68k
>
> On Sun, 6 Sept 2026 at 03:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 27.08.2026 um 21:39 schrieb Linmao Li:
>>> The SuperBlitter operations derive an integer byte count per pixel.  The
>>> accelerated fill path handles only one-, two- and four-byte pixels.
>>> However, the operations are currently installed for every external
>>> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
>>> truecolor modes accepted by the external video parser.
>>>
>>> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
>>> nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
>>> incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
>>> despite advancing addresses by three bytes per pixel.  These cases can
>>> corrupt the framebuffer beyond the requested rectangle.
>> I believe 24 bpp mode can be rescued using something like this (entirely
>> untested):
>>
>> --- a/drivers/video/fbdev/atafb.c
>> +++ b/drivers/video/fbdev/atafb.c
>> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
>>           case 2:
>>                   memset16((u16 *)line, pix, rect->width);
>>                   break;
>> +       case 3:
>> +               memset(line, pix, ((rect->width * bytespp) % 4));
>> +               line += ((rect->width * bytespp) % 4);
>> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
> This uses unaligned writes for the largest part.
> You can avoid that by doing the memset32() first.

True enough (iff line happens to be aligned, which is only true if 
rect->dx is even).

But as Miro pointed out, 24 bpp can't actually be used (and without TOS 
setting such a mode before Linux boot, it can't ever happen).

Cheers,

     Michael


>
>> +               break;
>>           default:
>>                   memset32((u32 *)line, pix, rect->width);
>>                   break;
>>
>> Can't test this on hardware, and would need Miro to confirm it works as
>> intended.
>>
>>> Enable the SuperBlitter operations only for the layouts they implement:
>>> 8-bpp packed pixels and 16/32-bpp truecolor.  Keep the existing software
>>> operations for all other external formats.
>>>
>>> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
>>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>>> ---
>>>   drivers/video/fbdev/atafb.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>>> index 5bca34c45cef3..c3011b61a94b9 100644
>>> --- a/drivers/video/fbdev/atafb.c
>>> +++ b/drivers/video/fbdev/atafb.c
>>> @@ -3360,7 +3360,11 @@ static int __init atafb_probe(struct platform_device *pdev)
>>>                memset (screen_base, 0, external_len);
>>>
>>>                /* framebuffer in SV RAM: enable the SuperBlitter */
>>> -             if (external_addr >= 0xa0000000) {
>>> +             if (external_addr >= 0xa0000000 &&
>>> +                 ((external_pmode == FB_TYPE_PACKED_PIXELS &&
>>> +                   external_depth == 8) ||
>>> +                  (external_pmode == -1 &&
>>> +                   (external_depth == 16 || external_depth == 32)))) {
>>>                        svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
>>>                        if (svblit_regs) {
>>>                                svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
>>>
>> Otherwise, LGTM.
>>
>> @Geert: can you remember if pixel format or bit depth of an external
>> framebuffer can be changed at runtime using fbset??
> I am no Atari expert, but IIRC all external framebuffers rely on
> being fully set-up before Linux boots?
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
