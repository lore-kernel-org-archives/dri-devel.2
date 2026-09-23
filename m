Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89BBC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE8B10E94E;
	Wed, 23 Sep 2026 17:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="j5E2EGCt";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7950410E09B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1790183171;
 bh=9sC2s9c4kVeESBcaRi7B3uwGv/f+ZIkXcJcmd7k9ey8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j5E2EGCtmyxhWxVJokXSHuw5C+yOnbLNZ4baCc6TxSShKtCuvjiVhGivVSg4y9UBb
 wnR9pqB/7HRav14UHp41aEMlivzBf+DFHzPwkIodntCWIG+OKKwGVY12JZrjXXkzd7
 wDsg5AR5j92BLqYgQgAzqFba9bej7kNF/YGJmH5/r8KTgFf+hQwllvGWnlyhEfuWDJ
 WZpFpA1B6pu5Dt6m9RxXdFvGM4SgoChPa+o0Nb2Ts97Caz7JL2UOpUbXYO178MNDFv
 2MWuWwmCRW69gSB4p2RSn1ZxW7RVEqY4o2lmhGPTckm202dPtO9K6hE5CRQMm8HckY
 QciTOSpaF0/Bg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hqjzG4ycBz4wCx;
 Thu, 24 Sep 2026 03:06:02 +1000 (AEST)
Message-ID: <39fdd41d-fd6e-4f88-be35-28ce93482605@ozlabs.org>
Date: Wed, 23 Sep 2026 18:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
References: <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com> <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
 <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
 <20260923165240.GS563127@unreal>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260923165240.GS563127@unreal>
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

Hi Leon,

On 23/09/2026 17:52, Leon Romanovsky wrote:
> On Wed, Sep 23, 2026 at 04:40:03PM +0100, Matt Evans wrote:
>>
>> So the worry was that the VFIO DMABUF's temp/perm state could be
>> misconstrued as an implication/guarantee about the future availability
>> of that DMABUF to importers, OK.  And we want the existing move(false)
>> behaviour still, for dynamic importers that treat it as a move.
> 
> This is not a bug; the behavior is intentional.

I wasn't meaning to imply that! :)

> During review of the initial> versions of the revoke mechanism, it was
pointed out that
> `move_notify == invalidate_mappings == revoke`. The initial versions
> introduced a separate function call for revocation, which we abandon in
> favour of move semantics.

That makes sense, and it's good to know that background.

Thank you,


Matt

