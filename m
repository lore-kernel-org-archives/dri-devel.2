Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C76F9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7D510E64E;
	Tue, 14 Apr 2026 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="rd+dzGDr";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rd+dzGDr";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB94610E435
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 12:04:17 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7cEXSPR5yFHS4LAS4tuybv+AQrYQOOWxZH5AGU0cAX4=;
 b=rd+dzGDrJpa8Qgu7l+zQ0zoXIF5nnq4gSHdmjPq49OUS5Lzt8XMvEBhc3dvvXW4AFt2yT9oA6
 LejKNykM2J7GnPw+41MTJa5GKAIxQyMu5zsBtWU2jZYQ1xQGBa9WyIJ59oO8ePaPRIV1bHkDx6z
 Grp3JUANEDXeYsQtQ1d6eEo=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fvQzY2XgVz1BFsc
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 20:03:37 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7cEXSPR5yFHS4LAS4tuybv+AQrYQOOWxZH5AGU0cAX4=;
 b=rd+dzGDrJpa8Qgu7l+zQ0zoXIF5nnq4gSHdmjPq49OUS5Lzt8XMvEBhc3dvvXW4AFt2yT9oA6
 LejKNykM2J7GnPw+41MTJa5GKAIxQyMu5zsBtWU2jZYQ1xQGBa9WyIJ59oO8ePaPRIV1bHkDx6z
 Grp3JUANEDXeYsQtQ1d6eEo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fvQry6py1zLlYX;
 Mon, 13 Apr 2026 19:57:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A3A640571;
 Mon, 13 Apr 2026 20:04:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 20:04:10 +0800
Message-ID: <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
Date: Mon, 13 Apr 2026 20:04:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260413100152.GG21470@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

On 4/13/2026 6:01 PM, Leon Romanovsky wrote:
> On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
>> Hi all,
>>
>> I'm writing to propose adding a sysfs interface to expose and configure the
>> PCIe TPH
>> Steering Tag for PCIe devices, which is retrieved inside the kernel.
>>
>>
>> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
>> (identified
>> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
>> user-space
>> applications to fetch and set this value securely and conveniently, we need
>> a standard
>> kernel-to-user interface.
>>
>>
>> Proposed Solution: Add several sysfs attributes under each PCIe device's
>> sysfs directory:
>> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
>> device specific)
>> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
>> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
>> operations, e.g.:
>>    Read operation:
>>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>>    Write operation:
>>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>
>>
>> The design strictly follows PCI subsystem sysfs standards and has the
>> following key properties:
>>
>> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
>> devices that
>>    support TPH Steering Tag. Devices without TPH capability will not show
>> these nodes,
>>    avoiding unnecessary user confusion.
>>
>> 2. Permission Control: The attributes will use 0600 file permissions,
>> ensuring only
>>    privileged root users can read or write them, which satisfies security
>> requirements
>>    for hardware configuration interfaces.
>>
>> 3. Standard Implementation Location: The interface will be implemented in
>>    drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
>> attributes,
>>    ensuring consistency and maintainability within the PCI subsystem.
>>
>>
>> Why sysfs instead of alternatives like VFIO-PCI ioctl:
>>
>> - Universality: sysfs does not require binding the device to a special
>> driver such as
>>   vfio-pci. It is available to any privileged user-space component,
>> including system
>>   utilities, daemons, and monitoring tools.
>>
>> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
>>   straightforward, reducing code complexity and long-term maintenance cost.
>>
>> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
>> specific to
>>   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
>> kernel's
>>   standard pattern for hardware capabilities.
>>
>>
>> I look forward to your comments about this design before submitting the
>> final patch.
> 
> You need to explain more clearly why this write functionality is useful
> and necessary outside the VFIO/RDMA context:
> https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/
> 
> AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
> right ST values.
> 
> There are several comments regarding the implementation, but those can wait
> until the rationale behind the proposal is fully clarified.

Thanks for your review and comments.

Let me clarify the rationale behind this user-space sysfs interface:

1. VFIO is just one of the user-space device access frameworks.
   There are many other in-kernel frameworks that expose devices
   to user space, such as UIO, UACCE, etc., which may also require
   TPH Steering Tag support.

2. The kernel can automatically program Steering Tags only when
   the device provides a standard ST table in MSI-X or config space.
   However, many devices implement vendor-specific or platform-specific
   Steering Tag programming methods that cannot be fully handled
   by the generic kernel code.

3. For such devices, user-space applications or framework drivers
   need to retrieve and configure TPH Steering Tags directly.
   A unified sysfs interface allows all user-space frameworks
   (not just VFIO) to use a common, standard way to manage
   TPH Steering Tags, rather than implementing duplicated logic
   in each subsystem.

This interface provides a uniform method for any user-space
device access solution to work with TPH, which is why I believe
it is useful and necessary beyond the VFIO/RDMA case.

Thanks

> 
> Thanks
> 
>>
>> Best regards,
>> Chengwen Feng
>>

