Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35AACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 16:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C508710E13E;
	Tue,  6 Oct 2026 16:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="arwN/oC+";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC29B10E13E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 16:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791305125; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c2TC4PTqZRH323aHI0dILtKzGqO85wRWEiI8lkK3pP18nPVFk/mdOn1yiKvAU5YwQBgaiUW00bbf6mPp35mxGMHLavMaAYCSpanMwVHz35UD15RG2xyVleKvtflGsNsEluMiU69pUnGRcUw1hQW1RCm7goYfrZYnAlmIXm+i6YY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791305125;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=l2zvtehZljeKvFWWgwouDexzIcgFx4N1aUEmLfSWmKI=; 
 b=ayvTMeyf68nYVT/YQHOn/ndd4A425vahnWiKBettw5HeWDPSgUn1Oiu+0nIQN01R3M2CKmWsDgOpw3xx6N/y3dq8/6q7MRlORn1QQi827Pr5mf+Sxa5liFMTnDb41V41kwTrNFAfO9IZT5EhsoNMbiPaNLVWv87G6txzBZXJjs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791305125; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=l2zvtehZljeKvFWWgwouDexzIcgFx4N1aUEmLfSWmKI=;
 b=arwN/oC+UzNN+yr7pnPYYaytEg2sNHRtlGBTW8yWuB4kke2CQeF20QaRQWeaksZq
 42RIrVvw6fzLzEV7k3kkrftgSZExTgsdtiv1hLkzo0d+6FHOlwOh/wtTeZhkN6+2Eak
 2IAjYDaD/f7yl7SVt9rG/rS9szm6v2wtUJUALLIU=
Received: by smtp.zohomail.com with SMTPS id 1791305124824693.0308961866801;
 Tue, 6 Oct 2026 09:45:24 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
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
In-Reply-To: <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
Date: Tue, 06 Oct 2026 17:45:19 +0100
Message-Id: <179130511905.1018806.3717655233851799587.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Yns9KY08bSgPGCUVI3bZ4Lr0smenU/gzuYmrSov/zf0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxSWfd2mmenSoSaECoG2tgSFSTNRtwF2PHrVwn
 DGkLRHFqhmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUlnwAKCRAOJn5M7lND
 PdIEC/9ajqyvZeVMQj8DPD9wjIgwf0/cM+AFNwWR197XHiCbZszIxfkJS6eFq/NoeNCZJgBasBt
 9fFk6bFT2ImGVhefcZVLrdrqHOPWjGcgR6dfGbaWmv8yidyt39TbPUByIPl87RGqzAa66rpZN1H
 ucnMvKpF7gZRJzq4RALrQG0BYRAIYfXjfW/xu17+clps5jkKEzUvd0amX8LrPWOA/4eiqyp08eV
 WtCG7C+zUxWI4Efm3zCKLpRdKYxOInYTuwhL1xPGb/EZ3/utfEFyQJNf/1QDKgk6XaJ+CFPlqzy
 Yqm1Pq2nlNvpG1EQizCAF4Rs43rs8UCyQNy17o5+93Kmx1fS4a3mbiEawG9OED4oyXSpHsTuTUx
 2OAYegvF7IMNaWR1RTY3WDTmz2bdWqOZBcyB+2ppdu4N3O7yWWO9H0VfDFqv52GP9jGFtmSoPR1
 VT1T20LkB9n91NfhFUKzJ4R/XzsbHy5/argdPM0LnrrDIdje0xSkssfKX+4GqrdmdjpEM=
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

On 2026-10-02 16:14:38+01:00, Steven Price wrote:
> On 29/09/2026 04:44, Adrián Larumbe wrote:
> 
> > The GPU cache flush/invalidate operation is unnecessary. First off, the
> > GPU doesn't read off the perfcnt sample buffer, only writes into it, so
> 
> I don't think this is entirely true. The GPU performance counter unit
> only writes the counters that are enabled, counters that share a cache
> line but are not enabled are not written by the performance counter
> unit, but if the L2 contains that cache line then the write can hit in
> the L2 and dirty the entire line including stale data where the
> unwritten cache line is.

From the perspective of UM, is it bad if offsets into the perfcnt buffer
that stand for counters they did not enable contain undefined values?

> The upshot is that if the CPU has cleared a block of memory which the
> GPU happens to have cached, then the "unused" counters may end up
> showing the old data before the CPU cleared it (if they share a cache
> line with an active counter).
> 
> I have to admit it's probably somewhat academic given that Panfrost
> doesn't expose the ability to control which counters are enabled...
> 
> Is there a good reason for this patch (i.e. have you seen a performance
> problem with doing the invalidate)? Otherwise I'd prefer we keep to the
> safe route rather than trying to over optimise cache maintenance.

Like Boris said in a later reply, it was mostly about simplifying error handling
in the perfcnt enable path. We saw this initial clean being done and thought it
wasn't necessary.

> Obviously in the fully coherent case the invalidate could be skipped (as
> in the next patch).
> 
> Thanks,
> Steve


