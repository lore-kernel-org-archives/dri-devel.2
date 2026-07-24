Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D26C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEE810F488;
	Fri, 24 Jul 2026 21:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sb8UcShO";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4532810F488
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:38:49 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3811f512167so851658a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784929129; x=1785533929; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qq6JMFh0gDJiS/8lUoBGQxGZpE4+LKphNkGVGqdhJ2o=;
 b=Sb8UcShOftWEwQwn5p9GDVp5u81ZGKfV6nutCBRP0l2xMoh8XWk3Hzp/naQANLScE9
 rytVRpJXu2IuFv7uSbmKaZLrTzpDDnK6DIEiXeRyK7uzOl0kLUmCPlGqATR1Qsfv3PXZ
 phgoxHYvzMEoVaNDhf4bl76VaceWyG6g0SCZcVDCKUHyT7Xp0SiuHeg7/DJFcqbGkrPM
 MKHRwxQCJPE1R8ZvbBR0DqKoOqWBWICUX9ZlWjek+xpPkZ3THEbSpsgHD65AIpNhHvFH
 0fS/B/xwick4bO4x6iQp8v5oWQqenQAigdLs1cl8wdK5T9JciqqRUpGE0phgQGKaNBF8
 wRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784929129; x=1785533929;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qq6JMFh0gDJiS/8lUoBGQxGZpE4+LKphNkGVGqdhJ2o=;
 b=KQchMAs4b7Ck52yNkw72vd+qTeRjyefynFH0DdJJZAOnT0b7oK/9wjNMge9OdrNpMW
 KgfckaDsLokFbF7il5mY9UVyqbh++GiShO0DlcjdJ1CRb4R2kWGqqysTdQi/aqN/iSBO
 lyRHHX5X1z3eQleQG9JYh32RrMvVa3DIQ45XhSznIBg9IhTomHEk1yFPNY/2lDHTrlX1
 I2DNPKzy/yy/yBb7/WLDC61tNzGaTzzP3Q0e6ULVDYFtrAsrULpapEjlnQwsFBOTK1Rq
 oecDbA8u1Lp3sL1y2ddmeyVM6yfgrXBDE0HG/kJ5AGb8sBbgwF8xaGaFzzme1E5L+PYf
 BWWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlWEF7vk7Kr201e/h0+ObdAWBcec2D8h+nUYEcp43UM84q5qva/mpBhg0fcV1Ds6sQfshth3KYXmo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+jD/Mf93bwY6LfpttFH+7yFOsB2TEkhPc38vnqF+YrwSKWaUz
 hb1Cpz5aMh0dTiXq0LEN1tkOyrL0r8gtvwj90V0jWkFMfoo7t1Y1Ln5f
X-Gm-Gg: AR+sD10xx+qg+o+p8b3mn4/7CpkDkAEk3kjiYFrhrfGXM+z/Thl55oZCKhfHO+mwbGf
 0SW3InmFMj1m382ON7AICUTgsRGlI8cmyD700Yub2GB3FXFZ1eKAJnxGfnr9n8EIJEv6hgposSF
 mp0/zmVOIcZTud+9VngfkXjkmp2DaFwsh8RtLKpTY9LNLpeN9gAtcVhrB2Stv0Bpt3OqInDMliN
 +xsfgX3uWKT/T190uYTvvuTWVxEK4emmfzQgl0wOJX+s41VwqOseCRYJUki4fktc2OalqZgeDUC
 k0Vdot/HoJBEa1FdJBAAboOUGrX37tCUuS/BwVwnGUv2dE9DPjbGyQhtJw3IreOxmEagP17Kd69
 XLPeDUDfMTVbjLHgZtGo1UU2I+7S7T+WZk/5YWGfiPARUkpkVbnQ0iq2ThjRJFeSIoVF90qerzW
 c7tWSgCtQgeF7Ck4KO9QRg4Q==
X-Received: by 2002:a17:90b:3bce:b0:38e:e0b:320d with SMTP id
 98e67ed59e1d1-38f297812c8mr143723a91.41.1784929128727; 
 Fri, 24 Jul 2026 14:38:48 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f04175831sm2086519a91.11.2026.07.24.14.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:38:47 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:38:45 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amPbZbpQ0jwBshsa@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
 <20260724143001.5afa8631@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724143001.5afa8631@kernel.org>
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

On Fri, Jul 24, 2026 at 02:30:01PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 14:04:24 -0700 Bobby Eshleman wrote:
> > On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> > > On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:  
> > > > +@ksft_disruptive
> > > > +def check_rx_large_niov(cfg) -> None:
> > > > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > > > +    run_rx_large_niov(cfg)  
> > > 
> > > Any idea why the devmem tests sprinkle disruptive everywhere?
> > > Disruptive means we take the link down, I don't think this test 
> > > does that.  
> > 
> > Talked to Stan and he mentioned the original idea was not necessarily
> > just for link down, but any test that could be considered disruptive to
> > other tests, with the idea to eventually introduce some scheduling
> > (postpone disruptive until the end).
> 
> Perhaps have such conversations on the list? IDK what Stan has in mind.

For sure.

@Stan, can you elaborate on the intent of @ksft_disruptive?

> 
> > If we can get common agreement on its meaning, maybe I could submit
> > something into the documentation and update where its misused?
> > 
> > I'll drop it from this patch since it doesn't bring down the link (and
> > seemingly no worries about check_rx_hds() tests not having it).
