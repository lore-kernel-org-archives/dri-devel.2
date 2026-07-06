Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9A4C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F2110E323;
	Mon,  6 Jul 2026 08:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tOK1VCgr";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD4210E323
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:56:11 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gtyrS2rVsz9sNr;
 Mon,  6 Jul 2026 10:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783328168; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrGsBRjAqFY8yVeMNP0cQIBfrYHPy8Ji6WY4Dwo7CcU=;
 b=tOK1VCgrbyl1aSx2dmfhECBpz6A6bQPFNRmJwdejShuDCEi1n6Gl981zZE2+o5h1qFBpNw
 mC0PIAwHgKnsyRzHsQ6pL7XhMDtVxr+r0qIAYyuWMM/MOfjRyGSHjRBcsFwKwfxLq7nSQ2
 QPnaxADcv4SCPEJn9grDRguFngFxyKm8979I8H8Y0L4RFUO9eSTknX+8mYnI1+kakh9Taq
 1MzFjyMnZBO3F1hBclhGT99hZP0qebszimDsn3LIHUTAwl099eFsMSthJ3+EwfxqMazZBo
 uVLWD28ut5d8F49DPn481XgEQyz/Y6VnPcaSr01tHJbEJf/dOWGg4Sng+hT73g==
Message-ID: <305e36f05f6094a8be907e6234c0cd49c88f199c.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove relic from entity docu
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: atthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 10:54:54 +0200
In-Reply-To: <7f78b024-d7a5-4b57-8828-79771689f9b7@kernel.org>
References: <20260629083631.2547199-2-phasta@kernel.org>
 <7f78b024-d7a5-4b57-8828-79771689f9b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 4onsbnz3incbuky34w8fsnskpx87fnpw
X-MBO-RS-ID: c721ef634fae3c145fc
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

On Mon, 2026-06-29 at 11:12 +0200, Danilo Krummrich wrote:
> On 6/29/26 10:36 AM, Philipp Stanner wrote:
> > commit 4827d6d83f07 ("drm/sched: Remove racy hack from
> > drm_sched_fini()") removed the necessity to mark an entity as stopped i=
n
> > drm_sched_fini(). The documentation, however, still details that.
> >=20
> > Update sched_entity's documentation.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Pushed to drm-misc-next.


P.
