Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DD606A882
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ERypDUVe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EB810E413;
	Mon, 16 Nov 2026 15:02:42 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id C753410E414
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:02:35 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id C1DBF20B7168; Mon, 16 Nov 2026 07:02:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1DBF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794841349;
 bh=UrYcNCnPwkCr55f9wx8oAre7u+b0LDqMaAoFyZ5VaPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ERypDUVeu4NV1skzpf8c34AAAzQIG3PkRJQtWby0OLSkQ3SY2aKbeQhqT/Dm96/en
 QBTevP16cm96ExjC3d+nw/C85+oOk2rhax6ilL9H7pHsMuKWWdKczebjbxfa/YpNm1
 C5WCyZWbv2VYosYIY9eN6Z7Wtq1XqTTfLgniRwhg=
Date: Mon, 16 Nov 2026 10:02:29 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Message-ID: <avsbBTsIoo09yr9L@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
 <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 05:43:06PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, November 13, 2026 1:59 PM
> > 
> > I was doing a deep dive into the host spec and noticed some gaps. So,
> > I went ahead and hacked together the patches in this series for items
> > that seemed worthwhile to address.
> 
> Are you (or someone on the Microsoft side) testing these changes
> in a Generation 1 VM, as well as on back revs of the Hyper-V host?

Ya, I have smoke tested all of these patches on WS2016 (both gen1 and
gen2). Also, I have it on good authority that they should be good at
least as far back as VMBus v3.0, so it should cover everything that
is currently supported.

> Testing should go back to Windows Server 2016/Windows 10 for
> both Gen1 and Gen2.
> 
> Same questions apply to your earlier cursor plane support. I just
> did basic smoke testing of the cursor plane support on both Gen1
> and Gen2 VMs using vmconnect.exe on an up-to-date Windows 11
> host -- no obvious problems. But I don't have access to older hosts
> like WS2016/Win10 to do the back rev testing.
> 
> There are multiple frame buffer differences in Gen1 and Gen2 VMs,
> but most (or all?) are in the lowest layer in how the frame buffer is
> allocated and mapped. Hopefully these higher-level changes you are
> making are agnostic of the VM generation, but thoroughness would
> dictate testing both.
> 
> I'm less sure about what might have changed in current Hyper-V
> versions and WS2016 from 10 years ago. My general impression is
> that very little, if anything, has changed in the Hyper-V frame buffer
> support, but again it would be better to not get a bad surprise after
> the code has gone in.
> 
> Michael
> 
> > 
> > Hamza Mahfooz (2):
> >   drm/hyperv: add modes for all resolutions offered by the host
> >   drm/hyperv: batch dirty rectangles
> > 
> >  drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
> >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
> >  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++-----
> >  4 files changed, 110 insertions(+), 20 deletions(-)
> > 
> > --
> > 2.56.0
