Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB8FC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D1410E19B;
	Wed, 14 Oct 2026 18:03:36 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C5410E19B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792001004; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jqWn29pBLN5f5+3ILfi9EtntgCNHEhrsHz0mY46mJICxw/Q7bNpH/cTQc7ZRoCJpKaQ4H5Ou4ii7HfBJMixOUdlfz+bzcdQLFO+BW7yYE8hj+UgwQuzG9S9u6OyZxuo1tn3z2/izigunZMXNqzcYvPAaIlU4s6naOmNGFpt4zGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792001004;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BPScAGTP2dI9y+1B671zdS/5etpFnAG8cKrd+sZATm8=; 
 b=JqZzJXzztWOQ8TH7kX57rIp5+qTG+TzGAJT0bRexDmrRfKs5gWRnICKvkaBLktKDvlBooMC7BEY9Q+tmW7pe9HhmKt1fDXAGcrLtBKajuZhJ1Hv/UpGMRh0eu/n/r4N9ui+Wq3T2j0jAscwqEpY3/gUccmY+qG2MSh6/jVosdrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792001004; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=BPScAGTP2dI9y+1B671zdS/5etpFnAG8cKrd+sZATm8=;
 b=Zn0klXuSOOBf3l4KcDwiOZNBQ5sihqcI7yT2AUD4CQp0Yj9s4lEqO980gRhu4GY9
 jMwDf3b0TrhvnYrLP7/nzk6XZ6LaYOeTm1HHJaHYL++p0dvc323hJWA8kBguYqRps3P
 NRfGQqx+PhcJTBe1gD+8otzsGbWEd6eO0Cq6k12s=
Received: by smtp.zohomail.com with SMTPS id 1792001002372843.1310964349625;
 Wed, 14 Oct 2026 11:03:22 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:03:17 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <daniel@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: reset the Amlogic GXM GPU on runtime resume
Message-ID: <as_A5ygwMkEgGeP4@sobremesa>
References: <20260930125629.2691968-1-christianshewitt@gmail.com>
 <179184031154.1056803.12154076398577087527.b4-review@b4>
 <6B9C57A7-8BE5-461B-B44B-EF91FC2D2D93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6B9C57A7-8BE5-461B-B44B-EF91FC2D2D93@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.982.13
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

Hi Christian,

On 13.10.2026 09:02, Christian Hewitt wrote:
> > On 13 Oct 2026, at 1:25 am, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> > 
> > On Wed, 30 Sep 2026 12:56:29 +0000, Christian Hewitt <christianshewitt@gmail.com> wrote:
> >> After its first runtime suspend, every power-off of the Mali-T820 in
> >> Amlogic GXM SoCs times out and floods the log with shader, tiler and L2
> >> power transition timeouts. Following a soft reset the cores report not
> >> ready but PWRTRANS never clears, however long the driver waits.
> > 
> > Would you mind building the driver from the latest drm-misc-next and testing
> > whether this is still the case? Today I merged a patch series with a fix
> > for a long-standing bug that prevented the device from going into suspension
> > because of mismanagement of the PM refcount. It might be that what you report
> > as an issue triggered by power transitions is something altogether different.
> 
> I’d tested with the v12 iteration of your series in my amlogic-7.3.y [0] tree
> before generating the patch I submitted. I’ve now tested with v15 (as merged)
> and other recent panfrost patches you submitted (which v15 depends upon) and
> with this patch reverted, and the timeout issue with T820 remains. I also saw
> a splat that I wasn’t seeing with the v12 iteration [1].
> 
> [0] https://github.com/chewitt/linux/commits/amlogic-7.3.y
> [1] https://paste.libreelec.tv/desertic-cataleya.log

Turns out I was wrong about having easy access to a Khadas VIM2, so whatever I try to
gather about the existing bug must come from these logs. I see one very interesting
warning in [1]:

WARNING: drivers/gpu/drm/panfrost/panfrost_device.c:490 at panfrost_exception_name+0x1c/0x30 [panfrost], CPU#0: swapper/0/0

Something's causing the GPU to report a fault whose status code is at
present not documented in the driver.

I think that, because this seems like an SoC integration issue, and because of the unknown
exception being reported by the GPU, we should have some further input from an Amlogic SoC
subsystem maintainer, and also Steven Price himself.

> After reinstating this patch on v15 + dependencies dmesg is clean again [2].
> 
> [2] https://paste.libreelec.tv/leptosomatic-cherlyn.log
> 
> >> The transitions complete normally when the GPU comes out of a hardware
> >> reset, as it does at probe. Use runtime PM with reset and clock control
> > 
> > panfrost_device_reset() is always called as part of the PM runtime resume
> > operation, so I'm assuming what you mean here is that reset control is
> > deasserted at runtime resume when the SoC supports it
> 
> I’m firmly at the hobbyist end of kernel contributors and I’m not able to
> technically explain the patch Claude created. It’s entirely possible that it
> pokes around in the right area of code but is not the correct fix, but I lack
> the knowledge to dig further without explicit guidance. I can also give you
> remote access to a Khadas VIM2 board if that would be easier or useful?
> 
> Christian

Adrian Larumbe
