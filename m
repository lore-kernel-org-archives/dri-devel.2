Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5DDCDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF9410E080;
	Wed, 24 Jun 2026 14:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWnW7SVa";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325EE10E080
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:03:09 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30bb87c90deso164472eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 07:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309788; cv=none;
 d=google.com; s=arc-20240605;
 b=a4RLR9qKoTjsUyyqJhSoVcioSHqRhLoCCj0zZ6DvTKZ5s8e/Xm0mkOXf0r9EjzfJOi
 zBiO8bOk0Fv4EZoUM0vkqYhF1hzcAEo1kWSx7dKaPawjASa8qog357t0FWd710cPbxgG
 hlYEAUzX2WcxCk5FkWuqags5HRlOSRSnNu3p99yRN8hLALKzgyapG6s1dn4RnnR1aZaN
 L+ajmeJKXUSEdkxKRHucAcIjQX58qIXvKbjok2SkDh/NW1wvRiXuwnneO3ippUhCKNYX
 8oxBXcR7yjDkvj0O2p6otI/zxkjlxwO6ovfJL8yQnghr/JU4fhJJYpfJnI+A1aNS19Ua
 hb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
 fh=kird9WC5MkQZgRkYKFJhJRUiMkmXep7nWi78pceoIbI=;
 b=SRFeeCLs2PupP/XI9SYUgtny2hi+RxdLxsFUX6PIdJDcAFqPsexrTynFZLEtAscX+V
 ZVIh2L3si5c1GG2FSeLN/jiNzcGomJHOWm0CgEJiSVlLg7ryezrGHoSws6Bfupri7jX/
 3rqKFJur+tAcmZpOUav4PsQ7nvvXbbGED4CBHEYV0EN2U8QPku2a3ppeCo0L+DDjkEc7
 qqrMzJ5j0Xvpy2g7aVZJMBKWmd51Z2qErz9x8z6/iD2a6EEF+kANBeSUo9niWLG2XKAd
 wFwTUerlaW6GEI90kQLjw2HSgQkxVfjmpUwIBPOHAjOCyArOWmIFBfnvq9Zd50+ZDA6p
 6orA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782309788; x=1782914588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
 b=RWnW7SVa0KjDzboUKIA/GaDba8/Dj9pMbjSicpJZq+MWfYX+JQCKt0MpDyTkpz3Lum
 6PSJToVY10uPZwvij7m9t45FjeTf4Rok1QdQ0luJjpZkErhpvHx75eaaAvIXQSiRxVDK
 KcFG7tzlXZD1eGyGFxl5aKBEMssUmvw6fLuL7DykundOXkhbNeYP9LV9D6xoMPup/0Op
 F3s4Izy/IZsNUOR6Ba3Zzfjk5u5bFjwce7tIrRfdh52rzti653YUMty8Bq+pMpMrZFvA
 H/MsLLrIRMJnWPErWmcplaqLg3JmrwDBOMrFaja8KLH4j2zMEZ2tpSYCDapNkdMoj4Ig
 TnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782309788; x=1782914588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
 b=V4lVbqe679dmIj5aQWaQs6vVXvxuTyOFrb2ep6Yui07H9Wa+PgfSkKSIzp5AhN78vF
 l8lniSxf5kjuqC62JQrggcC0mZFRwtPtdkx3Q19Jg6WXQzxNRHDWiuRfCjEqtUfU579R
 2oyJOrQqftF22qaINCrJCT/PESfvgwxaMimgIjgHm1FGM4cflbyLSfdN05+TJYM14bze
 ToP0hXW77Wi7TcrW/a9YtQgPVvN0Mq+cMyhePSKcuzaguh3SNnohhTUTwwEfRp0+gdw8
 mH63qtN6i3IA9FFr3ZUaGstH6ThLvI+9xpva1seDjdwOmMZvOpK6rxi+J0ZLLiTx+UAD
 Ddsg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp53Xj16BYhjDG+Wojzobi+iXT0xtTNx+SxBSCTRXGYfQ/2w+ieoYkx3vkuCpg3buXoIG8gt6b5W88=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiyVzVpHbTxPFXnd5ZwkCnAq+PWX76qkJjBHtVh4Ns5GUykHeE
 grIp+oP7Xu9bBd8B8ilR9SxIbBPLaC/wc+HTOGaVOitmbDL58oqVDt8QCjtpiMVxv1N1EKoabBX
 q+f2MwCPGOcA4qrjbq9EtU3Gges8UxfQ=
X-Gm-Gg: AfdE7clHF78YsgTcvxSnDGb3MugeexIOEtwxjKBiG2ovIyMjqTHc8xuhG/Mr7os3ezZ
 T2FW35m6tuiMMgRmeLF4huu8LqHtuJcovXGmtq0Hp2Kkhf2GDPT5aZXwfcov8Hh4ShsXBEGD0TR
 DJbVmpkjw0hMahnSlkPMy9alDJqmgG1vcNfJYC4E1I9YPbsFv7fKFF5XhTNC9x1ZW6BYYYd1OWb
 950yMehO76WQKNmLCwSkshllp68k/YS/ei8JFMOebh5fiGFEp42UfH0CHYUgLpmdVxE4D+fUxbm
 NNXzMKgF5xVkX29ufQzA6ZuLX6RBpmCEcSzTP13e9fSwg3KvWaXzdVkiJKRsP4k4FrCuBg8DkC+
 sXoMA3C6wJ5ab
X-Received: by 2002:a05:7301:658a:b0:30b:c8bb:588f with SMTP id
 5a478bee46e88-30c5240f7damr3538472eec.5.1782309787929; Wed, 24 Jun 2026
 07:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
 <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
In-Reply-To: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jun 2026 16:02:53 +0200
X-Gm-Features: AVVi8CdZJD474qdF4GDgFLlfJ_vD8WsFaomaTI3YSRH6pluhcoRUR51gh_iz4VE
Message-ID: <CANiq72m_LakPxHt99+3eBn2rXokr3vZbdJf=Wk-Yi8_ufQ2mvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Wed, Jun 24, 2026 at 3:23=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I would only suggest adding the new file rust/kernel/module.rs in
> patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
> similarly to the other module-related Rust code, so that the module
> maintainers are emailed when changes to this file are proposed. I think
> you can change the existing 'F: rust/kernel/module_param.rs' to
> 'F: rust/kernel/module*.rs'.

That would be great, yes -- thanks!

Cheers,
Miguel
