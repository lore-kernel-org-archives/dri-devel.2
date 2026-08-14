Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7170FC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DC710E538;
	Fri, 14 Aug 2026 11:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="RM6wIpCJ";
	dkim-atps=neutral
X-Greylist: delayed 88575 seconds by postgrey-1.36 at gabe;
 Fri, 14 Aug 2026 11:20:52 UTC
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA8410E538
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1786706450; x=1786965650;
 bh=gZ/xY1sbSmHJCkms60/TkZPkt1U/i9ryG+oCm5UgYgs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=RM6wIpCJhmVGinbIi5+H+Iv8TmFW5a0Cu5+6zMVwUJwOuDQLX5I/uc3ATyUgU0JU/
 k3fsvmLc+g+XY6JdGGNomq7AaqoO18kiVQ2EFwLUe6sS4+FaVzwudutV4zRT2YjYOs
 yoYB46EaIptWOKxrpVf/IXEhAYnaBS5oPTNxbLTDOyMwWZhTb1oP4+a8mRkDfyjBel
 jx+xcI8kla47FWQmR2sROKEgGaMBUuA0ONMJZ5Dsp7IGOG6IVmPOX4pzawM5ggYayX
 82Zhmm0zBpPyNrTd53qfA8G7JzFBsxXLSArwYbZJprW8pQ/35smnbyKQhGSQBSwiKd
 NnLZOrvNc/p4Q==
X-Pm-Submission-Id: 4hM0CM0VVkz2Sd4C
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 3/3] drm/tyr: add GPU reset infrastructure
Date: Fri, 14 Aug 2026 14:20:39 +0300
Message-ID: <20260814112045.72877-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <D4F91EDE-5FD1-41F8-B5AE-D8C2EA25545D@collabora.com>
References: <20260813-tyr-reset-impl-v4-0-b36fcd0805b2@onurozkan.dev>
 <20260813-tyr-reset-impl-v4-3-b36fcd0805b2@onurozkan.dev>
 <D4F91EDE-5FD1-41F8-B5AE-D8C2EA25545D@collabora.com>
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

On Thu, 13 Aug 2026 20:25:15 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Hi Onur,=0D
> =0D
> Can we move the iomem to the HwGate and get rid of its Arc?  This way we=
=0D
> ensure that all hardware access must consider the possibility of an ongoi=
ng=0D
> reset by having each component that needs hardware access hold an Arc<HwG=
ate>=0D
> instead. Perhaps we can even broaden this to "hardware must be powered on=
" at=0D
> some point in the future.=0D
=0D
Sounds good to me, will do that in v5.=0D
=0D
Regards,=0D
Onur=0D
=0D
> =0D
> Otherwise, this looks good to me. Let's wait for Alice too.=0D
