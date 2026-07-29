Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FD1C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3910E564;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UGjVWERa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA14110E564
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785338328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWA02cKyEG3MnhMw4GWqcBnQsQ4t1ignU/WFOZgIXMc=;
 b=UGjVWERaVTIIsZiFTBi7Gc7SCd+jTt27lvKCksNt+r+bhjUIwyrc+5cQnuHy9WKxvyj+8V
 qlVKoGr/vFWFvurdIdQYO/22lV6YlNKKqXXXMvVA5Vhe6BErq7MBU9Zf+dsaP48agWogg1
 9gdIlpcr/2piv2C8jcTm/l0f7Z4pNiI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-7-A7RCW_OcejjA3weOnL_w-1; Wed, 29 Jul 2026 11:18:47 -0400
X-MC-Unique: 7-A7RCW_OcejjA3weOnL_w-1
X-Mimecast-MFC-AGG-ID: 7-A7RCW_OcejjA3weOnL_w_1785338326
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso742741f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338326; x=1785943126;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWA02cKyEG3MnhMw4GWqcBnQsQ4t1ignU/WFOZgIXMc=;
 b=BIgDS96Q/mOasncnllPPvH+jjAHMseGhJox8BwjFEWUImrqj+UG/f/37N2r+RferSs
 mFus7AuBnqTFG3FGEV8YtH7wBv8hCTbG/PHbH8eIIA2W6MFWpODrg+cwfPgBNQkwzQfg
 Furqz16IKorja5eTgHdjyREUDnOD/N5Ruptxx3LlIsh1V4+2nCMLvwM7Hy/qsLdMf/U4
 iZIflkk1B7RXZRnIzCtpjq/1gwfeSHmN6Vz42grWAuZ3Fvw0+5LfLjlTYPHsqvn+H9ro
 oTF32crKodFilGms1zMA/POm5ewkYoCw2ofo9BnhnZyQNozOLqF/sOfXU6/6WaeY6wgc
 EQtA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4yEMLUzGeIw7G+UqGNZSk6xmRZ8iQusbTCvmkq0ulwDuv04JnqsPDO1gokyFG31BvQbYGuB66+jA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhwmjpdkrrZXDH6Si0idfSQkhwasjrTwWvT0m8rKhSaYOBENWA
 8iQcpBq/utFxKosw+ilGrNbLQ6zMPl0vcSvzfyOANztkaPogj8V3la5hL6axjAFWtO7xiOAA1Ln
 HBa0oucBMHqluzs50PNYomDfmrdIquSSwfR7BDv0tNLyb/0qfE/eQJKZq1IdC/pLJw9ZCWA==
X-Gm-Gg: AR+sD12jvmfZ7ouwOMnAM/Jy/ye4eGibiXRQg8FCwyPT3D61KF6Sa89CfS8GFBVKhcM
 6Ji29e3mI07h10H3OuHLmQt0e0e60qxAixJwjzgVN7s+6BSTgjdgGlLIAMRw0NEhMWVPP8X8WvG
 8GjJEkiesYrGQV+olAi7sSutuKLHQIYJmRq9JX/qBBe5FZQ3O+LvBwSTcwH6DmtFaEY/qYv4neD
 TDiUaX12Q7qt3mmQZIvzhwK7OaoFv8aglMsHNy655X5iD6qP47socg9ZevPMIS5lREX8F4aKvhB
 /TuI7TLYeC+HbWnjV7R0G4aEeuvDOePEEpyWX3FKPbDEN8hD/lQXjWmsZbh7lTECmgANFb9OCSo
 w1dWDyLs5ji/xEhfjVOdLW56bfIO3QzWJlNW15ZgXAOuQTw==
X-Received: by 2002:a05:600c:3b10:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-496c6410476mr77216185e9.2.1785338325971; 
 Wed, 29 Jul 2026 08:18:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3b10:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-496c6410476mr77215675e9.2.1785338325364; 
 Wed, 29 Jul 2026 08:18:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e81asm64980995e9.7.2026.07.29.08.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:18:44 -0700 (PDT)
Message-ID: <acfd13bd-bc0b-404e-8a5e-bdbea823a708@redhat.com>
Date: Wed, 29 Jul 2026 17:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/log: Fix infinite loop when scale is too large
 for display
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20260729084815.692944-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260729084815.692944-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V27Bs9vsu3ov6Crw8id8LyXe2Eeq4CBDZEKmnxfEahE_1785338326
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

On 29/07/2026 10:48, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> When scale is large enough that scaled_font exceeds the display
> dimensions, rows or columns become 0. A columns value of 0 causes
> an infinite loop in drm_log_draw_kmsg_record() because the loop
> never decrements len.
> 
> Check for zero rows/columns in drm_log_setup_modeset() and return
> an error, cleaning up the already allocated buffer to avoid a leak.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index a04f651e8265..63577aeb705c 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -240,6 +240,12 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>   	scanout->scaled_font_w = scanout->font->width * scale;
>   	scanout->rows = height / scanout->scaled_font_h;
>   	scanout->columns = width / scanout->scaled_font_w;
> +	if (!scanout->rows || !scanout->columns) {
> +		drm_client_buffer_delete(scanout->buffer);
> +		scanout->buffer = NULL;
> +		mode_set->fb = NULL;
> +		return -EINVAL;
> +	}
>   	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
>   	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
>   	return 0;

