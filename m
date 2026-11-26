Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13931606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHncF/+K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732E21126C8;
	Thu, 26 Nov 2026 19:57:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CF61126C8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:57:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE79D605C8;
 Thu, 26 Nov 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795723032;
 b=yLH1L9S+SiHUBOlt51Fb1EyX91rfVEyizkpv6o/Z9AnFPP7aafhz4asLncJiDWzmqwfF
 R/w8Zumg3iE68GuVE5L9yAZhayph+lbSwTDmPwmXc6qoazZ3NSObI8SCwwUDSMeTHksWI
 SOaN3g20D07JRVn4Ndn7EtfwFSMc1zoWgitn+HGUgElP8ZdjgKoNEgwBklb/VTYI37I6W
 Ilec9d2v2knD3NqU4LhdcjI2fgnOS1UbgLOLLl8tfpTM85l2+/XFlgUFn5NQErrzPPxBs
 Lvs4lqNe4428M3V0jydwWVqKga8v4y1SvlzG37DFn77P9UT1ti69m6Cs86VHG79/O2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795723032;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=0416eUV/WSjQjoA6H5jF6z/8pETOyAMtqR7dJx5vckw=;
 b=gzjall2KMNO86qptARZOyzK3KqYkUlBFBhbxSQ6Ii7InnhQ1q2ALcK4lCyaHdS+Y4lKp
 qTD/hbTCB/w88mGVKuaS3RmxoFIlSaTVLeLoYSYH8Q1Yhw6vYPpa3681GXS08tKxUC8ly
 o7TEGi379EII6VJLfI2kUWgn85vD11mEr3/aobFy3vuQSFepTDIg52NDJ3GQms5ZYOk2s
 3ROlFu0Wsz+T/VYoy7sXAmCf/qPH9RFBniuwJV7nZRJAK6QCkWKj4ttvTg13IDDWADcGd
 0ulsnsc9RdGin6lvATSYlSQK9BMW3hfIxKcKw35MPfDN03Eu52mpKPJtfSK6xSFMe5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 794A01F000C4;
 Thu, 26 Nov 2026 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795723032;
 bh=0416eUV/WSjQjoA6H5jF6z/8pETOyAMtqR7dJx5vckw=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=QHncF/+K41V4uLmia6WMvLAW9UWworccoUWPGZyIECmyRJy8+OFgHKoO5B9kEollw
 cvzo2MoXkZvSWOpr5jvWUI7PGZm97lBmL5TvLvcfoAU5f2l6XJyZilONFpq8cR/x+Y
 hpqa+bM3xp6hLPvp7qyC4bLE7MRMDrieZavNj3B9JESYJ2GF0sM1gVRla7Z1jtHi51
 ZrAlPLbRPpwlJgyOwBgV6m1kAY5r0foVFyphcHHco0GCcSq7bv83+3+HhtG0rH9Q/R
 RnJ+ffSwwIxf9zHoAG+Fyy+CPEZ2VrtaxhL0WAbIB5z6GO+fsZyBdogC+GZ7VCMKvO
 GrL+JNbv8mYGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CCBB44D7D2;
 Thu, 26 Nov 2026 19:57:08 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/2] drm/panel: visionox-rm69299: Move off/sleep DSI
 commands to disable()
Date: Thu, 26 Nov 2026 20:57:05 +0100
Message-Id: <20261126-visionox-rm69299-enable-v2-0-d4aca6d50b05@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhSyFRceQ/DAukUJlFKWiUY0
 rtb8QAu38//728QOQhHOBcbBF4kip8y6EMB/dhNA6PYzKCVJlVrg7+KXzE8qNFNgzx1tzujIld
 ZU5EjqiGv58BO1t18bTOPEp8+vPejpfym/51LiQpdZyxpq8mezCXKsPbz6+jDAG1K6QPf5vt4w
 AAAAA==
X-Change-ID: 20260427-visionox-rm69299-enable-06f3d736f664
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>
Cc: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=zx7Xk0+dBLLt7XNzmT5ldQdB0NoABe+yn3rRzjyup5o=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrCI8T/ieL2eb52pIq9DciCixcwcUo+reruVXgG
 V8Xr6y6X0OJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawiPEwAKCRBgAj/E00kg
 cntRD/0TcjHQGiTMuRZ8wgwimLKu5mpvx5Rcyug9el5hUYhPcCc5krClaYJqmSHUWGrIncQwwZt
 /XaXnHneLkJvuD/JsAvwpDQXC8ogF8DCwGcYPw3ulNp4kwA/GYTO/m/lI5I4QYgaBD2v2+L2EA9
 0bqh1QIsx2qdmpZdHuSUaiZ5ivl5wVVZOlockQeLGVP3TjflrPclgBrTQphvoHfYk1H991udv+4
 Zj8Zt1u65Kci/L74JyHh16/ewh9paqMMlfd4bmpN9F9IDtioh/AsHO6sfAqfQsdiJOkHxDXoIs9
 CpAu/R4VRcT9/wVzZZYgGPZbTnqOmpLZQkXoMzCSdVtOQBLBqWZzzdKHoqQdmzJ5NCTBCGJoaEF
 Tpj3uyx1bBmIB6CTQEOEEbhcye61mT/ecQ4w+M2a6bQ8FoHdO6N8WvhBDFTsy7pxSGQgSp/ZBAn
 hScX9+44ihAo4QQS0DbhYI5LAJ74aXJedM9Rmag+zYxntb27uJA+yb1OGJQCDph/f9B9kG0M0WB
 Q2HgUCUOSplSslwYc32kLbxqDG+Nqesd/p5uPvCB2jObPNovv5fZzyAEFyB5gnV3bkJsYym7KVn
 1Xa7xze+Px5JKu+9pY+WjEohBapk9i7+UOh806oSpU0ReeX8qRjnH64CE7n+lSMyBp1nBVmMD7r
 BTPG1QjtIrTjwNA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On video-mode MSM DSI hosts with prepare_prev_first set, panel
unprepare() runs after the DPU timing engine has been disabled and
before the DSI host bridge post_disable() resets the video engine.
Sending DCS SET_DISPLAY_OFF in unprepare() therefore times out on every
screen blank/unblank on the SHIFT6mq:

  msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
  dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
  panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

Move only the display-off / enter-sleep DCS commands from unprepare()
into disable() while keeping the power-on and initialization sequence in
prepare() (where the link is in LP11 before video starts), and fold
power_off() into unprepare().

---
Changes in v2:
- Keep power-on and init DSI commands in prepare() instead of moving
  them to enable() (Neil, Dmitry).
- Only fold visionox_rm69299_power_off() into unprepare(), keeping
  visionox_rm69299_power_on() for prepare() (Neil Armstrong).
- Verified on SHIFT6mq across repeated blank/unblank and
  backlight cycles with zero DSI timeouts and no stuck disp_cc clocks.
- Link to v1: https://patch.msgid.link/20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org

---
Guido Günther (2):
      drm/panel: visionox-rm69299: Move off/sleep DSI commands to disable()
      drm/panel: visionox-rm69299: Move power_off() into unprepare()

 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260427-visionox-rm69299-enable-06f3d736f664

Best regards,
--  
David Heidelberg <david@ixit.cz>


