Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C82C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53D610F011;
	Fri, 11 Sep 2026 10:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hiEerPN8";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBF510F011
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:35:01 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hh9sY0cKKzMlHB;
 Fri, 11 Sep 2026 12:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789122897; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKEEiD16wKkBQjxmDmRAUzZxy57faOnn/iVbND/QIsk=;
 b=hiEerPN8mdqqrsx2qHOWOvFREe6NaSSh+iiKK1eFpYokR0Yc5WE2T3/iqQvKynpfQ9oVKr
 CNllmCrH8Rq0+opOAY9GD5vrGJJA9xm+MgZuDSUF1Je+L91J7aaW+4S9dbZycPfe5LmNZf
 5lVdSXQXfEGvDxo7V9FSHSjrfuCm9dtHjOuru+m3s3d1aNSA+blUZd1lyaBhjNt4RapOsA
 eEviFPoTeDjDoMs9/0coIRurGj9ptRA7iGJpm3SXY7FpIikZNN4POCUqFT7bxLLjzbefT4
 Yz9DYfW3FyUYfMXzxhSos3hLAnz3+/KIvUM0s1amYi4ik7s8G4njrAbdi1zWQg==
Message-ID: <54380f35297f069d7c3874c5239956125e923fca.camel@mailbox.org>
Subject: Re: [PATCH v3 0/3] drm/sched: Introduce more locking to entity
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 12:34:51 +0200
In-Reply-To: <23c88f50-1998-4de9-bbdb-3d15fd06d642@ursulin.net>
References: <20260910075942.2000338-2-phasta@kernel.org>
 <23c88f50-1998-4de9-bbdb-3d15fd06d642@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: tp1esos6apfrrw8kgkncr4ej4hi35bao
X-MBO-RS-ID: 40327136b90c505ca58
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

On Fri, 2026-09-11 at 09:19 +0100, Tvrtko Ursulin wrote:
> FWIW if you could review=20
> https://lore.kernel.org/dri-devel/20260907130527.52530-1-tvrtko.ursulin@i=
galia.com/=C2=A0
> you could drop the first two patches from your series. Extra benefit is=
=20
> that patch fixes a bug and has been tested by the user.

See the other thread; I'm not super-hard opposed, but if we can agree
on getting CFS to a non-experimental status by first improving
spsc_queue, then it would be nicer from the diff / git log perspective
to have these little patches as a preparational base-line for the spsc
rework :)

Greetings
Philipp
