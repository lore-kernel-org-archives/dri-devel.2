Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AA0CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C6D10E0A7;
	Fri, 19 Jun 2026 15:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lUkthRMa";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6849F10E0A4
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781882009;
 bh=1QsRTYJv/V6JQEsJMUbrHpG1B6cDUyuPuUiING2oFTI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lUkthRMaMEeqVhJ8JXxzh47Cl37fr8eNRTUlNw836+uLH/GZEf0zWkG+E4S01Jnfq
 YecdbiYTR+EzcalQYxIewQt1Rsv18MbUkpypGzNciItddrdKiD5Vmf6Mngrf7XIuwb
 RWJnYDiDJjQPb5igfdeb9udbwasF6bzYEpndpPzgRdMgEM/lnY/XUiM/CmickBaHvc
 ZkTrzjMlrxD635nTa02lPJiqeEF7r1F6Q/QKG29qlWIghwNZncR6BAY3zqxshSRce+
 Fx3CFwcDsgjHmzVL1h8IEkn+A0/L8espl1qdYSUar5Ma/bBcUv0O1ddWlMpELXpS95
 EYWQsk27ya2sQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ghh1X2w4Tz4w1W;
 Sat, 20 Jun 2026 01:13:20 +1000 (AEST)
Message-ID: <55ea7422-08d8-4c92-aa59-8ff6f9e9d781@ozlabs.org>
Date: Fri, 19 Jun 2026 16:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org> <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ajGbRE3WWJxNxcrg@google.com>
 <BYAPR11MB3687AE280241C9E00B46FCF98CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
 <24f34e59-7c3b-4b56-83bf-cb07e3f369a6@ozlabs.org>
 <20260619133116.GB278945@nvidia.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260619133116.GB278945@nvidia.com>
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

Hi Jason,

On 19/06/2026 14:31, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 05:02:58PM +0100, Matt Evans wrote:
> 
>> My understanding is that the sequences above wake a device that happens
>> to have previously been put into D3, and AFAICT it could only have got
>> there because of a previous vfio_pci_set_power_state().  Seems its only
>> caller is from the emulation of PCI_PM_CTRL using
>> vfio_lock_and_set_power_state(), and this zaps/revokes BAR access before
>> a transition to D3.  Similarly, an attempt to access a BAR via an
>> ioctl/through vfio_pci_core_do_io_rw() fails the D3 check in
>> __vfio_pci_memory_enabled(), and besides will try to take the memory_lock.
> 
> I thought the general design was the bars were made inaccessible
> before going to a low power state, and remain inaccessible while it is
> in low power?
> 
> So the order of D0 doesn't matter. If it is not in D0 then there is no
> mappings and zap/revoke is a NOP.
> 
> If is it in D0 then it doesn't matter because D0 is a nop.
Yes, that's what I'm getting at. :)  If it's in D3 then BARs are
inaccessible, so as long as we go into D0 before the DMABUF move, the
order of the zap relative to the "go to D0" doesn't matter.


M


