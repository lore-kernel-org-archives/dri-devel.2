Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A81F9D0ED
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713E710E125;
	Tue, 14 Apr 2026 18:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="QUprnfOz";
	dkim-atps=neutral
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E04A10E34F
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:46:03 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/rH0Uu14GhXVYPK5grp1fAneEmMX1tpdc4mScwVWkUA=;
 b=QUprnfOzrEf8RXeDhvg8haCyuPaIHMhwlqwH7DmukbaQT+vIRK077WN0qtvvjSzAVnlmw1SrP
 d/KPhMa441nYNLX8EOHkWahh5+WmdMWMsvezdAR0Atojl2CkQhMUxRCnyKIup7VIR17rWtnbYw9
 Ng5i+YQjRQ8tt3mZi/JM6gM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fw6PB1JP5zRhV9;
 Tue, 14 Apr 2026 22:39:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0B73040561;
 Tue, 14 Apr 2026 22:46:00 +0800 (CST)
Received: from [10.82.53.6] (10.82.53.6) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Apr
 2026 22:45:59 +0800
Content-Type: multipart/alternative;
 boundary="------------SmpNYQwZcbaveOwAFuXdVpK0"
Message-ID: <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
Date: Tue, 14 Apr 2026 22:46:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
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
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260414103547.GA361495@unreal>
X-Originating-IP: [10.82.53.6]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

--------------SmpNYQwZcbaveOwAFuXdVpK0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/4/14 18:35, Leon Romanovsky wrote:
> On Tue, Apr 14, 2026 at 05:30:09PM +0800, fengchengwen wrote:
>> On 4/14/2026 4:57 PM, Leon Romanovsky wrote:
>>> On Tue, Apr 14, 2026 at 09:07:23AM +0800, fengchengwen wrote:
>>>> On 4/14/2026 3:19 AM, Leon Romanovsky wrote:
>>>>> On Mon, Apr 13, 2026 at 08:04:10PM +0800, fengchengwen wrote:
>>>>>> On 4/13/2026 6:01 PM, Leon Romanovsky wrote:
>>>>>>> On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I'm writing to propose adding a sysfs interface to expose and configure the
>>>>>>>> PCIe TPH
>>>>>>>> Steering Tag for PCIe devices, which is retrieved inside the kernel.
>>>>>>>>
>>>>>>>>
>>>>>>>> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
>>>>>>>> (identified
>>>>>>>> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
>>>>>>>> user-space
>>>>>>>> applications to fetch and set this value securely and conveniently, we need
>>>>>>>> a standard
>>>>>>>> kernel-to-user interface.
>>>>>>>>
>>>>>>>>
>>>>>>>> Proposed Solution: Add several sysfs attributes under each PCIe device's
>>>>>>>> sysfs directory:
>>>>>>>> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
>>>>>>>> device specific)
>>>>>>>> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
>>>>>>>> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
>>>>>>>> operations, e.g.:
>>>>>>>>     Read operation:
>>>>>>>>       echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>>>       cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>>>     Write operation:
>>>>>>>>       echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>>>
>>>>>>>>
>>>>>>>> The design strictly follows PCI subsystem sysfs standards and has the
>>>>>>>> following key properties:
>>>>>>>>
>>>>>>>> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
>>>>>>>> devices that
>>>>>>>>     support TPH Steering Tag. Devices without TPH capability will not show
>>>>>>>> these nodes,
>>>>>>>>     avoiding unnecessary user confusion.
>>>>>>>>
>>>>>>>> 2. Permission Control: The attributes will use 0600 file permissions,
>>>>>>>> ensuring only
>>>>>>>>     privileged root users can read or write them, which satisfies security
>>>>>>>> requirements
>>>>>>>>     for hardware configuration interfaces.
>>>>>>>>
>>>>>>>> 3. Standard Implementation Location: The interface will be implemented in
>>>>>>>>     drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
>>>>>>>> attributes,
>>>>>>>>     ensuring consistency and maintainability within the PCI subsystem.
>>>>>>>>
>>>>>>>>
>>>>>>>> Why sysfs instead of alternatives like VFIO-PCI ioctl:
>>>>>>>>
>>>>>>>> - Universality: sysfs does not require binding the device to a special
>>>>>>>> driver such as
>>>>>>>>    vfio-pci. It is available to any privileged user-space component,
>>>>>>>> including system
>>>>>>>>    utilities, daemons, and monitoring tools.
>>>>>>>>
>>>>>>>> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
>>>>>>>>    straightforward, reducing code complexity and long-term maintenance cost.
>>>>>>>>
>>>>>>>> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
>>>>>>>> specific to
>>>>>>>>    user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
>>>>>>>> kernel's
>>>>>>>>    standard pattern for hardware capabilities.
>>>>>>>>
>>>>>>>>
>>>>>>>> I look forward to your comments about this design before submitting the
>>>>>>>> final patch.
>>>>>>> You need to explain more clearly why this write functionality is useful
>>>>>>> and necessary outside the VFIO/RDMA context:
>>>>>>> https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/
>>>>>>>
>>>>>>> AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
>>>>>>> right ST values.
>>>>>>>
>>>>>>> There are several comments regarding the implementation, but those can wait
>>>>>>> until the rationale behind the proposal is fully clarified.
>>>>>> Thanks for your review and comments.
>>>>>>
>>>>>> Let me clarify the rationale behind this user-space sysfs interface:
>>>>>>
>>>>>> 1. VFIO is just one of the user-space device access frameworks.
>>>>>>     There are many other in-kernel frameworks that expose devices
>>>>>>     to user space, such as UIO, UACCE, etc., which may also require
>>>>>>     TPH Steering Tag support.
>>>>>>
>>>>>> 2. The kernel can automatically program Steering Tags only when
>>>>>>     the device provides a standard ST table in MSI-X or config space.
>>>>>>     However, many devices implement vendor-specific or platform-specific
>>>>>>     Steering Tag programming methods that cannot be fully handled
>>>>>>     by the generic kernel code.
>>>>>>
>>>>>> 3. For such devices, user-space applications or framework drivers
>>>>>>     need to retrieve and configure TPH Steering Tags directly.
>>>>>>     A unified sysfs interface allows all user-space frameworks
>>>>>>     (not just VFIO) to use a common, standard way to manage
>>>>>>     TPH Steering Tags, rather than implementing duplicated logic
>>>>>>     in each subsystem.
>>>>>>
>>>>>> This interface provides a uniform method for any user-space
>>>>>> device access solution to work with TPH, which is why I believe
>>>>>> it is useful and necessary beyond the VFIO/RDMA case.
>>>>> I understand the rationale for providing a read interface, for example for
>>>>> debugging, but I do not see any justification for a write interface.
>>>> Thank you for the comment!
>>>>
>>>> As I explained, read interface is not only for debugging. It was used to
>>>> such device who don't declare ST location in MSI-X or config-space, the following
>>>> is Intel X710 NIC device's lspci output (only TPH part):
>>>>
>>>> 	Capabilities: [1a0 v1] Transaction Processing Hints
>>>> 		Device specific mode supported
>>>> 		No steering table available
>>>>
>>>> So we could not config the ST for device on kernel because it's vendor specific.
>>>> But we could configure ST by it's vendor user-space driver, in this case, we
>>>> should get ST from kernel to user-space.
>>> Vendor-specific, in the context of the PCI specification, does not mean the
>>> kernel cannot configure it. It simply means that the ST values are not
>>> stored in the ST table.
>> Thank you for the clarification!
>>
>> I agree with your interpretation of "vendor-specific" in PCI spec terms—it
>> does not prevent the kernel from handling TPH in principle. However, the
>> real problem is that the kernel has no standardized way to know where or
>> how to program those vendor-specific ST values.
> No one here is opposed to you implementing the appropriate callbacks or
> extending the existing in-kernel API to support a device‑specific mode.
>
>> When a device  reports "No steering table available" and operates in
>> device-specific mode, the method used to set ST values is entirely
>> device-specific and not covered by the PCI specification. If the device
>> is taken over to user-space by UIO framework (e.g. VFIO or IGB_UIO), the
>> generic kernel cannot infer the proper programming sequence or registers
>> for each vendor-specific implementation.
>>
>> In these cases, the configuration must be done by the vendor’s
>> user-space driver, which is aware of the device’s private programming
>> model. But such a user-space driver still needs to obtain valid,
>> platform-provided ST values (from ACPI _DSM), which it cannot do
>> without a kernel interface.
> The objection applies to this point. The PCI device exists in kernel space,
> and the kernel is responsible for managing its internal state.


Thank you for the continued discussion.

We have a real platform requirement:

  * 1. Devices in TPH Device-Specific Mode with no standard ST table
  * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
  * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
  * 4. Userspace must program STs into vendor-specific registers


The generic kernel cannot handle this vendor-specific programming.
If you do not think a sysfs interface is appropriate, could you
suggest *what is the right way* for userspace to get these ST
values from the kernel?

I am happy to implement whatever approach the community recommends.

Thanks


>
>> This is why a read-only interface to retrieve ST values is still
>> needed: the kernel holds the valid platform tags, while the user-space
>> driver handles the device-specific programming.
>>
>> Thanks
>>
>>> Thanks
--------------SmpNYQwZcbaveOwAFuXdVpK0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026/4/14 18:35, Leon Romanovsky
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260414103547.GA361495@unreal">
      <pre class="moz-quote-pre" wrap="">On Tue, Apr 14, 2026 at 05:30:09PM +0800, fengchengwen wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 4/14/2026 4:57 PM, Leon Romanovsky wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Tue, Apr 14, 2026 at 09:07:23AM +0800, fengchengwen wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 4/14/2026 3:19 AM, Leon Romanovsky wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Mon, Apr 13, 2026 at 08:04:10PM +0800, fengchengwen wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">On 4/13/2026 6:01 PM, Leon Romanovsky wrote:
</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">Hi all,

I'm writing to propose adding a sysfs interface to expose and configure the
PCIe TPH
Steering Tag for PCIe devices, which is retrieved inside the kernel.


Background: The TPH Steering Tag is tightly coupled with both a PCIe device
(identified
by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
user-space
applications to fetch and set this value securely and conveniently, we need
a standard
kernel-to-user interface.


Proposed Solution: Add several sysfs attributes under each PCIe device's
sysfs directory:
1. /sys/bus/pci/devices/&lt;BDF&gt;/tph_mode to query the TPH mode (interrupt or
device specific)
2. /sys/bus/pci/devices/&lt;BDF&gt;/tph_enable to control the TPH feature
3. /sys/bus/pci/devices/&lt;BDF&gt;/tph_st to support both read and write
operations, e.g.:
   Read operation:
     echo "cpu=3" &gt; /sys/bus/pci/devices/0000:01:00.0/tph_st
     cat /sys/bus/pci/devices/0000:01:00.0/tph_st
   Write operation:
     echo "index=10 st=123" &gt; /sys/bus/pci/devices/0000:01:00.0/tph_st


The design strictly follows PCI subsystem sysfs standards and has the
following key properties:

1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
devices that
   support TPH Steering Tag. Devices without TPH capability will not show
these nodes,
   avoiding unnecessary user confusion.

2. Permission Control: The attributes will use 0600 file permissions,
ensuring only
   privileged root users can read or write them, which satisfies security
requirements
   for hardware configuration interfaces.

3. Standard Implementation Location: The interface will be implemented in
   drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
attributes,
   ensuring consistency and maintainability within the PCI subsystem.


Why sysfs instead of alternatives like VFIO-PCI ioctl:

- Universality: sysfs does not require binding the device to a special
driver such as
  vfio-pci. It is available to any privileged user-space component,
including system
  utilities, daemons, and monitoring tools.

- Simplicity: Both user-space usage (cat/echo) and kernel implementation are
  straightforward, reducing code complexity and long-term maintenance cost.

- Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
specific to
  user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
kernel's
  standard pattern for hardware capabilities.


I look forward to your comments about this design before submitting the
final patch.
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">
You need to explain more clearly why this write functionality is useful
and necessary outside the VFIO/RDMA context:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/">https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/</a>

AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
right ST values.

There are several comments regarding the implementation, but those can wait
until the rationale behind the proposal is fully clarified.
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">
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
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">
I understand the rationale for providing a read interface, for example for
debugging, but I do not see any justification for a write interface.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
Thank you for the comment!

As I explained, read interface is not only for debugging. It was used to
such device who don't declare ST location in MSI-X or config-space, the following
is Intel X710 NIC device's lspci output (only TPH part):

	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		No steering table available

So we could not config the ST for device on kernel because it's vendor specific.
But we could configure ST by it's vendor user-space driver, in this case, we
should get ST from kernel to user-space.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Vendor-specific, in the context of the PCI specification, does not mean the
kernel cannot configure it. It simply means that the ST values are not
stored in the ST table.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Thank you for the clarification!

I agree with your interpretation of "vendor-specific" in PCI spec terms—it
does not prevent the kernel from handling TPH in principle. However, the
real problem is that the kernel has no standardized way to know where or
how to program those vendor-specific ST values.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No one here is opposed to you implementing the appropriate callbacks or
extending the existing in-kernel API to support a device‑specific mode.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
When a device  reports "No steering table available" and operates in
device-specific mode, the method used to set ST values is entirely
device-specific and not covered by the PCI specification. If the device
is taken over to user-space by UIO framework (e.g. VFIO or IGB_UIO), the
generic kernel cannot infer the proper programming sequence or registers
for each vendor-specific implementation.

In these cases, the configuration must be done by the vendor’s
user-space driver, which is aware of the device’s private programming
model. But such a user-space driver still needs to obtain valid,
platform-provided ST values (from ACPI _DSM), which it cannot do
without a kernel interface.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The objection applies to this point. The PCI device exists in kernel space,
and the kernel is responsible for managing its internal state.</pre>
    </blockquote>
    <p><br>
    </p>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">Thank you for the continued
      discussion.</div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"><br>
    </div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"></div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">We have a real platform
      requirement:</div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"></div>
    <ul style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">
      <li style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: list-item; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);">1. Devices in TPH
        Device-Specific Mode with no standard ST table</li>
      <li style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: list-item; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);">2. Steering Tags must be
        obtained from ACPI _DSM (kernel-only)</li>
      <li style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: list-item; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);">3. Devices are fully
        managed by userspace drivers (VFIO/UIO)</li>
      <li style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: list-item; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);">4. Userspace must program
        STs into vendor-specific registers</li>
    </ul>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"></div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"><br>
    </div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">The generic kernel cannot
      handle this vendor-specific programming.
      <div style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: block; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);"></div>
      If you do not think a sysfs interface is appropriate, could you
      <div style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: block; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);"></div>
      suggest <strong style="color: rgb(31, 35, 41); font: 700 16px /
        24px ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 700; line-height: 24px; text-align: start;
        white-space: normal; display: inline; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);">what is the right way</strong>
      for userspace to get these ST
      <div style="color: rgb(31, 35, 41); font: 16px / 24px
        ui-sans-serif, system-ui, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px;
        font-weight: 400; line-height: 24px; text-align: start;
        white-space: normal; display: block; flex: 0 1 auto;
        flex-direction: row; justify-content: normal; align-items:
        normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
        none repeat scroll 0% 0% / auto padding-box border-box;
        background-color: rgba(0, 0, 0, 0);"></div>
      values from the kernel?</div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"></div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"><br>
    </div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">I am happy to implement
      whatever approach the community recommends.</div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"></div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);"><br>
    </div>
    <div style="color: rgb(31, 35, 41); font: 16px / 24px ui-sans-serif,
      system-ui, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe
      UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color
      Emoji&quot;; font-size: 16px; font-weight: 400; line-height: 24px;
      text-align: start; white-space: normal; display: block; flex: 0 1
      auto; flex-direction: row; justify-content: normal; align-items:
      normal; padding: 0px; margin: 0px; background: rgba(0, 0, 0, 0)
      none repeat scroll 0% 0% / auto padding-box border-box;
      background-color: rgba(0, 0, 0, 0);">Thanks</div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260414103547.GA361495@unreal">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This is why a read-only interface to retrieve ST values is still
needed: the kernel holds the valid platform tags, while the user-space
driver handles the device-specific programming.

Thanks

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------SmpNYQwZcbaveOwAFuXdVpK0--
