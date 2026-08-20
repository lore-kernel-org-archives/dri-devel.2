Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84690C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAA310F024;
	Thu, 20 Aug 2026 13:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="dUuUWwD2";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F1410F024
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:27:38 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-51c2a76536bso21669091cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1787232457; x=1787837257; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+OWRyp1Na2XBrlQ7bIW9EaBkPnu+lSJuThzM8dmXiRw=;
 b=dUuUWwD2QZQmTHNmxV/JJ1NG1kQG6YJg0a/lEEQQRcrp7aZYGA0NZdWzsRNKySOxe4
 lVVcsDYu8ThwM/nm+E1m1uLSnjHx9wk1+pFF4s1E1cAe4i1CWsJIIulhQWWfVd8ACXDo
 kTOO9NjEA7GVNtY5oBIkwXgbEgrQqbnr0misxoVxSj9a/ldBHr2n+ptzhaSeCWxaHODU
 HxpUyAAScsbRj8pBR18ogbRXQS3Oy3F8C22CGAMO+vPeyqqL37Cnqxp6EOv9S00UO/o3
 7cMsACQ7xfAB0iWeXmD1v7yaY1BgExJNk4ilXWi1/vBm7XDsuUAgsZZ6p/Wpt/8/qLx4
 k5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787232457; x=1787837257;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+OWRyp1Na2XBrlQ7bIW9EaBkPnu+lSJuThzM8dmXiRw=;
 b=WwKnKsX2MqpQSC9TsYzlne15R8zzNcA/yy11/XtXpvnr0eMLzxySiM5s0q3Hl0otQl
 S78OwWL/IkbVt9ACTgPv21hVpYUebu4Tf+zemeR6J37xz0p8/M/pXml4NJqz5nsYtFxe
 pSFW+w33uzK7r+W0WFGPdmXvYPV6fiXAIFXbzWxARTHtRg1qlICRSEBHIbEIWPv/A8Gg
 pHivCk6Tfm+j56Iw7LfHICBX4mSRcAk2PgTENIVz9/xPJ8axZSCe+gs3p+t6dHmhMb37
 z9YVjpbQdYJy5LzIgoLE9mvk7XpYlB0BB1tRhL82xinOVTPLLHPabI/lQvtggS2OYWte
 dZlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrb53pQTZ+cKDvgKiy4L5ASTa3DS6C6CvrZrbKzQf4ghri/01kTrQcEJGWvMIRol8di56XIN89FaQc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCCsYFL3q+wiI7Ttj95xayrA20uZSewxA/YHdkpnP3tELstar5
 4O/6rvted8knb6Ly2Ev07RMtUkEBhRi07t7UYXga9e2uWOkGDfHLaPdMcQ+aLT2P7EI=
X-Gm-Gg: AR+sD10clUZPm1buvHHPQtlxcyl6OBpVxLnowbcia0o+nPwIq0I2FxE9D2XhAC3Jm5S
 oGq0IrbFAirvkTzPM+qFqtT9pqcaK7wBOyoCVg+xEVNOQbyqZhkZPGspIMZO1BoA/Mofi9bwiZ+
 U4Grmuz9haevACAMJQP9EY6IIwXQYVfHMwJQq1odhLVAbYDFwE4o5PTbVyqM3Z4CNk0MJmPOO0J
 0MuAYMRHoNqmIfMe8OWAGgVl38SXnkYQ+KsRGH2ddTcb16QNGs0Um+3LQYZvG3cfWC53O1iyxMv
 ttgc8GS3gfwdH4Kz3X6bPkiRsUHEuzmcXuRKWoJeidFNzRJn+4Dg9uMN8fjnll/qjTZJBEGcHnO
 ScHORTHUHTD5tMJ3AxCEdIubPisHvBnCxzzhGbwBrHQNPySpQTO1i4Z+y2QoAWUoXsta/XUiStV
 cdZsv/C7fSvhRoWNBrX6yvEypbDisk7feIyotCTsVNNZCjtIpiYTg0GWJwgsV1NFbXyd2Q3hU0e
 VqH8aIZMwu/s5vI3J4h5gDI2CYt+yJ+FEXflsDcgtOePg==
X-Received: by 2002:a05:622a:5149:b0:52d:ce86:1393 with SMTP id
 d75a77b69052e-52dd5cecc34mr115534681cf.37.1787232457641; 
 Thu, 20 Aug 2026 06:27:37 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd857b6b1sm30570231cf.3.2026.08.20.06.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:27:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wx2nw-00000003ikC-1Lb9;
 Thu, 20 Aug 2026 10:27:36 -0300
Date: Thu, 20 Aug 2026 10:27:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 1/2] irqchip/gic-v3-its: Zero shared pages after conversion
Message-ID: <20260820132736.GC18100@ziepe.ca>
References: <20260820105026.53208-1-steven.price@arm.com>
 <20260820105026.53208-2-steven.price@arm.com>
 <87wltlnfay.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wltlnfay.wl-maz@kernel.org>
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

On Thu, Aug 20, 2026 at 01:32:05PM +0100, Marc Zyngier wrote:
> On Thu, 20 Aug 2026 11:50:24 +0100,
> Steven Price <steven.price@arm.com> wrote:
> > 
> > its_alloc_pages_node() passes __GFP_ZERO to the page allocator before
> > calling set_memory_decrypted(). This assumes that converting a page from
> > private to shared preserves its contents.
> > 
> > For Arm CCA with MEC (Memory Encryption Contexts) the key used to access
> > the page will change, and so by default the visible data will change.
> > The host could ensure that it zeros the page, but rather than relying on
> > the host's behaviour it's best if the guest simply zeros after the
> > decryption rather than before. Specifically in this case the ITS tables
> > are required to be zeroed.
> 
> What are the guarantees that we want to enforce post decryption?  My
> recollection is that the RME firmware cleans the caches to the PoPA,
> making the data immediately visible to the hypervisor. Obviously, this
> isn't the case anymore, since the zeroing comes after that, and I
> don't see any CMO enforcing this.

I thought any CMO stuff was principally about cleaning things as part
of the MEC change? Coherency after the memory is made shared should
follow the normal cachable memory model rules, just like in a non-CC
VM? We don't need further explicit CMOs for that.

Post decryption I would expect from all architectures:

 1) Neither the guest or host take a fault/error when accessing the
    memory. ie the host may immediately pass this memory to an
    O_DIRECT system call and have its kernel read from it.
    It must not crash the kernel.

 2) So long as the memory is mapped cachable it should follow the
    normal memory model visibility rules. ie it works the same as
    VM CPU memory prior to CC

 3) Rules for actual DMA are the same as prior to CC, the VM is
    expected to issue its own flushes prior to DMA if the platform
    requires it.

Given the requirements for #1, is there actually any case on any
platform where the host doesn't *have* to fill the memory? Is there a
platform with MEC that doesn't generate an error on reading with the
wrong MEC? Without MEC it surely has to be zero'd in the RMM world,
right?

I've argued before that set_memory_decrypted() should be defined to
return 0'd memory. I think there are real systems that *have* to zero
the memory as part of the state change and this API is now
forcing an extra zeroing.

> I'm concerned that this relies on undocumented behaviours that may
> hold today on some undisclosed combinations of HW and hypervisors, but
> that are not guaranteed at all. set_memory_decrypted() doesn't really
> say anything, and I have the feeling that we may want some hypervisor
> specific hook to perform the correct CMO magic. I don't think this is
> required right now, but I'm not excluding anything!

I would expect any required CMOs to be part of the arch's
implementation of set_memory_decrypted()?

Jason
