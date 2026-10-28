Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB4606A320
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XgaZ6u/+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B10710E6FF;
	Wed, 28 Oct 2026 21:44:41 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55B210E6E4
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793223873;
 bh=Qh2/y58GjNmfgNfLzXxQQQycPDPiBmIAsENzNFzOtmM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XgaZ6u/+qg+wZnzhUdgMaGYQEJojXomCpAheWyEyY0TWE42dHMXpYs08vJadlyxLh
 fO53a49IwboAtbVeyrkZZJJCAqCLiYdt9iSNer45oU9ovf58TeLVt6cfcQiEIqRRn8
 lBkf9sHPCb9bPYlqUf4qc4sQyCJbRMj1Uxr7MlIoLdd3tLKHesIOwZ+uJIDKgKC3S6
 H+qLtimEk+tGAtvYGYOeBrfSLUlpEnp04GsxrYZrBB15RlE8wBH0ri+3+OErrRG9g4
 sVmfszSPBxWoBjKARHw8qAxx/jWMyri1UUJa3y3jrtIEjD9q5iXzmhP9gHfGXi+WTi
 gpXr3JeDowJIg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 92BFC17E04C7;
 Wed, 28 Oct 2026 22:44:32 +0100 (CET)
Message-ID: <8b1b7d8d-9656-4b3b-9f83-1526c8110ab7@collabora.com>
Date: Wed, 28 Oct 2026 23:44:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
 <45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maíra,

On 10/27/26 3:35 PM, Maíra Canal wrote:
> Hi Cristian,
> 
> On 13/10/26 22:03, Cristian Ciocaltea wrote:
>> Replace driver local scrambling logic with the newly introduced common
>> HDMI 2.0 scrambling support:
>>
>> - Advertise source-side scrambling capability by setting supported HDMI
>>    version based on the variant's max_pixel_clock.
>>
>> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>>    only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>>    sink-side SCDC programming and periodic status monitoring to
>>    drm_connector_hdmi_{enable,disable}_scrambling().
>>
>> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>>    the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>>    which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>>    CRTC reset on reconnection.
>>
>> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>>    flag, now tracked by the common drm_connector_hdmi layer, as well as
>>    the now unused output_{bpc,color_format} driver data members.
>>
>> No functional change intended.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_hdmi.c | 230 +++++------------------------------------
>>   drivers/gpu/drm/vc4/vc4_hdmi.h |  21 ----
>>   2 files changed, 28 insertions(+), 223 deletions(-)
>>
> 
> [...]
> 
>>   +    /*
>> +     * Since we don't know the state of the controller and its
>> +     * display (if any), let's assume it's always enabled.
>> +     * drm_connector_hdmi_disable_scrambling() will thus run at boot,
>> +     * make sure it's disabled, and avoid any inconsistency.
>> +     */
>> +    connector->hdmi.scrambler_enabled = drm_connector_hdmi_scrambler_supported(connector);
>> +
> 
> I'm okay merging this series to drm-misc-next, but I believe that
> Sashiko's report has a point about this chunk. If the display if off or
> disconnected, the boot-time disable would never run. Could you please
> take a look at it?

Thanks for checking this out!

I initially overlooked Sashiko's finding, as it only complains about a
theoretical display flicker - the conditions required to hit it are quite
narrow, all of which must hold at once:

- an HDMI 2.0-capable source, so RPi 0..3 are out
- nothing active at boot, so that vc4_crtc_disable_at_boot() bails out early and
  no boot-time disable runs
- a sink advertising SCDC + scrambling (i.e. 4k60-capable) which nevertheless
  gets a first modeset with a mode that does not need scrambling - pretty
  unusual, since the preferred mode is normally the highest supported one

Eventually the reset's disable leg clears the flag, so it's a single flicker and
the state self-corrects from then on.

Other than this one-time glitch, the driver conversion should preserve the
original behaviour.  The thing is that vc4 kind of abuses the common API, since
normally connector->hdmi.scrambler_enabled is not supposed to be flipped
manually.

Regardless, I think we can handle this by making drm_connector_hdmi_sync_scdc()
rely on the committed connector state rather than on the current source-side
scrambler status, i.e. conn_state->hdmi.scrambler_needed, which is computed
during atomic check and correctly describes the active mode.

> Also, while greping the code, one thing caught my attention:
> drm_connector_hdmi_disable_scrambling() is called at
> vc4_crtc_disable_at_boot() before drm_dev_register(). Does that mean
> that connector->status might be connector_status_unknown at that point?
> I'm concerned due to the last if-block in
> drm_connector_hdmi_disable_scrambling(). Am I mistaken?

You're not mistaken: connector->status is expected to indicate
connector_status_unknown, while connector->display_info should be empty as well,
since no EDID has been read yet.  Hence, the sink-side SCDC writes are skipped -
only the source-side clear and the flag reset happen.

That is indeed a behavioral difference, as the pre-conversion
vc4_hdmi_disable_scrambling() had no such guards and issued the SCDC writes
unconditionally:

- with no display connected, the old code poked a non-existent sink and the I2C
  transfer simply NAK'ed, so skipping it is arguably better

- with a display connected and SCDC scrambling pre-enabled, the old code did
  clear the sink's scrambling, while the new one doesn't - if the first kernel
  modeset then picks a mode below 340 MHz, the sink could in theory be left
  trying to descramble unscrambled data

The second case also seems unlikely, as HDMI 2.0 sinks are expected to reset the
SCDC configuration when the connection is lost, while scrambling should be
disabled by default until the source enables it via SCDC.

A more realistic risk is the sink's state being left with scrambling enabled by
the board firmware before the kernel boots.  Probability-wise it needs the same
unlikely ingredient: the first kernel modeset picking a non-scrambled mode while
the firmware had a scrambled one.  The usual outcome is the same preferred 4k60
mode being selected, so enable_scrambling() reprograms the sink as needed.

Rather than issuing the SCDC writes blindly at boot, which would mean DDC
traffic towards a possibly absent sink, we should reset the sink status from
drm_connector_hdmi_enable_scrambling() when the committed state requires no
scrambling.  At that point the sink has been probed and its capabilities parsed,
so the operation is safe:

-       if (!conn_state->hdmi.scrambler_needed)
+       if (!conn_state->hdmi.scrambler_needed) {
+           drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
+
+           if (config & SCDC_SCRAMBLING_ENABLE)
+                   drm_scdc_set_scrambling(connector, false);
+
+           if (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40)
+                  drm_scdc_set_high_tmds_clock_ratio(connector, false);
+
            return 0;
+       }

I'm going to test both fixes and send them out as a separate series, so we're
not blocking on it.

Regards,
Cristian
