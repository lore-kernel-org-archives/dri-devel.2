Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E875C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E2310EDBD;
	Thu, 13 Aug 2026 18:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCAOiJEs";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0261710E20F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:54:58 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso26769a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786647298; cv=none;
 d=google.com; s=arc-20260327;
 b=Eym7+eoPqitdI6IyHC8Ju5++be8ahekTDb3UFJpW+i1w1ElwNONX5WoDDPvyluzJwi
 89+6xcD7D2+5uGEJlU4R67xHfp8CkHJaXCL4UgLGy2NW0XhxjCCZ+6ko1N5xdTjTbumC
 4DBxUs/e0rG9DtoKrwGtU4xRYyS5G/dKnyvzmDMlQgBJ4HCC85MEIBOEwRDxJ3rGpxp2
 a4R9p6vIfXAArnl7oXI+3f1qz0eOHWOXv63MAoLcV1Dj6C0Gjg0aMwBphK77+K5Nyyr0
 yZQ9w9gXjexqxHbfZSkawveGGadoY+7JUVmcI4GzJ6emq77LTUUmC8t58RYtZeDD+1/Z
 xt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ys42dbnu0/ICx4BZSSpRiOGzHCv3bwg46ovXH3mc4po=;
 fh=9A6nI1LZQQQzEhsvmuVZBz0B3lVU4dRfmBkqQ0l88GM=;
 b=rFQN5LoRCHQBtdu0SUD4q/VBFQ1lJdJjUhhBwNXLv53DwS0jIG86Jw3rBGLnwvlixb
 lIJYGpCD0by7AavT0hbYx9vgjU8iQwylDnvF3QR/3ygsS2P5Qs7fGFnHH+Oz1Y9v2S3h
 jJzNgaRu9o6M1QPcdwBR4Ecqd8uy6aGA8UwnP4jO9nIEmA0lINrf+Vs5gsSfSTtm25RF
 rFZ3qTdpMFQ7Ewa/4NuR1EJjit3vEsS4UKl69BI8VIwwWzyltfYrJ6nxlgzs+ktqYcMo
 JnEow9GBNSaH3eZOrr1gw7btbtMMAkDY4cLJZ9v7FmJNBEVGeqcdWZD+BALZUKQkoF/K
 u9gw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786647298; x=1787252098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ys42dbnu0/ICx4BZSSpRiOGzHCv3bwg46ovXH3mc4po=;
 b=mCAOiJEscQkA/Gr9bzhueBINAjOwCqp98eVoHSgyl3T3Qr01BC+niO8yIaTHr9dveu
 JaJWozKVCr/VB1gc87CcXqnMCeGY1xcV/4HtUmjGEVKoFNjkfs3IdHD646U/H7GXOIhW
 OYtY3rL37m0TbaQvxkWTiiDLvMlCkHyqvpGHzpYKiOAaVuYnfI/n2s0EcesZM8+NrD3n
 jrxr/6LDE71rNpzwv+apQg4gdEWRjf7Xua6qHugUO4WvVfX+4m6g/ll6Iuq2+yO4KJmy
 Wuvue34awXnO7n4jw3GdKU+p+4Zg/FDWr22xZbx5t2GCC6dvw/qduyrnnAhPczauKO/w
 N3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786647298; x=1787252098;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ys42dbnu0/ICx4BZSSpRiOGzHCv3bwg46ovXH3mc4po=;
 b=JfcEvISOuoahm4WvpPOetY71GLqhAXC4wh7ASq7XkPqC01w6/sfulXJvL1KqBBQ/WG
 CSmfQP9QshJJH1Wsx7e85StpplsqADB9nBHNxIDdBDudZlAq8XxWoP60/4UVLY7BNrC3
 nPBX8mTEi2PkgCPO2sNQw16NJ8G+57p+bcZVtEE+/HeBC8q46SWOo0idZiTymKqImQP+
 7Gco4NQQJVZoDzgqTWvmKkaZIFd3uFEf0mQFwmvNpE7NZqIsUe6PDxdY42OQjDxdD95b
 gno4LqLPmltsbW2ghoWHvo/uZnBX6okxb7mvq4h8Qumdcfu2EP/HePBmi7kvc+0xP9no
 yTsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH3p6F5e6zK5RH7YtMzIfrsgz0Z2K2a4Id/hCcVvPM4ThPPqq+eSwT15D5dUX6mz6AFRUlZSt9BwQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSd3knJv+PQkn5Obu58PwQaXXRse2muxI1bMWa4wiWm6pNfo+w
 OXzCsBH07cLGuhQ0S53GIvurS38U2UJ/byDTMfpRtnXMOZzapaB/JZa0AHnzCWvu9mrTIw2e+Kb
 uv0Gd5CSFx9Mz1/HghDJbjGnyLuDIpmN9fA==
X-Gm-Gg: AR+sD10jbdQED+EkNS+CAIp+Lmzmv02M3SW9DX1uRa0feD9YjGyVV1CstwzxqONso6b
 62wHJviyfwdnUeE2WEJsTknAWUD656XDll8KaSVwqvdTOLs/iStZYyIE85qA9BWe7+IDSxZrzwJ
 zTg19tdNMrXvqHIJy6UuLUNbK5Bghi0nQ8it4rUUFizBiQpezjetwDbkoNeh22bWhhfFTCW5WO7
 KZVDEIBlg3Atk2MxuZPNhNPzjr3px3rNNvqtNb+Hu4JIJ2KxgiJ6YC6S6hKqwbyYvZhzfTO8aqi
 NElUKvCRviZPOsVJSbFin+Lsjn04835BAchX2p1iq4RB3Xe4c7ZOXtM+/AtHDY7H1HxNFTfKzsG
 c+S2jLDMtxbl97aQ61kThu6eYiKUcI+Q=
X-Received: by 2002:a17:90b:1c91:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-3933b4d0640mr179244a91.0.1786647298317; Thu, 13 Aug 2026
 11:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
 <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
In-Reply-To: <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 14:54:46 -0400
X-Gm-Features: AUfX_mx_auIKOQjmwN2CvsU15Mwo-xw_9T-mFr-sYw0GjTAJECthI8fgD4LDjdE
Message-ID: <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, mamin506@gmail.com,
 ogabbay@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sumit.semwal@linaro.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, "Zhen, Max" <Max.Zhen@amd.com>, 
 "Santan, Sonal" <sonal.santan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 13, 2026 at 2:45=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
>
> On 8/13/26 00:44, Christian K=C3=B6nig wrote:
> > Hi Lizhi,
> >
> > yeah that sounds reasonable.
> Thanks. :)
> >
> > An alternative would be to use DMA_BUF_IOCTL_SYNC from userspace, but t=
hat is usually only for the exporter to implement clflush or similar action=
s. As importer you need to be able to take the data as it is.
> >
> > We have discussed before if that shouldn't be changed somehow, but so f=
ar didn't settled on an interface.
> >
> > Question is why do you need clflush in the first place? The NPU is a PC=
Ie device, isn't it? And so it should be using cache coherent memory access=
es.
>
> I do not know the hardware detail. The legacy NPU device is not cache
> coherent. And the next generation (aie4) devices will be cache coherent.
>

The CPU wouldn't be coherent with device caches, but the device should
be coherent with the CPU's caches.  I.e., PCIe transactions from the
device should snoop the CPU's cache.  Otherwise, you couldn't use CPU
cached memory for DMA.

Alex

>
> Lizhi
>
> >
> > Regards,
> > Christian.
> >
> > On 8/12/26 17:45, Lizhi Hou wrote:
> >> Hi Christian,
> >>
> >> Thanks for pointing this out.
> >>
> >> Taimuraz, this is not introduced by your patch. And the current code v=
iolates dma-buf protocol. It look we need to unconditionally return -EOPNOT=
SUPP for imported BO at the beginning of amdxdna_flush_bo(). Could you help=
 to modify your patch 1 for this if it makes sense?
> >>
> >>
> >> Thanks,
> >>
> >> Lizhi
> >>
> >> On 8/12/26 01:57, Christian K=C3=B6nig wrote:
> >>> On 8/12/26 01:13, Taimuraz Kaitmazov wrote:
> >>>> SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours=
 them
> >>>> only on the vmap path. An imported BO is tested for first and flushe=
s its
> >>>> whole scatterlist,
> >>> Absolutely clear NAK to that from a DMA-buf maintainer side.
> >>>
> >>> Flushing on imported scatterlist of a DMA-buf is a really big NO-GO.
> >>>
> >>> If DMA-buf imports are used with the device then the device needs to =
be able to coherently access the underlying memory.
> >>>
> >>> In other words you *CAN'T* call drm_clflush_pages() on imported memor=
y.
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>> so a sync costs what the BO is worth rather than what
> >>>> the caller asked to maintain: on npu4 an imported 64 MiB BO cost 105=
6 us
> >>>> to sync at every size from 4 KiB up. Patch 5 reorders the arms so th=
e
> >>>> vmap path is tried first, and indexes the page-array fallback from t=
he
> >>>> requested offset.
> >>>>
> >>>> The four before it are the ground that has to be solid first. Patch =
1
> >>>> refuses an I/O memory mapping, which the driver currently stores as =
if it
> >>>> were an ordinary kernel address. Patch 2 adds a probe that does not =
log,
> >>>> so patch 5 does not make an exporter without a vmap op print on ever=
y
> >>>> ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own ran=
ge: a
> >>>> zero length reaching drm_clflush_virt_range(), and an offset and siz=
e
> >>>> added to the BO address without an overflow check, one level above a
> >>>> function that checks the same arithmetic. All four stand on their ow=
n and
> >>>> can be taken separately; only patch 5 depends on them.
> >>>>
> >>>> v1 did not reach dri-devel, so this is the first version visible the=
re.
> >>>> It is on lore via the other lists it was copied to:
> >>>> https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitma=
zov.com/
> >>>>
> >>>> Changes in v2:
> >>>>    - patch 2: take the device from the GEM object rather than abo->c=
lient.
> >>>>      amdxdna_gem_obj_close() clears that pointer under abo->lock, wh=
ich the
> >>>>      pre-split code held across the log and the split did not.
> >>>>    - new patch 3: return early from a zero-length flush.
> >>>>    - new patch 4: check the sync range for overflow on a device BO.
> >>>>    - patch 5: say why the persistent mapping adds no pin.
> >>>>
> >>>> The measurements in patch 5 were taken with the equivalent change in
> >>>> AMD's out-of-tree xdna-driver, where this merged as #1541. That vers=
ion
> >>>> and this one differ only in a page-array fallback mainline has no fi=
eld
> >>>> for, reached when the mapping fails and the BO is neither imported n=
or
> >>>> shmem backed, and in the name of the mapping helper. The flush and t=
he
> >>>> helper are otherwise identical. This version is compile-tested; it h=
as
> >>>> not been booted.
> >>>>
> >>>> Patch 1 is from inspection rather than a reproducer. The exporter I =
can
> >>>> test against is amdgpu, and amdgpu is the case that cannot reach it:=
 it
> >>>> implements .pin, so a non peer to peer attachment like this driver's
> >>>> forces the buffer to GTT before anything maps it. Reproducing it nee=
ds a
> >>>> GPU whose exporter has no .pin, which I do not have paired with an N=
PU
> >>>> here.
> >>>>
> >>>> Taimuraz Kaitmazov (5):
> >>>>     accel/amdxdna: refuse an I/O memory mapping of an imported BO
> >>>>     accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
> >>>>     accel/amdxdna: return early from a zero-length flush
> >>>>     accel/amdxdna: check the sync range for overflow on a device BO
> >>>>     accel/amdxdna: flush only the requested range in amdxdna_flush_b=
o
> >>>>
> >>>>    drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++---=
-----
> >>>>    1 file changed, 49 insertions(+), 17 deletions(-)
> >>>>
> >>>> --
> >>>> 2.55.0
> >>>>
