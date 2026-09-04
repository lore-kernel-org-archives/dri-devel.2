Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA266C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA0510FA18;
	Fri,  4 Sep 2026 09:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BrXcC9Rz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FF910FA18
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:57:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0D7160A74;
 Fri,  4 Sep 2026 09:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D2F1F00A3D;
 Fri,  4 Sep 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788515867;
 bh=/15UFxxirqrO6Bz4pIRkXUatQQguIa781LW8rPq7u7k=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=BrXcC9RzxRJ6NySORcZpN3sm3JkaldhaXPz+gnhZPMY1EadAYOkbv4Nh5Rpok4xMz
 jLBZqo3QXsnSPvLzrXQKY1lru15mUz64nWx8UpmzTZazPuNYvX6gj+3UchvxheCpgM
 TN00/LFSCsjOOJhFKBbSg0v7k4F4RQCiRRudG8ZSFo6wwe+TI7Ke0ptJ89XOYElo9Z
 MAsOxGQAco306BHkGjpdFKPw7xYp595gjA0o/3xytpx4/qOw2hgjndho2ZTTz9F0xM
 K2QBq067hYHrOEbggHjG6zJ7whSRFEImLMpJ4UZr6/zZPljZNHbYhmB2GaFs1rPIg2
 s9AyF43jcFZ1Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 11:57:44 +0200
Message-Id: <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Cc: <phasta@kernel.org>, <christian.koenig@amd.com>, <tursulin@ursulin.net>,
 <matthew.brost@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <mdaenzer@redhat.com>,
 <alessio.belle@imgtec.com>, <luigi.santivetti@imgtec.com>,
 <stable@vger.kernel.org>
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
In-Reply-To: <20260904080618.2098450-2-malhyuk97@gmail.com>
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

On Fri Sep 4, 2026 at 10:06 AM CEST, Jonghyuk Kim(MalHyuk) wrote:
> Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the=
 rules")
> Cc: stable@vger.kernel.org # we don't know since when

How is that? If there's a Fixes: tag it expresses that this commit introduc=
ed
the bug, so it should be known exactly since when it is present.

However, I don't think this is the correct Fixes: tag, the bug was present
before. I think it was present all the way back to commit f556cb0caeec
("drm/amd: add scheduler fence implementation (v2)").

It is also not the case that it wasn't a bug before we had per-context
schedulers, it's just that it became much more likely to trigger with
per-context schedulers; nothing prevents the kernel from having a reference
count of a DMA fence after the driver was unbound and hence the
per-device/per-ring scheduler was torn down.

More in general, putting "we don't know since when" for the stable folks is
rough. If neither the author of the patch nor the maintainers of the subsys=
tem
can figure it out, how are the stable folks supposed to?
