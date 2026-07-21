Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25061C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04110EB5B;
	Tue, 21 Jul 2026 20:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="O7hHqJ4t";
	dkim-atps=neutral
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C03C10EB5B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:59:15 +0000 (UTC)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-5bfb3347ce0so2736864e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667554; x=1785272354;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jc2SJP3lkZ1N0ECtnV921w8IKIEqjLFTfSmJP9J9mvg=;
 b=hsLH6I17XMZzEo4dvGFDvnwp5HSKNi4a85HGQma9gxOjOKNOFro65FxEn46RG2qVQb
 DS4qgH67jbjr8KaPPq7EGNSpVWwPnN8VWT4QBoqTkQL3reHh+8qeisGAEz84o3vW0bGH
 dfGkXXhpBIBGTdSg5JrBSY3tC9dP5m/YS9TeShAjgpF5Qpxb1JBre0nkU47blDE5G1G8
 Q7Nbw0o81bbMVDbfFDM0uhovrxC3ZYm2g0lboWvEiF9jAOXOz3n/2zjbXlDVDOscYFRh
 +z66HRAxCXuTxEwgceyltE7MLnwCjAwXsni6ecNlWWH6GI8YGnP9/wMj36nmHRSDG0oL
 fjNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKMQQBImOC2Qwz1vrSFnJxOxVpafu7YjYk+rpxx+dgc/gbpJv5MSzY57Us7m4hAHpZYhgyfeAhP9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIDdeWvEUKoaYWyJpVl4eJ4X9OL4FH6Ek+5yB+P/7loCjSohVS
 8T6gf7VB3rDk/vJDmCJIJQYZqtYD//3OWGVQFN5gEhzwoRRdTiGXcXzVYKV3aQCphcysVbdi3Tq
 FUYHSz9f0VjRfOoqzxPDgCZ2D+sgb3/L4LSASq0m9snZW5HNdOrp6HaulprccPssNP//RjbykI3
 C5grG/i8yZzjsmz/APwSVJRklw64fRXj0NW/5GxlmuNE2x9D8zS0rXvfPVAmxfA1jq5xHjbLbvI
 B0u/MtocgSq1VkpHkqEtuaTwrou
X-Gm-Gg: AR+sD101IA2rJQBO3CjxgxZ8IqItHsQurovJkP4+gjFJrZlkxmbN8ZZ3MDUGlZeJvOj
 +3HKrh3P7TXOueg/wxmOgkMDvaaEEu3BjczlI1AUCDfYSO1r0VGCqto3O2gVzpCBoE3g2732jXM
 DAUV8hCiiX/UDiS1Y5POHZ4JZF3bWdy6BIlLzEM7NhfN8I988QHm/qFOve5NCu0JBDUP38xT3aO
 Kp5hczbPo29XSca1tUg3OhOr4mN4otqrPt+wpdHsc/RDPDIsm772XMCWK5ckkpOZ1jFg/ZAKm4G
 P2Le3pJG5BdJimfAy6K678SRKjYVJ8QiKcqxIWI/Pg3IMBT9WKkM+evCkuIGS0u1Cr3XBsoY06Y
 VLZqvPBE+NPBNiHTKiy5n5/Zl6YUHn6Nao9MDZd/WYTHrSB7dLOLCPUqhsnWhQPvinJ4lxqeP5o
 58/XusPTLPAXKwl9N1Lw9thWm0zdu8tP4NU/T11OUg
X-Received: by 2002:a05:6122:8b8a:b0:5bf:8fdf:89d with SMTP id
 71dfb90a1353d-5c1bf8d7885mr5607770e0c.9.1784667553599; 
 Tue, 21 Jul 2026 13:59:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c2c64f6d5asm34090e0c.4.2026.07.21.13.59.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:59:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90410c668adso236695016d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784667553; x=1785272353;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jc2SJP3lkZ1N0ECtnV921w8IKIEqjLFTfSmJP9J9mvg=;
 b=O7hHqJ4tQ/OEwVYOnMtrv3sJuEH2R3EcMGgo4LAFkw92D3EUnDUSbtzzr7s844sFng
 sf5NKGjZhBnOmHdtBQQescPI2nDBQQkBB1ZUwtxb2T0/a8iiwrTwydxzPgP6Eg/1xPoa
 58GdTB/GPhSLSk6LW92J6Yr7nLA6BrHv0p2WY=
X-Forwarded-Encrypted: i=1;
 AHgh+RotPBosrMqILv+kv7vvt1AXTGJzcIaYdUpFDA1XwQbKstKjUnwYTQapPcs63CKkCxYEew55835xLNg=@lists.freedesktop.org
X-Received: by 2002:a05:6214:400d:b0:8fd:7913:b34e with SMTP id
 6a1803df08f44-907783374f5mr216237266d6.17.1784667553061; 
 Tue, 21 Jul 2026 13:59:13 -0700 (PDT)
X-Received: by 2002:a05:6214:400d:b0:8fd:7913:b34e with SMTP id
 6a1803df08f44-907783374f5mr216237116d6.17.1784667552670; 
 Tue, 21 Jul 2026 13:59:12 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e13e0sm4962566d6.31.2026.07.21.13.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:59:12 -0700 (PDT)
Message-ID: <45d9220e-3739-4689-83c7-3ec3fb6f9675@broadcom.com>
Date: Tue, 21 Jul 2026 14:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove
To: Saswat PC Ubuntu <saswatjungkhadka@gmail.com>, zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org
References: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 7/21/26 1:00 AM, Saswat PC Ubuntu wrote:
> vmw_goal_waiter_add() and vmw_goal_waiter_remove() have had no
> callers since commit 'db6a94b26354', which removed their only

You can use dim cite <sha> from https://gitlab.freedesktop.org/drm/maintainer-tools
to cite a commit, it's more readable that way.

> call site. Their sibling functions vmw_seqno_waiter_add/remove
> are still in active use, confirming these are leftover dead
> code.
> 
> Signed-off-by: Saswat PC Ubuntu <saswatjungkhadka@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  2 --
>  drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 12 ------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 38bea8aba..d84e077ed 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -1026,8 +1026,6 @@ extern int vmw_fallback_wait(struct vmw_private *dev_priv,
>  			     unsigned long timeout);
>  bool vmw_seqno_waiter_add(struct vmw_private *dev_priv);
>  bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv);
>  bool vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
>  			    int *waiter_count);
>  bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> index 05773eb39..88c77226c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> @@ -273,18 +273,6 @@ bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv)
>  					&dev_priv->fence_queue_waiters);
>  }
>  
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_add(dev_priv, vmw_irqflag_fence_goal(dev_priv),
> -					&dev_priv->goal_queue_waiters);
> -}
> -
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_remove(dev_priv, vmw_irqflag_fence_goal(dev_priv),
> -					&dev_priv->goal_queue_waiters);
> -}
> -
>  static void vmw_irq_preinstall(struct drm_device *dev)
>  {
>  	struct vmw_private *dev_priv = vmw_priv(dev);


LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
