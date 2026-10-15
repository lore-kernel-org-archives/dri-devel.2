Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136ACCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766A610EC39;
	Thu, 15 Oct 2026 16:32:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9CF931123E0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:32:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A328614BF;
 Thu, 15 Oct 2026 09:32:19 -0700 (PDT)
Received: from [10.0.138.89] (XHFQ2J9959-5.cambridge.arm.com [10.0.138.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E966C3F871;
 Thu, 15 Oct 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792081942; bh=K53bHe/qRL8PgX+fC0aZ/IKukdzfGE2CeH1J1pXxbIw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QvHiuvww2XMiC1VH5lrEn7YT52tcUfUfqnhqZ6AL7/+1oS59HDeC1lXKxNrpFi1pC
 t0SbzJpTfupyKQqZc3bVVGYXHq188MRT6NrH01zSEEbyjpLbZx7PQxzYaj0Ht2nEy2
 xPD7PUul+C++YYvpS1ogXhTXImp3VMZKjPrCVxsE=
Message-ID: <e8d97f6c-8e22-4c85-b15d-6edade16d789@arm.com>
Date: Thu, 15 Oct 2026 17:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/15] misc/arm-cla: Add launch operation helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-3-ryan.roberts@arm.com>
 <2026101542-briskness-most-a8ca@gregkh>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <2026101542-briskness-most-a8ca@gregkh>
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

On 15/10/2026 17:17, Greg Kroah-Hartman wrote:
> On Thu, Oct 15, 2026 at 03:25:36PM +0100, Ryan Roberts wrote:
>> From: Jean-Philippe Brucker <jpb@kernel.org>
>>
>> CLA commands are issued by writing optional payload registers,
>> programming the LAUNCH register and polling LRESP until the hardware
>> accepts or rejects the operation.
>>
>> Add a common launch helper that performs this sequence on the CLA's
>> local CPU, waits for LRESP completion and translates launch response
>> codes into Linux errors.
>>
>> Build accelerator reset and register read and write support on top of
>> it. The register read and write helpers split larger accesses into
>> multiple launch operations when an access crosses an eight-register
>> window.
>>
>> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
> 
> You forgot to sign off on patches from others :(

Ahh sh*t, sorry about that. Hopefully given this is "just" an RFC that's not a
big deal? Else, let me know and I'll resend.
