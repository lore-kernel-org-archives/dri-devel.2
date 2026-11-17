Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA0606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kvrM0Is5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8D810E28E;
	Tue, 17 Nov 2026 15:17:54 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5732410E28E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:17:48 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4BFB515B2;
 Tue, 17 Nov 2026 16:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794928519;
 bh=AuNfJcVsNlmBHvQXbr/m6QK3IosI8fGBFvj6yCnOQEY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kvrM0Is5KWmScATicbXKF0w52EBhcBF4F889GdIdx6empYQ7QSBWJ+7FBmak0Tc7V
 iLYYh0pz1zVC5bJQytP1nYjNdYKdlwfjnyhh3TkdlV3Z4HOhbiqK/4IzmgKVMAWkhY
 WPuG/wkSGqQmur2l25cFK9kjjpPWIXOF5YNsZ3QA=
Message-ID: <ff10a7e1-3a5d-4e0f-be4b-aba3d05de1cd@ideasonboard.com>
Date: Tue, 17 Nov 2026 17:17:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/39] drm: Implement state readout support
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Paul Cercueil <paul@crapouillou.net>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 06/11/2026 15:14, Maxime Ripard wrote:
> Hi,
> 
> Here's a series that implement what i915 calls "fastboot", ie,
> initializing the initial KMS state from the hardware state at boot, to
> skip the first modeset if the firmware already set up the display.
> 
> This series creates the infrastructure in KMS to create that state by
> relying on driver specific hooks. It also implements some infrastructure
> to check during non-blocking commits that the readout helpers work
> properly by reading out the state that was just committed and comparing
> it to what was supposed to be committed.
> 
> This relies on another set of driver hooks to compare the entities
> states, with helpers providing the default implementation.
> 
> It then implements the readout support in the TIDSS driver, and was
> tested with the SK-AM62 board. This board in particular is pretty
> interesting, since it relies on an DPI to HDMI bridge, and uses the
> drm_bridge_connector infrastructure.
> 
> So the readout works with the current state of the art on embedded-ish
> platforms.
> 
> Unlike the earlier RFCs, it now works fine: the state is picked up
> properly, doesn't trigger a modeset if what was programmed is the one
> the first modeset tries to pick as well, will switch properly if it
> isn't, etc.
Sorry for taking so long with this, even if I said already a long time 
back that I have additional patches for you. I now finally managed to 
get them into some kind of order, and I have pushed a branch to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 
ti/boot-splash-v8.5

It's based on today's drm-misc-next, with the following posted series on 
top:

- [PATCH RESEND 00/83] drm: Switch drivers to 
drm_mode_config_create_initial_state
- [PATCH v8 00/39] drm: Implement state readout support

However, from the SRO series, I dropped all the tidss patches. It was 
getting so difficult to make my changes at changes on top, so I decided 
to just make fresh clean ones. I've tried to keep authorship where 
applicable, but I could have missed some.

After the SRO series, I have a pile of patches on top. It starts with 
tidss patches that are not quite SRO related, but fix things or change 
the structure so that SRO gets easier to add:

drm/tidss: Fix the plane staying disabled after a CRTC off and on
drm/tidss: Remove the unused 'is_enabled'
drm/tidss: Split requesting the interrupt from enabling it
drm/tidss: Split dispc_init_hw() into steps called from probe
drm/tidss: Reset the DSS after the probe steps that can defer
drm/tidss: Keep the DSS enabled from the reset to the end of probe

Then I have some non-tidss patches. Some of these, I think, you already 
had in a local tree or were posted in the tilcdc series. The panel side 
is lacking, so I labeled those as hacks. I'm not quite sure how to 
correctly implement that.

drm/atomic_sro: Do not compare the plane zpos
drm/atomic_sro: Do not compare planes on an inactive CRTC
drm/atomic_sro: Add a device-level atomic_sro_install_state hook
drm/bridge: Add an atomic_sro_install_state hook for bridges
HACK: drm/bridge: panel: Prepare and enable the panel when installing 
the state
HACK: drm/panel: simple: Set the sync polarities of Microtips MF-101HIEBCAF0

Then I have tidss SRO patches. Many of these are based on yours, but 
there are plenty of details that have changed, fixing issues I found 
when testing different combinations.

drm/tidss: Implement .hw_reset hook
drm/tidss: Reset the DISPC at runtime suspend if probe did not reset it
drm/tidss: dispc: Add helpers for the state readout
drm/tidss: encoder: Implement atomic_sro_get_current_crtc
drm/tidss: oldi: Implement hw readout support
drm/tidss: dispc: Keep DPIENABLE of an active VP in dispc_vp_init()
drm/tidss: crtc: Implement hw readout support
drm/tidss: plane: Implement hw readout support
drm/tidss: encoder: Implement bridge state readout
drm/tidss: Implement hw readout support

I have been testing these with AM62-SK, HDMI and OLDI, with all the 
different combinations I've come up with. However, I realized just today 
that the bootloader could still do things a bit differently, which 
wouldn't work with the current patches. I decided to ignore that for now.

I also need to test all this on other TI boards, without SRO, or perhaps 
adding SRO if it's easy-ish.

So... Again, thanks Maxime for the great work you've done here, I really 
like this series. It's annoyingly complicated to get to work reliably, 
though, but maybe we'll get there =). With all my tests now working, 
I'll try to find the time to actually review the series.

Feel free to use, abuse, or not use the commits from my branch in any 
way you want.

  Tomi

