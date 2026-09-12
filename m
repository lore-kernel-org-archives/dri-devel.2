Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12BC88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F82E10E641;
	Sat, 12 Sep 2026 08:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kPovIeMB";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FEB10E683
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1789200205; x=1789459405;
 bh=kK7CQgC17BZEaNS8D1YaLCnpNWJ1hulzqUvU7kaLBmg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kPovIeMBW5V9/JqworP/bg79xmmgxWyhBUFtnle7WSBVUZM7q3jwb6GYoJzT8TtDd
 s8RkVjbch/6YD67SWKkC1MlZIuu37TWSWE4+UFSBnM+e+LzD0yq+uogpUos4OEkpIV
 YRNRg+WAuMXp1a72SH4yrVq4IYq1UdaN5DcgIBsBXoqfc+zUAmPLK5m8JAt8Fi52wb
 /igTf/rhVSyZzKkTTNuLOaiXRIpdlPy1GpA7rxEBPzYGkS1uRjH5CxKQiu5NCwE5D0
 2Y+wPMeU7oGPdjnDxlcS5JSy54UJ/R7XhQvY9/46jt/J2U1F+jEIQejLx2cldjPivE
 +5O7TrUHdXflw==
X-Pm-Submission-Id: 4hhkSB3vgqz2ScN7
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
Date: Sat, 12 Sep 2026 11:03:17 +0300
Message-ID: <20260912080321.78104-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <62D24E3D-0956-402E-8451-24FADC8D357D@collabora.com>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
 <62D24E3D-0956-402E-8451-24FADC8D357D@collabora.com>
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

On Wed, 26 Aug 2026 11:05:39 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Hi Onur,=0D
> =0D
> I have nothing against this patch, but as with anything touching Revocabl=
e, I'd=0D
> rather get Danilo's opinion here regarding revoke() and the Arc in the re=
gistration.=0D
> =0D
> Otherwise LGTM.=0D
> =0D
> -- Daniel=0D
=0D
Before implementing this, I asked for Danilo's opinion so I believe there=0D
shouldn't be significant issues with the approach from his perspective.=0D
=0D
But yeah, it would be great to get his feedback on the complete design.=0D
=0D
	Onur=0D
