Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0E7CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799D811214A;
	Fri,  9 Oct 2026 13:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="AS3vjR+D";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B5811214A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:29:53 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=AjAP+QI8JnYavGL9gJQd7S1yVJL066iBX6Zj9aSs6G0=; 
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791552591; v=1; x=1792157391;
 b=AS3vjR+DGpgj6O2uhrp0VSkLIp1nJ3/d5EGXgEZQldY4rUHgZAUIEZh4Z/F2BW7yvcwGDPcT
 iTlqsWIhtkOHQ7wQD9YTvJ8AM+jcplJYfV9MXZZoFYK6iKzFMKP3bJhfPwwgTza5ArWEvCSh99G
 OJS6kcrKqjTml4CqKrQtYrltESW4aLAgikPNe6gP95T11Gt6CxidGBytZihFMsiZQCVF9WWkIgW
 FD09slVhFfHzX1CtAjF4uJ53NxYSvxOpS8ZUjUwW5Fal/xRACTptb1QWRQR8DHJ4+ukm1rglpPU
 fGh7FQ3/ZpCm8ul9+VrbO48hw0gAhht8KImBzxoBBV/RQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 25315a1375ed6732;
 Fri, 09 Oct 2026 13:29:51 +0000
X-Mizu-Trace-ID: 25315a1375ed6732
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 15:29:46 +0200
Message-Id: <DM0CE087PHFD.EEV8UZ4V6A7E@cknow-tech.com>
Cc: "Karl Mehltretter" <kmehltretter@gmail.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Rob Clark" <rob.clark@oss.qualcomm.com>, "Jianfeng Liu"
 <liujianfeng1994@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, "Alistair Popple" <apopple@nvidia.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, <linux-rockchip@lists.infradead.org>
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "Diederik de Haas"
 <diederik@cknow-tech.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
X-Mailer: aerc 0.22.0-31-g5c1c510d2b65
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
 <DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com>
 <20261009125338.GB13920@nvidia.com>
In-Reply-To: <20261009125338.GB13920@nvidia.com>
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

On Fri Oct 9, 2026 at 2:53 PM CEST, Jason Gunthorpe wrote:
> On Wed, Oct 07, 2026 at 02:02:31PM +0200, Diederik de Haas wrote:
>> [ 1091.981354] rc rc3: two consecutive events of type space
>> [ 1104.670513] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/inp=
ut12
>> [ 1172.090231] devfreq fb000000.gpu: Couldn't update frequency transitio=
n information.
>> [ 1189.403278] devfreq fb000000.gpu: Couldn't update frequency transitio=
n information.
>> [ 1206.309295] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/inp=
ut13
>> [ 1268.968696] DMA-BUF: importer used the CPU side of an exporter's sg_t=
able
>
> This is a nice stack trace, is that the point of this series?

Actually only the last line, I just "couldn't help myself" to also include
the "Couldn't update frequency transition information" part.
It can be unrelated. Or not. I lack the knowledge to make that determinatio=
n.

>> [ 1268.968710] CPU: 6 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc=
6+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
>> [ 1268.968715] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
>> [ 1268.968717] Call trace:
>> [ 1268.968719]  show_stack+0x20/0x38 (C)
>> [ 1268.968726]  dump_stack_lvl+0x60/0x80
>> [ 1268.968730]  sg_dmabuf_cpu_access_warn.part.0+0x24/0x30
>> [ 1268.968734]  sg_dmabuf_cpu_access_warn+0x34/0x38
>> [ 1268.968739]  iommu_map_sg+0xc8/0x1e0
>> [ 1268.968745]  rockchip_gem_iommu_map+0x8c/0x128 [rockchipdrm]
>> [ 1268.968757]  rockchip_gem_prime_import_sg_table+0x58/0x160 [rockchipd=
rm]
>> [ 1268.968761]  drm_gem_prime_import_dev+0xa8/0x1d0 [drm]
>> [ 1268.968776]  drm_gem_prime_fd_to_handle+0x1a4/0x280 [drm]

IIUC this was meant to show the actual problem.

> So.. This is the exact same thing I need for iommufd.
>
> rockchip is managing its own iommu domain and you cannot map to an
> iommu domain without using a physical address.
>
> Of course it is *completely* illegal to call iommu_map_sgtable() in the
> importer side of a dmabuf.

I can't say anything useful wrt this, so I added the maintainers of
``drivers/gpu/drm/rockchip/rockchip_drm_gem.c`` to the recipient list.

> static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
> {
> [..]
> 	ret =3D iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt=
,
> 				prot);

It may not matter, but I noticed the majority of that function is from 2016=
:
38f993b7c59e ("drm/rockchip: Do not use DMA mapping API if attached to IOMM=
U domain")
1aa5ca6e3ec6 ("drm/rockchip: Use common IOMMU API to attach devices")

From the first commit (38f993b7c59e):

    The API is not suitable for subsystems consisting of multiple devices
    and requires severe hacks to use it. To mitigate this, this patch
    implements allocation and address space management locally by using
    helpers provided by DRM framework, like other DRM drivers do, e.g.
    Tegra.
   =20
    This patch should not introduce any functional changes until the driver
    is made to attach subdevices into an IOMMU domain with the generic IOMM=
U
    API, which will happen in following patch. Based heavily on GEM
    implementation of Tegra DRM driver.

And I assume "following patch" was 1aa5ca6e3ec6.

Cheers,
  Diederik
