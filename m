Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B99C5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C78D89B62;
	Tue, 11 Aug 2026 01:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="VPKcsr9f";
	dkim-atps=neutral
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA72789B62
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:22:19 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oFEc+/+OrOZEpAInr6c6BnICqnyY1xFJl7g53sdqgPg=;
 b=VPKcsr9fBKPgaglLI0HArPC+z5DitiGPHliBlmlMSyAiFb1RCzV4ed3NRfabwU7+yCj4d7m4G
 9xFxWetg42BMf3GJmBxepx9i1xMd4ARmkVxM/tV165j7zjVw/QHG1klBrH5E125x6+30T4TMFzl
 o9lzKJQC8OYfZpa6swrQHlE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hJtqw07TXzLlXB;
 Tue, 11 Aug 2026 09:11:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A77D4057A;
 Tue, 11 Aug 2026 09:22:16 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 09:22:15 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 09:22:15 +0800
Message-ID: <a48e0b33-7eab-478e-a396-b6e76b7a066f@huawei.com>
Date: Tue, 11 Aug 2026 09:22:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongbang Shi <shiyongbang@huawei.com>
Subject: [RFC] drm/client: Relax clone mode selection in
 drm_client_target_cloned
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <liangjian010@huawei.com>, <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, 
 <helin52@h-partners.com>, <shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

Hi all,

This is a design-only RFC to solicit feedback on a proposed relaxation of the
cloned-modeset selection logic in the DRM fbdev client. No patch is attached;
pseudocode only.

Background and motivation

On the HiBMC SoC (drivers/gpu/drm/hisilicon/hibmc, a dual-output VGA +
DP PCI display device, single CRTC, clone output) we observe the following
call chain during fbdev client hotplug:

+-----------------------------+
|  drm_fbdev_client_hotplug   |
+-----------------------------+
               |
               v
+-----------------------------+
| drm_fb_helper_hotplug_event |
+-----------------------------+
               |
               | fb_helper->fb(640x480)  <derived from vga GRUB>
               v
+-----------------------------+
|   drm_client_modeset_probe  |
|   <width=640, height=480>   |
+-----------------------------+                   +-------------------+
               |                                   | DP probed modes:  |
               v                                   |  "640x480" 25200  |
+-----------------------------------+             |  "640x480" 25175  |
|         .fill_modes               |             |                   |
| <Rejected other modes: VIRTUAL_X> |-------------| VGA probed modes: |
+-----------------------------------+             |  "640x480" 25175  |
               |                                   +-------------------+
               v
+-----------------------------+           +---------------------------------+
|  drm_client_target_cloned   | --------> | drm_connector_pick_cmdline_mode |
+-----------------------------+           |         + drm_mode_match        |
                                           |            <No dp GRUB>         |
                                           +---------------------------------+
                                                           |
                                                           | fail
                                                           v
                                         +-------------------------------------+
                                         |           DMT(1024x768)             |
                                         |  <Already rejected in .fill_modes>  |
                                         +-------------------------------------+
                                 fail                      |
               ---------------------------------------------
               |       can_clone = false; <can't enable cloning when we probably wanted to.>
               v
+-----------------------------+
| drm_client_target_preferred |
|     <dp: 640x480 25200>     |
|     <vga: 640x480 25175>    |
+-----------------------------+
               |
               v
+-----------------------------+
|    drm_client_pick_crtcs    |
|    <drm_mode_equal fail>    |
+-----------------------------+

   * GRUB brings the console up at 640x480 on the VGA connector, so the fbdev
     client is probed with width=640, height=480.
   * The VGA connector gets a command-line mode of 640x480@25175 (derived
     from the GRUB framebuffer).
   * The DP connector has *no* command-line mode, but its probed mode list
     contains "640x480" 25200, "640x480" 25175, "640x480" 25175.
   * VGA's probed mode list contains "640x480" 25175.

The current drm_client_target_cloned() requires *every* enabled connector to
have a command-line mode, and all of them to be equal. Because DP has none,
this path fails immediately. The fallback then tries to find DMT 1024x768 on
every connector, but on this hardware 1024x768 has already been rejected in
drm_mode_prune_invalid() (VIRTUAL_X), so the fallback fails too. The code
prints "kms: can't enable cloning when we probably wanted to." and falls
through to drm_client_target_preferred(), which independently picks
"640x480" 25200 for DP and "640x480" 25175 for VGA. Those two modes are not
drm_mode_equal(), so drm_client_pick_crtcs() cannot place both connectors on
the single CRTC and one output ends up disabled.

The net effect: even though both connectors advertise a perfectly good
640x480@25175 mode, clone setup fails because (a) the command-line check
insists on every connector having a cmdline mode and (b) the only fallback
is a hardcoded 1024x768 that this hardware cannot scan out.

Proposed design (pseudocode)

The idea is to relax the mode-selection part of drm_client_target_cloned()
to handle three cases, in order, before the existing 1024x768 fallback:

   Case 1 — All enabled connectors have a cmdline mode and they are all
            equal. Clone succeeds. (Existing behaviour; unchanged.)

   Case 2 — Some enabled connectors have a cmdline mode and all such cmdline
            modes are equal. For every enabled connector WITHOUT a cmdline
            mode, look the shared cmdline mode up in that connector's probed
            mode list. If every connector without a cmdline mode has a
            matching probed mode, clone succeeds.

   Case 3 — No enabled connector has a cmdline mode. Walk the first enabled
            connector's probed mode list and, for each candidate, check that
            every other enabled connector has a drm_mode_match() equivalent
            in its probed list. The first candidate present on all
            connectors wins.

Pseudocode:

   drm_client_target_cloned(dev, connectors, connector_count,
                            modes, offsets, enabled, width, height):
       // --- existing guards, unchanged ---
       if dev->mode_config.num_crtc > 1:
           return false
       count = number of enabled connectors
       if count <= 1:
           return false

       // --- Phase 1: classify cmdline modes ---
       common_cmdline_mode = NULL
       have_cmdline_mode = false
       have_no_cmdline_mode = false
       can_clone = true

       for each enabled connector i:
           modes[i] = drm_connector_pick_cmdline_mode(connectors[i])
           if modes[i] != NULL:
               have_cmdline_mode = true
               if common_cmdline_mode == NULL:
                   common_cmdline_mode = modes[i]
               else if not drm_mode_match(modes[i], common_cmdline_mode,
                           TIMINGS | CLOCK | FLAGS | 3D_FLAGS):
                   can_clone = false
                   break
           else:
               have_no_cmdline_mode = true

       // --- Case 1: all have same cmdline mode ---
       if can_clone and have_cmdline_mode and not have_no_cmdline_mode:
           return true

       // --- Case 2: partial cmdline, resolve the rest from probed lists ---
       if can_clone and have_cmdline_mode and have_no_cmdline_mode:
           for each enabled connector i without a cmdline mode:
               modes[i] = NULL
               for each mode M in connectors[i]->modes:
                   if drm_mode_match(M, common_cmdline_mode,
                           TIMINGS | CLOCK | FLAGS | 3D_FLAGS):
                       modes[i] = M
                       break
               if modes[i] == NULL:
                   can_clone = false
                   break
           if can_clone:
               return true

       // --- Case 3: no cmdline mode anywhere, find a common probed mode ---
       if not have_cmdline_mode:
           first = index of first enabled connector
           for each candidate mode M in connectors[first]->modes:
               can_clone = true
               modes[first] = M
               for each other enabled connector j:
                   modes[j] = NULL
                   for each mode P in connectors[j]->modes:
                       if drm_mode_match(P, M,
                               TIMINGS | CLOCK | FLAGS | 3D_FLAGS):
                           modes[j] = P
                           break
                   if modes[j] == NULL:
                       can_clone = false
                       break
               if can_clone:
                   return true
               // else: reset all modes[] and try next candidate

       // --- clean up before fallback ---
       for each enabled connector i:
           modes[i] = NULL

       // --- existing 1024x768 DMT fallback, unchanged ---
       ...
       // --- existing failure message, unchanged ---
       drm_info(dev, "kms: can't enable cloning when we probably wanted to.")
       return false

Only the mode-selection logic is touched. The single-CRTC guard, the
>1-enabled-connector guard, the 1024x768 fallback, and the failure message
are all kept. Matching uses DRM_MODE_MATCH_TIMINGS | CLOCK | FLAGS |
3D_FLAGS — the same set the original code already uses — so two modes that
the rest of the DRM client considers "the same mode" are treated as
clone-compatible here too.

No UAPI change. No new helper. No change to drm_connector_pick_cmdline_mode,
drm_client_target_preferred, or drm_client_pick_crtcs.

RFC-specific questions

I am specifically looking for feedback on:

   * Whether case 2 (partial cmdline, look up shared cmdline mode in
     probed lists) is the right boundary, or whether the community would
     prefer the fbdev client to stay strict and require cmdline modes on
     all connectors.

   * Whether case 3 (no cmdline mode at all, search for a common probed
     mode) is acceptable in principle, or whether the community would
     prefer to keep that case relying solely on the 1024x768 fallback.

   * Whether the candidate-walk in case 3 (first enabled connector's
     modes, first match wins) is the right selection policy, or whether
     a "preferred mode first" / "largest mode" policy would be better.
     The simple "first found" style mirrors the existing 1024x768
     fallback.

   * Naming suggestions for the shared cmdline mode and presence-tracking
     variables, if/when this becomes a formal patch.

For now the prototype is against v7.2.0 of the local tree.

Comments very welcome.

Thanks,
Yongbang.
