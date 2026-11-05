Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9E606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjbnjB7G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFF011225F;
	Thu,  5 Nov 2026 08:53:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD7311225F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:53:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E884E412BC;
 Thu,  5 Nov 2026 08:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BA1F000C1;
 Thu,  5 Nov 2026 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793868807;
 bh=J7vfUkafQT4T5T8qqfuJQdq9zP4CBm2tNhbBc8LF8kE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cjbnjB7GJibNOC+EeGoO0DpYNfYuH5n6u0/wbnbr6UIGwIg3GndAH3sGQGQzIZMDY
 Dqf1oapH/2gfH0/ahH8TYNjXCQ/G02ZmiL+IpqU3h3J/jfM+rv/BNs08bmrGgRim4q
 6ACU5R1Zk4RFMPN+m+sVaa+AwMVqU0xnuglOESZ9dmJL8JSz+IGUBgwguFZi6MEKyp
 Fb+xbw6UuOWf9KN2s//Y3RJDSrhRTdcmaKRT7iLTFS9ayXyu+tpURY//KN4NoPtipc
 Mthcgo8RG5bVVVkwzvi9GS0kAczU6L/l/D+3K7S6jFfndeO7M5b3mdw7K8JSXmbPXZ
 LfEgYqbvufKpw==
Date: Thu, 5 Nov 2026 10:53:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v12 05/19] PCI/P2PDMA: Evaluate ACS controls at the path
 divergence
Message-ID: <20261105085323.GK478286@unreal>
References: <20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com>
 <20261103-fix-p2p-acs-v4-0-v12-5-912101f93517@nvidia.com>
 <sashiko-outbox-194956@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-194956@kernel.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 09:31:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] PCI/P2PDMA: missing upstream forwarding check in calc_map_type_and_dist()
> - [Medium] PCI/P2PDMA: masked redirect and read warnings in calc_map_type_and_dist()
> --
> 
> commit ae19e046716c7bc5dbb292aa22e00859ce94d08e
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Evaluate ACS controls at the path divergence
> 
> This commit updates calc_map_type_and_dist() to evaluate ACS directional
> redirect controls at the path divergence rather than below it. It also
> checks for internal routes between functions sharing a PCIe link, verifies
> ACS Upstream Forwarding on shared downstream ports, and rejects unreadable
> ACS Control registers.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index dbab955dcbdbb..8ca0c9ba87c23 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -589,6 +590,65 @@ static bool pci_acs_p2pdma_ctrl(struct pci_dev *pdev, u16 *ctrl)
> 
> [ ... ]
> 
> > +static struct pci_dev *
> > +pci_acs_p2pdma_no_upstream_forwarding(struct pci_dev *common)
> > +{
> > +	struct pci_dev *pdev;
> > +	u16 ctrl;
> > +
> > +	for (pdev = common; pdev; pdev = pci_upstream_bridge(pdev)) {
> > +		if (!pci_acs_p2pdma_downstream_port(pdev))
> > +			continue;
> > +
> > +		if (!pci_acs_p2pdma_ctrl(pdev, &ctrl))
> > +			return pdev;
> > +
> > +		/*
> > +		 * Include Root Ports here. The PCIe port type check excludes
> > +		 * the legacy AMD southbridge quirk, which may sleep.
> > +		 */
> > +		if (pci_dev_specific_acs_enabled(pdev, PCI_ACS_UF) > 0)
> > +			continue;
> > +
> > +		if (!(pdev->acs_cap && pdev->acs_capabilities & ctrl & PCI_ACS_UF))
> > +			return pdev;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> [ ... ]
> 
> > @@ -865,57 +932,106 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> 
> [ ... ]
> 
> > +check_paths_acs:
> > +	*dist = dist_a + dist_b;
> >  
> > +	/*
> > +	 * ACS P2P routing controls apply where a TLP can route toward the peer
> > +	 * or upstream. Below that divergence, its only route toward the other
> > +	 * branch is upstream, so redirect controls do not affect the path.
> > +	 */
> > +	if (a_child && b_child) {
> > +		if (pci_acs_p2pdma_ctrl(a_child, &ctrl))
> > +			state = pci_acs_p2pdma_completion(ctrl);
> > +		if (state != PCI_ACS_P2PDMA_DIRECT) {
> > +			pci_p2pdma_list_redir(&acs_list, &quirk_list, a_child);
> > +			if (state == PCI_ACS_P2PDMA_REDIRECT)
> > +				acs_redirect_cnt++;
> > +			else if (!acs_unreadable)
> > +				acs_unreadable = a_child;
> > +		}
> >  
> > +		state = PCI_ACS_P2PDMA_NOT_SUPPORTED;
> > +		if (pci_acs_p2pdma_ctrl(b_child, &ctrl))
> > +			state = pci_acs_p2pdma_request(ctrl);
> > +		if (state != PCI_ACS_P2PDMA_DIRECT) {
> > +			pci_p2pdma_list_redir(&acs_list, &quirk_list, b_child);
> > +			if (state == PCI_ACS_P2PDMA_REDIRECT)
> > +				acs_redirect_cnt++;
> > +			else if (!acs_unreadable)
> > +				acs_unreadable = b_child;
> > +		}
> > +		/*
> > +		 * Two children of one Downstream or Root Port share a link.
> > +		 * Use topology rather than slot numbers or the multifunction
> > +		 * bit, since ARI functions and VFs need not share those.
> > +		 */
> > +		if (pci_acs_p2pdma_downstream_port(a)) {
> > +			req_upstream =
> > +				pci_acs_p2pdma_no_internal_route(b_child, PCI_ACS_RR);
> > +			cpl_upstream =
> > +				pci_acs_p2pdma_no_internal_route(a_child, PCI_ACS_CR);
> > +			uf_blocked = pci_acs_p2pdma_no_upstream_forwarding(a);
> > +		}
> >  	}
> 
> [Severity: High]
> When provider and client sit behind different Switch Downstream Ports of a
> PCIe Switch, their lowest common ancestor a in calc_map_type_and_dist() is
> the Switch Upstream Port (PCI_EXP_TYPE_UPSTREAM), where
> pci_acs_p2pdma_downstream_port(a) is false.
> 
> If b_child has PCI_ACS_RR or PCI_ACS_EC enabled, or a_child has PCI_ACS_CR
> enabled, the switch redirects traffic upstream out of the Switch Upstream
> Port a toward the host bridge. That redirected TLP then arrives on the
> secondary interface of every shared Switch Downstream Port (in a cascaded
> switch topology) and Root Port above a with its target also behind that same
> secondary interface, requiring PCI_ACS_UF on those shared ports to reach the
> host bridge.
> 
> Although pci_acs_p2pdma_no_upstream_forwarding() already walks up
> pci_upstream_bridge() while skipping Switch Upstream Ports, calling it only
> inside if (pci_acs_p2pdma_downstream_port(a)) skips checking the shared
> Downstream and Root Ports above a when a is a Switch Upstream Port. Can this
> cause calc_map_type_and_dist() to return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> instead of PCI_P2PDMA_MAP_NOT_SUPPORTED when an ancestor port above the
> switch lacks PCI_ACS_UF or has an unreadable ACS Control register?

The thing is that this behaviour was before my series, but let's change
it too.

> 
> > +	/*
> > +	 * Below a shared upstream bridge, a path whose divergence ports do not
> > +	 * redirect routes the request directly.
> > +	 */
> > +	if (!acs_unreadable && !acs_redirect_cnt &&
> > +	    !req_upstream && !cpl_upstream) {
> >  		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
> >  		goto done;
> >  	}
> >  
> > +	if (verbose) {
> > +		if (acs_unreadable)
> > +			pci_warn(client, "ACS Control is unreadable for provider %s at %s\n",
> > +				 pci_name(provider), pci_name(acs_unreadable));
> > +		else if (uf_blocked)
> > +			pci_warn(client,
> > +				 "cannot forward peer-to-peer DMA for provider %s upstream at %s\n",
> > +				 pci_name(provider), pci_name(uf_blocked));
> > +		else if (req_upstream || cpl_upstream)
> > +			pci_warn(client,
> > +				 "peer-to-peer DMA with provider %s requires the host bridge; no internal route between functions\n",
> > +				 pci_name(provider));
> > +		else
> > +			pci_p2pdma_warn_redir(client, provider, &acs_list,
> > +					      &quirk_list);
> > +	}
> 
> [Severity: Medium]
> How are diagnostics handled here when sibling functions under a Downstream
> Port or Root Port a DO support internal peer-to-peer routing (!req_upstream
> && !cpl_upstream), but have PCI_ACS_RR, PCI_ACS_EC, or PCI_ACS_CR enabled on
> the functions themselves (acs_redirect_cnt > 0)?
> 
> In that case, disabling ACS redirect on the functions via
> pci=disable_acs_redir= would allow them to use their internal route
> (PCI_P2PDMA_MAP_BUS_ADDR) without traversing port a. However, because
> uf_blocked = pci_acs_p2pdma_no_upstream_forwarding(a) is evaluated
> unconditionally and checked before the final else branch in the verbose
> block, if port a or an ancestor port does not have PCI_ACS_UF enabled,
> calc_map_type_and_dist() only warns about upstream forwarding at uf_blocked
> and suppresses pci_p2pdma_warn_redir().
> 
> Additionally, pci_acs_p2pdma_no_upstream_forwarding() is called before the
> PCI_P2PDMA_MAP_BUS_ADDR check (reading PCI_ACS_CTRL up the hierarchy even
> when the functions route directly), and when pci_acs_p2pdma_ctrl() fails on
> an upstream port, it returns that port as uf_blocked rather than
> acs_unreadable, logging an upstream-forwarding message instead of an
> unreadable ACS Control warning. Should pci_acs_p2pdma_no_upstream_forwarding()
> only be evaluated after the direct-route check, distinguish unreadable ACS
> Control registers from missing PCI_ACS_UF, and still emit
> pci_p2pdma_warn_redir() when programmable redirect bits blocked a valid
> direct route?

ok, let's change it too.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com?part=5
