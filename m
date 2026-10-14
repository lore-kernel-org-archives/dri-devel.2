Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62459CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C7B10FBE2;
	Wed, 14 Oct 2026 07:57:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4365210FBE2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:57:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BAC760214
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91BD1F0089B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791964623;
 bh=sl6IW0nnvVtp07vNT44AV7L0erWrDL8jBfOworvsToI=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=co9OoteDp2WuxaM8YqiplSwL9GnSd9In+175+3Te3DpvnRRfRQnFkFo+66Rxr8uTx
 fJYP8sycpWgurlsHVS+fCyw7p0VkLM5hgv1fQct5k3l5MryucUFTUwW8D16h6rKYJg
 qC4Sw6Yl0Vw/3h8SiPgyDEjGvfrAQ7z9DAOU1XID9Fw9QCjsHRSI9Zp4EufxvqDtdj
 OEQz2ODYL3dahOwI1VJmJpeVa78kuo8g0w91NTk7fJCZz3zCIfoCumI482++PTfRGZ
 KioZJz1346e+z5inJu/Mi6i3b47QXZAtTuEh6hOOvlz2sD33rq1jc+BXpeoUaXnX5i
 KjDhwntvI9xiQ==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3a75f960be3so9132801fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:57:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxXC1aP6V7xFl3CZZBJNjdbn82EBByE8+zcU0XZFeguEeE4oFa/5S9lJXm/NnMiWp3UPI7nVgq0jWY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLvgFA0uXczyAviMsTeybmm4odJ2P6QGTrkELIOKgwcd+5T7G+a
 i8lrXVN2RFx6y9S7hK7rnhXE7lCLTxcmjGW55PSDGO4sSCzCrICz3nldlheqPyxDRujTwocHADU
 G4J9WELAFfCUpFesVcheCqs756MNlwIu6RXuX4vrSyQ==
X-Received: by 2002:a05:651c:1542:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3a9c539343dmr40055691fa.20.1791964622555; Wed, 14 Oct 2026
 00:57:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 00:57:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 00:57:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260814075624.16639-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
References: <20260814075624.16639-1-pengpeng@iscas.ac.cn>
Date: Wed, 14 Oct 2026 00:57:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me3kH8rrifW20xw2JqECydKrbBfQ2ZfFsTrL6KwD8+9=A@mail.gmail.com>
X-Gm-Features: AclHuK_kQw-qSVTPtUkRCZuiCj0gamOTj8vq5XddbmqNqJG15Vf0yUsge2wg9SY
Message-ID: <CAMRc=Me3kH8rrifW20xw2JqECydKrbBfQ2ZfFsTrL6KwD8+9=A@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: davinci_all_defconfig: enable the current ST7586
 symbol
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <brgl@kernel.org>, Russell King <linux@armlinux.org.uk>
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

On Fri, 14 Aug 2026 09:56:24 +0200, Pengpeng Hou <pengpeng@iscas.ac.cn> said:
> The ST7586 DRM provider is now built by CONFIG_DRM_ST7586.
> davinci_all_defconfig still enables the removed DRM_TINYDRM and
> TINYDRM_ST7586 carrier symbols.
>
> Replace those stale entries with the current provider symbol.
>
> Assisted-by: Codex:gpt-5

Should be Assisted-by: LLM but even that tag is going away[1].

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1: https://lore.kernel.org/all/20260624082029.18675-1-pengpeng@iscas.ac.cn/
> - no source-code changes
> - rebase davinci_all_defconfig
> - route the revision to DaVinci and ST7586 maintainers
> - add the coding-assistant disclosure
>
> The Kconfig/provider mapping was reviewed statically; no DaVinci kernel
> build was performed.
>
>  arch/arm/configs/davinci_all_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index 72703ef0c51c..ac0029701283 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -144,8 +144,7 @@ CONFIG_VIDEO_ADV7343=m
>  CONFIG_DRM=m
>  CONFIG_DRM_TILCDC=m
>  CONFIG_DRM_SIMPLE_BRIDGE=m
> -CONFIG_DRM_TINYDRM=m
> -CONFIG_TINYDRM_ST7586=m
> +CONFIG_DRM_ST7586=m
>  CONFIG_FB=y
>  CONFIG_FB_DA8XX=y
>  CONFIG_BACKLIGHT_PWM=m
> --
> 2.50.1 (Apple Git-155)
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[1] https://lore.kernel.org/lkml/20261009083137.3-1-sashal@kernel.org/
