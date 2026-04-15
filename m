Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75297F9D0F6
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 01:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9054810E021;
	Wed, 15 Apr 2026 01:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="xLjXOP53";
	dkim-atps=neutral
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A44710E021
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 01:47:47 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=FKRdkwMjOaJ50cZQVCsjgPQXyq1PmmPA+TconZgAAI4=;
 b=xLjXOP53NN9FcwooK7x1IrxXikyHDczrsdyivuYn9Orevo4EtcIBcm+uyFpOdliAshfavswN/
 W85houPnKWrTLdJe2iNWA+kSOhiffrq3D3EGt2AZGMo50leaBOHZCzwwWnMH1D3L48OZh5vGHpH
 aflpVvibp0IPSuWx0P/oWY4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fwP4l3jDXzLlSv;
 Wed, 15 Apr 2026 09:41:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id DC9304048B;
 Wed, 15 Apr 2026 09:47:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 09:47:44 +0800
Message-ID: <9a7609b7-1d8d-4758-8f3b-081658d90711@huawei.com>
Date: Wed, 15 Apr 2026 09:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
 <20260414151125.GF2577880@ziepe.ca>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260414151125.GF2577880@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 4/14/2026 11:11 PM, Jason Gunthorpe wrote:
> On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>>    We have a real platform requirement:
>>
>>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>>      * 4. Userspace must program STs into vendor-specific registers
> 
> No, this is nonsenscial too.
> 
> If you want to control the steering tags for MMIO BAR memory exposed
> by VFIO then the DMABUF mechanism Keith & co has been working on is
> the correct approach.
> 
> If the VFIO user needs to control steering tags for the device it is
> directly controling then it must do that through VFIO ioctls.
> 
> Nobody messes around with other devices under the covers of the
> operating kernel driver. Stop proposing that.

Understood.

For VFIO-passed devices that are fully under userspace control,
we will implement the TPH Steering Tag query interface
exclusively through VFIO ioctls, not sysfs.

This will allow userspace to query per-CPU Steering Tags
from platform firmware (ACPI _DSM) for the VFIO device,
which is fully under its control.

Thanks

> 
> Jason

