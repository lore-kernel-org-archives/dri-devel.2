Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75680CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC14810E297;
	Mon,  1 Jun 2026 17:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="hnefms2J";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E80A10E297
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 17:50:06 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5174a3a025aso17924351cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780336205; x=1780941005; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
 b=hnefms2JKKYT1nI2PYDy1tCiUSUOpybsbiHwR5sbRJ9ocdZf2SGqnYUWe8Mxmd1qze
 nV4hRQoxHprLdeW4lhSdcM7lTDEQQw+foMagx5fXTRaA+kplMcVMiShycu2XfLAMlFYN
 yZ4gWPLxEMApsO1m3d93lMU47CWVdx3LSEQPzQULEr7SOAi5N43ww7qnd7hc1dmQDHqQ
 gD1W5nc5ArbS199sEAjmopUPqijfigWkuSBXVICfVYqu1bxSSrZ8i+ttaLVfGT5Cghdo
 OF0iYvyoB4/0m/BujC7WXE+1XRdNihen2kTiE4twutjSlHR2vO6riOC9Ih+KsB692Tip
 BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780336205; x=1780941005;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
 b=eArbDsaMNNC+aHWndtudU4lkOTK5HAFr4AtSo+k0IvHmHGFdTg/s5tx6ZA/yvrD6Yj
 oh+PMCz1dqVFp/cdCfQT/HnkpiEZBjDJiMgIN4WtrxUBWe5o1/TW9VbyjBfk6Ybnq+ZH
 5kUdTOuWWZ9CTV1p05+qr82xrkqS56D6VVcb1TCKO+gucvmEnOGKWHKihZyb/RhUgOWT
 /7r7JFsSfvV0SIjOa6UPCTvQOOzui0UEQ5HDXKRrRH3PjsJLtE+nJoeTA/6Cq9KFIAvw
 kKZhinUTICGR/osZZ7If8ZaON2uzf+MAckX9GFmk1NhOkwzov1zGBrizCV3OhbJvvxRi
 ufbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KadK//7Ur2Rg60ebkcG8vmSxCiRnIa93An1k7b7zF7SSOaWjKmwEP6vWmrqpB7OkVUZPPVnwRwIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuYVkPYr4cpR1DFjQJZpJAGiOnW4WuXlKsnA61ppEq7Pay7nev
 saJNxuu1HjGdXkdjXNyry6GXxjgAeH/p+mMHKOVwsySTbrHA2u9gumCUgrHEqiayezY=
X-Gm-Gg: Acq92OG2UPqNfOzr+r0ugth5Lt68WoXoMz+KlJj9GW35e8xd8LFbQyjnxd/BH/lRKA/
 dTtn9BenoFQuBsZYCBh/DmApwOIC8cyHHE54OATGu44H9kDL4GWExqCh6Z2m8qfvwx1KgpbfRiX
 NYPexucaTXctp2WUVpJccaY+y9VQQz75zdplWNoCvY8bWMrRaqoSmWN3TaxEm49DTn7AqE1e9GL
 Ji3MD42bNX4PhLLWNU06tK48QP1CJImMUtptv4vL5WL8eZZniyqSSVKVGQ+g5VsQOa5o3haZno6
 wBkEV3lITuiK46pFUptLsZAMBgGLHoJ9oMyiUhmswod+b557eaENyiuJu+57f8UpPVgsZjQ0rqK
 hpODJlnh9E8wbDyK6hz7hC0S6RCcRkY7mLGv/4oLcFRHGlnBIYyQrIOoQWW6zk5q2SFOaA5U2j+
 JzO8RPoKU3tMGFG1totkPQON1mjZltN9XCrOHHCEAKxM4GauAUftYT4NbF6nXHCycCsTwpyGNqu
 MJb4yPwqW4mRani
X-Received: by 2002:a05:622a:1148:b0:50d:d1ea:65dd with SMTP id
 d75a77b69052e-5173a722af3mr169052191cf.14.1780336205151; 
 Mon, 01 Jun 2026 10:50:05 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741d6a240sm60989871cf.18.2026.06.01.10.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 10:50:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU6m4-000000027Uh-034u;
 Mon, 01 Jun 2026 14:50:04 -0300
Date: Mon, 1 Jun 2026 14:50:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601175003.GC2487554@ziepe.ca>
References: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <ahn3ovmkEq-Y-LKt@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahn3ovmkEq-Y-LKt@kbusch-mbp>
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

On Fri, May 29, 2026 at 02:31:30PM -0600, Keith Busch wrote:
> On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> > On 5/29/26 08:34, Zhiping Zhang wrote:
> > ...
> > > There's no in-tree vendor PF driver
> > 
> > Well I have to admit it's a bit on the edge but this sentence is a show stopper.
> > 
> > DMA-buf is an in kernel interface for buffer sharing between drivers and any change to it needs an in kernel driver as justification for the added complexity.
> > 
> > > - the device is a Meta MTIA
> > > accelerator managed entirely from userspace via VFIO passthrough.
> > 
> > When you have a complete open source driver stack which utilizes VFIO passthrough as the interface to communicate with the kernel drivers then we can eventually talk about that.
> > 
> > But as far as I can see without upstreaming or at least open sourcing the full stack to utilize this functionality it's a clear NAK to upstreaming this.
> 
> But the existing dmabuf for vfio-pci was accepted upstream without these
> requirements. I see you had concerns about even that, but still Acked
> under the same model that's propsed in this series:
> 
>   https://lore.kernel.org/linux-pci/57b8876f-1399-4e4d-a44b-1177787aa17d@amd.com/

To be fair that is quite different there isn't a proprietary userspace
issue for that series, and there should be more users of the API when
the GPU drivers migrate..

Jason
