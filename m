Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDB4CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA24910E61C;
	Wed, 20 May 2026 15:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YgcAH5em";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EA010E61C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779289276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iNI05lI3ZJNtRJRk3gp69aJzRmdZtfX27Kd0N0R0kp0=;
 b=YgcAH5emFRjBWumvmD5X6j8BvxlFq+XqqTZ0IwkT3CrUTBh9Y0NaVo6WHzGWykFxxrCcCk
 Oww/skwCG2oRKttQgq5RSunXwzsS5K3rPDi4vSQ0taJlcjeQfYkbI0pxPf7ClKd63qN0dj
 HRAX1rRaf1raYvBbqGp3/Knsqsc5OoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-V9bE_KeOMzuCNBE51Is07g-1; Wed, 20 May 2026 11:01:13 -0400
X-MC-Unique: V9bE_KeOMzuCNBE51Is07g-1
X-Mimecast-MFC-AGG-ID: V9bE_KeOMzuCNBE51Is07g_1779289272
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso3093200f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289272; x=1779894072;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iNI05lI3ZJNtRJRk3gp69aJzRmdZtfX27Kd0N0R0kp0=;
 b=diJJf/4wJVoh57LAZ18FhSQMnttZpmffyg03lWoZN+yo9OeftqfYXOB3kSu/gV7I9t
 sBXVlRKMMUyfB8n9l5E8y/gbdl3hvijp4QX50egUzlrXYW5qBcf5DoPwF9S0RCj1W2YQ
 vNBdCLvLo4ppiXNoZLY0is8emADNmM14IISPX0a0HKI2EdsZK861ps9TQS7MbhM2dg5k
 EQU3oMay5ijNb4AiBWi/GLz9V37mZWbEvZRhaCQMk+CGrljCwbjpBRJFGV/4kA2WpBC6
 lgsKTSVPUNJKh0E/MqY4bPr/FGLS7ibZz/hbtjAXqByf74gvVZokLs2EmxA/DvFjVTEk
 lmUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X6s63LR9iWcm6Idgdqi9zMlfc6QzMUtZ/RJc4wzzLPFgi89pWiC/rRdxpS/rflyctBmChMHBzSGE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlQdq4sk1DfZyPXAl7TxzdVlKdrljKS7qi7gY145bOlGV7rvTv
 4724B07Zm4qqq2db/SrQjgnZHcb3P6o/VvxmRFvsZizPcmqeEJjOc9RJDm13sImkJ0EzxL/wmJ1
 HHI7CNx3A7kmydBNkp1kT0wfymHGDdKMIfBy9jfvL/QIfssrKnRIGcFIi7U4eq9Zmhi0Thg==
X-Gm-Gg: Acq92OHAZqn5wgKNJ/zMrvG1nIbfExy0rG/er4+fgX0hU2KPdFV24/HLxmXzNR+ozrM
 JaDLlTy3IpVwsHOksiUynKgsMNGd0vOUCR/3WeDz4sbakqH2Elbe7CxqZU7fbcKe+TZAJa26u7/
 yGd2MuJMKeYRqOBBWQdN9wui1MiOj5IDSkeOkRoqYCLlbCvO5keY7M9k9RVh7LeEEF6BQ482CfA
 TMR4N5tNioyS9KrOjrmwssvprnkqhoAHG5E0qMnzCyEJjGsgHAWnV0jLtgLE/ololEs15DLeYlT
 GTnX9HoXHIXq+QLpmpeu3eRbcZHHHqPTzCssOi+71TkjU61GrDlMl4EhTqT+By39cK3UWCn4qOU
 rENY5Vi2HwqyNuS6+DxDQdMGB3uDej6v8K5m12DRN112ex2Vy0upL9eVrq0yCKUzG6TIfcgT8ZV
 w6qW+Y
X-Received: by 2002:a05:6000:2f8a:b0:45d:817c:b8b2 with SMTP id
 ffacd0b85a97d-45e5c5cc656mr39867405f8f.30.1779289272451; 
 Wed, 20 May 2026 08:01:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2f8a:b0:45d:817c:b8b2 with SMTP id
 ffacd0b85a97d-45e5c5cc656mr39867309f8f.30.1779289271815; 
 Wed, 20 May 2026 08:01:11 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm54754235f8f.35.2026.05.20.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:01:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/8] video/hdmi: Add common TMDS character rate
 constants
In-Reply-To: <20260520144424.1633354-2-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
 <20260520144424.1633354-2-javierm@redhat.com>
Date: Wed, 20 May 2026 17:01:10 +0200
Message-ID: <87tss215xl.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oiBnJTpBC9pdVUgtVuDW0-CAYYBHIWZp5extldrJc90_1779289272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Javier Martinez Canillas <javierm@redhat.com> writes:

[adding the dri-devel ML since patman didn't include it for this patch]

> Several DRM drivers already define their own constants for minimum and
> maximum TMDS character rates.
>
> By defining common rate constants in a shared header, drivers can just use
> them instead of having driver local define macros or use magic numbers.
>
> The values defined in the <linux/hdmi.h> header correspond to maximum TMDS
> character rates defined by each HDMI specification version:
>
>   - HDMI_TMDS_CHAR_RATE_MIN_HZ:     25 MHz (minimum for all versions)
>   - HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ: 165 MHz (HDMI 1.0 maximum)
>   - HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ: 340 MHz (HDMI 1.3 maximum)
>   - HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ: 600 MHz (HDMI 2.0 maximum)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>
> Changes in v2:
> - Change naming convention to HDMI_$SPEC_TMDS_CHAR_RATE_MAX_HZ (Maxime).
> - Define the constants in <linux/hdmi.h> (Dmitry).
>
>  include/linux/hdmi.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index 96bda41d9148..8dab78e1f61b 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -50,6 +50,12 @@ enum hdmi_infoframe_type {
>  	HDMI_INFOFRAME_TYPE_DRM = 0x87,
>  };
>  
> +/* HDMI spec maximum TMDS character rates, in Hz */
> +#define HDMI_TMDS_CHAR_RATE_MIN_HZ         25000000
> +#define HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ    165000000
> +#define HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ    340000000
> +#define HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ    600000000
> +
>  #define HDMI_IEEE_OUI 0x000c03
>  #define HDMI_FORUM_IEEE_OUI 0xc45dd8
>  #define HDMI_INFOFRAME_HEADER_SIZE  4
> -- 
> 2.54.0
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

