Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648BCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18EF10FD1D;
	Wed, 14 Oct 2026 12:29:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D2010FD44
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:29:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 686BC60546;
 Wed, 14 Oct 2026 12:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF2E1F000FF;
 Wed, 14 Oct 2026 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791980950;
 bh=ou04b0/hFtdaOVEHHTNfPP1cCZvVZf6j4VI84q0WiWk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Xt7892Jy0n6EC0YO2YLdu/mTSi1jgJ/5gXXOwZ2GsnGDO3fS/SmBX/8nZjQs/QAh4
 1Klb3+ZNTo8HMpvShYos8H7tnn5TE6JRkoj+Eaj4t+QFv5Cile15hu3Wk0w3CrpqvS
 52Rx6d08+9xMU5fjvc1aB1/dnBY3LCikDiX/hiiR+2ICnSRlaJsS0QnYmNpPzIb0tO
 urzEY33DSzOsIDAvd4BtUKf3owCPfT5KMh7H9klQ/TjiDr9Rt4C9Qc/JHBeYfrBMCp
 0ZEQsCYXPl+BKuo8dCThX8XSPkKoxfOhzf47p8ML2GMJ0w41nCGMPGNrEwlRG8xmgX
 r3rmsw/AIINOQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261003030439.599330-1-mhun512@gmail.com>
References: <20261003030439.599330-1-mhun512@gmail.com>
Subject: Re: (subset) [PATCH] backlight: lm3630a: Cancel delayed work
 before destroying workqueue
Message-Id: <179198094807.807209.15203791412466567063.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:29:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Fri, 02 Oct 2026 23:04:39 -0400, Myeonghun Pak wrote:
> The interrupt handler queues delayed work to read the interrupt status.
> After free_irq() stops the producer, this work can still be waiting on its
> timer. destroy_workqueue() cannot drain delayed work that has not yet been
> queued by its timer, so the timer can outlive both the workqueue and the
> devm-allocated chip containing the work.
> 
> Cancel the delayed work synchronously after freeing the IRQ and before
> destroying the workqueue. This also waits for any running status read to
> finish before the chip's resources are released.
> 
> [...]

Applied, thanks!

[1/1] backlight: lm3630a: Cancel delayed work before destroying workqueue
      commit: 2cf184caab8b406fdd9db126ee40d62418237456

--
Lee Jones [李琼斯]

