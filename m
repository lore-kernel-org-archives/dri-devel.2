Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=wLlkl+OD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1861C10E444;
	Wed, 18 Nov 2026 12:37:20 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B89410E444
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:37:14 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D3F363C;
 Wed, 18 Nov 2026 13:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795005284;
 bh=ll6996UDsuF7w8pITuDox1RaFVgxbc6j0tUmNVtfLDQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=wLlkl+OD/EP/pi/S9jdKU7kPUNmIRRRNfdU3OBqzEwHnh3HaglXMrzna+z2o0s06T
 5QAzC7pmKXnoAktW6qpEFDnBvG1NEBVwierPsKMulXxlCsGCldY6+b3W1UT0CJ8xfO
 hqXHkFtN5R7A7pJAyzglrcOs1j55COBncKxMn7H4=
Message-ID: <c9c78db9-6b3b-41d8-9880-8b137bdbdd38@ideasonboard.com>
Date: Wed, 18 Nov 2026 14:37:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/39] drm: Implement state readout support
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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
 <ff10a7e1-3a5d-4e0f-be4b-aba3d05de1cd@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <ff10a7e1-3a5d-4e0f-be4b-aba3d05de1cd@ideasonboard.com>
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

On 17/11/2026 17:17, Tomi Valkeinen wrote:
> Hi,
> 
> On 06/11/2026 15:14, Maxime Ripard wrote:
>> Hi,
>>
>> Here's a series that implement what i915 calls "fastboot", ie,
>> initializing the initial KMS state from the hardware state at boot, to
>> skip the first modeset if the firmware already set up the display.
>>
>> This series creates the infrastructure in KMS to create that state by
>> relying on driver specific hooks. It also implements some infrastructure
>> to check during non-blocking commits that the readout helpers work
>> properly by reading out the state that was just committed and comparing
>> it to what was supposed to be committed.
>>
>> This relies on another set of driver hooks to compare the entities
>> states, with helpers providing the default implementation.
>>
>> It then implements the readout support in the TIDSS driver, and was
>> tested with the SK-AM62 board. This board in particular is pretty
>> interesting, since it relies on an DPI to HDMI bridge, and uses the
>> drm_bridge_connector infrastructure.
>>
>> So the readout works with the current state of the art on embedded-ish
>> platforms.
>>
>> Unlike the earlier RFCs, it now works fine: the state is picked up
>> properly, doesn't trigger a modeset if what was programmed is the one
>> the first modeset tries to pick as well, will switch properly if it
>> isn't, etc.
> Sorry for taking so long with this, even if I said already a long time 
> back that I have additional patches for you. I now finally managed to 
> get them into some kind of order, and I have pushed a branch to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git ti/boot- 
> splash-v8.5
> 
> It's based on today's drm-misc-next, with the following posted series on 
> top:
> 
> - [PATCH RESEND 00/83] drm: Switch drivers to 
> drm_mode_config_create_initial_state
> - [PATCH v8 00/39] drm: Implement state readout support
> 
> However, from the SRO series, I dropped all the tidss patches. It was 
> getting so difficult to make my changes at changes on top, so I decided 
> to just make fresh clean ones. I've tried to keep authorship where 
> applicable, but I could have missed some.
> 
> After the SRO series, I have a pile of patches on top. It starts with 
> tidss patches that are not quite SRO related, but fix things or change 
> the structure so that SRO gets easier to add:
> 
> drm/tidss: Fix the plane staying disabled after a CRTC off and on
> drm/tidss: Remove the unused 'is_enabled'
> drm/tidss: Split requesting the interrupt from enabling it
> drm/tidss: Split dispc_init_hw() into steps called from probe
> drm/tidss: Reset the DSS after the probe steps that can defer
> drm/tidss: Keep the DSS enabled from the reset to the end of probe
> 
> Then I have some non-tidss patches. Some of these, I think, you already 
> had in a local tree or were posted in the tilcdc series. The panel side 
> is lacking, so I labeled those as hacks. I'm not quite sure how to 
> correctly implement that.
> 
> drm/atomic_sro: Do not compare the plane zpos
> drm/atomic_sro: Do not compare planes on an inactive CRTC
> drm/atomic_sro: Add a device-level atomic_sro_install_state hook
> drm/bridge: Add an atomic_sro_install_state hook for bridges
> HACK: drm/bridge: panel: Prepare and enable the panel when installing 
> the state
> HACK: drm/panel: simple: Set the sync polarities of Microtips 
> MF-101HIEBCAF0
> 
> Then I have tidss SRO patches. Many of these are based on yours, but 
> there are plenty of details that have changed, fixing issues I found 
> when testing different combinations.
> 
> drm/tidss: Implement .hw_reset hook
> drm/tidss: Reset the DISPC at runtime suspend if probe did not reset it
> drm/tidss: dispc: Add helpers for the state readout
> drm/tidss: encoder: Implement atomic_sro_get_current_crtc
> drm/tidss: oldi: Implement hw readout support
> drm/tidss: dispc: Keep DPIENABLE of an active VP in dispc_vp_init()
> drm/tidss: crtc: Implement hw readout support
> drm/tidss: plane: Implement hw readout support
> drm/tidss: encoder: Implement bridge state readout
> drm/tidss: Implement hw readout support
> 
> I have been testing these with AM62-SK, HDMI and OLDI, with all the 
> different combinations I've come up with. However, I realized just today 
> that the bootloader could still do things a bit differently, which 
> wouldn't work with the current patches. I decided to ignore that for now.
> 
> I also need to test all this on other TI boards, without SRO, or perhaps 
> adding SRO if it's easy-ish.
> 
> So... Again, thanks Maxime for the great work you've done here, I really 
> like this series. It's annoyingly complicated to get to work reliably, 
> though, but maybe we'll get there =). With all my tests now working, 
> I'll try to find the time to actually review the series.
> 
> Feel free to use, abuse, or not use the commits from my branch in any 
> way you want.
A few more issues I found while testing.

The SRO can never fully recover the state we have on the SW side. One 
particular case is the fb/plane sizes and offsets. E.g.

kmstest -c lvds -p 1:800x800 -f 2000x2000 -v 10,10-800x800

*ERROR* plane-1 configuration mismatch in src_x expected 10.000000, got 
0.000000
*ERROR* plane-1 configuration mismatch in src.x1 expected 655360, got 0
[PLANE:45:plane-1] Committed and Readout PLANE state don't match

There's no offset in the HW, so the SRO just gives 0. Another with the 
width and height:

kmstest -c lvds -p 1:800x800 -f 1200x1200 -v 0,0-900x900

*ERROR* framebuffer configuration mismatch in width expected 1200, got 900
*ERROR* framebuffer configuration mismatch in height expected 1200, got 900
[PLANE:45:plane-1] Committed and Readout PLANE state don't match

I think we can fix the fb width, at least for tidss, as we should be 
able to read out the stride. But for fb height, there's nothing in the HW.

Another, tidss specific one, is when we downscale enough, and the driver 
switches to decimating. We don't do a proper readout for that.

Then a possibly wider issue: with two displays, the driver assigns the 
planes as primary planes for each display. If the bootloader has 
configured the planes on two displays the other way, we run into trouble 
with legacy modesetting. In my case the bootloader sets up plane 0 on 
HDMI, plane 1 on LVDS. The driver's init configures plane 1 as the 
primary plane for HDMI, and plane 0 for LVDS. If I then do:

KMSXX_DISABLE_ATOMIC=1 kmstest -c hdmi

it fails.

Another, perhaps tidss related issue is with bus formats & flags. 
Changing them doesn't cause a full modeset, so if the bootloader e.g. 
sets up DE to active high, but the kernel wants to use a different 
value, and we have a connector related commit that's not a modeset:

import kms
card = kms.Card()
conn = next(c for c in card.connectors if c.fullname == 'LVDS-1')
req = kms.AtomicReq(card)
req.add(conn, 'CRTC_ID', conn.get_prop_value('CRTC_ID'))
req.commit_sync(allow_modeset=False)

results in:

*ERROR* crtc-0 configuration mismatch in bus_flags expected 0000008a, 
got 00000086
[CRTC:42:crtc-0] Committed and Readout CRTC state don't match
*ERROR* bridge-30200000.dss configuration mismatch in 
input_bus_cfg.flags expected 0000008a, got 00000086
*ERROR* bridge-30200000.dss configuration mismatch in 
output_bus_cfg.flags expected 0000008a, got 00000086
Committed and Readout private object state don't match
*ERROR* bridge-30200000.dss configuration mismatch in 
input_bus_cfg.flags expected 0000008a, got 00000089
*ERROR* bridge-30200000.dss configuration mismatch in 
output_bus_cfg.flags expected 00000002, got 00000001
Committed and Readout private object state don't match


I don't have proper fixes for these yet, but SRO does bring out all 
kinds of interest corner cases =).

  Tomi

