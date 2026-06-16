Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ABECD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B6788EBA;
	Tue, 16 Jun 2026 18:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="iQwVxooz";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4595310EB0F
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:51:58 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2c6a4eccab1so8775ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781635918; x=1782240718;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
 b=iQwVxoozr2pd+LDaOvBERDb+4ilLS39PCaIu661ixA37OBvZeByDncIMtgLbxe8JmE
 9jtvzJPsJNVebj9L83QdHjf4HvMaWxN65dOweSZfHEAmbqZqAhN3RihtoAVBzOXotAUJ
 Ed3lQCRfsK0e18+JNcLqhi+KXaKC5KGJmiAn/QjYgujAamS2SKSQcBuw6qT/M9n6NTJK
 GSxEgfudxEraVwR+CK2mgCcV0LgpdBzgNMI94AlCsicRoiHroh6ktKL2h0o55OUk9Pjn
 9ij44b/W5GfJqlQHGK8TX62IhSVuZe6t2q+H8ExXyZ3/kjG9L5l5avQXKHBlrOx7uRRM
 VXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635918; x=1782240718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
 b=XbJGS0BTeiOfUKOuFAqN2j9U8mat5CPxZEmA6ct+0+ToaNpYmEC54wcBKTStPmrhqZ
 932al4Ep4g1X/YRgd54AEzCshDLqnY9ttmnLHmcv5UE6qH/Cp1WNHfQ3fdFYa1C8ZhYf
 Rl/IxwiNYISib/ZaqSMaPlcqM1IAIjLxvgUqKd0KWK8CcfWpQS231iCjGBbP6FcsFbOL
 ur6sphHTZvezrpKuM7Ot3dONIu3WLCMfvJBxpIMhEEQ2qS9vL2XTYA/CJEjijUL0FFTC
 BLjQt6h3OPV4pXUkN2agolGYorxaSbpKLYN8h/x1yM27aE6aQ61CDBnndNVJTSeAcGDO
 0sYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mUlzsJN2lTz2x/LMWY+EYvweYIfGJwzFJUmwLSaGn2vwiC+CpnXzJuhwpfpMrq+zurDrBrRwlzKk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/d34cKmGTzhK1RayRdxcghROyk8qQvt79GGZbDxodhW8NPYss
 dygxnKkiiJJkQmkD2a+zE3NrZKb00dqeb90f6JaTMlmCf5deQ5WUdFppJuaavSeCJA==
X-Gm-Gg: AfdE7cmHh/SsnjYOb+P5x808zqFG5gpt2H5Bji4gPxcG5iPlQdFGvy6JeSfX7liGLIo
 xPXgcpHPx/MKvd7YhOJ+UXhoo22XQyhqXUzChCmoz7unYAx0wowhjCOq3uwIXBhnpDi7/ViOPY5
 KIH/jca2WBD0p8rYVjMjsF6C7nGzG36QqIudUKLcV8BFlxLfP8+h/tUcgft9Xk+K30PPv3prcIW
 IZrDNe5IQC6jmhyScZasUt8N1ILoKyIAHnvluyFlJ/JwKoa+pcfmIkl3Ts2lg0GdjCiOwbVYC+a
 PoTTQ8VMDjHvnTbCt2yezE0omQtkBfyjvP2WaG/wtry6yaDRuS8lN+1sKjmrdy9lhD7Y7alilK3
 rcbOU8NtfDtFUOSy2pemnuEfDmnfS8lUoUIbnbW3P0BcnjL+3QgKwJ5d7TzY3xxQmj5EBCtqKvB
 dLk7kBDQ+tudBMhMB/G+FZMepI+mepvl3z7337MrjVvmtUchQKLMQ4d41oQO7L
X-Received: by 2002:a17:903:2f84:b0:2b0:b925:da98 with SMTP id
 d9443c01a7336-2c6bbc5d4eemr256505ad.19.1781635917134; 
 Tue, 16 Jun 2026 11:51:57 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ad03fdcsm13472996b3a.24.2026.06.16.11.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:51:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:51:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajGbRE3WWJxNxcrg@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
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

On Tue, Jun 16, 2026 at 09:48:14AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Saturday, June 13, 2026 3:39 AM
> > 
> > On Wed, Jun 10, 2026 at 04:43:20PM +0100, Matt Evans wrote:
> > > @@ -1264,7 +1265,7 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	if (!vdev->reset_works)
> > >  		return -EINVAL;
> > >
> > > -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> > > +	down_write(&vdev->memory_lock);
> > >
> > >  	/*
> > >  	 * This function can be invoked while the power state is non-D0. If
> > > @@ -1277,10 +1278,11 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	 */
> > >  	vfio_pci_set_power_state(vdev, PCI_D0);
> > >
> > > -	vfio_pci_dma_buf_move(vdev, true);
> > > +	vfio_pci_zap_revoke_bars(vdev);
> > 
> > I'm wondering if this change in behavior is correct?
> > BEFORE this patch the sequence was:
> > 
> > 1. zap vma mappings
> > 2. Enter D0
> > 
> > After this patch the sequence becomes
> > 
> > 1. Take the lock
> > 2. Enter D0
> > 3. zap vma mappings
> > 
> > My worry is if user-space accesses a BAR *during* the transition to D0,
> > it could crash since the mappings still exist during the transition?
> 
> not 'crash' as you also noted later with all Fs on read and dropped writes.

Ack, "crash" is definitely a strong word, I just meant that the
user-space program isn't expecting to see all Fs today. Since today any
access during reset is faulted, however with this all apps may have to
lookout for all Fs during a read. Could this change cause existing apps
to crash?

> 
> > 
> > The old code is immune to it because it removed user-mappings first.
> > 
> > Following the discussion from v1 regarding the ordering of
> > vfio_pci_dma_buf_move() and the D0 transition.. while it makes sense to
> > perform the DMABUF revocation/move after the hardware is in D0.. I'm not
> > too confident about moving zap after D0 :/
> 
> probably add a comment to remind that ordering requirement for dma
> 

+1. That'd be helpful.

> > 
> > I mean, sure, the user would just see all Fs on a read and writes will
> > be dropped silently until we are in D0.. but the behaviour before this
> > change was that the user access will fault and hang on the memory_lock
> > instead which ensures that the user observes a consistent dev state..
> > 
> 
> I see this more consistent from another angle.
> 
> Old code only removes/blocks cpu access but not for device. DMAs
> are allowed to this device while it's transitioning between D0/D3.
> 
> New code at least make this part consistent - both cpu/p2p are allowed
> in the transition window.
> 
> Ideally a sane userspace shouldn't rely on the content read back when
> it has initiated a reset in parallel. So this behavior change sounds ok?

I agree on the CPU / P2P consistency part. However, my concern is for a
shared reset scenario where a reset triggered by one process (I guess it
was vfio_assign_device_set?) can affect multiple devices in a dev_set
that are owned by different, unrelated processes. 

In the old code, these peer processes are protected because their BAR
mappings are zapped immediately. Their MMIO threads simply stall in
a page fault until the reset is complete.

I agree for a single-reset scenario, sane user-space should never access
regions during a self-triggered reset.

Am I missing something?

Thanks,
Praan
