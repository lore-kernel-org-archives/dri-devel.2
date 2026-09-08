Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F0C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A56110EBB1;
	Tue,  8 Sep 2026 12:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BUtw6t9N";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D9410EBB1
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:29:27 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hfNXz7518zKnSD;
 Tue, 08 Sep 2026 14:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788870564; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cpwCirlfpQ7b0q0uxJLsDK1aH2U0BUVu/3a4N7TqfY=;
 b=BUtw6t9NoGUStX4XvZU6VN78mz8+oT46GcgQXDbmFT25x23El62/FA5yMigCdXG2rx4Xza
 ugAb5mMZnT1wFfpfcWvcch5jCysnQb02MYTLf826w/eal3nVZRh89/pD/gdxRF+E70VBZz
 SrsZI4tDkSW+AKAW+r2m5hQLi2U6YGjfAraFazUXXlakP1e3CQpCAKvs9BE0hfzCG9wodC
 akilzea+5+jVKgepf+Zk+gAvle38YIxmyyKsxT1vdAJkuNwM7T+9XmiPp+hXHRHUQaqGNR
 qB+cp8Zm1G+tBA5SBCm6hHtMkFo/9edDY+BtvSrjaHGks5NS6tSbQdmH+zDkXw==
Message-ID: <bf1c4ad1df5bdc93159b65d2acfbeffc4ae5df7b.camel@mailbox.org>
Subject: Re: [PATCH v4] drm/sched: Create a fake device for KUnit tests
From: Philipp Stanner <phasta@mailbox.org>
To: oushixiong1025@163.com, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Shixiong Ou	
 <oushixiong@kylinos.cn>, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 14:29:15 +0200
In-Reply-To: <20260908055941.351486-1-oushixiong1025@163.com>
References: <20260908055941.351486-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 6fee3086efbb3b57d24
X-MBO-RS-META: ory169k3wbdcseghx64t1jxx6bbme9ss
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-09-08 at 13:59 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The DRM scheduler KUnit tests pass NULL for the dev field in
> drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
> trace event via dev_name() on sched->dev.
>=20
> Give the mock scheduler a device with kunit_device_register(), which is
> also cleaned up at test exit. A per-function counter keeps the device
> names unique, since some tests create several mock schedulers.
>=20
> Fixes: 5a99350794fe ("drm/sched: Add scheduler unit testing infrastructur=
e and some basic tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>=20
> ---
> v3->v4:
> =C2=A0 - Initialize the instance counter explicitly

You learn something new every day =E2=80=93 apparently that must not be don=
e,
according to the DRM rules.

My bad.

I reverted it locally and pushed to drm-misc-fixes

Thx Shixiong.

P.
