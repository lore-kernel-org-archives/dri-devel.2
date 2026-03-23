Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0069EC01B6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1539610E4B3;
	Mon, 23 Mar 2026 09:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g4R0izOF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A6E10E4B3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:57:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 794B143F30;
 Mon, 23 Mar 2026 09:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB4C4CEF7;
 Mon, 23 Mar 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774259844;
 bh=gRh5APmEZoL+PCyEZvnv2xN1B3en8Ns9D/n0z8iaxBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g4R0izOFJoLr+RY7wW6q6gHNB7yQudIc04pJgXeAIwJ239kqv/JbRYRpU5JH+iUAv
 JupXG4sO7npwob97zlSwBJW8vYP9+qAPTQ5RK7aT5ZO7tueXiBsQGxtcbkeyU9wj5S
 Qo/JSFcbGOf83jTPZsXwi7JyePUxC/32UrQfXUNdRRO7ziRgQcSDns54jkSUUL99YP
 W/tflhveyuTEIrhtcKgT1u757xG2aBFRhafGEVM5FqqWib075dpzVdmzut0hO6BMkX
 KqTBw8JAf3AgkPT/3/L7mvJxLn5KYCWrfAvPv/vNVkm+3cokYm5jhueSZjggTy5QV4
 WD2kCDP+tbEKQ==
Date: Mon, 23 Mar 2026 09:57:19 +0000
From: Daniel Thompson <danielt@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lee Jones <lee@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
Message-ID: <acEOf2pI_NpfA4EP@aspen.lan>
References: <5084777.GXAFRqVoOG@rafael.j.wysocki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5084777.GXAFRqVoOG@rafael.j.wysocki>
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

On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the Apple Backlight ACPI driver to a
> platform one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
