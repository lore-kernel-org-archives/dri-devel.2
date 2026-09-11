Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB033C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 04:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E555610E321;
	Fri, 11 Sep 2026 04:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VU4pWfg0";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EE910E321
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 04:53:27 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so515235a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 21:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789102407; x=1789707207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mT2sfmz7zRKsiFELeDn6nFddteQ3mqhWB3TM2IakbMI=;
 b=VU4pWfg0jGXSD8UgDxQE3K6RlMfPuCyG3FyfMHTYhm24bgC2Uljew2oD2AM5bgKoYt
 5Q0zawdH7RsDdtpZ0FZdVUELIaiqmVdciCUkldPk9KVKcsONL2H5qcW9EOQypNThBTU8
 UVMERWfgobTmCij1+lO9Y3gDsMaHuwU6O3z/9L7q4A5HcfwGomREjFs0uOXts5rr9PaE
 nMscaM9zj2kv1QnwwbPxCJSrrp/TTRx2zqh5nqUvc20gmEjGl5bXeX4v/NRfbEfEu9sA
 9p08tINf4mk5yyH90xdc//mHffo4QnWEnXnqxPuCqQ8pNCH1jfpatwyhbfv6idTBU5QN
 yvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789102407; x=1789707207;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mT2sfmz7zRKsiFELeDn6nFddteQ3mqhWB3TM2IakbMI=;
 b=CZwUyPHsOY1A6brAGVOi19Ls/D3JPGNDadi1pshSiug51taLrc9suuY6YpENf8yRhW
 vqZFs1v4BoLf376fwFk8bHNYg+bLTEpcmQWbM5THRnGAgOHt7T+LBpw9Lntrkv6legPs
 TGmZzJvHoCWS3k8mhnaXyNzrWbvBwIe+peKvJI87rQQwF0pebnwp1xaXHa6hfSDa40DQ
 RjjKHyeDZOYFfo9f1ubfOaLyxuagOxNDLPDumzbimT2hmrIcxZtlHDaOh8KQWHe+6a2N
 /j+UGUQkDovU/UaNnE112RDYSuGB7Y/+mZHM5QiqVb6G0tMc8MVAFWiJBifdyCFnn7t4
 5XKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxipoyqebihhso0ylWkBm27U2J8dervlVduxjfVAkxThBjl79rigJM1LjBe/1Pb7o6RUCro4G9QNQ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXw3eIbZZ/NBA+4Qr1VvCjbzlmJhhngpjMUpKufdV7rMwdLYs4
 M+y0btt+gE6gJ73LvbNVSbKsc9Awt0LlHV3DmSEkCrEBLbkNvdZCc58N
X-Gm-Gg: AYBFou07IISVXNS6SjgvGLVsBRsIOfBj5e9ABz2zKu/fKg/T4Fof2V0nOVvS6tFZlll
 +MxilSg/Elmp5XPayk88fqgCVu1eT9ZgQEl6T5N37SQGtoNM7Fjk6jtdtorXPFCOpDKkcf4xfrY
 MwMutQgotwTt0Cjcu828Hsy42ilIuL8/ZzQ4rCvR28D2jWs8TVOfh9pvCpcDW4SQoxcuqfMb6EZ
 WtIK7mLkKSErbwGIYTOOMF5MP2hUrrd3MQC6+5Kd3GMRBaqcHDVpp7Wz/sUWRW91DgeADuYSLZ6
 FtGq4riW5pYqJRAPS3MMk0ckZYpMK0thNI79c96ZFe8WbmUsRMQrrLxB73coDPqTlYmwrtmfIHJ
 25qFKRIIrcRVuks/u8zKVy2+fODC2ibwhqUPD668rKBnG/vJ7dP0GdEbX92l+E+x9Jtzs8nPXqg
 1NcteG+3xYhQCDDz7XG/fgWe9SYOC0qHL8DGXBhkGf2YFDqV6OkQo9GbEJd7zfJOAXi18q6RdNa
 KAagomSSKaKe8AhHFufw5iwyJ7384c=
X-Received: by 2002:a17:90b:1c8b:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-39d9c38fa48mr3710302a91.22.1789102406694; 
 Thu, 10 Sep 2026 21:53:26 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz.
 [122.59.250.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm2884821a91.8.2026.09.10.21.53.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2026 21:53:26 -0700 (PDT)
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>,
 Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
Date: Fri, 11 Sep 2026 16:53:16 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hi Geert,

Am 08.09.2026 um 19:18 schrieb Geert Uytterhoeven:
>>> Unless I overlooked something, the fill also looks wrong on paper: the
>>> first line is filled with a repeated byte and then with repeated
>>> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
>>> pattern unless all three bytes are equal.
>>
>> You're correct - we'd need a memset24() to account for that. Without
>
> Unless the frame buffer would be using a DIRECT_COLOR visual (which
> is not the case), then you could draw pixels in the 16 console colors
> by replicating the color index in all 3 bytes ;-)

Sorry, I don't get that - are the console colors chosen judiciously to 
allow for that?

>> hardware support this is an academic exercise that I don't have time for :-)
>
> True. And as this code is used only to fill the first line (the blitter
> replicates it into the other lines), the performance difference between
> a simple byte loop and a true memset24() won't be that large.

I wasn't worried about performance as the blitter takes care of most of 
the work (though we may schedule away from svblit_fillrect() while the 
blitter is active). Getting the 'simple byte loop' right is more 
important. My sample code got everything wrong in fact.

There's a reason why we don't work with 24 bit sized objects usually, 
and probably a reason why 24 bpp was never implemented for the 
SuperVidel :-)

Cheers,

	Michael

>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
