Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EDAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0681310E809;
	Mon, 29 Jun 2026 10:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jK/op6iK";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7DE10E80F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:16:10 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gphxz4gTyz9v8L;
 Mon, 29 Jun 2026 12:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782728167; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HW+BWg1JW9BNHOp4E3b5w+CbOMquiIMjz4qFrzocohs=;
 b=jK/op6iKOf1vTXFwaDd/0zgNygsmmHaCv3tMcFv5+iH3+DDblF/MSPxD75wLznpekMTSWv
 Lkph52uqTDvIzBN7QoROOJsWOa0bM2mNUwancglKHe4kvMs0AMBGipFw3WO6SCQ4XpP1Oz
 J6FRq/PVuGdEDCt4R9MR8AQkulWZpqkuSFiMRTHCT1U7ndySQz0gR/Ab1/yWTGuZqBZhE+
 GlMM+rDgzf9LYeGob4ZWgqvdZDb/lwmMjjuT4UhPPlaAsFYN6Iz95DnUcFhHtT63qhytxT
 J5F12TJTLxeXcYfkQ3TOF4iqZWES9oywB7+vht13SmcJYV49gsGwE43V0jqEYg==
Message-ID: <9bd4bd923eacca9da25b6b9fda33057455d084c3.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Baineng Shou <shoubaineng@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Akash Goel <akash.goel@arm.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Mon, 29 Jun 2026 12:16:02 +0200
In-Reply-To: <349ada65-c788-4c5e-9992-0278cf1382dd@amd.com>
References: <20260629031346.3875683-1-shoubaineng@gmail.com>
 <becd29b5-9e40-4104-b6c9-3d91e2ddddff@amd.com>
 <058f4bb261e408cf17deca9ff7354460675eacbf.camel@mailbox.org>
 <66344c20-ea97-4dfa-ac42-c9d6e061eb95@amd.com>
 <7dc78d8ae9903c215ec492ee39b27cc504da8307.camel@mailbox.org>
 <349ada65-c788-4c5e-9992-0278cf1382dd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: a61e13d958b385de307
X-MBO-RS-META: zr99d7yz1wiidqwq7p49y3w987uhfuxh
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

On Mon, 2026-06-29 at 11:52 +0200, Christian K=C3=B6nig wrote:
> On 6/29/26 11:06, Philipp Stanner wrote:
> > On Mon, 2026-06-29 at 10:52 +0200, Christian K=C3=B6nig wrote:
> > > On 6/29/26 10:49, Philipp Stanner wrote:
> > > > >=20
> > > > > I will add a CC stable before pushing to drm-misc-fixes.
> > > >=20
> > > > No offense intended or taken, but don't the DRM rules say that
> > > > things
> > > > do not get merged while there are outstanding concerns or
> > > > significant
> > > > points in review feedback?
> > >=20
> > > I haven't seen that before writing the response.
> > >=20
> > > I usually go over my mails till the end and wait a couple of
> > > hours before pushing anything.
> > >=20
> > > > What about my comments?
> > >=20
> > > Looks valid to me as well, but I think that is a separate issue.
> >=20
> > But if we keep it an integer for now, and if that check is added,
> > and
> > it most certainly should also catch negative integers, shouldn't
> > it?
>=20
> Maybe with a WARN_ON(), but not as regular code path.
>=20
> The thing is I think we need to backport this fix to stable kernels,
> but switching from signed to unsigned is only a minor cleanup when no
> real users are currently affected.

Fine by me.

P.
