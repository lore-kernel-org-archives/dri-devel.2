Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A5606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0658E10E2A9;
	Fri, 20 Nov 2026 07:44:45 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E360610E2A9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:44:43 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-990fbae94f5so402628241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160682; x=1795765482;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vu6IMQbhyMpXX+yWtY4enAtEpk8kj3N3fFV230nsSvs=;
 b=yEIQ3284IZMzcxbRoU4QhS+CKjdKY1Ef86DtgOdAh/j+K09MKmIP9G4HRRwAPRT+dC
 lPIjxYlDkRJpWzNygw66NQ6eL0xUbhaKPVQBQ6G8Wt8xZ476iL9PQRF30jJMTatpsk78
 e/dNKAoirZ2xTnhoegpnJMemPsoKzQoQ74UkeeTId1BhAW7pa31qWd4q+/xvCDAOHfrt
 o55XK8Bfuliwmgx+fhf3oUnIycRbUukaKr5YHaTG2A6LKMBLSWqZsFbUMRjwlLyDxxFk
 ouqzR0AXn6LHM9RTWXdPckrrWp1hXhThmsAd4zv/IjKZ1OiqxYi5o6M3U8y7+cU0yc1n
 viTA==
X-Forwarded-Encrypted: i=1;
 AL+hErFfwgxHHCG1IDBCajMHVez0zsXcGk/Wxvtfjl0mMhJvLsiAZOJm9TH7ET6hi0w5MHwNIEgtmNmpddA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9JrhRYIcUtqAPaKmZEc4Z1r3HAXCLTIrVELb8+LbSDI33LvF/s
 Zp7g1YelWQZ8Mzmej1lSCcpybw/BTRn1OXfkJ0bZyWKRKumiyuz/31p/LIq9KUPU
X-Gm-Gg: AZFdTZerSfc0Dc2QGSiu2xB+CYBwrQ3gvFGRw2Cv/t8A0feLbLDYSWt3WdPzaC49cSz
 xchDUoombqBjV/U2WccwGdlXfVGqVBjmAK/0SUk63CpPFocaD6fB7abY9e8o+L/D/EXykul2ZFz
 iQdFjHkQORPHwejslbTCnEHFM5TG4VWeh31w4UJbMp3Mf2h4jXGZhGD+J6oc25ErRJnw0p0oKX0
 Eg0DN+MdI9fKvaNZxwJ3vdf+H3eewhZw5s8dmbgxVoBs0jWWrGQ17t3Xtp1FNX5NDZ+R7dJ7djF
 cK+99hLItfc1Rwv9iLhMgteOu+eDAlEpZu1J8KB4LwUYdGNvEJ15wi8qrFRME1UTbskHWsRpLy3
 VT4g4qR9JoslIq/Zf4iGJjc5YeVXkCLreSIqw7JwzNaLzHORph2YBoape5gointwEnzR14EY3Uj
 1TcYh00+lY4luBaAhiz4GXsxZB6X0IynADmbzpklYK9rjt02f7BY8fzR31SNlJSspRvzQdj2iB/
 bz7WLn5CPEPBCzSOtL5Tj8iXdMRGcJVHfM7Te8suh3bhLidewju0JPM/4JvKlb0l5is5H2pz3gB
 58/JvrXLOpzTufG2uw4NwR22lS4sa+Z8tI4BvD1L2CU4QjyTzt6+otlksiTJjNZtnfAtsCZM/TV
 jyMgxdjsbQRY7
X-Received: by 2002:a05:6102:b11:b0:7d6:3d9a:4da2 with SMTP id
 ada2fe7eead31-7d7396157aemr1023458137.26.1795160682508; 
 Thu, 19 Nov 2026 23:44:42 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e7f92680sm2294930137.5.2026.11.19.23.44.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 23:44:41 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-990fbae94f5so402611241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:44:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHWlB+q5ymRwW1LzAwjhehbqSr6Df3KSSxEwjJlrlPdQAQziCc54obzYpm9OEJluymnpyEJ+apT+Us=@lists.freedesktop.org
X-Received: by 2002:a05:6102:441e:b0:7cb:bda3:27ab with SMTP id
 ada2fe7eead31-7d7393925f5mr941037137.13.1795160681386; Thu, 19 Nov 2026
 23:44:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
 <179513882271.284394.17357508909448455391.b4-review@b4>
In-Reply-To: <179513882271.284394.17357508909448455391.b4-review@b4>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:44:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
X-Gm-Features: Aa3M54p6yw1Lhc431P_jQfP5g0YMf_od8mct8UUR6SclOJC7dcSgYi-awR9w8qQ
Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
To: Brian Masney <masneyb@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
 Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Brian,

On Fri, 20 Nov 2026 at 02:40, Brian Masney <masneyb@kernel.org> wrote:
> > This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> > about consumer devices").
> >
> > This commit added a struct device pointer member to struct clk and a
> > parameter to clk_hw_create_clk(), but the new member was never used
> > beyond setting.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/clk/clk.h
> > +++ b/drivers/clk/clk.h
> > @@ -5,8 +5,6 @@
> >   */
> >
> >  struct clk_hw;
> > -struct device;
> > -struct of_phandle_args;
>
> Did you mean to remove of_phandle_args?

Yes, it was added by efa850487a6b6742, too (although it was
used in that header file before). Currently it's not used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
