Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4EC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E459210E7B7;
	Mon, 10 Aug 2026 11:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dTFWa39W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF4A10E7B7
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:11:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E4D041467;
 Mon, 10 Aug 2026 11:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC51F00A3D;
 Mon, 10 Aug 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786360276;
 bh=OYpEnC1uFpNkW7CzGUa5yZRpTMO0OmVPr30M8mDEOxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dTFWa39W0wQurWMCPLwzB2dxPqXJ/lOtcb+6us+vUyvMEOgX5k/CfI3nn4IDIUQGh
 1qcERn8pT0HE7ibBqEaHKHLZgtEn6OTWZOi3zwBDLMeO3aP5b9YZxe7XSw/Dz//uvi
 Pf/SnikSROEv7l80Ae86SP0DgyK7xFojj0DkFQ+QTXFAJi146riZFPUiQ+ghVepxoP
 6HQV8lIX1jmXK/acMxroLNlo2kvhm9kr7UmIQ3ZfP5CzmHRxArMhLVnTWOT2NyOkjo
 QuJJ/jI/g0fc8xWqzqDgUrxZYv+mpdYvExw7o0GITcVHSZ0QUfWdPWT3hDCv9O+RtN
 a+bdP7l3jAjvA==
Date: Mon, 10 Aug 2026 12:11:12 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
 "open list:BACKLIGHT CLASS/SUBSYSTEM" <dri-devel@lists.freedesktop.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] backlight: qcom-wled: Remove redundant dev_err()
Message-ID: <anmx0GEAY0SeMdW_@aspen.lan>
References: <20260722065709.346072-1-panchuang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722065709.346072-1-panchuang@vivo.com>
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

On Wed, Jul 22, 2026 at 02:57:08PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
