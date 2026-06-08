Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172D7CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530D510ED4E;
	Mon,  8 Jun 2026 06:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoFq7tYJ";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDE310ED4E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:07:57 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so2020881a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780898876; cv=none;
 d=google.com; s=arc-20240605;
 b=dRWqQHUNJoRD68Zpav0JVsqdyOfBQaWg/2CAsQWRiKybT3LboGiXaiSwRGiXeD/v5z
 7nzQoKKJI/56yqenKbeFBB84hb5VdhA0uijmnBYmhiPHnM46b6Tgv0hOlqjbc6GbCsWH
 yuqViHbXKsadbb5PDRIMjo1hqjC6wGeJCn9rbsaZl16Wg49bI+p9PumMnXEzLAdV+abY
 UPSl/MpB4JEoRONleKbM46Xki09Oe0atsQJri26rfLXw1o7CwuzinLvPGNUOBVMCnlgE
 rgGrnS1RxkTIzFQERTf18fUdIxr1YDFBkXqdMjxgZCrBEEJiQG7E8rhJ99lryVfuM5YB
 k6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
 fh=oR3PZ6REvNPsqdsoRvzNI+w5k/Qjiu3WQ1R2VIfFXBA=;
 b=TgxWak38VX2xO9q+2KpQPvZZyrScIcH5RNHjsfV5JKLU8AYu+l844+0rUGY90lzyxe
 iXIHlu8V3O2evLNyo2U0VMZ4FQoT2HG0LETGG2w++4Q9QfoKRxz39f8uidsXFZbP6peS
 ka9TBHWMerPz9szEkZGx9d1ZSRXH4u/ZIXxaUgoVTyEECjmDed4jIy5fKWdq0CLoMjLb
 01xuS5FKYLHFEI6R6xBXu9f6Q5EVd3qaGWYIuNg1Iqo2Nk39Jbu7SPVGdC3AvjGbPUPk
 AAnc4tBuO4gpFRdP3FnT/mFUbYUn5D1yKibZMVltr6yIDJI8cH+E/Qz7Dgee12TdWjwl
 7tqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780898876; x=1781503676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
 b=MoFq7tYJEew/s7XtE8ZidE/iVwWWo3QAbVJzyEG2/GEopTIFyaFyBOf7ZkmyWJkVsS
 dnLjIPJTyPBElfrz33R5rQtsCRP0WNPVUJaoHa4ha2+gObSrvdkxNaIM6AeNQaHGptxx
 xFCoX2ZlKDkKSsNUiNCF6xKhtbkAEmiYaflA9H242JQDuTYbgAUqe1gcAkLQmfKq33Uk
 bvZUWxQuO8QI2hVJOQgAK7SoeXy4wb7/0W16JR91GbjIQA/XfNqkv6tFhvZIzTzc98P8
 AQdG7Wu6P7Dhra508BAIr+s4U6xBEvL0XjZyXF+bHHLcP4VOnR4B42GMuib/NDkHwa8O
 WB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898876; x=1781503676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
 b=DhbxjGLx9qWrZ4/n/30lh33ep88r/EeuhUzKksR+W+NFmMuI50uajy4Kohj3KypJE9
 ScX4YJ4RYAEHxZTWleqCAg0s2HM/tyHpZZsH/P9Ie0bHXQENLlVDogo02sad4bjwKoK0
 nX++3OQ6zUPgeiIOe9lGqfgzDt36BFKTrCISVJfulRJcwsPXtb6lHlTI7eG9R9iv4B0H
 dsqqYzGgRgjr6ldqr9nBVmYpzXSc2iMmJ7rEioUVZoFA6hswelVkxTDFEY1Ir/jHo9e/
 hx3WEkf/uXJ6a6272P+mGCKURUmCay2uT3EOxoFMLIs52sFQFWpk1UJLLCF8M3dQ+Qpa
 DVxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SulRfbmOndb9pcIlN1iT2a2ovSkmKEgCd9ApJ7A7/Ii4NO5A4I1xEOIYvysRaCPd52/VovnHO8CM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEbrXK9/eJ2cFVCMtGdQDOJC3CS0SEhmaaoTgfBHRKgR1MPT30
 DXXFOXiMQASNt0DYY4B/x/CvodKQmS0kYfLLvyK60552BOD4HHBiYlzXV8bTb9YKwYmFLeEbC2x
 o3+LQAaQdMsf2abz5M5mY4kFaEkrD8ctgotj1f18=
X-Gm-Gg: Acq92OFoGLH+EPh1mgdvFf0b9UU3a3CAtEUB4r6Gcid5P717hoTwzRnTpZGmh2XhFsm
 ZSWVCcIXkGCw3KLgInj3j6DmAYeFZd8eGwWT6c1yhjJnV4XWmfVybYkwTt4d7M7BHKy/NmI+wrp
 WQvGxgFZ67ndEFxIqd7WjXVu/8w9RZlV6o3Z1Ghxdlcs6LI7WfIww+NB6AOHtkKMc/8bgPYoXiE
 D6S5K5PZqUZCBBNKWbz9EhBz8PHUSvQz0tG8vEYv153Nh21RFnUzfP60JX35N02hVPSQF2t2h2g
 ORjSNl4lMOhadx9rnAY3fN3Sb4gOBT8iPfiesQJ6Yu3BS6H6VxtZkq+PdwljHPmzzKGEqnme+4c
 klmaTDGgzmzGvcHzAThMTWpPR0suX2vgP19iKGcj0tDoW2V++CnNaBX97YpZRVx7n981Hoa6Umi
 /hJwo=
X-Received: by 2002:a17:906:8a62:b0:bea:a8c2:3d02 with SMTP id
 a640c23a62f3a-bf36fba1b5dmr514497466b.4.1780898875739; Sun, 07 Jun 2026
 23:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
In-Reply-To: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2026 09:07:19 +0300
X-Gm-Features: AVVi8CdSZ41x6EBhGrW-maqYqFvmYxaB5rlMq92vcxyr-Rwo3G25Posh805oQgQ
Message-ID: <CAHp75VfcrHn5R47PCDOoNnmLNbKA8sX3Jz9T-AoMSnbmqqyP1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: fbtft: fb_ra8875: prefer usleep_range over
 udelay
To: Georgii Druzhinin <ilovelinuxgames@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jun 7, 2026 at 11:17=E2=80=AFPM Georgii Druzhinin
<ilovelinuxgames@gmail.com> wrote:
>
> Replace udelay(100) with usleep_range(100, 120) to avoid busy-waiting
> and allow the scheduler to utilize the CPU during the delay.

Nice, now go to the lore.kernel.org mailing list archives and check
what was done previously on this and why none of the similar patches
have been applied so far. Also read README in the driver's folder.

--=20
With Best Regards,
Andy Shevchenko
