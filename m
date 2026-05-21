Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BEBCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255E510F329;
	Thu, 21 May 2026 14:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="meqkAUtt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1AA10F329;
 Thu, 21 May 2026 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779372041; x=1810908041;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=P2vvrMS0cA0nf8csD85gV4H/e4rsZnFQUK3vI4r1K10=;
 b=meqkAUtt0WEXZ9RzLOLb3/gHkGxsuAPYQ/UpaP4EKvMjxptcLhaEmXBL
 H+mJCDFFyyDGzFCLYJiqTOXTYpubEHU5+kEh8Uaw6I9EBd6sVnqarRtrs
 z1zezlr1hxGKjF66oJjICqVQxd7tFtZkWkqOpkH7AbbIchY6TY6QrtPGw
 i+/cNOyAjEDLCQutg352LPZM2ohAGqqj2BoTpwBXigT2dZNM34yBE+qk8
 jvR+5/024nf0mWU17obC+RlH2wQm+/X9jFBjY4X6VnRzTK1zamCy/+XUj
 5wk75B2K/agCpcZCnd5IbacEqEldbm4p4n4UvPzNzQPxfGXGg6bqxIlaw A==;
X-CSE-ConnectionGUID: T6GCb/l3SuKstObSGgT9eA==
X-CSE-MsgGUID: rhuFUTw2SLqg99xFJ0Xl+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79437169"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="79437169"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 07:00:40 -0700
X-CSE-ConnectionGUID: LWLwqBgwSTWMNBmcK6XsTw==
X-CSE-MsgGUID: YwRXeLaPQYOODzDoC1fScQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="239682785"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.42])
 ([10.245.244.42])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 07:00:33 -0700
Message-ID: <9aa73abb-0eb1-4320-a179-40f7d2458dd9@linux.intel.com>
Date: Thu, 21 May 2026 17:00:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
To: Thierry Reding <thierry.reding@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-6-a6de5da7216b@nvidia.com> <ag67FStKnQcvNOrP@orome>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ag67FStKnQcvNOrP@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/21/26 10:59, Thierry Reding wrote:
> On Wed, May 06, 2026 at 03:41:57PM +0200, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Currently the kernel relies on a global variable to reference the PMC
>> context. Use an explicit lookup for the PMC and pass that to the public
>> PMC APIs.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> Mathias, Greg,
> 
> can you ack this so I can pick it up into the Tegra tree for simple
> dependency resolution?

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

