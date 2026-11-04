Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DD606A338
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=F/mPSDlc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B757112C6B;
	Fri,  6 Nov 2026 09:19:05 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 20:14:23 UTC
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3C310FEE2
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793822353; cv=none; d=zohomail.eu; s=zohoarc; 
 b=dlV+Ny7hMOkt5HlZXhS26tgvbGlxQSLVURMm88dYkJMHWlULVV0zmrBO9gxBn7WMswHyq/aRkHk/hkyUyvQvScLFrcd8md0fionlD+5VJGGGlpae+fCFMb/iWwjsmTQeHrRisYXN+w2vbaABX7Rhqsco+EvwZnyT7xXZBsWUXTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1793822353;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ItJWBgurNWrKzbA3+9kWCtCIwN+CzwIffxyCOBCEeZ4=; 
 b=PHRuyDioZ2UmrngLNTXv1sxpH7KF6ZBwgzXJgOwZ5rnw0a0Aq7NDbBfsyHjNUGBJwUnw7IxEoBUBo73S9YeWNC9D6cNo4Gpp2E3Y92HjLrV1SSKbUriY79tl6jBRoJ2xGgp54GzaX4L/+0woOci0HiY4/Iu0wyvaQGRKFob+b+4=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256;
 b=F/mPSDlc4uIp6nAJHIOr/sNm8CuQcnOjV63n6wSvUpp1rZ03Ldkn+O6DHim38i2EcxTOGPx7aGWqjPccxvtEG+L0CnB5dOhByaaEYd6rxSYmXDvrFrB9l6yiwzpf2SdRkXldpUkcc/j9XVnviticvo6Y8DKw3tzzz0kxkrtonrM=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=ItJWBgurNWrKzbA3+9kWCtCIwN+CzwIffxyCOBCEeZ4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793822350815917.9354164021267;
 Wed, 4 Nov 2026 20:59:10 +0100 (CET)
Date: Wed, 04 Nov 2026 21:59:09 +0200
From: Igor Velkov <iav@iav.lv>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: iav@iav.lv, Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/panfrost: Gate the RK3399 GPU clock in runtime suspend
Message-ID: <20261104-panfrost-rk3399-pm-rt-larumbe-reply-1@iav.lv>
In-Reply-To: <autNWETrwrHbD2H9@sobremesa>
References: <20261030-panfrost-rk3399-pm-rt-v1-1-e94437159a9d@iav.lv>
 <autNWETrwrHbD2H9@sobremesa>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Adrián,

On 04.11.2026, Adrián Larumbe wrote:
>> On ROCK Pi 4A restore from hibernation hangs in genpd_restore_noirq()
>> of the GPU while panfrost is bound. With the clock gated in runtime
>> suspend, as on the Allwinner H616 and the Renesas parts, it restores.
>
> I find the wording in the preceding paragraph a bit confusing . Would
> you mind clarifying what 'parts' means here? I guess you refer to
> specific SoCs.

Yes, SoCs: allwinner,sun50i-h616-mali, renesas,r9a08g046-mali and
renesas,r9a09g047-mali already use default_pm_rt_data. v2 will name
them.

> Also, I wonder why not disabling the clocks would forestall coming back
> from a power suspension state. Have you raised this matter to the
> maintainers of the RK3399 SoC subsystem?

The kernel that reads the image never binds panfrost, so after
clk_disable_unused() aclk_gpu stays gated. The restored image still has
it enabled in software (enable count 1 since probe), so powering the GPU
domain back on, whose clocks include aclk_gpu, only bumps the count, and
the QoS writes that follow in rockchip_pd_power() go to a gated block
and hang. I traced this for rkvdec [1]; for the GPU I see the hang at
the same spot, genpd_restore_noirq(), and gating in runtime suspend
removes it. I haven't raised it separately; Heiko is on To.

> Would you also mind describing what you did to reproduce this
> resume-from-suspend issue? Lately we've been getting some fixes for
> similar SoC issues and I wonder whether mine also has it.

It is hibernation (restore from disk), not suspend to RAM. ROCK Pi 4A,
drm-misc-next 33ed26235db9 plus [1], panfrost as a module, bound, GPU
idle, swap file with resume= and resume_offset=: systemctl hibernate,
power off and on. Without the patch restore hangs at "panfrost
ff9a0000.gpu: calling genpd_restore_noirq" 2 of 2, with it restores
6 of 6. A quick check on another board: with panfrost bound and the GPU
idle, its core clock keeps enable count 1 in clk_summary.

> If this patch depends on another fix being merged first, I think it's
> best you delay sending a v2 until it's been committed to its relevant
> subsystem tree and changes pulled into drm-misc-next.

It applies and builds without [1]; [1] only gets this board through
restore up to the GPU. [1] goes through linux-media, so I'd rather not
tie v2 to it, but fine either way.

> I'm not entirely sure about what patch submission guidelines say about
> testing information, but normally commit trailers must come about
> last. Would you mind then moving this to right before the S-o-b?

The test notes are below the "---" on purpose, so they stay out of the
commit.

>> +	{ .compatible = "rockchip,rk3399-mali", .data = &default_pm_rt_data },
>
> You're effectively adding support to a whole new SoC. This made me
> wonder, are we sure suspension resumption not working is only because of
> GPU_PM_RT? Shouldn't we know first about its supplies and power domains,
> and any potential GPU quirks? I think this goes beyond my knowledge, so
> maybe Steven Price can pitch in.

The node already carries "rockchip,rk3399-mali", "arm,mali-t860" and
binds through the fallback today. default_pm_rt_data differs from
default_data only in GPU_PM_RT; supplies and the power domain stay as
they are. The RK3399 GPU node has no bus clocks and no resets, so
GPU_PM_RT changes only aclk_gpu here. Steven's view is welcome.

[1] https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a231de@iav.lv

--
Igor Velkov
