Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0B6CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 15:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9954810E26D;
	Tue, 12 May 2026 15:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="atLEN8zi";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8DB9E10E26D
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:38:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA399202C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:38:39 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9F23B3F85F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778600324; bh=bTW8PIkNq6aZUF6NF1FmasGVCIC4HDNHJXMvlerQOQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=atLEN8zitquJu3MG2aDl/Vqi6TIEMDlsKtSGYcLkHaOfl4AHGPBij+gXG69ChKKYd
 ijqGR2Ve35H7L3fyGUjrh7DWwjYtUcWBrcRFp8tvLqWE5Oax9UyGR45UTiyHML5BEr
 d5ibpUQ7gS9C9zwyUwCXCD9joyVUtQFxO65pgXZI=
Date: Tue, 12 May 2026 16:38:18 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>,
 Ketil Johnsen <ketil.johnsen@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <agNJasayW8VCHTiU@e142607>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora> <afxVIuVVPisBQ9p_@e129842.arm.com>
 <20260507135356.5428d50d@fedora> <agMvb_jeRsO7tSS-@e142607>
 <20260512161111.0cb7000e@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512161111.0cb7000e@fedora>
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

On Tue, May 12, 2026 at 04:11:11PM +0200, Boris Brezillon wrote:
> On Tue, 12 May 2026 14:47:27 +0100
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > On Thu, May 07, 2026 at 01:53:56PM +0200, Boris Brezillon wrote:
> > > On Thu, 7 May 2026 11:02:26 +0200
> > > Marcin Ślusarz <marcin.slusarz@arm.com> wrote:
> > >   
> > > > On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wrote:  
> > > > > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panthor_device *ptdev)
> > > > > >  			return ret;
> > > > > >  	}
> > > > > >  
> > > > > > +	/* If a protected heap name is specified but not found, defer the probe until created */
> > > > > > +	if (protected_heap_name && strlen(protected_heap_name)) {    
> > > > > 
> > > > > Do we really need this strlen() > 0? Won't dma_heap_find() fail is the
> > > > > name is "" already?    
> > > > 
> > > > If dma_heap_find() will fail, then the whole probe with fail too.
> > > > This check prevents that.  
> > > 
> > > Yeah, that's also a questionable design choice. I mean, we can
> > > currently probe and boot the FW even though we never setup the
> > > protected FW sections, so why should we defer the probe here? Can't we
> > > just retry the next time a group with the protected bit is created and
> > > fail if we can find a protected heap?  
> > 
> > The problem we have with the current firmware is that it does a number of setup steps at "boot"
> > time only. One of the steps is preparing its internal structures for when it enters protected
> > mode and it stores them in the buffer passed in at firmware loading. We cannot later run the
> > process when we have a group with protected mode set.
> 
> No, but we can force a full/slow reset and have that thing
> re-initialized, can't we? I mean, that's basically what we do when a
> fast reset fails: we re-initialize all the sections and reset again, at
> which point the FW should start from a fresh state, and be able to
> properly initialize the protected-related stuff if protected sections
> are populated. Am I missing something?

Right, we can do that. For some reason I keep associating the reset with the
error handling and not with "normal" operations.

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
