Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F4CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A3210F50E;
	Fri, 26 Jun 2026 08:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sSYV2gbW";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE910F502;
 Fri, 26 Jun 2026 08:53:25 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gmqFr5M37z9tsY;
 Fri, 26 Jun 2026 10:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782464000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8ththMBG+84d8ctaLVozbhNg629lcbcbIJXlC8vPYc=;
 b=sSYV2gbWRD8EpJdL+FgRmhxlqbGnugHjH9TdZydsrY5QlqaDQwv/UYrZL+CjnJgLdIlraD
 QpIthiSHBXWErDXVnH4Ct0q6yCG77seXX8NU6Da67AbtDMUoMFIMgpXtbMSxvvABmIHASC
 h8kboyCurkg3L4j8Fg91bMv4u4aanxpJ0dHOlF7apBe/ui4PYSsne86EvsEX48LZ+guhR7
 KxCn6eGHO4vGhem50G5lveeX+3u51c8ApRI4BTXmkvwWsEjrP8n+yTfzZyzUuL5gBfqEnL
 B8VSfFE6sxdPTlZfbujKRBY0zBmMUwTj7OHuN9hsnXW3v5Ye7fE8iK/Wy1+rsg==
Message-ID: <7a474010-67a1-426b-9ca2-76c11cfbb0ac@mailbox.org>
Date: Fri, 26 Jun 2026 10:53:15 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH] drm/amd/display: extend HPD debounce filter to
 DisplayPort SST
To: Nick Haghiri <nick@haghiri.net>, Ivan Lipski <ivlipski@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Xaver Hugl <xaver.hugl@kde.org>
References: <20260625150439.330875-1-nick@haghiri.net>
 <928d4c2a-d8b7-43d7-995e-a3e6996d2952@amd.com>
 <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4atn6ks4z84yes6ty6tdpkipeqfayuif
X-MBO-RS-ID: 9796ec2181fda82a13a
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


[ Adding Xaver for awareness ]

On 6/25/26 21:45, Nick Haghiri wrote:
> On 6/25/26 3:15 PM, Ivan Lipski wrote:
>> I don't think I've encountered a situation when a monitor with DP can
>> wake a system up from DPMS, so that's interesting. What distro and
>> desktop environment are you using? I'd like to reproduce this issue
>> and help with it.
> 
> openSUSE Tumbleweed, KDE Plasma 6.7 on Wayland (KWin). GPU is an RX 9070
> XT (RDNA4), monitor is an MSI MPG 274U over DisplayPort SST.
> 
> What happens: when the output goes DPMS-off and the monitor drops into
> deep sleep, it briefly de-asserts and re-asserts HPD. amdgpu forwards
> that as a hotplug, KWin re-probes and re-enables the output, and the
> panel comes right back on, so it never actually stays asleep while
> connected.

FWIW, that the panel comes on and stays on might be a KWin bug. Mutter had a bug like that, which I fixed in https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4209/diffs?commit_id=ec73076e07640fc0752d9ecc66c5934726db2d7e.


P.S. For other reasons, mutter also has debouncing similar to this. If the kernel debounces as well, it'll take longer until mutter actually removes an unplugged display from its display configuration, hopefully not too bad though.

-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
