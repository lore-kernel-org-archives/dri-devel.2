Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79884F9D0E2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96A310E621;
	Tue, 14 Apr 2026 16:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bLO5NtAY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F1C10E624
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:22:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E076360018;
 Tue, 14 Apr 2026 16:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7005C19425;
 Tue, 14 Apr 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776183743;
 bh=7QPQx98w0vfSRTmQEZsX9ZnLp6xe+L/O04W9VIyKjf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bLO5NtAYQ3osx0vyOtFP1RnfpoGlWrjRR97Mxf9XLnThmWAGOO9tg2Hqqa+qIwRgt
 2mfYUWa9PhPht7lmX60IpLZNfYxuhAHNl/OuMIkc4H0Zixl9Md1gCoAJbhAnKBBBmf
 CbPqa1Sjm2covRdFAdBBPhw8mtkvgSsnCIX27tSgBjQMX6+bInyYGfwaMmvewPaEqy
 Q+Z1ftzFyrxsXjO0yf7jCFHjZVw66+3KGQPvFNh9Lwd9DWLhyJ+dkgVEh0dmN0Ij01
 W90XDZ26CR7ri4yB5oJcuAapKP8AZY+aC0Qdbyw9FERiZzjgYyB2kdeKoxaSXHH9k+
 GwFhCLAn5YbhA==
Date: Tue, 14 Apr 2026 17:22:18 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Add cgbc backlight driver
Message-ID: <ad5purZ0jef5a1KR@aspen.lan>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
 <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>
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

On Fri, Mar 27, 2026 at 08:39:33PM +0100, Thomas Richard wrote:
> Add missing backlight driver in CONGATEC BOARD CONTROLLER entry.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
