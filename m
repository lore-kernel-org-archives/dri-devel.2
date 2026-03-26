Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9399E10A88E6
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD64810EB14;
	Thu, 26 Mar 2026 17:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="POgFUL0C";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F2410E956
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:18:57 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7986e0553bdso12643657b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774545535; x=1775150335; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=catgTR0xDAfngSvOjKkRc4V9EBNqPXIOGG/xwNaa+5g=;
 b=POgFUL0Cigdca3lM4gYAAvwh7yzgWtBACzIz80T7HDyUEMDnWcpqf9egd8AvFtcBMM
 xX/aZLxl/vCPTibOHW5dVDbHKhOI6Ny93LedOB+GDA8ZXTmiJlQGR5N3RcvLQ/tASPM/
 edB5fMr5a9fJ0RxsZrjItYlccNVERQj4+V0JbUgUO2jADGXSfNMv5b64pVSh+PCI/KKX
 4Gz4z7meR7qUZ8IEzcFhTYhGWjMhfG6z2skRlsE1LHXLtptS4W64QHCjnRat734VqxOV
 GdwozgefVH8MdXpWNwaSCTDUI7udZnchnyDzx08ZFkzNH92TqM2cms/JV1tfTZdZ8la1
 tdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774545535; x=1775150335;
 h=in-reply-to:autocrypt:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=catgTR0xDAfngSvOjKkRc4V9EBNqPXIOGG/xwNaa+5g=;
 b=Am69g5buWyXdsIKVjr5E1/42kEwwSdyR1wla7MjlcxBx8DB41MzE2rqFQDiGcE7M/Q
 jaqjyCzwW8qyp/l8pLp23fVuG1goZ8FKBnxu1RR1iBJeguLioZV2jtp0BOTkB+0QIjHY
 yx95rkPk5+03tzW4csf5G2IQJrTfNSjh2PgnJIcNIyqM+9fYhKOwXkpzZgydLqWHbeMY
 FZMQGe/yWFFnmI9GxLjdjwd2he+ZVIB8sgLZm4NHArCDbm7PS7dhCc2RCSx1z+VLAymI
 MUSty8hSWqUtITDcA6PCL9lGK2FtskY2pfh1EcmdzRRqDmgUQ1WeZ45ca+b1E9Kl2+Fp
 BPLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb1u3eQv89q8RDgM51m3ucex6q0qm4HU/eNP+ZFpvgY/HylTBgG3bv73j7LmrQ/+4230ilpEzcffA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzObFcgsPo5qGcv6mV/fE4fa7ERmT7WWvLdvUioS2SqHsL0p09
 8e+mN9m1RceOTZ9OuOIWg4cAweE9peQq2m+nTxe32qDSSoaGOF2jIh+g
X-Gm-Gg: ATEYQzz1w8iACkb/aCLxFFTwDItlwV8Ga4nVIyy/ru40BpwXGb+U49BajlxSlm+AUJ+
 NDATeEY+qQz1aLoBxpmTJtMGobaTukIJTqE03dv902nyZJT3J9bDzyY1e2pNLLOF+WEN2Wz3Pla
 V4Y+AQqE33PUgAW8vEhFpev26NBCS6KrFaNKMFwKJ+CE/kMb4gUA4L94y0LXwO0/+xBb6e8g0pj
 84NyW5crsHTlv7YlpWuyz+txS6dFVa/qx+5vhWgktfSlfWtKB+P1W8mJh0hcSjKIh01CiidpbtL
 Vl1B4FXm8w+7PwGp6JXJnMekuSUz2A7cDyI0LCIL7xX8tfgWIJwx7NI6u5IcE6hAwebgfd/nXf6
 FFemaOAUjjKF3hrIYVFOAOfmUCLTxGAWiZ4PuXcqt3cA4FIJr1345d9SDvruDEpFxfcOrPRcWll
 ik1WcsWERFz/HrHFEDKMAOmCX5wrpHI/6jOIMkWC+688zQ8Jmm+uNw67R2fiw7BQceCElqmQzQE
 T3kjAAF+ATtH4tdtqRW2fvrRR14/QYSlHaf6Z0=
X-Received: by 2002:a05:690c:c4e9:b0:79a:cdf0:e27e with SMTP id
 00721157ae682-79acf3bdd43mr86695287b3.21.1774545535057; 
 Thu, 26 Mar 2026 10:18:55 -0700 (PDT)
Received: from [10.138.34.110]
 (h69-131-148-49.cncrtn.broadband.dynamic.tds.net. [69.131.148.49])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79b10c64964sm15704197b3.7.2026.03.26.10.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 10:18:54 -0700 (PDT)
Message-ID: <4f201188-31ac-4dac-9cc6-79c4283486e5@gmail.com>
Date: Thu, 26 Mar 2026 13:18:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mapping non-pinned memory from one Xen domain into another
To: Teddy Astie <teddy.astie@vates.tech>,
 Xen developer discussion <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jan Beulich <jbeulich@suse.com>, Val Packett <val@invisiblethingslab.com>,
 Ariadne Conill <ariadne@ariadne.space>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <5123c11c-3b8a-4633-809f-16c24418a4ce@vates.tech>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <5123c11c-3b8a-4633-809f-16c24418a4ce@vates.tech>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------q4eFoExnaRHx7KlXZl2RC647"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------q4eFoExnaRHx7KlXZl2RC647
Content-Type: multipart/mixed; boundary="------------Mw057gSCTShl0mrhaYEBlqTI";
 protected-headers="v1"
Message-ID: <4f201188-31ac-4dac-9cc6-79c4283486e5@gmail.com>
Date: Thu, 26 Mar 2026 13:18:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mapping non-pinned memory from one Xen domain into another
To: Teddy Astie <teddy.astie@vates.tech>,
 Xen developer discussion <xen-devel@lists.xenproject.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jan Beulich <jbeulich@suse.com>, Val Packett <val@invisiblethingslab.com>,
 Ariadne Conill <ariadne@ariadne.space>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>
References: <84462c4b-7813-4ad1-aeb2-862ae4f3a627@gmail.com>
 <5123c11c-3b8a-4633-809f-16c24418a4ce@vates.tech>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <5123c11c-3b8a-4633-809f-16c24418a4ce@vates.tech>
Autocrypt-Gossip: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==

--------------Mw057gSCTShl0mrhaYEBlqTI
Content-Type: multipart/mixed; boundary="------------raEGs0y239z4seO7DQS7CzhM"

--------------raEGs0y239z4seO7DQS7CzhM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/24/26 14:00, Teddy Astie wrote:
> Hello,
>=20
> I assume all this only concerns HVM/PVH DomU, I don't think it is doabl=
e=20
> for PV DomU (if that matters).
>=20
> Le 24/03/2026 =C3=A0 15:17, Demi Marie Obenour a =C3=A9crit=C2=A0:
>> Here is a proposed design document for supporting mapping GPU VRAM
>> and/or file-backed memory into other domains.  It's not in the form of=

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
>> However, to the best of my understanding, the design described here is=

>> the only viable one.  Linux MM and GPU drivers require it, and changes=

>> to either to relax this requirement will not be accepted upstream.
>> ---
>> # Memory lending: Mapping pageable memory, such as GPU VRAM, from one =
Xen domain into another
>>
>> ## Background
>>
>> Some Linux kernel subsystems require full control over certain memory
>> regions.  This includes the ability to handle page faults from any
>> entity accessing this memory.  Such entities include not only that
>> kernel's userspace, but also kernels belonging to other guests.
>>
>> For instance, GPU drivers reserve the right to migrate data between
>> VRAM and system RAM at any time.  Furthermore, there is a set of
>> page tables between the "aperture" (mapped as a PCI BAR) and the
>> actual VRAM.  This means that the GPU driver can make the memory
>> temporarily inaccessible to the CPU.  This is in fact _required_
>> when resizable BAR is not supported, as otherwise there is too much
>> VRAM to expose it all via a single BAR.
>>
>> Since the backing storage of this memory must be movable, pinning
>> it is not supported.  However, the existing grant table interface
>> requires pinned memory.  Therefore, such memory currently cannot be
>> shared with another guest.  As a result, implementing virtio-GPU blob
>> objects is not possible.  Since blob objects are a prerequisite for
>> both Venus and native contexts, supporting Vulkan via virtio-GPU on
>> Xen is also impossible.
>>
>=20
> I'm not sure Vulkan fully allow memory to be moved between RAM and VRAM=
=2E=20
> Or at least, you would need to lie a bit on the=20
> VK_MEMORY_HEAP_DEVICE_LOCAL_BIT property.
>=20
> So I assume there is a way to choose between having memory as VRAM or a=
s=20
> RAM somehow, unless it is only a hint ?

On Linux, it is indeed only a hint.  If VRAM is exhausted, Linux
will move buffers to system RAM to free up space.  This significantly
benefits desktop workloads, which have a lot of GPU buffers that are
not used frequently.  Games are an exception, but I suspect they use
their buffers frequently enough that Linux doesn't decide to page
them out.

>> Direct Access to Differentiated Memory (DAX) also relies on non-pinned=

>> memory.  In the (now rare) case of persistent memory, it is because
>> the filesystem may need to move data blocks around on disk.  In the
>> case of virtio-pmem and virtio-fs, it is because page faults on write
>> operations are used to inform filesystems that they need to write the
>> data back at some point.  Without these page faults, filesystems will
>> not write back the data and silent data loss will result.
>>
>> There are other use-cases for this too.  For instance, virtio-GPU
>> cross-domain Wayland exposes host shared memory buffers to the guest.
>> These buffers are mmap()'d file descriptors provided by the Wayland
>> compositor, and as such are not guaranteed to be anonymous memory.
>> Using grant tables for such mappings would conflict with the design
>> of existing virtio-GPU implementations, which assume that GPU VRAM
>> and shared memory can be handled uniformly.
>>
>> Additionally, this is needed to support paging guest memory out to the=

>> host's disks.  While this is significantly less efficient than using
>> an in-guest balloon driver, it has the advantage of not requiring
>> guest cooperation.  Therefore, it can be useful for situations in
>> which the performance of a guest is irrelevant, but where saving the
>> guest isn't appropriate.
>>
>> ## Informing drivers that they must stop using memory: MMU notifiers
>>
>> Kernel drivers, such as xen_privcmd, in the same domain that has
>> the GPU (the "host") may map GPU memory buffers.  However, they must
>> register an *MMU notifier*.  This is a callback that Linux core memory=

>> management code ("MM") uses to tell the driver that it must stop
>> all accesses to the memory.  Once the memory is no longer accessed,
>> Linux assumes it can do whatever it wants with this memory:
>>
>> - The GPU driver can move it from VRAM to system RAM or visa versa,
>>   move it within VRAM or system RAM, or it temporarily inaccessible
>>   so that other VRAM can be accessed.
>> - MM can swap the page out to disk/zram/etc.
>> - MM can move the page in system RAM to create huge pages.
>> - MM can write the pages out to their backing files and then free them=
=2E
>> - Anything else in Linux can do whatever it wants with the memory.
>>
>> Suspending access to memory is not allowed to block indefinitely.
>> It can sleep, but it must finish in finite time regardless of what
>> userspace (or other VMs) do.  Otherwise, bad things (which I believe
>> includes deadlocks) may result.  I believe it can fail temporarily,
>> but permanent failure is also not allowed.  Once the MMU notifier
>> has succeeded, userspace or other domains **must not be allowed to
>> access the memory**.  This would be an exploitable use-after-free
>> vulnerability.
>>
>> Due to these requirements, MMU notifier callbacks must not require
>> cooperation from other guests.  This means that they are not allowed t=
o
>> wait for memory that has been granted to another guest to no longer
>> be mapped by that guest.  Therefore, MMU notifiers and the use of
>> grant tables are inherently incompatible.
>=20
>=20
>>
>> ## Memory lending: A different approach
>>
>> Instead, xen_privcmd must use a different hypercall to _lend_ memory t=
o
>> another domain (the "guest").  When MM triggers the guest MMU notifier=
,
>> xen_privcmd _tells_ Xen (via hypercall) to revoke the guest's access
>> to the memory.  This hypercall _must succeed in bounded time_ even
>> if the guest is malicious.
>>
>> Since the other guests are not aware this has happened, they will
>> continue to access the memory.  This will cause p2m faults, which
>> trap to Xen.  Xen normally kills the guest in this situation which is
>> obviously not desired behavior.  Instead, Xen must pause the guest
>> and inform the host's kernel.  xen_privcmd will have registered a
>> handler for such events, so it will be informed when this happens.
>>
>> When xen_privcmd is told that a guest wants to access the revoked
>> page, it will ask core MM to make the page available.  Once the page
>> _is_ available, core MM will inform xen_privcmd, which will in turn
>> provide a page to Xen that will be mapped into the guest's stage 2
>> translation tables.  This page will generally be different than the
>> one that was originally lent.
>>
>> Requesting a new page can fail.  This is usually due to rare errors,
>> such as a GPU being hot-unplugged or an I/O error faulting pages
>> from disk.  In these cases, the old content of the page is lost.
>>
>> When this happens, xen_privcmd can do one of two things:
>>
>> 1. It can provide a page that is filled with zeros.
>> 2. It can tell Xen that it is unable to fulfill the request.
>>
>> Which choice it makes is under userspace control.  If userspace
>> chooses the second option, Xen injects a fault into the guest.
>> It is up to the guest to handle the fault correctly.
>>
> Is it some ioreq-like mechanism where :
> - A guest access a "non-ready" page
> - Nothing there -> pagefault (e.g NPF) and guest vCPU is blocked
> - Xen asks Dom0 what to do (event channel, VIRQ, ...)
> - Dom0 explicitly maps memory to the guest (or do any other operation)
> - Guest resumes execution with the page mapped

This is exactly it!

> Something that looks a bit similar to "memory paging".

It *is* memory paging :).  I named it differently for two reasons:

1. I didn't want this to be confused with the existing memory paging
   mechanism in Xen.

2. I wanted to emphasize that lent memory is still "owned" by the
   lending domain.
  =20
>> ## Restrictions on lent memory>>
>> Lent memory is still considered to belong to the lending domain.
>> The borrowing domain can only access it via its p2m.  Hypercalls made
>> by the borrowing domain act as if the borrowed memory was not present.=

>> This includes, but is not limited to:
>>
>> - Using pointers to borrowed memory in hypercall arguments.
>> - Granting borrowed memory to other VMs.
>> - Any other operation that depends on whether a page is accessible
>>    by a domain.
>=20
> What about emulated instructions that refers to this memory ?

This would be allowed if (and only if) it can trigger paging as you
wrote above.

>> Furthermore:
>>
>> - Borrowed memory isn't mapped into the IOMMU of any PCIe devices
>>    the guest has attached, because IOTLB faults generally are not
>>    replayable.
>>
>=20
> Given that (as written bellow) Borrowed memory is a part of some form o=
f=20
> emulated BAR or special region, there is no guarantee that DMA will wor=
k=20
> properly anyway (unless P2P DMA support is advertised).
>=20
> Splitting the IOMMU side from the P2M is not a good idea as it rules ou=
t=20
> the "IOMMU HAP PT Share" optimization.

If the pages are mapped in the IOMMU, paging them out requires an
IOTLB invalidation.  My understanding is that these are far too slow.

How important is sharing the HAP and IOMMU page tables?

>> - Foreign mapping hypercalls that reference lent memory will fail.
>>    Otherwise, the domain making the foreign mapping hypercall could
>>    continue to access the borrowed memory after the lease had been
>>    revoked.  This is true even if the domain performing the foreign
>>    mapping is an all-powerful dom0.  Otherwise, an emulated device
>>    could access memory whose lease had been revoked.
>>
>> This also means that live migration of a domain that has borrowed
>> memory requires cooperation from the lending domain.  For now, it
>> will be considered out of scope.  Live migration is typically used
>> with server workloads, and accelerators for server hardware often
>> support SR-IOV.
>>
>> ## Where will lent memory appear in a guest's address space?
>>
>> Typically, lent memory will be an emulated PCI BAR.  It may be emulate=
d
>> by dom0 or an alternate ioreq server.  However, it is not *required*
>> to be a PCI BAR.
>>
>=20
> ---
>=20
> While the design could work (albeit the implied complexity), I'm not a =

> big fan of it, or at least, it needs to consider some constraints for=20
> having reasonable performance.
> One of the big issue is that a performance-sensitive system (virtualize=
d=20
> GPU) is interlocking with several "hard to optimize" subsystem like P2M=
=20
> or Dom0 having to process a paging event.
>=20
> Modifying the P2M (especially removing entries) is a fairly expensive=20
> operation as it sometimes requires pausing all the vCPUs each time it's=
=20
> done.

Not every GPU supports recoverable page faults.  Even when they
are supported, they are extremely expensive.  Each of them involves
a round-trip from the GPU to the CPU and back, which means that a
potentially very large number of GPU cores are blocked until the
CPU can respond.  Therefore, GPU driver developers avoid relying on
GPU page faults whenever possible.  Instead, data is moved in large
chunks using a dedicated DMA engine in the GPU.
As a result, I'm not too concerned with the cost of P2M manipulation.
Anything that requires making a GPU buffer temporarily inaccessible
is already an expensive process, and driver developers have strong
incentives to keep the time the buffer is unmapped as short as
possible.
If performance turns out to be a problem, something like KVM's
asynchronous page faults might be a better solution.

> If it's done at 4k granularity, it would also lack superpage support,=20
> which wouldn't help either. (doing things at the 2M+ scale would help, =

> but I don't know enough how MMU notifier does things.
>=20
> While I agree that grants is not a adequate mechanism for this (for=20
> multiples reasons), I'm not fully convinced of the proposal.
> I would prefer a strategy where we map a fixed amount of RAM+VRAM as a =

> blob, along with some form of cooperative hotplug mechanism to=20
> dynamically provision the amount.

I asked the GPU driver developers about pinning VRAM like this a couple
years ago or so.  The response I got was that it isn't supported.
I suspect that anyone needing VRAM pinning for graphics workloads is
using non-upstreamable hacks, most likely specific to a single driver.

More generally, the entire graphics stack receives essentially no
testing under Xen.  There have been bugs that have affected Qubes OS
users for months or more, and they went unfixed because they couldn't
be reproduced outside of Xen.  To the upstream graphics developers,
Xen might as well not exist.  This means that any solution that
requires changing the graphics stack is not a practical option,
and I do not expect this to change in the foreseeable future.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------raEGs0y239z4seO7DQS7CzhM
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------raEGs0y239z4seO7DQS7CzhM--

--------------Mw057gSCTShl0mrhaYEBlqTI--

--------------q4eFoExnaRHx7KlXZl2RC647
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmnFankACgkQszaHOrMp
8lMXhBAAmdOPhh8pYd8FNNgBBAJD5qFbwWHlA135Biww8R38taFSJ2v1RjBR0Xdj
mkkb9g/UmviJmVuEdi67a2qetWfOw0SpqHOnWjFPD18PAIqDH8u2mGgdNuVLmFbM
9c52ZvhmpbTLJJcQWAYroL/8F2A39220TKne4qI6pKElJsZtTTIjt1P+XD7fJx0B
Av8kGtZo/rRTKl03a8Dm/EiQuUiHsETFfluHniNq2/nSzvPRVp4wBSnhuqrjrHKO
n6m841Ze2QiSydMDLSOsGnM2kCfEwEiKbRK6K3Shn+1tYNGvUFRuSuTEGCF3d9LQ
h0QvpCwNSbRDmXBWw4Dpal3YWOzYnLGCw/sDT05Rvz+IT5Q1DRz3WzH42SwHj4zh
8aD6pveGaM93EGDCLQHiCa1+UIC+f71NdFTTXjbqmcTx3SVK89bCCbDNjk+dOtcM
mjuQiB801NsKooEQkzxLW1Mtl3jSinsxsXYb1eWynBHzSkR+DsjAM6t13tSY4K3y
GHJZWIR90YkR/pMJ4/3jkkjmtYFGWvK+BhcV1PmjtuIRmlVuPpnZVplk1j+xT5B9
Y0qJVQz3Ozl76ycE90QjuwAOI4aGkQAyBbh+8xq4pWZ0+n7GUhHBMIIX2TCN4pSk
BQB3ecfitOsy0cypWZvQyRzm+6G36gy3CS/TlGN+coEky1SfH8w=
=WsJg
-----END PGP SIGNATURE-----

--------------q4eFoExnaRHx7KlXZl2RC647--
