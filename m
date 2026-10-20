Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD219606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R0X9Nmpp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C41C10E75B;
	Tue, 20 Oct 2026 10:42:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C0F1F10E75B
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:42:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA711596;
 Tue, 20 Oct 2026 03:41:59 -0700 (PDT)
Received: from [10.0.137.15] (XHFQ2J9959-5.cambridge.arm.com [10.0.137.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2958D3F7D8;
 Tue, 20 Oct 2026 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792492922; bh=OaSet948UMPKW/bEq7Gy7KB2ZNmZwB2hGOuIicxjXI8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=R0X9NmppaPctZe25oyvdRyxTPp7TrT33QgSmgyWht1QNwxUfP4JqEzNxdmziK123R
 XueQS3xiz/bfL8vBZ1yVww8k6Q6T25wedDXhj06BS3d1+I/XnwCjNfnm9GNFLMWDfn
 vC7cxViW1dKg0DcKnWi5Bhdwq1g6zBBbBiqLMygQ=
Message-ID: <375868af-d0bd-4278-83e6-f8429df130e9@arm.com>
Date: Tue, 20 Oct 2026 11:41:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/15] misc/arm-cla: Add vfio-mdev user interface
To: Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-16-ryan.roberts@arm.com>
 <20261015164102.GC13920@nvidia.com>
 <CABCqBse_aZL-EH0us2uA5X10q6E4WP02MoHTYf+M9ezRZr26WQ@mail.gmail.com>
 <20261016144202.GG13920@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016144202.GG13920@nvidia.com>
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

On 16/10/2026 15:42, Jason Gunthorpe wrote:
> On Fri, Oct 16, 2026 at 03:22:00PM +0100, Jean-Philippe Brucker wrote:
>> On Thu, 15 Oct 2026 at 17:41, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>> I think I said this last time, please don't use vfio mdev for
>>> anything. There is nothing mediated about this.
>>
>> We don't multiplex a device between guests, but the host driver must
>> control part of the device registers while the remainder is assigned to
>> a guest. The host configures accelerator access, stage-2 translation,
>> handles CPUHP and context save/restore. So we can't bind the device to
>> vfio-platform.
> 
> That's fine, you can make a proper vfio-cla driver.

Hi Jason,

Thanks for taking a look at this! I've been chewing on this comment and trying
to educate myself deeper on the subject. I have a proposal...

Currently we create a struct device per CLA device instance. But multiple CLA
device instances cooperate within a domain and the domain is the "unit of
isolation"; we can't have some CLAs from a domain assigned to a VM, while others
from the same domain are used by the host. Therefore it didn't feel like the
correct model to unbind one of these devices from the native driver and rebind
it to a cla-vfio driver. mdev seemed to solve this problem nicely for us.

But looking into it in more detail, I guess something like this might be a bit
more standard:

 - Split the existing CLA driver into three components:
    - cla-core: Hardware discovery, domain configuration, struct device
      registration and CPU hotplug
    - cla-native driver: Provides the user space accelerator interfaces
    - cla-vfio driver: Enables domains to be assigned to virtual machines
 - Each domain has a struct device (created by the core)
    - An individual CLA is not represented by a struct device
 - Either cla-native or cla-vfio can then bind to a domain device
    - cla-native exposes a char device per domain, per accelerator class
    - cla-vfio

For VFIO, I guess we could use one VFIO region per CLA, which would allow the
VMM to construct a device tree. But it would need to additionally determine
which CPU each CLA is bound to; perhaps that's a sysfs interface that cla-core
could expose?

Does this feel like it's going in the right direction?

Thanks,
Ryan

> 
> Jason

