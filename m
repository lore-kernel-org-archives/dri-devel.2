Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4F1C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD5310E7CF;
	Tue, 28 Jul 2026 07:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h0fJFTBR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5D610E7CF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785224747; x=1816760747;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=Qwwo+RjO5/E+/gdt7oUP1BpkpYefVSpeX8tj12d2Y98=;
 b=h0fJFTBRwNMCprOp3SdVZ3I1behbyCI5Tef6v+AsucG3euTnu8wPj2Ti
 TrPsZ82WA9yQ0zBRzsqHWaSnJzVANoyXy0GYbWFjLfG33x/kphaayKPb/
 KzFMZ1v9NMkAZeHdxiebICJqjONz+ODzAO22MZSfnmA1hUBqAsDOj7GQi
 24hs2K4mZyYwUKn1WwlnNj479cSR8nm5c3nCSB1qv1EcbVE3lazIQwSTf
 KXyAEak2jGmMHJL8RdBgVCBMzX8nfZLUH5AZAfvIJV3tfS0GegydZuOEp
 viJg05o9eEXUrAQMTn2pxMxxviFrEWObn55Ok4AbIBzheIlTMv/KGBr3a g==;
X-CSE-ConnectionGUID: jrkHyZtYSOiUN7TdSnhOag==
X-CSE-MsgGUID: j937uSs/S86QStoSFdwJ1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85670790"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85670790"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:45:45 -0700
X-CSE-ConnectionGUID: CzO3WoOrS4OdZoKto+PKIQ==
X-CSE-MsgGUID: c46EBBmlTvuz1ZaGKmwAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="256292800"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:45:39 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>, Hans Verkuil
 <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Samuel
 Holland <samuel@sholland.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] Add SCDC information to connector debugfs
In-Reply-To: <EDiHBw8XQg-RsxQIQVIjig@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
 <1c9d3a50341129188242b1b2758fcee5eab243db@intel.com>
 <EDiHBw8XQg-RsxQIQVIjig@collabora.com>
Date: Tue, 28 Jul 2026 10:45:37 +0300
Message-ID: <f18b084c3b6372da4c9e5a779696edc599a9f0a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 27 Jul 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> =
wrote:
> On Monday, 27 July 2026 10:35:15 Central European Summer Time Jani Nikula=
 wrote:
>> On Fri, 24 Jul 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.co=
m> wrote:
>> > HDMI uses the DDC I2C bus for communicating various bits of link status
>> > out of band with the actual HDMI video signal. This information can be
>> > useful for debugging issues like questionable cables sabotaged by feli=
ne
>> > teeth, Enthusiast Grade cables made of cow fencing wire, and other such
>> > problems that ruin one's media viewing plans.
>> >
>> > Consequently, this series exposes various bits of pertinent information
>> > from the SCDC protocol in an HDMI connector's debugfs. To continually
>> > poll the link status, userspace can poll the debugfs file.
>>=20
>> Is there a reason we can't add a character device node for this similar
>> to DP AUX? See config DRM_DISPLAY_DP_AUX_CHARDEV.
>
> You already can just point tools at the ddc symlink to the i2c dev.
>
> The idea here is to be able to read this out of debugfs without
> any additional external tooling needed.

Fair enough, thanks.

BR,
Jani.

>
>> It's ultimately more generic than deciphering everything in kernel.
>
> The kernel will need to decipher this in the future anyway for HDMI 2.x
> support, including so that it can set link status to bad when there's a
> glut of errors.
>
>>=20
>>=20
>> BR,
>> Jani.
>>=20
>>=20
>>=20
>>=20
>>=20
>> >
>> > ---
>> > Changes in v9:
>> > - Unlock mode_config.mutex on disconnected connector early exit
>> > - Calculate and print Reed-Solomon error corrections counter on !=3D 4
>> >   lane FRL as well. Technically a functional change to an already
>> >   reviewed patch, but I kept the R-b because it's so minor.
>> > - Link to v8: https://patch.msgid.link/20260722-scdc-link-health-v8-0-=
cd1dacbb85d9@collabora.com
>> >
>> > Changes in v8:
>> > - Acquire mode_config mutex in an interruptible way during
>> >   scdc_status_show to avoid racing connector state
>> > - Remove scdc_debugfs_priv, use connector as debugfs entry priv instead
>> > - Allocate and free state in scdc_status_show, since it doesn't need to
>> >   persist across debugfs reads
>> > - Check for NULL ddc in drm_scdc_read_state in the unlikely event an
>> >   EDID with the SCDC flag was forced on a connector with no DDC
>> > - Note: drm_connector_get() is omitted from drm_scdc_debugfs_init
>> >   because drm_scdc_debugfs_init is called on connector construction and
>> >   the debugfs is removed on connector destruction. Adding a redundant
>> >   reference increase here would necessitate introducing a destruction
>> >   callback to mirror the debugfs_init connector op for the sole purpose
>> >   of decreasing the counter again.
>> > - Link to v7: https://patch.msgid.link/20260721-scdc-link-health-v7-0-=
92df1b6ad5fc@collabora.com
>> >
>> > Changes in v7:
>> > - Move HDMI debugfs registration to new state helper, fix up all users
>> >   (sun4i, vc4, bridge)
>> > - Register scdc debugfs in new hdmi debugfs helper
>> > - Link to v6: https://patch.msgid.link/20260611-scdc-link-health-v6-0-=
6307875a6b5e@collabora.com
>> >
>> > Changes in v6:
>> > - Fix off-by-one error in drm_scdc_read_state
>> > - Link to v5: https://patch.msgid.link/20260604-scdc-link-health-v5-0-=
11173b0ac3de@collabora.com
>> >
>> > Changes in v5:
>> > - Read all SCDC data regardless of update flags
>> > - Dump SCDC data as hex before the human-readable output. It's separat=
ed
>> >   with "\n----------------\n\n".
>> > - No longer write 0 to read-only registers
>> > - Add Reed-Solomon Corrections counter parsing
>> > - Parsing has been kept. A desire was expressed to get this data witho=
ut
>> >   any external userspace tooling, and the kernel will need to parse it
>> >   eventually anyway to set the link status.
>> > - Functions have been made static as of right now, since external users
>> >   may do another pass over the function signatures anyway.
>> > - Link to v4: https://patch.msgid.link/20260527-scdc-link-health-v4-0-=
622ea40a1f59@collabora.com
>> >
>> > Changes in v4:
>> > - Don't use C struct bitfields for parsing status flags. Switch to
>> >   bitwise AND for boolean flags, and FIELD_GET for multi-bit values.
>> > - Drop the superfluous !! and parens
>> > - Drop the __pure attributes on static functions
>> > - Initialise stack local arrays with {}, not { 0 }.
>> > - I've kept the print macros and %-30s format. Reason being that I don=
't
>> >   want to repeat the format specifier and str_yes_no(foo) a bunch, and=
 I
>> >   like the %-30s format because it means all values are aligned with t=
he
>> >   value of the longest field, which is 30 chars long.
>> > - Link to v3: https://patch.msgid.link/20260526-scdc-link-health-v3-0-=
59e4a4aaead1@collabora.com
>> >
>> > Changes in v3:
>> > - Add patch to change return type of drm_scdc_read/write.
>> > - Rework error counter reading to duplicate less code.
>> > - Also check lane 3 counter valid flag when reading its error counter.
>> > - Use memset to clear buf for error counters, rather than doing it in
>> >   the loop.
>> > - Make read_error_counters not accept 0 as num_lanes; fix it up in the
>> >   caller instead.
>> > - Link to v2: https://patch.msgid.link/20260520-scdc-link-health-v2-0-=
511af18cd64b@collabora.com
>> >
>> > Changes in v2:
>> > - Add HDMI 2.1 SCDC status reporting
>> > - Link to v1: https://patch.msgid.link/20260415-scdc-link-health-v1-0-=
8e731e88eaf0@collabora.com
>> >
>> > To: Jani Nikula <jani.nikula@linux.intel.com>
>> > To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > To: Maxime Ripard <mripard@kernel.org>
>> > To: Thomas Zimmermann <tzimmermann@suse.de>
>> > To: David Airlie <airlied@gmail.com>
>> > To: Simona Vetter <simona@ffwll.ch>
>> > To: Andrzej Hajda <andrzej.hajda@intel.com>
>> > To: Neil Armstrong <neil.armstrong@linaro.org>
>> > To: Robert Foss <rfoss@kernel.org>
>> > To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> > To: Jonas Karlman <jonas@kwiboo.se>
>> > To: Jernej Skrabec <jernej.skrabec@gmail.com>
>> > To: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> > To: Daniel Stone <daniel@fooishbar.org>
>> > To: Hans Verkuil <hverkuil+cisco@kernel.org>
>> > To: Chen-Yu Tsai <wens@kernel.org>
>> > To: Samuel Holland <samuel@sholland.org>
>> > To: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> > To: Ma=C3=ADra Canal <mcanal@igalia.com>
>> > To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
>> > Cc: dri-devel@lists.freedesktop.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: kernel@collabora.com
>> > Cc: linux-arm-kernel@lists.infradead.org
>> > Cc: linux-sunxi@lists.linux.dev
>> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> >
>> > ---
>> > Nicolas Frattaroli (5):
>> >       drm/scdc-helper: Don't use ssize_t return type for scdc_read/wri=
te
>> >       drm/scdc-helper: Add scdc_status debugfs entry
>> >       drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
>> >       drm/debugfs: Move HDMI debugfs registration to state helper
>> >       drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI
>> >
>> >  drivers/gpu/drm/display/drm_bridge_connector.c  |   3 +
>> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 156 +++++++++++++
>> >  drivers/gpu/drm/display/drm_scdc_helper.c       | 289 +++++++++++++++=
++++++++-
>> >  drivers/gpu/drm/drm_debugfs.c                   | 157 -------------
>> >  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          |   1 +
>> >  drivers/gpu/drm/vc4/vc4_hdmi.c                  |   1 +
>> >  include/drm/display/drm_hdmi_state_helper.h     |   3 +
>> >  include/drm/display/drm_scdc.h                  |  21 +-
>> >  include/drm/display/drm_scdc_helper.h           | 103 ++++++++-
>> >  9 files changed, 568 insertions(+), 166 deletions(-)
>> > ---
>> > base-commit: b747a63003130bef1a3d5d6ba97c94d0cee36f55
>> > change-id: 20260413-scdc-link-health-89326013d96c
>> >
>> > Best regards,
>> > --=20=20
>> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> >
>>=20
>>=20
>
>
>
>

--=20
Jani Nikula, Intel
