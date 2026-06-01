Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD33CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470E0113767;
	Mon,  1 Jun 2026 18:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="iiFUWkMR";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F4029113767
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 18:48:40 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-91563382bcfso126839885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780339720; x=1780944520; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
 b=iiFUWkMRho8W+ZsCFS+UK+SiBDuR12toTKA21klsh6iE9ofdmWh02LcY8Gzn/gzuj+
 dVU3QTJg0T6lXVHqFgCVhl0CXFY+w2uIPIDh/7OdaDXzLrFzk14r41kpZl9uLgiGPQpp
 rDC/3N3kKxspGnzEM2EtSuCWUxYpmFK91dDkyf9JZxms+H1reIMvr+fQ99l9uVsjnw2C
 QuQEA+0KxBdaYri6sLhTxJF/gKuaHg4NXqtSG8+hGfigL4DGIUI7c9//jiYQNGW+MOuY
 wpO7RJObnUMy/qRQDrVENEOkTfDkGOHxP9a6GXLIok2hVSvAUn8OYYaeokvrDvFReSUw
 vDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780339720; x=1780944520;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOVGBJ+B1pIGsdNReY7mg4M6+73TAYZ+OPVziP9NXJE=;
 b=nJ9hwlTy0qBkW58rlmgXT3+tIJgirKR2hJHlyBeqZix6TF+qSidTxIq4sWqMr5TRHS
 a758QlmfQ4KqcZsdYm6AepBW0qKFPVuEAgv7j3ZVwsBDadeEOFm1kU6/C6mlBq9vdXRn
 cEexzQHH3CU/BLnW0Xh4AgKxucK8FRq89qo3qscr5JopyGTEZ1zUUwXFLUiJs6gR8E/1
 0Pw47/0bPYmfhbCdDuDwp0+Ph+TzD8SzmPQzx7AbrGvHyEjbCa55HatmEf53iBlQPM+J
 iETy6Qvop0Yg/tB9UpbiaxaA+lDMG7NJbblELIXo9zc+lf+ExfJ9t3sK77azvTec2k7R
 tlrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xv1LEqxRtol0Vbt/h1RRILiEZJXdKhizgB6H08vHCAM9DtkjZmMSPNzrd1kyL447DK9QNrRWNJWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsuuFnVUihDjbRQz5Xm32Q/NRTPUDShLkdSLlLL4Drhj2kdiSS
 rmtZ1rGruWbp5K6/vc2PmNEYNuRUY/pE5bod3DYWyyPQNwD45vceNL2UPx1HQZteE8AFz4QSJbz
 ePlU8
X-Gm-Gg: Acq92OFSaKXf1+30Zy5ITvJqt7Ht08bX6Mvv/Gidv6UUuPBDJ4ku3BZz0TVgikicuQp
 6thPNf1o2+cuXirsCpYOFJ4KdyiHM7tRUgwlXqA9GajUmtUZF5gu2CEa1sLqAnwFmVZze1jD/1u
 2LVzrSTNmaZyVPfh1uD5CaOO8zl6rA0dnMuUZ2eZwPL4xS0fyVtEW5DnNOLNku9YfvL9p2BA52N
 zHeF8dv/G4+PoCFnPxJkZFfH2iPV37pjw2kQz2vsG7aiTLqtlWMXDw4rdssuSJqPjikgFazFSZd
 2ppsaJrl0lef1TNG0DNp5wABhrnbsa8GFhTDEvLEsrxo/k5o+ZDomhR9iWmwmEnB2RqR3UkhWVB
 7+ZogLpc8v3kjVW55/SotcrudxJeadbo3vhRgTkvQwYFOfSsWrZLwRs4rcPGMJ1UaM54Xy6e8wb
 Zj0LfN0GUS3750OdluBtPMFR61MHjI50viSrrqDI2nmo4XEYGXrgRXWwqLZo5KlHUJA/zaEthbJ
 BdQ/rSECPIH9QWX
X-Received: by 2002:a05:620a:630f:20b0:912:1206:ddd1 with SMTP id
 af79cd13be357-9153d93b157mr1356674885a.1.1780339720004; 
 Mon, 01 Jun 2026 11:48:40 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153262f45dsm1098180085a.41.2026.06.01.11.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 11:48:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU7gk-00000002GHG-3uxy;
 Mon, 01 Jun 2026 15:48:38 -0300
Date: Mon, 1 Jun 2026 15:48:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601184838.GE2487554@ziepe.ca>
References: <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
 <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
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

On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian König wrote:
> On 6/1/26 19:47, Jason Gunthorpe wrote:
> > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >>>> When you have a complete open source driver stack which utilizes
> >>>> VFIO passthrough as the interface to communicate with the kernel
> >>>> drivers then we can eventually talk about that.
> >>>
> >>> That decision is not up to dmabuf
> >>
> >> Yes it is. This is the DMA-buf API which is added here.
> > 
> > It is a DMA-buf kernel API that is added, I think it is overreaching
> > to try to veto a VFIO uAPI that calls it..
> 
> Well as long as that is a private interface between VFIO and mlx5 I
> have no objection at all.

Well, as you know, we are using dmabuf to mediate many of these
connections now.

I don't mind a "private" interface as a starting point, but it does
need to discoverable and negotiated without weird module dependencies
or symbol_gets.

> But when it starts to affect DMA-buf I need to make sure that it
> works for everybody. And without even being able to test it that
> becomes really tricky.

They should have an argument how it can be used for CPU backed memory,
IMHO.

> > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > VFIO uAPI that can be re-used by any other device that happens to
> > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > based around the PCI spec.
> 
> That it's implementing an official PCI spec is a good argument.
> 
> But on the other hand looking at the spec it's not really specifying
> much since everything is architecture specific.

Yeah, spec doesn't say what TPH does when it is received. It is
intended as an opaque channel between the source and target.

Even on the CPU DRAM side we make an opaque call into ACPI and the
BIOS returns back the right value to use for the CPU. The whole thing
is agressively opaque as to what the values mean to any particular
device.

So I don't have an issue with VFIO supplying a value for MMIO it
owns, it fits the general architecture.

> > Anyone can repeat the demonstration Meta outlined in their cover
> > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > VFIO uAPI says they should be set.
> > 
> > There is nothing uniquely tied to Meta's device here, or unusable by
> > someone else's devices. Arguably this is actually a mlx5 feature to
> > allow VFIO to control its TPH generation HW.
> 
> Would it be possible to demonstrate the functionality with some FPGA
> implementing an PCIe endpoint?

Sure, you don't even need a special endpoint, any endpoint that
doesn't explode when it receives a TPH is fine to illustrate that mlx5
is emitting it correctly.

A fpga reference board with an out of the box PCIe IP demo is likely
entirely sufficient, and you can use a FPGA logic analyzer to inspect
the packets.

Though keep in mind mlx5 is formally supporting TPH in a growing
number of kernel contexts, so we do test and verify our device is
working properly as an initiator. So I wouldn't advocate anyone
actually use their time on FPGA :)

> Doesn't needs to be anything funky, just the ability to exercise
> this for basically everybody who can spend a few $ on the HW.

Topologically you also probably need a PCIe switch as the CPU P2P
likely discards the header.

Jason

