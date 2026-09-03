Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C98C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712B10EF26;
	Thu,  3 Sep 2026 14:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EutWTcpp";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D3110EF26
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:39:36 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-85a50f6a7f7so30260217b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 07:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446375; cv=none;
 d=google.com; s=arc-20260327;
 b=HeSbZLPx/jRpRmJzIBbUMfhoGOckd0YltbcdHyj4vLGDPXjjeV9+Db7cZ2idHzxfXe
 YwsfXQfPTdRlz9N6rfatl2Z3rtj8A9c0ZOl3dYkLLR9aM+rxoVi8cCmmqT4c1M34mfK1
 LMRW7G6BEkZiOlu99cDkCJo1n9rORXi3mpCfPLtc1TnMawmEqTxsXUSXxqQp3TbpD3hV
 2mkGgzMIc4ejru2yqAkFVyHYxh/SXBo78VtftXIPokne8fJo/8rnZci9FzA+lPhDZj/D
 hzm3MH8YELkHHCsSO3Jam5ixFn+3AGLn5GYUMrclPZEwbSchA7i2/9H3v7NxnbHqakzg
 q9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cmlPLJyBSVhdlXIs0gcABkaj2xlIPjqFJYx6h3IxpcE=;
 fh=OY4CfM7Fq7NJi8YJdxDPVtSZTY/OLrA9g2H7QhkmCyI=;
 b=h4J9WR5146GBrHZoxXk8KKdsV+RJH3BufZg41LBDMNGMIHbaURlr8+0kMVrY34IpN7
 BIU6WwMyI++aKPAFZ5CytzpMV2kI7nwNx9qJfnEY4+zZF31qHnMRwK8R8pzFlCJR0P7P
 94d1MAHi0XyZ/BrSNq902zDi/kN6C5zL55tUDdgN2q7pxBXlNz29FeMQ9W+lI0ghflYe
 q9Vy6XOJEbWUS3K0dUXuJX4lltitHeMSdDW+3FfZOBqO08AkMfoR7V/zezVWVyaFkt4j
 fDe5xNYqrWB3zDptXByaq3v677DFVVc2fbjK6DPb/7XLDXw2EVh6WPZmS7pvXioF584B
 lRdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788446375; x=1789051175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmlPLJyBSVhdlXIs0gcABkaj2xlIPjqFJYx6h3IxpcE=;
 b=EutWTcppj2afwHu/5/CsmvzU98Xcvb5HdbX/ClKPhKXjUFvj3b5M7NmrgC0xRvOz0j
 AxHWmcZL3KLBR+ix4lgeudA54QE5zeLKeKKvVI4n9LPJ01OX9rGKLyq/bAoFKMHZW7rA
 psEJKDOZZbf/SMS6CF6CdsT1Z4x393OtIljUEHVoGuzZn+HPe7HM2eF3aWyBKUVI9zP+
 HGQXVGHplRCvCBdBy+txZkobffkYJ06s21cIFfFlKgyiIxxrFxBNBOQoAbEY2aOtzT6h
 YKCaNQb8WTaaaRVtEWME79Tr549s80kQdqJE3a69peDuLVKLOzsN9bdryqFYjbzfnhFG
 1Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446375; x=1789051175;
 h=content-transfer-encoding:content-type:cc:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmlPLJyBSVhdlXIs0gcABkaj2xlIPjqFJYx6h3IxpcE=;
 b=XYgGmq0/F54fkvXSL4W2x1HeawHnnVrj/xg06fKpML5v0FFuIoTz16tHo0+suUHOL9
 yRyJRTjD667UD/+RUM9ebfxXtA8FPecX51pCH+dkODbAHWCmdjEaxHAFfeMaHnAeaxGj
 /YzLkxZZAjjdoY8wfXhhwBqPvjdvgtKrgbDrLHW7X2ME5mZ3b0v8iD6SO5sKrUrNZ6i8
 xFl3bdSMW5NEeY6DSm6s7OemzjJ7w3Ho0MJZ5nZT+az0iG+OY6G/uRTi8ehc5smkzUld
 Vz7SmqLSq3XQmmmrf0qN0WuaR2D4sRqxPLsQbp6iAt9exJ2jicjmgoY9XcnLbE6nEWXF
 SICg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvFoWQEfhp6LdRs93itLPqcxr546vj7q0eaLrzK8yrHmiL5mZk8Aqq1L3lS3AFOj3wId5AcpBHtb4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++msuKmDrsZmU72D3t5a7+Di8JqF8+PslUw3HT9R9VE0+C8imjIs
 mYKr8Wg9DfccIq2KEnGDAUzudi6rdUtmvPcX9upALAI7jz6WD3bxgjtQhtH8CeW294IZaXUKLnF
 FCoDf5vo9uxNuryqGafz8A27lCZwIA2V01+/4m1HAhg==
X-Gm-Gg: AYBFou36cTVqAaw0woAChDQT2WdA1sCMQZ6NHGIno7Cq9VLhFyRATrZN2FDq5g99avf
 x5Ei/gET2JXJy4H8hbAGcjI6GlGmnfIDDRhoShZLb5sQxmjFclACo4FPuRfuXaXMav9sVkd/gXH
 ZyxJgrS6Fqp/ExG/hNX8ZQ4W7rwmmoXeFlAdgeMOKGqG1cPqgRNVnbHNxD3zgqchepgfs/Qzua5
 W/VvQwh2hJqp3+9ADUen5+RKqJHPnMki+rdAo/sTR00r40SBK1bkIeKv72XGK2ndlRoC06YV/wn
 IpA0hoL1tAypGiNyDZLpMhJl0cjCn06MsTpv9wjMQvbiDDxhGum7FUt7WQ==
X-Received: by 2002:a05:690e:1904:b0:66d:1478:189c with SMTP id
 956f58d0204a3-66f9bf8d234mt5185178d50.40.1788446374768; Thu, 03 Sep 2026
 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260903143004.1026181-1-jun.nie@linaro.org>
In-Reply-To: <20260903143004.1026181-1-jun.nie@linaro.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 3 Sep 2026 22:39:22 +0800
X-Gm-Features: AcwNN1V9Sc-XWHIXu60lPfwzYFhzqrxq1vJD2g2K6GQFtNs-hV63HQDDwAGV2Hs
Message-ID: <CABymUCPzN89G6pSH7hG44hRupeMoyA+54BRW+mW6tT_Y21mXCw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: delete timeout timer when encoder is not busy
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, Maxime Ripard <mripard@kernel.org>, 
 Teguh Sobirin <teguh@sobir.in>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Jun Nie <jun.nie@linaro.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=883=E6=97=A5=E5=
=91=A8=E5=9B=9B 22:30=E5=86=99=E9=81=93=EF=BC=9A
>
> There is a spurious timeout error message under the following reproductio=
n
> steps:
> 1. Run "modetest -M msm -r" and press CTRL+Z to pause it.
> 2. Run "while true; do rtcwake -m mem -s 3 -v; sleep 2; done"
>
> Resulting error message:
> [  124.018206] [drm:dpu_encoder_virt_atomic_disable:1425] [dpu error]enc3=
5 timeout pending
>
> dpu_crtc_commit_kickoff() calls dpu_encoder_kickoff() to set frame busy
> bits, and then arms the frame done timer. If the frame done IRQ fires
> between these two steps, the IRQ handler clears the busy bits before the
> timer is armed. As a result, the timer runs with busy bits already cleare=
d
> and is never cancelled by subsequent IRQ handlers, leading to a false
> timeout warning.
>
> Delete the pending timer when all busy bits are cleared in the frame done
> callback to prevent false timeouts.
>

Another option is to wrap the enc_spinlock lock/unlock pair in dpu_encoder.=
c
and expose it to dpu_crtc.c to make the sequence of dpu_encoder_kickoff()
and dpu_encoder_start_frame_done_timer() atomic against the IRQ handler.
However, this breaks encoder self-containment to some extent. Furthermore,
initial testing revealed a deadlock involving additional locks beyond
dpu_enc->enc_spinlock.

- Jun
