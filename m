Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9D606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R5jTtr3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDED10FABF;
	Wed,  4 Nov 2026 10:09:45 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F66010E880
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:09:38 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-93e6eb77f0bso61147185a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 02:09:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786977; cv=none;
 d=google.com; s=arc-20260327;
 b=AgP+BeeAH70P+cIdCjHNNQEcx27eCPF5dGhq7AOaR0PVWacf+MqL7svMAJbbZsDykg
 P/DibCi/1za3fwYoQbgP1FNxWhqR4H+BKpnnkMrwDRKHzPBB6zxyoN40e2/T4jtcypu5
 oL6QnhbJJ69+2z24r7xAZb4oGAih569DRvMYw54TrvzTjMmkyDWHRc6gMi2n1iKlGbWi
 2bHCN62t21+Q4iEUJRFWgf8w9Yik5uXIVQa+x8gmd6wkzv2GPXtPa4rhgQoo/1LsxRKv
 25t1bUX+EKbkvbrZgzCKJ//vCB7TQ/dI9H3WC1DV9i+bekzGymNMq9oHQBI+c60it+Ba
 8qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
 fh=0id+PgTUI4lMn9Hm9CZwiBfapQwA3Hzz+XjvMDTfQgY=;
 b=SAmGpJ0Mq7yjnKvwySCmU/F2mwqbboQrxNAy+DGI9yNJjthFcZRykx+8AY7VgWYynv
 SEQzXklvCN7XjYzUl/HY0k9Rc3+/sZe3P5xctCCJ3J8kpz5VcFiUP3SnvOLtdKQIhyzB
 MfPshaQcv+iB7Vb59NhwqElkowgms1cwBCEnAsfDRwig+cMauqEVYseChznGXKuuRPFO
 4HYX9vQFeNKp1DcKOJRbw5GJbcrGycYpEPqX/aWEH8r96GZfNFFe/8tpprSTKbd/Dazl
 pq96QItW3vvMh7chhAcVSGi9aiAPIfcXlCb+p7C0FiSsu7Lx8Nrc5/O2PouVebJMc2Yg
 +Inw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793786977;
 x=1794391777; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
 b=R5jTtr3AWo4sAKtEp6jbMXgCb294p2sJCbKHxmajs46OYhQqwy+FlBPXzi+ozV4XER
 oJZIvlMDo6WsvAwZ6ioWgZv5B9lm5p0LYp+2kdmHVy58eSi7k8EebDZluctF73M4g1GH
 gCNk4gHkQejChR1o608d9G1yMDU6H2XKlfR7eILkeLWEO3xd/SOcsBpTuk9GkwvGjasj
 k6V1dsqGhlI/7UPPtTw3Q4podv4kCkJkyMmIaQcClDmgE7JTnEN5nPGQutxLxFRaHS4p
 zJWg17ETaWssRIDs7IT2kQWoMKO5Ikf1Wrr+VTP9CxUFCYAXpPFK3qQVZaS3BHECijCs
 9u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793786977; x=1794391777;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
 b=ANwtRBCXKwSPjTV1+WNXLCQ1n9BlzWgNGqGp4w5MENdqFTgPaUehs1Y8Lyz5h6g90B
 K1YrjOwawTBbWZjfYUm7SoCI7NZCRFDwWn7OyDaTqUHwtqLP8lHL63HO5mBKh9Os07mD
 OjU/X0zpMp4OGuzkWsIyb1PjvRrkBV6d3mZ694lKHKsBnMm0JAH9YV6O4cSyXHZ9aNkg
 Tx5ezRSkJbuK/nRzOibGI9mN1PZVD9+8DcLXi04nOt45FYiJ2fsCuDM2d9a/8C7Om55C
 UlPnlPChyKK8CCFySwRTEHquMolRnWTD03wSO2FPXWo/GA9KSzAKJ/Ndb07KQCMROiLs
 k2ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLtB7RRyJ5UNbBbDzCDqf6m2xJiYh3SEIH0ZqjFKR5s5RPbr5HmljfCF3V73W0evZZhMm/5kSK6T8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z995iBO6o40dG2n7uJtt3d6BpKdyTjQhoV/GMbJlFavEaDkIJ8C
 NNLrIZulbX41Bfy4o5JAewan2wYYoJsgJGC58GSTRCm30l+1FnGNLUfsSB6Th4CnwytiD4Gi4qc
 U1UEj4WmuzDikV57vlpQPlcf1wZLOrPFMYfIvolnbqQ==
X-Gm-Gg: AYBFou0v/fcrbkqzqjj3K8oqlHFvyKIEL6uEFnhqFTuPYUfNf7IU4FWHnnhCywIaVXf
 zTUFmWVSbtDsyABvLbRVfnkStXg8Qy0sZde3rjqRDlUrHx3jtquoI3xE4VSA0efYko8RrmbuY+7
 oVIFHGKD/Sdm72hGwIV9vgsNBFyCRfbmfEbmc2qYfFnr7kToFlP1klYqgGJElUzAjhtyQ4hxvaZ
 EYRlDE3Ei9ahD7+Av34KEgQiQ0ehbX+lcQrByUs2bDX8IkQqYu6xPn9K5o6DomtzRUYGaFA+KD8
 ZWaBO9i1yInxfVQdLUiyKalMKBBZFAvR6/9fK8gKpc2PBnQqG7amoTqpGqovR4llfrDgXwI4dhm
 cuRz6yVYU2kX774KT09156iGUop/vZqOKu1Zih398cgGrW12/plvBu2u6P26LyM8JM4gbHQp4b0
 w+LGM5znX+eqXZxr3NT/0=
X-Received: by 2002:a05:620a:460b:b0:937:6de8:b40 with SMTP id
 af79cd13be357-944217194b4mr2663985585a.15.1793786977174; Wed, 04 Nov 2026
 02:09:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com>
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 4 Nov 2026 11:09:25 +0100
X-Gm-Features: AclHuK8sSyrPUh77ae7umfCvxuLdQ-s4Z2b2nFvZD8O11RHz5Wmhve3hcOyzmnA
Message-ID: <CAPsqS2SOj-+VQxsFvMQ1Hqcep55J0yT++76QZ8or4a9kmF7Bdw@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
 royalnet026@gmail.com, abel.vesa@oss.qualcomm.com, 
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai, 
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com, 
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl, 
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 9:31=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> wr=
ote:
>
> This adds the RK3576 NPU to accel/rocket.
>
> v15 is v14 rebased onto next-20261030. v14's 12/15 no longer applied
> there, because Sidong Yang's regcmd validation added two defines in the
> spot where 12/15 adds its own. Nothing else changed, and the tags carry
> over.
>
> Leonard Lausen has the series running on a NanoPi M5 and posted a board
> patch on top of it:
> https://lore.kernel.org/all/20261019090348.378183-2-leonard@lausen.nl/
>
> On Sashiko's two points about v14 9/15, I measured a CM5-IO. U-Boot
> hands over with the NPU domains on, and the power domain driver still
> probes. The NPU QoS is saved before its first power-on, so it is not
> zeroed. The domain whose QoS does get zeroed is the GPU, on mainline
> without this series, and that fix went out on its own:
> https://lore.kernel.org/all/20261101055633.101309-1-gahing@gahingwoo.com/
>
> 1/15 is the patch that carries Igor Paunovic's name. It is also part
> of his DVFS series, so whichever lands first, the other drops it.
>
> Ulf offered to take 7, 9 and 10. 1 to 5, 11 and 12 go through accel,
> and 13 to 15 through rockchip. 15/15 needs 9, 10 and 12 to 14 first.
> Without 9, 10 and 13, the ROCK 4D takes an SError at boot when the NPU
> domain powers on.
>
> Link to v14: https://lore.kernel.org/all/20260924102135.92217-1-gahing@ga=
hingwoo.com/

Hi,

Could you please add a GET_PARAM IOCTL to this series for userspace to
query the hardware version? I think I would return an enum that
matches the NPU DT compatibles one to one. Then userspace can have a
hardware database indexed by that value with sram, register map, etc.

Regards,

Tomeu

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (14):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle an optional power-domain reset on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 157 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  89 +++++++---
>  12 files changed, 467 insertions(+), 64 deletions(-)
>
>
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> --
> 2.43.0
>
