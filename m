Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D184BCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 17:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F6610E1D9;
	Tue,  6 Oct 2026 17:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Z1iOvX0H";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E4A10E3A7
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 17:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791308135; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JWnU8+DVJH77L5jPMmnJq4YyBE3IvPCdC+wh+Lgp5Mb4BhiurOs6t5KagrkdEnbvkscz5d4FMXUAQ76Awca0PS8a+2j18cvNlwzePkbS/R+zkhwElZi/UsmW8DrSe5c+0m2V09nI0IvlwGYl6fIU+OFqjmbQfEaLp3yz3fJ0JcM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791308135;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uzlERgS6IKg3Aub4ATZ5A96E6H2wTIZyNgWca8i48qM=; 
 b=kNGiNUc2NMSJ5ishQoLeMIIl2wxruxt6EacretbJl6DT054xHpBhpv7LdLSdPjmE22hwepqmkYPHvXU1YBYr5owm/zu6avTI0p+sVVxxv1b6PW8vN3Y9r8Ua/HrfjzXMon7XWgo+B5Eif3GwwEzdF5/CWO+b1dpph4idqivulnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791308135; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=uzlERgS6IKg3Aub4ATZ5A96E6H2wTIZyNgWca8i48qM=;
 b=Z1iOvX0Hc0pAhuuy375LHNupuHw0eGfOCAhkNajU9gDasB+m4JG+Mg+Mo9vldzl9
 pvZSnwDTPGErBo6FQhC+axmN5RP86a7rtPg3Sik+kYehgq/bkC+DFzgVR7sqcQZ/1Dl
 ZqArxAsOMhWmhTldyq9iSnVsJQ1AaP+kEpZ+fyLA=
Received: by smtp.zohomail.com with SMTPS id 1791308134410525.0055785860591;
 Tue, 6 Oct 2026 10:35:34 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <37422c77-ecdc-46a0-8896-3a5098417426@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <20261005103855.655f8199@fedora-61.home>
 <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
 <20261005173741.445715f0@fedora-61.home>
 <37422c77-ecdc-46a0-8896-3a5098417426@arm.com>
Date: Tue, 06 Oct 2026 18:35:29 +0100
Message-Id: <179130812939.1018806.2045583346110052897.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=R+WWnBcb7MjTrh3nR3mkd4Ia2jxPFj/JyJhqyre0svI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxTFh4ZC2cviUaNdI/hTgsK0SyulhC9u0cD9om
 xOikBXnXtaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUxYQAKCRAOJn5M7lND
 PQoVC/94ShhpXjcf5gRnUev/o1FvkpfXpV9/Hvoidq6K/gonmmu3QSucxmiuVdpuryj2Iq2dYYl
 J5q5w6gb0vJIBejnZaohQyiliMTDS528EPLNklrrGzogyiuXjDPvKZ7Kfoo+NyEsptR2rBi1vIo
 U2ytKyfAOjVDO7X37819qVVi7GrDWH84+kf8pbF6Az0tzn0E1e/lBfXFnJiDbaomzR2bPnF0Bu1
 60Lu5PDvBJEcwaoAHy6Pn+JmibbMqMzd4oWPUoIFoFx5Wfyko+5Nb0NfcxHu50EDymBkj1s30FO
 axy7P4Euj301ngXuETpwV3372uARirNRNUNCHg5raDq+wBqFiM7um34+EcQx9gyfFkAR5rTw4M3
 WeuCH7bi7HnI/yH8UnSYeNTCJ3tszTHfjIGvb9t7tpjo4xdlftQ71PjQSoZ6rErL2Bk4uFCnli7
 ZbXbWwnzkr4THmqugK1htUoFUVYZKoVC3Q6DICH4Tn9WW3ERngpQVZEU7C+AKSyY5NUrs=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-10-05 17:05:14+01:00, Steven Price wrote:
> On 05/10/2026 16:37, Boris Brezillon wrote:
> 
> > On Mon, 5 Oct 2026 16:06:02 +0100
> > Steven Price <steven.price@arm.com> wrote:
> > 
> > 
> > Hm, I'd say it's actually impossible because every unmap operation is
> > followed by a flush+inval of the GPU L2 and LSC, so for this stale
> > clean line to exist on the GPU side when a physical page is GPU-mapped
> > again, it would take a bug in the unmap logic or in the MMU HW, I
> > think. Am I missing something?
> 
> Ah, yes that's true :) Although there's no need for us to do an
> invalidate on the unmap path...

Does that mean the panfrost_mmu_flush_range() we do at the end of panfrost_mmu_unmap()
is unnecessary? Is it because, as you said in a previous message, cache lines for
BOs referenced in a CS are always invalidates before anything else is executed?

If we keep the invalidate at the end of the mmu path, then there would be no need
to mention that all counters being enabled is the ultimate reason why no initial
flush/invalidate is needed in the perfcnt enable path.

> >>
> > 
> > I suppose speculation pre-populating the caches with stale data would be
> > covered by the flush+inval we do after a map operation (this is
> > currently done in the unlock path regardless of the VM op, so both map
> > and unmap get it). I don't know, maybe the goal is to relax the flushing
> > policy around VM modifications in the future, but if things stay as
> > they are now, we can assume that a fresh BO being GPU-mapped guarantees
> > that no cacheline points to it until the first GPU access. But maybe
> > I'm missing something else...
> 
> I have to admit I'm coming from experience on CPUs - there speculation
> means a CPU can load a cache line at basically any point. So the
> argument that a line cannot be in a cache almost never holds. GPUs (at
> least Mali GPUs) haven't quite got to the stage of CPUs.
> 
> Thanks,
> Steve


