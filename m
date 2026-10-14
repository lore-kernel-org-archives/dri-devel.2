Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E71CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBF810FB32;
	Wed, 14 Oct 2026 06:49:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAC310FB4A
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:49:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00C394480A;
 Wed, 14 Oct 2026 06:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7831F000FF;
 Wed, 14 Oct 2026 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791960589;
 bh=HsruFh9QO1GPcgzHM/eIN4QvMcLaW/LA6gWESnfZHSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mVJlbiM/EP8ys9nyQRDJQ8sn/T7DsLfHRZN3r21zlTQW1lbP8DSx8EyerYncpPuIr
 gA8I/QGeDH/hEoLd1e+zjbQBZxG7gm8HTOMZljFD7QZTLouzkmL0DxR9Ce798ft153
 TNzQNikJIS5F92B+DeqacWEJVvLtcSRxU6tplhlM1ezsfZXiCx6dsF7Fk+/SH62Zo0
 PSrKysfbHH/CqRs960H2nixrrskAKRkm/4JMCreLuuzBC2PB8eq8zqS89yOaOofyQ+
 0pHTvN3JbWdeu49VRw0MT1hERXmPdsfhqdxp7bb8nSE4upQ3Od/TBgGvPoqsjF2M+E
 /3rft81V54rEw==
Date: Wed, 14 Oct 2026 09:49:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v11 01/19] PCI/P2PDMA: Honor device-specific ACS
 redirection
Message-ID: <20261014064946.GU219304@unreal>
References: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
 <20261013-fix-p2p-acs-v4-0-v11-1-72cf8c96e617@nvidia.com>
 <sashiko-outbox-169930@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-169930@kernel.org>
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

On Tue, Oct 13, 2026 at 02:44:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci/p2pdma: deadlock in calc_map_type_and_dist() calling xa_store() from softirq
> --
> 
> commit 6120f97b22446453f3e4fa09135e1a44135ecfe8
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Honor device-specific ACS redirection
> 
> This commit updates PCI P2PDMA to respect device-specific ACS redirection
> quirks for switches and ports that redirect peer-to-peer traffic without a
> standard ACS capability. It queries quirks to set Request and Completion
> Redirect flags and modifies how affected ports are warned about.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 45260423dfb09..ba94b0f339285 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> [ ... ]
> > @@ -782,15 +867,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  		goto done;
> >  	}
> >  
> > -	if (verbose) {
> > -		/* Drop the final semicolon; the list is not empty here */
> > -		if (!seq_buf_has_overflowed(&acs_list))
> > -			acs_list.buffer[acs_list.len - 1] = '\0';
> > -		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
> > -			 pci_name(provider));
> > -		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> > -			 seq_buf_str(&acs_list));
> > -	}
> > +	if (verbose)
> > +		pci_p2pdma_warn_redir(client, provider, &acs_list, &quirk_list);
> >  
> >  map_through_host_bridge:
> >  	if (!cpu_supports_p2pdma() &&
> 
> [Severity: High]
> Does calling xa_store() further down in this function risk a deadlock?

Not in the current code base, I failed to find any reliable path for it.

Thanks
