Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D9ECD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 08:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3186510ED8A;
	Thu, 28 May 2026 08:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="VWNmy/8p";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F8510ED8A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:04:30 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CEfwnPgqLrNaYc1mj4Eyf5bsKzEWDOcFqXc4WbjJj3Y=;
 b=VWNmy/8ppTsOaeH7aF0IkCxzVtF02EKB40Q9n+4FS2a49yqKE93km1cGo7tdMukvd+DizK640
 vi3iz/xW1BQV8Gi5uBJySJ7LLs+A4yUb35GPILBJVkXEleZVBmRDs/+XWvwt+5lC9/Fs3PEnMDf
 Z/U2WkMeDuot+idcTJbFv+w=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gQzMp6R6nzmV6T;
 Thu, 28 May 2026 15:56:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 59E7140539;
 Thu, 28 May 2026 16:04:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 16:04:25 +0800
Message-ID: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
Date: Thu, 28 May 2026 16:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig <christian.koenig@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
 <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> On Wed, May 27, 2026 at 1:53 PM Alex Williamson <alex@shazbot.org> wrote:
>>
>>>
>> On Tue, 26 May 2026 07:43:53 -0700
>> Zhiping Zhang <zhipingz@meta.com> wrote:
>>
>>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
>>> requester mode without reaching into pci_dev internals.
>>>
>>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
>>> !CONFIG_PCIE_TPH stub for callers.
>>>
>>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>>> ---
>>>  drivers/pci/tph.c       | 12 ++++++++++++
>>>  include/linux/pci-tph.h |  2 ++
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>>> index 91145e8d9d95..6c4492075ae9 100644
>>> --- a/drivers/pci/tph.c
>>> +++ b/drivers/pci/tph.c
>>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>>>  }
>>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>>>
>>> +/**
>>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
>>> + * @pdev: PCI device to query
>>> + *
>>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
>>> + */
>>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
>>> +{
>>> +     return pdev->tph_req_type;
>>> +}
>>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
>>> +
>>>  /*
>>>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>>>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
>>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>>> index be68cd17f2f8..fe572737b409 100644
>>> --- a/include/linux/pci-tph.h
>>> +++ b/include/linux/pci-tph.h
>>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>>>  #else
>>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>>                                       unsigned int index, u16 tag)
>>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>>  { return -EINVAL; }
>>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { return 0; }
>>
>> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,

It need add #include <linux/pci.h> at beginning too, else it will counter compile error like this:

   In file included from drivers/vdpa/mlx5/core/mr.c:8:
   In file included from include/linux/mlx5/qp.h:36:
   In file included from include/linux/mlx5/device.h:37:
   In file included from include/rdma/ib_verbs.h:46:
>> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PCI_TPH_LOC_NONE'
      48 | { return PCI_TPH_LOC_NONE; }
         |          ^
   1 error generated.

>>
>> Alex
>>
> ack, will do.
> 
> Thanks,
> Zhiping
> 

