Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EADC44512
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 08:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D4010E02A;
	Sun, 19 Jul 2026 08:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PkcrM5GP";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C17210E02A
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 08:01:14 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso961839a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 01:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784448072; cv=none;
 d=google.com; s=arc-20260327;
 b=B2blET1Fu0V5ISWNW3VbouuiGgF9ITCFgOkWtswlEJbT/SkMwnXTXitRdf9Iar65ed
 9+3u32bmJk5B28BCkN5lYrcfjhoythLXnPjMgZHsTuCcSmVgrNJcjxJbOMCcxNB9aTpl
 ruxREkdi5EI6KjXSlIDsEoetWCBwuZZgPYf7wu95Np+EPfNnK0v8rut5EZ5R1M+0ZhvW
 +Q97uCeVBJyhNrLBS3qKdb+hZir/xHby65h4CovAbdGkWJ0+xO3G+aFYRdABHVVvGIgG
 FKEOBYuTRGDRhhHwjPDIBHh9MGggR/b9BVoVbtBdN7RoGd1F4TblBBUzuNg0TdzZHLN7
 pX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
 fh=9WSj45kn9FQ0ZOKDxY1AwCekwRvpSpu/oha4/OKvoUM=;
 b=KaS2riISAwVXOWqoXhKm9pAbS3HXW0v+DMzPLy736TY94zi2txsXXw+ji4oROlVpel
 0nD5w5HHRCpmq8stWxAOX5HXP1fecAQy+Kken9Oi9mlY4CQVbJU9D0bx5xHycsY7gGl3
 qRFSA99Do7NNM8SCDBWM/8wskNmH32uLZHv7vSdLs8AFKHXnkkoaaqN3RKr9H7own7VZ
 W48/AAMHMWkjvEaI5M100mZzKuF5nSio1jyryp+5Df6Jw5lopjZS6NhrkE0ZBjcsWmSJ
 HWfxFyj/K6hVdFudDoVF1Y8OUxUeW/zm7P5Gze3X8vhqHntEpgOZnI0DvN72zS8o1tRU
 AFjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784448072; x=1785052872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
 b=PkcrM5GPPuvLB6CB3ELWIFvnpGAhanPOU2gYgu0hM2u82xkda9L/al9Akp8nM9GZeu
 hGLS3QPP/fiHJqcWPMR6OCxGRCq0yM68JOTGZFn3mec37pyIsvT9+/UDoilGYfc5UBoJ
 vnYiH+31DAHenKyMfZONmdrIfI+3UVmD6rUjyXs/UGstN2YtORZ//JUNG2G0Eg6TfJ5G
 xEbDfUar9rpQNH1DJBenG2ikKYN21msl5teBgVe/dy+9SuXoDQMQSz02So3DC8+Iyx83
 lrxdHdCCHMMIabsZeJ0j2Q1BpGdUqw0mCc3zc8wMzBsXsw5osogwV8dzU0afkYV1W2ba
 BtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784448072; x=1785052872;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
 b=BCNd3lXezaZPXWswRbZmMx554gIQx7RXoKoB1Q27OWEUhMHkT3oAK4qU8oGUMPjaq6
 UJ0Obi9I1aWMLo5pdOzwD/iMj60LT5rWOAYqFXeqxfvKUDnA2ZtzInQpoZgjN1sdj1d8
 4/pokwINCwiuM43lvp4Is2xS3X2B6ClOmirQFWOw+7H8THZEb7pXi1k+1bMwhhp1p5bk
 wwfgihg6FBo7r3XLrSRpdCM7kSYYwKsWYsv52GZmzyfume2MaH04zft3Qo0dsfdmOHUp
 XIaA481zN6mvyOQcHhuKGUhieb4czZSZQzbVNUc+yRTgskbu3DhvfKiDkjECtLMfw/wW
 1ZEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0g/zzJuPC3OqGhHPkj6yhCIl+dP1RbRHqmIibHlX52B6mEyk+cJqrV7mckpTvxbO97+2FXdSn1k0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQk9WHk2JJ9mpY14VgZojXxIYh0MA7krILAFRW1cxcnptwRHkF
 StWEVD8cTQqM36RMuzsbq3FxvUo2Zs+zaEVUFQpTD60RF5AwgnzGcn7iyzVGholtIGhMCAfBSe6
 OkM7fdr1yAHTZDg/5Dnfwul1+qQhjBiQ=
X-Gm-Gg: AfdE7clGZL6mwz0Ub6OBbwVMA50u3BwYkqgIGTOhDgX54FfbWXXxHOhNz/rxlvJdGc8
 q+ubN9DvBPd9qDyeLsC1zkDkrNAE2DWhZ4zGUe8MtE0eM8Y/UOleEC8eRPo2iRdwixVdWpy7UUp
 3mE6Q2r5uJ3ifYNpJSlm3jCV74lYjNjiFYpmiq4S7JBMBWm8NMM8hOdq4DtuNfpvgC/zWQOHaZ8
 3KgWM+K8TYQ7Us7IBy+oK894Wfm3Mm9I212qi6GyJhsgKQNSw+CsrXIsqNo85Cid4eogF+YPfGc
 Xh8XT0kO8mn85FuiNo0x4KUELzZYC2Aio+wNXPjyIEynL7znJ2ddHBOQ7e4b3H4A06GWtATKJdy
 EBAwvQgeZoMGQg1n0Ib5RLmnd80byOVdaTpG3HwbSQs3amarYBR1h2MulXw==
X-Received: by 2002:a17:907:741:b0:c14:816a:156a with SMTP id
 a640c23a62f3a-c16b476855fmr384738266b.43.1784448072255; Sun, 19 Jul 2026
 01:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
In-Reply-To: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 19 Jul 2026 11:00:36 +0300
X-Gm-Features: AUfX_myg58yoFCRBGSgVX-lgudzYthoirm_XN3vbryoytwu4PunHn8W5YCPfrL8
Message-ID: <CAHp75VczCz8_=g8-is=gq+fkzcGbtf5Co1J7wH=M3+nkKzqo9g@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
To: Shivesh <chanelshivesh@gmail.com>
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

On Sat, Jul 18, 2026 at 9:23=E2=80=AFPM Shivesh <chanelshivesh@gmail.com> w=
rote:
>
> From 7e9684b26176644bc92c2285acc7444f3f7ddb4d Mon Sep 17 00:00:00 2001
> From: Shivesh <chanelshivesh@gmail.com>
> Date: Sat, 18 Jul 2026 18:08:04 +0000
> Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
>
> Fix space-related checkpatch errors in macro invocations. When the
> modifier argument is empty, remove the trailing comma to avoid
> 'space required after comma' and 'space prohibited before close
> parenthesis' conflicting errors.

Format of the sending the patch is wrong, and you even haven't
compiled the code. NAK.


--=20
With Best Regards,
Andy Shevchenko
