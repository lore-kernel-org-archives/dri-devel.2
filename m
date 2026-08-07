Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC16C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009AB89CF6;
	Fri,  7 Aug 2026 21:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JNpXQYwy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcV3+jCo";
	dkim-atps=neutral
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BE789CF6
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:16:49 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailflow.stl.internal (Postfix) with ESMTP id 1220313000A9;
 Fri,  7 Aug 2026 17:16:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 07 Aug 2026 17:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786137408; x=
 1786141008; bh=u65a33YsPGkrm5DbFwjYqKu3v67PWiH6b2m7nICjwnc=; b=J
 NpXQYwyedpKQgkLt/svWlAD7a4eXz7jjz4I4cwX//0AGaTe3bXw0IHZFyBo4Fh8R
 N4S9wbXMnTQ9c+ukWkn4XHfZz9KsuhtFSQkEj7jK1OiRAfi8128BdYbSI2zdvMhi
 gYncV3KDt1aWDPWgTShgsb3I8CqHpR1yxsQRMw59yJ7WOZy2bjUksDn+ZIwmpUOM
 OtBOkrKZlIF5hWfcG7YQVIFFk67mnaDygTUqkFRllLLgt4FA4am5HwU9+DqXLaHX
 Ze9Zkpyr7lbdU/CzmGyHzFrI6co3pwUUswPOQw7jucuX0CVNTpJS2wqKldm/KOVs
 IXAUGoJJVpD9b7rl9oUiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786137408; x=1786141008; bh=u
 65a33YsPGkrm5DbFwjYqKu3v67PWiH6b2m7nICjwnc=; b=JcV3+jCohCCw8xe8T
 +NRlD5bdDvDK/XsEwBXTlwYTax4FDlbx2yDDOvXiZzJKTrntkoz26i7p78kVfMbY
 f8sap9GRH9rBsdk0sHpcys4phR6Gm3jpLJj/iSQ5yhgdrJlN8vmC10I+q0U0Jf1v
 M4IMXmCW5LY74T0Y/1fKG9YHLKWGcXKjD8do5x7DE6/74D/qIzq4Z9qrphGe4Jc+
 2VntX3FvY5X80QwIcWUSXBp2tFMe3ZrdF+m4LMpMzCDsDRwybmFxFoZvh2GawI5I
 8nT6QByOpJsxWzj2xDsGFCkPvBJtf92xNN5mMIWMjFUE7Qt2+Rmom1X11fl62nHH
 UvnGw==
X-ME-Sender: <xms:P0t2akcJ2AtI38arOXbPxmWwavby04k9k7MKFUpR0VRO7BIlaJSsEg>
 <xme:P0t2ask7MJWEiYtEyzG6EGTr9e8VMBAtzP4Ij0JlGXmSHalPxlV7G_wAL8uXaAQKT
 PJnCKmH__RtXbHENAt9CQwvYWRFBvKybIk6gQo-A5VU_Nif5Y5WUP3K>
X-ME-Received: <xmr:P0t2ahwsfMPv5gx3uq0_Hj_T5TBbBfljrQTb8sxSk0LzhUayqlZyoaaWrqaqxSU5V1l0bIW7jw>
X-ME-Proxy-Cause: dmFkZTE3CiQE/dtghaiNWTxUzA4DwineYnqEv0+tvipTjALwsm+Cw+C6zo0v0EpTPzQ9Mn
 7K1v0ISkThNVVdy9zT5enDYkQ328ZPmg6XlQV24kjuLO8JSp/o3UAwjIiW7c+/M1ggiOLe
 e4yOmhkBGm8SdJk3E7Ut7gVXAcjY0fjeeXkdFqLwFfbSm0l6Hyn8QaoHJTecyEmZU8CZ9n
 6Ju102hHhiwTi+oz9n3BMsoA/hR5W7g4QG9Nz1simaYp4M9rij/GI69isZiqLTFlK1jQii
 qt4HQgekyTZKyvh26ermFRPZ+C17B8wWUThV3JaE3FaDaba9TRf0wNfL1JiePztdQ5+eGb
 MNbiiPkbAahx9X54l+3mAUMxZZKU6BHwCWKlCCcvfylxNMXpoANnG87I1IH1lRAL8quzpW
 91rs4ZzdXxSXRdrvNuY8NkFSIAogxZDkYqrpsi2MzE/r57hZYruyXCprUmUxFFXkgnngq0
 aSE6/tL3UyBu0rT70BW78/qJ6XR8+mgRWmVDS6+6JK4kTkOpMezMFy1+TXtyeSScKo0Vv2
 3uTUrY7GYDxp7NryNgnWatk3UhEVV4uiGCchk/alsA9YMKXwkKO+K19BaV/g5QyAR7lHKx
 sLmpnZ5RgUrD3P2tI47I4Of9meLGI4MZHiGXw5YSAfh29d0Qb5j2XcCZikxA
X-ME-Proxy: <xmx:P0t2anyPvSI9fwDnt9X0jnw6wyMFSXtCS4UNOQRxXEYETMfbje7H4Q>
 <xmx:P0t2apWK2YBu-Dvx037tvqsy6fVYAaL8BoLIkkMfcgUEPJ3nvZC_LA>
 <xmx:P0t2amQrKFQW43WUVjDAFPPZlVFZmccJeGVSkTyS8KuXkuEcLUmm4w>
 <xmx:P0t2apQ0NB4tq6za52cwSFmo3z357rvTQQUBjPoFXEd8A8B-r6Yv3Q>
 <xmx:QEt2atVbsXb-QeqYKrl8Fi7mBfulVh_009mUPQqh4i_IFvWHOw5EB3Vu>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:16:36 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: robin.murphy@arm.com, diederik@cknow-tech.com, tomeu@tomeuvizoso.net,
 heiko@sntech.de
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat,  8 Aug 2026 09:16:28 +1200
Message-ID: <20260807211629.1573228-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fb94bd28-fdbf-4f99-a6ff-b5ab18c64345@arm.com>
References: 
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

On 07/08/2026 1:56 pm, Robin Murphy wrote:
> If the interrupt never fires at all then possibly the signal depends on
> some additional clock or power domain in order to propagate, or it's
> just described incorrectly; or if other interrupt sources within the
> NPU/IOMMU do still work then maybe there's some additional masking
> control that's been overlooked, or perhaps it it just terminally broken.

Robin, Diederik, I owe you both a correction before you spend any more
time on this. The premise is wrong. The interrupt is fine, and the
polling in patch 7 should not exist.

The completion interrupt does reach the GIC on RK3576. With the fix
below and the hrtimer disabled, so that only a real interrupt can retire
a job, a single int8 convolution runs correctly three times out of three
on three different inputs with zero timeouts and /proc/interrupts
counting up. No extra clock, no extra power domain, no extra mask.

What was actually wrong is one register write. PC_TASK_CON packs the
task number, and rocket_registers.h is derived from RK3588, where that
field is 12 bits wide with TASK_PP_EN, TASK_COUNT_CLEAR and RESERVED_0
above it at bits 12, 13 and 14. RK3576 uses a 16 bit task number, so
those three controls sit at bits 16, 17 and 18 instead:

  rocket, v1 through v6:  TASK_CON = 0x00007001
  vendor driver, RK3576:  TASK_CON = 0x00070001

So the PC read our word as task_number = 0x7001, that is 28673 tasks,
with the count clear landing on nothing. It never signalled completion
because by its own count it was never finished, and only a full reset
ever cleared the counter. That also explains the other symptom in the
cover letter, that only the first job after a reset computed anything.

  rocket_pc_writel(core, TASK_CON, (0x7u << 16) | task_count);

I found it by taking an ordered trace of every register write our driver
makes during one submit and diffing it against the same trace from the
vendor driver on the same board. Exactly one value differed. I should
have done that before writing a workaround, and before describing a
hardware limitation I had not established.

Two guesses I made the same night, a per job IOMMU teardown and the
vendor's post completion sequence, were both wrong, which is the other
half of the lesson.

So for v7: patch 7 loses the polling and the "the interrupt does not
arrive" text. I would rather not carry a bounded poll at all. Jobs that
compute incorrectly do still time out, but that is a driver bug on my
side rather than something the hardware needs help with, and the
scheduler timeout already covers it. Diederik, this is what you warned
me about off list, that a poll reads as a workaround for an
undetermined problem. You were right and the problem is now determined.

The rest of v7 follows what you both asked for: the job_lock fix becomes
its own patch with a Fixes tag and leaves the RFC series, the
rk3588_soc_data change is separated from adding rk3576_soc_data,
refactoring comes before the new support rather than inside it, and I
will stop editing a comment in the patch after the one that added it.

On the GIC question, for the record, so the thread has it in one place:
RK3576 is GICv2, gic-400 in the upstream DT, not GICv3. It made no
difference here, as you said it would not.

Thanks for digging into this, and sorry for pointing you at a fault that
was mine.

Jiaxing
