Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6FF10E271;
	Mon, 31 Aug 2026 09:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="La57D/PC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C305410E271
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:16:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7799E436BA;
 Mon, 31 Aug 2026 09:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121101F000E9;
 Mon, 31 Aug 2026 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167786;
 bh=QKvBc5YAIUkjZvnk5bWUmLbVUV116FgKuE+ph+scD0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=La57D/PCuDl/mwr16huPy8JICx4ys0UeYuiGHcNGwp1RpmEVvQHo/LCYmqRrkzvXG
 rIbKRcLb+b01FC8dcggJy4PY6YnQpBnXFSv7Sx5LlqKeTmBysATcpJ4YAJOJp1FoDJ
 29gIYnQc7S3N06dhNP45Ihtvm+dCOr8MDD3BBa3ICbJPwHfT1Q7d6H3ds4MIwKGPKj
 M/bxbXuOBjXNywQ0PboWxuJhNKlBeJ37Bckvs0yI7oYBsP26fRTH1HrGzT/aSoeOTV
 WZbbtjYX73BJwilsUcqUtk34e+QktvBqELQAr58qYcRDHyHwy36RQgrWA1W4uIJNnX
 QJdFDEoKPiwYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/14] arm64: dts: rockchip: rk3576: add NPU (RKNN)
 nodes
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260831081956.84871-14-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-14-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:16:25 +0000
Message-Id: <20260831091626.121101F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaking `iommu_group` reference in `rocket_job_next_locked`.
--

commit 6d0158c8b1c151133b206dc57eb669f47d5dc64e
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes

Add the two RKNN cores and their IOMMUs. Both cores are disabled by
default; boards enable what they wire up.

[Severity: High]
This isn't a bug introduced by this patch, but is there an iommu_group
reference leak in rocket_job_next_locked()?

drivers/accel/rocket/rocket_job.c:rocket_job_next_locked() {
...
	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
		rocket_job_hw_submit(core, core->in_flight_job);
		return;
	}

	iommu_detach_group(NULL, iommu_group_get(core->dev));
	dma_fence_signal(core->in_flight_job->done_fence);
...
}

The reference acquired by iommu_group_get() is passed to
iommu_detach_group() which does not consume it. Since iommu_group_put()
is never called, this reference appears to leak.

Could this code use the already acquired core->iommu_group pointer instead?

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> index b0c0d3c8b1b14..2d0133cdf9b5f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D13
