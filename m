Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E6C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E254B10E61B;
	Sat,  5 Sep 2026 15:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gS0awwnh";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD4510E42F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 21:33:33 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-52d7a3defe8so15912451cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788557612; x=1789162412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5/Xia7rxdpyQybCgSGxs4a0QCDbKXZF9niLTTnJnSM=;
 b=gS0awwnhk5JywnclnDqm+IDAvHXoT0Y2ILBAxb/xJSkh5B1yPeU/ADQi9qu82l952s
 w9ZyeZaf03CVgftNmw7+dLBC1Xu3NTUX2JdgBbnWzD6S1ZyjUPaSos/Tgf4cCGeF5OyQ
 W1bfIzntkntZDFvm98vRtgw1Lj0kq3vHip0yy7/kkAsb0hEiTfrOrb3S7cwDBgSi1wBl
 wZsb3AoS/pJowNAaxQqPd4ODwDk7LGF1Jmpy1svuwW31TVq5+jfvltV8d2dsvNM0VeG9
 dNSyDWqNios8TBH22qKebrif+Qh87Gl4CxNaWnVnS41BQ6L1zfFui7UMwW1eBkQ9BQ4n
 FnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788557612; x=1789162412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5/Xia7rxdpyQybCgSGxs4a0QCDbKXZF9niLTTnJnSM=;
 b=EXh0AyV7JgdXCULhaRjgSYGoD39hY4ARhtX6HD7UHnoIN+EcUzH4mpaXKHColVw8Fq
 MjAOtmKku6NsC9HHIyouC291cEIs/pi5WPhpnJfQjd4RI+IrwO7Q/srojWJqA7E9AVjy
 wm8dbBx7BUrX6DLwll3jtC6+wv6BbSHWetcIo3MYTTjEpPr/ydbwQSHxQbakKv/Inch8
 uls+OVLVI/v4SmmqmzWXSRBceUJkEkY4q8RHhIv2Psl4abCQHK6Cry+VH2+k4oZe7oi5
 4hUjjqA4/qWrpLzjtmtijO3MAvcyIGasL8oa89Fu5/lYEuNMNgKnVWCx+1mDZZH499Jp
 hJzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi1LCOFSnJdbmu5IwG5lc5g370maXjr81zfnmN1XxLdggWKAigA5NVhePSqPhB2stpVSnV7I4EY5A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lWd7tUMAa3MAEfZvbYRFEJtJY+geRwTEsmqXI+qpvGZApJUJcz
 rvkUg3pNsGtIZhc10N/v3e0Nxlgb5i/22fSSEZ9XPFZ2xgNSwVK0uAs=
X-Gm-Gg: AYBFou0ufMr2weiIIvQf1ZUmJBsGCTyFqtmP9WLMJuli8WEZP+a9n9Ej6a5WablE3bF
 Dv7uwMw8aqTzEGA7OIoZ1ozNoieac+SCPVVh6ZOSNaLBWCg63JBPAsPmTYQivLlvemvGIJDgdVD
 dcHF9okQCNH3kmqXBusQ0aQdvvTd9I+gG1TZdW5Frp1i7Op3KscP61xt1DMGs7hLDPx1oI1wd69
 eTh/44hCLorLCUW5B5ePgA+MxEt8pYcWH41OWmTTQCYwXiYBm1t90IYtyDivbHjmFKbQ4iaLKK2
 l+hOpZe6yb96mqtuPqTwyn6rLlCGMHJS3mSh/XTe47eql+nbPbBOPrlFsANsquXZLRimS2kf7IG
 nkZXQxE8H9Zx3lrT5yxddCtMqDCjWhtOYLbCjj8viL/Nt6fKiP7LOosV0/mdamzNXV9QyXoKsQd
 Rz4bq1bCnoFpfIIn5klNtaMqWPOqPgp8ZYtRb1ksqZyxWXBr80Xom4Z5f2IniTLPkcZSoPL0QVD
 4ODGfBcJxsELg0=
X-Received: by 2002:a05:622a:1493:b0:52e:12e6:6d7b with SMTP id
 d75a77b69052e-530549f8c81mr96143391cf.39.1788557612371; 
 Fri, 04 Sep 2026 14:33:32 -0700 (PDT)
Received: from X570.phub.net.cable.rogers.com
 ([2607:fea8:744f:d200:9441:f2ae:56aa:8a81])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054227a0esm29646561cf.29.2026.09.04.14.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 14:33:31 -0700 (PDT)
From: Barzin Lotfabadi <barzin221@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: allwinner: h616: add HDMI device tree nodes
Date: Fri,  4 Sep 2026 17:33:27 -0400
Message-ID: <20260904213329.3910099-1-barzin221@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

These two patches add the device tree nodes needed for HDMI output on the
Allwinner H616 family.  Tested on an Orange Pi Zero 3 (H618, 4GB), which
drives a 1920x1080@60Hz desktop with these applied.

Mainline already has DE33 mixer support in the sun4i driver, but there are
no display nodes at all in sun50i-h616.dtsi, so nothing probes.  Ryan
Walklin's "arm64: dts: allwinner: h616: add LCD timing controller and
display engine support" series adds the display engine, bus, mixer and TCON
nodes, but states that HDMI output is not provided.  These patches are the
missing HDMI half.

Every register address, clock index and reset line was read out of the
vendor device tree shipped with the board and translated to the mainline
dt-bindings macros; the clock and reset numbering was verified identical
between the vendor and mainline CCU headers before substitution.

Two things I would appreciate guidance on:

1. Patch 1 currently also adds the display engine, bus, mixer and TCON
   nodes, because Ryan's series has not landed and the HDMI nodes need
   something to attach to.  If his series is merged first, I am happy to
   respin this as an HDMI-only delta on top of it.  That is probably the
   right shape; I did not want to post a series that applies to nothing in
   the meantime.

2. These nodes alone are not sufficient for a picture.  Two driver changes
   are also needed: an H616 variant in sun8i_hdmi_phy.c (only
   a83t/h3/r40/a64/h6 exist today), and setting the TCON pad select bit in
   sun4i_tcon.c.  Both exist in the Armbian sunxi-6.12 tree, authored by
   The-going.  I have deliberately not included them here, because I cannot
   provide a Signed-off-by on another developer's work.  If someone in a
   position to carry those forward would like to, I am happy to help test.
   Without them these nodes probe but produce no output.

checkpatch is clean apart from one 103-column warning on a remote-endpoint
line in patch 1; the identical construct at the same width already exists in
sun50i-h6.dtsi:183, so I left it matching the surrounding convention.

One implementation note worth recording, since it cost a boot cycle: the
DE33 mixer's three register regions must be named "layers", "top" and
"display".  The driver fetches the latter two by name, so a wrong name here
surfaces as "invalid resource (null)" and a -EINVAL bind failure several
layers away from the cause.

Result on the board, with the two driver patches also applied:

  sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_mixer_ops)
  sun4i-drm display-engine: bound 6510000.tcon-top (ops sun8i_tcon_top_ops)
  sun4i-drm display-engine: bound 6515000.lcd-controller (ops sun4i_tcon_ops)
  sun8i-dw-hdmi 6000000.hdmi: Detected HDMI TX controller v2.12a with HDCP
  sun4i-drm display-engine: bound 6000000.hdmi (ops sun8i_dw_hdmi_ops)
  [drm] Initialized sun4i-drm 1.0.0 for display-engine on minor 0

with the connector reading "connected", EDID read correctly from the sink,
and 1920x1080 among the reported modes.

Full boot logs, the decompiled vendor device tree the nodes were derived
from, and a photo of the running desktop are at:

  https://github.com/BarzinL/h616-hdmi-mainline

Based on mainline a500db7819c5.

Barzin Lotfabadi (2):
  arm64: dts: allwinner: h616: add display engine and HDMI nodes
  arm64: dts: allwinner: orangepi-zero3: enable HDMI output

 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     | 191 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h618-orangepi-zero3.dts   |  25 +++
 2 files changed, 216 insertions(+)

-- 
2.51.0

