Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E6C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3BF10E501;
	Mon,  7 Sep 2026 20:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX6kWwTy";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5B510E501
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:14:13 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso2561021a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788812053; x=1789416853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MhNwMmgT5IoqPKbTajdZzif3txtKsi05HtP3StDpTm4=;
 b=lX6kWwTyWpQ5Sfqu/vOezpFjQmhyHL7Mbs3uk6bXxD+kPvU/AVFjHTzeR87bJsqEPq
 L+7q80EdMd42j52hA7o7KO/5M7nokfw6b06aC2koiABSOueHAVoJxnIs+nlEftdTl2LH
 KZ3nGM7SoZw4bLjG56QA97TD5qpH1trqxugwsLC0hDkJLgRqwm1psxgEeHi489BtXlkO
 lQSv/Il87CIXnZNwwDGv+zqEooJX+T7OFusogn0Eb9r+oH0d4LGYP7veDCYziC7nwDP1
 NX+QUe3qThQUU3WZwyoVoMPPY4MQxCD5eWV9DeIU2f1Kz2ibz7IO+Spu71Hs/M3KSY/+
 G6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788812053; x=1789416853;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MhNwMmgT5IoqPKbTajdZzif3txtKsi05HtP3StDpTm4=;
 b=ZamOfO62HCGfXSzpz+uOErIJRiUpZ1SzDTERDICnTLhPms8jWG4id1knvGsZAC2c4v
 twLdXhFg9ylRD2IWNLsLe7xVAztqlCgD9v+DuZ5KZW3/+S6st6xOtyPd1ONupdFXOk2g
 fw28q3/PI9LAOYlPhVm4XgaQfxQNHIZnFqHAFVYTuFfgSaNGC4AtcVAnLfhMheFvHMF7
 VoYNTmxJV+3y+6H94Ne0QFCdZWbkDeeFV7kBA+BouFZLjo/hwIQ2abK8i3HiJpw9aJSk
 nWe1bD6l4vPnbfLrTrEkscaQPj9MNUjoYCTJmlWvGuiefS/5HJDOMZvmEuz3ALlHSRVK
 CzmA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEu/Ku4iDgKqFyBRILt9XUruQ8Oqih7Fbe3/KVRVpFhnOKCBMDrU1QXcQCwIMKknT9gISee8ZBjVY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwFyoto0OCjgRCiUJAmX5ciUbTWI2zfhcCCZ/4kifQZN8YabsT
 pLe2qnSbNEmWwgYjGdjTx8pKD6CePG7NLZ8w06gtJ3+oyxEi1wMorhM7
X-Gm-Gg: AYBFou3WTog6c/lYyNMqF1XMYotMGVWIXhQC+/gb/iaYaXg3Ww0UQsJFadpLP2FPqzZ
 EFBaN3T3D0zjYPPC8JMhgJHLJzO5OgclhS5YY1489ZAZp1v1UE+tDwhlB0u1WZj+OTLL5A2ZAsE
 YfB/kCJvCbDWhXViKMspixA8Jis8GaIUxPPhtrtQ3yQQY6BIxwpVKIrIyAk4PDRrzh/8TIG1wS6
 7vHa5W+L+aKuesVjjJPXq1CNhTwQZhExNHlbaEYVnzbybvnC278pas5ggIyKTmLmfhk62ogxgWU
 QQc6hl1zwYcCrjDJcAo3ROEp6nCfmlwsHzq7c5xTFQuvFSbC2aXD5zcIjTKwNl8+vMwXTGtOUhQ
 /7Jc5PiRx8/jgXKd9gYBebieCOyyDtkebh96J6hFVIGJTiopOw3uEVFRvER5aurjrtEj0JwvqmM
 gQxeHDCXW+B+8tvfQ7gd/20bXEBkyAGjkJ+6Fvx0YiGui719HlS8rbKA0/jMq8WyRINWT9P08WF
 3BQN0OtDbdcJSvS/cisaA67XXEfESv16qMx1AYOpb9GY71MAb8ASlFstrQan6RXAuUXML/sUM0z
X-Received: by 2002:a05:6a20:c896:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3da39f47dd4mr42511514637.8.1788812052990; 
 Mon, 07 Sep 2026 13:14:12 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:e5ea:1a30:7c29:cd76?
 ([2001:df0:0:200c:e5ea:1a30:7c29:cd76])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa31b24sm29604849eec.13.2026.09.07.13.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 13:14:12 -0700 (PDT)
Message-ID: <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
Date: Tue, 8 Sep 2026 08:14:05 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
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

Hi Miro,

On 7/09/26 23:14, Miro Kropáček wrote:
> Hi Linmao, hi Michael,
>
> On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Hi Linmao,
>>
>> thanks for your patch!
>>
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
>> +               break;
>>           default:
>>                   memset32((u32 *)line, pix, rect->width);
>>                   break;
>>
>> Can't test this on hardware, and would need Miro to confirm it works as
>> intended.
> Linmao's patch: I ran it on a Falcon with SuperVidel at
> 1920x1080x32bpp, all good.
>
> Michael's 24bpp fill: I cannot test it because the SuperVidel has no
> 24bpp video mode. It was planned but never implemented. Its mode
> register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
> and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
> remaining code reserved - and TOS offers no 24bpp mode to set.
Without a 24 bpp mode, the 24 bpp fill is pointless, so no point trying 
to keep that mode alive.
> Unless I overlooked something, the fill also looks wrong on paper: the
> first line is filled with a repeated byte and then with repeated
> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> pattern unless all three bytes are equal.

You're correct - we'd need a memset24() to account for that. Without 
hardware support this is an academic exercise that I don't have time for :-)

> On the fbset question: no, the pixel format, depth and geometry of an
> external framebuffer cannot be changed at runtime here. fbset -depth
> 16 and fbset -xres 1024 -yres 768 both return success and change
> nothing, because ext_decode_var() only validates against the values
> from the boot argument, ext_encode_var() re-derives every field from
> the external_* globals and ext_set_par() is empty. Only a reboot with
> a different atafb:external: argument changes the mode.

All good then - do you need my Acked-by for Linmao's patch, Helge?

Cheers,

Michael

