Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10EBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7C810E248;
	Tue,  7 Jul 2026 01:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aqV/Etli";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C809610E248
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 01:12:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD1506004E;
 Tue,  7 Jul 2026 01:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB71F000E9;
 Tue,  7 Jul 2026 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783386760;
 bh=Bpr94blKxteo8hypXiKiHMmG4NpkfXoLHUxXUd6dXlE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aqV/EtlifybphsGTzPN4XSgCiBcycrTeTLlWNLVUrKOrd09ebjJiXqQ0Cmjv2hygY
 6g4hqp4xh5cumNqeNUmmRJa0ZWUkraM+OAK1+9cZSEjECKmtIDOXt+7/aq2eUHmiND
 6QZJnGmOlaJ82h/7L8lLDDrT+J6h86c00nbiHrhwdQFlD9joO+tW7amMONpy/FUiBY
 3p/wOqNIS9XBnud3q9ZptwP7wDH4S4YIt01VfDJdWuNXL50hchTL7d17v8JemjVgEa
 imy618oWv77Eqtu/Ke81Pcg2XDYrPhz4go4uBzfqxcNJYXwDAFusW0siencRO1Qo7u
 m+3dp0r6bKQ8w==
Message-ID: <7368b556-b874-4d90-87de-44d7f0d3dc31@kernel.org>
Date: Tue, 7 Jul 2026 10:12:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] ata: don't store pci_device_id
To: Gary Guo <gary@garyguo.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@redhat.com>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, industrypack-devel@lists.sourceforge.net,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
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

On 7/6/26 23:11, Gary Guo wrote:
> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Looks good, but please change the commit title to:

ata: ata_generic: don't store pci_device_id

With that,

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
