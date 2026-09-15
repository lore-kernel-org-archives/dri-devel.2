Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E217C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1DE10E2A1;
	Tue, 15 Sep 2026 14:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HW2jWuBP";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD7610E2A1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1789482627;
 bh=5x9PVSs1pegITND9ej196jOTL1wg1+lrDdeCERTcAHc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HW2jWuBPYllN+POQQWsl9SXygg0v21ChZrs/LiJUyRXjiHTCByo+VsqV60ZoXKldG
 41ptofyOkN6OVSCyTCHR1WdrTkrEsJKjSkPQlI5Wa8FHPCkNND6LisEhHlWUAj+7sG
 hkMOgFOh1R0i3F96CpuT5OBkKjiv4ltHfiB3h1SVGuIPXLzKURaSl6QI0Gp8mRSgC+
 3H1F//DVOQSEQpXu4fmWDq+E8cGaV+JG1rdwfJLGt7FW96YUuatkZBB41ZOlAL5bBe
 i6BMmYH83fCJ51UmvwtyS/Z5dmcwwO/zQXESU2QH7hNId0BzSxx71viz2QtOnjk9sj
 rwR69zCQL/Qxw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hkkvH33lkz4wBB;
 Wed, 16 Sep 2026 00:30:19 +1000 (AEST)
Message-ID: <9ebcebb9-94a5-40b4-8764-5d70ea465f9c@ozlabs.org>
Date: Tue, 15 Sep 2026 15:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org> <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com> <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915123517.GS3968357@nvidia.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260915123517.GS3968357@nvidia.com>
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

On 15/09/2026 13:35, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>> ranges previously delegated to a subordinate client process: by
>> revoking, the driver process can ensure that the loaned resources are
>> made inaccessible when the client is deemed "done".  The original
>> DMABUF is defunct, and BAR resources can then be safely re-exported
>> for use by new clients."
> 
> This makes the point clear, you want a way to permanently revoke a
> specific dmabuf fd and render it forever unable to access any
> underlying memory.
> 
> You want to do this so the vendor can fence the vendee without
> requiring its co-operation.

Exactly!  (I'll reword this commit message still, re other requests in
this thread, but you got the concept.)

> "temporary revoke" ie what VFIO already does around reset is a
> different thing.

Yes, right.  From the DMABUF importer (and now mmap) perspective the
mechanism is unchanged.  priv->revoked was always "temporary"/transient
(OK, splitting hairs, but at VFIO shutdown an exported DMABUF becomes
permanently inaccessible).

Here the only change is adding another cause of becoming inaccessible
(direct request from userspace) and the length of time (it can never be
re-attached, for the reasons you mentioned).

Cheers,


Matt
