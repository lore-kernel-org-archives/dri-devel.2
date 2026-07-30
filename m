Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28597C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8270D10F0A5;
	Thu, 30 Jul 2026 21:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rx3wfA/p";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2FA10F0A5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:39:40 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso531626b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785447580; x=1786052380; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mlBdZN/Yu2XetCK2pd4kqserGOdzhIFqZOg4RXy2UAo=;
 b=Rx3wfA/p97g+LfggW2RpVkkh0VWpntgHmgcA6V7HF446U1CMHvu/4nEJnAD98LUz6C
 /9zUFVcs16AucZYG8WXt8087+H7QiNvYEon8j4E7aOIShTRQG4RdLgK3Gw52PvapGx+M
 UP9qzcP7b6rkK3HqXzYKuIdEaAfx/hOeUywMYD2Dy5K1+jRk9q26rNUjXnVMfKONyI9t
 //CqDjuzV52V/gZJFbOZcWoecmFhpvmPlc7ZSCmPVKPHMQpfsChyfIV+zn0o03vv1s02
 ANGR1/z6xxpv9gjhlIFqE69W3y65ifFqEOkS5kwpzJVdUS7GW5vQK0LpxF1fXN9krwtl
 +D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785447580; x=1786052380;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mlBdZN/Yu2XetCK2pd4kqserGOdzhIFqZOg4RXy2UAo=;
 b=T14J2ISZUXEnh5hWxhtrQaFvDsuiXKDffs6m+RUHbqu4zI+LwuMnje7BVvpJtFTVim
 uH9dsp/0kKt+b/26pMEiehEDlFgOLkDDEU6gcq9GGStrx7m1f97uAggaZYeu96A916Jt
 A/iS2FeGHBrBiQfwKJEwrfRJbbV5Lu5NWbyoT636xwLI5pcyyN5/FeL2Tt3sfzhH9juZ
 Jqeo2hV9BH2NgsAWZfjdEx8/W7B4JxfmfcVyFzojqT9x2itRtkRTR2Lgaz95gfIwVawn
 yVuqA77jrwE8XKwMgl70cdwht66o2j7HybtPJxj3pGAmnZ2V4GyeImRgcu+N1gkbBzog
 IU9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7eQGxPmJbXE3mE2Vn0oTsRlGA/TQE0JZlWbeiglBZj3rz8pV0+zfxXi0QZGORsRPv5e0gqjynyiE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAUPnUL9IinTgQPP+Z+9u1bdnXtYSUaETFYKGRfykgdVZDazmT
 +niAU/3FpZ187q5h0ssbXzXuckeMEV3g+hu+WPSkCsYcJvJ7CT/Ubkl1
X-Gm-Gg: AR+sD10LGjTLfo3TxwN5j/nyTtSQLvuEq8NCN9RL3ooo+9xk0ztkQ8+yRatIu74J24A
 uopV5l7eYdDTp6S58ndR4Ddl5Nv9GWh2COdqH+VwQiCCYcoDVuDaQLfz30VcCJiqsVxH3qiatj+
 XtwFnCE1dgHsUeWpLvnPU/aRtolV5WALZaEwR0fNrKCk9QH+v1n6l9ZM7LuxpmidyP1TlN5HCba
 hapUdVMUKPz1p/YzkigTAR6X5Opi3b97TpQB3IbiUOHwI47b6Bc+TFoiyLU7DNeVzN0znHCT3hZ
 5oYwHu3rnpv3CiPKwg3ZW7aqdNG3YUbMZFztSIPVUa3RSSvbBallYtbRLS+jLBkHg26mLuXOChq
 fvjny9oOIMpyNUWHwspUyvxG37AJ8MAHUpIekhwYAUPvBXrE83LXjEl3TBiOyEZCvXWvkZtpbik
 DABndiSAglUODQdDKUkpbFEMkSnFdbw0RqzKY8v8ha3wptosE0RjZFE3xlF4P/sRBljLGJlTpGA
 rcFRc9JEg==
X-Received: by 2002:a05:6a00:2a09:b0:845:44c7:5e28 with SMTP id
 d2e1a72fcca58-84ebc2685a6mr3911212b3a.31.1785447580388; 
 Thu, 30 Jul 2026 14:39:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e9fe1d07dsm3618306b3a.8.2026.07.30.14.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 14:39:39 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:39:37 -0700
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
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amvEJVio9XtCn+YT@devvm29614.prn0.facebook.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
 <20260729191649.55ab7942@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729191649.55ab7942@kernel.org>
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

On Wed, Jul 29, 2026 at 07:16:49PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 14:21:17 -0700 Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add a new devmem test case for binding the dmabuf with rx-page-size=16K.
> > The test sweeps RX payload sizes straddling the niov boundary to cover
> > the sub-niov, exact-niov, and multi-niov RX paths.
> > 
> > Silence pylint invalid-name (`with open() as f`) and too-many-arguments
> > (ncdevmem_rx grew to 6 args) at file scope.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Hm, odd. In NIPA we're getting:
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: drivers/net/hw: devmem.py
> # TAP version 13
> # 1..5
> # ok 1 devmem.check_rx # SKIP marked as disruptive
> # ok 2 devmem.check_tx # SKIP marked as disruptive
> # ok 3 devmem.check_tx_chunks # SKIP marked as disruptive
> # ok 4 devmem.check_rx_hds # SKIP Test requires devmem support
> # ok 5 devmem.check_rx_large_niov # SKIP Test requires devmem support
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:5 error:0
> ok 1 selftests: drivers/net/hw: devmem.py
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> https://netdev.bots.linux.dev/logs/hwksft/BCM57508/results/755681/config
> driver: bnxt
> fw: 237.1.148.0
> 
> Any idea?

Poking around, it looks like 231.1.167.0 and above should support
everything, so fw should be okay AFAICT.

Looks like the config is missing CONFIG_NET_DEVMEM and CONFIG_UDMABUF?

Sorry, took me a while... was certain it was a bug in my code.

Not the failure here, but wondering if this was on ARM led to seeing
that 16K hardcoded rx_page_size in run_rx_large_niov() may fail on ARM
with 64K pages because it will fail the IS_ALIGN(16K, 64K) check...

Best,
Bobby
