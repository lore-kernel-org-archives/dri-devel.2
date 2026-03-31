Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7FFF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2EC10E8E3;
	Tue, 31 Mar 2026 10:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQV6GpZ3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582D110E8E3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:48:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 75F5A6001A;
 Tue, 31 Mar 2026 10:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE43C19423;
 Tue, 31 Mar 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774954110;
 bh=+pdx9CboE/37M0KLJVQhp4sepscwIcmqL2aP3WoAHi8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bQV6GpZ3+QpAb1HXoZY/vUrBxToOG4ZidqJttDRquwa6vTqViKJUxhBWKD7RkIMJZ
 bgRB0oeSDXMecE9GvXtjE2mcG0Foy7jaOFPkJA5BndyVsLwzlQzY02VnmVFcIM73uJ
 jJ3HZLkD5DqRbBKEgs8L7OZlkrq3VwMZXWU2KxHjsZc0rHg5yjL/Bw/MuAlNVt3c7G
 2L8GbRmX46I7dies1f/80rLZSNwzZMbtSHJva75faWSh6tE4AnHpsFiHDaduS02f+L
 LKdtyyKp3VbAEUty7ttD2T9AOOWIZ6puR2Uv84fNrzrwe3BLjumpk0qf5R/Q13i5sW
 jED+bI6jEN17Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <5084777.GXAFRqVoOG@rafael.j.wysocki>
References: <5084777.GXAFRqVoOG@rafael.j.wysocki>
Subject: Re: (subset) [PATCH v1] backlight: apple_bl: Convert to a platform
 driver
Message-Id: <177495410819.3826141.10439293270550177913.b4-ty@b4>
Date: Tue, 31 Mar 2026 11:48:28 +0100
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

On Sat, 14 Mar 2026 12:50:11 +0100, Rafael J. Wysocki wrote:
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> [...]

Applied, thanks!

[1/1] backlight: apple_bl: Convert to a platform driver
      commit: 04d8f3fd0b52ead84eb722989afa094b8fca9129

--
Lee Jones [李琼斯]

