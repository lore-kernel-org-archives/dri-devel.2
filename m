Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF1606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCZheR5f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B96B10E96F;
	Thu,  5 Nov 2026 18:50:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7293B10E984
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:50:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDB79600B4;
 Thu,  5 Nov 2026 18:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328A1F000C1;
 Thu,  5 Nov 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793904647;
 bh=Xg2H2JbSaNt4G+nLKOWCl18uepzGTAp2Ue28h4Ezewo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=OCZheR5fEydX8GegsAf/Wbjwxh7nD5KwrEXxHD5+kCz5Yl+2GkPBZu0dVuFBo2nE2
 IcMR6lD9OBPQSXDK5pcjJ3uTgSZPX/c8e/ndzssJ8LYFCfA6Up5BEYfjJy3gvuJGQd
 XeKP6+UFUzxddE7yBtMLpllJnCpY3XPxS1OoRuRmjRHs/VGDcAMxn3SzqVVXBimQjm
 d05sBvebvdD2szbftzMY79fCdv8dJSMtDKvIxF0fKVJS2VM43RPCLiG7zkIcRak6Ye
 7PatMhG/ma1hHL/rZQYY36Zkf4u9wCVx1cPXIqN0Co++Cw/+2WhKXdeUpjJT7IiIRD
 8ffKBooZ7Fj4w==
Date: Thu, 05 Nov 2026 08:50:46 -1000
Message-ID: <5582fb8a609eb8a2348811ecb6f539a7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v8 4/6] workqueue: Add support for real-time workers
In-Reply-To: <20261104095225.32654-5-tvrtko.ursulin@igalia.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-5-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied 1-4 to wq/for-7.5 with the code refilled to avoid unnecessary line
breaks, HIGHPRI_PRIORITY renamed to HIGHPRI_PRIO and RT_PRIORITY renamed to
RT_PRIO.

Thanks.

--
tejun
