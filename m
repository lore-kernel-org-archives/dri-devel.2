Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68051109C02F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C950610E15F;
	Wed, 25 Mar 2026 15:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LUtMfUEK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8024A10E15F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774453581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7cy/6cDx1rFE8ee3i8hr+hRak5k71ivXO/Y/xfktL8=;
 b=LUtMfUEKHL1OLhwjrgDIxT/z8ip/j4ezvjdKvKLsRXMypAFcCRxK3kOx7hkwkGrKrvJx0s
 Fw48OhUhG+u7392oHAhHx3CgR1s62ayuhWCcohHndLwnh00Ah4/Ua7NH3S3ngmFHw7hJFJ
 5xHW9u7MRFtlUhc//Pv997AVlKome+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-InoxDynlMnqtO6XYJaKRTw-1; Wed, 25 Mar 2026 11:46:20 -0400
X-MC-Unique: InoxDynlMnqtO6XYJaKRTw-1
X-Mimecast-MFC-AGG-ID: InoxDynlMnqtO6XYJaKRTw_1774453579
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so14045545e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774453579; x=1775058379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7cy/6cDx1rFE8ee3i8hr+hRak5k71ivXO/Y/xfktL8=;
 b=Wtr5NH1hlbHNpMQtnaLm2nstFosYG5AoDJN4YX9wOYIN7rcTxihu1/ej//v6BhIWgG
 GKhVo+6DlPIQaH+SX3KtPA4GprnI767ZYpIdbAYgI6noGQ+07Uzy1rbVZrv/ayQWws5Z
 W7reaD7bICH2eLf2OArNgW4rX0rQaHNmfqqL2JwvfUmlkYo3F0IPFUhagUPfE8pvSpNO
 rcYWO6mDO64jCTMGtlqSkiVMZ74PbAFcdn710T45ndKvmKXMI+42oH16rNBpRn5hmwBF
 wdXzU2dRpFOCb64CsHY8B/i9WNCVTj+VzC1jfpDrVeQizjlfM4KopaIvHC0CAcanGFP9
 ZBVg==
X-Gm-Message-State: AOJu0Yznoeu2WNp6J5GCLxmdNKgvJsdwrrg3Gm+YfJ+d9mqxyMVeYI1T
 UDlUW7Bp1JqmKLJuD8r7I48OvXlAAOXLOaZHEdgUmSa7uaV4w0dhT0sQ9JKl86H3XWpT2Y8zMjm
 mHZeKq8DZvSWkf3B4YQZNxlzZ6+d/v9QhBi/fKcWE3mRczWjPkiuBW6QsOUjMDPii99EXfg==
X-Gm-Gg: ATEYQzz5IeKwd9nY/d7Qnb/nV9PcJEjyzNYvhwRl5k92HhJYvPB5EG/cIgqgFFylROv
 K4Ub0la/OKoBeuBoBdT/IasUYVX6H/MYlGe6pYccJGS9FH16XFVVZGdvH91IJzZr1JGn/JXcvUN
 ueljaeY15/QHRTCUpkx7vULyLsa6fqEmf7948SM/LF/k66RsiPiDj45bxxOkHqUddHNJY0IPsMS
 wACgAWkNd7lH6fadbWjCjkOqoeJN4nLvi1BE2OEzaPsyWWuEo5yOsOrX28fH6klCyEV+YrJzCK1
 kHL9TRx+do930akT/KLJJtAorc0X7fz3jdl1yMY3EJIT337XdT8NOLHWXuY5/MEB/Xe6MmVGpIC
 bbxw7Hehb8MXQDzgTTV8GqOMruUZfI5mvlyX+9Uwo4y4jzveT2IlWyWsRSfyyqA==
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-487160a2589mr54835615e9.14.1774453578666; 
 Wed, 25 Mar 2026 08:46:18 -0700 (PDT)
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-487160a2589mr54835085e9.14.1774453578198; 
 Wed, 25 Mar 2026 08:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487166064fasm25225155e9.7.2026.03.25.08.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:46:17 -0700 (PDT)
Message-ID: <9e395a20-3381-475c-983a-03644a012a0c@redhat.com>
Date: Wed, 25 Mar 2026 16:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/ast: dp501: Fix initialization of SCU2C
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8TSfMo5zF98AnzFEbNPkWqmnl06ZFMUh5m1t69xYo4A_1774453579
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 23/03/2026 16:56, Thomas Zimmermann wrote:
> Ast's DP501 initialization reads the register SCU2C at offset 0x1202c
> and tries to set it to source data from VGA. But writes the update to
> offset 0x0, with unknown results. Write the result to SCU instead.
> 
> The bug only happens in ast_init_analog(). There's similar code in
> ast_init_dvo(), which works correctly.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 83c6620bae3f ("drm/ast: initial DP501 support (v0.2)")
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.16+
> ---
>   drivers/gpu/drm/ast/ast_dp501.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
> index 9e19d8c17730..677c52c0d99a 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -436,7 +436,7 @@ static void ast_init_analog(struct ast_device *ast)
>   	/* Finally, clear bits [17:16] of SCU2c */
>   	data = ast_read32(ast, 0x1202c);
>   	data &= 0xfffcffff;
> -	ast_write32(ast, 0, data);
> +	ast_write32(ast, 0x1202c, data);
>   
>   	/* Disable DVO */
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);

