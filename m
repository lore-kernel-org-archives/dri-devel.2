Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAF5CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 20:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866B91124B5;
	Fri, 29 May 2026 20:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q56lhMre";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DB51124B5
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 20:11:33 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-914b5f85129so697282385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780085492; x=1780690292; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
 b=Q56lhMrezsDg7AGVLT6RxDmAtrJg/bvrEdxOUmv5ouutZ3dmAYkfVSiR55zl3JQ6ql
 +Ise5aoRORvmZLAv+5+kCDAy6Q3P5Wmn/RUKe9OWOk5cCpWobFojWWdp3HojzUf9L1VD
 gDACNcb/YGos+otqXAGlV7PCuJJBuJUXM2i7wBDci7xIaolY/1QTT9AxHQLnr/2oTZ0F
 e9UFhtOu8fKAfeI8MPT6GeG2a6/vSC02ZW57M+3tc2VV9i5nLJspVf6/hm3gr49EK0RP
 RL4C3BhsFPNdpn0HxKlgUcWgbufp8yw/yUETTxzeJ5Y3Ea5HaQkN8K2eURPB4dur2NYI
 t79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780085492; x=1780690292;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
 b=QMC/iV9TXNZudnrBob77kgShyG5NymxwDX0K+7W73t5NM6uqq2ol21WRpw2cz5nJ7g
 c4/AjirxvM/1jeAUIgexlfVfFdWV9DpR8mql8JAFv00kGWcVuGWJmIDcdVl38PhYR0Iz
 CO7K9I+YGCCeS/i4NAsRwWg0LwQ80eUDjFR7OUtYUh3w5qS4aEsKdvv/+xn67VPf+221
 LAZ8dD8hHbbOJ7sfCoN7EiNHGAMoCWTppsz8YnxpjIJC2gI9hDQ2FBZaI6wPkleKVFxF
 /+bav/KGb3xBUAoy16Ll1xmW/F4RG/fQCEr85zCmjElPF4i5eeqYHGZzj28PdNhFOR1I
 CX4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XXqlLaIUvQqQOdvU6pNxt0Vl7B0e2wyau+CgOsLSo80PyiWIwTwdLZ8Mn2qf2oUjh15BoQCCShtA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjO4wtvQKDUTkEInyA5V60/vU3zIksu+f96EjsYxyPIb+kBV/3
 u/8icrY7RiQPovcKA4jo46CxFca3OhaGFG5PNvQ0fIwE13tbneunEqh6H8Ip+zaYkIg=
X-Gm-Gg: Acq92OF3L8MUOYbuxh4wClhq36LE4zLXPJz48ITZKhUVfXGCZVxfiwS4MCSH0eSRRXV
 fJq8zID45dhif2WvAXE7QHN5U5GgzYeQocCSwrdPUALjiS7ce0QbZPzjCzRr60VKXlVe7E4cOHO
 25w2rJrVvPstYZQsEjiDTrH9iJnCxjKARfKh2nHbmT7mgzxWzGrDx/5GU2rMlaAnIh0jn1Rfy6O
 mXv6Lerh8ayfIPvNak8IiWrNvC1A62hA+OZ3WXkcnE0TaX4F+QXm5vPwK+AuuY5WoIvR4IpBeRA
 eb1wOyBrvwd8IRsJPPQ83J0jQk37uMUMIMdBY4cUl7Sxdtc9fTD61wfkPnG3yx7kgPVM1cofZmb
 7KcuMEr4FsoIwU2jAGVot52jQ4H6Ju4fsxmmgIGFZPQTmhDRIidLF8Y0hNtXntqvGuYMBjFmyRQ
 IWLdM3wlxQhGgs1MMeLi3njpIpGjJ7IRKf8qWXIU16hD2AA9lAWllTMlhqbxA/CYU1K9P2gcGcK
 skSCe+1lDiEhVMC
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id
 af79cd13be357-9153d999728mr194543785a.24.1780085492316; 
 Fri, 29 May 2026 13:11:32 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153244de53sm312617585a.8.2026.05.29.13.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wT3YI-00000000q8h-45Mx;
 Fri, 29 May 2026 17:11:30 -0300
Date: Fri, 29 May 2026 17:11:30 -0300
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
Message-ID: <20260529201130.GU2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
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

On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> On 5/29/26 08:34, Zhiping Zhang wrote:
> ...
> > There's no in-tree vendor PF driver
> 
> Well I have to admit it's a bit on the edge but this sentence is a
> show stopper.

I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
driver.

> DMA-buf is an in kernel interface for buffer sharing between drivers
> and any change to it needs an in kernel driver as justification for
> the added complexity.

vfio is the in-kernel driver, this series fully shows the in-kernel
API using vfio as the exporter and mlx5 as the importer. It certainly
meets the standard required to show in-tree users.

> When you have a complete open source driver stack which utilizes
> VFIO passthrough as the interface to communicate with the kernel
> drivers then we can eventually talk about that.

That decision is not up to dmabuf - what VFIO subsystem requires to
accept a new UAPI is up to the VFIO maintainers.

DRM and VFIO have very different views on what is required to merge a
new uAPI.

Jason
