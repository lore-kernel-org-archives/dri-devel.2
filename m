Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32128606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfTFfzgg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB2A10F494;
	Tue,  3 Nov 2026 09:31:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BC410F494
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:31:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE906435A1;
 Tue,  3 Nov 2026 09:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8761F000C1;
 Tue,  3 Nov 2026 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793698294;
 bh=fC16NdxBHdU0srh0OABsgzxxvlgydqQxXjKWclcHTvI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jfTFfzggyFUYRSqQAC3fPC/fCK0uFwNV0+C/UmQCj3cQj9oGHSUEWcknZXrqYwo/h
 pgBYuek31bOMwCaJIha47Ec6TS+x0gAzn9MITt5UPoM1FOK5+t5a444KeH2Q+Hlu+v
 Q+lUOGobMEsrIr+cQvgQWFOIiKUJ9MtgiOdqyhjDB+DYpZrsWYlSwBwfU6vRwWw8G9
 +934LwqjVhNGgSwcXXa7mrKQZqOaAqMv6PojVEBC0nMsaxJOvajKQQtn99/00H+lAc
 Pp1B2msamp+a0ST+4mBxEB/opq/FNoIlfscr1jblLuqLzJfqN7BHlqQXLQZC+mpiip
 WOsXFFyVxYcIQ==
Message-ID: <sashiko-outbox-194956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/19] PCI/P2PDMA: Evaluate ACS controls at the path
 divergence
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261103-fix-p2p-acs-v4-0-v12-5-912101f93517@nvidia.com>
References: <20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com>
 <20261103-fix-p2p-acs-v4-0-v12-5-912101f93517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:31:33 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/P2PDMA: missing upstream forwarding check in calc_map_type_and=
_dist()
- [Medium] PCI/P2PDMA: masked redirect and read warnings in calc_map_type_a=
nd_dist()
--

commit ae19e046716c7bc5dbb292aa22e00859ce94d08e
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Evaluate ACS controls at the path divergence

This commit updates calc_map_type_and_dist() to evaluate ACS directional
redirect controls at the path divergence rather than below it. It also
checks for internal routes between functions sharing a PCIe link, verifies
ACS Upstream Forwarding on shared downstream ports, and rejects unreadable
ACS Control registers.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index dbab955dcbdbb..8ca0c9ba87c23 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -589,6 +590,65 @@ static bool pci_acs_p2pdma_ctrl(struct pci_dev *pdev=
, u16 *ctrl)

[ ... ]

> +static struct pci_dev *
> +pci_acs_p2pdma_no_upstream_forwarding(struct pci_dev *common)
> +{
> +	struct pci_dev *pdev;
> +	u16 ctrl;
> +
> +	for (pdev =3D common; pdev; pdev =3D pci_upstream_bridge(pdev)) {
> +		if (!pci_acs_p2pdma_downstream_port(pdev))
> +			continue;
> +
> +		if (!pci_acs_p2pdma_ctrl(pdev, &ctrl))
> +			return pdev;
> +
> +		/*
> +		 * Include Root Ports here. The PCIe port type check excludes
> +		 * the legacy AMD southbridge quirk, which may sleep.
> +		 */
> +		if (pci_dev_specific_acs_enabled(pdev, PCI_ACS_UF) > 0)
> +			continue;
> +
> +		if (!(pdev->acs_cap && pdev->acs_capabilities & ctrl & PCI_ACS_UF))
> +			return pdev;
> +	}
> +
> +	return NULL;
> +}

[ ... ]

> @@ -865,57 +932,106 @@ calc_map_type_and_dist(struct pci_dev *provider, s=
truct pci_dev *client,

[ ... ]

> +check_paths_acs:
> +	*dist =3D dist_a + dist_b;
> =20
> +	/*
> +	 * ACS P2P routing controls apply where a TLP can route toward the peer
> +	 * or upstream. Below that divergence, its only route toward the other
> +	 * branch is upstream, so redirect controls do not affect the path.
> +	 */
> +	if (a_child && b_child) {
> +		if (pci_acs_p2pdma_ctrl(a_child, &ctrl))
> +			state =3D pci_acs_p2pdma_completion(ctrl);
> +		if (state !=3D PCI_ACS_P2PDMA_DIRECT) {
> +			pci_p2pdma_list_redir(&acs_list, &quirk_list, a_child);
> +			if (state =3D=3D PCI_ACS_P2PDMA_REDIRECT)
> +				acs_redirect_cnt++;
> +			else if (!acs_unreadable)
> +				acs_unreadable =3D a_child;
> +		}
> =20
> +		state =3D PCI_ACS_P2PDMA_NOT_SUPPORTED;
> +		if (pci_acs_p2pdma_ctrl(b_child, &ctrl))
> +			state =3D pci_acs_p2pdma_request(ctrl);
> +		if (state !=3D PCI_ACS_P2PDMA_DIRECT) {
> +			pci_p2pdma_list_redir(&acs_list, &quirk_list, b_child);
> +			if (state =3D=3D PCI_ACS_P2PDMA_REDIRECT)
> +				acs_redirect_cnt++;
> +			else if (!acs_unreadable)
> +				acs_unreadable =3D b_child;
> +		}
> +		/*
> +		 * Two children of one Downstream or Root Port share a link.
> +		 * Use topology rather than slot numbers or the multifunction
> +		 * bit, since ARI functions and VFs need not share those.
> +		 */
> +		if (pci_acs_p2pdma_downstream_port(a)) {
> +			req_upstream =3D
> +				pci_acs_p2pdma_no_internal_route(b_child, PCI_ACS_RR);
> +			cpl_upstream =3D
> +				pci_acs_p2pdma_no_internal_route(a_child, PCI_ACS_CR);
> +			uf_blocked =3D pci_acs_p2pdma_no_upstream_forwarding(a);
> +		}
>  	}

[Severity: High]
When provider and client sit behind different Switch Downstream Ports of a
PCIe Switch, their lowest common ancestor a in calc_map_type_and_dist() is
the Switch Upstream Port (PCI_EXP_TYPE_UPSTREAM), where
pci_acs_p2pdma_downstream_port(a) is false.

If b_child has PCI_ACS_RR or PCI_ACS_EC enabled, or a_child has PCI_ACS_CR
enabled, the switch redirects traffic upstream out of the Switch Upstream
Port a toward the host bridge. That redirected TLP then arrives on the
secondary interface of every shared Switch Downstream Port (in a cascaded
switch topology) and Root Port above a with its target also behind that same
secondary interface, requiring PCI_ACS_UF on those shared ports to reach the
host bridge.

Although pci_acs_p2pdma_no_upstream_forwarding() already walks up
pci_upstream_bridge() while skipping Switch Upstream Ports, calling it only
inside if (pci_acs_p2pdma_downstream_port(a)) skips checking the shared
Downstream and Root Ports above a when a is a Switch Upstream Port. Can this
cause calc_map_type_and_dist() to return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
instead of PCI_P2PDMA_MAP_NOT_SUPPORTED when an ancestor port above the
switch lacks PCI_ACS_UF or has an unreadable ACS Control register?

> +	/*
> +	 * Below a shared upstream bridge, a path whose divergence ports do not
> +	 * redirect routes the request directly.
> +	 */
> +	if (!acs_unreadable && !acs_redirect_cnt &&
> +	    !req_upstream && !cpl_upstream) {
>  		map_type =3D PCI_P2PDMA_MAP_BUS_ADDR;
>  		goto done;
>  	}
> =20
> +	if (verbose) {
> +		if (acs_unreadable)
> +			pci_warn(client, "ACS Control is unreadable for provider %s at %s\n",
> +				 pci_name(provider), pci_name(acs_unreadable));
> +		else if (uf_blocked)
> +			pci_warn(client,
> +				 "cannot forward peer-to-peer DMA for provider %s upstream at %s\n",
> +				 pci_name(provider), pci_name(uf_blocked));
> +		else if (req_upstream || cpl_upstream)
> +			pci_warn(client,
> +				 "peer-to-peer DMA with provider %s requires the host bridge; no int=
ernal route between functions\n",
> +				 pci_name(provider));
> +		else
> +			pci_p2pdma_warn_redir(client, provider, &acs_list,
> +					      &quirk_list);
> +	}

[Severity: Medium]
How are diagnostics handled here when sibling functions under a Downstream
Port or Root Port a DO support internal peer-to-peer routing (!req_upstream
&& !cpl_upstream), but have PCI_ACS_RR, PCI_ACS_EC, or PCI_ACS_CR enabled on
the functions themselves (acs_redirect_cnt > 0)?

In that case, disabling ACS redirect on the functions via
pci=3Ddisable_acs_redir=3D would allow them to use their internal route
(PCI_P2PDMA_MAP_BUS_ADDR) without traversing port a. However, because
uf_blocked =3D pci_acs_p2pdma_no_upstream_forwarding(a) is evaluated
unconditionally and checked before the final else branch in the verbose
block, if port a or an ancestor port does not have PCI_ACS_UF enabled,
calc_map_type_and_dist() only warns about upstream forwarding at uf_blocked
and suppresses pci_p2pdma_warn_redir().

Additionally, pci_acs_p2pdma_no_upstream_forwarding() is called before the
PCI_P2PDMA_MAP_BUS_ADDR check (reading PCI_ACS_CTRL up the hierarchy even
when the functions route directly), and when pci_acs_p2pdma_ctrl() fails on
an upstream port, it returns that port as uf_blocked rather than
acs_unreadable, logging an upstream-forwarding message instead of an
unreadable ACS Control warning. Should pci_acs_p2pdma_no_upstream_forwardin=
g()
only be evaluated after the direct-route check, distinguish unreadable ACS
Control registers from missing PCI_ACS_UF, and still emit
pci_p2pdma_warn_redir() when programmable redirect bits blocked a valid
direct route?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-fix-p2p-ac=
s-v4-0-v12-0-912101f93517@nvidia.com?part=3D5
