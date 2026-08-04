Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A584C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF2010EA61;
	Tue,  4 Aug 2026 13:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ut9E2wMR";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982A110EA61
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:57:07 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso600994f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785851826; x=1786456626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TE9xxgUxR/pvncha53bikY5ll9Vwv1tdHdDjBDXq5T8=;
 b=Ut9E2wMR71/QG4mJgVFqCYRkRzATgAS0ipwO0B/O2UpDQ7VDa95r2w1QsfJAtYKMkH
 IaRVHOwOQVJ6pA7Xe6sjMyJ8HKnFdDrQjw1MRutaxP0vCmSVHIDtiJHwJnyiSqlmYZS4
 vUHxBVs2E+JIG1ayyZ9p7/9SAv4G5ZkPNq2fASVtUzzdpnVrLJRDkXbIB+4Td9ZCiEvX
 Sh4opvyGPBjc+Ifh2RqoCOypvrXcTDHvJsCK49OV3Tx/3tG/IuTv4R7ah+K0sOuO9Qhc
 IY0ZULphU+9aP8lqwRWHkRqPKXmRrfAbPNNyHyf7tTnlUVOsjEYooNE/7A/1gTLenY0o
 XZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851826; x=1786456626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TE9xxgUxR/pvncha53bikY5ll9Vwv1tdHdDjBDXq5T8=;
 b=q0aaU6+0/YUYoxBrDVl9nOIzQoZd4LIBqdKVWEHrkd5XA3UDrzOkXm7KQqULIrsD1z
 Hf3b3RT9+20e+aywAAqv7QPS98Co22E87xazrTPeHjX3txi1Js8flWxyt26Fep5Vz9uA
 5xxqniZnC5o9i7HblNeeAs11mS1vZYegr5pF+Yo+9qBv038bdPNm9KKt3ZWRJAO7sclM
 IsB26k8ix4kWg11AXFhq7ot75A7c9fJRmPOvZNgqQAblWzr7GtiNoLv3mgoMQ3K3D935
 nRy64dbds2RPMVa68PqQ3MDfjCyJUqAweffy2tWQhpxX/5HFlI+hioh+GnncvHhNq+ii
 2UxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpFpXjNuyN/GplrNSTGAQfjP4h/mfDACAdc4j+r/a1DQnyRGcRMsnwUCX22yf2VkZkHxVhkeCC+wE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZrs+7fWitgXd8zNY0DitRynLzqUDB+6Rd1WtGXBvsv+6x1kgW
 jdI2z7zsxGH9oVvFDquQBrlI8uin1t2D8TAZuyfio0zPPWWKCQEjjzYHBrdZpd1M
X-Gm-Gg: AR+sD13cdjyxcEy99QsdGzIG5mlZ2puLUEIrtbYSXc7yLmmQhWlBO0JWDAVb9Mkky6T
 uxLJmOh+00V7yYZdDymjeKJ+v23GSt4cKXa3nLlGkrEEJK6JHUFamS1AFp5iQWtlmcZ7B5F7h9L
 pMuvwDmIfmRA908XFq93Q8kmsf54P1prgAtiDXnnj9jdvzdY2fKAZDJtk9CiZHeAasXxhNTOCHY
 qD7RLy9i+L2x5XtWakcTrEt+7+IqjUqv7vSv+pFp4wyTwrXQwvnReYZ7oYrH+hmP4bskXavaQ9n
 y8t82eCPTzOC93GWo7DAVGzsyo4brHSQ5SeTj1o2FRIEwq8qOkD5TGxcs/3pdS8aF7mclLrLs7C
 dWh3x7YW23KrI9oUy677z2dhksNybpvw2BWZVo5yRgrDPc/SbrJyTM26/TQJdNAXalYv5WYIzrI
 eBuS6HOuOHdUgFH8rs+qhl6LVGtbd5TolhllC5dws1JpD2s2ajUwk1x9dfW57Oq9cnl4lNV7IVo
 4UO4gGn71KOVojapqA61VGDjJOuyo7IJwtxKUEVuI/7FObOjj296Quu5C+E6mtZJ1IA
X-Received: by 2002:a05:6000:41d5:b0:47f:959f:d5e with SMTP id
 ffacd0b85a97d-47fd70631f5mr20353186f8f.0.1785851825677; 
 Tue, 04 Aug 2026 06:57:05 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B0400B222A3225E875A6B.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:400:b222:a322:5e87:5a6b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6cbsm39595608f8f.23.2026.08.04.06.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:57:05 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH v9 00/22] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Tue,  4 Aug 2026 15:56:40 +0200
Message-ID: <20260804135641.17170-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Sebastian,

You wrote in the cover letter that parts of this are untested, and asked for
comments on the out-of-band hotplug callback.  I have been running this series
on real hardware, so here is a report from the USB-C DP AltMode side.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, Orange Pi 5 Plus, USB-C DP AltMode

Hardware and base
-----------------

  Board:  Orange Pi 5 Plus (RK3588)
  Kernel: v7.2-rc6 + rockchip-devel, pinned at 8c70065a3207, which carries
          this series at v9 - including 03/22 "Fix error handling in
          dw_dp_link_enable()", so this is v9 and not an earlier respin.
          No local changes on top of any dw-dp patch.
  PHY:    your rockchip-usbdp v13 series, from the same branch
  Sink:   4K120-capable display, reached both directly and through a USB-C
          dock, DP AltMode over the Type-C port

Results
-------

USB-C DP AltMode works.  I get 4K120 on the Type-C output, which on this board
is a third display output that mainline does not otherwise light up at all.
The mode comes up at dclk 594 MHz, which is what 4:2:0 should give at that
resolution (two pixels per clock), and it survives a live modeset - I can go
from 60 Hz to 120 Hz on a running desktop without unplugging the cable and
without dropping to a black screen.

That last part is the change I want to highlight.  On my previous kernel, based
on v7.0 without this series and without the usbdp rework, touching the cable
while the link was up was something I had to actively avoid, and a live 60->120
modeset gave me a black screen that needed a hard reset to recover from.  Both
of those are gone here.  Whatever the combination of the follow-up bridge work
and the PHY re-init on orientation change is doing, from where I sit it is the
difference between "usable" and "do not touch".

I have not exercised the DP audio path (22/22) yet, and I have no board with a
native DP connector or an HDMI bridge downstream, so I cannot say anything
about the code path you flagged as untested.

On the out-of-band HPD callback
-------------------------------

You asked for comments, and I have a data point rather than a design opinion.

On this board the AUX channel is dead at boot until something kicks the Type-C
port controller.  The cause is on the firmware side rather than yours: the
board boots through EDK2, which has no TCPM, so it hands Linux a PHY that was
never brought into a sane state and a port controller that has never
negotiated.  Nothing on the DP side can discover the sink until fusb302 is
poked, after which the link comes up normally and stays up.

I mention it because it is exactly the shape of event your callback is for: the
hotplug information arrives from outside the DP block, late, and the DP side had
no way of knowing.  A separate callback rather than reusing hotplug_notify seems
right to me for that reason - the two really are different sources, and only one
of them is something the DP block could ever have observed itself.  I cannot
tell you whether there is a cleaner mechanism, but I can tell you that the
separation matches how the hardware actually behaves here.

One neighbouring finding
------------------------

While bringing this up I hit a bug that is not in your series but sits right
next to it, so it may be useful to you and to Cristian.

On RK3588, VP2's dclk was parented to the HDMI PHY clock.  When the HDMI PHY is
not powered - which is the normal case if you are only driving the Type-C
output - that parent is dead, and DP gets no usable pixel clock: nothing above
640x480 comes up.  Re-parenting VP2's dclk to V0PLL in DT fixes it, and that is
what the 4K120 above is running on.

I see Cristian's "Consolidate HDMI PHY PLL clock parent switch" (v3 09/14 of the
DW HDMI QP YUV series) touches the same parent-switch logic from the driver
side.  I have not yet worked out whether that series makes the DT change
unnecessary, or whether the two are complementary.  I will work that out before
I send anything, but I would rather flag it here than have two people discover
it separately.

Happy to run any specific case you want covered, or to retest on later
revisions.

Thanks for the series - it turns a port that did nothing on mainline into my
main display output.

Igor
