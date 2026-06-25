Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B36ACDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D613A10F14C;
	Thu, 25 Jun 2026 07:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kvR2dK2k";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04410F14C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:25:50 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gm9MH20n3z9tQr;
 Thu, 25 Jun 2026 09:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782372347; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQD35UO6Szx2rw0N2+oli/oEjPgYfVwfdvJ9X7POARs=;
 b=kvR2dK2kR1dyf5Tq8+qbQ76pCXcAPQg/vW3aGUr814ncITGW7RZEVrI1TXRAF+7hPogHHu
 FKFE/D8vmBW/yql8Aij69QlVwh41e7VpM3GilLj+yxK/5U7VAFIrzikZQ9gL+hTUfwxgpr
 yFmJfEeoA0y+3qlO8Mc9hMkK0kfgCU/BdINVJ0HQl7iOq0Yj65appxMXfl/Cirm2UTGMdh
 PFXnW2n0gPs0qt1f1K9iwUXu3VrQhkRYATOEC+BQkegbyO5F1kIYmfkh4JERMWgLI2wfNA
 iboDfIzVyIR5KxCW5OpC/7/lL/xBojMW1fZr8bFpyOW9KJFFocJ5q7shM0MMBA==
Message-ID: <c9d8f3a762601f352bd176d4ae5c7977edaeab11.camel@mailbox.org>
Subject: Re: dma_fence cleanup/rework
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org, 
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Date: Thu, 25 Jun 2026 09:25:43 +0200
In-Reply-To: <20260624122917.2483-1-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 6h4y7a4cen9tnptfx3f9ke37werybozk
X-MBO-RS-ID: 14a23481600515e0d57
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

On Wed, 2026-06-24 at 13:13 +0200, Christian K=C3=B6nig wrote:
> Then the last piece is dropping calling enable_signaling callback with th=
e
> dma_fence lock held. This makes it possible for backends to acquire locks
> which are semantically ordered outside of the dma_fence lock.
>=20
> This is necessary to allows using the dma_fence inline lock in more cases=
,
> previously backends used some common external lock for their dma_fences t=
o
> for example make it possible remove fences from linked lists.

Hi Christian,

thx for all this work! I will review around a bit during the next days.

For completeness, let me ask here:
Is there any relation, or any work in the pipe, which you would
consider a good solution for the race conditions described in these two
threads [1][2]?


Regards
P.


[1] https://lore.kernel.org/dri-devel/20260618-linux-drm_crtc_fix2-v1-1-c03=
e77b36f34@linaro.org/
[2] https://lore.kernel.org/dri-devel/fa0dc9757bf8343516c4b156a2b70ec91b64e=
f8f.camel@mailbox.org/
