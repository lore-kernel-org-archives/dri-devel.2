Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AC8D6AB01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 20:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F42E10E376;
	Thu,  2 Apr 2026 20:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A19SlO8u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FCD10E376
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 20:16:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 746EA60123;
 Thu,  2 Apr 2026 20:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04294C116C6;
 Thu,  2 Apr 2026 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775160972;
 bh=UDf5S0/eqXCSush/2QWvIcoWCzUaIiWdlvm1anNpGTA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A19SlO8us1fnFLpujzh7Sbk0kauk/8jeAl0m0AgC4+/Cbsp5c4KvB+Y3pje5uD0TX
 9NPStWxzROR1wCqis7H61FsYovYfwZDKDIih+iKST9Q4rTKYi5Aa0GIMDBVowdFd8H
 1fUu7/8HX3WUajfKtxIqKhspoMACcR6gAQ6UoBjqj+Qd/tHqqgm8wW6MkSW6nkMRLw
 RPpGECMdRN5uQMIm77aCEMms7RFXlG4jb2t4y7QyMB/A/EjsqbzOZsReE24sUQMNMu
 t5fxvV6D5vOdKlM7hFXy1/5YMplFSIyduqGTnxwSJHu0qW9x9V/MbJepHDnpePyCgg
 5mKiOZFNvXEaA==
Date: Thu, 2 Apr 2026 15:16:10 -0500
From: Rob Herring <robh@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: dri-devel@lists.freedesktop.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: ethosu: Add hardware dependency hint
Message-ID: <20260402201610.GB966967-robh@kernel.org>
References: <20260401122323.6127a77c@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401122323.6127a77c@endymion>
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

On Wed, Apr 01, 2026 at 12:23:23PM +0200, Jean Delvare wrote:
> The Ethos-U NPU is only available on ARM systems, so add a hardware
> dependency hint to prevent this driver from being needlessly
> included in kernels built for other architectures.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  drivers/accel/ethosu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Rob

