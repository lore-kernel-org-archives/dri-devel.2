Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B33CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD04510E33E;
	Mon, 18 May 2026 18:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PRRrFjgF";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A778310E33E
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:10:52 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-132830d8281so10169569c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779127852; cv=none;
 d=google.com; s=arc-20240605;
 b=GLN/VYQeP5vpHQufjKPen8LhMoGCmHCG08Rf/Lmr5/hIew1GoFevC9JLcWMYFMbd3g
 xowfQ58Av9d0t0IIJKLG+Er+/glIcjqN9lTCT/U/5h/m17T6ryWXk1IkqPGhDFlhJmnG
 /VNSzdKot2TRsBaQbvNW6jxIJh6+7uJWjfyz5jYnBubosm6+kCYouw9HmxEIqFInSFgB
 eLCAjKxd2DD4YUF6O2OV0QilaYYovyFIKGage0n+0yoNsVaCtBl09LddEMse0x5YuTVU
 Dx54Kwt9si5auYFwA1hHA3s/Du9wbZDbCsHm65bz7XK6UloHvoMo5lOQZCjEqMecki6m
 dwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8Zh1uX+6g1iCyNuMr452Zg32sFLSdswHocLXkqvORIw=;
 fh=sp2l1hRNCIGo7taJtktk7CNSMsKQo0Oh1OW5ZutGA94=;
 b=HrI7vIh1cO6kwfKfwaUPqOPpCUPi+ixfYpx782p4RpxbhYWOuSogmf6S8h5GXGVW5c
 pDVWfrN/ERoUDxGSMz1cMEdQNyd44ce/ZmkFzB0xPc2mkXSqgQEPNABG/+E3gUPECr4c
 4Jb5xQL1x0uuXKrEdi5rpt8+x0U43FsvcASdz4/G7b0hyo+LQEMNtSl49qLOR0srDaB2
 vhOEuJTUkWVa0BV1NYx5f56h2t1i0oso0l0/XmDkz0qVfOozoAXPWGzWu3ngmpEJI3to
 mECvs0c87OSFE7/eQF+deulYlHPwIYcTrTBpjWwHq0Hf9wNF90DDy9BTUTbLW+yKM+pH
 QzcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779127852; x=1779732652;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zh1uX+6g1iCyNuMr452Zg32sFLSdswHocLXkqvORIw=;
 b=PRRrFjgFxpMxhnMI9Fy333++UypyC4n8JhFSREEEbYF2AadJhQj4SoGiz63pb8moV2
 38krAsGMX3MGDZPCJWtoATwmmPaCKR6S/KzGmzs22ZF5+JApO6VqtHF9hfMB853Z17cr
 78uIXSQGzOIHgeynw0YPWyr7+mZzdbGdRzpp2ztYTDZ87bKdRFZvcArjm6b5wxnq4gSQ
 levHKwTNjQi2zLTQz4sU70YvpjaZzASeXyFoqkegrbvh/Fi3yDk3ZrtF7kJVyBTU9qmR
 xt9aRlrwHmeVwsQXm7MEWwg8FY+xQ1CcMUcR/vxSgFVgcmB4nFyq/4ATnUoje1XN8yoS
 qUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127852; x=1779732652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Zh1uX+6g1iCyNuMr452Zg32sFLSdswHocLXkqvORIw=;
 b=hltxApNPSYGgD6l+HlgVTzvSMJ24HA50Dm36HXp2G7VbvTSkJKJHKxTHlN5gNO/9mS
 RA7bA7wp4YFV5I1GoKjgBfljQe9CoS2YejOeAyOxpP4NUk+elbFi3GkggB6Su1H4REzP
 4LdM/AkSKFuyzSvXmk/aXFiivGDuZ+UFwAUTYoV0PlVNW3qQNNc+pWTtWbK45X/h4PLI
 IvOsmL6a8/NObtMBPJz0QZVuRTUiJqax9rqicqJz19cUtVfbqVUR57Q4rjUYgsEbAUku
 g4BXRIILdqzFOKZsdKsRbtc+CGPooO3AEpShSi351kSak3s0WGXX4j1Pn7sp/3Z7KzOs
 R++w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GVmF5eLLzlCFWWhwK+9py8GlfQL9Gx22LgqAANKJxczfYS254EuFzvzdgJK6gm2yC/JF52/0aSlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW+WP/vkwZRsYXwzpKBJYQMH1OCljdRhDKH/dUn38BMx876+zj
 bxcu95bNqEFHaHhyQqjgMHcAlSDRqxbcdq7XVh+OlF8xj56H/0mfLQQC1IKu8KgTk7gEVq8rb0S
 /yNwSX9V0cSIlKDuHKl0cH5Ur2DfzhIVBdF030kA=
X-Gm-Gg: Acq92OHk2Y+iZYEwJes4IP437OLzDs5TNPkC7IBMO1aq283z71SFe1XtqcQX7LMrYui
 mJn73vAwrgkKBqf/dwKAVX2o/C1YozqNJQ2U5TjJA2oz4V57P+KZvcswDi7AC1G31QtCqy2YNty
 KHaOSYc60Y3tnCNknf5eO5pEpQCNBPoNUTUHcmY0ljW5o3yOjLSh5ZljEuQPbwAopWdFgBaiCeF
 XIWOzXfVD4DEpLTG0PUaw34s5H4LUqPOOUZi3az6YgJTCDP6+f4rKuZvkJ8RzM5x965S8tPwmc8
 8pgKgAGLX2RKIFQxBKMlSOOrw+/UXGPHQEEc5UdxCpphFNRNuNCiXL5/K0tPLZ6iLrgltzw1hiU
 GrrpSo02ncxHdzsaaZO7eK+9jHaB/Na1zdZf5N7EOc+87rw==
X-Received: by 2002:a05:701a:c971:b0:12f:c7c3:f5ab with SMTP id
 a92af1059eb24-13504b5c729mr7498926c88.2.1779127851270; Mon, 18 May 2026
 11:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <afXGeq1AvqFY76MY@stanley.mountain>
 <agsrBPXYXA2vZgj1@willie-the-truck>
In-Reply-To: <agsrBPXYXA2vZgj1@willie-the-truck>
From: John Stultz <jstultz@google.com>
Date: Mon, 18 May 2026 11:10:39 -0700
X-Gm-Features: AVHnY4JEPSawYOP6NYIZt62uD2ja2iT50yoFNPEGPnVnjR3u9oBDEzKTHYXWqs4
Message-ID: <CANDhNCrbbWf9CebcQjwiTWt_LiZ9NLUa5C84Fco1V_HumL_6bQ@mail.gmail.com>
Subject: Re: [bug report] dma-buf: heaps: Rework heap allocation hooks to
 return struct dma_buf instead of fd
To: Will Deacon <will@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Dan Carpenter <error27@gmail.com>, tjmercier@google.com, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
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

On Mon, May 18, 2026 at 8:06=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Sat, May 02, 2026 at 12:40:10PM +0300, Dan Carpenter wrote:
> > I'm not sure exactly who to report this bug too.  Probably the mm
> > devs?
>
> [Adding John and TJ, in case they are interested / able to help]
>
> Will
>
> (original report follows)
>
> >       drivers/dma-buf/heaps/system_heap.c:499 system_heap_allocate()
> >       warn: passing positive error code 's32min-(-1),1' to 'ERR_PTR'
> >
> > drivers/dma-buf/heaps/system_heap.c
> >     459         if (cc_shared) {
> >     460                 for_each_sgtable_sg(table, sg, i) {
> >     461                         ret =3D system_heap_set_page_decrypted(=
sg_page(sg));
> >     462                         if (ret)
> >     463                                 goto free_pages;
> >
> > It kind of looks like system_heap_set_page_decrypted() can return 1.
> >
> >     464                 }
> >     465         }
> >     466
> >     467         /* create the dmabuf */
> >     468         exp_info.exp_name =3D dma_heap_get_name(heap);
> >     469         exp_info.ops =3D &system_heap_buf_ops;
> >     470         exp_info.size =3D buffer->len;
> >     471         exp_info.flags =3D fd_flags;
> >     472         exp_info.priv =3D buffer;
> >     473         dmabuf =3D dma_buf_export(&exp_info);
> >     474         if (IS_ERR(dmabuf)) {
> >     475                 ret =3D PTR_ERR(dmabuf);
> >     476                 goto free_pages;
> >     477         }
> >     478         return dmabuf;
> >     479
> >     480 free_pages:
> >     481         for_each_sgtable_sg(table, sg, i) {
> >     482                 struct page *p =3D sg_page(sg);
> >     483
> >     484                 /*
> >     485                  * Intentionally leak pages that cannot be re-e=
ncrypted
> >     486                  * to prevent shared memory from being reused.
> >     487                  */
> >     488                 if (buffer->cc_shared &&
> >     489                     system_heap_set_page_encrypted(p))
> >     490                         continue;
> >     491                 __free_pages(p, compound_order(p));
> >     492         }
> >     493         sg_free_table(table);
> >     494 free_buffer:
> >     495         list_for_each_entry_safe(page, tmp_page, &pages, lru)
> >     496                 __free_pages(page, compound_order(page));
> >     497         kfree(buffer);
> >     498
> > --> 499         return ERR_PTR(ret);
> >     500 }
> >
> > The problem is that add_to_pagemap() returns PM_END_OF_BUFFER (1)
> > which is used by pagemap_read() and nowhere else.  The call tree
> > is:
> >
> > system_heap_allocate()
> > system_heap_set_page_decrypted()
> > set_memory_decrypted()
> > realm_set_memory_decrypted()
> > __set_memory_enc_dec()
> > __change_memory_common()
> > update_range_prot()
> > walk_kernel_page_table_range_lockless()
> > walk_pgd_range()
> > pagemap_pte_hole()
> > add_to_pagemap()
> >
> > This code seems sort of old and I guess no one has reported the bug
> > so maybe it's a false positive, but it feels like it's asking for
> > problems to return the PM_END_OF_BUFFER.  There aren't any comments
> > on any of those functions above explaining what return values are
> > expected.

So, do we just need the system_heap_set_page_decrypted() to have a if
(ret > 0) special case on the return check from
set_memory_decrypted()?

Or should this get fixed at a deeper level?

thanks
-john
