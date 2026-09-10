Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E60C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2AC10F38B;
	Thu, 10 Sep 2026 08:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uFNhIYU2";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C3410F38B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:52:03 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hgWdC6J6jzMlGp;
 Thu, 10 Sep 2026 10:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789030319; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FX2cFaHch8amRDc3UqW68hr3WD9WI3VSFQDVtgOwqrM=;
 b=uFNhIYU2YFabjGfb7xmKDdNA+ZXXGo15RPXKgtUUi9z3CWkc2Dn/+Zw703YGib3ZiMQ3C7
 dYZXU4RnTr0ZcGbhFd5L0oztN1QMr0yl+fOyootHI+cQDGs6iEIlOjrDVsL/U5bjf6StNJ
 4A8scFYcEFIKF6uqsclb3m2621EmNJJ8eKiA5HPrsaqbpWd9doDKW+pXD1aVBGoJ7UPnlr
 Bvt6E3gP0iwaLVIVHATjknv9ng0TLOJ/uCnH+gP1/NsH7soos/6FasI/dmMTHnkjEGPIUZ
 YKTxAUuKAIO9mNIsi4Sb9tjmNxKH85c5GImfNOXI7NFk7dXXdCFqywTV37WErQ==
Message-ID: <608f03824420323f9c9d3bc29cfeb0bed714074e.camel@mailbox.org>
Subject: Re: drm/sched: run queues freed before the TDR that
 drm_sched_fini() waits for
From: Philipp Stanner <phasta@mailbox.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, phasta@kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Luben Tuikov	
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:51:55 +0200
In-Reply-To: <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
 <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: jxeqag5trg4hyy7kc7891ys68f6a66x5
X-MBO-RS-ID: e605a9458ce16b4baf2
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

On Thu, 2026-09-10 at 17:44 +0900, Donggeun Yoo wrote:
> On 9/10/26 09:32, Christian K=C3=B6nig wrote:
>=20
> work_tdr is queued on sched->timeout_wq and is only canceled by the
> cancel_delayed_work_sync() below the loop, so a timeout handler can still
> be running while the run queues are freed.

It is not as obvious to me as it is to you why you think that the
timeout handler is exploding.

> On how I got there: the KUnit case never signals the hardware fence, whic=
h

Which KUnit test case exactly?

I kindly asked you to provide more details about how and where the bug
occurs. Can you post a longer stacktrace and also run
scrips/decode_stacktrace.sh on it?

> is what keeps the handler inside timedout_job() while drm_sched_fini() ru=
ns.
> That breaks the rule that all run_job() fences are signaled before
> drm_sched_fini(), so a correct driver should not reach this, and I have n=
o
> reproducer that does not cheat that way. The same caveat is in the patch.

If the bug only exists because someone does not signal all hardware-
fences (that's what we call the ones returned from run_job()), then I
tend to think that this is not a scheduler bug.

Maybe a kunit test bug that should be fixed.

Though for robustness reasons we _could_ nevertheless stop the timeout
work item before releasing other resources. But that's just a best-
effort nice-to-have change, since the change making a difference would
mean that there are life time violations with ordering issues anyways.


P.
