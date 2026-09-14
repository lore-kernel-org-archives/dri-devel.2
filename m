Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B9BC88E65
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D974010E0F1;
	Mon, 14 Sep 2026 10:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHOqE33V";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511610E0F1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:58:08 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so555636766b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789383487; cv=none;
 d=google.com; s=arc-20260327;
 b=RrqNe6AmztfslLAPQCHAoMHoaD0x4Dtbbb5YYtWuZ5ifxnHzT+0wCvGQEL9eNII+rk
 uEKXMrbqjBZvusyvBkRwwAihxYigdgckSdBButPDJ1dRJthQZrvE/00egKVbhc4trpuy
 AcCtH9IX+jYZqv991giKPQccpw0Zo7pUuTVPKUjWBAOAcDj8hNBCtqv16k4q1L6uL7xf
 G8CYc3zsqcmhB+4gx/Tr89IjVApQviXPpYboVMMu7G9gfPBCf5ExsEf8YH3UnP4dKbCs
 b3j+21sWIqlNxrXely1mB5CpvZ0QgqD3ptgzUaBAvkwie69peDAa29y8mViL3XK3fDqC
 D53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
 fh=6vpoglXxPwCVlPaAmhXSFuxtcoSyVmvtsfJJCY/wCm0=;
 b=Ajc4sWo9128aE+8C7YRhV1hlGfJSlFf/jMW36USrydHHJ3rMP9NbxbV+DdFH5t44+E
 YH12b36cU+26k6dqE0OdGo8LLh7C5m6jssBbaNMCqEKTIOSXgOw+xxC0qW2m2edLdVi5
 8YWtWILRDQMDmENj1NOo9wwxJLVD+ffNLHjMhh/Pzh9g0ATOtZ5u0r/NG82g8yHAhctn
 67j4XXFCnzQ/BuNBPf7ztZ2sTvwMbC1V0Vy+lmlCAzdn1TCnAQTLY1AdNFXN4zANXBNZ
 646nKqkIqTVAYxFDMPP5jwXewcT1/+Haj9yLXYKmrWTV0ELtdEUByfQTgt5G5jHU8D5M
 0SZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789383487; x=1789988287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
 b=tHOqE33V1n97yNhbwKDP7vZQfWvZG7V89RtjkkrIkIsG01RIdSYBgpwIHzJKRYXIka
 ISZlM6+K8PHLIy33126jbuPJ4lxZ18WqC1yLPg5oYdnWL/UHCcSyPQn0sHwrcG0CRAd0
 wqDY7WFMC6bTDmkP9KTKqXRtkOdSDGBBLkP4jwgjE2YSZ98xwxAqw+peksdy3/s3mXJU
 RBYqPoSSjD783mixUwX74qKA1yVECHG0w3puqMaEgSPcw5yD9QqInBPAajr2CQW6/+F0
 m4ZJXIKRHserL6n2XQ9ZH8OPL/4Jjm0Baxl85o+DkDB63BQrUYN+rRsbvr7zy6ao4oqG
 1tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383487; x=1789988287;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
 b=JlyhKd3lxuyoChq5vnUJEblbjyBP7A3GjHfj9Ud8Mrdwa0ISHxps8QamvQlPMHE1I2
 VQ1osa//P2TaQLdw7nSP1+1Dx9XHgGaJXWUsknuSNNfytbS5jDzkep/UFRjqcT6a7DLz
 HbX+Ff514pBEm16FlBdFHaPfno4errWitR1FtvPm9YvQKjamDKvtN/ZrUWDENstzlZ1X
 9ua2Sc+YGWKSnx41r8wb6bjSyCGTqSSys4bf3duLB2iiMnJm7kpTD1061xR6Ds8IfCHY
 ViuHRExF7cW6NQDMGS3BOxuZuPfiiPWkBCe6jot53quTWXGQh+H1aqb7CzoQrspTgyck
 xsZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxa1pHdIAYHfINcqUFOlX/PxSqhtCRRJCkPuG3kV1Nu13+jf8kJUNl6F6Sraev2HWYFELhr5LZ3cuQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lABeAvYOWRabMLebRVjScd4mvG+qZNIZ7pnAcF2rhzUYyyLLgj
 s/LEPAArm7+PwkFp/TslWUlYD74kOqXvBDl77Y48SRD47CApw+TQ3Kc63zFZQRG/5Bo3bBY4Xds
 jKNOziE9/8qRkkEvpgDHjXe03l4GcJLw=
X-Gm-Gg: AYBFou1peFUd2N4L9fgIAgbNo5jIfXQGQXQ8+ovS6HtLr8cCPE9979AwYjRmCjIOXr6
 9+99D8IYGMQtpvUER+AYAoI5qFeppmfVAjdF9JgmPXq9fQf5BNwPzk1xiFOKBhIU2ZBDOHOta8+
 GwEg19CnGlg7SHqAfFcCJ+qES2AreffbrxZNeQq1Q/Jf/H8g9eghIl7eONcGa6wPASoMMlZACBE
 WMzfmtOfRcHArH5xK6Jh25q2R80KU/yLT1YnarUB/5clH4c2hYFTyyNsSFCexl6rKMdSx8wxQiZ
 /HYhD9x9EOE/ZDKYSkjju+kgPoQ8Vb9IDC7BNs3kaw3wGURd8RrETlv69BM3j68/Aj6zPQo2rqa
 RAy24c0OsjAcAoSKUIJIyjh1tpwNvv3rz4QAf94JnsH0Ov/vO7HRAyilJZMjdk6m4HkkHd17nkW
 5y9nP2E2BdqX+7IyQNMUvdpIzEZjMiDfylGwFZNIWtRfTt+91M5/E=
X-Received: by 2002:a17:907:980c:b0:c29:45ad:7af7 with SMTP id
 a640c23a62f3a-c29b86ee829mr131881566b.30.1789383486731; Mon, 14 Sep 2026
 03:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260914090858.9939-2-manuelebnerli@mailbox.org>
In-Reply-To: <20260914090858.9939-2-manuelebnerli@mailbox.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Sep 2026 13:57:30 +0300
X-Gm-Features: AcwNN1UCS4c0mLENuPHDYDtqcMcsoOZID1y92p_Z79HcLzYNNZxrCUfwyzX99MA
Message-ID: <CAHp75VfApqZk6jz0TzQpm8H7qE08uqpJ44_dWdGLOcq8r+y-xQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace number with sizeof()
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Mon, Sep 14, 2026 at 12:09=E2=80=AFPM Manuel Ebner <manuelebnerli@mailbo=
x.org> wrote:
>
> Replace integer number with sizeof with the goal of prevent future trunca=
tion bugs.

preventing

>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

So far I see only a single patch, what are the "future truncation
bugs" you are talking about?

...

>  static unsigned int read_devicecode(struct fbtft_par *par)
>  {
> -       u8 rxbuf[8] =3D {0, };
> +       u8 rxbuf[sizeof(u64)] =3D {0, };

This is an unclear change. Where did u64 come from? Why do we even
need a 8-byte buffer when we only do 4-byte operations?

>         write_reg(par, 0x0000);
>         par->fbtftops.read(par, rxbuf, 4);

Perhaps you need to read a datasheet for this panel and come up with a
better understanding?

--=20
With Best Regards,
Andy Shevchenko
