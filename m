Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55666C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8690410F965;
	Fri, 25 Sep 2026 07:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vZCG5JLk";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747C910E5A5
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:51:48 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hrjZn74kzzMlM9;
 Fri, 25 Sep 2026 09:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790322706; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjpeIY/pG0iyYr5NWnH1XKSCrH0YfSl/S1f/surn4EU=;
 b=vZCG5JLkHEX1PNzOIaK9ft628SrijD+0AzYbRyqzLc7b3Mf+xCGIAGZ1yrtNgDoOmO1ZT5
 7eu0qA8UbgNYLqqVgVRV6Ph5BAhxKsaoWZBESI1G9y0jYfxKRKB1+Dsg23Vr8HxVcjCkFm
 /Zh3LEv2POQdRb/EiaC8Y22gLoj6OhzDIky6TljqWe5UMU0Azuf32KT40mP2SijPqPvY5W
 OY988CYe4+ZfnM8HostD7qPD0KivcSjHLPZI9bWtSa+aOoujej6oWmy1aQd6/bWXvQ0cwM
 26xcj37OcwWb8/iHoKeUxAJxyqvsm3kD4t6lIs29NeRBVSF3eRhyeVT7q+KH9Q==
Message-ID: <c74e694483833b6eb1fa56228e67a9fdf9f1ab6c.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove forgotten header
From: Philipp Stanner <phasta@mailbox.org>
To: Marco Pagani <marco.pagani@linux.dev>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Matthew
 Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Fri, 25 Sep 2026 09:51:42 +0200
In-Reply-To: <50b4b64d-7948-418b-9f3e-9d841fc426a3@linux.dev>
References: <20260625104903.1713213-2-phasta@kernel.org>
 <50b4b64d-7948-418b-9f3e-9d841fc426a3@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: a77a23f4c045a7a67a9
X-MBO-RS-META: cnzc14fysmehxmxbtp16dpdx4p7htn9t
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

On Thu, 2026-09-24 at 12:08 +0200, Marco Pagani wrote:
>=20
>=20
> On 25/06/2026 12:49, Philipp Stanner wrote:
> > sched_main.c still contains the spsc queue header, which is not needed
> > anymore in that file.
> >=20
> > Remove the surplus header import.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Marco Pagani <marco.pagani@linux.dev>

Thx Marco. Pushed it now

P.
