Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD85C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2B910F542;
	Fri, 17 Jul 2026 12:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SWY4iwE3";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F2F9810F542
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:36:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BA161476;
 Fri, 17 Jul 2026 05:36:30 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DB2D3F7B4;
 Fri, 17 Jul 2026 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784291794; bh=cK5CyITB0AQ4m/M1LPMHQsYqVGfmWCfGzBB/iAt08Fo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SWY4iwE32bOwuSxhu1Kr1LYKKKXPrBMFSFsib240wu2IB7V33T92lfoCNtCvAXPRu
 tDR54r1ifr8tF0pN1OPK5iKnW7W6gAVayDho5Y4frWx7ELROJHnFijd5hlJvaDQoFe
 ZLPPTRk6SWeGqDpwVM6hbKtrmRZgFqBqIDuSl3bM=
Message-ID: <c000fe3e-2c10-4b2e-9f3c-852e38be5eb8@arm.com>
Date: Fri, 17 Jul 2026 13:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/8] misc/arm-cla: Probe firmware-described devices
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-4-ryan.roberts@arm.com>
 <7927c483-57ed-4253-a7df-40104ff2b192@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7927c483-57ed-4253-a7df-40104ff2b192@app.fastmail.com>
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

On 17/07/2026 13:25, Arnd Bergmann wrote:
> On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
>> +
>> +static const struct of_device_id cla_of_match[] = {
>> +	{.compatible = "arm,cla",},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, cla_of_match);
> 
> This is missing a device tree binding, and probably needs to versioned
> in some form.

Given the aims of the RFC, I didn't think this would be a blocker for now - of
course it's on the list for if/when we get further along the road.

Thanks,
Ryan


> 
>       Arnd

