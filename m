Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594A606A321
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=iVCr79NK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D498A10F4D3;
	Tue, 27 Oct 2026 13:18:29 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C22C10F4D3;
 Tue, 27 Oct 2026 13:18:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jDWJr2jMBzKpLX;
 Tue, 27 Oct 2026 14:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793107100; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWeOBryevCm8q/A7sxlX/iP0oFz7HX9qKQxKArV12Iw=;
 b=iVCr79NK6XGQ6EgNpNOD2bIXbXL4I31nNsALqsgJRAan4PCZUas/ziri01k+UiVvLsQycr
 jEGy6QljBosVW5Jqu3A3FRH9PvEPpuR1SGd/VF9yKM8tiw3qKMJDMTnIN61hfHzO9OAalg
 +R4lzNj7N3ZHiyQkid3xUbPsvyYN6df7DO+vf2+mhbILym7f7VNh7w6qtP3E8pLywHmgky
 PNA+zG+e/z3TjI0CHMJMq+oEv4xqQ4um8e04VeTmBtozNA74R3z1gtrHt5WAgK+sTPgwlY
 jVLHV3f1canVotp7+7KSY9bxJDhgRLuFMtxsVimGTIwXsp7syZC2oZLllN1x6w==
Message-ID: <fd9cc070b3a4e28316ad2ffce942227e33974016.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: Harden against potential deadlock
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Philipp Stanner <phasta@kernel.org>,
 Alex Deucher	 <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Tue, 27 Oct 2026 14:18:16 +0100
In-Reply-To: <1ed5c075-c66a-4144-b23b-a9d80e1fc2c1@amd.com>
References: <20261026141541.469727-2-phasta@kernel.org>
 <bcd63af3-d2ce-488c-ab96-2b11536cd50c@amd.com>
 <1ed5c075-c66a-4144-b23b-a9d80e1fc2c1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: buiiipye989ra698z48roho9cbycqgfu
X-MBO-RS-ID: 7b35dd1fa6a48d1be36
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-27 at 12:51 +0100, Christian K=C3=B6nig wrote:
> On 10/26/26 19:31, Felix Kuehling wrote:
> > We don't implement ops->signaled, and we explicitly signal the
> > fence from SW with dma_fence_signal or dma_fence_check_and_signal.
> > So the signaled flag should be the only thing that needs to be
> > checked. The flag is only set while holding the fence lock, and
> > checked while holding the fence lock. So in theory, relying on the
> > check in __dma_fence_enable_signaling should be safe.
>=20
> I actually had a patch to remove that one send out month ago already,
> it was just never merged.
>=20
> The call absolutely doesn't make sense since the ops->signaled
> callback isn't implemented and the bit tested before the enable
> signaling callback called.
>=20
> I can take care and push the removal to amd-staging-drm-next when I
> find time.


OK, but put me on Cc please. I could need that change for my other
dma_fence-ish work. I would post the removal as a v2, too, if I don't
hear from you mid-term

Greetings,
Philipp
