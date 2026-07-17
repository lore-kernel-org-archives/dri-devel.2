Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6403C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BE010F567;
	Fri, 17 Jul 2026 13:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="O8IdS8G3";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CAA7910F567
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D111477;
 Fri, 17 Jul 2026 06:42:37 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4AD3F7D8;
 Fri, 17 Jul 2026 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784295762; bh=lD/C55RPTNkAoWBALB4tsbeKSWOx57U5ia61Pk1caS4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O8IdS8G3CnKuMNburYce3PCdi61FDsSRFopmQca85h5hKz29/iSlxtdvby8rVIIAj
 LtCuH1paFHjRXytQB5McfRZ0LM8i/XXM0l90zvuDgyK1HUw8k4i1yZJMQslVOOtuQG
 sg/V2vf8ELp7Z+iC2v+3/ef855u9qt/W5t28YTtk=
Message-ID: <753239d6-af3b-48f1-b4bc-229ef9b6ed49@arm.com>
Date: Fri, 17 Jul 2026 14:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, maz@kernel.org,
 oupton@kernel.org, hch@infradead.org
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <aloS_T3LQvpHeZUV@willie-the-truck> <20260717133200.GB699082@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260717133200.GB699082@nvidia.com>
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

On 17/07/2026 14:32, Jason Gunthorpe wrote:
> On Fri, Jul 17, 2026 at 12:33:17PM +0100, Will Deacon wrote:
> 
>> first. So, at the moment, this just looks like a burden to me, especially
>> as it appears to create a brand new, device-specific UAPI for what is
>> ostensibly a form of SVA - something which the community is actively
>> working on already.
> 
> Yeah, I think it was a mistake to hardwire the invalidation to the
> CPU. It would fit much better into Linux if the invalidation was
> separate and independently controllable with an option to follow the
> CPU.

Well I'm certainly not going to disagree, but the HW is somewhat fixed at this
point :-|

> 
> Then you could use a normal S2 page table through iommufd and not mess
> with kvm. (though the VMID sharing with KVM for a BTM-like scheme was
> never solved upstream)
> 
> I also wouldn't expect you to use vfio-mdev, if the devices are
> discovered and known at boot then it should be a normal vfio driver.

OK good feedback - I'm not going to claim to be a VFIO expert (especially not in
front of an actual VFIO expert) - We'll look closer at this and come back if we
have questions (although unlikely over the summer holiday).

Thanks,
Ryan


> 
> Jason

