Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F369C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2A18989E;
	Tue,  1 Sep 2026 09:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gP0dJdwg";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3B18989E
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:12:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso4668615e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788253947; x=1788858747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0TlUfV1W2wVGJiIoux61PNOlqp07vzGJ/19zLvBmSsQ=;
 b=gP0dJdwgg6IjKtHb4me5zkSkDDTDjYsEIi1I64pJY5DbUFd4DokbN+9RiXokpFPKqf
 BJIiA/PJkda813tXe4Vv0TKf0Fou4tOAFXDVbFu1uftjHABHErvjY0W1oaBGdh1zNkQD
 yuiEW7xp4iChGf8MOBsxQIw4nZiskOctq2AMOeJTdGtteMX6MQB4moIBtu3dIToWyGlE
 ho0l6wmc69wt29buhUvfUOvB4dE0uz/VKjTsjVJLSeOCDhosKLYxP93KQVCaQWwfOYA6
 Y2ktAZu5feltjWzV0uyxXMB27UOppuSrkoiWtpfi4wjem7xQAGt1qAo4gk5NraQY3EPM
 6HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253947; x=1788858747;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0TlUfV1W2wVGJiIoux61PNOlqp07vzGJ/19zLvBmSsQ=;
 b=mHGOkIQ2x1gzMfgk6/ALxgvS2iStSVwXgIGE5w+kAp1GQV3p8qWiyM+4YsbXzzxWwk
 8TxwokIXhN6sb57Qkqc+Os36lCXecln8MrYouwmHkzoVPPNhH3NsZZ/DSR6ALtaOfCKT
 2u6W4SSfg1U882z58UBOeO2eAEEJdh+3yQTvzFXV8CMksMmMdFCMjGIvoaXmlv3sXAih
 909PcKEVB1pBVipdNn9Zu2YFbQ72dQC1wEDpDBIAM1SR20e/QIf1tqR8ch7XQJs+HlWT
 gMoIrsvVEPb3obI07TyA5U7mN5+YlG/Y3ibTHJ5X8nlXYclEBwCRcm7bIcOUKbirCyhW
 yOVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXEow3jE+MtzAu6xPSSUaX0QXfycLHL1xvxZSmD2g8IWnlIn86z6fnMFF1y6FTmu1quo6PFbupVzg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3bFMnROVli8evjr/1F1QGxL5R8v18YwWIZnnnqD87DKH4lMTz
 0O5o+2hmGDTRr6nepHfKcUlVDH4nOuDxr+Cyi2BwzzQzOVOiOWB94YYU
X-Gm-Gg: AR+sD10I1D3DUFeL9zlLxMLDano2OAbPyOfHE+Zkx6HCgOnGKVQyxd4Mmpoj6MBa07Z
 OZy4vyQMRFhAYpKgF0tWmlE9uxvzVLDR0DGjOP1FwuWy6abP2iA0UlZkwUpUL+PstjTWOcVYVO/
 7af8HvEwuoPJWG4SvPapYVz5UQggpFbeyFKRyez7XUkjsKMBapTJHW2ubTuestGsOPBmy7EHul3
 2x7223SiKqtJ0MS902fPUF94UHBJz/lWxjirljPd/fsQ37i/CiWPCKfoK0VNsJE4YKAmUFDI6BP
 /rqPUP7J0YSLU0MH/o28zeFmgxuSvQWnnPMI7Ovserq8XpJUJ0U7bf0nmExkxaJUIPJj7aIDg3x
 IY8lYgulezjZQmu1+JffwOEOPGIE1N+G1XiRaOQAYtnnNs1ntX7DPuDh5XxTXUwX1bgqvbm0D+v
 XCqa4RSI7Jhra7tNpwfT2pEsF70RFCSff611puqqwXcAhXaFrWn2tjfLDB2Qc/5pBxRtFEMQYEA
 wQO4bS/Sp6UvHZyQ3ZlTOhqY3X/UdwTaYT7
X-Received: by 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-49b91c51e62mr456328445e9.14.1788253946713; 
 Tue, 01 Sep 2026 02:12:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm53004175e9.15.2026.09.01.02.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 02:12:26 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:12:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: use strscpy() instead of strcpy() in
 virt_vbt_generation()
Message-ID: <20260901101225.3aa0f0cf@pumpkin>
In-Reply-To: <20260901050241.359490-1-hrushirajg23@gmail.com>
References: <20260901050241.359490-1-hrushirajg23@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue,  1 Sep 2026 10:32:41 +0530
Hrushiraj Gandhi <hrushirajg23@gmail.com> wrote:

> strcpy() has no bound on the destination buffer, so convert this to
> the bounded, always-NUL-terminating strscpy() instead. The literal
> "BIOS_DATA_BLOCK" (15 chars + NUL) fits the 16-byte signature field
> exactly, so this is a no-op change in behaviour.
> 
> No functional change.
> 
> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index d6e76ba31d60..f2527e26cd1e 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -151,7 +151,8 @@ static void virt_vbt_generation(struct vbt *v)
>  	v->header.vbt_size = sizeof(struct vbt);
>  	v->header.bdb_offset = offsetof(struct vbt, bdb_header);
>  
> -	strcpy(&v->bdb_header.signature[0], "BIOS_DATA_BLOCK");
> +	strscpy(v->bdb_header.signature, "BIOS_DATA_BLOCK",
> +		sizeof(v->bdb_header.signature));

Pointless and potentially wrong.
Both normally reduce to the same memcpy() call.
If the fixed string is too long strcpy() generates a compile error
whereas strscpy() will silently truncate.

(The '&' and '[0]' might need removing.)

David

>  	v->bdb_header.version = 186; /* child_dev_size = 33 */
>  	v->bdb_header.header_size = sizeof(v->bdb_header);
>  
> 

