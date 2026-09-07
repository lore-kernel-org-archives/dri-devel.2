Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A02AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E483E10E38E;
	Mon,  7 Sep 2026 09:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AWrOaH0N";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4E910E38E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:50:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hdj3c6FnFzMlG6;
 Mon, 07 Sep 2026 11:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788774604; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mN5wtl5wK1pD+jSdgzCx9eyQ3AaSJqVlV4B1zGffWK8=;
 b=AWrOaH0N4MENJC3X3K7wXV/Q/nLJgHXZU80S67C/QaANI1QxLNe005cPGSfB0ALKwe2FCg
 F1cfhG1EkZIboyEnIPMuyJrVO2UJ/14EDZXqonopmsZax6YsCmtH1Hl92Z9a4rl9ipcw1Q
 P/W/NTrWh3cdjSH26ooKZRXU8xXJq3VMNWnaGkwn808EYvKSmXwK993QgRFPKSN2g7KA5B
 jXd75AAjmFeN5iB93XL3KKTeZCxLXAYfevXdZmUWsRHldT7ReeK3gAzalfAbJAzDz3t24s
 vCEfbayZdpV+V2Ye8e9lo8NScwal57W2WmmzMT5dnCMEOk3qoxl6+edznXJpHA==
Message-ID: <b36f5adfd5f6243d79e321e99b29b932a270f551.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, "Jonghyuk
 Kim(MalHyuk)" <malhyuk97@gmail.com>, 	matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Mon, 07 Sep 2026 11:49:56 +0200
In-Reply-To: <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 6938f1eef1a9cc0b4cf
X-MBO-RS-META: nayt3edutsba5jya4n7cejqtwjwa8ywu
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

On Mon, 2026-09-07 at 11:42 +0200, Philipp Stanner wrote:
> Moreover, even if we did remove ops->release in drm_sched, it would
> still be a race: a driver's contract is the hardware_fence, the rule
> being that you have to signal those. So after signaling the last
> hardware_fence, you could actually start releasing resources, but it
> might be that finished_fences are still in-flight and are unsignaled.
>=20
> So we have some sort of fence -> fence race here, too.

Forget about that, signaling the hw_fence should always result in
undelayed signaling of the finished-fence.

So it would seem that making the signaled-state instead of ops =3D=3D NULL
the decoupling point in dma_fence is the solution to go for?


P.
