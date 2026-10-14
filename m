Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E47CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEB110FD44;
	Wed, 14 Oct 2026 12:30:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AD210FD45
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:30:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D20960546;
 Wed, 14 Oct 2026 12:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A231F000FF;
 Wed, 14 Oct 2026 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791981006;
 bh=vEb5Gx0LrtGn+0frlTWsSNwPuSCsK7a2RD1SMA1DXnU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Ljil3pb0zmj/wIQfZB/cQuB9DS2AhIvaEixXz+DRu0ctwfV+uIB5+aTb+AKr4fGtv
 pda6bfzDOZgAGvX9cTgJh/VbcqoQmK1GKRVXUvFSQr2721LDY1hZ3oyzu1IDfyAmsF
 RE5XPBwu5tH+L1Oc7nUddPsAR7vVPUxNYWiT7YUraox48N3v0514slWNq+e49lNfoR
 kTxHBW256PTScguOamk6dTxfUP6llVcZS63QHzv5pudOpYNtwUmiHJQpV2BDHx1Ul+
 wHFDM381bh0i4wyCgeT4b1xXOJiWVs+7eKoNvOKyqss19TjaEhItjTA5x2wTseNagL
 awPFYwfKeAzgA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-Id: <179198100282.808561.2750105116872314866.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:30:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> The qcom-wled OVP interrupt is enabled at probe whenever the module is
> already on, but the driver still believes the backlight is off, so the
> first brightness update re-enables the interrupt and trips "Unbalanced
> enable for IRQ". sdm845-mainline has carried a workaround for years and
> Joel posted a flag-based version last October [1], which Konrad and
> Daniel asked to be replaced by something that does not track the IRQ
> state by hand.
> 
> [...]

Applied, thanks!

[1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      commit: 186fc521f211a207c323b753659f28d3dda7bc45
[2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
      commit: e60dc9c05e0f415ef8bc63b3179abdd49830a619
[3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      commit: b32a8c32fea3855e707717155f198f03fdbf6f1e
[4/4] backlight: qcom-wled: Read back the programmed brightness at probe
      commit: 2ffcac916578f4a57347e717786d1e07e85cbf2b

--
Lee Jones [李琼斯]

