Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A10DEC01A4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668DC10E407;
	Mon, 23 Mar 2026 08:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=subdivi.de header.i=@subdivi.de header.b="X8cApdQQ";
	dkim-atps=neutral
X-Greylist: delayed 488 seconds by postgrey-1.36 at gabe;
 Sun, 22 Mar 2026 08:16:44 UTC
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0A610E15C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdivi.de;
 s=k26.isilmar-4; t=1774166914;
 bh=lKTMvHmpJAIEYs8KPE88FNtFpOWsrJiEyxBoFqDN2DA=;
 h=Date:From:To:Subject:From;
 b=X8cApdQQTmEOyXptIY29Y/x5YVegCWlJFsqp3t0CKM0M3MyYUTYfiIlpWfeaAxH4H
 Wcd5Pk7LZ7hfVAgs7Q+UiSlglEPHFji1EMpFptrJ1iPvtvCb/ESq55kkZYjvpaZz4E
 hvpxk4CwBJzHowhmrHmHlOgQlekPGmykYwUyBvCl/Qg82ak1/e42mFgNtIuqTuxVAC
 /E8mHhEhqnPNbjtpBSeQ8jF9xAkaAVEnN/drr8aR3UivjJa+x7YamlyI4bRq7qk4U0
 VJJLhxcrAnuBJ0MIXqnSJ/Wlr+pNgJ47vqhYQPuCAfE+WsI6NdafU1D5IQfoHd1aOe
 nYWVAjMwGTIRw==
Received: from isilmar-4.linta.de (isilmar.linta [10.0.0.1])
 by isilmar-4.linta.de (Postfix) with ESMTP id 3FBE5200690;
 Sun, 22 Mar 2026 08:08:34 +0000 (UTC)
Date: Fri, 20 Mar 2026 17:26:34 +0100
From: Helmut Grohne <helmut@subdivi.de>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: amdxdna: firmware <-> driver compatibility
Message-ID: <20260320162634.GA1515@subdivi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

Hello,

I recently attempted updating my linux-firmware. This included updating
amdnpu/17f0_10/npu.sbin.1.0.0.63 to amdnpu/17f0_10/npu.sbin.1.1.2.64.
Once loading the new firmware, I see the following messages on a Debian
6.19.6+deb14+1-amd64 kernel:

amdxdna 0000:66:00.1: enabling device (0000 -> 0002)
amdxdna 0000:66:00.1: [drm] *ERROR* aie2_check_protocol: Incompatible firmware protocol major 7 minor 2
amdxdna 0000:66:00.1: [drm] *ERROR* aie2_hw_start: firmware is not alive
amdxdna 0000:66:00.1: [drm] *ERROR* aie2_smu_exec: smu cmd 4 failed, 0xff
amdxdna 0000:66:00.1: [drm] *ERROR* aie2_smu_fini: Power off failed, ret -22
amdxdna 0000:66:00.1: [drm] *ERROR* aie2_init: start npu failed, ret -22
amdxdna 0000:66:00.1: [drm] *ERROR* amdxdna_probe: Hardware init failed, ret -22
amdxdna 0000:66:00.1: probe with driver amdxdna failed with error -22

This indicates that the updated firmware is incompatible with a 6.19
series kernel. A web search suggests that a 7.0+ kernel requires a npu
firmware >= 1.1. This is an ABI break. When the interface changes in
incompatible ways, the firmware filename should change to avoid such
confusion. The firmware upgrade should be supplying both firmware
versions as long as 6.19 remains supported.

Helmut

