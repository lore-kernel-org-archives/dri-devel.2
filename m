Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175E2CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7451610E7E9;
	Wed, 27 May 2026 13:18:36 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BB410E7CE
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:18:32 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-57746f02da7so7713166e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887912; x=1780492712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MuSPc8y576tayBCaWdrNcab8/lH09ziazVq9lwM/2k=;
 b=IDZTnL4Ep1ugiTpnKeI33VcM9mjHPkCEmJJKQChvtDW3cTaCeKeHQpO/mdZdJwygb/
 1j7HXnzaT04XXur01V09FV20RvIEAwWq01ZMu+TFhYH2Up4kJVqHVdmyQgKCnZx281gB
 WgqBl2zqrLWUL1UYqi0pw9jFRA2xtFbVRKNvpIb6VQj4gXfAAYXp30npgUsK4JYgvkQy
 Y3N4Z33gaCOwemPoPTTEei2UUXHngZ6Em+OVhqCeJh6ogHvMNg07jo6taNzFh6Ujjiju
 EYjM994XMv2pzRo3jzZuL+/0OIIJNGzcPsL++xnl76FesJUsXF9nV7DfnV3HZeZZjs7X
 y0rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mT6lyWWvkEWaDVbL47hVmlwEG3hCz85Vu5tRa9b3Llk6End/EsptId0Qa3Jtx4SZ7MtjS3pzt4fI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4eOkeRqU50yZA/paRnKwh34WyTI8SO8gb2YxZBa42lDP/9/gR
 jUl7ookN7LO0eiJOE0IvdoD8RZMg4L9QONljrGCfa2TrTqINp/yIeRwDPx/iSLewapM=
X-Gm-Gg: Acq92OEZjM+dLJF1vof20vfne31/akdoio4a7NIC8nspBb//MPJEFsIw4chMcHCpKDz
 ngZqTYBFCA+uOi7Qx9L2fg/aO1z3mUMIDFzubChXp2Y/QCqTAb+G0OZg3AKkYvHhBfgHkKWxc1N
 1yZPaLqwFB8GVAGTJQplvJ3l4u6j8BTZ+J9XlPqhhSewz/xA8iVVRoa4JjfLUWVG0qeIY0xx6qk
 aFPwPczs4sCOXuhXVRl0Ra6h3Bsr71ER0q4/r677s41AZiyRUFSEM6Rif0ZhmKs79GsuDFHcwzs
 BZNWHog4iFXwXpcH3OygG15MZbKHSImwYoMRnt1o5NEu3h7GTeTa9A5JjubN/MwEklTBbYK6eJM
 HPtZJmeVNUxxA67L9ExTZKQxxH3y1Fzc4KreQ5Y70LjDbS8s0Pj9DtsJuwTIs7lMMVA2O1GNyKB
 MezIcvB7WOh5EprHcGEot2YYOmBkqWsYPL6VWXWrvoNSl9TnJAKdfqN5KtOkKvrU6erCQy12mii
 K8=
X-Received: by 2002:a05:6122:f8f:b0:575:56fe:574d with SMTP id
 71dfb90a1353d-586640340b2mr12086863e0c.12.1779887911538; 
 Wed, 27 May 2026 06:18:31 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f8f6cd40sm21200336e0c.16.2026.05.27.06.18.29
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:18:30 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-56f75445470so8992778e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:18:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+LEKRmoeLg7OOUqvIc7zyasl1VRCqaMVYzf74/M4uvDYC9EyMyF1NFyiYh/2heuFR7JnsP01MWsi0=@lists.freedesktop.org
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr11675886e0c.3.1779887909452; Wed, 27 May 2026
 06:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:18:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
X-Gm-Features: AVHnY4K9MKooRiuSGEh5fNQ2eTKctG0rOT_zroLTx4bk0lQkHEgucmZG57_gNvg
Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] zorro: Simplify storing pointers in device id
 struct
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>,
 Andi Shyti <andi.shyti@kernel.org>, 
 Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org, 
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Technically it is fine (on all current Linux architectures) to store a
> pointer in an unsigned long variable. However this needs explicit
> casting which is an easy source for type mismatches.
>
> By replacing the plain unsigned long .driver_data in struct
> zorro_device_id by an anonymous union, most of the casting can be
> dropped. There is still some implicit casting involved (between a void *
> and a driver specific pointer type), but that's better than the approach
> to store a pointer in an unsigned long variable as this doesn't lose the
> information that the data being pointed to is const.
>
> All users of struct zorro_device_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
