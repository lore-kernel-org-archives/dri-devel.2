Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93491D3941A
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F6510E0B7;
	Thu,  2 Apr 2026 12:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CvHhZo36";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="O+sL8XKo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA52510E0B7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775132599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
 b=CvHhZo362ATfCvP5SP9xyxfErRuDRDS2aSDcjtQmOkMzEnLVWceNKg4TeTbotRfHHQMXWq
 tPlFcW8qI/GDMdzBQ4v974GO718+YmJh/J8j2IwaHdQd/k596NdT0U0ARRfzpY5cAmRNCv
 vT5GJ2FLnDjDtu5al30CqQlOHrnyGIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-WatGnwqDNkm6H61TqRwLDA-1; Thu, 02 Apr 2026 08:23:15 -0400
X-MC-Unique: WatGnwqDNkm6H61TqRwLDA-1
X-Mimecast-MFC-AGG-ID: WatGnwqDNkm6H61TqRwLDA_1775132594
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d022974acso877827f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775132594; x=1775737394; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
 b=O+sL8XKo5J4Zkxd5TagfWh3eHRV7SezI0OxK/xIZ18AC/ujJoSXMxoeD0cD+kDB/iK
 bVeBEJUY9BIS7JKACiNfIVwyysekM7bwxQlPwXbjQ/9SxDztlCcN6Ddzh1N9iLhhtoaa
 Im5/nm4ZbSdYQ/F3EC+eh8WrUmNDaLz+eEiXB+2dPwpLf0/PSOxjplE0Gmiqe9EwfA9Z
 JvMpxCPAcTlL4vX7AXn+ZsbBifKYGSUL4WI9K3E48GOJTHhKt23kV2hfzfLE6NDH0Vg7
 M7QsodThhTG7SkwIEBTEs+CSY8ZXu2jesP9uFHIuw52USWCvapz0HOsHh1ft+yHFEUhu
 SR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775132594; x=1775737394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
 b=mFlpTbkoVGpeuU58k3ptOhdGGqitPhIjOAhOME0QquaEmnRXKgy7y3WKpxqZbNZLOy
 vT5eSlspgWeRHNAmS3/YBQnUSc4FPEcAVwbZwfQ0fKmGkqlI/q/1oafi0pDwBwIP9JSB
 3BHq+3nq/AZgoOW7tH/Ja8B6AWrtvC+WWYljnaMHiAHiQdn02PXRuZVPgH59MG6N5t6o
 tw1bIpZr1fmkYqbiKQjcRejs+RZopZU1/jmQdsIlPot+vasdQiLJdd802Eu/VteLU+KC
 qwjNe3bUyZGcLuHYDhPIVsvQPSDviLMbyeEchjQ4rf/SmtuhuS8BWP1vqEkzzLYUwsgm
 O3ZQ==
X-Gm-Message-State: AOJu0Yz7BZXZC/7z+OA+5Bb9UBiXJ68/kGMahazEUjLjKLAgHMqkvyP3
 8FdUtO/GL0PJV5gZBS3qmKTL/mFaeqRdmHmjw5Yh0lAMIf+XQoFLCKuP2UB4aQLvcYVbHy8b9Me
 B2zXm1PHsMBu9tnaREfMfQkhtt4h8XOSanFIlxdr8yBZLjhMjzAWo3SGpCKw5wl9Fx0ry1g==
X-Gm-Gg: AeBDieusPQpAYQNq1KbpAGTd8ue0Nke8iwPqrIjRtU7KvWDwTqItHalG3a/HY4B0gmV
 2G34HC8XY7lgYcUagzlcgyOQryjxgP8v6FrmvTdV43LgR/5ma2dausgnYV5JPQiJtZqGinLSkst
 bkTTnAfWiESVNxwodTTyHMfuwAfKNq2nPEY7/lLnN8HubrPxpRq52MEeK69rN54typCCAFWFBK2
 WVWrt4H4kuYiJqvs/Mlzc6XzBXgF5Uf7Sec0Sf+dBaS2HcWabfQNqGf5e7F4S3QFKcoPp4lr+GT
 ONS6aafzed42TPkx/Z8MTIZ9Vj7tOgSc9HHZ7qK3LvJsEphuRatw6zWnG1o6pyetqMf4dUwU/A=
 =
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43d1505b105mr13705377f8f.11.1775132594185; 
 Thu, 02 Apr 2026 05:23:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43d1505b105mr13705319f8f.11.1775132593703; 
 Thu, 02 Apr 2026 05:23:13 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d214f2b63sm4510096f8f.28.2026.04.02.05.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:23:13 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:23:12 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
Message-ID: <20260402-discreet-glossy-perch-bda4f9@houat>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-3-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="e65sn5i4kwgewwdb"
Content-Disposition: inline
In-Reply-To: <20260325192352.437608-3-jiri@resnulli.us>
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


--e65sn5i4kwgewwdb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
MIME-Version: 1.0

Hi Jiri,

On Wed, Mar 25, 2026 at 08:23:52PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Add a new "system_cc_shared" dma-buf heap to allow userspace to
> allocate shared (decrypted) memory for confidential computing (CoCo)
> VMs.
>=20
> On CoCo VMs, guest memory is private by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is private or
> shared. The kernel's direct map is set up as private,
> so pages returned by alloc_pages() are private in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to private memory (no TDISP support), it has to be explicitly
> shared. A couple of things are needed to properly handle
> shared memory for the dma-buf use case:
>=20
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent shared memory from being
>   reused as private.
>=20
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the shared pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>=20
> - DMA_ATTR_CC_SHARED for DMA mapping:
>   Since the pages are already shared, the DMA API needs to be
>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>   as unencrypted for device access.
>=20
> On non-CoCo VMs, the system_cc_shared heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly shared memory.
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I'm a bit late to the party, sorry.

This new heap must be documented in
Documentation/userspace-api/dma-buf-heaps.rst, but (and especially since
it seems like it was merged already) it can be done as a follow-up
patch.

Maxime

--e65sn5i4kwgewwdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCac5frAAKCRAnX84Zoj2+
dnVEAX9CFXx//98RE08S4/htofGJDNunF07/14IluU1iYb8+94vCMi2iUvSzXSKI
zbgrVRgBfRy+pMU2nc+zOonhVfFvK813bX4cN9vLtMfH0/h/fKnFJKCc5msL12k4
8g97/3uO3A==
=FGaV
-----END PGP SIGNATURE-----

--e65sn5i4kwgewwdb--

