Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789A8C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA16B10F546;
	Fri, 17 Jul 2026 12:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hMWp8GwJ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4678910F542
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:33:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A85021476;
 Fri, 17 Jul 2026 05:33:07 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467C23F7B4;
 Fri, 17 Jul 2026 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784291591; bh=RDpVVg8kFR8tLzOuRdIhEL58jET3NKRROOt/Z0gxSao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hMWp8GwJzRF5UZIO7llWHBXTN/HLu31bPfKJMWbDqFPVX/ABCDP7Uv8E3nfr/pgz6
 mz93o+2LPGP9NgzF7GOkgmnMKpHPVuOlv83VrSes5m+va/CFG+etb0rtKfkR6zbW0B
 a1EOO8mqxjWKsUm2Nf3s27A0ZKvy/CA6wT5MW1T8=
Message-ID: <a39b2bef-8fb5-444d-8ab8-3882224a3311@arm.com>
Date: Fri, 17 Jul 2026 13:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 oupton@kernel.org, hch@infradead.org, jgg@nvidia.com
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <aloS_T3LQvpHeZUV@willie-the-truck> <87ech1rf6n.wl-maz@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87ech1rf6n.wl-maz@kernel.org>
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

On 17/07/2026 13:09, Marc Zyngier wrote:
> Thanks Will for roping me in.

Sorry - I intentionally didn't include you because last time we spoke you said
you were only really interested in discussions on the virt side of things and I
didn't want to spam your inbox. Perhaps the wrong decision...

> 
> On Fri, 17 Jul 2026 12:33:17 +0100,
> Will Deacon <will@kernel.org> wrote:
>>
>>> I'm deliberately constraining the scope to bare-metal support for now.
>>> Virtualization is something we are considering (and have prototyped), but plan
>>> to post a separate RFC for that as follow-up, once we have agreement on
>>> direction for the bare-metal driver.
>>
>> I'd actually like to see what the virtualisation part looks like first
>> because doing it as a bolt-on later feels like the wrong approach. The
>> structure you have at the moment is remarkably clean, given the
>> architectural/CPU interactions (this thing even apparently builds as a
>> module, nice!), but I'm unsure how far you can push the separation once
>> you need to start hacking at KVM. Maybe the MMU notifiers are enough,
>> but I can't tell.
> 
> +1.
> 
> Virtualisation cannot be a "bolt on the side" exercise. It is an
> integral part of the arm64 tree, particularly for memory management
> and scheduling, all of which have a direct impact on KVM.
> 
> I don't think we can really evaluate anything here without looking at
> the full picture.

OK understood - as per reply to Will, we'll prioritise doing a version with virt
support.

Thanks,
Ryan


> 
> Thanks,
> 
> 	M.
> 

