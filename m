Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6C9CDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BAB10EE7C;
	Wed, 24 Jun 2026 10:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IFbx46fk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5918A10EE6D
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:15:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7790C60018;
 Wed, 24 Jun 2026 10:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123091F000E9;
 Wed, 24 Jun 2026 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782296132;
 bh=3Z6vVtiARmzoF0hJLufenUaSJACEjbpI3NSqndz55D0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IFbx46fkCBTQGNnbC3oEu0DISdYrL5s0fRmRq2Gnp2pFg/XIRQ/tBJKY9aGe7IRVS
 1lAliMUrW6gtNYTVDn5diB6xxWl+r9bqzp3RWTAfB0dMmeHMkK3YKOZWDA9m2co6h7
 ADjm5RB/YDKKCfgpk0DYQNvZVSzygDtE+W0nO3rghjQqTdFtnaWafldhVOG+FTxauF
 V4sIKxJewFeQ1cUjUFYzP0I9m0QTzK9qS0d1/xXkbSv0k1+oUcT6c6WlxZgadhtr1z
 PdNQ1pD6PAh+LWlkiVA2xKQkec2jRBEBylvcfd/cejnB0ogPx4+tHy/LnH6Lrb6jiD
 UXDJWeAMBd0ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/xe/ras: Add support for error threshold
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623101043.255897-4-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-4-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:15:31 +0000
Message-Id: <20260624101532.123091F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `threshold` and `reserved` fields are incorrectly swapped in=
 `struct xe_ras_set_threshold_response`.
--

commit b88a93d0104e4bd53859ba2c4b041330bc44ceef
Author: Raag Jadav <raag.jadav@intel.com>

drm/xe/ras: Add support for error threshold

System controller allows getting/setting per counter threshold for
correctable errors, which it uses to raise error events to the driver.
Get/set it using the respective mailbox command.

> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ra=
s_types.h
> index 6688e11f57a86..747b651880cd5 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
[ ... ]
> +struct xe_ras_get_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Current threshold of the counter */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[4];
> +} __packed;
[ ... ]
> +struct xe_ras_set_threshold_request {
> +	/** @counter: Counter to set threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold to be set */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_response - Response structure for set thr=
eshold
> + */
> +struct xe_ras_set_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved */
> +	u32 reserved;
> +	/** @threshold: Updated threshold */
> +	u32 threshold;
> +	/** @status: Operation status */
> +	u32 status;

[Severity: Medium]
Are the reserved and threshold fields swapped in this structure compared to
the firmware specification?

In xe_ras_set_threshold_request and xe_ras_get_threshold_response, the
threshold payload immediately follows the counter struct. Placing reserved
before threshold here shifts the threshold and status fields to different
offsets.

If this is a mistake, it could cause ras_status_to_errno() to read the
wrong offset and silently ignore firmware errors when xe_ras_set_threshold()
checks response.status, as well as log an incorrect threshold value.

> +	/** @reserved1: Reserved for future use */
> +	u32 reserved1[2];
> +} __packed;
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623101043.2558=
97-1-raag.jadav@intel.com?part=3D3
