Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE46CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33F110E0D3;
	Wed, 30 Sep 2026 22:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lqN7HRln";
	dkim-atps=neutral
Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com
 [74.125.224.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6E210E0D3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 22:34:13 +0000 (UTC)
Received: by mail-yx2-f39.google.com with SMTP id
 00721157ae682-8aa75b338d6so36074957b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790807652; cv=none;
 d=google.com; s=arc-20260327;
 b=nVGXCoP/02bHZ8a1YoJ3ZP6ohq8VWewgnJVYpPJ39iBUSCS4d6HzXlPrybGbdmSevS
 ugfQutkQaaIgJlDV3r0MAFaC2ZMIUEHYrWOBhkfNRwglBqs2ECJ9CRJBaUrsan8opA/+
 Gw+gK79+YEZSLpWWt+m9B+CqES7c1zM3mrVzR/I1e7C08+tNkWZQIDNLUtB+GzDmc2Xq
 9txeOH7oUWO63vcP1A3wLRH9Me+mf+/uM0kqBQ70MaaMwCn/wx5HvMrK0c8tjjhC/CTU
 cKxk8iBo2v6/2+MuCkRXm3s3HMXYytOVWdRGXY6qutrx6kEQf2bOh8i/sSiDKuFYdmm1
 RzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oUkmfFRhu+PfGBj+HhIfsuAp+eP4DBxyfph1aN2q324=;
 fh=0r/CiuY+scB5q5Wp3YSAvuvYXZ4zbjCC1VrLhRr8LY8=;
 b=DgkKEofKe+QD0bUgcrBkeN0DqG/vXkTXToZpkqaTIOs04l/v961YNHJI66dM9IMvIP
 KzqAyHkESVvDgiXamTu7fFr6JvrsgwtfmAc34RIZw+KfOgDYF4BvSbO7Uno3IjwO2NNZ
 WujmFF5beEAb003jgfeEYt3Y2U/FrqWCuaPjnRcIUyswBTD8kQqB1MgOFs7cPwf6Vc8g
 /hPRTBdnzDg76vy2B5n1YCFtfR1zXJb2hdmqO7YQhpHf9CRXUmcJv2G9XM1TQOWPc5OW
 7+JnI/li3TfpNbP5w2KeolovogZUrwnXopIc+rkuJd/sDI8ZwJukQ7cibfBxeHo2BepG
 6NnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790807652; x=1791412452; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oUkmfFRhu+PfGBj+HhIfsuAp+eP4DBxyfph1aN2q324=;
 b=lqN7HRlnTuaGLqAgKoxt1JeQZtefGgDFuzFhME1dTfiTWDshhLw6I7U58aXr6wsYN1
 AA0E19aZpAMpAj7GWST1Hmcy+2ZxPwEePVSyBrw6SiTAJQeqx8VMiRKzc40amgS6Ylpr
 ML0YKRkxxT3AGzDRkZ5GrkuowmV6WV5vfHKzOjXh0QEzStPGturROiDCloNDgIvJHRsR
 ShFa5VBD9Bhpg7cUjh3JNQnHvIUZK++V+6vFgcevRDODrmCn9oKJEbdgbvU8cDLMUEz9
 rCfSPjGIL30CVyJcM5l4IuGZQby83l6IyZYirskUIFzoyC4mibl9oKsRNVLe/hLMpaVk
 C+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790807652; x=1791412452;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oUkmfFRhu+PfGBj+HhIfsuAp+eP4DBxyfph1aN2q324=;
 b=cyldkCwcyaRHbZd+BrE+D0uBrfVZM1oZtDYLk9vSeZ4lZ916JSNpZKftd8QJC30z7r
 /NRvDWsSRCNEYX9J4g/Yj4gKfwJbMoLzCBLfW1+PIKYKFxrjM//Z+PZu+t6mcv5yKee1
 Ad+C4bpbVthv667W8kQQ5GBhui4uisCcYVcN0/9BrZ52yegRy+WilN2HBL6LYj4R7GlZ
 kg+Zm4wCtbHTh8zfZbmqfJFQrxczBXFfTIQWLLEXeuJ295JZJPwC/BsyX+VaOLKVgmZ5
 sxr4a7zgLHw9tmzUdqMrQBt7DZfuOJ/v2WpvKyAerm041G3zUIsugke0MX78vfFTr3F3
 LtUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVb7LjJYHijJ4r4GlkwwN7luIgiqQQj4pbJEqKz6skAIV+WuOmhNyH193fzZumN0+e2/OZ0K6gVyg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL0n7fOI3KdsjnS+BPkIsaFQUwfIvDeiCgcQyiABE09hWmFzVkD
 zMUR5VVGAkqYv3UNBFF863qKsbcCzQGcik04asj9n2VxaIMlCnlBfyxOUycMlljr3R5AK2zGAFz
 wQfHeC5I9PhNXibbJTrf2NKeO5kdAyCU=
X-Gm-Gg: AYBFou25SBdQkzI4UxgbByHLSQFTI6SPtugEBe3UIoa3xJ7qoWyRcwkV3nT0KUDa15c
 haxoVZc2mH06DWWehfqCDmAEBNS57wNSACksK2nXFHzvv59SJK/TVWqennf00mIULUnZFdnQ5it
 QXpNh89jnfs+apPdTI6ndJDKEng+iedpN3ECEa+WzGCmCHgJlk//8TCdyGWGLRNa5OprzpBJj3N
 gcdzIHmRJvfEgwoy9FGcwdexlAjIuw902XoNbSYdsz+o3I438O6TVW0MdMVdFEvomhyZW5SoabB
 o781MMJBQWCeipgsjgZb/5mvTrqcbmrf0LldgZCmJZ4xEgU2ZEF3jAkO3ZFnoe0wsMu3r2vRw/1
 fpyk74G7SX/0YKdb5hyMn8Vdq6Bh6WZdCmNPr6emU+8VQ7tRMmHtBr/dSj7qD6mUUIQcyr0NDrQ
 ==
X-Received: by 2002:a05:690c:4486:b0:8a8:86cc:f0d9 with SMTP id
 00721157ae682-8ac947b8c1amr15185617b3.66.1790807652652; Wed, 30 Sep 2026
 15:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260930164704.1049735-1-max.zhen@amd.com>
In-Reply-To: <20260930164704.1049735-1-max.zhen@amd.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Thu, 1 Oct 2026 10:37:16 +1300
X-Gm-Features: AclHuK8jqvs2xKPcwrh1EjUjBtMkQLDOpjFfC1OF9RWzwzIg9hc1qWQAaXEwGyg
Message-ID: <CA+pz=kLERMEUwN5OQf7=aDDqkH93CHXHUuD+aA0tuYN2xCk3tQ@mail.gmail.com>
Subject: Re: [PATCH V1] accel/amdxdna: eliminate GFP_KERNEL allocation from
 mailbox send path
To: Max Zhen <max.zhen@amd.com>
Cc: ogabbay@kernel.org, quic_jhugo@quicinc.com, 
 dri-devel@lists.freedesktop.org, mario.limonciello@amd.com, 
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 linux-kernel@vger.kernel.org, sonal.santan@amd.com, 
 Min Ma <mamin506@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Max,

> +#define MSG_BUF_SZ(chann)                                    \
> +     (mailbox_get_ringbuf_size(chann, CHAN_RES_X2I) +        \
> +      sizeof(struct mailbox_msg))

> +     mb_chann->msg_buf = kcalloc(n_msg, MSG_BUF_SZ(mb_chann), GFP_KERNEL);

rb_size comes from the firmware-provided channel info, and with this
change it now sizes a host allocation as well as the ring itself.
Nothing bounds it before the kcalloc(), so a bad or compromised
firmware value turns directly into an arbitrarily large kernel
allocation. Could rb_size be checked against the ring window it
describes before the pool is allocated?

> +     if (!mb_chann->msg_buf)
> +             return -ENOMEM;

This adds another failure path out of xdna_mailbox_start_channel()
before request_irq(). On failure the caller still holds the freed
channel pointer, which "accel/amdxdna: clear the mailbox channel
pointer when starting it fails" (Reviewed-by: Lizhi Hou) fixes, so the
two patches should be fine in either order.

Thanks,

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
