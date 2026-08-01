Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F52C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A7B10E124;
	Sat,  1 Aug 2026 19:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=behler.me header.i=@behler.me header.b="Gfz8Z8zX";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F8E10E353
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 16:05:48 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-664c6304683so1847581d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 09:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785600347; cv=none;
 d=google.com; s=arc-20260327;
 b=JxcaruL6Ul2bQl3KrygVnnS1Tp0JYFRKcfTOwHdjoDDSaewcsx3pfgETFCLfeabxiC
 0zijEuK4AQKhwJPxIfwqrZlKe0ZqGEIWia+EeBnLpdfF/mXtOS89n8GwrbuoKhCYF7Wc
 dXUwenlJYSKG1vV0ga3aaZ2l04gN5rXVMHxzaDMGqTcewL63g9ozyWRsWWNoC7S0rcqM
 9i6ZUZ0UHuiTq+zZX1o17xNvPGhe+6OPGNw5PKyQcpGqfu6A8xhwxwQ0MuMNCpYTmMvv
 zIxd+/lE7EGTktDKTCQ1apNuIVkW2HETYOW/14oO+aIZnBme9QQMwFZAzaqRhBQcxJiA
 go+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XMV4g3BZPpWE/yWFeGUE5X630AsemOBuxoyOXwBAQaM=;
 fh=R6Ugg4jrxGyRwI3DiEtBkxT4xU9zo6eL5TU+puonQXw=;
 b=R+nzEmE2AhEaNloBUYiZ3fw8sVjL/6JPTxvzcsuXE7rmCFtRaYGB3YHpu3EMkrZAWk
 krOqfb9CXM2OuV9uKixOyL8VT+aPY6EcJRh3mDcGRsYYvONwT68dEXpnj2bVtBRGSCnD
 zNqlC8GVIPU+aVCyJmGK42kuPSYe7Cv/gDcmA50Olnw0IVCi4c7+JCgoJxR03qJSWn/m
 CmnN4dIiVHk2+XA3vBr/Ev21Ty0e05t0AsNk2IyqtXK7zOd3yPNxlusNeNYIhHVCBiI+
 XDOS9Ixm/tHW53lLsub7d8lKRE+1ZyP9xXkx05AZkGy2HC44H5BlYiyYhYRuHvs0xYbI
 0Vnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=behler.me; s=google; t=1785600347; x=1786205147; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XMV4g3BZPpWE/yWFeGUE5X630AsemOBuxoyOXwBAQaM=;
 b=Gfz8Z8zX9aHnwnWX+W2HigGng3gEeV6KH6ySIbPDBKQVKhMYCd4KJbf+pTm1R+ylTT
 ovRnD3A+4a0mAZ3YK+GL9ZABGu+i3V5nnvTtFIk73icynxrzJ1kC1hbHiK2Z9BP+4BwC
 kY3kiKQLF/T51l0H+1rq8J/RcDZ62+bI3j5SkFGt6pbhI0COzwpJDrvHuFoR2SP+a41T
 BcSOROwnJ0N81GOcXgV0ha/za1PM0o4jTq1Uud7/7/yNX+VJPcMbRKH6oNtdJIW3VZdN
 j/bvVeRhNGIixX/2RE+4H1YIh13s2SAJxu0JXAwCstoVR3wiqDtOgEZRf1xtwm08ZoZv
 9Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785600347; x=1786205147;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XMV4g3BZPpWE/yWFeGUE5X630AsemOBuxoyOXwBAQaM=;
 b=YZNCn71RSQ58frPIVDMtU/gip+EVUC/X4IGNPXA6QrCicbSzi7M2/Qf0QRQXclZuJI
 NcYRQAB0v0U5c8fuR3om6sR81YEECzTn12+v5S1iXfLz0EfawyRNCJsA8RENdqxwK/yJ
 Pe4amOtHqzaBC+YwDMrVqXN5a6VRok2yuH4yO7Rz2T6KxCKRr4OCD9VYRB9ObVCo7EDs
 UFQ9ThpatDg45IVFYQDp0o924EiJWG0BlZBi2YSUWe5xhMdxD3pftCqUFs1sJl3JqsOU
 g4yeUjqJ7LZ9Cz2t1HS+i7yrAnmGXXcawn/Q3CbHBtprX6d9mja9KXLA3Y/JV9gsKPv/
 ZiWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6vqA+6XrpFh4dA51E+azxM4WQwL580zg9pzr9WXmJ5K24B2qP2cZvh8HETCNdpOKXAFxp9/4Z3ks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNPKsjadNY64BF2J7ABMkJxQ8o8TEePd1nTq4O7b8QfHBmQuSV
 5iugg+mh1Qdx5XIMCtduvbdp+PyWRNCIrDFaIud8YafwXzVK840x321nc23PBGHmdFsOcfKsDnX
 2ffzhlDu2UCepyPuPOIVji0OdQWFzhDfnhWevps1rPg==
X-Gm-Gg: AR+sD11naJ2i50u9kaAui2knXe81QsZOf9S/8oAUDixtnCFG7vuM4LPiuIZ/cnyDzw0
 LgKPfAqfpOMkCCXBG0xW/gIyETKHJ5Nrs/13Cb7i87ynEtBSS42GavBupK6JvP3wQzAFnpGQ0ue
 MuIN4Ngf4nXJJfcx9Z1qMw0T+N08b5jnMf2wNkyZ2QNKRm5twS4SUZrfDf0oLayS/VzZvfQAaQ3
 +EEyyzSg/t6pGoyOp7HQ5HTGJOs5htSEVvggdAOvuCknVvRPC4vJGyI+VGKp4yYMamws4GLz6KY
 VAsJV3kasGuzkEBrdZr5EQsVHeOz++TAN4eKhWfyWjUKnVoK1T9lnFipdpEgGs1k3qX60NKUoXC
 Z495Ua3ZJ98JZ
X-Received: by 2002:a53:cc4f:0:b0:667:c3c0:f2b7 with SMTP id
 956f58d0204a3-6694f0a7488mr4235374d50.19.1785600346674; Sat, 01 Aug 2026
 09:05:46 -0700 (PDT)
MIME-Version: 1.0
From: Bernd Behler <bernd@behler.me>
Date: Sat, 1 Aug 2026 18:05:34 +0200
X-Gm-Features: AUfX_myTGQEgFAnuavm2rETdEKM6wPsVH5mJSLK-QjJxN1Au5BXvDoH27Vz5AwQ
Message-ID: <CAM=hwCxiJwODObeut=JcCA8jbu4C-XVEKJpR-y2MnDJibBQyOw@mail.gmail.com>
Subject: =?UTF-8?Q?Apple_Studio_Display_=282026=2C_Thunderbolt_5=29_=E2=80=94_DP_tu?=
 =?UTF-8?Q?nnel_torn_down_every_few_minutes_on_Intel_TB4_host?=
To: linux-usb@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 01 Aug 2026 19:43:17 +0000
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

Summary
-------

An Apple Studio Display (2026 model, Thunderbolt 5) connected to an Intel
Arrow Lake-H host with integrated Thunderbolt 4 loses its DisplayPort
tunnel every 2-5 minutes under normal desktop use. The screen goes black
for ~2 s, occasionally for several minutes. The Thunderbolt link itself,
the tunnelled USB3 and the tunnelled PCIe stay up throughout -- only the
DP tunnels are torn down and re-established.

The previous Studio Display model (2022, Thunderbolt 3) on the same host,
same port, same cable, same kernel does not show the problem.

Hardware
--------

Host:        Intel NUC 15 Pro "Cyber Canyon" (NUC15CRKU5), Core Ultra 5 225H
Host TB:     integrated, 8086:7ec2 / 8086:7ec3, host router generation 4
GPU:         Intel Arc 130T/140T (8086:7d51), i915
Kernel:      7.1.4-arch1-1 (Arch Linux)
Compositor:  Hyprland / aquamarine (Wayland, atomic KMS)

Failing display -- Apple Studio Display 2026
- EDID: manufacturer APP, model 44614, made week 1 of 2026
- TB device 0x8025, generation 4, 20.0 Gb/s x 2 lanes, NVM 64.81
- contains an Intel JHL9480 (Barlow Ridge, TB5) -- appears as
  8086:5786 PCIe switch behind the tunnel
- firmware updated via macOS immediately before these traces; no change

Working reference -- Apple Studio Display 2022
- EDID: manufacturer APP, model 44602, made week 7 of 2022
- TB device 0x801f, generation 3, NVM 67.0

Symptom
-------

Reproducible within minutes by scrolling bright web pages. Frequency under
load is one event every 2-5 minutes. Recovery is usually ~2 s; three events
during the session took between 2 and 3 minutes.

Only the Studio Display blanks. A second monitor on HDMI is unaffected.

Trace
-----

drm.debug=0x104 plus "module thunderbolt +p". A single event:

  i915 0000:00:02.0: [drm:xelpdp_pica_irq_handler] pica hotplug event received,
                     stat 0x0000000c, pins 0x00001800, long 0x00001800
  i915 0000:00:02.0: [drm:intel_dp_hpd_pulse] got hpd irq on
                     [ENCODER:521:DDI TC3/PHY TC3] - long
  i915 0000:00:02.0: [drm:drm_dp_dpcd_access] AUX USBC3/DDI TC3/PHY TC3:
                     Too many retries, giving up. First error: -6
  i915 0000:00:02.0: [drm:intel_dp_hpd_pulse] got hpd irq on
                     [ENCODER:549:DDI TC4/PHY TC4] - long
  i915 0000:00:02.0: [drm:intel_tc_port_reset_mode] Port G/TC#4:
                     TC port mode reset (disconnected -> tbt-alt)
  i915 0000:00:02.0: [drm:drm_dp_tunnel_destroy] [DPTUN 1:1:5] destroying
  i915 0000:00:02.0: [drm:drm_dp_tunnel_destroy] [DPTUN 1:1:6] destroying

Thunderbolt side of the same event:

  thunderbolt 0000:00:0d.3: acking hot unplug event on 1:11
  thunderbolt 0000:00:0d.3: 1:11: DP OUT resource unavailable: adapter unplug
  thunderbolt 0000:00:0d.3: 0:5 <-> 1:11 (DP): deactivating
  thunderbolt 0000:00:0d.3: acking hot unplug event on 1:12
  thunderbolt 0000:00:0d.3: deactivating Video path from 0:5 to 1:11
  thunderbolt 0000:00:0d.3: 0:5: detached from bandwidth group 1
  thunderbolt 0000:00:0d.3: 0: released DP resource for port 5
  thunderbolt 0000:00:0d.3: 0:6 <-> 1:12 (DP): DPRX read timeout

The "hot unplug event" originates from the device router; the host acks it
and tears the tunnels down. "DPRX read timeout" recurs on every event.

In one earlier trace the teardown was preceded by a bandwidth-allocation
request from the display asking for zero:

  thunderbolt 0000:00:0d.3: acking DP_BW (0x20) notification on 0
  thunderbolt 0000:00:0d.3: 0:6: requested bandwidth 0 Mb/s
  thunderbolt 0000:00:0d.3: 0:6 <-> 1:12 (DP): bandwidth allocation
changed to 0/0 Mb/s
  thunderbolt 0000:00:0d.3: acking hot unplug event on 1:12

Later events start directly at the active adapter 1:11 with no such
prelude, also with bw_alloc_mode=N.

Possibly relevant: tunnel topology differs between the two models
-----------------------------------------------------------------

Both displays expose a 2x1 tiled EDID (2560x2880 per tile).

2026 model -- i915 drives the full 5120x2880 through a single tunnel at
HBR3; the second DP tunnel exists but never carries a stream:

  0:5 <-> 1:11 (DP): consumed bandwidth 0/22500 Mb/s      <- carries all of 5K
  0:6 <-> 1:12 (DP): consumed bandwidth 0/0 Mb/s          <- idle
  port_clock=810000, lane_count=4

2022 model -- driven as two real tiles, both tunnels carrying video:

  0:5 <-> 1:10 (DP): consumed bandwidth 0/17000 Mb/s
  0:6 <-> 1:11 (DP): estimated bandwidth 19000 Mb/s
  port_clock=540000, lane_count=4

The idle second tunnel of the 2026 model was the adapter that unplugged
first in the earliest traces.

Link maximum on this host is 36000 Mb/s. The tunnelled USB3 grows to
14738 Mb/s when DP releases bandwidth.

Ruled out
---------

Each of these was tested; the trace signature stayed byte-for-byte
identical.

- Display firmware update (performed via macOS; now NVM 64.81)
- thunderbolt.clx=0 -- link low-power states
- thunderbolt.bw_alloc_mode=0 -- DP bandwidth allocation mode
- Thunderbolt/PCIe runtime PM (power/control=on on the NHI controllers,
  the tunnel PCIe ports and all TB devices). This did eliminate a
  separate, rarer failure in which the whole TB link dropped for ~8 s
  including USB -- but has no effect on the DP-only events described here.
- Cable: swapped the 2026 display's cable for the 2022 display's TB3
  cable. Link still negotiates generation 4 at 20 Gb/s x 2; failure
  unchanged.
- Bandwidth / link training: AUX dies outright (-ENXIO), no retrain is
  ever attempted.
- PSR / Panel Replay: "Sink support: PSR = no, Panel Replay = no".

Not yet tested: driving the 2026 display as two explicit tiles to mirror
the 2022 model's working configuration.

Questions
---------

1. Is the host expected to tear down both DP tunnels when one DP OUT
   adapter signals unplug, or could the teardown be scoped to the
   affected adapter?
2. Would a debounce or retry be appropriate before releasing the DP
   resource, given the adapter reappears ~2 s later?
3. Is the recurring "DPRX read timeout" on this device a known interop
   issue? dprx_timeout is at its default of 12000 ms here.

Happy to test patches or collect further traces.

Thanks,
Bernd Behler
