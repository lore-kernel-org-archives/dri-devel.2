Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63316C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666A610F1EC;
	Fri, 31 Jul 2026 11:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j0XzqYNv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED7910F1EC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:09:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 513396004E;
 Fri, 31 Jul 2026 11:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE6B1F000E9;
 Fri, 31 Jul 2026 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785496195;
 bh=s9Dp3ScBGBt3a0eMRr8MOXfaIz7TYF1wma8ob1rZDqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j0XzqYNvpHXf70w80HN6fEeZUXZU/LTNIxu0s7qCHE3MJM17Xk3pNAIG1nDXBZRrM
 lsNh5hiFcVICdOLLzD6cH16lRBmEblSmmnOihaLO/9JFp3VYIJNuMVv06EvrJ7nC3m
 4dRCBvc7ZQcyk/HW/Qq2ooT5KMUG0TOX0ns5F+t+LcIWyQiAbam9QVPMGBkGkL9zmD
 Qn+/BJj0qzw6seGdYhJRxaBRdDqjk4Is7L/OVmhTdTlAs5UBnxED2dcbreZXmqU4nM
 BtMhWd1AzGdXFMNisl1lE4kYGSPSooDRKfy8GF12ht0YbXYwT+UFHn/qwgUZ+8GW2D
 1qd6xgpQhTPww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
To: "Jakub Turek" <jakub.turek@elsta.tech>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
 <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 11:09:54 +0000
Message-Id: <20260731110954.ACE6B1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [High] Invalid initialization command sequence sent to SH1107 displays.
- [Medium] The local variable `ret` can be returned uninitialized in `ssd13=
07fb_update_rect` when `par->page_address_mode` is true and `pages` evaluat=
es to 0.
- [Low] Suboptimal and wasteful memory allocation for `array` when `page_ad=
dress_mode` is enabled.

Pre-existing issues:
- [Critical] The driver frees `fb_info` and graphical memory immediately du=
ring device removal, leading to a Use-After-Free if userspace holds open fi=
le descriptors.
- [High] Kernel crash during probe if the device is matched via the legacy =
I2C ID table.
- [High] Short I2C writes are silently treated as successes, potentially co=
rrupting the display.
- [High] Missing lock around display update sequence allows concurrent I2C =
transactions to interleave and corrupts the hardware state cache.
- [High] The driver may sleep in atomic context when fbcon attempts to upda=
te the display during a kernel panic or oops.
- [High] Unvalidated `solomon,width` and `solomon,height` device tree prope=
rties can cause integer overflows when allocating memory, leading to heap b=
uffer overflows.
- [High] The `refreshrate` module parameter can be set to 0, which causes a=
 division by zero when configuring the deferred I/O delay.
- [Low] The `i2c_device_id` array terminator does not use named initializer=
s.
--

--- Patch [1]: [PATCH 1/2] fbdev: ssd1307fb: add support for Sino Wealth SH=
1107 controller ---
Note: The format of this review has been altered to a free-form summary due
to recitation restrictions. Original patch code is not quoted.

Commit: 1ab3e53993e2ff1e1a60665597dfc8bf1a7a4cd1
Author: Jakub Turek <jakub.turek@elsta.tech>
Subject: fbdev: ssd1307fb: add support for Sino Wealth SH1107 controller

This commit adds support for the SH1107 display controller to the ssd1307fb
driver. It introduces a page_address_mode flag to handle the vertical page
addressing mode utilized by the SH1107.

[Severity: Medium]
In ssd1307fb_update_rect(), if par->page_address_mode is true and the
calculated pages evaluates to 0 (for example, if invoked with a damage
rectangle where height is 0), both initialization blocks for ret are
bypassed. Could this result in returning an uninitialized stack variable?

[Severity: Low]
In ssd1307fb_update_rect(), when page_address_mode is enabled, the code
allocates width * pages bytes for the array. However, it only populates
and writes width bytes per loop iteration, resetting the index each time.
Is this allocation larger than necessary?

[Severity: High]
In ssd1307fb_init(), the SSD1307FB_SET_ADDRESS_MODE (0x20) command is
sent unconditionally. On the SH1107 controller, 0x20 is a 1-byte DC-DC
voltage setting command rather than a 2-byte addressing mode command. Will
the hardware incorrectly interpret the subsequent byte 0x02 as a standalone
command instead of an addressing mode parameter?

[Severity: High]
This is a pre-existing issue, but in ssd1307fb_probe(), device_info is
fetched using device_get_match_data(). If the driver is bound via the
legacy I2C sysfs interface, this returns NULL because the entries in the
ssd1307fb_i2c_id array lack a .driver_data field. Could this cause a kernel
panic when par->device_info->default_vcomh is dereferenced?

[Severity: High]
This isn't a bug introduced by this patch, but in ssd1307fb_write_array(),
if i2c_master_send() returns a short write (a positive value less than len),
this positive value is returned instead of a negative error. Since call
sites like ssd1307fb_update_rect() only test for ret < 0, do short writes
get incorrectly treated as successes, potentially misaligning subsequent
hardware commands?

[Severity: High]
This is a pre-existing issue, but ssd1307fb_update_rect() performs multiple
I2C writes and updates caching variables without holding any driver-level
lock. Could concurrent access from fbcon, delayed work queues, and userspace
writes to /dev/fb0 interleave I2C messages and corrupt the hardware state?

[Severity: High]
This isn't a bug introduced by this patch, but during a system crash, fbcon
flushes output in atomic context and invokes .fb_imageblit, which eventually
calls ssd1307fb_update_rect(). This function calls kzalloc() with GFP_KERNEL
and the sleepable i2c_master_send(). Does this cause a deadlock or nested
panic preventing oops messages from printing?

[Severity: Critical]
This is a pre-existing issue, but ssd1307fb_remove() unconditionally calls
__free_pages() and framebuffer_release() directly inline. If a userspace
process holds an open file descriptor to /dev/fb0 during device unbind, will
subsequent operations access freed memory since the driver doesn't wait for
fbdev core reference counting to reach zero?

[Severity: High]
This isn't a bug introduced by this patch, but in ssd1307fb_probe(),
unvalidated solomon,width and solomon,height properties from the device tree
are multiplied to calculate vmem_size. Could maliciously crafted large
values cause an integer overflow leading to a small memory allocation and
subsequent heap buffer overflows in ssd1307fb_update_rect()?

[Severity: High]
This is a pre-existing issue, but the refreshrate module parameter can be
set to 0. When configuring the deferred I/O delay in ssd1307fb_probe(), does
the expression HZ / refreshrate evaluate to a division by zero and crash the
kernel?

[Severity: Low]
This isn't a bug introduced by this patch, but the ssd1307fb_i2c_id array
concludes with an empty terminator instead of using a named initializer.
Does this violate the I2C subsystem API guidelines for struct i2c_device_id
arrays?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-feat-sh110=
7-v1-0-e10977f76e6b@elsta.tech?part=3D1
