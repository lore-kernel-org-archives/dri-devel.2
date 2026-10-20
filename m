Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C14606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=k1oeeqEy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152D210F509;
	Tue, 20 Oct 2026 11:51:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 798FB10F51C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:51:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6E21596;
 Tue, 20 Oct 2026 04:51:27 -0700 (PDT)
Received: from [10.0.137.15] (XHFQ2J9959-5.cambridge.arm.com [10.0.137.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F9A3F7B4;
 Tue, 20 Oct 2026 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792497090; bh=UFdHRBoQNmzK3J1KulBJN2N/STdJqV3Qy+2zaWTevg8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k1oeeqEyXO6BAXWERGM3PoBR163hq6VQuZgUfNyIwbgfcGU+dMXRc6ZiMZ8nIPUHE
 hepPI5uQuoBLhfyK2T0O/Del6FpxrnjimRZS57vdorb4f0y7hQi1/BYwO9CNcBOF4p
 xtMeabKTRqXJsmvVN6HMxF9dAnQOgKizG9dfxlgQ=
Message-ID: <95e0f9bd-0203-4c7a-9d09-622593bb3d4c@arm.com>
Date: Tue, 20 Oct 2026 12:51:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/15] vfio: Support VFIO devices that access the
 CPU MMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-13-ryan.roberts@arm.com>
 <20261015164421.GD13920@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261015164421.GD13920@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jason,


On 15/10/2026 17:44, Jason Gunthorpe wrote:
> On Thu, Oct 15, 2026 at 03:25:46PM +0100, Ryan Roberts wrote:
>> From: Jean-Philippe Brucker <jpb@kernel.org>
>>
>> Support devices that are attached to a CPU and perform DMA through a
>> MMU. They do not have an IOMMU and do not use a VFIO container.
>> The VMM needs device-specific knowledge in order to create a virtual
>> device (device tree, ACPI tables), so it also knows not to allocate a
>> container.
> 
> I'm not so excited to see new things built on top of the group
> interface.
> 
> Maybe in this case you just don't have to do a bind operation on the
> cdev to an iommufd? That feels kind of natural if you don't use a
> iommufd

Yes, that makes sense. I don't know enough to know what actually needs to change
to make this work, but will look in this direction.

> 
> However.. you still have to affirm which single mm is the mm that the
> device is going to be doing DMA against. The process the opens the fd
> should not be forced to be the mm that it gets linked to.

What is the mm representing here? Ultimately we want to install the KVM
instance's stage2 pgtables and (pinned) VMID. We currently get that via the
bound KVM instance (which looks like it still works using the cdev interface?)

The guest will then install the stage1 pgtables and (pinned) ASID associated
with the relevant (guest) mm_struct.

Do we _need_ an mm association in the host?

Thanks,
Ryan

> 
> From that perspective maybe you should create an iommufd and a special
> "SVA" IOAS that it can attach to. This is more complicated but it
> makes the mm linkage and blocking beahvior explicit and controlled by
> userspace.
> 
> Jason

