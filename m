Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE37FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2CD310E215;
	Mon, 27 Apr 2026 11:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnsXT5KP";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4B7C210E215
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:51:34 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 8D55F20B7169; Mon, 27 Apr 2026 04:51:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D55F20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777290694;
 bh=u4fxCSX6+lkya8NkULSrVpIHMRpwmUGWqwp1lb66MDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VnsXT5KPDTqb3PGZqTBaTFbTzX+ByVQgClsT65WKGJG2JZC9V16fL6Y4yQ78sHfFD
 B2ElV/SkAyffzpDCAWB9kzh+7kGOpd1z5oLvqvzzJbHPPokS4jV8EoCZ/9g9tJELoN
 GiJkCIdmaFtrl4gV4aiOAtcpa0RDwdJb6K967djY=
Date: Mon, 27 Apr 2026 04:51:34 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 Long Li <longli@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Himadri Pandya <himadrispandya@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Deepak Rawat <drawat.floss@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "stable@kernel.vger.org" <stable@kernel.vger.org>
Subject: Re: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Message-ID: <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
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

On Sun, Apr 26, 2026 at 05:00:24AM +0000, Saurabh Singh Sengar wrote:
> > Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
> > 
> > VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
> > ensure they are always aligned and large enough to hold all of the relevant
> > data.
> > 
> > Cc: stable@kernel.vger.org
> > Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video
> > device")
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > index 051ecc526832..753d97bff76f 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > @@ -10,7 +10,7 @@
> > 
> >  #include "hyperv_drm.h"
> > 
> > -#define VMBUS_RING_BUFSIZE (256 * 1024)
> > +#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
> >  #define VMBUS_VSP_TIMEOUT (10 * HZ)
> > 
> >  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
> > --
> > 2.54.0
> 
> Although this lgtm, but this may change the behaviour on ARM64 systems with page size > 4K ?
> Have we tested it ?

Yup, I tested it on an ARM64 windows machine with a 64K page size guest kernel.

> 
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Pushed to drm-misc.

> 
