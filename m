Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653A1C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D650B10E855;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Gh7FhbGn";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0650010E1A9
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=sfz2jeqf2ra6deha5l34k43swm.protonmail2; t=1790532721;
 x=1790791921; bh=BaA+PvTIQkJ8Rsg8Gex3ng2jCts9EGUcExk5dx8M/ZU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Gh7FhbGn8KUlaG29K/qsA9gm7ZnxyGWOJIurE59aWJEPrym8NCx6TYC6KDacc70jB
 TPoVGZgnDRApuPRfFIN9bJ1jXJotl3S/9SV2ePvHNeW/D0inXTl9Qrx/yzPWnCSF12
 mJi+Uo8kYI+BHITIrUupGP7n9dCXFcLRqryvOipV8fgshYq+MdpAo9J2z+ewRXxnni
 tgKmsT/U+gQhn1ppAWYsTktS9kdwqU3MlD2q/JLdRqCRGpqptOroUfkwej249qI6tt
 nAc2NjgyBN+Ki9iwA/eDmBH14HrrEszHZ0z14nfhtQ+ctUCsdxgIgmIOO26Fm644/d
 4DM4mH+iZWkhA==
Date: Sun, 27 Sep 2026 18:11:57 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Lorenzo Delgado <lnsdev@proton.me>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexandre Courbot <acourbot@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: io: convert ResourceSize into a transparent
 newtype
Message-ID: <20260927181154.1757237-1-lnsdev@proton.me>
In-Reply-To: <DLNPXJ4WPH4L.2MBUGV1TAESYY@kernel.org>
References: <20260920-resource-size-newtype-v3-1-9451444e83bb@proton.me>
 <DLNPXJ4WPH4L.2MBUGV1TAESYY@kernel.org>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: 541aa433539a53276ac34d20166f44a5eb3c53af
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

On Thu Sep 24, 2026 at 7:21 PM CEST, Danilo Krummrich wrote:
> So, I think we should change dma_len() to just return u32 (I'm also fine =
with a
> new type, but it might be slighly overkill).
>
> I'd usually pick this patch regardless and leave that for a follow-up, as=
 it is
> a separate issue. But if we change dma_len() first, we only have to updat=
e tyr
> once, whereas if change it after we end up touching nova and tyr twice.

Makes sense, thanks. I sent v4 with a patch in front that makes dma_len()
return u32, so the newtype patch no longer touches tyr or nova-core:

https://lore.kernel.org/r/20260927-resource-size-newtype-v4-0-447a08af23fb@=
proton.me

Heads-up: patch 1 interacts with Alexandre's nova_num on one line in
gsp.rs. Whichever lands second needs a two-line fixup; details in the
cover letter.

