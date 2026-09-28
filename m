Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06197CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE4810E955;
	Mon, 28 Sep 2026 17:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="UNlde3uG";
	dkim-atps=neutral
Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com
 [74.125.230.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB0910E955
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 17:29:42 +0000 (UTC)
Received: by mail-qv2-f42.google.com with SMTP id
 6a1803df08f44-914488d0455so23108366d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790616581; x=1791221381; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8wHi2lHLlVmnngzxn3a4naORn9qZPczzGL0TvCk5Do=;
 b=UNlde3uG02It+D9U8tnuibWm+jideiDKzJTUzegC5TAI262cE8Evamj7r8EJe1gBtP
 0cUWIg5pGL+l0XzUAF9peZTtHQ/AO2cg/7XHnSOPmwXxcVgZs8zHhg3zUjK1pa7Sif5W
 F6/z2UqxD24bqrAVOtgtUQyPvhYlXDi05sIoKxZg8zbX8FBKNIV/CJsE+LDL9jmFLfQa
 zYEbxEaQIJCDU4P7OWtEHKqTQci5FXPyQjW0vB1GvNPI152RTnNMgM9lQeAiL0hOzSzs
 MEKk9kJuhcs4LhQCxnj6tun0VaOjdoBFpKlov4urlTC1g0aCPY3gEe70QVc2epYiRt8K
 MtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616581; x=1791221381;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8wHi2lHLlVmnngzxn3a4naORn9qZPczzGL0TvCk5Do=;
 b=QUuxLjR0C6l5qpb3dj13Okgwg61DJQY778z5tg301pTW4D33ehm7rvqIkwHChtOxZm
 8tvCtUvoT8YC+B1Bq7Xk78qGpEDqjmSOI57lKEyJj2DB/OyW1EUWKxn6nXO8SdLFAQNw
 oJUSRDfBlPaQTDjwQL6FA+GJA7NIDIl2X3KfLQYXJpSqh/ONRPBXspbgAk5rKMgb3K0G
 uRrr/bnQuutzO5STuSdNRKfjFfXjWRa+vAOC8AybtZPMmjFT0WcRjJRvcyS2kMs6ZkVt
 reUqoWUGm0yc3gQKD5mC5a5jrjiyX1XGDGJITPZojco0F6UkNpFAD53sGQhe/wQD7DGS
 rXVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByk/CIQ9U/SlWWFGw2IqY2Ph/j0hC4NV8iZnaLkubhrBT4RAq84j0gZvPeCoafugpl4t/LfhWktzc8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+ySXksSTScxWnyCLdtfdKIw9H2oWOoNcpbLcGitURTYtk7DNg
 +euD8hiogCI4zZLi7soi1/uthfPXwz2xpCDewr9GeBrglq5SV5kqdvqmxwOPSo67Cvw=
X-Gm-Gg: AYBFou3nWlH0bGT4FTniXvC9jvItDt4qH0oIeJNuGw7VLhk7qh6C2V2olEklb654Juh
 gtbfg5HBRvXC+jN3peT/l/HjveLBefbGzUjDQs+wySPyHPfcso6yWSUj251HWTTWIbxKs2aPolg
 2j5a8eVwHM33uye7rJJk/OTP/9mvK8fP1T52S5gryJ0DwY5pe0kbEeESi29vcVhKjio0I3th2z0
 la4PfMPqnO4EyaYeGY+m9soUD/kT1KbZiALzHY66wS4Z7Z5FVoziJt0Q2yEwWr8msi7VjwszYqp
 qCkz9vdYgIhpqr0rhbq9p+tIx4ADnZGgno/VI7AopY9gzwjkrdHrInV8VQK9KwpSAGjZoaq6GxW
 BEzVKy7fVfeze+6iCZaZUAOAGOg3puwtd64wLsrB8/1GEsGFCHufgsEQ8EotX1C2CirgCBEnlqM
 qxKmbWyGXmd9/ZdQMgiIwROSOJeF66wWOpSybRN2EKKqLE
X-Received: by 2002:a05:6214:19c6:b0:916:7629:f1c with SMTP id
 6a1803df08f44-91676291098mr52487856d6.10.1790616581176; 
 Mon, 28 Sep 2026 10:29:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430df77adsm84361036d6.26.2026.09.28.10.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:29:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBFAZ-00000007NhG-43XU;
 Mon, 28 Sep 2026 14:29:39 -0300
Date: Mon, 28 Sep 2026 14:29:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260928172939.GK163130@ziepe.ca>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca>
 <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
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

On Thu, Sep 24, 2026 at 11:17:57PM -0700, Zhiping Zhang wrote:
> On Thu, Sep 24, 2026 at 4:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > >
> > On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > > I don't think this belongs in the importer. Every in-tree dma-buf
> > > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > > habanalabs memory.c. There is no importer-side caller.
> >
> > Right, and they shouldn't be doing that, but it still has to be
> > checked that the st is going directly to the peer device not the host
> > bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> > indication.
> >
> > I fear you will need some of Leon's series to make that happen.
> >
> > So probably the proposed change to dmabuf ops is far too simple.
> >
> > Jason
> 
> Hi Jason,
> 
> Thanks for the comments.
> 
> Agreed -- the tag should not be handed out unless the routing is
> PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
> with two changes. I can fold both into patch 4.
> ```
> In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
> tristate VFIO_PCI_CORE:
> 
>     EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);

No, that's been rejected several times already.
 
> and in drivers/vfio/pci/vfio_pci_dmabuf.c,
> vfio_pci_dma_buf_get_pci_tph() gains:
> 
>     struct dma_buf_attachment *attach;
> 
>     if (list_empty(&dmabuf->attachments))
>         return -EOPNOTSUPP;
> 
>     list_for_each_entry(attach, &dmabuf->attachments, node)
>         if (pci_p2pdma_map_type(priv->provider, attach->dev) !=
>             PCI_P2PDMA_MAP_BUS_ADDR)
>                 return -EOPNOTSUPP;
> ```

Also no, this has to be done via PCI_P2PDMA_MAP_BUS_ADDR which also
enforces putting the determination in the right place in the code
flow..

> Two properties are worth stating explicitly:

Ah! AI!

Jason
