Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B561606A338
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=1g44ZpTk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE32610E111;
	Tue,  3 Nov 2026 22:07:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FF510E159
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=hUCocccnsnf4xuExAg437z+DV5q0Sp1f0DdcukIjmG4=; b=1g44ZpTkXoPPCChI1zYrpMbJGO
 D+a+MnExzT/wGw5Y6PwfcXQVdZY5GMsN+R7zTySPRbU854mlVOP0lCKi7G6lYwFo5hw+W+hcu8qRW
 qsqCHADeAlRx9ShK/WPyuOI9NoMB3VYmDrI8C0hDL+5WSyHhj03ND+5GbR2Zhw3LXbL1fHuqeTZIy
 0meSJGJHd/5++cD/95RqRZdn6C+/VExHvsDFOtpJMaRqlW/OAI0dy54JCdoyDbHPOfiky1BBArLGV
 HZHUJ1VX9DvS1hrE2xwMjCuy16DRPGa0EAd2QbKI1PGwDaVGdPf3TtQX0k6TVU7GX4mXCLX2uOt70
 3kUGwcaA==;
From: Heiko Stuebner <heiko@sntech.de>
To: sidong.yang@furiosa.ai, royalnet026@gmail.com,
 Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ogabbay@kernel.org, tomeu@tomeuvizoso.net
Subject: Re: [PATCH v6 0/2] accel/rocket: Fix allocation handling and
 scheduler array leak
Date: Tue,  3 Nov 2026 23:07:26 +0100
Message-ID: <179374364224.491826.14820937269561898345.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 14 Sep 2026 11:56:03 +0700, Triet Hoang wrote:
> This small series addresses allocation and memory management issues in
> the accel/rocket driver:
> 
> 1. Patch 1 ensures proper allocation checks before using pointers
>    in rocket_job_open()
> 2. Patch 2 fixes an unreachable memory leak of the scheduler array when
>    running on single-core setups (e.g., num_cores == 1), where
>    drm_sched_entity_init() drops the array pointer.
> 
> [...]

Applied, thanks!

[1/2] accel/rocket: Check allocations before use
      commit: be22e979c18f5ac6407f21c860a3e09d5411ec16
[2/2] drm/rocket: Keep scheduler allocation in rocket_file_priv
      commit: 91c7da1f42cadba62e1b0ba40be999803d998db0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
