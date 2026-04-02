Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D04CC6B01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9FB10E322;
	Thu,  2 Apr 2026 05:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QkUO7hZ0";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C5C10E322
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:07:01 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so76084366b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775106420; cv=none;
 d=google.com; s=arc-20240605;
 b=WwoENLO9wso7005gtG4/nw/BKgpjMJsjTZ9sB0ifiTj2qcUZf3uzhp+AIAUzAXNXpe
 trJAA+CAPMIMHjAVzpvjzyEpPdoe5j//vn3XCil1+APlkojtqZg0XURzBoo4vIK6o3S5
 1wEvqNYAs6IT8rXH7rroOb6hSe2TPtnl2VIEruHWKpnMAJXl44GpE7RbqNFnvaEqxIbk
 WIBY7PRuNuiftFUNSN2NBdkaRz8bHQYzr3vAdjgeQwueC5PNBk/sYNpfLodwk/FWc/oz
 0zzYTM6GuO43oQdN3xHbib6a3Hj6lUFfcDLfitPlb9bYA/OCErpFnttYqhXfVVr1RyW/
 35UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
 fh=TLj6UbP6T9VDWyeNWA14uapSn59/at/6OqxqdjbMSbI=;
 b=H/3T0/iWdF5gjEBgOvrgJAnqbs5MMdP1FE8FOGwDQ+ghrgpfb9Ru6yqWJ46MgYVzOq
 Blbeo9xQsRdvOosBzlj9bHoPUHmQ9RNc+nTVQmN4ruQEEN4QLa/uPZhnv9WeG1b+tq0L
 X3FN1T5t/ZLnQOCMOIr5pWQoxMnQxpPQvkgEpk9WDL2Ub2p4kw7vKDb1QqGPkgdmn96/
 ApztBtdAjF5Yq+I7c7HHDBuDzUkw4NkIaCxCoZuhJBwsFNlI/nr7DaAFY57gp2gbSU6q
 J23jKy4SkVCufVnUWUthaXpxVx+u1tGi4rrJf/0OP+ltWgIArkFKzb1N8h03fPNdu5Im
 QS3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775106420; x=1775711220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
 b=QkUO7hZ0v9YmkIJ7uMw0WJJldzy01/ssV193uLt4GpahlAwEniKs71IvDMH7FbfWJd
 tafFSJdwlbBucjCJxbF2ZU9aOtH6H6EFyPSSZFv6J59iqNB1IB5hnrzvnUt5VhSlzxZ8
 l3md3LK/vmgo/yagmErk66VqcKfZoHYWoR6F/xW/HwdA3DYwknTZIBwThttjDDz4/fQs
 a3EXuLSRhTgHz2up32ezKxC884rZZKWNdh3gjZnprREiomtlOEyjMFf80/ObjGHsV+T8
 80Alq0+asnFPlucQc3W3JnWm0V6YLxpytlTc8ry0X6cEZOJK7s6TiEoOcgPeNEnPdw6Z
 lJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775106420; x=1775711220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
 b=tPwdPrEwEmdC87UwQ88Wy84ezDZ6Et+W2fxkOyLL2A1nkgh49TZUS1i6fT8PV5JNYJ
 fAUnMT+r1kF5ZyhU3AjYXIF4JJC9DDIP+vLiaBOrATmwbVyEiazqlTRz1MRtGZrr6g/m
 XWDuqGAegz/GCGqid7gkL/osfevVPMJXgeJ8lqqsIQbBTq/G5vFwQwvK41DklSu0sr2I
 +smrwPQekbnTUwsa0J1NUh2ZxvQNUquWKbs8wpdbqvNVW+/+rUyg+L8pdZxGmTf4oMIz
 T8lXy7G6jt3PtMQQ6Q3lA9gWOTlAKtTuwv1vvx2O+tk1ixe9giQFvJ5MvZ71btOr4pn1
 SeAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxmWRniRRSYNIF6P+ie4tVYnZJrLZu9rj1nxQyjWozfUt/yimXokiRgrNvTRvctcLHtT+trljqpY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGrMoqdxIqMdskCECck+7vi3XB9s+CLWZADP9SznxLv1VwJNfd
 FcQKc1NlwwzjG3XUTZpriTzSc5rJkCWX+Sddh1AaBajr9+rm7SKAIJnyFGZS7q5DBWzFUF5VA+H
 jHAg4jkt4v/4j7lfqVfxS3/qJdb7fIv4FjEWmhBilPg==
X-Gm-Gg: ATEYQzzI3jp/0/OWulQSHFChM6JO9uJVtDOZI9BXQeCDG5nGWW/wLZlby2PACd+UApx
 garoWuS2oqPIcX8UP3J8xtk2KzGlarU/imPiHvsMQwYgQf/0xKkowmxFVYhRvnhV7oYpaO9RhLX
 qHoaKEZWPwOBqIxyIjCc9LKz+n6gqw6B5fEdNdca2npzxArWOdVjh/jn1cqTbbjD6BQbqCpBxET
 xaHIqV9dyyThQ9BKiI1OmDp+/PmWznolwo3xk52N4JS5LQCaz4b08QVjEH9in1MCzna6uDx3C6s
 syYG5ebUMAxsbYR4s8X6L1ZsGSvIPuYqZ+PJgEU=
X-Received: by 2002:a17:906:f185:b0:b97:4e42:23ef with SMTP id
 a640c23a62f3a-b9c138f8b82mr248056566b.16.1775106419953; Wed, 01 Apr 2026
 22:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260331100026eucas1p19bdc2aaca4c9a48c6f6ac8fec71478d8@eucas1p1.samsung.com>
 <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
 <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
In-Reply-To: <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 10:36:48 +0530
X-Gm-Features: AQROBzCJbHUqpXNhrktgFRPzZ2TP3XLnRpMznWDVTmhDI0Xxoe_pLYi4105Frnw
Message-ID: <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, 
 Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
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

Hello Maxime,

On Tue, 31 Mar 2026 at 18:24, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 31.03.2026 12:00, Maxime Ripard wrote:
> > The recent introduction of heaps in the optee driver [1] made possible
> > the creation of heaps as modules.
> >
> > It's generally a good idea if possible, including for the already
> > existing system and CMA heaps.
> >
> > The system one is pretty trivial, the CMA one is a bit more involved,
> > especially since we have a call from kernel/dma/contiguous.c to the CMA
> > heap code. This was solved by turning the logic around and making the
> > CMA heap call into the contiguous DMA code.
> >
> > Let me know what you think,
> > Maxime
> >
> > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wikl=
ander@linaro.org/
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>

Thank you for this patch series; now that it is needed by more folks,
I think we can merge this.

Marek, I'll coordinate with you on this - thank you!

Best,
Sumit.


>
>
> Applied again patches 1-5 to my dma-mapping-for-next branch. I hope this =
time it
>
> won't cause new problems in linux-next.
>
>
> Here is a stable branch to apply remaining dma-buf heaps patches:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git=
/log/?h=3Ddma-contig-for-7.1-modules-prep-v4
>

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


--
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed
