Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDA9103E166
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869AB10E32F;
	Wed, 18 Mar 2026 11:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pVWgczWt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E40910E3F2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773834333;
 bh=VVR+rPozuCmk3fPCcBrJvk79JKneXnM9ifrXxXuvJ4U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pVWgczWtgCHVgkRPxEQZNHzYnyLFhtuMrjua5Yi0+nf1fMXxgUjQtqq8T9gQwFR0u
 R/6NRF1fhxYpI1AqWZehaxh5hq/Z5MrhE/gRslOTxBAMy03lT4dGfOk5wEna+FYHub
 VyQv3ZD/Sw5HYWTr5iKTj+wPfhI3kmI/HmMBSdn5+6N9/lVKkBhVx6IVYsyg5zCbMe
 sZnxthWs1kKiNW8sDAys/SPfJ2q3PGiEQdxIa2aP45VdZGwkoQUrBH2txvLjyaiozP
 F73+zMsEpJMoTP6g4AYIsNvcOZvCxgXsRtOU/dBQrwhzeHFyTl4jqm66wzRKptDPHK
 BbuN/ZHfp6Cnw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E7B7C17E137B;
 Wed, 18 Mar 2026 12:45:32 +0100 (CET)
Date: Wed, 18 Mar 2026 12:45:29 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <20260318124529.1269ffc7@fedora>
In-Reply-To: <abqHvvsyL5BPA_cn@fedora>
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <20260316152152.1e20d35e@fedora> <20260317183054.5d7030ec@fedora>
 <20260318111649.2912818b@fedora> <abqHvvsyL5BPA_cn@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 18 Mar 2026 08:14:31 -0300
Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:

> On Wed, Mar 18, 2026 at 11:16:49AM +0100, Boris Brezillon wrote:
> > On Tue, 17 Mar 2026 18:30:54 +0100
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >   
> > > > 
> > > > I've played a bit with the drm-misc-{next,fixes} versions (with the extra
> > > > pfn_mkwrite fixes on top for the -next variant), and below is my preferred
> > > > version (pfn insertion is all handled inside the try_insert_pfn() helper,
> > > > with order == PMD_ORDER specialized there).    
> > > 
> > > One last thing, the subject should probably be "drm/shmem-helper: Fix
> > > huge page mapping in fault handler" (instead of "Fix Map huge page
> > > ..."). Pedro, do you think you'll be able to send a v4 before the end
> > > of the week? I'd really like to have that fix in -rc5 or -rc6.  
> > 
> > If you can't, please let me know, I'll post a new version for you.  
> 
> Should I send a patch for the drm-misc-{next,fixes}, or v7.0-rc4?

The patch should be against drm-misc-fixes, and if you can port it to
drm-misc-next and share the diff, that would be helpful for the merge
conflict resolution.

> I am planning to send it today.

Thanks!
