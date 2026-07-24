Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1B8C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C41810E5CE;
	Fri, 24 Jul 2026 21:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dcY1My5Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C445310E5CE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:30:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD92060A60;
 Fri, 24 Jul 2026 21:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAC1F000E9;
 Fri, 24 Jul 2026 21:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784928603;
 bh=gbVBUykhRTMTCv/pcLItA/njGTwSduEcLdsDQAdKLvE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dcY1My5YAnKm9lrlAe9AkBnVNoKTg+LjQZSFSEtrrsbIe4ISCe95lqbKsVi0zkprl
 DEOAZHkRY08fpYrwLG/fGpqxrYkWqi59hKgjRCr6GLz+rGfd0sgEz/Lm1hZrbOnbvo
 j3Dq3EbM3CzJlaxn0jsudSRt6k5xqfjTKkfY+LlUEFJjYoEDfVAy8Mj+yFUrGH97hb
 CHwYcsZPSzAQrgS3h5AnFv1TwdgmQOmqr8o242dVsq+coOLwEN4d6eYQTAwSX4s3Xa
 GHz251yV3RIrCjHustUJC9T2M+3sYThMBKMWbahBT0EKU82w1FbIDOcGLcRjb7vLtv
 DxGSY+0ClTaLA==
Date: Fri, 24 Jul 2026 14:30:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <20260724143001.5afa8631@kernel.org>
In-Reply-To: <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 24 Jul 2026 14:04:24 -0700 Bobby Eshleman wrote:
> On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> > On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:  
> > > +@ksft_disruptive
> > > +def check_rx_large_niov(cfg) -> None:
> > > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > > +    run_rx_large_niov(cfg)  
> > 
> > Any idea why the devmem tests sprinkle disruptive everywhere?
> > Disruptive means we take the link down, I don't think this test 
> > does that.  
> 
> Talked to Stan and he mentioned the original idea was not necessarily
> just for link down, but any test that could be considered disruptive to
> other tests, with the idea to eventually introduce some scheduling
> (postpone disruptive until the end).

Perhaps have such conversations on the list? IDK what Stan has in mind.

> If we can get common agreement on its meaning, maybe I could submit
> something into the documentation and update where its misused?
> 
> I'll drop it from this patch since it doesn't bring down the link (and
> seemingly no worries about check_rx_hds() tests not having it).
