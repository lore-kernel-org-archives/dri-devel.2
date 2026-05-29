Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B4CCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A2311235F;
	Fri, 29 May 2026 17:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="FRABtc0o";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9C311235F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780077259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K8+z8JVIxolwKD4s8wOJ3FaqO7j1z0hC/EI3wUDR/lo0rPshLi6H4TkjF+Sk663aPhtzsuqx211ujwWswu84UC6zoHps5uMQ94wChjkOA9qRd6WrMQABz1kIh2rbsxllXcdvl6GGTINMOCCKO0jtMaB9jgadzDe3LOkmKifMhoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780077259;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vwPjQ1r+rv+5d+L1+VEMg3LAc/c3JcPD6v55V+dvItA=; 
 b=VrFlhgGtT+ynXVYKTC8ApZ40UFE9M3YKyQnLUYKhXmxVMchZuykaYYt70skfUW2CghO7K8AtUwaTubmxynhhUWkrdscZ7wThbAuelSlaJmNVW0sAYLMbTOzhuTO2L2pqeDCxsxUxtt9F7ZUhFlIFhg7+orZOesSt3bSAqO/01a0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780077258; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=vwPjQ1r+rv+5d+L1+VEMg3LAc/c3JcPD6v55V+dvItA=;
 b=FRABtc0owDRhKdZQf93EjUkTdo6bOM7+EXjo/CooBPk65x1yf9yVWqGP3+j9Cfd9
 HYqabeJcnEQ6LaddVtEc8iHBc3BgmL73SsC8XjytqkUVRjO1FN8WdK2mu5JKZv1Stdj
 2BxnzlyQeKx3mK/171vX3l1IUcwV4qh8qkMhLvW4=
Received: by mx.zohomail.com with SMTPS id 1780077255691921.9879854061624;
 Fri, 29 May 2026 10:54:15 -0700 (PDT)
Date: Fri, 29 May 2026 18:54:10 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v5 02/11] drm/gpuvm: Remove dead code
Message-ID: <ahnScgEvJw8SDInr@sobremesa>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-3-adrian.larumbe@collabora.com>
 <DHD232A6MYDI.1SZ5JL6UWA6SU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DHD232A6MYDI.1SZ5JL6UWA6SU@kernel.org>
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

My apologies, it seems I completely missed this message and already sent a
separate patch series removing the same dead code but not drm_gpuva_find_prev().
I'll do it in a v2.

On 26.03.2026 23:10, Danilo Krummrich wrote:
> On Fri Mar 13, 2026 at 4:09 PM CET, Adrián Larumbe wrote:
> >  struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start);
> > -struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);
> 
> drm_gpuva_find_prev() seems to be unused too.

Adrian Larumbe
