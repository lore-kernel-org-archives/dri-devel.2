Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C95CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D13F88DE5;
	Mon, 15 Jun 2026 17:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9v93ZkL";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E9E10E511
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:54:06 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-306f1213aadso323008eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546046; cv=none;
 d=google.com; s=arc-20240605;
 b=Ywy+N6rbul65DcNWQYsTDEC3jh/MyiXnuX51q2q8pG2EdRJKaGRGk3QTBbLyXczTlt
 nyfWEH6Npu7kHxZCqJjiOyP6tS3yKL8/gxIR7uIG7Trqxv4ul52+RUJG373wENv0fvyE
 Ulf9n/TJhVd+i7yhFbsWDq9m7AqjuvPJKHbmMwJYsuVlkTSHDocdeDo3XYnALPpeZXDk
 m6WbWNcVR5k0kn/v+Q3DhN67mO7aNf/yC97GG0R68i2ZzfCqRehOr/O0Zzd2F/kVSUeO
 rBogDlG4dvfGX6yYQeEWMXsVGvjOb2InOQ172d88V+9SoxKwMmRh7DUJyRdQHpKRHD3q
 j6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 fh=ol9AFyl8ICwFb33QMN/obdxfupovej1VjgU0xz6X1D0=;
 b=AiLbPT8Ofb8nFKgU65i6Gz1mdRxM4Hla2X4pUa9yM+Vk9UD0i05VCbhN+kkRCtBlZh
 4GgB27n4OpvaM42oNTrUNGvbSY+a7czZpHHhXygjuqWtcoPM0t+E57dCLQa3Kk3GGYYD
 NsHDCt9pbcVyisNdn1WPjcmnV4Jjj9BjDQHuNwEnHKOvRVMueDS7cNOlutsqqJxUC2qQ
 YYsxHKR1RSSjZ20V127Tm9/mh0esoMndGPWIjyDQ/VL5EP0vLris9FHtnK1qziqe5cik
 Ze53M4LIVTe8PsVzDQJ2JJCest3VAkmoXoUFHOOTZjJw52d3la5G+8RpoqTYnM3jFNP1
 MYLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546046; x=1782150846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 b=A9v93ZkL1JXCrZLCLp+kilr4+5swFWxF5esqbMSYTea+4n+eQ4TY9056FTUt4Aztgq
 jButYOx+1rbOEX1aAP9F6eMEwju6xf0eiotmgS9Qg7LteWoCgVyolNSHxfkGRHh/tVnB
 tSyAXssnGL9mXO5j1/8qcrzekvoAb2VK9y/F/HACHuY1GFoj/a5i01qWy/MAz379D8ij
 K5L4FXAaDwnKdu8tAT7w3lkfCsDHF1R17OpgQoEZRAvEEt8ktB+1GaFay0KdO+0033aG
 0XFw43mk/dHd/XsTXvP2Ai/5yJaAvB/8ahwyRkLGx0ItIFGjeRpXiZGj8eRCJHMWLBlI
 gZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546046; x=1782150846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 b=oIG/81SrX2wdunMgYwN95L1ccLWs2HQr755SDDg6SekjuBFRmZBSgBxWhUszz02cSI
 fEByLlfab2ClKl2tZ/TLlbSTZ1ohJFHUipL5KXXiqV4CXK7pcrbTqREOsMd4bYmglPOV
 dtKHUCGIegRNSUnWkqajOs8MRMR/izi9kyefVv+7HNgvMrHGcXvWTYPoHtBhWfASAkTv
 Taspl96Xk2zL4uNntnaqneyfiWsro9Wi3l6HIwTNuiMiKOWt6VWXrEmiEqng3YWRXMh6
 PhcqdwCCMC8QPrQDhh6KNMnwwlt75abWVItiNEvkCyQUs/TpT1bTAJ/H8cF/LIH/81Yk
 HXsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uMv6CCE2riJGmqkbhzeP35nw2XPKLyOHyvhaNFp34KXxphAyXzKY6HjDm0LjbU6WNfonn7l9ZNYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmDXbc2ZMbPWnN6XHxWHXMGVKzucwaqR8AyshbI2Pfasd8Vmmf
 u/ISGGvdlY14KnsxiYSGmsKQxrtHc/t618df1NArgG+IYjqGYeB4YZh6oF146DsUvgDuieLb9PS
 EpClvJ0/FzFJYGpAQKJs8BRB0FA5krzA=
X-Gm-Gg: Acq92OG8PdMSdUrlfJ5Piy7kbe09a9xjCwGcdo5yqS2hyqu2/L26H7vTUAwqrNFm4TS
 HBVUsGyFAw0V9uQcfTBwRar1lmkBPv8IkHp3e5rMkcATgkzD5oWlbFCj+oge/caTXmgABo+sQtl
 05QbQDvQH/R4a66ynWIp5r8tG7M5VCAqytLleyXfTNqp2G7NolbKgANQnr9QR7EpbQG0MVZguzO
 7tFdcuuNXYLdOnetHN64T6S/ibHZZ5O4jE2uMwcPh9cNcnsutES6y/MRYwLYZ+7NP06+l960eDY
 2ZK48+jjGxEt/Xnuw3QzeWMP12kdAcojVt3pfdKKh/EmKwVaNmhMGxEMXaanZIsiBmXvGlPWORY
 uALtQ
X-Received: by 2002:a05:7300:2d07:b0:304:cec4:dbdb with SMTP id
 5a478bee46e88-3082008977cmr3599528eec.4.1781546045858; Mon, 15 Jun 2026
 10:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
In-Reply-To: <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 13:53:52 -0400
X-Gm-Features: AVVi8CdqwiWNBPSphn3J7yyMq6FkhbfPshSymt8PKr3c0v0L9dqT3Suxzi8nKmw
Message-ID: <CADnq5_P0WSMb1ALbKO-mqRWa+Et3Qe+04um_r0B-cDdxiYo0nA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Use seq_putc() in three functions
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied patches 2 and 3.  Thanks!

Alex

On Fri, Jun 5, 2026 at 8:09=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 12:44:01 +0200
>
> Single characters should occasionally be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 885e9b7bc27a..e45fa6e97fc6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -606,7 +606,7 @@ static int dp_lttpr_status_show(struct seq_file *m, v=
oid *unused)
>                 break;
>         }
>
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>         return 0;
>  }
>
> @@ -1081,7 +1081,7 @@ static int psr_capability_show(struct seq_file *m, =
void *data)
>                    str_yes_no(link->psr_settings.psr_feature_enabled));
>         if (link->psr_settings.psr_version)
>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_version=
);
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>
>         return 0;
>  }
> @@ -1266,7 +1266,7 @@ static int hdcp_sink_capability_show(struct seq_fil=
e *m, void *data)
>         if (!hdcp_cap && !hdcp2_cap)
>                 seq_printf(m, "%s ", "None");
>
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>
>         return 0;
>  }
> --
> 2.54.0
>
