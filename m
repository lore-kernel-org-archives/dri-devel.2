Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9222CC4450A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 00:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DB010E174;
	Fri, 17 Jul 2026 00:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="AvWpgteR";
	dkim-atps=neutral
X-Greylist: delayed 83340 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 00:16:40 UTC
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6F710E174
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 00:16:40 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=SYwy6QobYtfLX+TFA3XAHC6CKwVcv5/eHXjCp5polzo=;
 b=AvWpgteRLh7Ai4tN3A9nHSUkPydX2mLUe2z2zpVVLaUx5yc4C9x0rCidbQmHPcMnz2puAedBQ
 oMijff9E3RIGFU6YWhyhDXAbDMcxlwX9mohFxxfX7zmi8yfmIX6GnsEVyOxbNtfNRiD8H2z8QfC
 KrxmpFGDKkc7NUvBhT47PNk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h1VbB6yjCz1K96b;
 Fri, 17 Jul 2026 08:07:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 18D4540572;
 Fri, 17 Jul 2026 08:16:37 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 08:16:36 +0800
Message-ID: <a855b8da-5ec5-433b-b5cf-177034ae5392@huawei.com>
Date: Fri, 17 Jul 2026 08:16:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Zhiping Zhang <zhipingz@meta.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
 <CAH3zFs0Wbz5EYUMQArmUtT-jdAtisafw6e89RWKZJrJpipYQoA@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAH3zFs0Wbz5EYUMQArmUtT-jdAtisafw6e89RWKZJrJpipYQoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 7/17/2026 4:08 AM, Zhiping Zhang wrote:
> On Wed, Jul 15, 2026 at 6:07 PM fengchengwen <fengchengwen@huawei.com> wrote:
>>
>>>
>> Hi Zhiping,
>>
>> One concern I'd like to raise is the implicit topology constraint of the
>> TPH P2P path. TPH Steering Tag only works reliably when both importer and
>> exporter devices sit under the same Root Port (or same TPH-aware switch).
>>
>> For cross-Root-Port P2P traffic (e.g. P2P devices located in different
>> RC or even socket), most server-grade Root Complexes do not forward TPH
>> prefixes through their internal routing. The ST field gets silently
>> stripped before reaching the target device, so all TPH setup becomes
>> ineffective with no error reported to user.
>>
>> Because cross-Root-Port P2P traffic with ST does not affect the host, but
>> merely the completer may experience some performance degradation because
>> it lacks the TPH hint. In this case, I suggest adding restrictions in the
>> uAPI.
>>
>> A further step is to check whether the importer and exporter are under
>> the same root port. However, this verification will cause the P2P TPH
>> to be unsupported in the case of multi-host or multi-root PCIe switch.
>>
>> Thanks
> 
> Hi Fengcheng,
> 
> Agreed the RC may not preserve TPH across Root Ports (PCIe Base Spec
> r6.4 §6.17.4 requires all intermediate routing elements to support
> TPH, and cross-RP forwarding is optional/implementation-dependent, cf.
> §2.2.10.4.2). But the uAPI can't gate it: there's no discoverable "TPH
> routing" capability -- DevCap2[13:12] (r6.4 §7.5.3.15) describes the
> completer, not P2P forwarding -- and a same-Root-Port check would
> wrongly reject switch and multi-root topologies where ST does forward.
> 
> And it's harmless anyway: per r6.4 §2.2.7.1 an element without TPH
> support ignores the TH bit and completes as if unhinted, so a stripped
> ST just degrades to the non-TPH baseline.

Thank you for your detailed explanation. I agree to maintain the current
implementation.

Thanks

> 
> Thanks,
> Zhiping
> 

