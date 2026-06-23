Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E36CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 23:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA0E10ED76;
	Tue, 23 Jun 2026 23:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gOvIoKmq";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ABB10ED62
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 23:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782255827; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AHwz5nym8AdF4nouJsu2+Bm9pfUE6Ht17qSA660nxK4+ZQNjDa2gl9fz1VIypIz38qy/2WJ8/0LeixooZQXvxlRAHoVvhgHh8u87H0A5mUzKIlfRO3x0G3+R8K+5eP8/qEifpMDzpRaezJMYeqcER36VJUIMOPtb0mYPevIaKtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782255827;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lUZH4nBGhVkoyHpsDLzrW/AhCF1ut9JHuXJeloJe34M=; 
 b=LXrU7SxvKqXjHuOIWuBmuk3Wxv5Ernjyomo3bTQpgckkhso2MPqevbZyFqlHxvSXj1n3j9X4UdJ8vS/XbcTCukcnSXYofMOLihZPTZoC0Ae4H/7pPujBYmvO2+oseNlGmEnaBcoqlubmvJ5i0V6t4uhL3mkrvbnJpDRP/ISafZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782255827; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=lUZH4nBGhVkoyHpsDLzrW/AhCF1ut9JHuXJeloJe34M=;
 b=gOvIoKmqb9NKEW3zyMM/+mKZHZeXPlxVKj9yvbGpffEg2X8NgkocbvNA7tki7kPS
 AzxltPtuYtEn8qrRuLSuMrKayi/l6rxk7j2+5WosqleoiKJbqZ8pcVG0lz0ntC8Q8ck
 UOjeNax6n/h5OzglAkSnr4+4K4HAwDBkITFkR704=
Received: by mx.zohomail.com with SMTPS id 1782255825197406.7977429302473;
 Tue, 23 Jun 2026 16:03:45 -0700 (PDT)
Date: Wed, 24 Jun 2026 00:03:42 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/panthor: Add vm_bind region with kbo range
 intersection check
Message-ID: <ajsQvIdJJ32-JYKJ@sobremesa>
References: <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
 <20260623201433.0BC441F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623201433.0BC441F000E9@smtp.kernel.org>
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

On 23.06.2026 20:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Integer overflow in `panthor_vm_is_kernel_address()` bypasses the newly added kernel BO range check.
> --
> 
> commit 517863d5c6821783c9329a7a6ac1663177dce0ba
> Author: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> drm/panthor: Add vm_bind region with kbo range intersection check
> 
> This commit adds a check during VM binding to ensure that user-exposed BO
> mappings do not intersect with the virtual address space carve-out reserved
> for kernel BOs. It introduces panthor_vm_is_kernel_address() to evaluate if
> the requested mapping overlaps with the kernel VA range.
> 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 31cc57029c12c..5625f3d340318 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> 
> [ ... ]
> 
> > @@ -1309,6 +1318,24 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
> >  	return 0;
> >  }
> >  
> > +static bool
> > +panthor_vm_is_kernel_address(struct panthor_vm *vm,
> > +			     const struct drm_panthor_vm_bind_op *op)
> > +{
> > +	u32 op_type = op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
> > +	u64 end, kstart, krange, kend;
> > +
> > +	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
> > +		return false;
> > +
> > +	end = op->va + op->size;
> > +	kstart = vm->kernel_va.start;
> > +	krange = vm->kernel_va.range;
> > +	kend = kstart + krange;
> > +
> > +	return krange && op->va < kend && kstart < end;
> 
> [Severity: Medium]
> Can this calculation integer overflow?
> 
> If a user provides an op->va and op->size that wrap around a 64-bit integer
> when added, end becomes a small value.
> 
> This would cause the intersection check (kstart < end) to evaluate to false,
> bypassing the newly added kernel BO range check.
> 
> Should this use an overflow safe check to validate the range before checking
> the intersection?

Will address in v3.

> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com?part=1

Adrian Larumbe
