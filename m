Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A9AC5DF68
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A6610F270;
	Thu, 13 Aug 2026 09:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/R+DQ4A";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F3810E03B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:53 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39f927721f2so12416151fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786595271; cv=none;
 d=google.com; s=arc-20260327;
 b=U0B/mXOKecz7IQ28mwZfNIBxDazo0U3mBKzYkrFZNAItTPt8PGuWcNtyxmbRtd94eQ
 1edF4gkBbHHcjOODQLkFyW/uPSuF2NZRBtoIis57sv+/vAHyWrv2GfgnQwAnqi4bz1G2
 Hg2c9xMtCbW+YjtLnil/V9i/5ZaviP5WCF9KwdJ/GT8dORKuc9fXxmjwYM+RTzOgvG+g
 5UhL+epDK6lpNIfuDkZHJKGqDRq1M5num7pDmJzzBaj4CiJQIvjs6WNddSzww53DynqO
 NMQl2AVdBZ/xneUGwrbfp6GFJSQuFrA4j4MLZHvZgFns3dGWPzsTje1KxoKeDLTNK0PW
 0x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=a6DEVzmK3qVQENQm1NcCr1EvhZxESWnZuaofQxJb//w=;
 fh=+K3KkJVhAx6XIYikssRST+Hi/wiU0TlLh6F5Kf8iMrg=;
 b=hHRxjYxybMiY1y3eA4RIDfhhzAVlz8CZRL8Gjp6O8b3nNo/IrhkW1+KcaHq8uNwVEI
 MxC5MJXYaekX7hbFqIvN6PvZNiK7jSOH3m3Dx9VVcIOoBxjQXQ9qCgsWnXL+Vewp3PGA
 xFbiWi8YYlfbAhtAjZ88UoxJIDy6l/JtcizJPZ1vtc1s/kgl7WZ9VdkdCWtSOc0Fgcc9
 NHLjCssC0BeAv4RFnlZUeM75fxR/hKs5dbx6q64bxSillVaj5zegabvh/QtwjfF7T1oA
 Q9QRqcdBYq2ceV7/sfgfhRrjCABP7B/BqWOkDPDOFHeDobC15wIkFHPO1AfbE/UVS2wb
 pa4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786595271; x=1787200071; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a6DEVzmK3qVQENQm1NcCr1EvhZxESWnZuaofQxJb//w=;
 b=j/R+DQ4A+6bCcS67UkUG1FMOJT7nRaaCxRgz/rUetIKfoi5oRIB7NsAeoXBajdRWLx
 64em1Qi6M7rw9wd/9PNs3/yA2hbUSwgehNzL2ma0Oxhpz7KYCSyp4CDrPdb985FVfTWl
 /dImZBmYaopoL8XirH0xtfwOSLGxjaA0TspybcRMFCmbENYf3HAFt9CG29bKL2Pv1eC8
 vcBjm23QHzdkc0mhnoeRlQJAT0yMzX4iXos3vtVIHHrljT1HwqIjfboVEOQZk5Lvkraj
 HGNaureWB9xPPxNsYIQGhEVhAlDnHeJV6+ZrpsTc9hG3bSTlpPJkGVcVCwuce1gGwT8R
 y+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786595271; x=1787200071;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a6DEVzmK3qVQENQm1NcCr1EvhZxESWnZuaofQxJb//w=;
 b=SPKrkRxeenv8DYvghwXYmKjw5Ly6WX2dRqFQTbEaLu/1p2fn8iqGegtmWdBU4BQk1u
 QPxDrAbfT7lDAuzZ3CaNRW9UuOMlGiV4Oop7hgkZCthA4zvt4sHzmpGD0bc954pTMkUp
 ujim5dCBrzM3uH9zCeVPWz8hpvK7J7puPK3rU99b40xUlQDM4LblgyigMpGlu7edKfKU
 pGnpGsmehnVq8+oq7JCW92zkyrXALsRDBdBRLgO5Wt5hiATwvGA87nwi9p83rmGmcq90
 WUjGussm0/OFmo+dbW7RtqtxBwB4e2vw+xVZPV+F8bB9GOhViSs8MZEmGshvcxVf+51E
 Ac5w==
X-Gm-Message-State: AOJu0YwzeLfUhTR747gNI0JF+qLXDrZpC1i5CEQu84x9NItJrp1pQLrJ
 s+zUfxgdpPu2CjY7zbSaAJL7+X4xQWg+VXE6QKYh5NY1+Z2mFVUWU+pxRLjIhz7safHo3d2gyxL
 DD9R4G6yESSmd0Rx0uprGHI2RbZyG6jYNZYs7cKY=
X-Gm-Gg: AR+sD12fr9n3DUQC88Gwb8NtR76us69SiW+BkIU7MU7Yly1jsebxOWk/UtAJFcOd7t3
 fpK1gtl/5nfSwbyViYCRqN9GqkbraeyzcBY9xsgnVKl5DC/mENLWzX8/WxqoHgx1v8inhzEGGkb
 NO1IXe0JfHFNkg/HsL48ERzXr/4Jt1ss2o7j3HNQWlyK4AqSw/yx27gP9gKRnAiS0jMJArv8VX7
 nnpEGCw+ZGq/VGN1SWaj6t4xK18wDxJE1iFNq/1kkFxRbZfT/46bGlNyuj8MwNa2rCg0Vh8tkEv
 VZV96Rq4klGRlwlpnBGmSaStDT0LkPkUUKVUGTgvQgE=
X-Received: by 2002:a2e:a98e:0:b0:39c:a346:8a36 with SMTP id
 38308e7fff4ca-3a11a54152cmr3559571fa.8.1786595270857; Wed, 12 Aug 2026
 21:27:50 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Piparo <holofermes@gmail.com>
Date: Thu, 13 Aug 2026 00:27:24 -0400
X-Gm-Features: AUfX_mzd75rnG7eDXx3dOQZHSmFx8Mp8zkUsPQYcZPQWPT70HSQm2pB_XCPnJlg
Message-ID: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
Subject: drm/ssd130x: stale pixels when the GPU renders into the framebuffer
To: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

The symptom
===========

I am working with a Raspberry Pi 5 driving a 128x32 SSD1306 over I2C
through ssd130x, brought up with dtoverlay=ssd1306, and a GLES client
rendering into it. The GPU renders straight into the panel's framebuffer.
The panel shows a blocky pattern that is affected by CPU load. The kernel
is 6.18.39.

A capture:

  https://files.fabiopiparo.com/ssd130-line-glitch.webp

This is a simple trail traveling left to right, and the busier the Pi is,
the shorter the trail (link above). On an idle machine the leftovers build
up into a blocky fog. That was the clue that pointed me at the CPU cache,
since the lifetime of the artifact tracks memory pressure.

The trace
=========

I made a test program that flips between two alternating solid frames
while i2c_write payloads are traced. 15 of the 31 flushes carry bytes
from both frames in one payload, mixed at 64 byte granularity.

What appears to happen
======================

My reading: the driver's XRGB conversion reads the framebuffer through a
cached mapping while the GPU writes the same memory directly, so what
reaches the panel is whatever lines the CPU still holds. The 64 byte
granularity and the load dependence both fit that, and write-combining
the mapping makes it stop.

What stops it
=============

Setting shmem->map_wc in a .gem_create_object hook makes all the traced
payloads come out as expected.

Whether the exporter is the right place for this, I do not know.

I am happy to test anything on this hardware and report back.

Disclosure
==========

The panel, the symptom and the i2c trace come from my own hardware. The
analysis above and the change came out of a long debugging session with
an AI assistant.
