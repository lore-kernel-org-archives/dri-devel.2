Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBFFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E012310E581;
	Mon, 13 Jul 2026 08:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Yrl7oPe+";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6D489B66
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783929599; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=beUvZownJKxYbE4vtGmQpdjmF6IAlXKYt5cWyVGQS5zBa5uKkIGD33WNPvv26ph4odNJb1sEPs0KUrt4WjvSwknwPIdiRZdSZiNltu2ALVyHog1QEZHECgFjNUQnAZqH9XrfcZCGH76LhxSQX2b5oy9mbHXJ88AjRgsTptT/NW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783929599;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CNcuYJ7/HN/F2UVGrdzGY109S9/PBSZE6yzs4AZfUR4=; 
 b=l9B2XvbipT6U5GIvzo+klRyclTsuuePz1aP7vvYOk02MffUIh25JBRKZ15Q5kTjVBIFi/IXPywlBlYY60VTw/foHfNlXTHZUgNfx3NMK3Qr2wvoDUUdWmKyw+IGRyJteLWcXIoLZXogW2GPkMYcczMgp5gsp1ZjwfPBqYoQNeg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783929599; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=CNcuYJ7/HN/F2UVGrdzGY109S9/PBSZE6yzs4AZfUR4=;
 b=Yrl7oPe+h3rwYp8Dsipk4JXkdyPgM5OJZiPCFfPiGfrFxFbkMS+GBKW9vet+/Qqa
 35ZjZcWukcm6Nn4DcXDjxSR1kd/X1KydF/zjboyRaVElT9or7jsfK90F2NgAe68j637
 RVzMR6z7AHgj2jDp3P/23TmaGlSJU7jeSQSxN8IQ=
Received: by mx.zohomail.com with SMTPS id 1783929598001272.5248757124549;
 Mon, 13 Jul 2026 00:59:58 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/3] drm/panthor: Add vm_bind region with kbo range
 overlap check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <f5153423-27cf-42a8-bbd5-a289c14b6de6@arm.com>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
 <20260704-vm_bind_checks-v4-2-4705b6ca9f8a@collabora.com>
 <f5153423-27cf-42a8-bbd5-a289c14b6de6@arm.com>
Date: Mon, 13 Jul 2026 08:59:52 +0100
Message-Id: <178392959202.3779593.6197036600693145874.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=G/3IQU5ffi9GL8YHbiZvd65QqXKx8/ZI6ANxH9CXCvM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqVJr52GS6UCwcEul8uKCiFaoW8fj/va9WR43fp
 oOeIW+Co/CJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCalSa+QAKCRAOJn5M7lND
 PVoJDACz7QbzeWU0Yn+qlmDLeA1HtsC1EGJRCAVodsT0JLMFip+IMobHVv/wLhpj0pbSakm+/qP
 tEXgi5hmiFhrZj6AXjnDigNImX/t5n7taFsvmUALPazygIHDakr6lrgWlRj6RAoP2mXd3LILhRu
 uoaxlJKPFKqlvOtXe+4ljFE6kBmm5mfJAVM+ZANFKsaG+gTfQutxoozrchWXiz1o9K0n/kVeLBW
 uzdXEt90UUDQsw/7KvEBNmDrkdjTf20/df14ygJt5ROzV8Pi/0krqacuXz62ysf2nVDvJ7hkJFw
 XychTCsFb5ZcbSi8rr0PJ55aIpQKiG1UGCyQzifTkWByKDa+Jj7DDQ9QJv3MKolmfHrplOHC0qF
 phHkfW7bvNmp7Uh5g3MimF/DOXM9Dm/QKZ2olQj8hcaBUEqDvGZK6YHqtUCF2Uk3IJ+qT4SDrUh
 6/Z99hk/4ZkY2uF5L8I4kIv6Jav/xx2pbRo6fkuC/5OagszryX68uT3rJrFqtNdQ9Pm58=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-07-09 09:25:13+01:00, Steven Price wrote:
> On 04/07/2026 05:46, Adrián Larumbe wrote:
> 
> > When a VM is created, caller has to specify the range of the address space
> > carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> > UM-exposed BO's should not intersect with that region, but at the moment
> > we're not checking this.
> > 
> > At first, I thought of giving these values to drm_gpuvm_init() through its
> > reserve_{offset, range} arguments, but it turns out that is meant for VM
> > address spans that are not managed through the usual drm_gpuvm split/merge
> > circuit, so storing the end of the user VA range at VM creation time and
> > doing a quick check in the vm_bind ioctl path was the simplest workaround.
> > 
> > Fixes: tag and reference the relevant sparse binding support commit.
> > Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 163231c1703d..662a2c13b467 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -310,6 +310,9 @@ struct panthor_vm {
> >  		u64 end;
> >  	} kernel_auto_va;
> >  
> > +	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
> > +	u64 user_va_range;
> > +
> >  	/** @as: Address space related fields. */
> >  	struct {
> >  		/**
> > @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  		va_range = full_va_range;
> >  	}
> >  
> > +	vm->user_va_range = kernel_va_start;
> > +
> >  	mutex_init(&vm->mm_lock);
> >  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
> >  	vm->kernel_auto_va.start = auto_kernel_va_start;
> > @@ -2985,6 +2990,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
> >  	if (check_add_overflow(op->va, op->size, &end))
> >  		return -EINVAL;
> >  
> > +	/* We don't allow mappings that overlap with kbo's reserved range */
> > +	if (end > vm->user_va_range)
> > +		return -EINVAL;
> > +
> 
> Squashing this with the previous patch we can do this in one check:
> 
> 	if (range_overflows(op->va, op->size, vm->user_va_range))
> 		return -EINVAL;
> 
> Thanks,
> Steve

Will do so for the next revision.

