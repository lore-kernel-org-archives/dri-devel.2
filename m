Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F8BC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D6B10F1FC;
	Thu, 23 Jul 2026 21:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FkODYz35";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DA210F1FC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 21:10:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0EA640AA3;
 Thu, 23 Jul 2026 21:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0881F000E9;
 Thu, 23 Jul 2026 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784841049;
 bh=5f9ZtsjVxvvVMvTLjI49xDxBHtnl7xTVDp8nqfIG+AU=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=FkODYz35kP7ItLHXLj7+ej0aCz7/XB1I0nj2NlHbujPL2ltI3Mnx1VSjzH8o8y4rS
 E2ehk2LOEeW2IFH4HycAobCulyM6g9HO7sKrz77K80RYWQD39b/mZGOfsrpH1gw5hF
 by5G8VfCJllg0j3fdBRlmTF1q0AuFpnCqbPV7sILcHfy9sF0P/N25znpChnLHJkriy
 kZsOnBfAx15dpcU3r53MCTMobDleW9Yp//gn9AQdVMJqKrdMti1wprCiOnHuiPpcT4
 CbhpQe4ZfWYkjoRkAK/vlKML8N+cElkZ8nmm0sO8gqe3p2dVI/mV/mc7+WmvBXkM9U
 LEYm8WUGknPdQ==
Date: Thu, 23 Jul 2026 16:10:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@redhat.com>, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 industrypack-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 9/9] pci: fix UAF when probe runs concurrent to dyn ID
 removal
Message-ID: <20260723211048.GA857046@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK67INM1MX6H.1FA6WNE8RZ9R7@garyguo.net>
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

On Thu, Jul 23, 2026 at 08:44:48PM +0100, Gary Guo wrote:
> On Thu Jul 23, 2026 at 8:29 PM BST, Bjorn Helgaas wrote:
> > On Thu, Jul 23, 2026 at 07:57:58PM +0100, Gary Guo wrote:
> >> On Tue Jul 21, 2026 at 11:35 PM BST, Bjorn Helgaas wrote:
> >> > On Mon, Jul 06, 2026 at 03:11:21PM +0100, Gary Guo wrote:
> >> >> Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
> >> >> as remove_id_store can free the node. Thus, make a copy in
> >> >> pci_match_device. Also, clarify that the id parameter is only valid during
> >> >> probe.
> >> >> 
> >> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> >> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/
> >> >> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> >> >> Signed-off-by: Gary Guo <gary@garyguo.net>
> >> >> ---
> >> >>  drivers/pci/pci-driver.c | 28 +++++++++++++++-------------
> >> >>  include/linux/pci.h      |  1 +
> >> >>  2 files changed, 16 insertions(+), 13 deletions(-)
> >> >> 
> >> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> >> index 64b308b6e61c..92c17c116de6 100644
> >> >> --- a/include/linux/pci.h
> >> >> +++ b/include/linux/pci.h
> >> >> @@ -979,6 +979,7 @@ struct module;
> >> >>   *		function returns zero when the driver chooses to
> >> >>   *		take "ownership" of the device or an error code
> >> >>   *		(negative number) otherwise.
> >> >> + *		The pci_device_id parameter is only valid during probe.
> >> >
> >> > The probe function takes a pointer to a struct pci_device_id,
> >> > so I think the requirement is that the struct pci_device_id
> >> > only *needs* to be valid during .probe(), right, i.e., the PCI
> >> > core probe path makes its own copy of the ID and doesn't retain
> >> > the pointer after .probe() returns, right?
> >> >
> >> > I assume the caller determines the struct pci_device_id
> >> > lifetime, and it could be forever.
> >> >
> >> > Could say something like:
> >> >
> >> >   The pci_device_id parameter only needs to be valid during
> >> >   probe.
> >> 
> >> As a contract on function parameter, the caller needs to
> >> guarantee that it lives at least as long as documented (i.e.
> >> during the whole probe) and the callee cannot assume that it will
> >> be valid beyond what's guaranteed.
> >> 
> >> How about:
> >> 
> >>     The pci_device_id parameter is only guaranteed to be valid
> >>     during probe.
> >
> > That's ok with me.  My only niggle is that this documentation is
> > that the *consumer* end, and of course the consumer, i.e., the PCI
> > core probe path, can't guarantee anything about the parameters it
> > receives.  But I guess your point is that the *caller* must
> > guarantee that the parameter remains valid during probe.
> 
> I'm not quite getting it, the PCI core probe path is pci-driver.c
> which is the caller? Do you mean that the PCI *driver* probe path
> cannot guarantee anything about the parameter it receives?
> 
> > The only thing the consumer can guarantee is that it doesn't
> > depend on the pci_device_id parameter after the probe returns.
> 
> How about:
> 
>     The pci_device_id parameter may not be valid after the probe
>     returns and must not be used afterwards.

You're right, sorry, I had this all completely backwards.  I was
thinking the pci_device_id came from a PCI endpoint driver, but of
course that's not right.  The PCI core *supplies* it to the driver's
.probe() function, and that .probe() shouldn't save the pointer.

I think either your original text or your last proposal is fine.

Sorry for confusing all this!
