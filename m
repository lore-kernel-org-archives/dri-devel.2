Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA13C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBCF10E473;
	Fri, 17 Jul 2026 14:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R2KJ8m5P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0281310E473
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:29:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0ED6560204;
 Fri, 17 Jul 2026 14:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D6A1F000E9;
 Fri, 17 Jul 2026 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298581;
 bh=NXH9xDP5EGt4A9bhAAgfN7wyEZ9GTtJVjj7HW+q1SQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R2KJ8m5PkPwQBw0jAJXXX750pY4kPE/YgPe99p5L6gMj2TGr3TuXVwslR2fBxL6ii
 gdXwaU78/lBLG4AbstFSRWYabGHcmrZfQQoPR3s0Zeu4zt6vspKeTDLmLBg/4nOh7k
 lrZ7tPQVPivswaGbG/9lnfrgCWEyq42N8CHKYwMrXCdI2iTOAzq+SWr3AtfxOcicr0
 B6n1QcOMuwMFGIXt0bUN+68Dnua4rD5URgV3fMtiHuLruVSV+DggWK2ZpHsIcuptmW
 B8IHybc6ITZ+Jjwy1zPLv6gezpOLt+EUaRMkhYcbfoR7tVSyJL9vTCxDBsYpUObASX
 VRenxz/MZKVvg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkjZL-00000007c9e-1A4A;
 Fri, 17 Jul 2026 16:29:39 +0200
Date: Fri, 17 Jul 2026 16:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel-edp: take i2c adapter module reference
Message-ID: <alo8U-klzuNmEP8e@hovoldconsulting.com>
References: <20260716132245.1565121-1-johan@kernel.org>
 <CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com>
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

Hi Doug,

On Thu, Jul 16, 2026 at 10:27:02AM -0700, Doug Anderson wrote:

> On Thu, Jul 16, 2026 at 6:22 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> >
> > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > reference to the adapter module so that an attempt to unload the module
> > while in use fails gracefully instead of blocking uninterruptibly.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Worth adding any "Fixes:" tag? I guess this has been using
> of_find_i2c_adapter_by_node() for a long time...

Yeah, this comes from panel-simple which has had this issue since it was
merged in 2013. And that's a couple of years before the helper taking a
module reference even existed. 

I decided not to treat these as individual driver bugs, but perhaps the
instances added after the helper was merged could have had a Fixes tag.

> Sashiko-bot review [1] seems right, even though it's pointing out
> something that isn't really a new problem and is very much a corner
> case where someone is crafting an intentionally ridiculous device
> tree. If you agree, I wouldn't mind a followup patch fixing that, too.
> ;-)
> 
> [1] https://lore.kernel.org/r/20260716133420.187131F000E9@smtp.kernel.org/

Right, I saw that one too but wrote it off as a preexisting issue.

I'll send a v2 of this one rebased on a fix for that instead.

Johan
