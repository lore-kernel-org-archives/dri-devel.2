Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537ECA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D1210E696;
	Mon, 12 Oct 2026 21:24:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E8410E696
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=nwOkb7E+8xqXn3L0SCFJZ9ds1kFmnCw+l2ll9ov+m50=; b=G2vg8GJ66qMDMBMGAwXmNZJZ7C
 pJ0osvXFOZ7CQVl0ycz6rCLa6bUn9s5n6FlzehHEWy/wrUuOIQStGkcUgs1CiAmtuhDhG/9IYGu9i
 srY/4tqzQhDnfPVxIBeY43kFCfG1Gr1RHhsOI6W6zY9/+hnEZMa09SLO0E0zFGgVlXDxucdDc/N58
 ZqtV4l9J7f3mj0KkwI2nmSUQYXkSX7jCe6Nax/uJPAzgd0Pjz8V5S0oJRdpQvZNCHE7LsLe34L2y9
 B2vFy3CLAmlTK2d0RxbTDMq2ziOqyYhisoN+bn+NRIyM1YxsjDC59Vn7KctK55xT4CjK0ou2TWx6h
 FKZffFsg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Sidong Yang <sidong.yang@furiosa.ai>
Cc: Heiko Stuebner <heiko@sntech.de>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] accel/rocket: Validate task regcmd fields
Date: Mon, 12 Oct 2026 23:24:42 +0200
Message-ID: <179184026446.3911056.10147379714812166378.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004164727.466164-1-sidong.yang@furiosa.ai>
References: <20261004164727.466164-1-sidong.yang@furiosa.ai>
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


On Mon, 05 Oct 2026 01:47:24 +0900, Sidong Yang wrote:
> Patch 3 rejects misaligned regcmd addresses and out-of-range regcmd
> counts at submission. It is unchanged from v1.
> 
> Patches 1 and 2 fix two pre-existing issues from Sashiko's review of
> v1. Of its other findings, the ignored submit error [1], the
> iommu_group leak [2] and the unchecked allocation in rocket_job_open()
> [3] are handled by patches already on the list. Until [1] lands, a job
> that patch 3 rejects is dropped, but the ioctl still returns 0. The
> __u32 regcmd cannot truncate an IOVA, as the rockchip IOMMU aperture is
> 32-bit.
> 
> [...]

Applied, thanks!

[1/3] accel/rocket: Don't tear down the scheduler when drm_sched_init() fails
      commit: a6709a58a01c8fc357e316bee31f369c2ea56235
[2/3] accel/rocket: Use an unsigned index to copy the job's tasks
      commit: f31a7b1f277d64f0d0d5907e13b69fe01a0bd250
[3/3] accel/rocket: Validate task regcmd address and count on submission
      commit: 725953d4da85cfb97a4c309fad6346b72f8529e7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
