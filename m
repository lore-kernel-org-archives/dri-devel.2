Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B660D10BA45F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6F210ECD0;
	Fri, 27 Mar 2026 09:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="u7pSvGED";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE0B10ECD0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:31:28 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso1412121f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774603887; x=1775208687;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=V1OwEf8imgEcaY7dllHNGM8XinZT2Wtp74qO0bSsJFE=;
 b=u7pSvGEDfSXPRP0kyX8jY2FpsiJY3jDoWXlg6fz6zLtMJBykQOFeL3pzKuYvr5RzH2
 TCYGhvXT16M64RKSKF/okxLMbfvvJkMVNBG7jXEMPj3GXMeLdBOZD1sy1yHEIiClvbtT
 9vDTkFf9nvVChETQiZzmPm3AfYoQ8rgLZRsRk7oqtPwpPZgco7z2I2jbmCzPPsPY/Oz3
 XgnYSg9V35l2wDJffxepznQPRhnQctv3jSdAJEVyjHmdKJeOcehIQWdJ271KeNlk0E+R
 6vped4EulyzoNOHR4rgrmYIF1Eu75xzlhUKw18grM6fLadbr7EQlGhKYjMXx4SQ7CVMz
 k1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774603887; x=1775208687;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V1OwEf8imgEcaY7dllHNGM8XinZT2Wtp74qO0bSsJFE=;
 b=VB760L01C5EXjT2IYodp7ol+pk+wETx0cKX44cwW2lHadw20ZQ5/l0kTT2wPxY1YOr
 SnmHk0kefkUhTozuXjh0wPIMeqgJ8YtdLdbUNRGgqpvGgPP7T0f3tnmgkt/yjyL9sk1I
 dzQmR0SITdcD1XXoXjvdt8zENb0iI1c9qUxTUW2nka03PRkbDdiWocoMenFzll2FdwHL
 aov/AJJxaIvnEduKGMckxAlWmYLeDgvxlqh1r90l2X7gPTaJSlNYNE3JfGVdTWOztj7D
 +ERE/s4wk95CDZSIOOo+czGMeDTd6LUrdgiWVHpQHRbsg/22yva7z3SIJgROpUIMkTmr
 IHBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpg7CnAGErFnNqd0vhp3MUX95sIPAHhGvNIwkGxLL7BC92ueB/UtP6xtdZ/f0iyI9DQ2JjAu4MEI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxR1aBcwFOyS8VAyUHHVmiN0kvudCs5meDhuMVzvdxCesDuaYa
 B0tHj56IziMR9cNHKbK/cacJ6qBdwINiY0aco2E4MmxaXgRoR89kq10PvHqJZ50+jReB7zNkZGp
 mVC6r/lKeFHQTZAtNUw==
X-Received: from wmog15.prod.google.com ([2002:a05:600c:310f:b0:47f:941a:613d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c4:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48727eb7fcdmr29769655e9.22.1774603886661; 
 Fri, 27 Mar 2026 02:31:26 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:31:25 +0000
In-Reply-To: <20260313150956.1618635-5-adrian.larumbe@collabora.com>
Mime-Version: 1.0
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-5-adrian.larumbe@collabora.com>
Message-ID: <acZObe3EktbKooBa@google.com>
Subject: Re: [PATCH v5 04/11] drm/gpuvm: Add a helper to check if two VA can
 be merged
From: Alice Ryhl <aliceryhl@google.com>
To: "=?utf-8?Q?Adri=C3=A1n?= Larumbe" <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Janne Grunau <j@jannau.net>, kernel@collabora.com, 
 Caterina Shablia <caterina.shablia@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
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

On Fri, Mar 13, 2026 at 03:09:41PM +0000, Adri=C3=A1n Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> We are going to add flags/properties that will impact the VA merging
> ability. Instead of sprinkling tests all over the place in
> __drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
> can call it for every existing VA we walk through in the
> __drm_gpuvm_sm_map() loop.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

> +	/* We intentionally ignore u64 underflows because all we care about
> +	 * here is whether the VA diff matches the GEM offset diff.
> +	 */
> +	return b->va.addr - a->va.addr =3D=3D b->gem.offset - a->gem.offset;

Please use wrapping_sub() to make it clear to sanitizers etc that
underflow is intentional in this case.

Alice
