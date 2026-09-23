Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97106C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C6D10F1B7;
	Wed, 23 Sep 2026 20:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OVu5bhEQ";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1575E10F1B7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790196361; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZD9at1IpVlzlBeE/go+I66CNqaktVJ1OfMyx7UmC4WOcr0cKhugPY5B+vBYCd41vPoqI3olB//mLPAlC7YbwIzthxkz+f0lCNPXkGyKKcpgaIaL0s6kr7+vmr11K5EC2nQtOV3Yx5KP/zKgxN87fgQJNkLTC60fs0NduiXuefyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790196361;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wnOjea9Ulf5NeEgYzIRVLFVysAiGNWc+4LJnVYwpa80=; 
 b=GS64NqTjsZI6RfPy/d4gLJ2RrUM+YTypROserIICal4l+dArxAamKaESZAQUXsQSAtkgZzukrX84tdH2W2JiIm1XaK3OKrWwR1S0aFoX/4vFwAQY7vsKkctaazpvWFjOl8zA9BA8DvbDmO85Yf8MqV2+RJZmqAHjB8XKkQIEfi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790196361; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=wnOjea9Ulf5NeEgYzIRVLFVysAiGNWc+4LJnVYwpa80=;
 b=OVu5bhEQd08Gjph8Nz/TZFvDnsMdZlvHWxXkY2MPAHVUCZgwXg8ofB/5pjx010jS
 Tw9Akxblfgm3EdmiAdI+NApXkFVhz3wHSkGSeWiA+6XrAwkVmrB2sOU+hXTDtrvbb30
 tClMPrmtN2v6Ke+UCAHPcv4ssqYJ0pOYebEWMlIo=
Received: by smtp.zohomail.com with SMTPS id 1790196358937700.4388191159652;
 Wed, 23 Sep 2026 13:45:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 5/9] drm/tyr: drop unused KernelBo::bo() function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-5-5d28f1f75aca@collabora.com>
Date: Wed, 23 Sep 2026 17:45:39 -0300
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 kernel@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F19ABD7-1375-4559-A357-BCCEF91E0DD1@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-5-5d28f1f75aca@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External
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



> On 15 Sep 2026, at 07:57, Laura Nao <laura.nao@collabora.com> wrote:
>=20
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
> drivers/gpu/drm/tyr/gem.rs | 4 ----
> 1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 6ae4e71d3cbf..9a75344acc3b 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -142,10 +142,6 @@ pub(crate) fn new(
>         })
>     }
>=20
> -    pub(crate) fn bo(&self) -> &Bo {
> -        &self.bo
> -    }
> -
>     /// Returns the GPU virtual address range occupied by this buffer.
>     pub(crate) fn va_range(&self) -> Range<u64> {
>         self.va_range.clone()
>=20
> --=20
> 2.39.5
>=20

Please squash into patch 3.

=E2=80=94 Daniel

