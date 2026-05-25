Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDC8CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E945E10E021;
	Mon, 25 May 2026 07:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H2k8n5OT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2128F10E021
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779693944; x=1811229944;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p/WBw4ZtiYJdfAWpVnnvpD2JchFuoyR/8fyPN2vfvvw=;
 b=H2k8n5OTNtzXptSkebeji4u/8kk0RmluzGKKS96LwV8m0xF4T1essZGs
 a3WZG96+cpwXp9X3smrNqMO4a7Hxx84T6l6Zcj7q3HOJEQfxyfIiLAUTg
 WhejkYtnc73fG5lMMWQunxDz4on3Ju0re9aZg8g0LfHgNDBjjmv+X+vu3
 ruysElDjgSaxTrkhZJnWONUstH3eMcKNE0cBe1a6ADdS5jtXS79hbJXrw
 +h3wArtAZb1CDgnxqtlbUOp7Or80PrFU433at/iBnO9p83zjQr2NtWVhn
 aQqle6rDRkwOWtWAWgMMnZoq9paH/m4fQnerNgrDKzTxy9dCcErSf1VAQ g==;
X-CSE-ConnectionGUID: zC2LwhvrRoCY2lVaqKLb6w==
X-CSE-MsgGUID: kOXfbG82Q8mpAmBdd1mWTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80496024"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80496024"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 00:25:44 -0700
X-CSE-ConnectionGUID: Ju3bcPuDQEqmKL7QWAQOdg==
X-CSE-MsgGUID: sGF33ASrRuGpEqqICiX91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="245803354"
Received: from unknown (HELO [10.217.180.37]) ([10.217.180.37])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 00:25:42 -0700
Message-ID: <9a6b239c-d970-4ec3-abf0-6b900b786279@linux.intel.com>
Date: Mon, 25 May 2026 09:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: prevent uninitialized data bug in debugfs
To: Dan Carpenter <error27@gmail.com>,
 Karol Wachowski <karol.wachowski@intel.com>
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ahP24m6Mii9EDL7Q@stanley.mountain>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <ahP24m6Mii9EDL7Q@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 25-May-26 9:14, Dan Carpenter wrote:
> The simple_write_to_buffer() will only initialize data starting from
> the *pos offset so if it's non-zero then the first part of the buffer
> uninitialized.  Really, if *pos is non-zero then this code won't work
> so just check for that at the start of the function.
> 
> Fixes: 320323d2e545 ("accel/ivpu: Add debugfs interface for setting HWS priority bands")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>   drivers/accel/ivpu/ivpu_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index 189dbe94cf14..dc20bc73c6ed 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -450,7 +450,7 @@ priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t
>   	u32 band;
>   	int ret;
>   
> -	if (size >= sizeof(buf))
> +	if (*pos != 0 || size >= sizeof(buf))
>   		return -EINVAL;
>   
>   	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, pos, user_buf, size);

Thanks for submission.

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
