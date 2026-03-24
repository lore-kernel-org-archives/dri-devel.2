Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACB9F54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA21710E672;
	Tue, 24 Mar 2026 16:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Usi8u7sy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BA910E658
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:40:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36353419D3;
 Tue, 24 Mar 2026 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609AEC19424;
 Tue, 24 Mar 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774370428;
 bh=kkEoPq9q8fepKtiANcT9ZAfQh5CvujgTy1fMX5zG1GA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Usi8u7syiR8pttrP0If0eBSXVLvECDh4vy08/ZqtVulKRKflVXL3jmVRdohQwKBht
 pLikhuBCMExn+lDeH6gZOvhrGD5M3hP1lqIHYnzAv8h1HHMojvzMXa5gzawCKPOY1a
 eP2VC+2G4tfe7JyybigsnG7eTh9RsPeaM7wV6B6BIzFU2+inKczujBFLdhXFfoL2gy
 rnYVj0DfIip6b1NXGbxPHADZRGyVLbrPc/NrqMJg5deMxaIldA39qLx9J4yPIPZhJg
 NwmSSN+0BLFj8KbsFRSmClIbvc/QpUY5ipHQ42eIbrqKFyhJUeWnbIgZ1F+xDLL6Rg
 GW4STqjEN8Cng==
Date: Tue, 24 Mar 2026 16:40:23 +0000
From: Lee Jones <lee@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
Message-ID: <20260324164023.GE2902881@google.com>
References: <5084777.GXAFRqVoOG@rafael.j.wysocki> <acEOf2pI_NpfA4EP@aspen.lan>
 <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
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

On Tue, 24 Mar 2026, Rafael J. Wysocki wrote:

> On Mon, Mar 23, 2026 at 10:57 AM Daniel Thompson <danielt@kernel.org> wrote:
> >
> > On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > In all cases in which a struct acpi_driver is used for binding a driver
> > > to an ACPI device object, a corresponding platform device is created by
> > > the ACPI core and that device is regarded as a proper representation of
> > > underlying hardware.  Accordingly, a struct platform_driver should be
> > > used by driver code to bind to that device.  There are multiple reasons
> > > why drivers should not bind directly to ACPI device objects [1].
> > >
> > > Overall, it is better to bind drivers to platform devices than to their
> > > ACPI companions, so convert the Apple Backlight ACPI driver to a
> > > platform one.
> > >
> > > While this is not expected to alter functionality, it changes sysfs
> > > layout and so it will be visible to user space.
> > >
> > > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> 
> Thanks!
> 
> Unless anyone has any objections or concerns (in which case please let
> me know), I'm going to queue up this one for 7.1.

Why would you queue-up a Backlight patch?

I'd rather this goes in via the Backlight tree.

-- 
Lee Jones [李琼斯]
