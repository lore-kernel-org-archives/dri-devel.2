Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E8C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F44D10F217;
	Thu, 13 Aug 2026 09:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Xwk8AWY8";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/9SiPgS";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9D710F217
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:27:11 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailflow.stl.internal (Postfix) with ESMTP id C088513002E3;
 Thu, 13 Aug 2026 05:27:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 13 Aug 2026 05:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786613230; x=
 1786616830; bh=hsFxZ3Ixcxao/UXVeMngQAQyl2hgDxb8MfUV5pS9FUs=; b=X
 wk8AWY8y35vFRSuC0ov4nAO2Q2loXiexbgX7ejR4U7I7ayhSOnWRtCRvqtVkMqCt
 NouaXTbR1h7dbbLl2V5tF8dn2dqWA0SELOs15A5AktZjwZi0+5XIwrBSlu/3FsXV
 i+r/16Riveo7a8euMTs4OyINO4YhS1ZNn1to4VmG3BnR8uQ1ppBIhaG+BH/6JXos
 clLt90XpluD8XIVWvMKLX/hJQJIlHQ1vVv4qi/yQkNREj83lXosfpb9QKzjMRgDI
 vi0umdk+QjLUCr/eD+yi/DoOL24V7uXymAxQ+lNL4e+sf67RZYWes+j8eSOWFS0M
 iYcNjLrOPe0boUhK3n/Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786613230; x=1786616830; bh=h
 sFxZ3Ixcxao/UXVeMngQAQyl2hgDxb8MfUV5pS9FUs=; b=Q/9SiPgSDD5isYTw/
 kl2IM8TDJ7SyZd4QGFYywlNOQsHuUbdiqPGmnlXeeTmqAs8rTERrfXHcgk7fa5vL
 eXyz4MpWlEe46/+Nf88v5J9aNZT7ow5exUvmXSCY5S6Iy0cdaz7YprPjB4V3xX5B
 PelCSqOkY1wgBaupp9rY31nAvUwsBI83HZHxTpHMRJSjmSz6P21lBFC1CLkeKng3
 TJfGld6jMDu8s14NO7IpAsrKUkWD8Ic8I8d4DhWJrLwEVfi9OzCdC8Q0i/nGjBvo
 y9VoYyhw0kH4bkDEdB8LYbxwlAGDQ2Ahl/Kv0RWLAo5gLGIamEIQFJWl15jo4Dy7
 vMvvw==
X-ME-Sender: <xms:7I19akugtWEUS6DPZSDisOQRe96mDrKGSRwGSSLpHU9mPMxRqN6LfQ>
 <xme:7I19apqy7lkyKCGEQIpAznxs8-WiSiQ653uMatsa-uUM2gfrkNbPU37rn1DxhNKmd
 NzzA1SKwKlns-bCz8jYD4057WoB2KLJ01qq4CuiwrAkxUySaVPEIxA>
X-ME-Received: <xmr:7I19arUpi3rN-uvQmTa8xKsdhGw3uLMw323IJf2e4O1hfND1WsjrSbM-xH7VcXGWOmVvUj5i8g>
X-ME-Proxy-Cause: dmFkZTFvkSju2jPjsNthsipJjLLcKiFKo2iZfGlFycdFk+MydEAZMZ8gLXf+IJPcsUPR7q
 8Lu23Zv43b+dFbQ7TjLTmPjFPmS1byNHUQMmyTnEfd3+zp8aMAPcQyxqEG2X7Wh9zAGCZO
 ASfeTun9KO56biKJV5zVg16tsQhRU+6nbKkIbeQQqpYAylrTOrls7RmnSCLmRbmc2VPoBx
 vZ1P4cH26vteFh0edZtGGFBd7vW83H5gdsKKOvjG4hwjTKUneZFr39S9vg1vWvHxW1qTXR
 zUPf2/JEHD3iDaAfdm0gPNK5y+li0Yp5cV+EPNl29rBRAnACwpAGVl/KnlQtSLM0ttX4J2
 l/am9K2O25bP9VtmYiIW+Ly6VtUhOdy3nwxs4s4paixrmj2wHjw6niht4buWZq5Asathg6
 Dbkf3vfYVYIuGsr8OqC4kUSpHnopYqD2B1I1lcBGxFLDwkMzgVNIl9UwDGwBGLeAOHbbt/
 zrpjS30/nQOBC9mfp6MZRGCNVf5ooC5X9K42rk+Wn7kUL8YNSHsfX23UoiiyVImXKYepqA
 LZeamRMgClsJiboYwdWqADPrqjEP8BIGfaM/h0cYcfyyurW+EBHPTe3j+7YPmX4UWiLHUV
 sZPMA1wA7khI+wfKRscvUa0o9jFbm+dsi+zz5LhEmixxzjFL1pi6+NaQzMhg
X-ME-Proxy: <xmx:7I19ah3mDQBzGkzh83Ngyq0CwEggQu3-m416weoqLJgBeoWeIZD-0A>
 <xmx:7I19agtMs8Kw7___d7YWK26zmLpWguftRWXsk323Xw3tnFevElH6PQ>
 <xmx:7I19apUVspdMaNcCZmZAF7KafA8U57BSQJkiVPsBIr8lCXH1si_pfQ>
 <xmx:7I19aowpXoGEJ410Ikjp4fuTgN7RDhSF8iOoY5aS8sVi7eLE0WCFNg>
 <xmx:7o19aidqPjfiTHJjLmdGvpruDWgk2Cs0qwl36P7cxE5EfU3kKVTnsL4k>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:27:01 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 13 Aug 2026 21:26:56 +1200
Message-ID: <20260813092656.2568538-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812124850.6597-1-royalnet026@gmail.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260812124850.6597-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Igor,

Thank you for the run, and for reading the patch rather than only
testing it. Both of your points are right and both are fixed for v8.
I am answering your 1/10 question here as well so it stays in one
place.

> That is the v6 comment for the poll.

Yes, and it should not have shipped. The cover letter withdraws the
premise that comment states, the patch under it deletes the machinery
it describes, and it has no code beneath it at all. It is gone in v8.

For the record on how it survived: it was fixed in my tree the day the
correction went to the list and the fix never made it into the series I
formatted. That is the second time a fix has existed here and not
reached what I sent, so I now diff the posted patches against the tree
before sending rather than trusting that they match.

> It would sit more naturally in 1/10, which already touches that
> function, or in a patch of its own.

A patch of its own, placed after 1/10 rather than before it. 1/10 is a
fix with a Fixes tag that someone may want to backport, and it should
stay the smallest thing that fixes the bug. Refactoring the function
first would put the backport on top of a restructure it does not need.
So v8 is 1/10 unchanged, then the extraction on its own, then the
RK3576 patch with no shared-path changes left in it.

> would a synchronize_irq(core->irq) before the guard in
> rocket_reset() be worth having as well?

I think yes, and before the guard is the only place it can go. The
handler takes job_lock, so calling it inside the scoped_guard would
wait for a handler that is waiting for the lock we hold. Before the
guard nothing is held, and both callers, the timedout_job callback and
reset_work, are process context, so it is safe there.

It also closes exactly the window you describe rather than a different
one. drm_sched_stop() stops the scheduler and returns; a threaded
handler already running is untouched by it, and the comment sitting
above that code says "Remaining interrupts have been handled", which is
the assumption your reading breaks. synchronize_irq() makes that
sentence true instead of hopeful.

What it does not do is stop a handler that has already read
in_flight_job from finishing its work on a job the reset is about to
drop. That one wants the check and the write to be one step under the
lock, which is what 1/10 does. The two changes are complementary and I
will send them as such, with the comment reworded to say what is
actually guaranteed.

Your RK3588 numbers are also the only evidence anyone has that 1/10
costs nothing on the path it protects, since I cannot run three cores
here. Carrying the tag to v8:

  Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores

One piece of news from the userspace side, since you run MobileNet
through Teflon yourself. As of today the whole of MobileNet V1 runs on
the RK3576 with the open stack: 995 of its 1001 outputs land within one
count of the CPU reference, against 1001 channels of zero in every run
before this. The kernel side of that is this series unchanged; what
moved was four Mesa faults, the last of which was a coefficient buffer
whose second operand has to be 16 byte aligned, which is why every
layer whose output channel count was not a multiple of eight came back
empty.

Thanks again,
Jiaxing
