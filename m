Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C5C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94D310EC7D;
	Tue, 22 Sep 2026 11:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IZTeex7m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0251410EC77
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 11:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C382435A9;
 Tue, 22 Sep 2026 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5711F000FF;
 Tue, 22 Sep 2026 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790077214;
 bh=Cdex/xc77a8XA/B00Q6ob6uKUgOkO9qJAXi/hd+RnjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IZTeex7mt83st8s/r6RAwUnSzSk9KGy5f47f6mCQf0vR9VB2lJggyo7ZjUqdNX/qW
 Mez+tS3jgNQrEKov+QaRHnAw87jWX5i8Aq7gF4QgTk1X/jfa7OdTEfZtovjQ08cbNV
 Z1JlPjREh+Nab3fd5aobh0oEH7+wxsuwwZfYANGgXOTF+CxqLOpFOQUTEY86UFM0Ki
 FzMQMhnNboyh0nWnSrrxMJCxr8tHn2G7yIePojS+5nBpDS7VOZBAVGHonWdRzjhhr8
 TKmyYrasoNXtpiSbKt0P33M/7S8UKcRTSOwq186O+lFL05r2HMp6vzteK5kpkqF5Ha
 fTLSDttVu189Q==
Date: Tue, 22 Sep 2026 14:40:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260922114010.GE563127@unreal>
References: <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
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

On Mon, Sep 21, 2026 at 02:08:47PM +0100, Matt Evans wrote:
> Hi both,
> 
> On 16/09/2026 15:19, Christian König wrote:
> > On 9/15/26 16:22, Matt Evans wrote:
> >> Hi Christian,
> >>
> >> On 15/09/2026 12:13, Christian König wrote:
> >>> On 9/15/26 09:20, Leon Romanovsky wrote:
> >>>> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
> >>>>> Hi Leon,
> >>>>>
> >>>>> On 14/09/2026 12:54, Leon Romanovsky wrote:
> >>>>>> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
> >>>>>>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> >>>>>>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> >>>>>>>>> Expand the VFIO DMABUF revocation state to three states:
> >>>>>>>>> Not revoked, temporarily revoked, and permanently revoked.
> >>>>>>>>
> >>>>>>>> The thing is that "temporarily revoked" is actually the standard
> >>>>>>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> >>>>>>>> for VFIO.
> >>>>>>>
> >>>>>>> I think temporarily revokes here means it is revoked from a dmabuf
> >>>>>>> perspective
> >>>>>>
> >>>>>> My guess is that this is more of a "change owner" operation than a
> >>>>>> revoke operation.
> >>>>>>
> >>>>>> The main issue here is that we have to guess the semantics instead of
> >>>>>> having a properly named and documented operation.
> >>>>>
> >>>>> Apologies if the cover letter for the series and patch commit message (which
> >>>>> cover this) are unclear about the motivations and semantics.  On the commit
> >>>>> message, can you suggest clarifications:
> >>>>>
> >>>>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
> >>>>> ranges previously delegated to a subordinate client process: by
> >>>>> revoking, the driver process can ensure that the loaned resources are
> >>>>> made inaccessible when the client is deemed "done".  The original
> >>>>> DMABUF is defunct, and BAR resources can then be safely re-exported
> >>>>> for use by new clients."
> >>>>>
> >>>>> Given what I'll explain below, do give suggestions please.  There is more
> >>>>> context in the cover letter (the volume of which I didn't think appropriate
> >>>>> for the commit message).
> >>>>
> >>>> 1. Do not mix "driver" and "client" in the same description. For a
> >>>> non-native English speaker, "driver" has a very specific meaning in the
> >>>> context of the Linux kernel.
> >>>
> >>> In the context of DMA-buf it has also proven vital to clearly use the terms importer and exporter to describe the different roles a driver can have.
> >>>
> >>> I can't count how often there was confusion because people (me included) just used "driver" and it wasn't clear which role was meant.
> >>
> >> :)  I see where the quote can be clearer.  FWIW the "driver process" was
> >> referring to a userspace driver (which is a legitimate use of the D-word
> >> with VFIO, but still).  I'll clarify that, and will indicate this
> >> mechanism is used by userspace to influence the VFIO _exporter_ behaviour.
> >>
> >>>> 2. Explain the lifecycle in the commit message, and why "revoke", which
> >>>> is effectively what the importer does, is not sufficient.
> >>>>
> >>>> 3. The more you put in the cover letter, the less likely people are to
> >>>> read it.
> >>>>
> >>>> 4. Commit messages should describe the patches themselves, since they
> >>>> are what remains visible in the git log, unlike the cover letter.
> >>>>
> >>>> 5. I would call what you describe as "temporarily revoke" is actually "reclaim".
> 
> Leon, please see *** below.

I would like to see clearer terminology here. Terms such as "temporarily
revoke" and "permanently revoke" are misleading and require the reader to
be very familiar with the underlying details.

The exact terminology matters less to me, as long as we avoid overloading
the existing meaning of "revoke".

Thanks
