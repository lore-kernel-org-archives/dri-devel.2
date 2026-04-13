Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E676F34C47
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9377610E413;
	Mon, 13 Apr 2026 11:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CU1u105b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EABE10E412
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:59:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 140F560180;
 Mon, 13 Apr 2026 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D8C116C6;
 Mon, 13 Apr 2026 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776081593;
 bh=UrzM6k48bP3yTeLyeaejjl6zsZoyQg44ZBm9DYxWGxM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CU1u105bdVkDH4RtRM2qha13h93IdiDcgQMb9mhgoYn3SE4wtYzwM5jedg1I5LsuJ
 6cQXqu7mdvwdw9soqXKiUpr0NslP6FjCddc+ZD6E6RPoLDWc2JlZrhI1UAfugoN2ft
 yOfEHFY2kTeJgSA0/AB9nwfGIdtuQt9yQS1fYLahZZe/mF1f4pknSS/nZZ5pHCWYi7
 k9wFKXVYXb1AP00TvwmEJ2pgFdhxsCGkC6xYxC1ohgwFVCpWsnoglAA8cNQRsBZG11
 nu3KS2oHmcioPIW7F6RilFx7i5F4yGrespPundbv5NMR2JIaGp4TlWXAw2Szm/ommI
 rCSQNBGad5OKg==
Date: Mon, 13 Apr 2026 17:29:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v4 9/9] Documentation: ABI: Add sysfs ABI documentation
 for DDR training data
Message-ID: <yttrssaw4k2vx7r6l4vsb535qcrr4phsgj6qlnu2r764inai7o@d4qgr7uu5t2s>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
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

On Thu, Mar 19, 2026 at 12:01:49PM +0530, Kishore Batta wrote:
> Add ABI documentation for the DDR training data sysfs attribute exposed by
> the sahara MHI driver.
> 
> The documented sysfs node provides read-only access to the DDR training
> data captured during sahara command mode and exposed via the MHI
> controller device. This allows userspace to read the training data and
> manage it as needed outside the kernel.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>

Ah, this should be squashed with previous patch.

- Mani

> ---
>  .../ABI/testing/sysfs-bus-mhi-ddr_training_data       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> new file mode 100644
> index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
> @@ -0,0 +1,19 @@
> +What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
> +
> +Date:                   March 2026
> +
> +Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
> +
> +Description:            Contains the DDR training data for the Qualcomm device
> +                        connected. MHI driver populates different controller
> +                        nodes for each device. The DDR training data is exposed
> +                        to userspace to read and save the training data file to
> +                        the filesystem. In the subsequent boot up of the device,
> +                        the training data is restored from host to device
> +                        optimizing the boot up time of the device.
> +
> +Usage:                  Example for reading DDR training data:
> +                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
> +
> +Permissions:            The file permissions are set to 0444 allowing read
> +                        access.
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
