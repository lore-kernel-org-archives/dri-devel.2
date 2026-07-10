Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10112C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC0910E1D7;
	Fri, 10 Jul 2026 13:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="o09a0LCe";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F39C10E1D7
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:45:27 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-c15dfd34e4cso81567166b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783691126; x=1784295926;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wG6HuNoWW7IygZyBT7H+i3l/PRkL2cEL2O38DxA5QNs=;
 b=o09a0LCeG3A1uRTA3HTxthxf9m77C2DHYtcyp+2JqONxPIqwtOnbuSvTnn41owZyR1
 ct+9g1Eb/JraiFSsWiMHjFWvrlUUByVwMesFSmCKR4n0LSztNveE75tzi7W/KbiCdqw+
 w3wn1za4IRxTKGoNO2zvbaIE2LupMEPwXB1ORKFyFXsZ20p2fZQxw8NqMzaM4d6Ccfz+
 Qibfw5uRzSNhjTQUMjuvG74VPE1VTRSC9fdXrgtTrX92bjf4Q/Bo2I3N5wc6/uTbRm8f
 ugFd+cZmshatzDQC8YvmZYDLpjV242eEtzoRVcnYfq5HCz2bNEaoNXq4QeN1PJMkgyBG
 7YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691126; x=1784295926;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wG6HuNoWW7IygZyBT7H+i3l/PRkL2cEL2O38DxA5QNs=;
 b=qxkf5n4w7GtU3yRrUHuMvC9OM1W3bXs6kZ5h80kHKsYH5VFIiIVJWZDeqJnc8MVHUk
 EbUve9EQfchI56I1q2OHGMuhDh2w9cS400uA1lHaKxTYgFA5Y/tldqHIz1iYZ8Q8LZJx
 +EK9VuS3yEueQ/FckUZ0l3SaNWDXlutwxUBlupYZfamrFDnRFxPIqbQWYYAKVKBCJs0c
 JRvO8I6O+7yRNq9EN52wG7ResuGIi+zbS5LLTf9MNO9lTk+DsNXwLV0T9FWosTNA9YoX
 UfPQKsaRENUL1Vb+/lZuKwfE4DqMxrCAnb0NG1p8umVjbFH7HFRcKarQXiDWNIH00ZPT
 6w9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/LYvmNVZhW3gM2OnEEXSe6zceLSRp+aSszDHlXE7dx8cbFAgXBGRTWy6ICQGttBH3bn53ScOUZ9E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi9g/RqjpttPpW06mjSoz0ydgBcYPOxm22s9EA0LVRuWGh2V4z
 pJ6XH6IRRVHEsQSNWiuMSGgRiMLUt+4nLk6o5vXnkGE3pnmdySBpc9p96oFEu2QYd9aUh2cGgot
 1+axQ1V8gyaBm7CFNTQ==
X-Received: from ejbri40.prod.google.com ([2002:a17:906:d7e8:b0:c15:f2a5:1700])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c2a:b0:c15:da6a:c27c with SMTP id
 a640c23a62f3a-c15da6ac90emr390710966b.25.1783691125330; 
 Fri, 10 Jul 2026 06:45:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:45:24 +0000
In-Reply-To: <20260709-fw-boot-b4-v6-3-ca391e1a4108@collabora.com>
Mime-Version: 1.0
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-3-ca391e1a4108@collabora.com>
Message-ID: <alD3dMEuYHduWlzp@google.com>
Subject: Re: [PATCH v6 3/7] drm/tyr: add Memory Management Unit (MMU) support
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 boris.brezillon@collabora.com, samitolvanen@google.com, acourbot@nvidia.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, work@onurozkan.dev, 
 beata.michalska@arm.com, steven.price@arm.com, lyude@redhat.com
Content-Type: text/plain; charset="utf-8"
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

On Thu, Jul 09, 2026 at 02:36:43PM -0700, Deborah Brouwer wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Add Memory Management Unit (MMU) support in Tyr. The MMU module wraps a
> SlotManager instance to allocate MMU address-space slots for use by
> virtual memory (VM) address spaces. The MMU's SlotManager uses an
> AddressSpaceManager to handle the hardware-specific callbacks. For
> example, the AddressSpaceManager activates and evicts VMs from slots by
> writing commands to the MMU registers.
> 
> Add an implementation block for the MMU's MEMATTR register to provide
> a method for translating the Memory Attribute Indirection Register (MAIR)
> format from the pagetable configuration to a format understood by the MMU.
> 
> Create an mmu instance during probe, it will be used by subsequent patches
> in this series.
> 
> Wrap the iomem stored in TyrDrmRegistrationData in an Arc. The iomem
> is stored in the mmu through its AddressSpaceManager. In anticipation
> of the iomem also being stored in the firmware object, set up shared
> ownership of the iomem now.
> 
> Update Kconfig to add the new MMU and IOMMU dependencies required
> by this MMU module.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

> +//! Memory Management Unit (MMU) module.
> +//!
> +//! The GPU MMU provides a limited number of memory address spaces for use by command streams.
> +//! The MMU translates virtual addresses to physical addresses and manages memory configuration
> +//! and access permissions.
> +//!
> +//! This MMU module is essentially a locked wrapper around a [`SlotManager`] instance.
> +//! The [`SlotManager`] manages the assignment of virtual address spaces to hardware address-space
> +//! (AS) slots. MMU commands such as updates and flushes are carried out by the
> +//! [`AddressSpaceManager`] which actually writes to the MMU registers.
> +#![allow(dead_code)]

This occurs in a few different commits, but I'd make sure to use
expect(dead_code) here so we are sure to remove it when everything is
used.

> +/// Virtual memory (VM) address space data for use in MMU operations.
> +#[pin_data]
> +pub(crate) struct VmAsData<'bound> {
> +    /// The address space seat tracks this VM's binding to a hardware address space slot.
> +    /// Uses [`LockedBy`] to ensure safe concurrent access to the slot assignment state,
> +    /// protected by the [`AsSlotManager`] lock.
> +    as_seat: LockedBy<Seat, AsSlotManager<'bound>>,

Why not use the LockedSeat type alias here?

> +        let lockaddr_val = LOCKADDR::zeroed()
> +            .try_with_size(lockaddr_size)?
> +            .try_with_base(lockaddr_base)?
> +            .into_raw();

Should this be:

	let lockaddr_val = LOCKADDR::zeroed()
	    .try_with_size(lockaddr_size)?
	    .try_with_base(lockaddr_base >> 12)?
	    .into_raw();

or even just

	let lockaddr_val = lockaddr_size | lockaddr_base;

?

Alice
