Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99B2CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5142510F6F7;
	Thu,  1 Oct 2026 15:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WKHEr+Q/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4E510F6F0
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:24:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04F0341A87;
 Thu,  1 Oct 2026 15:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A01F000FF;
 Thu,  1 Oct 2026 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790868240;
 bh=u2Ft3FbFfr4tJ/bFZdJy0PXDor5ut/5iXgrR9l6rsPI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WKHEr+Q/TULo60S7m4kSFKAMsAxsNLRf9p20X8KWtX2OrakXvwdbBi9nUWwW0a2YC
 remeRO9qKeNQ6b7M+nk8n+TQKg2KnxQOjR2Ya/VxkjnCELMva434kMD9v+3or4+mzp
 pihzuHWOq1tmhUis81VXca7bqmjlckVkWzJJEsxjs6HL1PoGQrKMU/pz7l/fb+6+bQ
 zvf7bIXcfLupi/Oek4XmVP2yJC/cJAXZ4B8xZbDoHZCPuX+k6hwWFAyRJz/l0CAeTd
 GGq4d92rNJC5fE693UvPoMEMercHMx6JCiCkcuT/pp/no5FSdbOVpFsiGz1ilIDVak
 wHPM7eRgd/MgA==
Date: Thu, 1 Oct 2026 18:23:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 17/18] PCI/P2PDMA: Evaluate the ATS path for clients
 with ATS enabled
Message-ID: <20261001152355.GN3401365@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-17-1a8e0f50ddd9@nvidia.com>
 <20261001120756.A5CC41F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001120756.A5CC41F000FF@smtp.kernel.org>
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

On Thu, Oct 01, 2026 at 12:07:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci/p2pdma: pcim_p2pdma_set_ats_per_mapping() silently fails for pure clients
> --
> 
> commit 39432dea495f68fb0a21d0daa1f31ba24e130b39
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Evaluate the ATS path for clients with ATS enabled
> 
> P2PDMA assumes every client issues Untranslated Requests. A device with
> ATS enabled may translate any address it is handed, including a bus
> address, and Translation Blocking can reject its Translated Requests on
> a route the Untranslated answer called usable. This commit takes the
> Address Type from its ATS Enable bit and avoids handing such a client
> bus addresses unless the client declared per-mapping ATS.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 6a63901c65fb6..9c0943fdb3e36 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> [ ... ]
> > @@ -1633,6 +1674,9 @@ pci_p2pdma_map_type_tlp(struct p2pdma_provider *provider, struct device *dev,
> >  	cache_index = map_types_idx(client);
> >  
> >  	rcu_read_lock();
> > +	/* The declaration belongs to the client, the cache to the provider. */
> > +	p2pdma = rcu_dereference(client->p2pdma);
> > +	per_mapping = p2pdma && p2pdma->ats_per_mapping;
> 
> [Severity: High]
> Does this code handle pure P2PDMA clients correctly?
> 
> Since pure clients (devices initiating P2P transfers but not providing memory)
> have no mechanism or reason to call pcim_p2pdma_init(), client->p2pdma will
> be NULL for them.
> 
> This means when they call pcim_p2pdma_set_ats_per_mapping(), it silently returns
> and drops the configuration:
> 
> drivers/pci/p2pdma.c:pcim_p2pdma_set_ats_per_mapping() {
>     ...
> 	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> 	if (!p2p)
> 		/*
> 		 * ats_per_mapping is a performance optimization,
> 		 ...
> 		 */
> 		return;
> 
> 	p2p->ats_per_mapping = true;
> }
> 
> Because client->p2pdma is NULL, per_mapping will always evaluate to false
> here in pci_p2pdma_map_type_tlp(). This leads to pci_p2pdma_client_map_type()
> incorrectly overriding the map type, which could return
> PCI_P2PDMA_MAP_NOT_SUPPORTED and break P2P transfers that should have been
> permitted.
> 
> How should pure clients register their ATS per-mapping capability if they
> do not initialize pdev->p2pdma?

I don't know there Sashiko gets these ideas, but no "pure client"
shouldn't call to pcim_p2pdma_set_ats_per_mapping().

Thanks

> 
> >  	p2pdma = rcu_dereference(pdev->p2pdma);
> >  
> >  	if (p2pdma)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=17
