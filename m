Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365CDCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9318310E9B5;
	Wed, 14 Oct 2026 15:48:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D0310E111
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:48:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CCD640E25;
 Wed, 14 Oct 2026 15:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3971F000C4;
 Wed, 14 Oct 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791992896;
 bh=rvCn0Jy5JPk92lbxMFMPQnmkaKsTTGgMrym6uQCnrBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bGNROjsWMPa878f5faYxkglJCvBR/VdU51Uk8eb1VRHR6m9M8fYCsbthlETEkmQIe
 bn3N+cA3yuRCCZ9DCH8EYPfCvTeBt/OQ2iFjNKA2i0hIANRP8ebgKIt4C6jaGl+0CP
 8IF/lRQjm4JpPgeUYgNP0dQwK3+LFLNLg20PX2ypKGTT6LEEWku6UxHOkbRNncRSvJ
 hkF75pfvMKFX05OyVYDNeucom0hF8KdAHBO/alarcHJ23dPdN1E0eKlI5gLbgChZ3Q
 3JGlC6Ruz328RiaZZT94stKv31Zyxo/DM3yfRiem6aPiGKP73p4OBRnmxBPAXORSjH
 echT8emnji0UQ==
Date: Wed, 14 Oct 2026 16:48:10 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-ID: <20261014154810.GB1182143@google.com>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <179198100282.808561.2750105116872314866.b4-ty@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179198100282.808561.2750105116872314866.b4-ty@b4>
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

On Wed, 14 Oct 2026, Lee Jones wrote:

> On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> > The qcom-wled OVP interrupt is enabled at probe whenever the module is
> > already on, but the driver still believes the backlight is off, so the
> > first brightness update re-enables the interrupt and trips "Unbalanced
> > enable for IRQ". sdm845-mainline has carried a workaround for years and
> > Joel posted a flag-based version last October [1], which Konrad and
> > Daniel asked to be replaced by something that does not track the IRQ
> > state by hand.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
>       commit: 186fc521f211a207c323b753659f28d3dda7bc45
> [2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
>       commit: e60dc9c05e0f415ef8bc63b3179abdd49830a619
> [3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
>       commit: b32a8c32fea3855e707717155f198f03fdbf6f1e
> [4/4] backlight: qcom-wled: Read back the programmed brightness at probe
>       commit: 2ffcac916578f4a57347e717786d1e07e85cbf2b

No idea what this is.  The other one is the correct one.

-- 
Lee Jones
