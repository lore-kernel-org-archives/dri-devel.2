Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75295C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04EB10E04E;
	Wed, 29 Jul 2026 12:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gr1x8lJa";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0215C10E04E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:00:08 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so5268045e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785326406; x=1785931206; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGpSfzW/n1QG6/cG+kMOZnSU/466r29fscAgjtbrJJw=;
 b=gr1x8lJa0x2UeXlNjUHJjBuE5HXnNkPTvuJ2u0+WWlQY+P6S9TTyZt6HFL0PKSIqh2
 8bS9yzufkX1qHr3L115oKwknOMT8LwoeL+1l/ZVCsfOu0ULiuAF8oWAv3sW5I3Byi0I4
 zQfGurmZyJFDD5m7EalOg0OMMOYcnO0l3gdzQFP1/UHVOKQnG/+W2axIphnzfsn6+axy
 4jQM0WteZPzaliCizn7QNdKsziJM0N8qBOraiE3E9UZOm4xO9l+AHY6/e+YuU1zoytTG
 qUNKhxI4CvAgpAVafDo4dP8x1R+LckB4x2RXsDQmIAiLcBOf4R2B68tvXq+SGXBgJnl4
 C+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326406; x=1785931206;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eGpSfzW/n1QG6/cG+kMOZnSU/466r29fscAgjtbrJJw=;
 b=PfSeUpOPHMOQVUphTmkcd7T/xfL5pVt2NOvmPZVcO5j9F/vzx1Ta7I+slSICgWVZJH
 fPskTPDxOcMIQP+CdFZLREGz578F7lVRHZCrRAE5JnbbQ3bfIuXqCastHiXXacydKw2V
 twadM6ZnU/K5hM/23HlLhaxOUz0DBpgpbIerZn8/6z++fC41G0mbQHvVl015VAE1wwCM
 JdYFF2trDtsip2TMNKAauKhj89LYoFUSvWNQ7mPyvaHywEHWHVWX4Ok4i+s37RMCcH/3
 F2tdOl6QcNdHxK1qvDZgTyNWbWWF3n1VV3gClFB+GKufvbS4WvH1lZZVObF7tOmp+/dO
 aIoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcAZ3gwk4Ah4H+E9XLh8/Udv8XOKcCNT8+AB2sQJn8fT5NxVcxsxRLz4reypw76GBfRJ2k+NIHiFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNSLd30OrtrPqXSTIzdtYMBViGDcxev+t9X0IldP/grYbnoeqJ
 KDIQYhJ5EsZPIIT0/omRY8ZgjSk2IPxeo+BI8+8Ci49+c4GMSxVYvsea
X-Gm-Gg: AR+sD12KMrUuroitVM6I+sVoOb1yyMs0uYG8Xa2vsHV0HKrCus5r/G4gxh43RPhMKAB
 MqbEd8gxD8ETWzB6Q14jDuvDy4ss8btsUjBZbC4+ZqPXK2FNgUOBIPSbKD5y01m2Q5B1QYRoUvW
 S57PNTJJLFxoQSZpa24gcCgbxc4nXU10I9dGXxC1szKGXX+GCSNDkKHOWL+QSeUPHlkg0V/+sIB
 SD2pqfcU0gDANQwooXHqbRF+TXYqMCPqOTQ4tQwt8HmiGtvnZmnFxM+fTPf5BDao9Orgdk/YoX+
 9ZMya6e5XvYqn35k7051IaiZZYg1+qD7QrfoMZKo+i57F9Dq0/oPqu5ro3KacOt6anVhrqgEK5k
 64cgXM+UXJLHA/IS2BOp06yLKFpLLjioHqPuEklvxWx+Vmut2XdwqT+NZ4iz3uLd6Jo3WMV63ND
 QPuEUrRdaaJDGAGaUHK2vIayZvpdwJGSgI4MKGnESsBlXUQMOuAOxjz8axa/ESeB7z8qmT2kRWA
 dUP1h7Sd7WajRdpvmPNRDo=
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-496c6590745mr70182755e9.18.1785326405419; 
 Wed, 29 Jul 2026 05:00:05 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:2975:f35a:5252:318b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c462512dsm142592625e9.13.2026.07.29.05.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:00:04 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:00:02 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: snapshot firmware interface counts before
 loops
Message-ID: <amnrQq-IJzIB_kgF@osama>
References: <20260720135518.17927-1-osama.abdelkader@gmail.com>
 <amjH-v6-2POzmj1q@e142607>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjH-v6-2POzmj1q@e142607>
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

On Tue, Jul 28, 2026 at 04:17:14PM +0100, Liviu Dudau wrote:
> On Mon, Jul 20, 2026 at 03:55:18PM +0200, Osama Abdelkader wrote:
> > The firmware exposes the global group count and per-group stream count in
> > the shared control interface. These values are validated before being used
> > as loop bounds, but the memory is shared with the MCU firmware and can be
> > changed after validation.
> 
> Again, you're making statements that need to be proven here. How is MCU
> firmware going to change the content of the memory shared with the driver?
> 

Thanks for the review. yes, this was flagged by Sashiko while reviewing the 
previous patch, but I agree the commit message shouldn't present it as a proven
firmware mutation bug.

The useful part here is just making the validated count the same value used
as the loop bound. since It's an optimisation, should I send v2 without Fixes
and Cc stable tags?

> > 
> > Read each count once with READ_ONCE() and use the validated snapshot as the
> > loop bound. This keeps the loop bounds consistent with the validation and
> > prevents the compiler from reloading a firmware-controlled count during
> > iteration.
> 
> As an optimisation I'm fine with it, so:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 

Best regards,
Osama
> > 
> > Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index e2fcbd639c3c..6e6da98d795e 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> >  	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> >  			   ((u64)csg_idx * glb_iface->control->group_stride);
> > +	u32 stream_num;
> >  	unsigned int i;
> >  
> >  	if (iface_offset > shared_section_sz ||
> > @@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
> >  						 sizeof(*csg_iface->output));
> >  
> > -	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
> > -	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
> > +	stream_num = READ_ONCE(csg_iface->control->stream_num);
> > +	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
> >  		return -EINVAL;
> >  
> >  	if (!csg_iface->input || !csg_iface->output) {
> > @@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  		}
> >  	}
> >  
> > -	for (i = 0; i < csg_iface->control->stream_num; i++) {
> > +	for (i = 0; i < stream_num; i++) {
> >  		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
> >  
> >  		if (ret)
> > @@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  {
> >  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > +	u32 group_num;
> >  	unsigned int i;
> >  
> >  	if (!ptdev->fw->shared_section->mem->kmap)
> > @@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (glb_iface->control->group_num > MAX_CSGS ||
> > -	    glb_iface->control->group_num < MIN_CSGS) {
> > +	group_num = READ_ONCE(glb_iface->control->group_num);
> > +	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
> >  		drm_err(&ptdev->base, "Invalid number of control groups");
> >  		return -EINVAL;
> >  	}
> >  
> > -	for (i = 0; i < glb_iface->control->group_num; i++) {
> > +	for (i = 0; i < group_num; i++) {
> >  		int ret = panthor_init_csg_iface(ptdev, i);
> >  
> >  		if (ret)
> >  			return ret;
> >  	}
> >  
> >  	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
> > -- 
> > 2.43.0
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
