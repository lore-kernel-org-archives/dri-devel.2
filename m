Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4FFC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D580E10E7BB;
	Mon, 29 Jun 2026 09:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="UFTQ3ccM";
	dkim-atps=neutral
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C6810E7BB
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
 bh=UCtunqk+Fmc0sd0IPCVoA3RdjciFhdw4WwHo64+lRJY=;
 b=UFTQ3ccMvgm7ROMhPjuz8TAZaUBATjPoIObLRhQG+Ozi6akqNTRcUAtPRtlOdi/CLmYkS/v5297cTOKqQ/NO0dkQuax+I4SA/lfnfY7g9cAUMCtxNSB4PARqSd4WZ7F9j401UcRC4KHCXqcu1rE2EiV70EUBEi1ps+O10wMjg5pIjQ/sCksU1ehUnIoSqlH52OfZjG94hd+eWxVhpLk8cjZW0F1S6eDQVNTCPIq0q7HFWFrvaoSvLiDdBH
 ZbszYTVqUqjZACsm1qyAEslhNt0/6/xC08MQHVQm3/6KphQMgXQ/3oc3ZdVuQdfP0OuFHmNK7unAgG1KhOsH39ksMUbQ==
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=dynu.com; s=mail;
 b=k86g2QPTfgXWUBIAoeUItMiE8hgLQ2WQbp0ckB8346enRAflsNi9HqxNJyziDrBsCxemCdqMm4Qvfe+5AuXmC7MA9t8Mqjt1+IiD/wz9HPF9XjPQjkoC7w21obknzy64RSdRd9YPacJAK1EmUYst0hSR+X5lVk+kX4sf4nWn1cmnGhOmfDR9/tCB4V1vb/vcuYv8xQ/abRH93wJATa7XgkmgRVL12Sog+SEQkJAlOqTB6I6Mwnb7Av/qBG
 jPkid5hwWSea0Aowl1Chrd/XUa2JSWFHW1Dnm7D8aVPG1EtvN1YcxsgGhN47c0edFLeJ2+IkvMlKgePMjnV0EBTAunlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dynu.com; s=mail;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
 bh=UCtunqk+Fmc0sd0IPCVoA3RdjciFhdw4WwHo64+lRJY=;
 b=EQ98xnfstNm40Ez0ScnEWb6m69RKTpveEKd5hI0GYVYJK4zCL2YspNskOb+WHn4o6bDX6t2xdr0uYO08jetHbxCDIuch2HUdAyHxFWYSS3K36pLQNZAMl7+xnobPv2EaU/JFAO1A/s6Str1OGszD1f36D0tEuLvcsWGi+mqAFtM4jIytnAXnHWs+7e94YPAobcTlqroUpYeZ8MZeuvJtn0oIqSRgaqKe9TTWxZKf76K80gtxShh48Y7LAY
 EruqXs5SZeJr1N0XewsfQYuVKMPms5T4yi3Os6llsTVWdrCWQCLlCfXRhDGIsjlTU5oG72cy52fRM2/8XP18/y5SfFjg==
ARC-Authentication-Results: i=1; mx.dynu.com;
	dkim=none;
	dmarc=fail
Received: from GRAPHRT (188-24-194-9.rdsnet.ro [188.24.194.9])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 29 Jun 2026 09:33:24 +0000
X-Original-Rcpt-To: m95d+git@psihoexpert.ro
Date: Mon, 29 Jun 2026 12:33:28 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Erik Faye-Lund <kusmabite@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Marius Dinu <m95d+git@psihoexpert.ro>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [BUG] drm/panthor: intermittent freezes in Xorg xserver
Message-ID: <akI76PpXwFP3/O1C@GRAPHRT>
References: <aj5neetgYdu0QpcK@GRAPHRT> <20260629094419.6bb56d99@fedora-2.home>
 <CABPQNSa0-wqQTm0CzLFojWZLVY5OqQxWTXrpO=O4p8go52808Q@mail.gmail.com>
 <CABPQNSbwC=VtjjQiDd6B9ExT4GhgJOGUu-_tTeZ8TvgqDDbqKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPQNSbwC=VtjjQiDd6B9ExT4GhgJOGUu-_tTeZ8TvgqDDbqKQ@mail.gmail.com>
Authentication-Results: mx.dynu.com;
	dkim=none;
	dmarc=fail
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

On Mon, 2026-06-29 10.51.32 ++0200, Erik Faye-Lund wrote:
> Silly me, I forgot to disable HTML email, so this one bounced for
> some, resending. Sorry about the duplicate.
> 
> I wonder if you're experiencing the same issue as this?
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15116
> 

I have no ideea. That bug report is way above my understanding. Sorry.

> 
> > On Mon, Jun 29, 2026 at 10:24 AM Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >>
> >> On Fri, 26 Jun 2026 14:50:17 +0300
> >> Marius Dinu <m95d+git@psihoexpert.ro> wrote:
> >>
> >> > Hi.
> >> >
> >> > The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
> >> > mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost driver,
> >> > xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0.
> >>
> >> Are we sure that's a panthor issue? Also, is this a regression
> >> introduced by the latest kernel version, or has it been like that from
> >> the start?
> >>
> >> Also, would you mind opening an issue on [1]?
> >>
> >> >
> >> > The most clean way to reproduce this bug:
> >> > Form a console or ssh session, start Xorg in background, without a window
> >> > manager, and then run x11perf on that display.
> >> >
> >> > Xorg :0 &
> >> > x11perf -all -display :0
> >> >
> >> > The bug: weird intermittent performance issues in some of the tests.
> >> > Examples:
> >> >
> >> >     1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
> >> >     1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
> >> >     1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
> >> >     1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
> >> >     1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
> >> >     5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline
> >> >
> >> >  5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
> >> >  5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
> >> >  5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
> >> >  5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
> >> >  5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
> >> > 25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle
> >> >
> >> >     1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
> >> >     1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
> >> >     1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
> >> >     1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
> >> >     1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
> >> >     5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid
> >> >
> >> > There are no messages in kernel log or Xorg log.
> >> >
> >> > Visually, most of the tests runs fast as expected, but in some of the tests
> >> > it gets "stuck" randomly. The test suddenly freezes while drawing the pattern.
> >> > Then, after a while (a few seconds up to a couple of minutes), it gets
> >> > unstuck by itself, draws a few more patterns extremely fast for less than a
> >> > second, and then it gets stuck again.
> >>
> >> It smells like a signalling issue. Can you check the CPU activity and
> >> report any outstanding process? Can you maybe connect a gdb to the
> >> x11perf to see where it's blocked, and post the backtrace here (or in
> >> the gitlab issue)?
> >>
> >> Regards,
> >>
> >> Boris
> >>
> >> [1]https://gitlab.freedesktop.org/mesa/mesa

Marius

