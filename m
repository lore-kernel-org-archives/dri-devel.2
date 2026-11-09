Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75960606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TImMvHFX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC50110F2B3;
	Mon,  9 Nov 2026 13:44:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AB510F2CF
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794231872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
 b=TImMvHFXpxlE3RZ/IESRjzXY1Bz3uz7xYgDzlWTn5NUo4sYbsDhB250NNUtPlMXxdG6DBc
 WGLwO6SrQB9OF8tN3uQs4q77tBIalQZPSuzMxkuyVzd/PCVOY7m+CBdrO/4kVUtIPdziQv
 zULBqgLEhzg8pLONbEyJmnj8v9psdCA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-E53TZ_I1OAybqwOJ0T9wYg-1; Mon, 09 Nov 2026 08:44:31 -0500
X-MC-Unique: E53TZ_I1OAybqwOJ0T9wYg-1
X-Mimecast-MFC-AGG-ID: E53TZ_I1OAybqwOJ0T9wYg_1794231871
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-5682eb98dafso636863b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 05:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794231871; x=1794836671;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
 b=hV30PPNc5V8i8KIzenknOMxpDnXsY52VmW0Sz6oWUCmwujUP/57ssTCWhOUIt0HHBO
 DzuK42Nlry6HOLZ2TmnOIikswIB4m+jmmlxun4NnNtvVWyANsXr89weDIGlUFxrRiRCE
 +OpgF6RdBErJrsSHzkoq3p0EuKhVXppySp++t+8cylRdEsexaOKWSP5+gYAPxYbtBhnJ
 6Nsg87Tqc9gMGPvK4cAZII5ICnU/xNn761CSzQRnv4ktxqwFkffKlaiegwqe1MsJYJZf
 6mYfxQKGxexpWR75brYskm8X8djgS1yy2ffEyySeT2AWmBMmgqTU7yuafGgDj5US0AaR
 H4ig==
X-Forwarded-Encrypted: i=1;
 AL+hErGxg4EZXgszupuIh+Yof1BjrSIbd2FqlDMrIzYrVov5vho9a9qnLwO3uesKbqQNgaCkb9RQu0/7PGk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EQj26fKWw+iXeSTQoLCHo50yAGEME8PIF4plxcvHh+cddH+iI
 UR72AYbXKoNRIL1cutnLR8CljgKpzwNpg9SUE+ZW1tBzkZhtFkQFyuW6kEjUooAkP96sg3SQOGN
 sOAIdPz+8stoDmD0phX8WVg/bhpOjr4+nlmGV67vkzbhAVv5Wjy5BTfEwU0unul/jmpNIApCDaY
 tZSBg8b1FHbG6VroKDVXDoF2UNP1Wpmiekw71scJsTjim5
X-Gm-Gg: AYBFou1/yBvrzIaRrsV6K8xUQRt0/TwXXwCIW2W2aYhgua15M4t49MlWH5d9QcKwsxX
 3nXNWpSKCD1zWtgqdWqwRSL402zFGhhiONfalSmObbVPT4XkoZO3gL36cBDIzl+WKIC44tJioVK
 x3YUKN+sjczd/55pnKajVnC46ypDKAhOoitlEqvgabKpRtUvOmZnldFw29
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-56814022659mr2709803b6e.9.1794231870763; 
 Mon, 09 Nov 2026 05:44:30 -0800 (PST)
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-56814022659mr2709756b6e.9.1794231870169; Mon, 09 Nov 2026
 05:44:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
 <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
 <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
In-Reply-To: <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Nov 2026 14:44:17 +0100
X-Gm-Features: AclHuK-kxgj3T37bjFOZ7HtSClpdxsaDMPyjW53dccz7zE1_ZSRFcURRmSZwzSI
Message-ID: <CADSE00L3AfcnfcboK1TdPQiW7ZW1KpxG70b1oyWFqpLciOG6ng@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to
 memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Tao Cui <cui.tao@linux.dev>,
 akpm@linux-foundation.org, 
 dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com, 
 jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com, 
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
 stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org, 
 vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
 phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
 mason@kernel.org, harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sYChuqy6GgowILBl19fAzbW8EWTVbPIy0HxVNGOZp0I_1794231871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 11:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/6/26 18:25, T.J. Mercier wrote:
> > On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 11/6/26 14:18, Tao Cui wrote:
> >>> From: Tao Cui <cuitao@kylinos.cn>
> >>>
> >>> udmabuf pins the pages of a memfd and hands them out as a dma-buf.  T=
he
> >>> data pages keep the accounting of the memfd they were instantiated in=
,
> >>> but the bookkeeping around them does not: the page pointer array and
> >>> the pinned_folios array, both sized by the buffer page count, plus th=
e
> >>> transient folios array sized by the memfd folio count, are plain
> >>> GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> >>> memory, and size_limit_mb defaults to INT_MAX.
> >>>
> >>> Charge the three kvmalloc allocations so the creator pays for the
> >>> metadata it induces.  The system heap in the same subsystem already
> >>> accounts its buffer allocation;
> >
> > Only if the mem_accounting param is set to true. We (Android)
> > currently depend on it being disabled because system heap buffers
> > don't have a single owner for their entire lifetime (ownership often
> > changes immediately after they are allocated), and the kernel doesn't
> > have the ability to switch who is charged for the buffer memory quite
> > yet. Albert is working hard on it at the moment.
>
> Good point, making sure that Albert is on CC as well.
>
> So basically we not only need to charge the backing store of a DMA-buf to=
 somebody else, but also the housekeeping overhead.

For system heaps the housekeeping size is fixed at creation so it
kindof fits the reservation model nicely. We'd only need it to account
for the overhead (as part of the MEMCG_DMABUF stat probably).

>
> Mhm, this here also complicates the charge transfer Albert is working on.

The transfer would just move the charge as a single unit. But yeah,
the complexity will come from lazy exporters or any other exporter
where the bookkeeping grows or changes.

>
> @Albert not something we need to take care about now, but please keep tha=
t in mind while working on that stuff.

Noted. The issue already exists so my series does not make it worse. I
will note this for a follow up series.

Thanks for tagging me!

BR,
Albert

>
> Regards,
> Christian.
>
> >
> > Could you update the message to note the mem_accounting param pls?
> >
> >>> the data pages here stay with the
> >>> memfd.
> >
> > memfd / udmabuf is a little special because it uses shmem for the
> > backing store, which is already tracked by memcg under all conditions
> > (except hugetlb). We don't currently use udmabuf, so the lack of memcg
> > charge transfer for udmabuf is not an issue. But once we get charge
> > transfer working for the system heap it'd be good to follow up with
> > udmabuf.
> >
> >> T.J. needs to take a look here, but I fear that this might break uAPI.
> >
> > Thanks for looping me in Christian. The buffer allocations cost
> > gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
> > so I don't expect charging them to break anyone. Leaving them
> > uncharged is an accounting gap though, since someone could spam many
> > udmabufs from the same memfd and only pay for the memfd pages once. So
> > this change is ok with me.
> >
> >> A lot of the DMA-buf resources are intentionally not charged against m=
emcg.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >
> > With the commit message updated to mention the mem_accounting param:
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
>

