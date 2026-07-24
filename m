Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74A0C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0859610F4A3;
	Fri, 24 Jul 2026 22:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UoaJDvqp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510F410F4A3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53F7C600AD;
 Fri, 24 Jul 2026 22:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A8B1F000E9;
 Fri, 24 Jul 2026 22:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930838;
 bh=rukVo3Uuxy2j0nXqDDCCRKfJrQ9NUXslYxPOy5lqKT8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UoaJDvqpyE4e7TV8TyphVrpMyLeA1B2rGfr2vMJXNn5RvQr8plZtjmn/8Xuk7dgJx
 td7BXxGp57IQDa2p84G276YhTChpK56kNxS4kHm4DyQFDB6YF2ksFlwpF12thjH+DC
 f1pAt5qu2VAezYIvXIRtSdPI6e5/DCGepA7+DI8QY117dJRJkIuS0b2J8EbhTHBy32
 R6c31OyK6lPvzqmX956FMxkq5gIvjEZWTAEZIafGlqt41Q/r4/TOtxYqrV5CsvSJ3d
 65alkCelWPNkc9obBoclx2WKORupOLevuySIVv0mpTvVfDQIyWonKqVYQo5rRw8S40
 FYKlYBjVAu9mg==
Date: Fri, 24 Jul 2026 15:07:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Gerd
 Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <20260724150716.07c49ad8@kernel.org>
In-Reply-To: <amPbqtxPdhs9QrVP@devvm7509.cco0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
 <20260724143001.5afa8631@kernel.org>
 <amPbqtxPdhs9QrVP@devvm7509.cco0.facebook.com>
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

On Fri, 24 Jul 2026 14:41:47 -0700 Stanislav Fomichev wrote:
> > > Talked to Stan and he mentioned the original idea was not necessarily
> > > just for link down, but any test that could be considered disruptive to
> > > other tests, with the idea to eventually introduce some scheduling
> > > (postpone disruptive until the end).  
> > 
> > Perhaps have such conversations on the list? IDK what Stan has in mind.  
> 
> I don't have much to add so I didn't post on the list. In my mind, disruptive
> started as "anything that can lead to a soft reset". But since the
> sockets tend to survive these well, I do agree that your definition
> of "link goes down" is a better fit.

My recollection was basically that the test is not safe to run over
SSH (without tmux). Hence the link down concern. If we say soft reset
that'd cover 95% of the tests so it's not very useful.

The existing doc and README already document the link down AFAICT.
