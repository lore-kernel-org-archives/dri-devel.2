Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D80C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5629810E853;
	Mon, 17 Aug 2026 15:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="apMn5jXX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBBC10E853
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:18:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADDC1600AE;
 Mon, 17 Aug 2026 15:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF001F00A3A;
 Mon, 17 Aug 2026 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786979898;
 bh=GlBDrNemJGOZ2p7bCdTXX5Uz/rOAfEi0mhDIUCyeYy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=apMn5jXX5/5bVQmMmSf8J2E2IyvNObdJ8YR4tYPhgJGp4TA+QX/JFblQLu94OKs3p
 xOsq+Y5ozUgeEuq/3jMdc7oaNu1id3OssgoU7k+dHGdKLtMpzt+x5v3fPCZ+LkpXgi
 WdoOnA5HV+c93h40qvIlAeKXEAnDR3v3lAe+DOrD/LbzxNqy9byGIz9tzievzTAX8n
 7AAy81jwMu5zWiF2ylTA0kUsvTpq7ivAOuMkpYXpvplgeHBbtoj0ChTwobB6r/6A6a
 o2Svz3CvLT4bb/AlDEhmHp9PUXvjeFf1m1sTmjkpB70QYMLjWHwYADsVILc8VzZ3bn
 KjP/as4ReuMfA==
Date: Mon, 17 Aug 2026 10:18:15 -0500
From: Rob Herring <robh@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Saravana Kannan <saravanak@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mripard@kernel.org
Subject: Re: [PATCH 1/5] rust: of: add Node type
Message-ID: <20260817151815.GA757484-robh@kernel.org>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
 <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
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

On Mon, Aug 17, 2026 at 01:40:46PM +0200, Albert Esteve wrote:
> Add a Rust abstraction for `struct device_node`, the device
> tree node type.
> 
> `Node` wraps `device_node` type pointer and implements
> `AlwaysRefCounted`, allowing owned references to device
> tree nodes to be held. To do so, add C helpers to make
> them always accesible from Rust bindings, independently
> from the configuration.

struct device_node being refcounted is a kconfig option 
(CONFIG_OF_DYNAMIC). What happens when that is disabled?

> This abstraction is needed for subsequent patches, in particular
> for creating drm_panel instances from a `const struct device_node`
> pointer argument.

My intent is to make struct device_node opaque. We may never get there 
with C code, but please make sure Rust is that way from the start.

Rob
