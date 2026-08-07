Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101DCC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B5A10E45A;
	Fri,  7 Aug 2026 21:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="AR+k+BOq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDEB10E45A;
 Fri,  7 Aug 2026 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786136612; x=1786741412; i=w_armin@gmx.de;
 bh=ynAuYqRxpHHvvBQeKkL2i31ZDhBcUSyqeTHmWhd2yWU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AR+k+BOqNe6TJTuONOW6tClhewKZVZLP7jbbvFlTzJgsdyZ+YDYSyznu/xemrSYh
 5e3+pW7SxrSJ/p8ELKiaGXpfr8iYaNDd/jkZOt6BwArfREv1hnnMDCr/dl/i8x2nP
 1wL06078VNW9W+KDxy9kHX1JdQX2nDf5vtGmKPu0uFEjnVq/PGWhuLjm/h+7le5+5
 fqxoJ2r80IKgLFOMLoRo+XURUowQ4WDtyCmfue+l9dm+qV1MhjrFB4QayzLf5R66x
 EIp4glIBRoVsfxK2JQZCFwXOW5j9Nn4ruZ8zaRNfcMNjGIpDrSGddp/ATZNdKmcdF
 fK+cUeQ3Ur0DbrouVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1whDaB1b6x-008ngS; Fri, 07
 Aug 2026 23:03:32 +0200
Message-ID: <59aadf0f-953c-4b7c-8c92-9dd9bc4f89de@gmx.de>
Date: Fri, 7 Aug 2026 23:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] platform/wmi: Add aarch64 support
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@weissschuh.net, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
References: <20260724025959.142826-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20260724025959.142826-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XhWPv/JKs4wg1ltPcjA54qJdjyQYAJWIMSfQd03vtac47SDDNdn
 8VjSCgQ806r+Ys3YKucEiQIL6op5LNfCWBUZDrl74GW7ZUgltIaCaMdRFjvzDehSkQw395p
 XczQ0QCmtsEuQdRBq5uIyd2jW+EGD5vAIMZ8U2Ap4lGYlriV3kCZW5LqiU6SoK0v0LfamzK
 17YvP00mXx/53FXvjRA3w==
UI-OutboundReport: notjunk:1;M01:P0:JHOuLfo+bYw=;LeVQ+PkhJUxE5EPezqlRlsmB6Tn
 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
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

Am 24.07.26 um 04:59 schrieb Armin Wolf:

> The aarch64-laptops project found out that some Windows-on-Arm
> notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
> exactly like on x86. Those devices however are currently not
> supported by the WMI driver core due to only supporting x86.
>
> The first patch removes this restriction and allows the WMI
> driver core to run on all architectures that support ACPI.
> The second patch updates the acpi-video driver to take advantage
> of the improved support for architectures other than x86, and
> the last patch enables the generic WMI BMOF driver to support
> aarch64 as well.
>
> All patches have been tested on a ACPI-based aarch64 VM and
> work just fine.

Any thoughts about this series from the GPU driver people?

Thanks,
Armin Wolf

>
> Changes since v2:
> - fix Kconfig issue for the loongson-laptop driver
>
> Changes  since v1:
> - add additional tags
>
> Armin Wolf (3):
>    platform/wmi: Remove dependency on CONFIG_X86
>    ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
>    platform/x86: wmi-bmof: Move to generic WMI code
>
>   MAINTAINERS                                     |  2 +-
>   drivers/acpi/Kconfig                            |  2 +-
>   drivers/acpi/video_detect.c                     |  8 --------
>   drivers/gpu/drm/amd/amdgpu/Kconfig              |  4 +---
>   drivers/gpu/drm/gma500/Kconfig                  |  1 -
>   drivers/gpu/drm/i915/Kconfig                    |  1 -
>   drivers/gpu/drm/radeon/Kconfig                  |  4 +---
>   drivers/gpu/drm/xe/Kconfig                      |  5 ++---
>   drivers/platform/loongarch/Kconfig              |  1 +
>   drivers/platform/wmi/Kconfig                    | 14 +++++++++++++-
>   drivers/platform/wmi/Makefile                   |  4 ++++
>   drivers/platform/{x86/wmi-bmof.c => wmi/bmof.c} |  0
>   drivers/platform/x86/Kconfig                    | 12 ------------
>   drivers/platform/x86/Makefile                   |  3 ---
>   14 files changed, 24 insertions(+), 37 deletions(-)
>   rename drivers/platform/{x86/wmi-bmof.c => wmi/bmof.c} (100%)
>
