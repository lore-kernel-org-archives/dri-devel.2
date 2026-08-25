Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA858C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFD310E0D3;
	Tue, 25 Aug 2026 00:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kjPTRUhh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A617710E0D3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C78540A36;
 Tue, 25 Aug 2026 00:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72C41F000E9;
 Tue, 25 Aug 2026 00:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787619227;
 bh=XNrl5LBPAWI7aTJ5O2AHCh+GOVtZ+dqPxUS2v5/G7TI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kjPTRUhhqKwfEqQMSujmQUwp1mD7WH/ZtI676BtixIGFZsmd7wO7KqsM+geqQcBA/
 /qmXqTpdIJbvPE64Qn6I6uDnjjIOD/nFNa6TkAdXEcsm+ZujupDiErg4BQ1GdSNAIo
 ZixXWhC/Ci/A1ZEnY/lwkpDbwJef3MwisJhmy5csfwhESSyNTFfm+iE1X3oI9CsN7K
 vHzy1d5C2CoQCkR3itfv6Nq43B29+HTWcgYfAjuG2woXZEJ17GaBVK5ucoMfZKOpnB
 7ns9I+Ipzx3npg5YkzbpObh91P99wqRkKajQsuILKLCZh+hC4XhncYbpDhgcni13/e
 fvKub03yv7XBw==
Date: Mon, 24 Aug 2026 19:53:41 -0500
From: Rob Herring <robh@kernel.org>
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 4/5] accel/ethosu: propagate SRAM initialization errors
Message-ID: <20260825005341.GF50486-robh@kernel.org>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-5-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717061145.1478139-5-zhaoguohan@kylinos.cn>
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

On Fri, Jul 17, 2026 at 02:11:44PM +0800, GuoHan Zhao wrote:
> ethosu_sram_init() returns -ENOMEM if allocation from a declared SRAM
> pool fails. ethosu_init() ignores the error after recording the pool size.
> Probe then registers a device with a nonzero SRAM size and a zero sramphys
> address, allowing jobs to program address zero for SRAM.
> 
> Propagate the error and synchronously suspend the device before the probe
> path releases the scheduler.

If the SRAM is not available for some reason, then we should just set 
the SRAM size reported to 0 rather than failing probe.

Rob
