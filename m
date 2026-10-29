Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA2606A323
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Wafcha3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C98811239C;
	Thu, 29 Oct 2026 15:20:35 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B9011239C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:20:28 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC5C9447;
 Thu, 29 Oct 2026 16:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793287093;
 bh=EyTih/Clr8AyxUlfE6y1Xe7TiiehpHr3Bj6LTNfNVPM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wafcha3Adu1AtNEkuHHf/4F9zWGxs2WehkLjHBIih9+JrfzK9dENENP80208N0645
 PEAAfJLxccNyJoewS+ITYvZ7SvQ/BJOBn9GSG44Du5v4i4C3AY7HH87f5d1yMrIMNb
 kVtbuj/qEoTuiE7at96sj4cFc58rzDEVaWwRSddQ=
Message-ID: <843607fc-45fc-47c5-9d20-6feced20a43f@ideasonboard.com>
Date: Thu, 29 Oct 2026 17:20:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/34] drm: Implement state readout support
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Jocelyn Falempe <jfalempe@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

On 29/10/2026 09:33, Maxime Ripard wrote:
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
Sorry that I haven't had time to properly test and work on this. Here's 
some quick feedback.

Do you have a branch you use to test this, with additional patches? If 
so, could you always push that somewhere when posting the series (and 
mention it in the cover letter).

Not directly related to this series, but the series doesn't compile as 
modules, as drm_atomic_helper_colorop_create_state() is missing an export.

In an earlier version you had "drm/tidss: Switch to 
drm_mode_config_create_initial_state()". Isn't that still needed? 
Without it, the boot SRO is not done at all (which made me think you 
have additional patches in a local branch).

I think you have AM62-SK board without the OLDI display. Even without 
it, you can see what happens when OLDI is enabled by loading the 
k3-am625-sk-microtips-mf101hie-panel.dtbo overlay. You won't see 
anything displayed, of course, but otherwise it should load and work 
fine, and HDMI should continue working.

I've done some testing, and there are quite a lot of combinations to try 
out:

1) u-boot enables nothing, HDMI, OLDI or HDMI+OLDI, 2) OLDI dtbo loaded 
or not (i.e. kernel see HDMI or HDMI+OLDI), 3) drm.atomic_readout set to 
0 or 1, 4) a display pipeline's drivers (e.g. OLDI here) missing SRO 
support, but other pipelines have SRO, 5) the first use from the 
userspace is HDMI, OLDI or both, 6) with and without the 
drm_mode_config_create_initial_state().

So... It's quite a lot of combinations there, and laborious to test. I 
have some hack fixes in my local branch, and I'll try to find the time 
to organize them a bit so that I can share them.

But here are a few observations:

1)

Setup: No display in u-boot. OLDI dtbo not loaded. Only the 
drm_atomic_helper_colorop_create_state() fixup applied. Afaics behavior 
here should be exactly as before the series, as SRO is not enabled for 
tidss.

If I enable HDMI after boot, I get:

[   38.203024] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in mode_blob blobs don't match
[   38.203067] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and 
Readout CRTC state don't match
[  104.468776] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in connector_mask expected 1, got 0
[  104.468897] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in encoder_mask expected 1, got 0
[  104.468976] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in mode_blob blobs don't match
[  104.469047] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and 
Readout CRTC state don't match

If I do load OLDI dtbo or set atomic_readout=0, I don't see those, as 
SRO support gets disabled. My understanding of this issue is that the 
operation overall is fine, but the state comparison doesn't work quite 
right.

2)

Setup: HDMI+OLDI in u-boot. OLDI dtbo loaded. Only the 
drm_atomic_helper_colorop_create_state() fixup applied.

Enabling both displays after boot gives a sync lost flood and broken 
display output.

I think the issue here is that tidss does not reset the HW anymore (even 
if we don't call drm_mode_config_create_initial_state()), and the driver 
doesn't fully rewrite all the relevant DSS registers (or doesn't do it 
in a correct sequence, as it doesn't expect the VPs to be enabled at 
this point).

3)

Setup: No display in u-boot. OLDI dtbo loaded. 
drm_mode_config_create_initial_state() applied. So here we have HDMI 
pipeline, where drivers have SRO support, and OLDI, where they don't.

Loading the modules gives:

[   43.086356] tidss 30200000.dss: [drm] Device doesn't support hardware 
state readout.
[   43.086417] tidss 30200000.dss: Failed to set DSS PM to active
[   43.086429] tidss 30200000.dss: [drm] Couldn't reset dispc

Otherwise the displays seem to work ok.

4)

As 3) but HDMI+OLDI enabled at u-boot.

Same outputs at module load time. Using the displays break badly, 
probably because the driver doesn't re-program the registers fully.

5)

Setup: HDMI u-boot. OLDI dtbo not loaded. 
drm_mode_config_create_initial_state() applied. I think this is the 
setup you have been using.

No extra prints when loading modules. Running "kmstest -c hdmi" works 
fine, but prints:

[   62.464207] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in mode_blob blobs don't match
[   62.464252] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and 
Readout CRTC state don't match

and when exiting kmstest:

[   89.227700] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in connector_mask expected 1, got 0
[   89.227820] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in encoder_mask expected 1, got 0
[   89.227898] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in mode_blob blobs don't match
[   89.227969] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and 
Readout CRTC state don't match

Running kmsblank gives:

[  109.381641] tidss 30200000.dss: Timeout waiting for framedone on crtc 1
[  109.387107] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in enable expected yes, got no
[  109.387154] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in bus_format expected 0000100a, got 00000000
[  109.387181] tidss 30200000.dss: [drm] *ERROR* crtc-0 configuration 
mismatch in bus_flags expected 00000046, got 00000000
[  109.387205] tidss 30200000.dss: [drm] [CRTC:42:crtc-0] Committed and 
Readout CRTC state don't match
[  109.387227] tidss 30200000.dss: [drm] *ERROR* HDMI-A-1 configuration 
mismatch in crtc expected 00000000a0b1f61b, got 000000
[  109.387255] tidss 30200000.dss: [drm] *ERROR* HDMI-A-1 configuration 
mismatch in best_encoder expected 000000002b9c6290, g0
[  109.387286] tidss 30200000.dss: [drm] [CONNECTOR:44:HDMI-A-1] 
Committed and Readout connector state don't match
[  109.387306] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss 
configuration mismatch in input_bus_cfg.format expected 0
[  109.387332] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss 
configuration mismatch in input_bus_cfg.flags expected 00
[  109.387356] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss 
configuration mismatch in output_bus_cfg.format expected0
[  109.387380] tidss 30200000.dss: [drm] *ERROR* bridge-30200000.dss 
configuration mismatch in output_bus_cfg.flags expected 0
[  109.387403] tidss 30200000.dss: [drm] Committed and Readout private 
object state don't match
[  109.387420] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b 
configuration mismatch in input_bus_cfg.format expected 0000100
[  109.387444] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b 
configuration mismatch in input_bus_cfg.flags expected 00000040
[  109.387467] tidss 30200000.dss: [drm] *ERROR* bridge-1-003b 
configuration mismatch in output_bus_cfg.format expected 000010
[  109.387491] tidss 30200000.dss: [drm] Committed and Readout private 
object state don't match
[  109.387507] tidss 30200000.dss: [drm] *ERROR* bridge-connector-hdmi 
configuration mismatch in input_bus_cfg.format expecte0
[  109.387532] tidss 30200000.dss: [drm] *ERROR* bridge-connector-hdmi 
configuration mismatch in output_bus_cfg.format expect0
[  109.387555] tidss 30200000.dss: [drm] Committed and Readout private 
object state don't match

If I run kmsblank as the first thing after loading modules:

[   23.508008] tidss 30200000.dss: [drm] drm_WARN_ON_ONCE(!fb->obj[plane])
[   23.508210] WARNING: drivers/gpu/drm/drm_gem_framebuffer_helper.c:62 
at drm_gem_fb_get_obj+0xa4/0x120 [drm_kms_helper], CP5

  Tomi

