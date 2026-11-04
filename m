Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B0606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MikdqmwL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7A410FCD2;
	Wed,  4 Nov 2026 15:09:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A0A10FD02
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:09:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 107DB41826;
 Wed,  4 Nov 2026 15:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDA1F00A02;
 Wed,  4 Nov 2026 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793804970;
 bh=BFGjOyP5UIQiJBxM/VFU684BMQoEd0KQaBTYoIf/jec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MikdqmwL0zghAEx2caid1swCm7g3GXwsdv3H7ISWA6PMwbbp18mgRC71GTVXDaZdp
 Exq1UpQ2I5D35E9K9/i5jEsZiRyjQIAufLiJqfUcJfGZelAI8H2IwcwK6rcav4yw+s
 6SJzuQcTygDY66L5tYG6ssqTjXgPz1rXTO+TEM94=
Date: Wed, 4 Nov 2026 16:09:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: Re: [BUMP] [RFC PATCH v2 00/15] Arm Core Local Accelerator Driver
Message-ID: <2026110454-conjure-unfasten-1fe3@gregkh>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <80b69632-dbe1-405b-910a-c17a943d8fc2@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b69632-dbe1-405b-910a-c17a943d8fc2@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 02:41:59PM +0000, Ryan Roberts wrote:
> Hi All,
> 
> Just a polite bump; now that -rc1 is out, if anyone can spare any time to cast
> an eye and offer opinions, I'd be grateful. At this point, I'm most interested
> in feedback on the arm64 integration aspect; If you see blockers I'd like to
> discuss early.

We are _drowning_ in real patches right now, RFC ones go to the bottom
of the pile.  Please work to make this good enough that you feel it is
no longer a RFC and submit it that way.

thanks,

greg k-h
