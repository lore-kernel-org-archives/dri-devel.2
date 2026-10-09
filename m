Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2136CCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E7110EA93;
	Fri,  9 Oct 2026 17:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wmxowf33";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00D710EA93
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCE8960DC6;
 Fri,  9 Oct 2026 17:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4B1F00898;
 Fri,  9 Oct 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791565831;
 bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wmxowf334BkRZFU6Sq+uwK2c5v9j4EnLSle+yuIxbw0dZoW2zbp0fanJ3gjkSzjlg
 ++J5V5kaKFWyO50Jl1QWmLE98n1bC9sGm9nyBGYh2S3xa2FjRSCHhuqsUO41nflxsE
 HF2AgCutPzPCaKnIxuPIaY9WkS0OvpankhXXAzlwqBkuVCvMpnPGAmwupB4qR1BX4q
 y7pVdBA7HD2YGln5FnmdyMGutGkG+xpvhjIoiak5Nrz8n5urXSS1zeK4oPcAT+KvjI
 1SMKLjs3nGGyEl61xuJW/lbEGxNl3dMETwT3QENiyz1QiYF+b9OzkVDVLfQLr1X7dM
 Ivjwqv6bRwygg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Helge Deller <deller@gmx.de>, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Fri,  9 Oct 2026 13:09:46 -0400
Message-ID: <2026-10-09-1-daily-reply-0009-hyperv-fb-removal-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
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

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
