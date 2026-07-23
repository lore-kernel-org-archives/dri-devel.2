Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27B6C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287BA10E601;
	Thu, 23 Jul 2026 21:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mi7eEBmg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CB910E601
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 21:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDF5E41FE9;
 Thu, 23 Jul 2026 21:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E731F000E9;
 Thu, 23 Jul 2026 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784841717;
 bh=8KC2DSNpAt9AdYOuMQy3pAgGL6W1aDXGthYyqLSpM5k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Mi7eEBmgMeVYqqiVjdVsuP88GzcC3Y4dDWRr3EG1EW+Xm8uxB88jlDnBFLgWiloYA
 EzZWLtaF7Oqp+/Dr6sWvc0zk0cNUyC74SbBUeUGcM/tofgQ3zhQRaV7M9Qnz/6nA2Z
 nQont9J0yBdXBJ5PTLJqqIcnfWnUwhPSQAlQXSt43KpOhpDPAuUZBSETCyfmu4OwwI
 0uUtoFYVLbX6rRwsPcnRagkVhTUNR6HZuRHIgFGSZ7iUBi1uQ1Cn5GkHLr3nNyGSRJ
 vJhBvE03GRfto1K9b8QX9sdSRlQt9a93vj7sm8kwGcLt4oCU3spYGRXpjZtZ1eDdPz
 jWpE/BGAm3QqQ==
Message-ID: <2220ce37-2fbf-4be8-9af0-b3673be90f04@kernel.org>
Date: Thu, 23 Jul 2026 23:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] pci: fix UAF and TOCTOU related to dynamic ID
To: Gary Guo <gary@garyguo.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@redhat.com>, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 industrypack-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Sashiko <sashiko-bot@kernel.org>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/6/26 4:11 PM, Gary Guo wrote:
> Gary Guo (9):
>       ata: don't store pci_device_id
>       nsp32: don't store pci_device_id
>       ipack: tpci200: don't store pci_device_id
>       mlxsw: don't store pci_device_id
>       agp/via: don't rely on address of pci_device_id
>       agp/amd-k7: don't rely on address of pci_device_id
>       pci: make pci_match_one_device match on ID instead of device
>       pci: fix dyn_id add TOCTOU
>       pci: fix UAF when probe runs concurrent to dyn ID removal
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
