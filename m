Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1130CCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3D410E760;
	Mon, 22 Jun 2026 15:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ToA3PaPb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7111810E760;
 Mon, 22 Jun 2026 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PQvYmdv7l/ESIGmByUEb2vrNIzMYdcuiCUtVuj30ZX4=; b=ToA3PaPbYJbNs2g90uuncz9Dw4
 2ZbWq0EWGQzrURDbsgz57RWBkFx6e0lQQPO+i6jdclcsL/GRhethVLN7qLtrb+E9/u27a9da9OOxB
 0Xtm+MER55DGbLpaUk1Ly+TnBsSVdpcCVcsw78CJWNb1wWWKYbqec6dtnqvMl59VkJ9oB5PYCKk00
 bY/EpdRn1lzhZQsR5F1iYDRFsxLL1VoNQ51Msn9wuZRw7ZvvoFsjJR9GpK8c3bg3l2ZN3XG9OAh+u
 bMRnJvfy5qykiZw/5DpKixYTPdUGNu1BHMCykDnrDpI7W4WoTXOhOOm9fTx58PvxteyhmtjtCGE7/
 r2L1xIeA==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbgYB-003nTK-5L; Mon, 22 Jun 2026 17:27:03 +0200
Date: Mon, 22 Jun 2026 12:26:54 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
 <ajBLAsNoKesXmFcs@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBLAsNoKesXmFcs@slm.duckdns.org>
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

On Mon, Jun 15, 2026 at 08:57:06AM -1000, Tejun Heo wrote:
> On Mon, Jun 15, 2026 at 08:49:55AM -1000, Tejun Heo wrote:
> > The canonical behavior for cgroup2 would be not failing the write at all
> > even when the usage can't be brought down below the new max. Updating the
> > target configuration and tracking the current usage are separate operations.
> > The former should just set max and trigger reclaim and a writer should not
> > assume that a successful write indicates that the usage is below the written
> > max value.
> 
> Sent too early. One of the reasons is that cgroup is hierarchical and there
> can be multiple delegation layers and if you tie application of configuration
> to immediate enforcement, some hierarchical control actions become racy and
> awkward.
> 
> Here's an example: Imagine a system agent trying to lower usage in a subtree
> which contains multiple delegated containers. If max can be set below what
> reclaim can achieve immediately, it can just set the max and if the usage is
> still too high, can go around and e.g. kill some of the containers. If max
> write fails, it'd have to kill and then try again and inbetween someone else
> might push up the usage.
> 
> Thanks.
> 
> -- 
> tejun

Hi, Tejun.

As far as I understood the patchset, it doesn't fail the write if it fails
to reclaim. It sets the new max, then, if the write is blocking, starts
reclaim and eventually returns after multiple attempts. But it still
returns success.

So I believe this is behaving as you would expect.

Regards.
Cascardo.
