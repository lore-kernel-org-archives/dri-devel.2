Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E83C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C7610E1E1;
	Mon, 10 Aug 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LgzCGWYT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DEC10E71F
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786349107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+a+0U5GgUWNz5gXhQg+X0ag29Jj0knQnRmccGbHPwc=;
 b=LgzCGWYTnAx4MCxnZ+3XiExT+6PsC403lR+ZYOkXy17wuGjBgi5THETewV8/kUftFLk17R
 PSLO3v1Vem0L6AKPzRLPS1JuP4+188golcZnsscP/EMnWrryJ5JI85YcthvGJbuSTHaTrv
 1C33kmFqV17ElB0o+mThWEzsZnNi/C8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-nxztM1ttMeC5K4sSg_ZusA-1; Mon, 10 Aug 2026 04:05:02 -0400
X-MC-Unique: nxztM1ttMeC5K4sSg_ZusA-1
X-Mimecast-MFC-AGG-ID: nxztM1ttMeC5K4sSg_ZusA_1786349101
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f83416551so1475683f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 01:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786349101; x=1786953901;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/+a+0U5GgUWNz5gXhQg+X0ag29Jj0knQnRmccGbHPwc=;
 b=Bzrc40j6k1R4Slm120HYVoc7bjaiMsGwdRSEqyQ+eLFsslmsZDptnNFRIGRxZbZlNr
 CGtKR9659+fUEaSk7QzqrUksQIsSqCFPDrDLqkKiBsuVWa/xLEo7msdu8h/nxcMppDkb
 DjYnxHAFsKF9rdATwnhEoMQCO5SkmCOL44X6Za62hzRky96B3OQBV4iPBG9bv0lwtaGE
 VAgZ1IaEBXVXUSZK2xj8yxvGtV602L+tReZCncfwCIt8exZRbxswdqnRAnMr4SZ04MG5
 7YgEemPolVlnth3SeGbBcWCpNKWplmQklMSgD3QOpU5hLI5vVJSM/LDniUte/mPPcbfU
 tfQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkhaBhcDeYTsxWSh03Mw01kWVCqUaPoCwOiIujLnQhyEpJ/88SI3i4oX/EmwvXHpxiQkW3FW77bsg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypMopMqJu5Tc2bAZdOmcFbIO48Mp7h++dAUYSX5j192Ux9ojW8
 IhNNzU1D5vKx1JpdVPeYyJ18fTgtFgFkHFvuxFBF91m/KQPmWcK+Xhjy4dGBQgNffg6B46CLfWW
 udgGwA4x2AbErjVigRBzOIfGx0qbA4hKLc8YetYwuJwGH4rFYSZU8yHizMW9/g0cyg721qw==
X-Gm-Gg: AR+sD13cB5oZ//CSZRSZFEaiO78vwUZne3x7CM8152YsHlWHEbpmEmGRXwDga71jOJR
 AhThLNtS/Rig9YzyHhOahjVn6rfbCPnhq9tttlPVwk245MrcvQNLY8n53NzW1yXR0FP2d34rjOZ
 aKppjDvI1JAV1xYs1ViIW5I8URdrRG6nt1KhvRsbUNlOcdbvxhslJwWJG+BW54+AaOB4kAOo0Am
 +nnIiaaXD5XoipPel7EfFxwaCDSjIbfzB0HaHBIP58jfz3aLSEItk1GNNAGk7cfs7us4Xmxk1r0
 OlSFHRyjhVJC+i1BFYfoCEC29eLp7qLpxLXUsD6qLSmugYh56YwlsujbFhyvizJ6yo5eGBr0xYm
 Wl32I4BUSzrRSbB6370OTIg==
X-Received: by 2002:a05:6000:430a:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-47ffd203e5emr38268903f8f.2.1786349101180; 
 Mon, 10 Aug 2026 01:05:01 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-47ffd203e5emr38268788f8f.2.1786349100617; 
 Mon, 10 Aug 2026 01:05:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8b09sm35811136f8f.23.2026.08.10.01.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 01:05:00 -0700 (PDT)
Date: Mon, 10 Aug 2026 04:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 David Airlie <airlied@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Feng Liu <feliu@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nh-open-source@amazon.com" <nh-open-source@amazon.com>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC PATCH 00/12] virtio: support devices that own their
 virtqueue memory
Message-ID: <20260810035246-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260810021450-mutt-send-email-mst@kernel.org>
 <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
MIME-Version: 1.0
In-Reply-To: <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jcGuVjEAh5d8O2NdwugKxgn8KdX0GO7WiJAasqds27g_1786349101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Mon, Aug 10, 2026 at 07:39:02AM +0000, Graf (AWS), Alexander wrote:
> Hey Michael,
> 
> Thanks a bunch for having a detailed and quick look!
> 
> On 10.08.26 08:23, Michael S. Tsirkin wrote:
> > On Sun, Aug 09, 2026 at 06:19:58PM +0000, Alexander Graf wrote:
> >> Virtio drivers use guest memory to back virtqueues and their buffers.
> >> That means a VMM needs to be able to map guest memory. That is ok in the
> >> normal virt case. It gets icky with confidential computing (where we use
> >> swiotlb as workaround) and it defeats the purpose of isolated vhost-user
> >> backing devices, because they end up with full RAM access to the guest.
> >>
> >> So instead, I'm proposing an extension to virtio which allows it to give
> >> each virtio device its own dedicated memory region to communicate with the
> >> host, called DMB (Device Memory Buffer). A trusted hypervisor can force
> >> DMB to be present, which then enables safer, more isolated and resilient
> >> communication between guest and host.
> >>
> >> With DMB, the device provides a shared memory region that both parties
> >> agree is the full memory map both have access to. All memory offsets
> >> that previously would have been into guest RAM, are then offsets into
> >> this shared memory buffer region. One nice property of this is that it
> >> is a generic mechanism in the virtio transport layer, so higher level
> >> drivers work unmodified.
> >>
> >> I was exploring to use swiotlb instead to create individual pools. But
> >> that approach has multiple downsides:
> >>
> >> 1. Swiotlb is an OS primitive which is not available in all Operating
> >> Systems. DMB however lives in the virtio transport layer, which means we
> >> can add support for it in any OS independent of generic layers. This
> >> helps with Windows support.
> >
> > How does it help, if you are going to put a pool in
> > the driver, put a pool in the driver. Maybe with virtio mem to
> > simplify allocation.
> 
> 
> I'm not sure I understand the suggestion :)
> 


I'm not sure what the problem is for windows :)

But if you want a chunk of contiguos memory that windows
does not poke at without a driver, virtio mem is that :)

> >
> >> 2. We munge DMA space together. DMB provides a separate DMA space per
> >> virtio device. This means we can for example implement a device in
> >> vhost-user and give the implementing process only visibility to the DMB
> >> region, not all of guest memory. That reduces the exposure the
> >> vhost-user provider has, improving security.
> >>
> >> 3. Devices can opt-in. A hypervisor can choose to use standard virtio
> >> semantics for self-implemented devices (e.g. NSM), while requiring DMB
> >> for devices implemented by less trustworthy providers. The
> >> non-trustworthy devices do not get any visibility into the trustworthy
> >> ones, even with DMB in place for both.
> >
> > So I am not sure whether the implication is that it's purely a software
> > construct. But if it is, can we extend virtio iommu to
> > add a way to discover and enforce trust boundaries?
> > And maybe translate offsets to BARs, if that is desired?
> >
> > It seems to be that the result would be that we don't need fiddly
> > special casing in virtio ring specifically, and a lot of things like
> > pre-mapped dma will begin to work.
> 
> 
> On thing I'm trying to avoid is dynamicity. Anything that dynamically 
> changes visibility or needs state tracking is something that can go 
> wrong. By keeping everything self-contained within the guest, I can 
> reason about what is visible and what is not easily. Especially for 
> confidential computing, IMHO static wins over dynamic in general.
> 
> Or did I misunderstand your suggestion?


I get this part. But we can absolutely make it static.


Let's start by replicating your functionality with virtio-iommu.  So:

-device is behind virtio-iommu
-virtio-iommu tells guest "this device can only consume memory from that range,"
-and maybe: ...and translation is 1:1 with this offset

if guest does not acknowledge it will just fail?


this covers the proposal here simply by using a dedicated range
per device, right?



But look what we can easily add later: share a range
between devices, now you can move data between them with zero copies.


Isn't that better?


> As to pure software construct: With CXL, you can implement the exact 
> same protocol on real hardware as well. All it takes is cache coherency 
> of the BAR (or whatever the transport uses) region.
> 
> 
> 
> Alex

Yes this is what I thought originally, that you intend to
do it in hardware. But re-reading it, it begins to look like
that's not really the case, it's only "theoretically possible"?



-- 
MST

