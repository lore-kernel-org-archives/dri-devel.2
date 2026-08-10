Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF14C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCBB10E80B;
	Mon, 10 Aug 2026 12:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TuPq1NID";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D3089811;
 Mon, 10 Aug 2026 12:45:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 981FB600DA;
 Mon, 10 Aug 2026 12:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556261F00A3D;
 Mon, 10 Aug 2026 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786365924;
 bh=4K2C7DhbJOJxmf8+UuSZg6NFnK7PTCnLVHe4kYu+6Zw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=TuPq1NIDM0pLQYZyikjmMRc68yoxpEgRFj7gmpdP8TIYNF7LpdYSIEySNU6fPL0G5
 4dSoeNoQLuM7Z6zepMectNNYWu1E2/l4wAuZZa5CmSrlSAu+kGVRK52Iz5NlTDXQ3H
 pKRTJcpQ/5iZ72WVUHJCl++lTfo73s7ZchZV4iQ4rpg72kMTYMdZi6U2QH7Vcii3zV
 /tdDZD7X1AiFT8jImaqUN41ahlgBQYeMgt2OnRYHFrgdc5fC8KHWauHZQB+lcUMRip
 WsifvbWv1j45wXOb/Hz0QNA9IRWmQPR3Cv2F8QhdxB9oRv0ifRE8q9vh64g0j4GOfc
 uvF1UgUH1HfGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 14:45:20 +0200
Message-Id: <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
Cc: <phasta@kernel.org>, <Luke.Wildhardt@proton.me>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
In-Reply-To: <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
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

On Mon Aug 10, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
>> Reverted Commits:
>>=20
>> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
>> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
>> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
>> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run =
queue
>> 45c211ddf92a drm/sched: Switch default policy to fair
>> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage

[...]

> That might be the wisest thing to do; but let's hear if Tvrtko has an ide=
a for
> a hotfix first.

-rc7 was released yesterday; even with a working hotfix today it'd be trick=
y to
ensure the hotfix does not regress other drivers or workloads with 7.2 bein=
g
just a few days ahead.

I suggest to not wait and get the reverts ready.

Thanks,
Danilo
