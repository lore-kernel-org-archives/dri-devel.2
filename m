Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B6C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CF510E02E;
	Wed, 16 Sep 2026 16:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="UB84TBjg";
	dkim-atps=neutral
Received: from dormouse.ash.relay.mailchannels.net
 (dormouse.ash.relay.mailchannels.net [23.83.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B46710E02E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:23:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 75E5660D42;
 Wed, 16 Sep 2026 16:23:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com
 (100-98-23-230.trex-nlb.outbound.svc.cluster.local [100.98.23.230])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 01638639A9;
 Wed, 16 Sep 2026 16:22:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Plucky: 5f9e6bc91db29077_1789575783295_690671158
X-MC-Loop-Signature: 1789575783295:4125694942
X-MC-Ingress-Time: 1789575783295
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.23.230 (trex/8.0.2); Wed, 16 Sep 2026 16:23:03 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4hlPLp1szfz2V; 
 Wed, 16 Sep 2026 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1789575778;
 bh=hJgpgR1Pu/CBur1LbvrXJNeDc+USSMxzhOQ5CgOveDU=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=UB84TBjgMsU8N22HyV0v1QNyr+X3lWfaEQKfIgmYqEJHppr/sviQuiTC+eFSSeFzM
 azGUgQBxN4/Qlw6/MJ3/pbQOytqvMEZDw6ERx3MS/sM09uy5xFjVcrqoGkN0G36NYQ
 jMEKLLCO4pVkP9Bwdj5ksWOVw8S4mpJhJ7JVgiicEC/QYiFgVbWWW5PJg15RNjrw3J
 oiNx6cHT7s3/NC5kDRp3kB1bEWTg4Y+S9p9gnxXsFKzYTZRTXB/Gd9FBid6IpCNO6j
 wYa9X9zhfnwKs3BtBZhm2fe97NdRyS2oVwHHj+vbZKywl9b2YKn2tcuBNRm0lGWZaD
 jy2gTz7kFE70w==
Date: Wed, 16 Sep 2026 09:22:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christian =?utf-8?B?S8Ovwr/CvW5pZw==?= <christian.koenig@amd.com>,
 sumit.semwal@linaro.org, phasta@kernel.org,
 benjamin.gaignard@collabora.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
Message-ID: <20260916162255.jv3dqacwtgfiv5kd@offworld>
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
 <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
 <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
 <d8d3af91-4f21-44ea-bc90-339fa1adacf9@amd.com>
 <CABdmKX1YtyFM_MoMbPr4JUCXCr8TGPVbXUrAoQRELpp54cK-0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABdmKX1YtyFM_MoMbPr4JUCXCr8TGPVbXUrAoQRELpp54cK-0w@mail.gmail.com>
User-Agent: NeoMutt/20220429
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

On Wed, 16 Sep 2026, T.J. Mercier wrote:

>I'm not sure these patches were motivated by Android (based on x86
>focus in the commit message), but Davidlohr would have to comment on
>that. That's just where most of my experience comes from and what I
>can share details about.

This series was motivated by exploring new use cases for dma-buf (such
as kvcache), not really for Android specifically. I was counting on
the cheap/one-time 2Mb attempt (current high order semantics) to not be
a problem for potential performance gains. As for the x86 I tested here,
basically because it's what I have on hand, I had no idea ROCm was a no-no
for system heaps.

I am fine dropping this effort.

Thanks,
Davidlohr
