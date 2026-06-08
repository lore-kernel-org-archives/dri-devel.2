Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E2CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EE010ED51;
	Mon,  8 Jun 2026 06:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oAt/2tah";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE9310ED51
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:09:04 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bed4f2f0898so493441766b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780898943; cv=none;
 d=google.com; s=arc-20240605;
 b=QE+6ooXVl/rjEF8U4ydDoSfCUUBKxJWvzpXAP8THLtY9yH6ul3VQ71+H5c6OK8xHhx
 m8IA7oUsOIYZTKbeQAPX+2zLRWhcxt7hUdMGeZmNQTgfld5g/3+C5ztsnzHNaDoFlhxQ
 ovGX5PcN+UsBlooMO4jZIc9ajXmoL7OD7II7YLh0/uokQpmOr6LEdqmtrk2Xn4B/V4PR
 TjCm89Izm9nWaEpQPXQnR28xnH5NKJSAEKbfFJOpwSQad/wv3I0ZapGlWF932I355Bp7
 d2q0rHN+szelmGZHN8W6OhlAU5ejgn7aFgXgMY/MQ2XIVy8QyXn/87PhVo6ZqduB28zr
 o2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
 fh=E2gjLuLFv1SHyC/BrTDB4efU718pS+BO/LHHW4/eUdE=;
 b=LIYt6A4tV6mW+3MrwyyI934HsjI02qJYFdUCkz0UQ7FmWHwzMYHX7P4LEEBANkX/UY
 O09iywewNpCbCuPuaRRwwiMrHIoAkxEoZ4CldoHxnzCagihehVwrjSUfVUvyH/eXuG9U
 Q95lERkDV7371dZQqCPvj3j+dyMvNIaG7jspSidhK6C3tqSPE7NLJInKMACOGBr0cVzy
 8epK+WmRKS72ISrL/iWIxuugP7pLh+zaZBZP/BB+YNzNR6xBh/n295tZ5NOj5eJltxeF
 w326DcO1VgDP8I2BuNBtifkV9b99n+xY8We7qqzPhdSqivCfP6cFfO8miKjSK7AX3Yo5
 pT/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780898943; x=1781503743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
 b=oAt/2tahJZGdAEuBfDwHzqGfl2crrDBDE22aVMrrf6aPt7wEls+0qYpFHuMn5UPRbE
 S50k1RDuPxAcLtVUEtVeAprFLrnIHC5m3TF/OFqPYauMP43hIRdAm+0XaEolJVOSVO63
 YMZpWoF2Ey9R1eKG+99/mPsH1znzUt/61R45CprzwmtJzsMW4ocW0iptCWv5pAw0WFA+
 kqu34FCF9qVBpSudiu7JiG/mdtwh2up77Ggev9jzXLfTv1fvJoP3H5CCrDc2xNHNgTmI
 GI9E1ntnbyutooD7E2NBslAcPgMRu/sv4ezbnVDMFS03+sp2quFwriBocnS1CSiGnX31
 +A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898943; x=1781503743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8gi/wE5hjAq/hZ0xe+B37Cet1OR9dugn2vSBBancYOQ=;
 b=aOM2juTzMbO0RmssGlRayToDVHbhJIPPKDKeytBu7RJ/1PCor5HT99z3B1oNzXfDSd
 XPmNlr4B/4znfIzZ/ffit4ewMmYzbj28w3SiDIZA2yOC3TMopg4sKdR9KP18GQRzH4Tf
 wh7BS4B+3Xs/5GDA1p3ml/Z5foUJHwGHMJ2abQh+buVjOQLwGJo5VWHuaFuf0ZHrBfjV
 WM3+QRG7jGgnoLpn6NeCA3K7CZU3/mdL60KYZoPkpU7GVFbiNoBRXDvVyolgYfh+OEzh
 9fpU0aMkVAkj2nmoik7L6t3LvUxi+Wb3Vlyn9LH74HWxZcoXcKkf6qEfl7kcmyKjSXye
 beeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fhZ+bAWWHi/qHU0RnVFLKsfUOOCyrR1aeipz4Ac4/VYvNIFRv7xeO2s1ugrF7ecthWvp/FjMgHzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPLjRj/7nLw/7nkLfHPy/httNsXwqT6mLDhCgYc2ms19jFcZG9
 jEeAfpbrn0vZFySIkVjW0P3oNnPQxqjqqltIw3hYADYuV8CE5zriSYWJGYN1iq+YO6CeQ/6+aKV
 rUP0220rGrlk5mMw1aJaG5VpXmlf7Vwo=
X-Gm-Gg: Acq92OG6INPFaW/UsNGAD0eXkbIAIdK8OZChbzKNAE4F/gLeWDH4Evq6bD++I/I4ZCy
 iK19d7eWytyxIxWI66hAL6c9C1fOBuUNOhMpDI6Qkb6EDyv7AurSCUZufI/3fhJYikqKfdziXM9
 Oj2Ytbf+LWBXVEMLF/XUEiK2hlfW5SpV0Pe4cdIcCtKk/wD/NHi7mJSgpgYKHjdzKjwBzBRinnu
 iMb23FtfQ8kQYvtdToipe/A3/62yZ7tSMRF10qmlqNjexa6dElkfAyFgHkrul25NmXQF6iuFsPC
 3GYDx3rIx9K71YUnCvWdKZFQRWRg5OnKMVolo/hfnVe+co/A7YB1YHtluqLy5MRdQ7ynZGl8LN1
 XV/7K710DoWma2Nora1abBLwniodn/87VzO7kObBk2/Cw1K6awSKckEVwRax1lYhHeixNTIRMmX
 /t9qE=
X-Received: by 2002:a17:907:6e93:b0:be8:93c2:cbae with SMTP id
 a640c23a62f3a-bf3709666a1mr614698166b.19.1780898942969; Sun, 07 Jun 2026
 23:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
 <20260607201708.88644-2-ilovelinuxgames@gmail.com>
In-Reply-To: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2026 09:08:26 +0300
X-Gm-Features: AVVi8Cca4h6JLxFlP6kdGJ4g6L7zlZmMpERaiqBbVX1YCnn0IeyLuZTJiZG6xIU
Message-ID: <CAHp75VeNHCbiP5+YwLvWifzSF5FBD8aKBdz7rd4GAr=Y_i6fjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: fbtft: fbtft-bus: remove prohibited space
 before close parenthesis
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
> Fix checkpatch.pl error: "space prohibited before that close
> parenthesis ')'" by removing the empty argument and comma
> in define_fbtft_write_reg macro calls.

Please, learn C preprocessor and compile your stuff before submitting.
Also since you have a series of the patches it should have had a cover lett=
er.

--=20
With Best Regards,
Andy Shevchenko
