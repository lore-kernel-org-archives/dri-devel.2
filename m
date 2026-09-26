Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E105BC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD3610E3A2;
	Sat, 26 Sep 2026 16:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="flAwOjtS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B9A10E050
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 977156020C;
 Sat, 26 Sep 2026 16:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03F91F000FF;
 Sat, 26 Sep 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440005;
 bh=q8p/wCUk8cWVpUL/3mdSIEThA8tm+/7jX39lkkQ8EEE=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=flAwOjtSPoX6dbTjcTGiG9G5mEsSqXKigcjPcsTE95yFQlnCWcbdG9LDZBanvyjJO
 vz2617T24PmV5j1L4jxsdVqWrs3opwO6mHh65azECEac23cph7jU9WHm8RYo8EviTt
 nxLTeDznZ35PU2yaNzIqrMaupFe99QfjFHT1KIQObGpaoI8LVFfmpko9PLLQMf5XvI
 82XYV1a3o+fCrj5grGpHxgw8E59xs+ckJKvMHDeDNVS/XTu2lgjm70H//j6d7KFJn+
 CjN8MdCoVHgUcRfnOI8bEgt2bFpw7uLeB7ImdlBGdFXF5D5CgSfzWv/KSGl3Pf0fA9
 gO03tOMkT5hug==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 18:26:40 +0200
Message-Id: <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
In-Reply-To: <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
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

On Sat Sep 26, 2026 at 5:50 PM CEST, Gary Guo wrote:
> On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
>> @@ -71,3 +71,6 @@
>>  # Structs should implement `Zeroable` when all of their fields do.
>>  --with-derive-custom-struct .*=3DMaybeZeroable
>>  --with-derive-custom-union .*=3DMaybeZeroable
>> +
>> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
>> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3Dzerocopy_derive:=
:most_traits
>
> This is Tyr specific change and should be in patch 2.

Why list all of them separately? Can't we apply this to all uAPI structs?
