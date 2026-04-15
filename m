Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54067F419B6
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7ED410E6E2;
	Wed, 15 Apr 2026 14:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="T5agbBd9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1B010E6E2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 14:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776261682; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IOPvo1x2VU/uAmY2DeQObsa3u10m0MizPrN7sjAaNFm7XloULNp1/nl1+D5VEh7TPMc72FVoDLdVmWxmW60Cl51Wfdw6R+agQV+9ehXZW/V6LmMFrxNn51weLGydE/iwwANpITU+aLAos0nfeTGaR8eDAhd2nzPMeyo2CS2gpUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776261682;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w5EzX3RqJiH4Nx51/P4J5xtZrA5uWPd352nieBRMKRA=; 
 b=OQXLZ86xHZFZmX75GZWOCWvOlEUac2bSG7haZJ03iA9YJeb9YU6opZYSzzwjFvpgdFfFbWCn6YpgLhLv3JTToE89hD+VHAhQGlDjNctvNkcF9yS9lc0kFPkqaxDfyC7REFfshY55ewMK3CVrFMTepM1N4UAtfIylBaVTutC2B24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776261682; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=w5EzX3RqJiH4Nx51/P4J5xtZrA5uWPd352nieBRMKRA=;
 b=T5agbBd9l8z8AZqXx6jcRREyiak6rqqGAr1BjqxnN8HjX3fnX9YL3CMkJC+Bh8pz
 F+VlBOb6pILr40LfXUnU6ZQNVl7o/o7iviNG4V5vBLK6MLF36cm2avLerk66cZABdCi
 MNLDfdEgIxkzvXkDuRWT1/2oDGZuIkmEUCxsNbc0=
Received: by mx.zohomail.com with SMTPS id 1776261679978802.8043753562798;
 Wed, 15 Apr 2026 07:01:19 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:01:15 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
Message-ID: <ad-ZeRTbYYGatj7G@sobremesa>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
 <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
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

Hi Jani,

On 15.04.2026 16:54, Jani Nikula wrote:
> On Wed, 15 Apr 2026, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> > Bump the driver version to reflect the new MMU info query ioctl
> > parameter and the VM_BIND map sparse flag.
>
> You're not actually bumping the version, just adding to the comment.

Forgot to increase the driver's minor revision number, thanks for the catch.

> Does the version actually work for you for checking stuff? Do you have
> userspace checking it? Should it be some capability thing instead?

We absolutely need it because the UMD must be compatible with previous kernel versions,
which means in the case of sparse mappings, the old method of creating the dummy BO
in user mode and then having the Mesa driver do repeated mappings over it through
successive VM_BIND ioctl's must be available.

> BR,
> Jani.
>
> >
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > index a8090bc4e33c..c8fb63ede62c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
> >   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
> >   *       - adds drm_panthor_gpu_info::selected_coherency
> >   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> > + * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
> > + *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> >   */
> >  static const struct drm_driver panthor_drm_driver = {
> >  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
>
> --
> Jani Nikula, Intel

Adrian Larumbe
