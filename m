Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DB1C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16D010E0B5;
	Fri, 24 Jul 2026 21:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCX0qBzg";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A080810E0B5
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:04:27 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cace91f112so11103825ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784927067; x=1785531867; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VwUsmXLvkQOCrPIfr7szp1HeyxYyQEY+UzEyT+qGU7E=;
 b=HCX0qBzgtssm20El2C20sPzJi81oQqlRBmIUHkRDgPFjLK9tdphThqbv9kCRQuSZBo
 /vL1Y940UDwZpJTnm0fqniYtzXkIYe0McRTXdWXn3lOSS9egXRdIho/Kw1HQO+aU6OSw
 SeXiVdC6GluhX4Eh2LLJ5EEfsRxf85W91ubkibtfDkbs3FJzKg+jbgdOlomGKwFpGA7/
 KJsCgYM6jvlPGLecYtObxDcXb1I8q8UtMvtmue00c0FKmNf0Q0bPX5n8OcARe/2Zhr4z
 DzeevnOl8LO23HgmJpf3+lsI/O9PzMlgEBPKMv8FUdpGNeEAUj/3hkhKehxE4vxRjcHG
 KP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784927067; x=1785531867;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VwUsmXLvkQOCrPIfr7szp1HeyxYyQEY+UzEyT+qGU7E=;
 b=l5Z0eeolI4KAbx9xLqAopp7FkHjqJddZS7j5bahBrvRzn39Hpc+qi1vK/jCkdZCBmQ
 7vQ9WgFnHoIRYRna9ar/Dwf3rPefd32OWrSkd7HkX+o4oV5n3uo69nE5PRJj8hXoD0Sv
 UyI3L0ccEXgk6kzinbzkxWVLPyvBaf3DXrXHcFAgkntVh35i9yvGllbMSAz+fideU21J
 ixjioMB0HMFygqY/oOIWqeD36uVLcNiMOjxiYy4wYQoYHyXj3ftrln7pbOu+IxVjwAkp
 RYZDiqTj9kYCIcDBe1UT5K/2xYcQi0HmeNLea4hZoKXFMH6oSKKdfhUp9QaadoPrsMBn
 7aWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAQPzKLlRwoaDCuTHbdFLN3xLm8/bk5O2qpaX1MWAx2tzp5QqF4/bH4CZQOP96ugduHVCdHA8BNY4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyeitl6vKaHn0YPO1rdGp3EoY66erxIlmtFUTpdzwjZlJiLOtP6
 6tLEahanoEdCkf9+fopBzJqIQ4tB1H84DB/bCRjva/oS/qET5zCmGyE6
X-Gm-Gg: AR+sD13KCgzzwIlRjwWS/uFmIVkrCq8qck2GC083sxolw92p+OA8VnnZLsVK/694kO1
 R0RdTIq1nD0K+lafFxwovAXT9EPgSTnVyaPOs4yxS5G0W/pmW5E4ydiDLmj6/KTLchcT8/LLr+D
 WTnl29BcaWsbi3m0b+TyKR4XNKWcbCIAt8dpkbvfgTEpWwd09ofnDGj3hIVOtepWTq6MBkR/5TN
 vYuWEFz43mTiFE3N4yvWLRKCbOte/d2aqgOuwnOZQXZR+0FB5UPgdGqJX0e2o2i1G6jA7PJrIsM
 UCqB7ZqRQWO+61Z0OepRtawZ67tCEC/wXqydAS/34ndNQndQdp1YBanKi378ntiOkYWmd7z8hkl
 jK1iQ2wDEInGl/t/T5L5XG2j0KV57uGgoLhsuruT/EkmhOQUwyitHmbgJBqMLrXxPjGRO20hShe
 5UkAux0lIiEa4L4KYgKfWfDcK9kduOaG7XeBLnBCLti8q2oBnpi/Sn6ZmYIgYTkeUAwY4gTtyi+
 zXL4PesymIdB4FD2MM=
X-Received: by 2002:a17:903:2b0d:b0:2ca:d975:5bbd with SMTP id
 d9443c01a7336-2cfde7c4b2bmr712645ad.20.1784927067004; 
 Fri, 24 Jul 2026 14:04:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:48::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde5e2b8esm257875ad.31.2026.07.24.14.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:04:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:04:24 -0700
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
Message-ID: <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110903.34840531@kernel.org>
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

On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:
> > +@ksft_disruptive
> > +def check_rx_large_niov(cfg) -> None:
> > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > +    run_rx_large_niov(cfg)
> 
> Any idea why the devmem tests sprinkle disruptive everywhere?
> Disruptive means we take the link down, I don't think this test 
> does that.

Talked to Stan and he mentioned the original idea was not necessarily
just for link down, but any test that could be considered disruptive to
other tests, with the idea to eventually introduce some scheduling
(postpone disruptive until the end).

If we can get common agreement on its meaning, maybe I could submit
something into the documentation and update where its misused?

I'll drop it from this patch since it doesn't bring down the link (and
seemingly no worries about check_rx_hds() tests not having it).

Best,
Bobby
