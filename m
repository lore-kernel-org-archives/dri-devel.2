Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7FCC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA68C10FAC9;
	Tue, 15 Sep 2026 08:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UtF/0yZV";
	dkim-atps=neutral
Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com
 [74.125.228.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FFE10FAC9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:06:40 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id
 4fb4d7f45d1cf-6a9dfe4dfc0so3191052a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789459599; x=1790064399; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=heCFy2bFPAFPDyeCf8OpyG8vFQyBTqauqjXZX0i22bg=;
 b=UtF/0yZVc92psVgzz+A15KKYSgN9oNUlPhpCYNNPvsP0DgXpNwg5AAzmBcusWz5KpX
 jelqas2ptDE3fkY7Og3XRRG/z90dcZ3P3rbVevNRptZSzjnbn0FOxlcLsgSfCE6KIn13
 gCprdMffmMJefgtjVk3cLoyCS7sB7DNtBXM7wO5DUZZcjkHMdubXVZwiPZ7QxGCUYVIo
 E6SfcLSfOQiMyY4rICjZ2z+jGgTSN2izb75T2CPxBWXrFoYcs1FWcxzr5u3EmcVK72Do
 jJYkbQCamBy15Gbtdnb8IuVhpHsSoHx9jVLAgHV3ibRaw2L39CGTfErT5ySdftrKzh5Y
 ec+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459599; x=1790064399;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=heCFy2bFPAFPDyeCf8OpyG8vFQyBTqauqjXZX0i22bg=;
 b=kCHTwUtGszFah/PxLeh7JY7oTMxmS8/iS6SqVQLfR9AEz6ClEPUNqriJ6fGAnd7wPq
 WuB5eNc1o47bNOQyx3rB0EpFMfECtSjJ+k7EIxWg7gP6d53CUcpzVwbPlqAw/8iDmUe9
 YrCIgyFPj93zQM2vq/pEXiHYhSEWKLcfqvJ9bHGyfpt3dTnS1VOwRZ2cqkuU12HmTZt/
 O5nQYPrDiIvN3UhPEqw0uiLR9hLwKt2HtSwjDP4X+K6Uvqw3vWl6zSBBtioeqqk4v1Zh
 05Wk4oKQPFOYE06PKMLox1oISlRd27gUSxMAUDaDAVy7Oa1xMi9wIawI+4nEjk2yUOpD
 ox3w==
X-Gm-Message-State: AFuF++nQTJqZxN1W6kZRpDNeeS7vBhQuo9YBYm/kkbK9BPvRGizqatqP
 2uciUM3gRS62T7tyk+XHJ9lyaWebltJ8uZYznGnHoj532r3NPR8AQo2IWaSOEjgGXCo=
X-Gm-Gg: AYBFou2czNYR2CoApbTeKcQjI6EpXpmpVDdE1Bni5nTdvdyUUMZqY/Oj2XBK9EagHQK
 mg+oGSjgSTH0FFUAJsQZECX3tfUct4c4gRDtIhXOLxWCeHpqJrOAyO94owQEk+cStP6shZ4QD2/
 ijAJPxsvsw279R8YpcUjiMSh5qfFgGlvp92Yx3l+QECtGUmlkDjVta7wWxaiXaCXdatDM+WCmib
 R14wG8/qE+IepJi2hZINgv9BL0RGdyUFmUtb89L++ck3h13h2XLX1JAEqEP7GMtN+SkS5Bih+6S
 2Tive8Eq/WDAKVhHm+StSkL/bhpQZV57yXu12ywh0vSBEV3Xi0rxlrM8PAsb8jK/45NJcCG4yww
 lXucs+fkODyjhYF7FNpVjV7SnGdXdBnNGrLBvB/BmzSludq4HOWgZYC02cCEOp20hrPc1VOsbw3
 eWRjUBivTlbmR4nYAz1XP6z4FbHzHzMvIfMv/ViFGcXZvDra3ljmxtsda3CvPv/0m+Hd/HpjoyA
 tk=
X-Received: by 2002:a05:6402:4510:b0:6a9:9cd3:a07a with SMTP id
 4fb4d7f45d1cf-6a9f626e2f0mr4077380a12.20.1789459598660; 
 Tue, 15 Sep 2026 01:06:38 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b5831187sm5396669a12.1.2026.09.15.01.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 01:06:38 -0700 (PDT)
Message-ID: <321bcc9b1752d7fd2e1488270cb8bf4bf2cb5224.camel@linaro.org>
Subject: Re: [PATCH v3 0/2] drm/drm_crtc: dma_fence_ops fixes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Philipp Stanner
 <phasta@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>, Sean Paul
 <seanpaul@chromium.org>, Gustavo Padovan	 <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com, Simona Vetter
 <simona.vetter@ffwll.ch>, 	stable@vger.kernel.org
Date: Tue, 15 Sep 2026 09:07:58 +0100
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
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

On Tue, 2026-07-21 at 09:21 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> These patches fix two issues in the drm/drm_crtc driver. Initially I
> was hitting the BUG_ON() in a scenario as explained in the commit
> message of what is now the second patch in this series.
>=20
> After posting, sashiko.dev noticed another issue, that was previously
> masked by the now-removed BUG_ON(). Since we can't have a loud BUG() be
> replaced with silent data corruption or worse, I've also added a patch
> to address this issue highlighted by sashiko.dev. I believe its
> observation and analysis to be correct.
>=20
> Cheers,
> Andre'

Friendly ping on this series.

Cheers,
Andre'
