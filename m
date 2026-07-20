Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8C9C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0144F10E8CE;
	Mon, 20 Jul 2026 12:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PTPjJNf2";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8F710E8CE
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:04:38 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c15b509c323so1309541866b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784549077; x=1785153877; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4ATboiu3c5KqTH0slwsg9MiwpKOYlAoPTTY7ipBfLRY=;
 b=PTPjJNf2SL3ci7mG+m+W1aK1hjM+8w4zLYSh5M+G6N+QhEwpU7T0OFoKyp4K2dS2Ul
 Sjy0peJX5ExPqF0F90ZvjSvNQCU7a7TOjTQIp7cUhVeOL22McDEb3oEm/8ciVd8U5VgY
 5h3acsvXdYqAsir/vmzJeGQ7J1CkWZabI6wW/Rs7GwbJBzXcfYneABp6qs55WX3NIeZ0
 GafFg70EUPuzgULop6YmQl8yUZgza/ZDflKpHWjrGREVuwwnRcVAXLmjXKBdtZUhYW1O
 hRm6yoiG+H6a/iN1cJzDIqZkQPuwDddOA3UK8P2B0H20H9+QUMNu054lIz1T1Zqprxs0
 ahOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549077; x=1785153877;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ATboiu3c5KqTH0slwsg9MiwpKOYlAoPTTY7ipBfLRY=;
 b=MCrLdCs9hh4x5QccK3B658059dbunzG6X1TkdnYHF+ZgEKE3G69XhMhoDYaLay3i93
 FR5NDJiiq3oaMB6sStoCUCaHPcTLTIWrZwtnqQpnZpWTFOepqQT6ZIc7jvnEBm5VthqO
 0RO6IwOEkigAL/O8hn6sAFf6V+He0SPC9FZBRVzbwfgfVaaAh0np1ZiMLB8/HzIglvOI
 x2jOnrKYIPVvBK2AZ7HUdAKQhCyJSJES6tOnKRdQFIOE8Rn1qiHpaNZFqf+U3qqUzLD/
 VerVlTR5p/arCva8b/2wzg8gGAO4GxDhybGhOL3+0dYW4MZQDCUS3/91Jpps4QkLqfAJ
 zv2A==
X-Gm-Message-State: AOJu0YwkbhpXbIBA5S51a2fgTb6Lrud1vbuRMfkneUWfOADMKkxPtWzI
 G3wB8MEZZ+wtFqBZrMhqj22HU0yBr9jRZhbHpIQcm4z4RlEKFy3oQ6sBDHXVAH1wT6Y=
X-Gm-Gg: AfdE7ckRGr6sErLP2yAusaH03YzIXqjRfFehDKEqDWjUKR0BH8cxoptQeiMZ9GZMuDh
 BH4spGjC0npKe5JPx18NUlby3ID2J6N4O3oK0fCTwBsgXDD+uTA7DatbrFJStC1dOk/Wc2Bi01J
 oWHcwJlfVdHRYDHeiZKB/T4RKKaOAwqHyI+RIVFHDt6J4r6AZOoDeIPQTM0afrFJ5IXihM4ZTHs
 L+XCZMv1GC9YHnH7sgo4RcEqgFenPkMrk5HMGFX/A3rQdobbCngqyUdyAaJBnHNycoeFpUznLCA
 sq1DXBsHyE4PWR0Dz33HVX8zHn/dXkJehRo4n/GFGXlJ6jxDj13jrMfPD37JZvwhEoQA5ASn0L8
 8yVZI8mHYZXEyz85iTnyxb3JG4AiW4FdUvn8KiprLOUwDI04tgk2KNtWkW6+C6OpAqCTXYCn0jt
 HvdAGAyg==
X-Received: by 2002:a17:907:d508:b0:c15:f4e0:72a7 with SMTP id
 a640c23a62f3a-c16b4732c58mr541282766b.39.1784549076676; 
 Mon, 20 Jul 2026 05:04:36 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae10fsm458630066b.10.2026.07.20.05.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:04:36 -0700 (PDT)
Message-ID: <e03eb40c07d8603592ca38e7538d6709891bf811.camel@linaro.org>
Subject: Re: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: phasta@kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Mon, 20 Jul 2026 13:04:43 +0100
In-Reply-To: <b39f29efd4db9a2e10c6d1943a22b826cc5232f8.camel@mailbox.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
 <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
 <1ccfc0b5d1696a8dec4756b675294e7fb41ab5ff.camel@mailbox.org>
 <899942cc84af7a82a35b4ca34b486c40327fd543.camel@linaro.org>
 <b39f29efd4db9a2e10c6d1943a22b826cc5232f8.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
MIME-Version: 1.0
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

Hi Philipp,

(sorry for the slow reply).

On Thu, 2026-07-09 at 16:40 +0200, Philipp Stanner wrote:
> On Thu, 2026-07-09 at 15:19 +0100, Andr=C3=A9 Draszik wrote:
> > Hi Philipp,
> >=20
> > On Thu, 2026-07-09 at 14:32 +0200, Philipp Stanner wrote:
> > >=20
> > > On Wed, 2026-07-08 at 16:22 +0100, Andr=C3=A9 Draszik wrote:
> > >=20
> >=20

[...]

> > >=20
> The issue here seems to be that=20
> a) the crtc is made invalid in drm_crtc_cleanup() (memset(0))
> b) the drm_dev can disappear after drm_crtc_cleanup()
>=20
> Both issues stem from the fact that the fence callbacks can keep
> running into the driver.
>=20
> It is true that the fence, being refcounted, can stay alive, but none
> of the callbacks be invoked anymore, and your grace period wait
> fullfill.
>=20
> It is a strict dma_fence requirement that a fence issuer / producer
> signals all its fences before unload.

OK, I missed that. In that case, the patch should indeed be fine as-is.
I'll just do the (minor) updates as you had requested.

Thanks Philipp
