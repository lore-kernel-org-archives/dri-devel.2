Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B26CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 17:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4CC10E06C;
	Tue,  6 Oct 2026 17:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="O1hwaE5J";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BCB10E06C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 17:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791308577; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T9bl4cUIkS22dRQtrcTMJVNZLJuOn3qzuos94Z3aqx6XksT8amA5IsjhvkXVu4X6LSQ6w9H1fFk6CnP0Q0pkCe0HkMHrtk9kyFSw3s7JNJTr50pBzS6EYcyZvr+AaJAK6CfA5pz7r7YJ+LFYaikvvGwNVxsDKia1xHi37S2iGWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791308577;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KWPwI/TMLs4A5JfWID8+571hAk2AHT+uThGLpY/+9Nw=; 
 b=MxIY0MWky3ZCMEGkcWQXISoy84Y3ETfOJikZUyMpwTHU3MA4g/IMzuM+fbOwE7upXVEZDYSwUot8+8Uo8T6ARSCamgy+i6MeYfMiJACKXr/4pybwZrpLMeuRSS9pT0v+gHHD3hXxds2NcOl8Bqoz2UGjH5wNKsGl8Fn/p74JA+M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791308577; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=KWPwI/TMLs4A5JfWID8+571hAk2AHT+uThGLpY/+9Nw=;
 b=O1hwaE5JOdnYmV0IHkNvXmLy7FvvlXZ0wbM7DfNwFtcjzG0z5Qu8YDAM2Mqr0Xaz
 5vApJjPv8+GvOaAvT9u0wpRMg7+lUMrTxpz5729PZqC4QurlXOXEGJgtCqj14G6JFH2
 SHHPSmdfbY02p5qDHnVxqTADBzRMVi28QPhw8bjo=
Received: by smtp.zohomail.com with SMTPS id 1791308576085608.6983948946888;
 Tue, 6 Oct 2026 10:42:56 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, 
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
In-Reply-To: <20261005185738.010bc483@fedora-61.home>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <20261005103855.655f8199@fedora-61.home>
 <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
 <20261005173741.445715f0@fedora-61.home>
 <37422c77-ecdc-46a0-8896-3a5098417426@arm.com>
 <20261005185738.010bc483@fedora-61.home>
Date: Tue, 06 Oct 2026 18:42:50 +0100
Message-Id: <179130857041.1018806.6898929931051346034.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=752;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=bd+1P41IO15ibhKPcrrSHKh5od+yEGZluTc0dwCbu94=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxTMaQ/j2X9bykuJcr0RtX3bVvKBXqKcKdrI19
 o2vNc6P6IGJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUzGgAKCRAOJn5M7lND
 PZt/DACaTuYGeg1cxZ3bxDyA5nP1u7eiTOhBhKQ69eZ50mrN4Wkl4V4pR/j8ApsJGxHPMPRbRnJ
 6+ShlvIUwrvzCrrya08ZLGaww2P+3P7TtmvBx69CViMBuZgDbO+NyP9zdOHXUTBmJ05T0thqd6N
 yydxbHi/LArocbdY9O9NTJZHq+7Y+Gq9xhaxQXjs3iUKh3OCdbsWNTvl1WwLRGu11qOfw8LAgCF
 R7CG7/4L/7y6tekw/m756lemBhO10KdfUCB9zRZXvEK7vYiDUlG/zImMB+tFWCadSO6wkdiWyOp
 hi+WznGA9Tkzgtmlh0Pz9G4ZzGQ+9GxcKwn0RmzXXR77uP2Y65/u4QHLnNHvx0eciqXX09pzSNG
 Osmb4d++unvanDiR8EL40gCVGxuncbVncvY3bR9saAQ2O4YntaghG3APEG5DdrJ0uVRscHG78m8
 QyU0j3ftTCIuDgBJcOsCeM5FGd1PThCmvwBZHO6nBJtEm1W+8YSnELl74rPKjA9QuNTUo=
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

On 2026-10-05 18:57:38+02:00, Boris Brezillon wrote:
> On Mon, 5 Oct 2026 17:05:14 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
> > On 05/10/2026 16:37, Boris Brezillon wrote:
> > 
> > Ah, yes that's true :) Although there's no need for us to do an
> > invalidate on the unmap path...
> 
> My bad, I'm confusing Panfrost and Panthor here. There's indeed no L2
> flush+inval on unmap in Panfrost. We do have an L2 flush+inval on map
> (FLUSH_PT) that should cover this case though.

But we're doing panfrost_mmu_flush_range() both at the end of maps and unmaps,
so I wonder whether when you say we do L2 flush+inval on map, what you meant
was when submit a new job, we force a flush+invalidate for the AS the job
runs against.
