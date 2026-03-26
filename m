Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1743610ED679
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095AF10EE58;
	Fri, 27 Mar 2026 13:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="vEsv4QQs";
	dkim=pass (2048-bit key; unprotected) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="l8JHY/Te";
	dkim-atps=neutral
X-Greylist: delayed 966 seconds by postgrey-1.36 at gabe;
 Thu, 26 Mar 2026 18:42:58 UTC
Received: from mail179-37.suw41.mandrillapp.com
 (mail179-37.suw41.mandrillapp.com [198.2.179.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D96B10EB9E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1774549609; x=1774819609;
 bh=1AD6XtpInmedqkHt3lklQZZmmP5HZmKfK2sFPcPiL8Q=;
 h=From:Subject:Message-Id:To:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=vEsv4QQsazjAHRM3hDgnHJS/DV6TE2qRjFuL1KhzeJEGCPdaWKlZPr6GPJY8sd6Lw
 DZbmBwgTTq5yuaPvSCCKPsOI6uX2VDeZ4cIxWKN2g8+e3cQnaHllnigRL447kxoEs6
 y/YoG1nYUFel6p0+ipkWJz8SeNBs8+HM9Stb+fk9Bog5M6eoUo5e4gPumDYRZbPDgy
 V1oIXg50UiDsBtspuPVmZwNkXymBPS2yKgqdIrNnE5dRjSFLPIilbAUGnUud8evcBP
 2kbvHboKx2habjDMpda3HioZuqiWVkllMSer9+izacIc6QWMyYD6orGVNHYpw7ipka
 /uw4MohVwXkLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1774549609; x=1774810109; i=teddy.astie@vates.tech;
 bh=1AD6XtpInmedqkHt3lklQZZmmP5HZmKfK2sFPcPiL8Q=;
 h=From:Subject:Message-Id:To:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=l8JHY/Tea6yBGHD1sI4FsunVDPU7/Y++mbqvOpZSJoQBLtQfgCYHF2QDpq3fUF0G5
 ZOJNfuLl/mrRjHZIfkczqwaAAGxKopAkS+iAB/75GKxEACbuTACL7DEj4EFtSQa5fs
 0WuDayNMs/82LGffSVpuHGz91NrlfQSQlqakKSfNY86YFvMegVGZ+eQoOxjs5+X8q0
 lNWw2MZRVQPeQzjGf0eYFqALRkbag1S7yGwyvJmoO8ZkAbAxAoAA9itHVNLTgPWImw
 8lITpTTpOP3FDfQFiM6Xdaj0AZ12vLBF70kI7ILOUaOHnMuRl6/GC7/iB+ZlW+EcHc
 5urfVUKW3eWCg==
Received: from pmta12.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail179-37.suw41.mandrillapp.com (Mailchimp) with ESMTP id
 4fhXL156QczG0CLrw
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:26:49 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20Mapping=20non-pinned=20memory=20from=20one=20Xen=20domain=20into=20another?=
Received: from [37.26.189.201] by mandrillapp.com id
 c38559d027fa401bab8ffad53858cee2; Thu, 26 Mar 2026 18:26:49 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1774549607657
Message-Id: <df6194cf-1fc4-4a20-ad46-6eeab1d920a2@vates.tech>
To: "Demi Marie Obenour" <demiobenour@gmail.com>,
 "Xen developer discussion" <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "Jan Beulich" <jbeulich@suse.com>, "Val Packett" <val@invisiblethingslab.com>,
 "Ariadne Conill" <ariadne@ariadne.space>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>, "Juergen Gross" <jgross@suse.com>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <5123c11c-3b8a-4633-809f-16c24418a4ce@vates.tech>
 <4f201188-31ac-4dac-9cc6-79c4283486e5@gmail.com>
In-Reply-To: <4f201188-31ac-4dac-9cc6-79c4283486e5@gmail.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.c38559d027fa401bab8ffad53858cee2?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260326:md
Date: Thu, 26 Mar 2026 18:26:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Mar 2026 13:46:04 +0000
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

Le 26/03/2026 =C3=A0 18:18, Demi Marie Obenour a =C3=A9crit=C2=A0:
> On 3/24/26 14:00, Teddy Astie wrote:
>>> ## Restrictions on lent memory>>
>>> Lent memory is still considered to belong to the lending domain.
>>> The borrowing domain can only access it via its p2m.  Hypercalls made
>>> by the borrowing domain act as if the borrowed memory was not present.
>>> This includes, but is not limited to:
>>>
>>> - Using pointers to borrowed memory in hypercall arguments.
>>> - Granting borrowed memory to other VMs.
>>> - Any other operation that depends on whether a page is accessible
>>>     by a domain.
>>
>> What about emulated instructions that refers to this memory ?
> 
> This would be allowed if (and only if) it can trigger paging as you
> wrote above.
> 
>>> Furthermore:
>>>
>>> - Borrowed memory isn't mapped into the IOMMU of any PCIe devices
>>>     the guest has attached, because IOTLB faults generally are not
>>>     replayable.
>>>
>>
>> Given that (as written bellow) Borrowed memory is a part of some form of
>> emulated BAR or special region, there is no guarantee that DMA will work
>> properly anyway (unless P2P DMA support is advertised).
>>
>> Splitting the IOMMU side from the P2M is not a good idea as it rules out
>> the "IOMMU HAP PT Share" optimization.
> 
> If the pages are mapped in the IOMMU, paging them out requires an
> IOTLB invalidation.  My understanding is that these are far too slow.
> 

yes (aside specific cases like with paravirtualized IOMMU), but only if 
you have a device in the guest.

The problem is that that would force us to modify the ABI to have 
"non-DMA-able" memory in the guest, which doesn't exist yet aside 
specific cases like grants in PV.

> How important is sharing the HAP and IOMMU page tables?
> 
>>> - Foreign mapping hypercalls that reference lent memory will fail.
>>>     Otherwise, the domain making the foreign mapping hypercall could
>>>     continue to access the borrowed memory after the lease had been
>>>     revoked.  This is true even if the domain performing the foreign
>>>     mapping is an all-powerful dom0.  Otherwise, an emulated device
>>>     could access memory whose lease had been revoked.
>>>
>>> This also means that live migration of a domain that has borrowed
>>> memory requires cooperation from the lending domain.  For now, it
>>> will be considered out of scope.  Live migration is typically used
>>> with server workloads, and accelerators for server hardware often
>>> support SR-IOV.
>>>
>>> ## Where will lent memory appear in a guest's address space?
>>>
>>> Typically, lent memory will be an emulated PCI BAR.  It may be emulated
>>> by dom0 or an alternate ioreq server.  However, it is not *required*
>>> to be a PCI BAR.
>>>
>>
>> ---
>>
>> While the design could work (albeit the implied complexity), I'm not a
>> big fan of it, or at least, it needs to consider some constraints for
>> having reasonable performance.
>> One of the big issue is that a performance-sensitive system (virtualized
>> GPU) is interlocking with several "hard to optimize" subsystem like P2M
>> or Dom0 having to process a paging event.
>>
>> Modifying the P2M (especially removing entries) is a fairly expensive
>> operation as it sometimes requires pausing all the vCPUs each time it's
>> done.
> 
> Not every GPU supports recoverable page faults.  Even when they
> are supported, they are extremely expensive.  Each of them involves
> a round-trip from the GPU to the CPU and back, which means that a
> potentially very large number of GPU cores are blocked until the
> CPU can respond.  Therefore, GPU driver developers avoid relying on
> GPU page faults whenever possible.  Instead, data is moved in large
> chunks using a dedicated DMA engine in the GPU.
> As a result, I'm not too concerned with the cost of P2M manipulation.
> Anything that requires making a GPU buffer temporarily inaccessible
> is already an expensive process, and driver developers have strong
> incentives to keep the time the buffer is unmapped as short as
> possible.
> If performance turns out to be a problem, something like KVM's
> asynchronous page faults might be a better solution.
> 

Asynchronous page fault looks like a interesting and potentially easier 
to implement.

IIUC, the idea is to make the pages disappears on the guest behalf, and 
the guest would have to deal with the eventual page fault. Currently in 
Xen, a unhandled #NPF is fatal, but that could be tuned down for 
specific regions and transformed into a #PF or another exception for the 
guest to handle.

We have actually a similar need for SEV-ES MMIO handling, as we need to 
distinguish "MMIO-related NPF" (to paravirtualize through GHCB) to the 
other NPF; which needs to be configured in advance in page-tables (so 
that the CPU choose between #VC and VMEXIT#NPF).

It would also need some form of para-virtualization coming from virtio 
or a new Xen PV driver for the guest to be made aware of this mechanism.
I also assume that the guest handles properly that kind of event.

>> If it's done at 4k granularity, it would also lack superpage support,
>> which wouldn't help either. (doing things at the 2M+ scale would help,
>> but I don't know enough how MMU notifier does things.
>>
>> While I agree that grants is not a adequate mechanism for this (for
>> multiples reasons), I'm not fully convinced of the proposal.
>> I would prefer a strategy where we map a fixed amount of RAM+VRAM as a
>> blob, along with some form of cooperative hotplug mechanism to
>> dynamically provision the amount.
> 
> I asked the GPU driver developers about pinning VRAM like this a couple
> years ago or so.  The response I got was that it isn't supported.
> I suspect that anyone needing VRAM pinning for graphics workloads is
> using non-upstreamable hacks, most likely specific to a single driver.
> 
> More generally, the entire graphics stack receives essentially no
> testing under Xen.  There have been bugs that have affected Qubes OS
> users for months or more, and they went unfixed because they couldn't
> be reproduced outside of Xen.  To the upstream graphics developers,
> Xen might as well not exist.  This means that any solution that
> requires changing the graphics stack is not a practical option,
> and I do not expect this to change in the foreseeable future.


--
Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


