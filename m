Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58723CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE7910E082;
	Sun, 11 Oct 2026 16:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SvOfPrKI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C6A10E082
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 16:33:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A19C42B62;
 Sun, 11 Oct 2026 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7C11F0089B;
 Sun, 11 Oct 2026 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791736435;
 bh=uD3Wpx0T5ehE2s2XDi6c8Jflhb+BEWrMVlMvLIr9wUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SvOfPrKIsuAy3Yzm/IKedxehCl2JX7hwYkEtsXUpRExj2E0YBkTdYbW8Z08BUEDN6
 cHILVVL8NP5NFIm6/EX/oNLBWNX6sFG945FePUzqIJ5sq69jBszbnUf+g8sY+wE+ps
 UpupgxwVgKP8l3Wqsbq4iojBuPERqq4OPMBg6pSBXyaWNLCPOKle9kxUkTlXKNLU4n
 T+6Ps05ZkMQA7sPpewoC4T+tjrEjejQZUVA5Kmo9s1rCtM8ZtH0bz8fVK89hRFS0UN
 VQ6oXKNk5XD2n1C3YVvflQNB0dsQZaLoFprWAD2DJIlnNo2ynAHWnN5uGJaga+zHH8
 G6nZ2nw/tD7fw==
Date: Sun, 11 Oct 2026 22:03:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v7 0/7] Qualcomm Sahara protocol enhancements
Message-ID: <asu5x72z9-p0U8G0@debian>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
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

On Thu, Oct 08, 2026 at 11:53:44AM +0530, Kishore Batta wrote:
> Hi All,
> 
> This series reworks the Sahara protocol driver to make it reusable for
> multiple MHI based devices and adds support for capturing, restoring and
> exposing DDR training data using the Sahara command mode.
> 
> The Sahara protocol is transported over the MHI bus and is used by multiple
> flashless devices to transfer firmware images, retrieve memory dumps and
> exchange command mode data during early boot. However, the current
> implementation lives under the QAIC accelerator driver and contains
> device-specific assumptions that limit reuse.
> 
> Some MHI devices (for example, QDU100) expose the sahara protocol directly
> on a "SAHARA" MHI channel and rely on command mode to exchange DDR training
> data with the host. The existing driver does not bind to such devices and
> ignores Sahara command mode packets, causing training data to be dropped.
> 
> This series addresses these issues by relocating the Sahara driver to the
> MHI subsystem, centralizing device specific configuration and adding command
> mode handling for DDR training data.
> 
> Overview of the changes in this series -
> 1. Move Sahara under the MHI subsystem:
>    a. Relocate the sahara protocol driver from QAIC accelerator tree to
>       drivers/bus/mhi/host/clients directory.
>    b. Register Sahara as an independent MHI protocol driver.
> 
> 2. Generalize device matching and configuration
>    a. Allow the driver to bind to devices exposing the protocol on a
>       SAHARA MHI channel.
>    b. Centralize firmware image table selection at probe time using a variant
>       table, instead of scattered conditionals.
>    c. Preserve existing behavior on AIC devices.
> 
> 3. Add QDU100 firmware image table support
>    a. Add a QDU100 image table and select it based on the matched MHI channel.
>    b. No separate client driver or registration mechanism is required.
> 
> 4. Add Sahara command mode support for DDR training.
>    a. Handle command mode packets(CMD_READY, EXECUTE, EXECUTE_DATA).
>    b. Query supported commands and retrieve DDR training data from the device.
>    c. Allocate receive buffers based on the reported payload size and copy
>       raw data from the MHI DL.
>    d. Store training data in controller-scoped memory using devres so it
>       survives sahara channel teardown.
> 
> 5. Expose DDR training data to userspace
>    a. Add a read-only binary sysfs attribute under the MHI controller device.
>    b. The attribute reads directly from controller-scoped storage and remains
>       available after the Sahara channel device is removed.
>    c. Cleanup is handled automatically via device-managed resources.
> 
> 6. Document the sysfs ABI
>    a. Add ABI documentation describing the DDR training data sysfs node.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>

Series fails to apply to mhi-next branch. Please rebase and resend. Since I'm
about to send the PR for v7.4, this will miss the upcoming cycle. But I can
queue it once v7.4-rc1 is released.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
