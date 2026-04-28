Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59EFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0611F10E0C5;
	Tue, 28 Apr 2026 09:33:18 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5480610E0C5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:33:16 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-678a526f374so7381431a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 02:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368795; x=1777973595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
 b=OrBJja+CLFMrCYofIpQAVNvW4yXzQW2VmVOSJIndz0o69dK0Fkj1DqKarvlGgBZSuQ
 daU9Sn9rlP1Su0BBJ4RuiJB6HUJdqGfzw4STA2jhBtVxOk1k68H69hmQz0Rq4soLtqyw
 HJkk4hlR8PXhs+U+pLrc1Hqyd8C8o/V1+3ncV7UBVZ8NRz5a8CAY90K7P6+vr2f/sIKf
 5hR6HsEBID/LkEf6zGLR7+NAWBlCjtapgQrLnjiG2kOFtnZuPnhYWdF3mMqr53LIg5yD
 aGYaF3mWArnPE0EcgcH+izsTZO7qaEYjoMWPBsy3CrCuwtTZED+XEMh5cJ3c865TGYgd
 GSkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90F5sTtlSb/t52CQiu/YD+9a8zcPZdQE72jv+sv8ew3/di6IlZdEpXRvri6wWHsaC5xG3Us00zQu0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyykrSip+bGvqBM6tN9TPc6OWXdgrL/crDFhkRA4PgDqJAnX6lY
 jHBsBWWCI6KozEcf+DG/ylAXXdlm3AHRiQDV3Ji/Ntnpox4q7u7Xy/fZRdAxuath7lY=
X-Gm-Gg: AeBDieuPsqccO60/cgJ96C0zwTu6/v7F8XpH8NL1MDFw2ZeHRNktLWFgqvC2ujuezxI
 q4ZGXgawSDmqbLEAQ465AfPANRbYsBfiUR8PR0CJs8IIl7apwFw8i7rNRUtB1cECs30Y6QqMPxI
 Vpfpkix9vIWi4GU1RU1t6dYExOdAJoQcv5iRCOExRbrAjz/8aZ2RyZlMpfS+8IlyGneqmsxJiPU
 xGF8wW6e9MsT4nla/pjblEAWFEfu47pLkfFFRlTBD1M+sIq4XYAp8LMrthCmTszUUFzTmau2W1i
 scVLqQgncq/hfjoRxawcJ//9jJg2CEEzfr6TicUgw9lHyIK9vYOHHxNr7bY8JtL3JO18BU6TjKY
 1PqwZ5w2rOBrqcZ6309se4QnFPwoMLow70eEhtjaPNayTVt0a6Il3gYNaVlJnYYOv7STd6BvGvJ
 P6axs+SkJnf7lAy+9HIcafYULvn5rV4Hwfp6aFrJci0ViPPGF97pupVMzfVZ2e7Svhc7L/GQFjM
 g4BnJszSQ==
X-Received: by 2002:a17:906:f588:b0:baa:1d9:66ff with SMTP id
 a640c23a62f3a-bb802da69dbmr155463666b.20.1777368794564; 
 Tue, 28 Apr 2026 02:33:14 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com.
 [209.85.208.52]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-679b67ccc30sm528373a12.1.2026.04.28.02.33.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 02:33:14 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-678a526f374so7381391a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 02:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8UDxPVYbRruyQmDYsjS/hihuKyvGI1IKzrLE1bgpAahqE8BN82bzj5YhYt6JekMvMmK23u4+ocCaM=@lists.freedesktop.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce
 copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
