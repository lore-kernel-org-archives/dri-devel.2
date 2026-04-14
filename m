Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707FF9D0E4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0F610E1B4;
	Tue, 14 Apr 2026 16:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t4JKrsQW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87F410E1B4
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:22:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5428841567;
 Tue, 14 Apr 2026 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E2C19425;
 Tue, 14 Apr 2026 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776183723;
 bh=3LdZ7+x9wtSvMucKYNzrVg39qnVbee3MxWzoH/d3IlM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t4JKrsQWDLSfwgCk1aZThCGMyvzBcPnFXmm/+d6xC5T13xiigZ8n2EcjS2T3uFsTS
 GELD4hmhQAEZ7A4ISnlxj4EuXQ9tMra6oBiBP+aO5bjfrM1RKhH/81lsFL1tFGxaD4
 pPq14pgjoBPqehu/WOtjAnhiCU28IJBDEzi4U6FnJp2rjBuSzBjYeLc1U1wHb8nRy5
 5O5qv7DrO7REGF/6XgooC/TamwPXaWBxt8Z8WrE8v4A4ZcNIq1oGMMqolmKIcZDtS4
 oA20t+10Ei0VK9ygfJ0XcYBcEr1wRwppPdVVqcEyAR/jvnXw8i+ec7p9Rm14LbXgpt
 uYMIPPk8P5TZQ==
Date: Tue, 14 Apr 2026 17:21:58 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: cgbc: Remove redundant X86 dependency
Message-ID: <ad5pplCLAdvohy04@aspen.lan>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
 <20260327-backlight-cgbc-remove-x86-dependency-v1-1-4851c9e95371@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-1-4851c9e95371@bootlin.com>
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

On Fri, Mar 27, 2026 at 08:39:32PM +0100, Thomas Richard wrote:
> The backlight driver depends on the MFD cgbc-core driver, which already
> depends on X86. The explicit X86 dependency for the backlight driver is
> redundant and can be safely removed.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
