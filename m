Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E7606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=thelittleman.net header.i=@thelittleman.net header.a=rsa-sha256 header.s=20140415-thelittleman header.b=OcRk48xl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6894410ED41;
	Wed,  4 Nov 2026 08:58:05 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 20:56:04 UTC
Received: from mail.thelittleman.net (mail.thelittleman.net [91.99.148.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F5610E172;
 Tue,  3 Nov 2026 20:56:04 +0000 (UTC)
Received: from mail.thelittleman.net (localhost [127.0.0.1])
 by mail.thelittleman.net (Postfix) with ESMTPSA id 8ABDD5F92D;
 Tue, 03 Nov 2026 20:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thelittleman.net;
 s=20140415-thelittleman; t=1793738849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1YZpLjfbu6fNLdkBVvsc4d/vtdUbC5126/UpuwWjT4=;
 b=OcRk48xluXvjulj0mjLRYuQOra8JaZF3vUToOHWr1Q9S/Zvjj/ZXd8kEkzDZx0QVp8iLbv
 o84BgZMFykPizLZQsBd2NY83Ht94mG67fCQQy2A/H+8yRj2whLkruF/hpbuI2Y4n2YxRDG
 27WRS/3wn/l9qQb1sIoUd0YBFODrAxM=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:47:29 -0600
From: "David R. Hedges" <linuxdev844@thelittleman.net>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 4/5] drm/nouveau/kms/nv50-: don't drive outputs at 0 bpc
In-Reply-To: <sashiko-outbox-195931@kernel.org>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
 <20261103-nouveau-dp-fixes-v1-4-892f4bd357cd@thelittleman.net>
 <sashiko-outbox-195931@kernel.org>
Message-ID: <f3a2d8f720d1b619210067ad366fe7e9@thelittleman.net>
X-Sender: linuxdev844@thelittleman.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 13:41 -0600, sashiko-bot@kernel.org wrote:
> Could unconditionally defaulting asyh->or.bpc to 8 here break 6 bpc eDP 
> and
> 18-bit (6 bpc) LVDS panels?

Yes. ->detect() replaces the EDID on every probe, which resets
display_info.bpc, and for a panel whose EDID doesn't give a color depth
it stays 0 until ->get_modes() runs, so this isn't limited to a lost
EDID. For those panels, nouveau_connector_detect_depth() picks 6 bpc on
eDP and starts from 6 bpc on LVDS. Forcing 8 would drive eDP panels at
24 bpp and make nv50_sor_atomic_enable() override the VBIOS straps on
18-bit LVDS panels.

v2 will fall back to 6 bpc for eDP and LVDS and 8 bpc for everything
else, the same defaults nouveau_connector_detect_depth() uses before it
looks at the straps. On LVDS, that leaves the 18/24-bit choice to the
straps as 0 did, and eDP gets the depth ->get_modes() would give it
instead of 0, which trips the same watermark WARN as on DP. Calling
nouveau_connector_detect_depth() from ->detect() doesn't work for LVDS,
which needs the native mode that ->get_modes() sets up.
