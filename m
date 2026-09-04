Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93E9C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C293710F872;
	Fri,  4 Sep 2026 07:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BiEbd8l9";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75C410F885
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:02:57 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbnV64XTpz8tYt;
 Fri, 04 Sep 2026 09:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788505374; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkTXhSUxZlPterV5lsTm8TrVGWaiq1FzBIugDqMjlws=;
 b=BiEbd8l92lFlcr7LOcHlM8gA643/Vc9+1R88BCQ7NzVLApWfJAPWQCSWRvFFy281WlhDw0
 PezwhO4w2JR7tNEQQH7wLJ0xpNY13YGV850R808XXB6pO40xbojMW1Jh0ww70CgKNGs8lh
 vppiq1JZ+oEiD1LcYM53MrdvvtqC44Pn7ihn+GGfL4EtqliQOErxqEXF1uNwiWVwKF0B/F
 WjEPHaFa0wQcZSKfF4PtK60sCOedyJUXgI7yYCs41ZSnXP/gqvEGIQYK36fPK8MqTy9YnF
 avdvHuMEJGM2V3bz6DXJopyh4JfC1x/4kFC+6+DNIkJs4M6qUk0kttMe+oU18g==
Message-ID: <fcecfac828dc3f338d59125d6f0306534e1e2429.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
From: Philipp Stanner <phasta@mailbox.org>
To: oushixiong1025@163.com, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Shixiong Ou	
 <oushixiong@kylinos.cn>, stable@vger.kernel.org
Date: Fri, 04 Sep 2026 09:02:47 +0200
In-Reply-To: <20260903121558.782854-1-oushixiong1025@163.com>
References: <20260903121558.782854-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 4djizz5oszf5r9qr1y37yya6k5mi3tz1
X-MBO-RS-ID: 75dbe8cd375fafa4137
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

On Thu, 2026-09-03 at 20:15 +0800, oushixiong1025@163.com wrote:
>=20

[=E2=80=A6]

> +
> =C2=A0#include "sched_tests.h"
> =C2=A0
> =C2=A0/*
> @@ -288,6 +290,7 @@ static const struct drm_sched_backend_ops drm_mock_sc=
heduler_ops =3D {
> =C2=A0 */
> =C2=A0struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, l=
ong timeout)
> =C2=A0{
> +	static unsigned int instance;

I know statics are initialized to 0 automatically, but writing it out
explicitly is probably advantageous for readability, especially since
we're incrementing.

> =C2=A0	struct drm_sched_init_args args =3D {
> =C2=A0		.ops		=3D &drm_mock_scheduler_ops,
> =C2=A0		.num_rqs	=3D DRM_SCHED_PRIORITY_COUNT,
> @@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struc=
t kunit *test, long timeout)
> =C2=A0		.name		=3D "drm-mock-scheduler",
> =C2=A0	};
> =C2=A0	struct drm_mock_scheduler *sched;
> +	struct device *dev;
> +	char name[64];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	sched =3D kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
> =C2=A0	KUNIT_ASSERT_NOT_NULL(test, sched);
> =C2=A0
> +	snprintf(name, sizeof(name), "%s-%u", args.name, ++instance);

Any particular reason why you begin with index 1?
