Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E4EC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73A210F254;
	Fri, 31 Jul 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fgm9xkTh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFA310F254
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:28:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA67944006
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E701F01566
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785504480;
 bh=BdWRFs4osWaaJzMBzKIKTHPcsMgJqciu7jcoPmTxYec=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=fgm9xkThoqF1bQfPKO65FXat8RPLvTXA1XKtS4lux6x04EWgf5FH13BC8cyLHazPr
 dxzEQEnZ2Df/Tppmr2j3vLpLLS9qa9ha2qu+qXjQ6azhAt7sq6IF2eqHqW93C5RyoK
 TzXsDCJ6Ybn/MAaTz0O9nq2rCBocCM3nN5zK6lrw6dP/aHfYjN95ceIZnBoqnWhx1k
 WW3n99WPKLtRFqFe7BJZA5sk06HwbHzVF9HYWaljlWJJy+T9hsK7wQj88oCou57s59
 0KAgsXS/e9JqHF1A8NTB/9+4ixHnqSaTU7hPdlftVqNQKKsGa186j1PFolfZL1F7g4
 cxNxbc1EdJa0g==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39eb257e9fbso7135281fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6wdgzcLlC3yZc3cWQieNQ4K44MTdxyDYEn59aX9BD2wciT86ARgJL6on4dvAE7Jb4ixtmL3kJ00o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyZupSNdYDf2N6Ksw6do8rfZroSH9IbDZhxXyObdBSCozBmD9E
 BSVns14RLXA4qs6oFrOw27N7ig3MbvRpXDj5DBltCdzfyd2nLhtLOF4DGThirVLi0MIoB3NmmeE
 7KG5VxLqIjrRxrOvrQYXgwh+VlM99AsaF7v+z6rcIIQ==
X-Received: by 2002:a05:6512:3d9f:b0:5b2:a1f2:466e with SMTP id
 2adb3069b0e04-5b2e1fc8295mr456344e87.10.1785504479286; Fri, 31 Jul 2026
 06:27:59 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:27:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:27:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
MIME-Version: 1.0
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
 <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com>
 <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
Date: Fri, 31 Jul 2026 06:27:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdA6dTDvp=kQ+k2Jf=kyZBK7VTJCX=0Qvq2MOvQVOQDsQ@mail.gmail.com>
X-Gm-Features: AUfX_my4-vcUkFt6J5bi893LfoyHoVCDYEQ_iJ8oHk7wCMSuijA_BdfQPo-2B_Q
Message-ID: <CAMRc=MdA6dTDvp=kQ+k2Jf=kyZBK7VTJCX=0Qvq2MOvQVOQDsQ@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jeff Johnson <jjohnson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-pci@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>
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

On Fri, 31 Jul 2026 15:04:30 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
>>
>> Nit: s/pwrseq_disble/pwrseq_disable ?
>>
>
> Ah dang it, how did I miss it, I test-built it. :/
>
> Thanks for catching it.
>

Ah right, makes sense, it builds fine, it's just my sed script was wrong and
renamed it like this everywhere.

Bart
