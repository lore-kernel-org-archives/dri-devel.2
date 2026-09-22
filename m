Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E2BC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA6910EE44;
	Tue, 22 Sep 2026 19:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ak713uba";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608E210EE44
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790106877; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NG7TGqcaA7B3W8Jzbla2PRavcLUdFCNPZpNBnVQV5fkjg/9kmXIKx+/J7pPrcIMIZgEdmU1L8Z6y9nRQQy4ST7s+FLiD7IwpxQI1WjJxo5yzvBdVh3RuADEjYJr1jl7EqjUyxGPUGVbpSUU3tx1gA6mdWKh8rUAzxGDw3gHvOEU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790106877;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wHDFw3EmkQFG9s4tz3HXuvKOKBGMZVsGDcBpIYq58fE=; 
 b=Lq1UttZP/i261nv63qVHxt0OxWQiBk+weSieAmdsoWr4t6pAv/RukDPktPQH9KXB8j+wdLXoxbikBybm9UtzSEohDi4dVEPMPG6hKGKYUWaMgkJ0kjfTyFrbCxguw6badiVFUYxGxCDZXEeQO/2Wnk9mlOidqtQKduDc+LA+gHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790106877; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=wHDFw3EmkQFG9s4tz3HXuvKOKBGMZVsGDcBpIYq58fE=;
 b=Ak713ubaVUapNx/5I9YBIl37btZ9HMU1bASlR4pp+i8wvDC6kK/8CoWY4u/nsupm
 aMW6SxOnPj9pt6OqZl+ZPIhvqxJu2m0jSNYdI5peOnENJ3tLMZflvcXnwoqsJwCtln8
 yNWBF1sSUrvJadv3hb/m+dQ4OEzikwgUzZtlvTjk=
Received: by smtp.zohomail.com with SMTPS id 1790106876647419.0814435954552;
 Tue, 22 Sep 2026 12:54:36 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:54:31 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
Message-ID: <arGZYue8wqe9jivU@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-16-e588feaa61ef@collabora.com>
 <20260914121937.6f75e87b@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914121937.6f75e87b@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.95.26
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

On 14.09.2026 12:19, Boris Brezillon wrote:
> On Sat, 12 Sep 2026 00:28:17 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Expose expanded PERFCNT_DUMP IOCTL interface to user mode.
> 
> I don't think it makes sense to have the version bump in a separate
> commit when the changes adding support for a uAPI extension are all in a
> single commit, so I'd squash this commit into patch 15.

Will do.

> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 571a26b84126..de9b1c115181 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
> >   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
> >   *	   PANFROST_IOCTL_QUERY_BO_INFO and
> >   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> > + * - 1.7 - adds PERFCNT_DUMP req state field
> >   */
> >  static const struct drm_driver panfrost_drm_driver = {
> >  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> > @@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
> >  	.name			= "panfrost",
> >  	.desc			= "panfrost DRM",
> >  	.major			= 1,
> > -	.minor			= 6,
> > +	.minor			= 7,
> >  
> >  	.gem_create_object	= panfrost_gem_create_object,
> >  	.gem_prime_import	= panfrost_gem_prime_import,
> > 

Adrian Larumbe
