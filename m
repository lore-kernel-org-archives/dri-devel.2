Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCDFC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF5210E537;
	Mon, 14 Sep 2026 09:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vVc7P9q7";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E32A10E651;
 Mon, 14 Sep 2026 09:37:32 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hk0Rr4XqmzKn9V;
 Mon, 14 Sep 2026 11:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789378648; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+9MH70WKjCvhfQjzDnccEGPpWHdgQX9VggZtRW1gCU=;
 b=vVc7P9q755gp/4U/gJIwsTiL0yb14ppcJy3JyoZuYrgTInpV4aYeD/x8T0CXvxsZSpaNLh
 ++Ue1mZ1ivQuxUb2rDEr55qLKpBW/uuH7nY0dWCgxWmY9SbLTxYxXJqutO73Ar3YegxN8v
 JmwOWF0eBQSzAFq9krF74J3qerR4tqZ+YI8J6GoPZByIfWs890U14wpdzPnKp4lAaJumzR
 k9WIL3fL1U4xKrR6FYL9sn5YKYHJ7M3EVZXS0nz1298hiahLkM5J/lWnVRGGHPXlQ7ES3p
 FfcEAMDncHoLcZXfcxQMGR7bUAadSkMkvaGpWNcJJz5n3EDA2sZ6Ca4Q5ehGWg==
Message-ID: <28a236dcae3e2cac75b4f5afc091136db04134e7.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, Vitaly Prosyak	 <vitaly.prosyak@amd.com>,
 stable@vger.kernel.org, Michel Daenzer	 <mdaenzer@redhat.com>
Date: Mon, 14 Sep 2026 11:37:19 +0200
In-Reply-To: <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
 <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
 <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 386b0864b5bf0618924
X-MBO-RS-META: n9irhpodoxuj7m7t6yfpe8tg5zciq3sd
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

+Cc Michel (for the sched policy removal plan)

On Mon, 2026-09-14 at 09:59 +0100, Tvrtko Ursulin wrote:
> On 11/09/2026 10:36, Philipp Stanner wrote:
> > Someone from RH might or might not work on that, and perhaps that would
> > take until 2027. I'm keeping an eye open for people to pick it up, but
> > everyone's always busy.
>=20
> Again, I am happy to work on that as long as it is clear there is no=20
> duplication of effort.

I asked and made sure no one is working on it, so from our POV you have
green light.

>=20
> > Regarding the bugfix, this was reported as a performance issue on high
> > load, that only seems to be reachable for CFS users, a brand-new policy
> > that is marked as experimental and is not used by anyone in production
> > yet. So IMO we can move on on drm-misc-next with spsc-queue, which will
> > also make CFS usable then.
>=20
> I think more logical order is to first fix it with a small backportable=
=20
> fix even if experimental. That way people using 7.2 can actually test it=
=20
> and contribute valuable feedback.

I took another look and I think my only issue is basically just that
the patch addresses something which we should have done regardless of
the bug at hands. So I'd be already happy if the commit just had a
different title and slightly extended commit message, like:

"drm/sched: Fix vruntime race by extending locking"

plus sth like

"this simultaneously serves as a preparational step to replace the
spsc_queue as a whole".

>=20
> > Is there a plan btw as to how you would like to proceed with CFS?
>=20
> So for me the most typical and useful plan, and in the context of the
> desired spsc removal, is:
>=20
> =C2=A0 - Merge this fix so it gets into 7.2
> =C2=A0 - Spsc removal RFC for some upcoming release N.
> =C2=A0 - Remove experimental status from fair policy for kernel release >=
=3D N.
> =C2=A0 - Switch fair to default at >=3D N+1.

Couldn't it be enabled first for dedicated users? AFAIK it was
developed with Steam's gaming platforms in mind. Can their OS devs be
asked to switch it on or test it downstream?

> =C2=A0 - Remove FIFO and RR and simplify to single embedded run queue at =
>=3D N+2.

