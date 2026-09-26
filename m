Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4BFC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F8E10E2C3;
	Sat, 26 Sep 2026 16:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CoOcC+73";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C0710E2C3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:48:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98BD36020C;
 Sat, 26 Sep 2026 16:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05FB1F000FF;
 Sat, 26 Sep 2026 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790441334;
 bh=RcZ+pSBf1OxNGAAu5cwpwDBrRg3O+gIK2LnrVbUiwNc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=CoOcC+730dBIoTCfVxQ6bMr+mBu3k3sbI8jngJBlPjbG60U/21vj+9turXUV5YYej
 qihsx52Gi7GeP1/Oy2pEIvH7GRyBaNll7ICHO9SCqYIYLaNkdzpkUkWgBWLGE5rfXH
 wGOs90Yhp7acFSNpl7VZvVZqbu0PgARE0b/3DDwieUJ6rdrYNv9yRJ0uFL3ZFA2JmG
 EptHQXcyEbs4kMOzobYACLnhSuiESF45FOWgiOaHzJyEtsMl8EWW9AfZq8EV9wV7/Y
 7XJqKi+hpEf7wH9xCQgRJV4whKYjMa/BVHxp0HPMREnFzB8x85E8STaupKUz9Y9y1V
 Pn9JlHioRSHkA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 18:48:49 +0200
Message-Id: <DLPEHBOTZCCU.1DFPII93RC6LA@kernel.org>
Subject: Re: [PATCH v3 2/2] drm/tyr: safely write GpuInfo to userspace
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-2-e19bcb71980d@collabora.com>
In-Reply-To: <20260925-b4-gpu_info_intobytes-v3-2-e19bcb71980d@collabora.com>
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

On Sat Sep 26, 2026 at 2:26 AM CEST, Deborah Brouwer wrote:
> @@ -54,7 +54,7 @@ pub(crate) fn dev_query(
>                      )
>                      .writer();
> =20
> -                    writer.write(&reg_data.gpu_info)?;
> +                    writer.write_slice(reg_data.gpu_info.as_bytes())?;

I think we eventually want write() to require T: IntoBytes + Immutable, so =
I'm
not sure there is much value going back and forth with this.
