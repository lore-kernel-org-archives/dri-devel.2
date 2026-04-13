Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C4EBFD2F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A1C10E3AA;
	Mon, 13 Apr 2026 10:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CEQIE6k0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B82410E3AA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:01:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C9D060172;
 Mon, 13 Apr 2026 10:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B5C116C6;
 Mon, 13 Apr 2026 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776074517;
 bh=mlzyEmNbjtIL7vKwRnpEy6oi+2Tn09KmOp9o8MEUcZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CEQIE6k0EkCZR5gvUuRtGYRFHxBpBCUa0TuPqj77hqQrjQpnn6rBfnWHoQSbph/bT
 Fe9B/oOgXmRvwX+hiH5/hWAIYcDMNdMw79ZbZGOSTMtKIUvqhLT0R0/n6jPiz+O0wP
 W6KpUg4uQUk/Y2lnUKta40eTICc/PEDstDblrgFksvzKk99GaAmVm1wCBHteXSnAWr
 vB+VVor/EgXH1A/WtlIOe1Ts5XuCXa+acSf9oXu9ey5ZE0khuuLLTa22AfdJzlPcPd
 u9LhjZ+/zXvgbyeZqyXzvQnzLOJGnfd3b0lr15uLDAPgu+5x102R9LYktMfEHh/7ZA
 ELny7wvyWc3oQ==
Date: Mon, 13 Apr 2026 13:01:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260413100152.GG21470@unreal>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
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

On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
> Hi all,
> 
> I'm writing to propose adding a sysfs interface to expose and configure the
> PCIe TPH
> Steering Tag for PCIe devices, which is retrieved inside the kernel.
> 
> 
> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
> (identified
> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
> user-space
> applications to fetch and set this value securely and conveniently, we need
> a standard
> kernel-to-user interface.
> 
> 
> Proposed Solution: Add several sysfs attributes under each PCIe device's
> sysfs directory:
> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
> device specific)
> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
> operations, e.g.:
>    Read operation:
>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>    Write operation:
>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
> 
> 
> The design strictly follows PCI subsystem sysfs standards and has the
> following key properties:
> 
> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
> devices that
>    support TPH Steering Tag. Devices without TPH capability will not show
> these nodes,
>    avoiding unnecessary user confusion.
> 
> 2. Permission Control: The attributes will use 0600 file permissions,
> ensuring only
>    privileged root users can read or write them, which satisfies security
> requirements
>    for hardware configuration interfaces.
> 
> 3. Standard Implementation Location: The interface will be implemented in
>    drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
> attributes,
>    ensuring consistency and maintainability within the PCI subsystem.
> 
> 
> Why sysfs instead of alternatives like VFIO-PCI ioctl:
> 
> - Universality: sysfs does not require binding the device to a special
> driver such as
>   vfio-pci. It is available to any privileged user-space component,
> including system
>   utilities, daemons, and monitoring tools.
> 
> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
>   straightforward, reducing code complexity and long-term maintenance cost.
> 
> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
> specific to
>   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
> kernel's
>   standard pattern for hardware capabilities.
> 
> 
> I look forward to your comments about this design before submitting the
> final patch.

You need to explain more clearly why this write functionality is useful
and necessary outside the VFIO/RDMA context:
https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/

AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
right ST values.

There are several comments regarding the implementation, but those can wait
until the rationale behind the proposal is fully clarified.

Thanks

> 
> Best regards,
> Chengwen Feng
> 
