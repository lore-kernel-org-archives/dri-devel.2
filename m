Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7CDCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D0B10E083;
	Tue, 13 Oct 2026 14:44:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9255E10E083
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:44:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B59D8602C3;
 Tue, 13 Oct 2026 14:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155CC1F000FF;
 Tue, 13 Oct 2026 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791902678;
 bh=S5XZjEefQh4EdB8bPyGtES7lAp11auEruiseyw9G5YA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G67LPayEaPri6jX7U5aHSF1SoPf+InmeNCiNXfrvN6JmLfx/cThKUlw47VO475TOm
 5AujQBlSTAePAMTMZF7yiBJF633Y6PyePVnEcLi/EEBMB8T5ptdGj/0HhhELA7XoB3
 d6txSnyju2ccA6ICBkVPOs9xwrFub1e4Z5dwygC2S4dePYWGtal9bWQOxsO39e6FsY
 8vEFBFKZuy7hSw9YImsrCi+qmqlkI4emnqAUbQDAx/TgZlXjx8z9GbG5rYQv7AJ/Nq
 90AjfRnX2WMX4spgriJFjhOkwcoDakw1F00ny8fM7/caqQFEicyDIJopG1yqNxDtGu
 um6rpmKSMRaCg==
Message-ID: <sashiko-outbox-169930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/19] PCI/P2PDMA: Honor device-specific ACS
 redirection
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261013-fix-p2p-acs-v4-0-v11-1-72cf8c96e617@nvidia.com>
References: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
 <20261013-fix-p2p-acs-v4-0-v11-1-72cf8c96e617@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:44:37 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/p2pdma: deadlock in calc_map_type_and_dist() calling xa_store(=
) from softirq
--

commit 6120f97b22446453f3e4fa09135e1a44135ecfe8
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Honor device-specific ACS redirection

This commit updates PCI P2PDMA to respect device-specific ACS redirection
quirks for switches and ports that redirect peer-to-peer traffic without a
standard ACS capability. It queries quirks to set Request and Completion
Redirect flags and modifies how affected ports are warned about.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 45260423dfb09..ba94b0f339285 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
[ ... ]
> @@ -782,15 +867,8 @@ calc_map_type_and_dist(struct pci_dev *provider, str=
uct pci_dev *client,
>  		goto done;
>  	}
> =20
> -	if (verbose) {
> -		/* Drop the final semicolon; the list is not empty here */
> -		if (!seq_buf_has_overflowed(&acs_list))
> -			acs_list.buffer[acs_list.len - 1] =3D '\0';
> -		pci_warn(client, "ACS redirect is set between the client and provider =
(%s)\n",
> -			 pci_name(provider));
> -		pci_warn(client, "to disable ACS redirect for this path, add the kerne=
l parameter: pci=3Ddisable_acs_redir=3D%s\n",
> -			 seq_buf_str(&acs_list));
> -	}
> +	if (verbose)
> +		pci_p2pdma_warn_redir(client, provider, &acs_list, &quirk_list);
> =20
>  map_through_host_bridge:
>  	if (!cpu_supports_p2pdma() &&

[Severity: High]
Does calling xa_store() further down in this function risk a deadlock?

The map_types xarray is initialized with a plain xa_init() (without
XA_FLAGS_LOCK_IRQ) in pcim_p2pdma_init(). This means its internal lock
operates as a simple process-context spin_lock.

Since calc_map_type_and_dist() can be called from softirq/hardirq context
during P2P DMA mapping (e.g., via dma_map_sg()), and xa_store() takes the
xarray lock without disabling interrupts, a process-context thread interrup=
ted
by a DMA mapping on the same CPU could cause a deadlock if they both try to
access this xarray:

drivers/pci/p2pdma.c:calc_map_type_and_dist() {
    ...
done:
	rcu_read_lock();
	p2pdma =3D rcu_dereference(provider->p2pdma);
	if (p2pdma)
		xa_store(&p2pdma->map_types, map_types_idx(client),
			 xa_mk_value(map_type), GFP_ATOMIC);
	rcu_read_unlock();
	return map_type;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-fix-p2p-ac=
s-v4-0-v11-0-72cf8c96e617@nvidia.com?part=3D1
