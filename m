Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F184CD5BC9
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 00:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD77E10EB02;
	Thu, 28 May 2026 00:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="dyisPlEH";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Thu, 28 May 2026 00:37:48 UTC
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C3E10EB02
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:37:48 +0000 (UTC)
Message-ID: <935aaec5-5417-3cde-f944-3c04ffbd3458@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779928342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NU+WkG0JMZCGGSqCR8dN7ZBIBOJxhf8qjGX+ma2NsKg=;
 b=dyisPlEHNGROmDO3PIu1xSoLKqbJ5ya7lkt4PEAUuiOJahBM0lcV7KL1qiKyDISpRWGvHn
 PU9aaAfjRJt1t0zYYK+VV8AbVWnhtYyWhAho5LVkMGWMq37hd+4E6BJrMBblf7z4Ug1ArL
 mdEYdaIAxL+2EOtvyfHtndikc337ELA=
Date: Wed, 27 May 2026 20:31:59 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] drm: zynqmp_dp: Fix uninitialized variable in debugfs()
Content-Language: en-US
To: Dan Carpenter <error27@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ahP3Xagt1LJrhmFl@stanley.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ahP3Xagt1LJrhmFl@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 5/25/26 03:16, Dan Carpenter wrote:
> If the *ppos is non-zero then simple_write_to_buffer() will not
> initialize the start of the buf[] buffer.  It doesn't really make sense
> to allow non-zero values for *ppos, so check for that at the start and
> return -EINVAL.

non-zero ppos seems to be handled properly by simple_write_to_buffer.

--Sean

> Fixes: 28edaacb821c ("drm: zynqmp_dp: Add debugfs interface for compliance testing")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>   drivers/gpu/drm/xlnx/zynqmp_dp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 7fb11b0a44f0..847179476041 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1888,6 +1888,9 @@ static ssize_t zynqmp_dp_pattern_write(struct file *file,
>   	ssize_t ret;
>   	int pattern;
>   
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
>   	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf,
>   				     count);
>   	if (ret < 0)
> @@ -2028,6 +2031,9 @@ static ssize_t zynqmp_dp_custom_write(struct file *file,
>   	ssize_t ret;
>   	char buf[sizeof(dp->test.custom)];
>   
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
>   	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
>   	if (ret < 0)
>   		return ret;

