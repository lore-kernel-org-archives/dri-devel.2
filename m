Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF5AF9D0D3
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE7810E076;
	Tue, 14 Apr 2026 15:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="E3vbq9Tb";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBB410E076
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 15:11:28 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8acb550db18so19085056d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776179487; x=1776784287; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
 b=E3vbq9Tbt4XZ4hGOA7RvWRPn4WtatXM1ngB9yp2VBo3g077DRmKTdPpZrCsvC+8rMW
 LxNvxJvWf+WoGBr1i3JNbYpKdBNRvSxUdPHhOl/ihUbmU3egM9sadZp/pqGtn0MaGpGn
 mxz0Y0g+YftIhlJTIlVBx25burqzFU1mzZuv8LbAJVd3Y1SvcFZQ6HOtYK67tb6EnHlf
 jUEWXEGsWKSsCnIats/m0e6skLK4t/6Km+LV5STPWHJbR577rEJADjJlSPHbuhoh1jPL
 2A2JoEf7F6mQISUr70ZQsiLBtV+ZnrJvKz1sLgmgly6g/MUAWTcJoMopVpnrGIXGtja0
 5+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776179487; x=1776784287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
 b=gc+JadMG6V1KRl+J0RKcHmQrDT8n59zqeNb5CltcZFW95kKVej3ISnEpxAU2TbU0Vd
 HhvbjcpKNVYEIRLP081pkzBshVPXvaRgrt2FOcEcXvm3fbOqRpxkcUGKe4QLoWmHszHG
 FPEo6kJxrXU9NrE56ddny6kCGgAkWoLKyL79rEuRueNYXfgiO8/Xh0dICxsxsRQjdU2Z
 AzGyRHRvyCT/9+EJqymi3cxcFg/vLsF0XinogC/IwJcR3DgcEiVrgT+gMpt7hpxXlBwS
 LWPa9rHRcQRNcmkfCA4Xh3tWSR/rhAsahjpCJT1/7crgmBVKjUfzzKtev/w3Lwr93JJX
 FdNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hHoyMDva68GN5XjlqdKv1FDvhparxC8xjtkn4eN89Lxb/q8SwdBjPnSxDvtI843rZ/qAOR70x4+I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNEWmae3ePWBJjM0Oi1gg7+SgjGdVYbCC2V5Xh91oS3hpoj1S0
 Bz+2w6fBX9yK9aMxoaYWImxyLnMahz/Si//7gCQfDb4pI24KhJk0N5kCmqJoQG6BQ8E=
X-Gm-Gg: AeBDieserngifyLZDAbZSe0cfm/oSS0NZnT3hdkyeV8t/V7jmOF6S8KcXJZV2NhAwcN
 g85eUpbNdfbjc3k+uHJVpfow0zKmoLlEIVJJjho9jbYjWBLYUGiqmeBQUnUIDOvaZZnmBqGPiS6
 E3vh4EW7t8qnL2rNIDlRbP2GZzZk+0h507+ksgl3Oo7SEDuc3sw0LDK4Om9VeFzNZKpB75dsu5c
 5yuA/qpQ7zryxNTMG6CHRaVpkI/SxG5E0+DSWod2dGVtLAHcspqEYs8aO7Kar7UlroiGg3AMJBV
 yQUgqFi0gB9PwUHLhGErP7CjtJ7R1/HtjWPwQh7NSApjnV76lp2qhIXvgkgSR1yD9Fdbpways9V
 HUcLUjBk9gSAXEoHTpSUvJEKg0vDHTM2bPwzcbqFgO1IQ9lqs6pPkpx/lNc5rlLp2WeoH+Ltjac
 lrGlhPCTBXoC5GOxsG4pYoC7BXIIdC+jsQry45xGzgXTaO524yA4qlQ5/S7/sCgFtOA4vWlpO/j
 DXgbA==
X-Received: by 2002:a05:6214:4a01:b0:89c:8709:d238 with SMTP id
 6a1803df08f44-8ac862b51e2mr284214856d6.40.1776179487026; 
 Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac849e35afsm159006516d6.3.2026.04.14.08.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 08:11:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wCfQD-0000000BNfx-2aVf;
 Tue, 14 Apr 2026 12:11:25 -0300
Date: Tue, 14 Apr 2026 12:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414151125.GF2577880@ziepe.ca>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
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

On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>    We have a real platform requirement:
> 
>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>      * 4. Userspace must program STs into vendor-specific registers

No, this is nonsenscial too.

If you want to control the steering tags for MMIO BAR memory exposed
by VFIO then the DMABUF mechanism Keith & co has been working on is
the correct approach.

If the VFIO user needs to control steering tags for the device it is
directly controling then it must do that through VFIO ioctls.

Nobody messes around with other devices under the covers of the
operating kernel driver. Stop proposing that.

Jason
