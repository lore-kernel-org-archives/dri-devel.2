Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D806ECD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B45897FD;
	Thu,  4 Jun 2026 14:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="l/ymEMJA";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF6889261
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:20:23 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-91588056619so51103085a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582823; cv=none;
 d=google.com; s=arc-20240605;
 b=aERXL+LpM64L55QM/LswhxrFAWhcm1CB2C7fhLxQjaPJvRY2MTWnoqF4egzg+q3F5b
 GdHGTkwPMTxrc3dt+t6rxLEEB7lsA0QqZ3pPAcKxUIMyiVsBcuYeegV6NxFZ5r0JThJ/
 5pWGFbeCqD/metjxh3ajeP4khwbomtwJkeuf05pP0WaGq25cr1sKHAw4r1N9pvz9Wu+p
 /fpr6DpajjYTf4GzK6dWH88/OsK6wKmidd2A6FKmA8C34smlFhzFYtNoWhSAC0VnKvoF
 zGW5JQfWRR7qbEZUCt88JOcg/3r/RJyd8Qu/w2sGP/vRzkOBE93s+oQfbafrNwoY2DBY
 f/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
 fh=HkxHJlQJuqJtk8szExFgOlWxfFjhRmRqs7SOhuJdmVk=;
 b=Gh4r3cFmEWhjCnPu8wfey/H1zQQB+SGbGmpJ6js9jbkxXfpLa7o3neVnhVmvr3rlxC
 apAdTTLuGBad2R/35Yn3GRlYw9vjuu63xeP8+e4xyF/iWYCCagNA7ceV/zrryeiV8y1j
 b3Yz1qwWh+OUGnnIg7klA0VpvPQKS3HpbGLenxMEHZQe7P/yf2oY3a+eNTtxLxD5WBQg
 Iv89RaW/eE1Jfwa+GSYP4mOIBuvAu06lKc1md1BDh8C6wY765K9mWQ9WyPUopNyfb+Yz
 02+RKdbzHgSm2D2k1k7dWg7esrvdwWPcDap1TmTfV2J59esni8FEI3usGi9kNQDeLBqp
 fi3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1780582823;
 x=1781187623; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
 b=l/ymEMJA9NocexEn8uGGfxDefFMb4yWjjrw+ZwNk8blSmeOmoHeFsE3zQbSiCjjc76
 qeDk+HtEKQv50/HnWoz6/34kDM48bGZqxq5ZnRkrXXEkWVhRjGqVCjTAJ4qREgaWgAZi
 bHhIvzQ3vMjpdKBevtKl1z2lp/O62YhK99syyL+JHS7lJK3p+XzUAm3AcvsPw+H7GQDU
 gCfJdKtdFi9Eu43ZpIXfycuSzcyLboPATX0bw7rcrv/Ft4NleppEMBObD2leiBt39fQX
 UlmP8t07fEBPZtZbllGEM1GPTtX7ZEVLNCCJGbY/puQS0O86ygY4mp1fxyFlAq3fBMf+
 pGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582823; x=1781187623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
 b=jho2kMFbxwVTz/YHCj319mbNX19nFFjPJfpJ8FgNSrxonpfoFHABaWAxgNFRtwZjzB
 o+mxkgxw5BTxeE/jT/mWlclXdNTBcKlICCQzV3oB3keLxsPZ6FtpmEftwKbDE3UDqV5S
 jCVt5kc9cM7v+Se0zO6jOb9yFUFegqZb8SPojKM234HYvpCoKBxluJLd3yrTLGqlAT6s
 I5jpkkRpImlcRrgR7KwjWcvRxGRI97wDhjhxQiudN+38tcVd0YEVBzhwXe5ADaqIFVXp
 fSrCVO2RP73JRjRTdZdIyeCangormOM1gou5ySvMi0euF689Ont8mGnIG/MjGCmdMkPz
 GzNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kHAcCcLhPYL4Ai99m0ddeAB3iqTdVKL2PikoxifY54MGkc7bQGD4EIwkI6YpUVh0A6Pxl9OAm+lM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbMAnTwGb0067pBZnjA9JHDsmQ2fq+5tXO1OgH1/VsqTTbc1Sy
 fGeKuLXY96zkvoUAwJ6Rxt+dwJIDA6sKA7V/8tVtAa0O6CiUJfdSH/tNSQet+BYzXB/4Qr2MWIv
 HVrJCjyQw5UjakfDygXBN15dz0YdGlC5F8OXbbGHAuw==
X-Gm-Gg: Acq92OEAd2sqw2U0COd3HRo2PwYex6JkDmb5Sgl6LpGkuFjiK98By9JWvzDVnBYesyQ
 Ne8S4EC29lr9sG4us1ZTu/qQR/IYhSN9e9/7VZQnuhmGKEnt70LfsqzCRBLjjB6ch8ciTPXzzno
 6esjt6sA5w9yL5nss5ljY6sAE51Pn0Ipzj2N02HVdQbfvD2tbnyAZhNCO9yxe5lFWSZP2nRe903
 lh0gjWIIQvyUVY2yj4YHO7Ue9t47A2YtR8nI4MYLcf6LU2Nlpt1VRkjB4GqgsA5+vH6+kTDb6p5
 s4dYc5ICBYIuhlid
X-Received: by 2002:a05:620a:268d:b0:912:c0b3:7d9b with SMTP id
 af79cd13be357-9158a76739emr1272633085a.24.1780582822784; Thu, 04 Jun 2026
 07:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
In-Reply-To: <20260604135255.62682-7-midgy971@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 4 Jun 2026 16:20:10 +0200
X-Gm-Features: AVHnY4JQeDtrhyq7YBnn9raVEBX1uxBzeM4kDcgUj1eAV9LhKWI5-NL4FjfQpnY
Message-ID: <CAPsqS2RYjf4dMj=Maz1c2vViW83ZsrEW9eOez526eh=TsKvQww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Midgy BALON <midgy971@gmail.com>
Cc: ogabbay@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 4, 2026 at 3:53=E2=80=AFPM Midgy BALON <midgy971@gmail.com> wro=
te:
>
> On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> auto clock-gating of the page-table walker, so the walker's AXI master
> loses its clock between transactions; a TLB-miss page walk then never
> completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
>
> Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> so the walker keeps its clock. This is required for the RK3568 NPU MMU.

Hi,

I'm not able to review this patch myself, but maybe it can be
submitted separately while we work on the NPU bits?

Regards,

Tomeu

> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 4da80136933c4..e3d8b6e9ca12b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>
>         ret =3D rk_iommu_enable_paging(iommu);
>
> +       if (!ret) {
> +               /*
> +                * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page=
-walker
> +                * auto clock-gating; the walker's AXI master then loses =
its clock
> +                * between transactions and a TLB-miss page walk never co=
mpletes,
> +                * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE). =
 Clear
> +                * bit 1 (keep bit 0, the slave-port gate) once paging is=
 enabled.
> +                */
> +               for (i =3D 0; i < iommu->num_mmu; i++)
> +                       rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATIN=
G, 0x2);
> +       }
> +
>  out_disable_stall:
>         rk_iommu_disable_stall(iommu);
>  out_disable_clocks:
> --
> 2.39.5
>
