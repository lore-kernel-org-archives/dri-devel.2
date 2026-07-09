Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DF9C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530CD10E088;
	Thu,  9 Jul 2026 16:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="Nh8jbmKX";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F63D10E086
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=cy1QN1NzhHYQz51ULp2Gqf50+XQ1ns+77hhEPNga8rY=; b=Nh8jbmKX6frPNXdTwrWeSUk2K/
 wwAvA+IcRPsu33aWOOpLuL0vijI5DgOV90JCS0vpLno0kjWUzlQOKyS4YwO6k8R8nO7RDwrSMV+dL
 eUNoj0A1PKV5vNYV3esTbqfTeiVKHGkk7+XHxoh+bcruLUDYUxzX5Wd7yRHZ1xiCoknTcW04nSocm
 TcKxahaxu8DLA8ypbE2ArShDLuHPM0Wr6ec/033XdX1AaSEAa6bEKV6ZfKT1F5zkrnnd4htX8lYM5
 87Ax4T2lzLv1AEZrAaLw51M1m/4UwdZNo1vEMAQmEbhUh++xiDpV7Q6oEbp3ERRx1sczH4nnFpYrt
 QnN4V9Dw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74]
 helo=[10.0.33.8]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1whraJ-00000002TP7-04hO;
 Thu, 09 Jul 2026 10:26:47 -0600
Message-ID: <9b664c05-8e85-4ccb-afc4-91ba807438b7@deltatee.com>
Date: Thu, 9 Jul 2026 10:25:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
 <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
 <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
 <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org,
 jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com,
 kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de,
 dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org,
 ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2026-07-09 10:17 a.m., Matt Evans wrote:
> I'm intending to repost _retaining_ the 64BIT dependency (i.e. revert
> its removal) for simplicity's sake.  Then we can follow up separatey
> (outside this series) with a cleanup patch to remove 64BIT, explain,
> examine other dependencies etc. as you suggest.  Works for you?

Yup, that's fine by me. Thanks!

Logan
