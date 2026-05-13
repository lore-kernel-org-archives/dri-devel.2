Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B877ACD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3129310F05F;
	Wed, 13 May 2026 20:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MwsS+Xa0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF8F10F05F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:44:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F3817600AE;
 Wed, 13 May 2026 20:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C499C19425;
 Wed, 13 May 2026 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778705098;
 bh=hK59TklJ3r7JacXrdSpS9889H0qpgYzPE9M9TYuJ0n4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MwsS+Xa0ve7JCeRzGoYjxyFKLIECSSEzJfYMPQBm5oVeYiLGSXLTpVQnMIEhTfA7+
 1QS5UVfvr88oG9z8SeUtfZjA5O8CsyJIj8vK01ihh3oNcl0T1XZJDMCkIdtf9eqOIo
 4Oh4ftvn7W66wA2AEqIEZ2yP+oCcJuc/4gsSX64Js6zdr6JFdFIzWJi0iaK5dfALv5
 K2WV48WoE1xfrfv5BXkHgiqdFosoNQ51EtyRmDPfVNm3XSszy58YA4UYC2fH1cNZaC
 L3r7aAuRNntBvwJwjG4h2xgxaVJBL/IC6s2/mmRkSI0+Zs+cuJMu274jB1ZTsccuQ9
 3pJXIVyzoQXSg==
Date: Wed, 13 May 2026 10:44:57 -1000
Message-ID: <a4f68c0ea0accdcacc6cafe444ee786f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] cgroup/dmem: introduce a peak file
In-Reply-To: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
References: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
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

Hello,

The patch looks fine to me, but please flesh out the motivation in the
commit description - what's the use case, why do we want this?

Thanks.

--
tejun
