Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB9BCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DD910F18F;
	Thu,  7 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="eE686EVL";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF6A10E00C;
 Thu,  7 May 2026 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=rf6dlxadgragpeknl2zvhwifqq.protonmail; t=1778156569; x=1778415769;
 bh=yXyy/1avikG//9PNJ0NYNRcQ/+6OhcdCpQSlhFY4bVQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=eE686EVLPG9E3IvxDNMtZPAUgQnZvjYhBtGeYCeLsfCNrwyUOwDYNTExiom1wb1Vv
 qxf5nbN2AYwB+PjB6b4dqbRmwRB6HO9ooY5fYpYBLWpa0Jrj4sc5E1DnxJYfqEFebE
 pjq0qImRlNPXZuB/Kjwt4l0RDL2eqGnBDNaN2Fa6Zw9J60dvsjbk8K/SC9kyx70guD
 zRaMFJ8yT4aNrsf/KcU9MiDUzcCrQfOd+3neh79Rt+4WHcxEvs/Xro0+zBG7mfowTX
 HKw6d77yk6g1BGDajPKTBLEZHfo54YyENhNsf1cmjFijEBhEN7yZf+DNbhP37d96Ie
 XL4adMF90c2LQ==
Date: Thu, 07 May 2026 12:22:42 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Aditya Garg <gargaditya08@proton.me>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net, paul@crapouillou.net,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/10] drm/appletbdrm: Allocate request/response buffers
 in begin_fb_access
Message-ID: <G66ElwoYASE3O3RpWWuKm9V5LNUTUtjJ_lGUsDxN3EujU3wsp3vpT-KcXMsrFfYEZkBwq9TNaD3Pc2g4oaueu4B-JXN3PTCoNGY999s5WHU=@proton.me>
In-Reply-To: <20260507075725.29738-6-tzimmermann@suse.de>
References: <20260507075725.29738-1-tzimmermann@suse.de>
 <20260507075725.29738-6-tzimmermann@suse.de>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 809317f98a9202275d5c4ae88ce01ca05792218d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 May 2026 14:49:02 +0000
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

On Thursday, May 7th, 2026 at 1:27 PM, Thomas Zimmermann <tzimmermann@suse.=
de> wrote:

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>=20
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Aditya Garg <gargaditya08@proton.me>
