Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F87CC55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 16:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F031710E0B7;
	Sat,  1 Aug 2026 16:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="OW1WNFrk";
	dkim-atps=neutral
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E90D10E0B7
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 16:29:12 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1785601750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0OSr4PVxwlUzl29UswP2Ld/5ySXUrAk1c81FO8Jolo=;
 b=OW1WNFrkmP6loHKo7sJMqbrXaEig8yZmuh5ybE5188gYLkXVSJTXRRtI3uEBIrOahCqSzL
 eG9PQEkfPZdpqPo2KEG/FpcgZrkFDnvGFILUkkmIldT/BpE61VLPfUtoDBu8nCVeYWv50t
 r68PCxXxs+eza3LqF38f+zlGqwUHmraELWVDrFtipvcSr5Ft+8+6AZcNHUnFQ+RS5XKZZn
 piS2nn94sGCMCSbztvsI/kl/BbDZ0pmcv96INVPwT7FG9rWO44IEREaJdUJXaBjZYJd5mj
 vbd81zKOnJDFVeZHTUJwZ6SrNgZe22oImoPYpEuOh4UsxiTIhzV8LRbnlYT98w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 18:29:04 +0200
Message-Id: <DKDQZP8UB0XY.U2JKKNUEA4CV@cknow-tech.com>
Cc: "Tomeu Vizoso" <tomeu@tomeuvizoso.net>, "Heiko Stuebner"
 <heiko@sntech.de>, "Jiaxing Hu" <gahing@gahingwoo.com>, "Oded Gabbay"
 <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Igor Paunovic" <royalnet026@gmail.com>
References: <DKDOBW9CJ2Y3.10EEIZDTXPYJZ@cknow-tech.com>
 <20260801144021.7583-1-royalnet026@gmail.com>
In-Reply-To: <20260801144021.7583-1-royalnet026@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Sat Aug 1, 2026 at 4:40 PM CEST, Igor Paunovic wrote:
> Hi Diederik,
>
> (re-adding the lists, your reply came to me only)
>
> Thanks - that pointer was useful, and it changes what I thought I was
> looking at.  Two things came out of following it.

Then I guess it's useful I add the main part of that pointer to the ML:

  This is all 'above my paygrade', but the 'failed to get ack on domain' is
  a type of error which seems to surface on a regular basis:
  https://lore.kernel.org/linux-rockchip/?q=3D%22failed+to+get+ack+on+domai=
n%22

(My hope was that it may have given Igor pointers wrt the problem)

> First, a data point that may narrow your search rather than widen it:
> this board is not running upstream TF-A.  Its SCMI implementation
> identifies itself as Rockchip's own:
>
>   arm-scmi arm-scmi.0.auto: SCMI Protocol v2.0 'rockchip:' Firmware versi=
on 0x0
>
> and it still fails, so whatever this is, it is not exclusive to upstream
> TF-A BL31.  If rkbin BL31 makes your PineTab2 suspend/resume work, the
> difference there may be something more specific than the ack handshake
> itself.
>
> Second, going through the archive for that error string, the history is
> longer than I realised - Peter Geis' and Sebastian Reichel's pmdomain
> work on RK3588, and further back "arm64: dts: rockchip: add hevc power
> domain clock to rk3328".  That last one is interesting because the fix
> was to add a missing clock to the power domain, i.e. the handshake
> needs its clocks.
>
> What I have looks like a neighbouring case rather than the same one.
> Here the clocks are not missing - all three NPU domains already list the
> NPU clock (rk3588-base.dtsi lines 864, 877 and 885).  It is the rate
> that matters: the ack never arrives if the domain is moved while that
> clock is above its DT assigned-clock-rate, and the same domain moves
> cleanly once the rate is back down.  I have not seen that variant
> described anywhere, which is why I wrote it up.
>
> That suggests something you could try, though it is a guess and you know
> your board far better than I do: if any clock listed in a domain you are
> suspending happens to be at a non-boot rate at that moment - left there
> by devfreq, by an assigned-clock-rate, or by whatever ran last - then it
> would be the same shape as what I am seeing.  Pinning those clocks to
> their boot rates before the transition would be a cheap thing to rule
> out.  If it does nothing, at least it is eliminated.
>
> Thanks again for taking the time, and good luck with the PineTab2.
>
> Igor
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

