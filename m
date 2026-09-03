Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A7DC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0719E10F57F;
	Thu,  3 Sep 2026 12:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QjV2fdHL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45DE10F57F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0FEB6022C;
 Thu,  3 Sep 2026 12:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA61F000E9;
 Thu,  3 Sep 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788439089;
 bh=urmx6qLh7VqDwwY05WBP8jBUzRmTsPXeBMyOQrawmAQ=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=QjV2fdHL6Lnn2dWGdkkV730m1GgAhDgcmWXi52teSaNbSIn3W98RCHSjaw1+KLLck
 KokUNqf/xK8fMi7vUiwyhN/dKzUEtA04rcYwmTIwHcDY9F8BjAzYDR8bB8Rb/T4xbc
 yUdMZ2sZ11OEKpkRA8utOYoCzy6T3Yet2FmrHaS4TQa1A0hhM539FQA2jDUYOGE5DU
 YY0phxpSVFVlZAxiDqA/ntr5GpEoxWaJco7nVdiRTwzpQnUwC8AYXWYlqH2udEO0Ql
 NZRNeXJKOjVFmecqqDVP+QRhqZdRzJa0UuY5SqzGGyWju/IG6Hd7EAQ/GW8LoZdjKT
 hrCNijZa63+oA==
Message-ID: <8680c6a6bc2793ab83dd4e921bb370bb@kernel.org>
Date: Thu, 03 Sep 2026 12:38:06 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: oushixiong1025@163.com
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
In-Reply-To: <20260903121558.782854-1-oushixiong1025@163.com>
References: <20260903121558.782854-1-oushixiong1025@163.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Philipp Stanner" <phasta@kernel.org>, "Shixiong
 Ou" <oushixiong@kylinos.cn>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
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

On Thu, 3 Sep 2026 20:15:58 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The DRM scheduler KUnit tests pass NULL for the dev field in
> drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
> trace event via dev_name() on sched->dev.
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
