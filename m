Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607CCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6060210E11B;
	Wed, 27 May 2026 12:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ooJ/Nq6Q";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBA010E11B
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:14:41 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50faeb8317bso105627941cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1779884080; x=1780488880; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
 b=ooJ/Nq6QEbh17dVWh/Kb8gS8depxtQvtAccCpSsaLSRBIzlP552ziWA6yFPU+9Tzni
 ZSXeHea4fMapRcMzhugRHNNzXwWSBnnL7sircMvJ/sbh+4pyEn1BPRxhlSqfwjP59jXQ
 //KoN4Wx7C23xM0eFVtFee0ol+t23i3CPBjskRwCZ4CUwUaVzfeZCD74rAk8LaiEUlsr
 pDJvQY12gXzZ8GXz7Bgio+2FHMQcw1cV9bCFoHZe39B3Q2Bwo45je7Dbmeca7T6VR0jL
 Ik/bVog3ZGP8QqItpm+Atg0KC6aSoLHf+WmN9Y2JJpw3tbSKrIl6VesrpMU1cEl6zUYz
 nomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779884080; x=1780488880;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
 b=b5yCQAmHqnmoKIstjZFs7xiEh5k0kQs7lh9VR77vuvv8taTDfAucCOvmgvXUvprkpw
 NhdX8xDh3ggIQGma3FABj9eLiG7NZbf6UNU4YvvcCoUd/Fsh+6ZIvzjiTs7ICLEY9KbV
 kldbAKecac32m9YfMK68+lsuIyU/hBznRVUgKfdLsK9fbohQa25MBPMVu9CXdV2WDxai
 LueNtH+yVWc1z3+yPtbbWibUZqv5uyt87L0nAPQ1JzFhLBE/BknrIW3qRDYu0z6zhT7w
 0QXCbZqx0FFr5n941RdASCUX9vfMYHuduoffnKaB5+0QREajE6jg+TCN5lglGp4SobKn
 I0sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hbncRoj8IuayXnGqX9jvJJzMxgCwjygi0RZiNKbniLNOm9xeDlId7GVTW/SNoiYCp+sYyvD6toOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIM+4qHkEfKLhJEu6Z2DWewtoECMsLJV6FElLS+9LzS8svNMPc
 ZYlBAKmhBbuEWUrzvlZmKQ9vekLrydNHPRfyNY9vtNs1rh2+EkYZKOXudpK4Cck0Btg=
X-Gm-Gg: Acq92OFLys6kKuoOUkoqRp30GmTXIXfp7oBfb4941qGik2iKmHpRj0i//+lgkAc1PMk
 6WhP4OVoQ6BTcGD1TjcgD8YHcKSM+W2kwbq0mKmYD43UKOkKJ5j5EOq1WLYOX25gnTuVw6AYC5E
 Re5mwYgFMTUMqi0uurjrFLMTn9qieu4wHbk2DBTX+gmpSbc88Ms04CUmnMIN+8dN88gt6Vv15S4
 IBMlnt7+hTFQwnLiMrCS91AFJ7habrYie/T27AkU5S/GfObpHbdPo0Dy0Ip1C/ItsICCPCCAOHn
 d4hEMKIop/BkpHtwVLf39TNwJkmLgZWZ6/Oa9JIt9UB7TuWARopIq5Y4uF/siKrSFMRJu1U7AJ/
 LqQw5sbhrlR1mSGF11Fb6fbvOnJ86AAiY+8cif6an15khS8nLuweyHhSZiNLmD5nPdUQdcPBn3I
 an4fC/NJhqXPOuLigRggmEi1Sj2s947kdV5vUYORu9eDVgFr8EAfdxm3YOV8DBQ3Ur1dCBP4eHO
 nFxdwd//K0iduy9
X-Received: by 2002:ac8:58d4:0:b0:516:d2cc:5160 with SMTP id
 d75a77b69052e-516d459212fmr302395201cf.32.1779884079723; 
 Wed, 27 May 2026 05:14:39 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706adc446sm39991901cf.15.2026.05.27.05.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:14:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wSD9i-0000000ENnz-0tj0;
 Wed, 27 May 2026 09:14:38 -0300
Date: Wed, 27 May 2026 09:14:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527121438.GJ2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
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

On Wed, May 27, 2026 at 08:55:49AM +0200, Christian König wrote:
> On 5/26/26 16:43, Zhiping Zhang wrote:
> > This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> > export path, allowing importing drivers (e.g. mlx5) to use the
> > exporter's steering tag when performing peer-to-peer DMA into a
> > VFIO-owned device.
> 
> I'm not an expert for TPH, but that sounds very strange to me.
> 
> As far as I know the TLP Processing Hints allow devices to give a
> steering tag to the root complex together with memory accesses to
> give fine grained control about cache usage. In other words it is an
> extension to the classic snoop bit.

TPHS includes an bit of data on every TLP and the data transits to the
eventual completer.

It does not have to be a root port.
 
> For P2P that is obviously nonsense because we don't have P2P support
> for cached accesses.

For P2P the TPH data on the TLP will transit to the P2P completer
unchanged.

It is up to the completer do define what it does with the TPH data.

Typically root ports in CPUs will use TPH data for cache placement
instructions. But who knows what a P2P device will use it for.

In Linux the driver that owns the completing address space gets to
specify how the TPH data works based on its own device specific
knowledge.

Jason
