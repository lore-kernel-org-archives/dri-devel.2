Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F344C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA53210E264;
	Wed, 15 Jul 2026 21:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BI03toNw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B989210E264
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 21:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54FA142B7B;
 Wed, 15 Jul 2026 21:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013001F000E9;
 Wed, 15 Jul 2026 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784150165;
 bh=QCHzCYSx6rkkGhOZYkoDAz6zF4WeNw8S5J3i9l6X/KA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BI03toNwOfUHtvIcGkP6G6a1Ysgnq9O58YVFJiDrHwVmGol5FybMpb2+QIF/8DLRz
 cjZURMj4bdxmjwQMqU0GTFD2XqHACf++05slC/Rl9AVYLTc2Yzb0ToyEYcNAGfIkaV
 fNg238gc0ne2L8WySyDPwA9usLMTwj99rFnzL62tqGkEF7Eb/xo3cHMh33jgmJx7tW
 fBnnXK342X4Dr/wLvgHS2BMpSdmiq5MfzO065UaFl52XtwHHXOYe/9yCJne3JJr/zB
 lXvHPcbsTcthgdDUZFYZly3WKbf3ZX1TtvPCX4rvOaLrRLtBxNc4mYx87Jl3U31hp2
 wq7IWucE4Cn/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/3] rust: add basic serial device bus abstractions
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-rust_serdev-v14-1-b4ed5c93606f@posteo.de>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <20260715-rust_serdev-v14-1-b4ed5c93606f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:16:04 +0000
Message-Id: <20260715211605.013001F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Drivers cannot synchronously wait for data during `probe` without =
causing a deadlock, because `receive_buf_callback` blocks on a mutex held b=
y `probe_callback`.
- [High] Concurrent device callbacks during unbind or probe failure lead to=
 Use-After-Free (UAF) or NULL pointer dereference because driver data is cl=
eared before the device is closed.
- [High] `Device::set_baudrate` incorrectly treats approximate baudrates as=
 errors, which will fail driver initialization on many hardware platforms.
--

--- Patch [1]: [PATCH v14 1/3] rust: add basic serial device bus abstractio=
ns ---
Note: The format of this review is altered to provide a free-form summary of
the findings, rather than inline diff comments, due to system recitation
restrictions.

commit c091dc3bf08c045ff86b0afe5e41d3fd0a94bb83
Author: Markus Probst <markus.probst@posteo.de>
Subject: rust: add basic serial device bus abstractions

Implement the basic serial device bus abstractions required to write a
serial device bus device driver.

[Severity: High]
In Adapter<T>::probe_callback(), the code acquires the active mutex and
holds it across serdev_device_open() and data.__pinned_init(). If a driver
needs to send a command to the device and synchronously wait for a response
during its probe routine, won't this cause a deadlock?

When the device responds, Adapter<T>::receive_buf_callback() is invoked in
the RX workqueue and attempts to lock the exact same active mutex. Since
probe_callback() is blocked waiting for the response, and
receive_buf_callback() is blocked waiting for the mutex, the system seems
like it will deadlock. Is it possible to unlock before waiting, or use a
different synchronization strategy?

[Severity: High]
Looking at Adapter<T>::remove_callback(), it appears that T::unbind() is
called, but PrivateData is never explicitly dropped or obtained from the
device data, which might leave the device open and leak memory.

When remove_callback() returns, the C driver core sets drvdata to NULL. If
data arrives immediately after, receive_buf_callback() might read a NULL
pointer from drvdata_borrow() and dereference it.

Similarly, on a probe error in Adapter<T>::probe_callback(), ScopeGuard
clears drvdata before PrivateData's PinnedDrop implementation closes the
device. Does this create a race window where the device is still open and
receiving data while drvdata is NULL or in the process of being destroyed?

[Severity: High]
In Device::set_baudrate(), the success condition is checked using strict
equality (ret =3D=3D speed).

Since serdev_device_set_baudrate() configures the hardware and returns the
actual achieved baudrate (or 0 on failure), hardware clock divider
limitations often result in a baudrate that is close but not exactly equal
to the requested speed (for example, returning 115198 when 115200 is
requested).

Will this strict equality check cause valid driver initializations to fail
on platforms that can only approximate the requested baudrate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-rust_serde=
v-v14-0-b4ed5c93606f@posteo.de?part=3D1
