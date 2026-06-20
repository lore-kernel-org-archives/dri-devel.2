Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5F1CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 20:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C02610E289;
	Sat, 20 Jun 2026 20:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="k1I+BHs9";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918C810E289;
 Sat, 20 Jun 2026 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7bD9mS5Zz5cqo1Y1ilNCwVtC8Kdtavh0qtaQ1yBkjo8=; b=k1I+BHs9IktNNHbqp/ZmOIeilf
 3tZcWG9aQPoIk4nkgS9Suxc5RqewRdUhS6oV5wHSuWytUCtCfCp79yR9N/3tq7Pvj2KWv/8jbJI6O
 uQgNFEYbqa9U+zW6CK5pVNdU4/9dtGfySKQaXTZdEIM/5T05wTYDX2ZbZmsehtq+p9OcQToSdgFDM
 uXnVKEzGszW1smE2Q1XkWx3wR8eoKrazOt20MwzWSKkEdtmaiF8PcOQhavsZC60LWGhMi84HfYi4/
 3I6j2iZmFaw66Xnnc8OB/3c5H1oGQwCVH76LcZmjVncCvvWoFBT/wXuAwGIaeEPZBHAMdeOjWRyZh
 rXdZ3Dyg==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <carnil@debian.org>) id 1wb22I-00HB6i-0f;
 Sat, 20 Jun 2026 20:11:26 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
 id 4BA10BE2EE7; Sat, 20 Jun 2026 22:11:25 +0200 (CEST)
Date: Sat, 20 Jun 2026 22:11:25 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jaak Ristioja <jaak@ristioja.ee>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Dianne Skoll <dianne@skoll.ca>, Chris Park <chris.park@amd.com>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: 1139950@bugs.debian.org, egressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [regression] amdgpu carrizo: no display signal after modeset
Message-ID: <178198613176.3658222.16247101620976737948@eldamar.lan>
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
X-Debian-User: carnil
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

Control: forwarded -1 https://lore.kernel.org/regressions/178198613176.3658222.16247101620976737948@eldamar.lan

Hi

Jaak Ristioja reported the following issue in Debian at
https://bugs.debian.org/1139950 . Part of the original report contains
Debian specific version information, but Jaak did as well a bisecion
for the regression see below:

On Sun, Jun 14, 2026 at 02:27:01AM +0300, Jaak Ristioja wrote:
> Package: linux-modules-7.0.10+deb13-amd64
> Version: 7.0.10-1~bpo13+1
> 
> Hi,
> 
> Upgrading (after a long while) Debian Trixie installations on two different
> HP EliteDesk 705 G4 DM 35W computers with AMD PRO A10-9700E R7 (carrizo)
> resulted in both machines blanking the screen right after kernel modesetting
> activates via amdgpu, with the monitor reporting "no signal". There are no
> other symptoms besides losing the display as the system continues to run and
> is accessible using keyboard and network.
> 
> Bug first discovered with stable kernel linux-image-6.12.90+deb13.1-amd64
> (6.12.90-2) and the one from trixie-backports. The device is connected to a
> monitor using a DisplayPort to HDMI adapter. The bug occurs regardless of
> which if the two available physical DisplayPort ports to use.
> 
> I don't remember this being an issue some months ago, so I tried to
> reproduce this booting the Debian 13.1.0 and 13.4.0 install DVD images and
> using the kernel modules/firmware therein:
> 
>   13.1.0 installer:
>     firmware-amd-graphics_20250410-2
>     linux-image-6.12.43+deb13-amd64_6.12.43-1
>   13.4.0 installer:
>     firmware-amd-graphics 20250410-2
>     linux-image-6.12.73+deb13-amd64_6.12.73-1
> 
> I essentially unpacked the two *.deb files manually, depmod -a; modprobe drm
> debug=0x1ff; modprobe amdgpu.
> 
> I observed the bug reproduce using the 13.4.0 installer, but not on the
> 13.1.0 installer, meaning this is a regression somewhere between kernel
> versions 6.12.43-1 and 6.12.73-1.

The reporter did a bisection and found as offending commit:

    drm/amd/display: Bump the HDMI clock to 340MHz

    commit fee50077656d8a58011f13bca48f743d1b6d6015 upstream.

    [Why]
    DP-HDMI dongles can execeed bandwidth requirements on high resolution
    monitors. This can lead to pruning the high resolution modes.

    HDMI 1.3 bumped the clock to 340MHz, but display code never matched it.

    [How]
    Set default to (DVI) 165MHz.  Once HDMI display is identified update
    to 340MHz.

    Reported-by: Dianne Skoll <dianne@skoll.ca>
    Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4780
    Reviewed-by: Chris Park <chris.park@amd.com>
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
    Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    (cherry picked from commit ac1e65d8ade46c09fb184579b81acadf36dcb91e)
    Cc: stable@vger.kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Does this ring any bell?

#regzbot introduced: ae5b1d291c814a2884c3d54a56e83bc99052b1eb
#regzbot link: https://bugs.debian.org/1139950

Regards,
Salvatore
