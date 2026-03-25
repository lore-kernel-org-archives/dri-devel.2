Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C962109C045
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B98210E80F;
	Wed, 25 Mar 2026 16:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZT5F4zBu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D446610E80F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUWMVA7wtJF4ehuOzZk+O9lLJ0rN8OUOKK3EzT1g+Ps=;
 b=ZT5F4zBuJ4AXpi1sb9GjzScmUgEDNEVTX41JydwbWMU4N70F8nMaal7Pkrp3zM3yEVPB+e
 iphmlrgqc7XEJ//nXDfSzkYMiYHeh8yWc9zUuLvSp+PP+mLY7wh/GksBDMof1E6Z2leCSP
 jq1RbpFuxpBpttRYGW7R1jPOucRS3cM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-U18-mmpMMtyf9i5CN0tNLA-1; Wed, 25 Mar 2026 12:48:55 -0400
X-MC-Unique: U18-mmpMMtyf9i5CN0tNLA-1
X-Mimecast-MFC-AGG-ID: U18-mmpMMtyf9i5CN0tNLA_1774457335
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b8f9374dfso545299f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457334; x=1775062134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUWMVA7wtJF4ehuOzZk+O9lLJ0rN8OUOKK3EzT1g+Ps=;
 b=UxgqNBPSeFAiqnUec1oBtN8LjSu38swIMs2ESrS4ARp2yFaH2ry8vkNd6W2gPmCs9m
 vYxu2j6pxvtbbLV9Lnw0bN/qG66kEAP+XaenVDzLNNf/Q9KVmmqfRCZnxRpjQlQBi34n
 ESbRWAGxIadm1o5uL56D0SbQMYq0hc2eseCW5fCnEjx631cKFILYtAHM7fVPqM+gVBXC
 gGJ2DYRwN78A4tDfIfRYL+CoxUXUn8WCOaKz5gEPIShkM+D3gdeANi3Cz5b1t6LviiUv
 tSf3KYq3v3y6eIEKwhNcdMcEQ4pwtJyIvXJavEGCH+qBdntg2vQjTA8yhVk2v9jY8RkB
 4tig==
X-Gm-Message-State: AOJu0Yx0tgkwqqm8GzYTlxx6aHFe+NsPWo6/bg8aZKONMVqmlRNTP69Q
 TGpThu9r+FBDVfJSkf7cjMHnJbLAR7NGT++eWRTbAvG28h5xdd6WimV/AeO0GbnL3FObnB8y6Pm
 LDEafj97H/6RiLLy1cKMDNNmCBCcSa9TKPu/bOJnaiOg4u8HLtzlrCTgsJB4apBhcog1fyQ==
X-Gm-Gg: ATEYQzyv0s3tBD86MElp4cxaitXq/qnBN6vUSk9rxHze6geAKxuxgvaJKVUmhpRPpPA
 iOZ8xbNNmfQh3S5t7XiGyG1sVyfmjHT2W+2jvc4TfRyKhpmXIcI1ZCpW4nsfiDyx0iM4hsc7ZJy
 NQHPYckmOz/VWj+H91FTvRsY682Kl12INzHUENUBtWUss5EP5bWfPTjkrS1qkfR4Fjf5lzk0t7j
 /E2PhV4E532rMST4z64NoqXksN85hZOf7Xf5RTpvmqNPrJ6gIHtE+OPSDNzsdFakTYk6OGG9WfH
 jFX7pRrDqOfX1fUh7kkTPT85CeV+8KOsJsTmuIsLGrdWvnS9a09MfSzOSE2UTTRSdhuptGCvbN9
 nYYUBI66KSENRBpOqzCVSAgrWyg/xS9Ei1Iz4+uKF81qRwsmjpSy1bROAV7QmpA==
X-Received: by 2002:a05:600c:8489:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48715fc75dcmr57302865e9.2.1774457334521; 
 Wed, 25 Mar 2026 09:48:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8489:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48715fc75dcmr57302515e9.2.1774457333748; 
 Wed, 25 Mar 2026 09:48:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487172bbdf2sm40066175e9.4.2026.03.25.09.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 09:48:53 -0700 (PDT)
Message-ID: <c010ba72-06d3-46a1-a638-37330eb5a894@redhat.com>
Date: Wed, 25 Mar 2026 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] drm/ast: Fix open-coded scu_rev access
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-16-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260323160407.245773-16-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ptNDNtG-FO5A_S4TVnHYVU-SA2tXAQZQIPlWEjjNtx0_1774457335
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
> Replace all open-coded access to P2A and SCU registers in the device
> detection with the appropriate calls to ast_moutdwm() and ast_mindwm().
> Use P2A and MCR register constants. Name variables according to registers.
> 
Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_drv.c | 13 ++++++-------
>   drivers/gpu/drm/ast/ast_reg.h |  1 +
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index 6fe549f16309..ba6cf5fa901c 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -242,7 +242,7 @@ static int ast_detect_chip(struct pci_dev *pdev,
>   	enum ast_config_mode config_mode = ast_use_defaults;
>   	uint32_t scu_rev = 0xffffffff;
>   	enum ast_chip chip;
> -	u32 data;
> +	u32 data, p2a04, scu07c;
>   	u8 vgacrd0, vgacrd1;
>   
>   	/*
> @@ -275,14 +275,13 @@ static int ast_detect_chip(struct pci_dev *pdev,
>   			}
>   
>   			/* Double check that it's actually working */
> -			data = __ast_read32(regs, 0xf004);
> -			if ((data != 0xffffffff) && (data != 0x00)) {
> +			p2a04 = __ast_read32(regs, AST_REG_P2A04);
> +			if (p2a04 != 0xffffffff && p2a04 != 0x00000000) {
>   				config_mode = ast_use_p2a;
>   
> -				/* Read SCU7c (silicon revision register) */
> -				__ast_write32(regs, 0xf004, AST_REG_MCR00);
> -				__ast_write32(regs, 0xf000, 0x1);
> -				scu_rev = __ast_read32(regs, 0x1207c);
> +				/* Read SCU7C (silicon revision register) */
> +				scu07c = __ast_mindwm(regs, AST_REG_SCU07C);
> +				scu_rev = scu07c & AST_REG_SCU07C_CHIP_BONDING_MASK;
>   			}
>   		}
>   	}
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index 9d6ea0765990..00e496d61551 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -190,6 +190,7 @@
>   #define AST_REG_SCU040				AST_REG_SCU(0x040)
>   #define AST_REG_SCU070				AST_REG_SCU(0x070)
>   #define AST_REG_SCU07C				AST_REG_SCU(0x07c)
> +#define AST_REG_SCU07C_CHIP_BONDING_MASK	GENMASK(15, 8)
>   #define AST_REG_SCU084				AST_REG_SCU(0x084)
>   #define AST_REG_SCU088				AST_REG_SCU(0x088)
>   #define AST_REG_SCU08C				AST_REG_SCU(0x08c)

