Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A80C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F8610E751;
	Thu, 16 Jul 2026 11:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZZazAIO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEA310E751
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:26:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 886796001A;
 Thu, 16 Jul 2026 11:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCF1F000E9;
 Thu, 16 Jul 2026 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784201192;
 bh=yc6wXkbLTvWaqUxVj3VjWfyBF35rftwJBnNLuh/ixWY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KZZazAIOjasuoeHcbFpneaGytz0cv4lcFU0wIOhIddGLHs9CRIxCFgkWz+YO3TobF
 ikUvKSc2IUpuTWUf5/HJRWHwgV6pHwiuyOEje+CbcwgZG7KwG465DKoTyLajK6TG1u
 mCLQubpNkby5hd8cGe75vY91LYbX2668UrUXB6msNcOjav4Ycg1vITdi+3NT1P02RW
 jcZeTislKoJxPN1gRo9TrmDuxdmf56VfPVIVF3IeL1Mjz7c+/eTBlIvbrUWOLiLPp7
 2bnkH7+LtnDt82bNaAZc4EK2S9mGBfwczVzUYjnJusMof6/284Nu7QTm3msVfuop8k
 oYDFZgmApS9zA==
Date: Thu, 16 Jul 2026 12:26:28 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ramiro Oliveira <ramiro.oliveira@advantech.com>,
 linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-watchdog@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 1/8] Add Advantech EIO driver
Message-ID: <20260716112628.GB1260374@google.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-1-76e5e41026db@advantech.com>
 <20260714160814.3CA9B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714160814.3CA9B1F000E9@smtp.kernel.org>
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

On Tue, 14 Jul 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 15 potential issue(s) to consider:
> - [Critical] Driver uses zero-initialized `pmc[0]` array without verifying if the primary EC was successfully initialized, causing unintended I/O on system port 0x00.
> - [High] Missing success return for supported legacy code bases in `firmware_code_base()`.
> - [High] Incorrect validation of `devm_ioport_map()` return value.
> - [Medium] The `mfd_cell` array `eio_devs` is not declared as `const`.
> - [Medium] The driver uses `PLATFORM_DEVID_NONE` instead of `PLATFORM_DEVID_AUTO`, risking sysfs naming collisions.
> - [Medium] `acpi_ram_access()` truncates negative error codes into positive 8-bit integers.
> - [Medium] The requested region for the PNP base ports is off-by-one and fails to reserve the data port.
> - [Medium] Missing resource request for the dynamically discovered PMC command port.
> - [Medium] Unaligned memory access and endianness assumptions in `info_show()`.
> - [Medium] The IO port memory mapping is sized statically up to `0x49A`, but accesses dynamically discovered hardware registers which can exceed the mapped bounds.
> - [Medium] `pmc_clear` checks the wrong status bit (`IBF` instead of `OBF`) before attempting to clear pending garbage data.
> - [Medium] Hardware PNP configuration mode is left unlocked on error and skip paths in `eio_init()`.
> - [Low] The commit message prefix violates MFD subsystem naming conventions.
> - [Low] `MFD_EIO` uses the `isa_driver` API but lacks a Kconfig dependency on `ISA_BUS_API`.
> - [Low] Driver-specific header file is improperly placed in the global `include/linux/mfd/` directory.

That should keep you busy for a while.

Dropping this from my queue.

-- 
Lee Jones
