Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D492C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA78E10F212;
	Thu, 16 Jul 2026 08:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="eaceIWiM";
	dkim-atps=neutral
X-Greylist: delayed 430 seconds by postgrey-1.36 at gabe;
 Wed, 15 Jul 2026 14:44:42 UTC
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com
 [207.54.77.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE4210E07F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1784126683; x=1815662683;
 h=from:date:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vDeU+4zPoXa2rfas9DIJC/ack9B6GVrM3PJsqOJIVfM=;
 b=eaceIWiMsEurnZPHFEGHkOySUY1wSllQAoxYHqkgjh4i5PH28JU/fFji
 a9maZVMdhXCho2Llc8wON++HCG4AP6Fk92qxmZ3BUDYp/a9FloxXLZrnv
 D0k2YadCHAPWD5TBNBeGxfkzn1HcxPk7/VeiJpG8bxQxfij+c0WY2qh1x
 CXdTvlQcZkguA1AilbLFlgDrIod9bkIprV9C7VITgAP4xOXd3M2uPFl07
 +jWQkms0lvRVcSzYa6HF2H6bBfPTEYm5sNFQz8hjN7S1DSAT8YPG0IALS
 REOp4LVQeIFW0Hb999XSnilhR51pSn8TEAqoLoR5KDaHeminMo3YQvV+w g==;
X-CSE-ConnectionGUID: wgPlpNC8Q7WW7b3WFmT0Tg==
X-CSE-MsgGUID: 10ghzsQMR1yvQeEIDqh7bQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
 by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 17:37:30 +0300
X-CSE-ConnectionGUID: Z+9tdsEtT2W3xzX1rtWN6Q==
X-CSE-MsgGUID: TKtZWjU+SviYd6krL0Q0FQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
 by ces04_data.me-crop.lan with SMTP; 15 Jul 2026 17:43:04 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation);
 Wed, 15 Jul 2026 17:37:29 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Wed, 15 Jul 2026 14:45:58 +0300
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
Message-Id: <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
In-Reply-To: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:21:06 +0000
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

On Wed, 15 Jul 2026 15:48:05 +0530
Aniket Randive <aniket.randive@oss.qualcomm.com> wrote:

> This replaces the fixed 1-second timeout with a transfer-specific
> timeout while preserving sufficient margin for software overheads and
> bus-level delays.
> 

The dynamic timeout may be useful for any I2C bus controller, not only
for qcom-geni. Structure i2c_adapter already has field "timeout". Isn't
it worth to move the timeout calculation to i2c-core, so that the core
updates the timeout field in i2c_adapter structure, and the controller
driver just uses this value, instead of duplicating the calculation in
every driver that will use this feature?

Also, such parameters as I2C_TIMEOUT_SAFETY_COEFFICIENT and
I2C_TIMEOUT_MIN_USEC may be configurable by user (for example, in
device tree) for more flexibility.

Best regards,
-- 
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

