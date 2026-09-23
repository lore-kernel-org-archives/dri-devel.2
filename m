Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CC6C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5444510F1B3;
	Wed, 23 Sep 2026 20:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="f+AiFKSs";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C9A10F1B1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790196241; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Od7M/wSA5tzikDii9QWKFsoZ5vgDGjBtzcb0bvM09AK5BcZv6uRozRAf/zkyysrYxvO4t595mzW5PyALvuzvvR37ZZ3peVnKipwOvI/jptXo54FW+flUddvRWMN/PTXhu1lyT+NbrzmGJhNkuLephmGZMzIiTuFS3qG+w//vKsk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790196241;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nIvStNaBwCUS9YqtzrTcJ+q9eFKmm8kIUj274/Rdrsg=; 
 b=lCseOl7ivxGPJqyykbMcQIb8pZ/fjUlZ+FQMknbBP4A7TEjAt9jCYfZe1mkpWfmE3J8pAm8Vnqd4vCOBZE8x2L/M9K6KrbYn04iZ/pTJ3Aob31hb7YGYYHg/3GI4hlRgL8i3FnqzbXXBG+y0viAzZ6N1X70oJQw1Qxy8oauSpmU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790196241; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=nIvStNaBwCUS9YqtzrTcJ+q9eFKmm8kIUj274/Rdrsg=;
 b=f+AiFKSsMJLBM/RFvzar2N0OoUiswUecC+yuWuXB3Xpjz+smTTtjuKGSvLSlNTfL
 thwigXIAFp7ndkJE1GUxOFHoT2oeaFm/cyUWyWrM8aqPJ/YY8SU1RkrD1LNFMLXSrzI
 lYRbM30+eQghQF6MS87/g3T/Mz9NiEOT3FqYV08A=
Received: by smtp.zohomail.com with SMTPS id 1790196240105565.6208435910355;
 Wed, 23 Sep 2026 13:44:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 3/9] drm/tyr: add MappedBo, a kernel BO with an
 always-valid CPU mapping
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-3-5d28f1f75aca@collabora.com>
Date: Wed, 23 Sep 2026 17:43:41 -0300
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
Message-Id: <F5006B5E-CFC1-4EA6-9D15-8D68CBCFE2ED@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-3-5d28f1f75aca@collabora.com>
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

See my reply to 4/9.

=E2=80=94 Daniel=
