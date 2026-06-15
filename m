Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF2CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E77210E269;
	Mon, 15 Jun 2026 08:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JHKXE+LQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C811A10E269
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781510831; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LXJRAPjpPrnCwXEkDKSLW+4t2pEnG8XjF6IAF4z2QXe6hBba1gSrv8ffEE66eFsWvViRvTJyp9FTt9vdUQkqOv1kQZHil6mWFH73VxVSAPiYLF8Q8yD6cPoQeU2ecKGccuV8hNs/yJyqETkv8XEAzEZZgBOe0k2/CCz+wW1C8QI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781510831;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=08kfZVSxp3naC+h603GxRouyMYaFpiybxyIxzJqCKl4=; 
 b=IDXlk3JdiH6CUF8VoXGD/IFOjF4PzImQ4j2nm2QjmM5ANa65DLN/FDZSWHWLYw/tNZt2hNNtA0QLv73l9I8v+uMwf9myW+z0RJ1wUZdyl7AVogVIv1tidrZZaMd+dtDNKBWlmVuvttNGbvUiQG+fCpvF3dWJ5E8pGsbbPAB4Fp0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781510831; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=08kfZVSxp3naC+h603GxRouyMYaFpiybxyIxzJqCKl4=;
 b=JHKXE+LQN37LgAK06TRGpDBT5lisETwH/soBRwHxi2OW0D2PVM6MxLoJgPqPpQlW
 yDUy45bOIOnx7JZXq1baJG/ENoIIcoWM74Zlj8SYG+KHCP6uoHioGXQfd1oWreVmFgu
 wUTejWpfV9DCP1D+DXieEulCoOXJdX6QOYUV5JWs=
Received: by mx.zohomail.com with SMTPS id 1781510829642670.2269836841601;
 Mon, 15 Jun 2026 01:07:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>, Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v6 0/4] Add SCDC information to connector debugfs
Date: Mon, 15 Jun 2026 10:07:02 +0200
Message-ID: <5DBSVhedT12K_nGj0amyCw@collabora.com>
In-Reply-To: <ae219b64-c8ce-4798-995a-cd8fdd74d8a4@kernel.org>
References: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
 <ae219b64-c8ce-4798-995a-cd8fdd74d8a4@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Saturday, 13 June 2026 08:57:29 Central European Summer Time Hans Verkuil wrote:
> Hi Nicolas,
> 
> On 11/06/2026 14:57, Nicolas Frattaroli wrote:
> > HDMI uses the DDC I2C bus for communicating various bits of link status
> > out of band with the actual HDMI video signal. This information can be
> > useful for debugging issues like questionable cables sabotaged by feline
> > teeth, Enthusiast Grade cables made of cow fencing wire, and other such
> > problems that ruin one's media viewing plans.
> > 
> > Consequently, this series exposes various bits of pertinent information
> > from the SCDC protocol in an HDMI connector's debugfs. To continually
> > poll the link status, userspace can poll the debugfs file.
> 
> Something is not quite right: I've been testing this series with my i915
> based laptop with HDMI connector, and I never see the scdc_status file.
> And that's because CONFIG_DRM_BRIDGE_CONNECTOR is not set for my configuration.

That's to be expected. i915 does not use bridge connectors, and neither
does amdgpu iirc. I am working on embedded boards that do use bridge
connectors, along with all the rest of the HDMI state helpers.

Implementing something new in DRM usually involves having to triplicate
certain parts of the work in order to have i915 and amdgpu behave the
same as everyone else.

> So I think you are creating the debugfs entry in the wrong place.

I can't create it for all drm_connectors as Maxime suggested due to the
cyclical dependency that would create. If someone has any idea on how
to break that dependency cycle, I'm open to suggestions.

> I can read the SCDC from the display using edid-decode with the right /dev/i2c-X
> device, so it's definitely there.
> 
> Regards,
> 
> 	Hans
> 
> > 
> > ---
> > Changes in v6:
> > - Fix off-by-one error in drm_scdc_read_state
> > - Link to v5: https://patch.msgid.link/20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com
> > 
> > Changes in v5:
> > - Read all SCDC data regardless of update flags
> > - Dump SCDC data as hex before the human-readable output. It's separated
> >   with "\n----------------\n\n".
> > - No longer write 0 to read-only registers
> > - Add Reed-Solomon Corrections counter parsing
> > - Parsing has been kept. A desire was expressed to get this data without
> >   any external userspace tooling, and the kernel will need to parse it
> >   eventually anyway to set the link status.
> > - Functions have been made static as of right now, since external users
> >   may do another pass over the function signatures anyway.
> > - Link to v4: https://patch.msgid.link/20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com
> > 
> > Changes in v4:
> > - Don't use C struct bitfields for parsing status flags. Switch to
> >   bitwise AND for boolean flags, and FIELD_GET for multi-bit values.
> > - Drop the superfluous !! and parens
> > - Drop the __pure attributes on static functions
> > - Initialise stack local arrays with {}, not { 0 }.
> > - I've kept the print macros and %-30s format. Reason being that I don't
> >   want to repeat the format specifier and str_yes_no(foo) a bunch, and I
> >   like the %-30s format because it means all values are aligned with the
> >   value of the longest field, which is 30 chars long.
> > - Link to v3: https://patch.msgid.link/20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com
> > 
> > Changes in v3:
> > - Add patch to change return type of drm_scdc_read/write.
> > - Rework error counter reading to duplicate less code.
> > - Also check lane 3 counter valid flag when reading its error counter.
> > - Use memset to clear buf for error counters, rather than doing it in
> >   the loop.
> > - Make read_error_counters not accept 0 as num_lanes; fix it up in the
> >   caller instead.
> > - Link to v2: https://patch.msgid.link/20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com
> > 
> > Changes in v2:
> > - Add HDMI 2.1 SCDC status reporting
> > - Link to v1: https://patch.msgid.link/20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com
> > 
> > To: Jani Nikula <jani.nikula@linux.intel.com>
> > To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > To: Maxime Ripard <mripard@kernel.org>
> > To: Thomas Zimmermann <tzimmermann@suse.de>
> > To: David Airlie <airlied@gmail.com>
> > To: Simona Vetter <simona@ffwll.ch>
> > To: Andrzej Hajda <andrzej.hajda@intel.com>
> > To: Neil Armstrong <neil.armstrong@linaro.org>
> > To: Robert Foss <rfoss@kernel.org>
> > To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > To: Jonas Karlman <jonas@kwiboo.se>
> > To: Jernej Skrabec <jernej.skrabec@gmail.com>
> > To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > To: Daniel Stone <daniel@fooishbar.org>
> > To: Hans Verkuil <hverkuil+cisco@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kernel@collabora.com
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > ---
> > Nicolas Frattaroli (4):
> >       drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
> >       drm/scdc-helper: Add scdc_status debugfs entry
> >       drm/display: bridge_connector: init scdc debugfs for HDMI
> >       drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
> > 
> >  drivers/gpu/drm/display/drm_bridge_connector.c |   4 +
> >  drivers/gpu/drm/display/drm_scdc_helper.c      | 285 ++++++++++++++++++++++++-
> >  include/drm/display/drm_scdc.h                 |  21 +-
> >  include/drm/display/drm_scdc_helper.h          | 103 ++++++++-
> >  4 files changed, 404 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 4fdfaadba04dc0f2f2490dbc91922caa290463a5
> > change-id: 20260413-scdc-link-health-89326013d96c
> > 
> > Best regards,
> > --  
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> 
> 




