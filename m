Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F586C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 15:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE3B89349;
	Sun, 13 Sep 2026 15:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YN0MKBiN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38D089349
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDAB743F7C;
 Sun, 13 Sep 2026 15:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD701F000FF;
 Sun, 13 Sep 2026 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789314491;
 bh=CAGATFrGjpOdjdzUWpav8LQXEkXQtN7HhfR1h1EQFfQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YN0MKBiN+C7HzmSBLfKYjsR26sJjS8t4zc4Bu3LioLMPeP5xNJknXDpllqCIT/5bl
 keReoClozwAGEAr6PDecz6gZCSv5JU9kFYSNKpfVK51MciopDToVO/0jsZD34ovmtF
 cg/VZuqQUPIFN9MWwPx9NqoxO9QiBPq6xhXOU0xwqIY/+GSE9dAM11fa1dt4Mqvw+w
 8OfIx9TECTA4vSIqfyXxeQjsE+XSOmmQcVM3O4ILGlHdhMZz505XRNeaRZwiAMVIp+
 /D6MKxdmESSARpbccb5HpRi9J2ljsmtDftlS409MK+SdQXkz6b2LcVXDbvwN54LunY
 MU+R+qrmBia4A==
Date: Sun, 13 Sep 2026 05:48:10 -1000
Message-ID: <9d772dcc9c7331c239c8cb513331b399@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <nat@pixelcluster.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: Fix eviction helper reference in
 dmem_cgroup_try_charge()
In-Reply-To: <20260911220833.6958-1-kmehltretter@gmail.com>
References: <20260911220833.6958-1-kmehltretter@gmail.com>
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

Applied to cgroup/for-7.4 with the comment rewrapped.

Thanks.
-- 
tejun
