Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65233606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZofQTbxJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04B010E5FE;
	Mon,  2 Nov 2026 11:52:31 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB7B10E5FE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:52:25 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-91c905d7b6bso31113366d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793620344; cv=none;
 d=google.com; s=arc-20260327;
 b=mchVDr69xaroyu0KtBqmJif6QzxsMrzRIvcQ/BlNsd1KAXJwJjGPL/nw+dgXsg3iFp
 01XUv43OcJq85uY2GJMFs63UHiD8WEflzM27bJDp93AKBPZB6pJMuXzpvr2z8rDxBB/h
 quZMaH2o4bu0LGuwyjp+ekmX+O4Usa1WRWL9FyvMIqfOPL62SFMlhtf1T/cXuAPo/1JM
 05D/6U7cHH8CnxuketJyTOU9FhjmPAoukPvrGH/RUuFFbnyjJhUpC9ZnwtpVkzT4zWj+
 pgzeKSXAc9a8c9Im5WUIjzTkfm8BuLnxDrSt/OXCyIqmZ2hwKgQvYUeoNFfITRyxJE36
 UZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OPFfoxfETiD5aqwPpBjWzUPCpBAXaMCBvOYRyj7zIms=;
 fh=hDgNBaeRYnvm14gpOnnhXa62RWCWzPvIQ+KwjeiNqYE=;
 b=qHOR5TeGCF3+aKLke7QcqE2/+qGVZgdplJ/NhpJVv5j+YPcMiKjZQD3ASQmiF4wggD
 lbII2O6xoxMX6xNRtbEv3IvhavwohjZRkFjK9Nap+1m+sV4W8D5TbxfKOFGeDw3a4ip7
 F3xeeuQ0VCLLPAAJhaTixJxG8NZqZKQUbfijggh8Vm/wBtSK5U0tLaOPPEswc1gMyKSA
 b//0+NcGStgpmmD3ragMJJy16rhc0EAlgI5bI2ndKmEbSPKtzkKyNtPqAkYqwaTzy2pg
 M4VEe1JNq0RxlaLdTj3b6VcWperSj+KlvItS4PhvUuntyk1SdlF4LaEePgV+iFmT/dEk
 dE7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793620344; x=1794225144;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OPFfoxfETiD5aqwPpBjWzUPCpBAXaMCBvOYRyj7zIms=;
 b=ZofQTbxJMBtdraEZqIDCQ+BKDAo8eRqxid3DF30JRGxpP6PjblvwiYsfURQ4oBHOQb
 B3stcU8Gwcu8TuliH1HLraSl6kjTwDk9MmzrDLcIahMbLN78KoSW5F2XJSBeDE67NMPn
 zKIyX0nNTOYX3MaRGQ1ZZ9Drgwo4k33obU+MqE9yX1GII4skoulg610x2p2nGeKpVKwT
 /p+Scq/sCHaBkBulrJZXUDH6bvtyPEOhBpksITCLqiRKVXoCiQHcQpNgsZlkEB3gEIBY
 5/Fw6OZY19ESJ4wsmnJKm6BL342Z7Q0AtbPQAOpgdKne8aJdn6Q8pVfiERUn57d6PMhg
 bQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620344; x=1794225144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OPFfoxfETiD5aqwPpBjWzUPCpBAXaMCBvOYRyj7zIms=;
 b=ZmemhW6L33bhfr5sEYRwJDfr5zo3lTKAy/uzyhNFtLp2K66aMKx3CDqhnA7hHT71m1
 rPCGtZMMH2MCItNc0He2pLiL7qoIhVQ+p+5E+FmlzlYyma8PrFKE7gAoXBk7gHcPehlZ
 C3GCe/HnKqY9f8HvYS//L/XvKQj26aUGZh2jLiFKzArMPLAB0BCxeO3H/bkKDC3ROrpb
 rdet0XyPFY4/7Tch9cR4+9nLudl5puRVRyNUqYGARMdWUqR6Z1lwGpnmLFNeF/zR3Scg
 YeUtuMj6C71IGuh41+EqWVrGtjjf65RQ9c2gChWdf5KBuvGHfVvBZZI1oN0rifzHwTdD
 Gb1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByHMEVjnBRHDNTod0hX54GMehudloF95zsWeOc2VCLYnpEkGNnhK8N85DfG/3EtN5ErrKGRxymlTqs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uwQScisz7R3az+mA5iplpb4PSwcQVa02VRD9h4I5u0OSR5vJd
 sIYrKN0GQjjGbpxToZfKTPZeWMDh560Asc5kDV8W23qvf3DDlnm3s09GypMc/BP48MjioYJKqLx
 9liFL3bsR8ANERs/rZMRN8P90i04rYCxhqQFSxpqp
X-Gm-Gg: AYBFou2sfAtJRmUuH6TXLO+9vjtc56/OSFKro38O2oMJ7uyzrx+OVXcgDZFW3GUpc1C
 Uz/4o7qD/rJSze0sLtcD6pS8SwsiSiGgRp7u+GdmaGvLthq4u6j2a/88T/9nK4S6oioWJQx/1Ac
 NXbzLXKjrEVNXVeG+icKoPobAMuDoI73h8jL1DXIdHckIuC3ae1wFFyd8q8h57kqzc4mdmwowXB
 Ch1Ye4AfUhp8ZWcX1Qn2xThcd/ubCITon+wtLtRjHMPCQAGfvS28v1rnkpwM3fPwGQJTC4cFlkv
 FuT912E2B+4FDrc8Bazv0kbakXlTuVR7idra52bWRPTI1XQNy3ZNFvBh7uFdd6ZxchKC48EZR2/
 V3eLBOxSBCnYu/KF89Qc20hjGHfTqLyaJLbSoXJzeIwT7jPiAnwwDm5EjKytHo4nunmq2cgA3zV
 rAGzlGY37SpIhZtKUhe4ribiHonlFHvkwExW3VQfukOl8Tol/pvWAXsQ==
X-Received: by 2002:a05:6214:d65:b0:91c:77ef:21f3 with SMTP id
 6a1803df08f44-91ca4b4aa4bmr161361366d6.35.1793620343351; Mon, 02 Nov 2026
 03:52:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
 <CABdmKX0YRmr0ovk7teNQdXdLmC2LKruT59EQarpDMFcxoOFcQg@mail.gmail.com>
 <a10ab532-1e9e-4a85-a79e-b712868889c8@amd.com>
In-Reply-To: <a10ab532-1e9e-4a85-a79e-b712868889c8@amd.com>
From: Chris Wiseman <chriswiseman@google.com>
Date: Mon, 2 Nov 2026 03:52:11 -0800
X-Gm-Features: AclHuK8V34sYC53r3ruPdF2CmxA0GLy-yR6aEEhtX5C30asNiPTQwKxbQk7mNKE
Message-ID: <CALdCrooY1DSesx6fWXtpSmuLuE4ioXccVbE5-=37sJkUiLKZQQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Reject private mappings in
 system_heap_mmap()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, Philipp Stanner <phasta@kernel.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006f3e63065f49c790"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000006f3e63065f49c790
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Christian and T.J!

Yes, please go ahead and push this one to drm-misc-fixes (unless Sumit
would prefer to take it).  I will send out a separate patch for
drm-misc-next enforcing the check in dma_buf_mmap_internal() and
dma_buf_mmap() so we can see if anything in userspace complains.

On Mon, Nov 2, 2026 at 3:09=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> On 10/31/26 02:44, T.J. Mercier wrote:
> > On Fri, Oct 30, 2026 at 1:44=E2=80=AFPM Chris Wiseman <chriswiseman@goo=
gle.com>
> wrote:
> >>
> >> When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
> >> use sgtables instead of pagelists") stopped using heap_helpers.c and
> >> added a custom system_heap_mmap(), the check rejecting private mapping=
s
> >> was dropped.
> >>
> >> Other exporters and buffer allocators reject private or copy-on-write
> >> mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
> >> check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
> >> and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).
> >>
> >> However, system_heap_mmap() omits this check and calls remap_pfn_range=
()
> >> even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
> >> subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
> >> fault into do_wp_page() -> wp_page_copy(), silently allocating private
> >> anonymous copy-on-write pages whose writes never reach the underlying
> >> system heap buffer pages.
> >>
> >> Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
> >> cma_heap_mmap() and mmap_udmabuf().
> >>
> >> Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use
> sgtables instead of pagelists")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> >
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> >
> > I wonder if we should have this in dma_buf_mmap_internal() though. Any
> > thoughts Sumit or Christian?
>
> I do remember that this was once already discussed with Simona and a
> couple of others, but I don't remember what the outcome was.
>
> On the other hand I can't think of a reason why anybody would want a
> private mapping with DMA-buf copy on write clearly won't work. Maybe for
> backward compatibility with broken userspace, not for a real use case.
>
> I would say let's push this patch to drm-misc-fixes and apply another
> patch to drm-misc-next to enforce this for all DMA-bufs and see if anybod=
y
> complains that this breaks userspace.
>
> Should I push it to drm-misc-fixes or want somebody else take that?
>
> Regards,
> Christian.
>

--0000000000006f3e63065f49c790
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Christian and T.J!<div><br>Yes, please go ahead and=
 push this one to drm-misc-fixes (unless Sumit would prefer to take it).=C2=
=A0 I will send out a separate patch for drm-misc-next enforcing the check =
in dma_buf_mmap_internal() and dma_buf_mmap() so we can see if anything in =
userspace complains.</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 2, 2026 at 3:09=
=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd=
.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 10/31/26 02:44, T.J. Mercier wrote:<br>
&gt; On Fri, Oct 30, 2026 at 1:44=E2=80=AFPM Chris Wiseman &lt;<a href=3D"m=
ailto:chriswiseman@google.com" target=3D"_blank">chriswiseman@google.com</a=
>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; When commit 381295758792 (&quot;dma-buf: system_heap: Rework syste=
m heap to<br>
&gt;&gt; use sgtables instead of pagelists&quot;) stopped using heap_helper=
s.c and<br>
&gt;&gt; added a custom system_heap_mmap(), the check rejecting private map=
pings<br>
&gt;&gt; was dropped.<br>
&gt;&gt;<br>
&gt;&gt; Other exporters and buffer allocators reject private or copy-on-wr=
ite<br>
&gt;&gt; mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf(=
)<br>
&gt;&gt; check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap=
()<br>
&gt;&gt; and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).<br>
&gt;&gt;<br>
&gt;&gt; However, system_heap_mmap() omits this check and calls remap_pfn_r=
ange()<br>
&gt;&gt; even when userspace requests MAP_PRIVATE with PROT_WRITE. As a res=
ult,<br>
&gt;&gt; subsequent CPU writes to a MAP_PRIVATE mapping of a system heap bu=
ffer<br>
&gt;&gt; fault into do_wp_page() -&gt; wp_page_copy(), silently allocating =
private<br>
&gt;&gt; anonymous copy-on-write pages whose writes never reach the underly=
ing<br>
&gt;&gt; system heap buffer pages.<br>
&gt;&gt;<br>
&gt;&gt; Reject non-shared mappings in system_heap_mmap() with -EINVAL to m=
atch<br>
&gt;&gt; cma_heap_mmap() and mmap_udmabuf().<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 381295758792 (&quot;dma-buf: system_heap: Rework system hea=
p to use sgtables instead of pagelists&quot;)<br>
&gt;&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">st=
able@vger.kernel.org</a><br>
&gt;&gt; Signed-off-by: Chris Wiseman &lt;<a href=3D"mailto:chriswiseman@go=
ogle.com" target=3D"_blank">chriswiseman@google.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: T.J. Mercier &lt;<a href=3D"mailto:tjmercier@google.com" =
target=3D"_blank">tjmercier@google.com</a>&gt;<br>
&gt; <br>
&gt; I wonder if we should have this in dma_buf_mmap_internal() though. Any=
<br>
&gt; thoughts Sumit or Christian?<br>
<br>
I do remember that this was once already discussed with Simona and a couple=
 of others, but I don&#39;t remember what the outcome was.<br>
<br>
On the other hand I can&#39;t think of a reason why anybody would want a pr=
ivate mapping with DMA-buf copy on write clearly won&#39;t work. Maybe for =
backward compatibility with broken userspace, not for a real use case.<br>
<br>
I would say let&#39;s push this patch to drm-misc-fixes and apply another p=
atch to drm-misc-next to enforce this for all DMA-bufs and see if anybody c=
omplains that this breaks userspace.<br>
<br>
Should I push it to drm-misc-fixes or want somebody else take that?<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div>

--0000000000006f3e63065f49c790--
