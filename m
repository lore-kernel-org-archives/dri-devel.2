Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4742DFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6D510E70F;
	Mon,  4 May 2026 13:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aOuouZxF";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A780A10E70C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 13:56:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9045C4E42BBA;
 Mon,  4 May 2026 13:56:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 66D495FD5F;
 Mon,  4 May 2026 13:56:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2F69411AD220E; 
 Mon,  4 May 2026 15:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777903000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qgw6CpMOSFWIemSr8SVzTDICzBHegJK/gabMjw9JaVo=;
 b=aOuouZxFbEtc7NlEEX0YUd8ia4pq43moq6iDY1kdaPyir/76F0Spyzz87uuwstaMaPn7cB
 dt601R3j6NdnnwkysjkVlZUb+Dsy0XNLAPJxRLBm5gdfrnX2Q8y0SQsSIY9zEODPta8KPK
 shbpOZ6veFlapG+L6L9cmyly8aFP441LCn+rE/jIx8mEzfkjzQqfns1n0atkjxFoBgdlI0
 vgBCRH7OilJ2+Azp9LadSemjnOlXkNhJRE0kTJGRIsV4dualxDhQSElpXJiuQ+jHMh9dWt
 i5lhCJzElF2CH0NS84KfBRKmJsXDptRgisP3sdSR6jcU0Do5rZOKISTK44jsHQ==
Message-ID: <58e0de7b-8c1b-4d93-848d-c5afebb678f7@bootlin.com>
Date: Mon, 4 May 2026 15:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] backlight: expose the current brightness in the
 new kernel API
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marta Lofstedt <marta.lofstedt@intel.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
In-Reply-To: <20260424220953.167058-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 4/25/26 00:09, Mario Limonciello wrote:
> From: Marta Lofstedt <marta.lofstedt@intel.com>
> 
> Current brightness needs to be queried from drivers.
> 
> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
> v3:
>   * Rebase
>   * Add description
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/video/backlight/backlight.c | 6 ++++++
>   include/linux/backlight.h           | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index c3673bee6d9cf..9bbfc16cf2d74 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -206,6 +206,12 @@ int backlight_device_set_brightness(struct backlight_device *bd,
>   }
>   EXPORT_SYMBOL(backlight_device_set_brightness);
>   
> +int backlight_device_get_brightness(struct backlight_device *bd)
> +{
> +	return bd->props.brightness;

Hello,

The function backlight_get_brightness already exists and is already 
public, maybe you can use the existing function?

Thanks,
Louis Chauvet

> +}
> +EXPORT_SYMBOL(backlight_device_get_brightness);
> +
>   static ssize_t brightness_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 7e4fee65fddd9..851570b39d041 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -412,6 +412,7 @@ struct backlight_device *backlight_device_get_by_name(const char *name);
>   struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
>   int backlight_device_set_brightness(struct backlight_device *bd,
>   				    unsigned long brightness);
> +extern int backlight_device_get_brightness(struct backlight_device *bd);
>   
>   #if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>   void backlight_notify_blank(struct backlight_device *bd,

