Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737AFC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9760D10E545;
	Thu, 17 Sep 2026 02:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMBUJ8uc";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C9510E545
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:23:16 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39666e7c9efso45166a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789611796; x=1790216596; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nkh0FnuQtTwLU/gLgK8Zr6SvB3rMVV5l8Nx6NE3bkmQ=;
 b=FMBUJ8ucQYW1odJ6Ru02b/q61hpW0Lr+vum8z46p9p9bnlzwQJ0OeMju76nsclY/dy
 0AqRmH/CgB8Ts4+2RwLOb1MVq5b4TUJN+rXfkxsZH1iJJuKunMfvnGt+Sw72eb5pdE1T
 Bb7g8LmEKS3ZGgTdZGJMpkonnaYhZ6gAyAvgUxdgELWCtQJJHZ83U1OUBvHfRE1XXhx2
 4+qncUpnWW779i1r9USbnV7sYKrS1fYkCpK4aNq1e/Vz3mjh0u1YhtFTvlMiOP0Lo75I
 pslM74OuvuBoq3NLKwDvJQMAUIASxGKAbBZNisYdQmGjOb87IUM0KDERBifN2Cc1+xBE
 rkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789611796; x=1790216596;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nkh0FnuQtTwLU/gLgK8Zr6SvB3rMVV5l8Nx6NE3bkmQ=;
 b=XrQNdCS+Xlncva+n88TKkACjmRX1/PY4Hp0XcknQicfnN/fIAPc2GBz8hLOThUNh9D
 GP4wAsLJ+fot21ADpBWQjJ2HzZkTsySR3A10TV/+Pm8h3mWVke9Cet4HrCvJnzq6yBPz
 EJ2JmIPPEIaOD0/Hj1rEmtGFjGM6WzFaLkBzZsVwTBhz4KS9ARPwZeRpgxte62yJtDK8
 NdvVHFOwBtTSRYuzpawavbkui/D1cN400rYJ4BzQcWHIpKnlR4TBQSyH1a1kU3ylUyAg
 imfs+hSIZ+3tYfrKpS8H03YiqXhIzgeAq7Hu2w24zQIT5yPYIysvg8Afj1LJswvElvoN
 bamg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyvVm/52sUNAeiYx6TBy8lmde0E6XNt6NwGyxrz9QT9hMgycpG45sNnzBmAQ8Yxcme541+HsBB8dg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvMOhpG3VM2GQPdT4RhsUaGahVyejPYGi5uVHrOYycpdpiiph0
 E2LK98UFFyDzc4rQGJ54egx90YS40eU59U4k9ruGWTex9p6MC4wWUzp9
X-Gm-Gg: AYBFou17aEdeq9pYJwPz1mxfxTH3oUm/Kch2u4Ez7XULCZ49WZvhoQ/gYYlR4jHCkZv
 WrobPwNC1eELSv6vbkhZzz69nsvkC15PsRFX4tYuqecP2NvqCJYGF+isGS/cm9nrk6mxnrtFC+v
 MtcV/cDYW5A4I2D5Lb7VGcC7YbuQK6dqMskKo4ncvJ+vH/CauF2Xs5v0chtvYjDl3aeUA/RCDKP
 go0mLnKsWZ2Vwt/fCJOJA5AnAkyKhXg1i+2hDpScFWN452caZ3ZoP/CcjBsO/BPnw3HI9Fgo6KT
 0Td8WYm6QdA9EKZjn+2F110wLXlNciPJbFDkad9iHMZkBb9o5lggNJB1cfq80YNExfr2BpuNKUo
 o1USayfO2IHrLYIVhnXDLyPL/1S0SWyzdNDD9EM223BogNVIILv1NPEqNgpVvN9PuiqRta+ldIY
 wHWbWVW5qzyzEM63Y5QXxO8Vh9ORTRtmqYH20Nfcbwarqtz9XiCaIK/RjBKxX+rLTKD0TQj+ub4
 XLJyGEyCeGVtq6Txndeg+u9baF1dMtxhTkAoH7T99Q=
X-Received: by 2002:a17:90b:5386:b0:39d:febe:7452 with SMTP id
 98e67ed59e1d1-39e1e64b9bcmr7917463a91.4.1789611795933; 
 Wed, 16 Sep 2026 19:23:15 -0700 (PDT)
Received: from [192.168.0.203]
 (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com.
 [2607:8700:5500:a805::2]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14397197dc8sm9065853c88.3.2026.09.16.19.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 19:23:15 -0700 (PDT)
Message-ID: <bfce38b4-5475-4af6-acbb-cfb20e9b590a@gmail.com>
Date: Thu, 17 Sep 2026 10:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
To: Igor Paunovic <royalnet026@gmail.com>
References: <20260915103433.13163-1-rmxpzlb@gmail.com>
 <20260916161000.11756-1-royalnet026@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
From: Frank Zhang <rmxpzlb@gmail.com>
In-Reply-To: <20260916161000.11756-1-royalnet026@gmail.com>
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

On 9/17/26 00:09, Igor Paunovic wrote:
> Hi Frank,
> 
> I tested v6 on an Orange Pi 5 Plus (RK3588): git am onto a
> drm-misc-next based 7.3.0-rc2 tree with PROVE_LOCKING and
> DEBUG_ATOMIC_SLEEP, HDMI output to a TV.
> 
> The reproducer I used on v5 (output off, then open and close the PCM)
> now stops at the open: dw_hdmi_qp_audio_enable() returned -EOPNOTSUPP
> three times out of three, nothing from ASoC or the bridge was logged,
> and since the startup failed, the shutdown path never reached
> clear_audio_infoframe().
> 
> So I also ran the sequence from your commit message: PCM opened with
> the output on, output turned off by the compositor while the stream
> runs, PCM closed after that. With function_graph on
> dw_hdmi_qp_bridge_clear_audio_infoframe() and
> dw_hdmi_qp_audio_enable(), the clear call after the disable takes and
> drops phy.lock and returns 0 with no regmap access inside it; with the
> output on, as a control, one regmap_update_bits_base() call shows up
> inside it, under the lock.
> 
> There was no external abort, SError, lockdep report or might_sleep
> splat in the whole run, including two output off/on cycles, and once
> the output was back on a new stream played on the TV.
> 
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)
> 
> Not covered: I did not try to hit the window the lock is meant to
> close (an atomic disable landing between the state check and a
> register write), so that part rests on the code; and I did not check
> Dmitry's condition from v2 [1] that a PHY off/on cycle clears the
> audio registers.
> 
> v6 overlaps with Detlev's patch [2] (both return -EOPNOTSUPP from the
> audio callbacks while the output is off), and [2] no longer applies on
> top of v6. For the crash, v6 alone now covers both sequences from my
> v5 note (open with the output already off, and the output going away
> under an open PCM), so my remark there that both patches are needed
> does not apply to v6.
> 
> An LLM assistant applied and built the patch, wrote the test scripts,
> counted the traces and helped draft this mail; I ran the tests on the
> board and did the listening myself.
> 
> [1] https://lore.kernel.org/all/urguajogb4zsz4jg3ef32hpyf2awxkywdtlk5ackdi2gjai4l7@vpjaf3sznkto/
> [2] https://lore.kernel.org/all/20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com/
> 
> Igor

Hi Igor,

Thanks for your testing.

Best regards,
Frank

