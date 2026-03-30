Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82093FF60D9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B797610E896;
	Tue, 31 Mar 2026 07:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="zAunaEDM";
	dkim=pass (2048-bit key; unprotected) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="jI2M4JuX";
	dkim-atps=neutral
X-Greylist: delayed 1099 seconds by postgrey-1.36 at gabe;
 Mon, 30 Mar 2026 10:34:06 UTC
Received: from mail132-14.atl131.mandrillapp.com
 (mail132-14.atl131.mandrillapp.com [198.2.132.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B46910E5F6
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1774865746; x=1775135746;
 bh=4ftzqy59DoR80wgnd7UbR3KsoDNOo82PR4o/Q/pNvFk=;
 h=From:Subject:Message-Id:To:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=zAunaEDMh9/YaluxSVYm/LbBfNkwZdAWDDxMInhP8qlK4tgUKH72JncQLkeTFNjfx
 r8eZlKsgbPb5yN1Trg6xGvUlF99OdiV660Mmcy8RQTfyWeAKHWnAQoai5mHeNlwpzZ
 m6i7TJ1pRJLpzjR12c4DJx2IueaQJlXZ0yWdBY9c7BvZQ5jdJ5ib7iv8zPMNil5trx
 W/5LmDl2Vc/teqwzR6B/IM8XDKLsq8ZJZOPTXIKtrDT3nGvaPCG4i68yEth9MpEA/G
 VgDUVSf9MqvDFej0rMvWlNYKaIOoc/qoZSLw4rRUnj/s84VkWOkeqjCI+IA/CRAAI+
 l21DhC9yAGDbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1774865746; x=1775126246; i=teddy.astie@vates.tech;
 bh=4ftzqy59DoR80wgnd7UbR3KsoDNOo82PR4o/Q/pNvFk=;
 h=From:Subject:Message-Id:To:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=jI2M4JuXtzdviGXc3SgG/8H7DsUure+J+CuF316hFxaEkomdKq8pGWY8jUWUHVCcV
 VCd5SeraVdhFe7faKY/x9N08aTGYmh3K6AtsnMWHd8vl0ideBc0QKMw4WnuCzs4d5G
 dkjm6VLQbnSyRjvUf51vGcpOGjS9ba+XfHPXAvosZFsOTdsZDDMc3srKC2/TZC81YW
 K7ApGsDXWAhzBix7m6vgq9PwTXF26TmdNZCAp/TnykoYKZWSD5WkBswZwxLx708f8R
 ZK5g46Mxl1XyffPjlR7JN4khsn407MdW8hO3ZzGHHNvapmTEQxMpwWdiVfnTFJgtV0
 MebEzFjIV9qdQ==
Received: from pmta09.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail132-14.atl131.mandrillapp.com (Mailchimp) with ESMTP id
 4fknFZ4x3wz8XS0V0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:15:46 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20Why=20memory=20lending=20is=20needed=20for=20GPU=20acceleration?=
Received: from [37.26.189.201] by mandrillapp.com id
 74af7191595042178fa589a1f48813eb; Mon, 30 Mar 2026 10:15:46 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1774865745207
Message-Id: <ce114f02-f45e-4638-84ee-a8fd86ce1c5d@vates.tech>
To: "Demi Marie Obenour" <demiobenour@gmail.com>,
 "Xen developer discussion" <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "Jan Beulich" <jbeulich@suse.com>, "Val Packett" <val@invisiblethingslab.com>,
 "Ariadne Conill" <ariadne@ariadne.space>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>, "Juergen Gross" <jgross@suse.com>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <c38387fe-beef-4f50-b928-74f96b881b7a@gmail.com>
In-Reply-To: <c38387fe-beef-4f50-b928-74f96b881b7a@gmail.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.74af7191595042178fa589a1f48813eb?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260330:md
Date: Mon, 30 Mar 2026 10:15:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

Le 29/03/2026 =C3=A0 19:32, Demi Marie Obenour a =C3=A9crit=C2=A0:
> On 3/24/26 10:17, Demi Marie Obenour wrote:
>> Here is a proposed design document for supporting mapping GPU VRAM
>> and/or file-backed memory into other domains.  It's not in the form of
>> a patch because the leading + characters would just make it harder to
>> read for no particular gain, and because this is still RFC right now.
>> Once it is ready to merge, I'll send a proper patch.  Nevertheless,
>> you can consider this to be
>>
>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>
>> This approach is very different from the "frontend-allocates"
>> approach used elsewhere in Xen.  It is very much Linux-centric,
>> rather than Xen-centric.  In fact, MMU notifiers were invented for
>> KVM, and this approach is exactly the same as the one KVM implements.
>> However, to the best of my understanding, the design described here is
>> the only viable one.  Linux MM and GPU drivers require it, and changes
>> to either to relax this requirement will not be accepted upstream.
> 
> Teddy Astie (CCd) proposed a couple of alternatives on Matrix:
> 
> 1. Create dma-bufs for guest pages and import them into the host.
> 
>     This is a win not only for Xen, but also for KVM.  Right now, shared
>     (CPU) memory buffers must be copied from the guest to the host,
>     which is pointless.  So fixing that is a good thing!  That said,
>     I'm still concerned about triggering GPU driver code-paths that
>     are not tested on bare metal.
>     
> 2. Use PASID and 2-stage translation so that the GPU can operate in
>     guest physical memory.
>     
>     This is also a win.  AMD XDNA absolutely requires PASID support,
>     and apparently AMD GPUs can also use PASID.  So being able to use
>     PASID is certainly helpful.
> 
> However, I don't think either approach is sufficient for two reasons.
> 
> First, discrete GPUs have dedicated VRAM, which Xen knows nothing about.
> Only dom0's GPU drivers can manage VRAM, and they will insist on being
> able to migrate it between the CPU and the GPU.  Furthermore, VRAM
> can only be allocated using GPU driver ioctls, which will allocate
> it from dom0-owned memory.
> 
> Second, Certain Wayland protocols, such as screencapture, require program=
s
> to be able to import dmabufs.  Both of the above solutions would
> require that the pages be pinned.  I don't think this is an option,
> as IIUC pin_user_pages() fails on mappings of these dmabufs.  It's why
> direct I/O to dmabufs doesn't work.
> 

I suppose it fails because of the RAM/VRAM constraint you said 
previously. If the location of the memory stays the same (i.e guest 
memory mapping), pin should be almost "no-op".

(though, having dma-buf buffers coming from GPU drivers failing to pin 
is probably not a good thing in term of stability; some stuff like 
cameras probably break as a result; but I'm not a expert on that subject)

> To the best of my knowledge, these problems mean that lending memory
> is the only way to get robust GPU acceleration for both graphics and
> compute workloads under Xen.  Simpler approaches might work for pure
> compute workloads, for iGPUs, or for drivers that have Xen-specific
> changes.  None of them, however, support graphics workloads on dGPUs
> while using the GPU driver the same way bare metal workloads do.
> 
> Linux's graphics stack is massive, and trying to adapt it to work with
> Xen isn't going to be sustainable in the long term.  Adapting Xen to
> fit the graphics stack is probably more work up front, but it has the
> advantage of working with all GPU drivers, including ones that have not
> been written yet.  It also means that the testing done on bare metal is
> still applicable, and that bugs found when using this driver can either
> be reproduced on bare metal or can be fixed without driver changes.

One of my main concerns was about whether dma-buf can be used as 
"general purpose" GPU buffers; what I read in driver code suggest it 
should be fine, but it's a bit on the edge.

> 
> Finally, I'm not actually attached to memory lending at all.  It's a
> lot of complexity, and it's not at all similar to how the rest of
> Xen works.  If someone else can come up with a better solution that
> doesn't require GPU driver changes, I'd be all for it.  Unfortunately,
> I suspect none exists.  One can make almost anything work if one is
> willing to patch the drivers, but I am virtually certain that this
> will not be long-term sustainable.
> 

There's also the virtio-gpu side to consider. Blob mechanism appears to 
insist that GPU memory to come from the host by allowing buffers that 
aren't bound to virtio-gpu BAR yet (that also complexifies the KVM 
situation).

You can have GPU memory that exists in virtio-gpu, without being 
guest-visible, then the guest can map it on its own BAR.

> If Xen had its own GPU drivers, the situation would be totally
> different.  However, Xen must rely on Linux's GPU drivers, and that
> means it must play by their rules.




--
Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


