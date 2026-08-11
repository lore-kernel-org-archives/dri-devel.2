Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BBAC5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F3910EAB9;
	Tue, 11 Aug 2026 07:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OaG5ZbyE";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C281510EAB9;
 Tue, 11 Aug 2026 07:29:21 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hK3Cg1SVnzMlLV;
 Tue, 11 Aug 2026 09:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786433359; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4uurmhz/gFAz1ktMFv7oDxYCBjoixUMjupFd8mXcfI=;
 b=OaG5ZbyEMmKJ5TslKKTdyPfdrtGU3ej55jlxU9KMdwtTedMKGge4GLt4KkAKziv633cdtd
 NLVkrV6T7A/93q/+n3NsrgbGgDf/ntD3/P579Qb0j5FnIx+S9rFknCKt4WE7Fl4SuLtoLq
 nbJOmW7CbF/c3hbLN0P+52quJ2rInCCCQV3JcIYiwr471QV4cvGV5QX1tkgX1iUQYZqz8e
 eWrfAzU8/09zrVW9mnD1iDfUNUs9Ya7cLSuCmSRbFSUJ9hUAcZP6PBGixJI8dOnvTqeLKX
 cz8nGfZSirSZeIl8/VtNWWTxqjV3pBz4RT5ZgH1o6ErQUAc7ojN66iKxSROhrQ==
Message-ID: <e343b5fb2034b56af9049df970b987b239aacde7.camel@mailbox.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
From: Philipp Stanner <phasta@mailbox.org>
To: Luke.Wildhardt@proton.me, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, phasta@kernel.org, 
 "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "ckoenig.leichtzumerken@gmail.com"
 <ckoenig.leichtzumerken@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 11 Aug 2026 09:29:13 +0200
In-Reply-To: <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: qawuyb5ic8ztzk5pkjzpf8tjmyq5dqcg
X-MBO-RS-ID: e8842c3fbe0a84fa24a
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

On Mon, 2026-08-10 at 16:40 +0000, Luke.Wildhardt@proton.me wrote:
> Oops, forgot to reply all in my last message.
>=20
> I did a quick test of the patch before I left this morning, the
> freezing seems to gone, but when the GPU is under the same condition,
> the stuttering is more uniform if that makes sense. Granted this was
> only a 5 minute test but the freeze was rather reliable before, I can
> do more testing later.

That, unfortunately, indeed sounds as if we should go for the revert
ASAP.

>=20
> I know these things can be hard to describe, if that helps. If
> there's any profiling I could do or detailed logging that would help
> don't hesitate to ask.
>=20

Would a screencast / filmed screen be helpful? IIRC Steam also has some
fps counter etc in a submenu somewhere?


In any case, if we want to go for the CFS rework in another respin, I
suppose that it would be cool if @Tvrtko and you stay in contact


Thank you very much for the report!
Philipp

