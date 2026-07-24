Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59325C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D2710E309;
	Mon, 27 Jul 2026 07:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GdhAxlUI";
	dkim-atps=neutral
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DAB10F49F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:41:54 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso3651375ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784929314; x=1785534114; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v4ixN669MPx0d/t5228Qef0MeDlKadYsw/AtAwtoW40=;
 b=GdhAxlUI8YrJoBut/Gr3Ebuga4buLsx7C0aQEEH619pzEJ1xxu8eJHfX96LNyN760f
 rAShZOIxbc8urAoLyFghmTeRsHlCbJCCLAtPph2utsq7+h3VDDMR6ONVURyPBQWHa3ge
 BX+cQArvhl3M3mEhwbJAOuiAVtCPpUHnT9l06zmQCP6oOyk4+ayVdVd/Yx9EdnwzbMxT
 TXieDVGfunOw4Wh0mfYmL+RB/GJpqg3kkCJd4PgwQEnvca9odz+qyo6FMvlFvxHvvZz2
 F+UPGtEDXUvL9Pmcn4sXlPCDFwDsOfbn6CcWThosBFQ0C2sOUOMZRkUd/8PP53xAr6v8
 M1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784929314; x=1785534114;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v4ixN669MPx0d/t5228Qef0MeDlKadYsw/AtAwtoW40=;
 b=ItkqtbHm/i6oyhH9h8UhA83rcH6KMnqO7/zOooXPegoPJCoEODcQiin79GG5jHj4r1
 KJqdwLU7jFHFnPbMMolDZCpQLXV3jdUG6M6sTYZ2Nhafrou/NeRd1Xx9p1u2ohHHA3Z6
 wPNYP5SHcMxAYfMJwEuTeVhem0ZUwxPTrgYQzMz/vNRQfJ4wdZC0NE92PBMsolWJ8eDW
 PopF/Bs8S5zi9/VFjI5VzMoBZUhkgnXZ1ti11jBiJq0VsvngHbYFRkt/ycC1JyKXwtoV
 aspp19PL8bPNEhyAo0vb4sPwHxw6aSRW2+tWgEKmloEfLsJvGa+oNw8/YGTrmfTGSrc9
 8Y7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBGIIEDV7lHfOXX1satEIMmt96Ec60zBer8u2bfMq8TL7ZJKhGt63lx5Izq5nQ0DLpcbENc0JvmvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRkTn+xk8DMoVrC6HiNtvbZsrk7UuCWOaf6HBEw87D8X7dREpm
 cLPPumCBpPPdf9U9Sp8O62DecU9quuNdcJ50YbDJZtb0PS4xzcyXeXzC
X-Gm-Gg: AR+sD12kyvNBd2HdchRyAYe8SPyIbww1w8XMb+DtPQvzg8NhKOTMtWsLy6tQ6/nWGpg
 rSxk7ohb/QIlwvYxam8VQk8vb7w+3hxkud4y3At4+sSiN9yIgiXtYrAeDJT1xEePs5IU+Ib/4wU
 CJ9h8VPbzKlC37P6DZC34B85RmehfVD0iq25F9suPKi+Pccp3aby5g8eApV+meJNhFPr5Ndqnu+
 IMXCbAKMNDB4V2CLcKN9MFLJcQ9wzDhjuu/Nc2QLbsKySGKDD8nPEa99Gfel2niAdkTqvcTq0CK
 1WlqRHvsGNjVnDqeFH4RKRY3Nh5khX9TU48vidxhmVjuykXOQRJOl+sASDiaWwu52tIdh1oJHKL
 6x8EF47fZicdw7+sKHVGDiHas1CMwl17952J7x9Ckey9nLNtZHkMuJF8jEV7m6Sk8J8N7FFwjvB
 O4gg88lg==
X-Received: by 2002:a17:902:c943:b0:2ca:281:27f9 with SMTP id
 d9443c01a7336-2cfde8459edmr1610395ad.27.1784929313662; 
 Fri, 24 Jul 2026 14:41:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d81csm504415ad.80.2026.07.24.14.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:41:53 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:41:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, 
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, 
 skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amPbqtxPdhs9QrVP@devvm7509.cco0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
 <20260724143001.5afa8631@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724143001.5afa8631@kernel.org>
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

On 07/24, Jakub Kicinski wrote:
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

I don't have much to add so I didn't post on the list. In my mind, disruptive
started as "anything that can lead to a soft reset". But since the
sockets tend to survive these well, I do agree that your definition
of "link goes down" is a better fit.
