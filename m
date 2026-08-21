Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ACDC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C69610F394;
	Fri, 21 Aug 2026 16:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="LVclSAUY";
	dkim-atps=neutral
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BC710F395
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1787330555; x=1787589755;
 bh=m1czO2YB4t/SDWjO/C1S4Edo0WdLGwx3m/cuF6R7Dkk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=LVclSAUYOc29g9l5UGTnL9uuezJStxe1RWDuEFjVRYW2I+oavtOv/yaJPFfEdBn6F
 3HtsTEZY1mnyEfVXMAMlY61opI3uGqxoYdHqjzb/6h+SLDY9VmyQxcomZQeD1+FOVu
 bEwZEelpauT8I6n/R7AwVOnccL7YJIwBF9hJHvpFXD16abLEJQCaKeVAsW7v8OQWw4
 66sMoOQrlcyuuxDVoiCy07PkuB6GAzIS4e4yIdeHqlru+g1cB/6iMbBwgWa662x5+U
 9lwfZCc4nFZtSaReJdqC5BvKZW5o6oOCZiJ9AKR9W0NXMieuFQWHa0AG70SkK6V7DD
 UArgOQRTcKzzg==
X-Pm-Submission-Id: 4hRR1P299Gz1DDLk
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
Date: Fri, 21 Aug 2026 19:42:30 +0300
Message-ID: <20260821164232.1118419-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
 <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
 <20260821155814.980146-1-work@onurozkan.dev>
 <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 21 Aug 2026 13:39:45 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> =0D
> =0D
> > On 21 Aug 2026, at 12:58, Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > =0D
> > On Fri, 21 Aug 2026 12:31:03 -0300=0D
> > Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
> > =0D
> >> Hi Onur,=0D
> >> =0D
> >>> On 19 Aug 2026, at 15:45, Onur =C3=96zkan <work@onurozkan.dev> wrote:=
=0D
> >>> =0D
> >>> Add support for scheduling GPU resets on a dedicated workqueue. Track=
=0D
> >>> the reset state to avoid queueing another reset while one is already=
=0D
> >>> pending or in progress.=0D
> >>> =0D
> >>> Use an SRCU based gate with mutex-protected reader admission to block=
=0D
> >>> hardware accesses while reset work runs and wait for current users=0D
> >>> before resetting.=0D
> >>> =0D
> >>> Stop new reset requests during teardown and drain any queued or runni=
ng=0D
> >>> reset work before releasing the device resources.=0D
> >>> =0D
> >>> This is the initial reset infrastructure only. It is not wired to a r=
eset=0D
> >>> source yet as those will follow in separate work.=0D
> >>> =0D
> >>> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28=0D
> >>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> >> =0D
> >> I=E2=80=99d use dev_info instead, I don=E2=80=99t think a reset belong=
s in dev_dbg.=0D
> > =0D
> > It was dev_dbg initially, Danillo said otherwise and I changed it. I ha=
ve no=0D
> > strong feeling on both.=0D
> > =0D
> =0D
> You mean it was dev_info initially?=0D
=0D
Yeah, I wrote it incorrectly.=0D
=0D
> =0D
> > Does it deserve a new version to switch back into dev_dbg again? I thin=
k we can=0D
> > easily switch that when pulling this series.=0D
> =0D
> My point is that resetting the GPU should not be a =E2=80=9Cdebug=E2=80=
=9D trace, but rather something=0D
> that should hit dmesg unconditionally. Of all things that are printed on =
a driver, a =0D
> =E2=80=9Chey the GPU is being reset because something crashed=E2=80=9D is=
 something that should=0D
> always show up IMHO.=0D
> =0D
> I don=E2=80=99t think you need to send a new version though, let=E2=80=99=
s wait for more feedback=0D
> as well.=0D
> =0D
=0D
Okay.=0D
=0D
- Onur=0D
=0D
> =0D
> =E2=80=94 Daniel=0D
> =0D
