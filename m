Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC88FC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C76C10E813;
	Tue, 15 Sep 2026 14:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dUcMzsy7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F280010E813
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:14:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBAFD4352A;
 Tue, 15 Sep 2026 14:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1908C1F00893;
 Tue, 15 Sep 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789481658;
 bh=jNENJb5/uy9j+GjflFgbEMSVLzG3vVpVhOOfx8QtyxM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dUcMzsy7aw7q8AZK9gfKy9qsDrAg8ZOAtNeaPer4/3gYD+KNEY+xZu56acWZyy7G/
 W02ST8yO1Q22p535M0v7ZYguGT/u4GM9kMnRniOvZ0Mg6Pn4gA7/jmuXdRCDVkn+L6
 WhC16INupxTUlCpLPQOz2/i7SJc1HuZK8RxDiVHPA/qdfOHbEnc41RwTLgr5SQv6Sj
 4Ym8UbxmnWaUeY5GJQpU6zZus02YlcCL8IeSc9HSylzw+6k1eAbql2ca99Z89lyfKr
 qQIgZH7xoqC2oiEpo4O8M97FkTYlszFRMbO3eeoE3jN+gzozHRYhM3820iGEyqPi0n
 /njpbusHQWLyA==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org,
	mpenttil@redhat.com
Cc: Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tests: hdmi: fix infoframes tests
Date: Tue, 15 Sep 2026 16:14:00 +0200
Message-ID: <178948162528.1987579.17248782054753924983.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914040723.2593700-1-mpenttil@redhat.com>
References: <20260914040723.2593700-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 14 Sep 2026 07:07:23 +0300, mpenttil@redhat.com wrote:
> drm_atomic_commit() calls drm_atomic_check_only() internally. Calling
> drm_atomic_check_only() explicitly before the commit leaves the state
> marked as checked and triggers drm_WARN_ON(state->checked) when the
> commit checks the state again.
> 
> Remove the redundant explicit checks.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[1/1] drm/tests: hdmi: fix infoframes tests
      commit: d5c34a384305e05a2d463dd2094e0ec449643bd4

Thanks!
Maxime
