Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2B4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BCB10EB9E;
	Wed, 29 Jul 2026 11:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BbI+Bqd4";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A137210EB9E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:36:40 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so5589735e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785324999; x=1785929799; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3HHsEhTl+dXCrOvrCFYw7cTGZo+aEqQqlvgUlbn4X4=;
 b=BbI+Bqd40az5qODpNc/XvZcA/JrJglNYWk0UA/hjoTIvVpDrmATurinblgLELUS+Sl
 u/KlMX4PyyCdD7wkDZ+wvCVuHRXClL1Im6FVHEHX9kI9cEqYowMoYU8F4yWM1mXQj1aL
 dqY+e8GBcT0dQDrGB6IgLdWeB283mUyN29GZ19aiKRdh4IwfSW8tsbB25yUWO+rLsbAc
 J8rML1yCmw9FLehSuZhxU4pGcFpH9yN/rJoeJV9tUfx28+UZP4SLfDmb9NZgG8tkDoJe
 xiEhwWjynsXgjn267RA890aQafgmslQA/j2pQFXvkjCI+FyexuGo0mvSsOCIx37iBbIQ
 2EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785324999; x=1785929799;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A3HHsEhTl+dXCrOvrCFYw7cTGZo+aEqQqlvgUlbn4X4=;
 b=cJe3OBei1SDCmz7zVaIrqu9g+jn3Z+PNiYRcPpX80Rwqcs8JZYYj06n7rq9xntvAMq
 nOjkP4bzx1sFOZBrcUrCOyBF6qnErhBmAJXjOkgroXhefWJEIkBlMxP/+tn0PcUE8U3c
 vOu1xt1QP0SOMKfZAKA0//O6gCwaVhDnZU+kk6C+j+42YEqO6yy2Fz3gmq5kurZC7ZR/
 f9wJ8AuiJHMDZLhDx+ClM/GuIkyEj7/i0uLyKGhD5jvC35XSJBfS1eJ2QDcCV0v9/He5
 UrHtOPe77zXkOgJmc1eNc8ngF9VPzTdTN4JCsEaQ0Q4S0TWg6TbGN+wxMUSD9kUieS3z
 CJdg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9wdAynZxhAx2rYGk6Oar4tvdysqMxvhng4OnbDJirHE0N04Khn0CEmy6u+4e2eGIy7Ii/5tMfcLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7b+Ubwn8MHCyxbFfxKolFs9HNcCl+uuvTPwowXiLHmNiFeLRj
 LNDskIALKOB9f3Aa7ZkPV5pSmh2vvcjtgR5nuadK/zfr8JtXa0FPH629
X-Gm-Gg: AR+sD12xVFztDJPGmpUKoLBgNh9gggclE7cSN5puSi90aj0iVFI/YlxEXfBgRPOZc4r
 vwWJE+uyC4MUrwb0yM7U85gUnBK5Ph/wN1HdWbIA7Jd3/fNQ9sb+Q6KyoLnTHTGautjqmLhULSR
 hG0g4qOsBNq10F0Ui67BFFmnNqvTs5Zus4oZj+Q0Wp1loiW3tXdEKu7CyZKdrSSF5G1BDz7OAmI
 azpLaSD8pJVG04Orv8nQJKRqPXQycrfiQT18VM8+EavwtVU/e8D4YDZ50bcZuxnv5Hau/xxa53S
 P5MPOKAoVNoU4JkPSHnOJRe2DVWpFsQOLRJvbx2zaCQJtKjJMd7mbjHKeS9pQUrxOu8a1r5Y+Gk
 onfRqvucibF7w8JUEmNWLColb+gY/GGp1i0TXj9Ucy1onf0oo9WLjdg84vWwCchHa+qkj5H4UAI
 Bp7a0v2NHzMnuDTKReh1db269GtCp9I5/JwL8BE4ISMMaTRsDc1+k9rPr+CJ3ChaHWXYiTvudx2
 g/rEI6L8yJt+kgljDjp915WCDoiNORXNg==
X-Received: by 2002:a05:600c:4e8c:b0:495:4730:15b2 with SMTP id
 5b1f17b1804b1-496c6571ea4mr64839705e9.31.1785324998773; 
 Wed, 29 Jul 2026 04:36:38 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:2975:f35a:5252:318b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af19bsm145526535e9.3.2026.07.29.04.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:36:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:36:35 +0200
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
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
Message-ID: <amnlw_HGWX0YHMWV@osama>
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
 <amjG9WVZrb6v92_h@e142607>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjG9WVZrb6v92_h@e142607>
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

On Tue, Jul 28, 2026 at 04:12:53PM +0100, Liviu Dudau wrote:
> On Mon, Jul 20, 2026 at 03:44:35PM +0200, Osama Abdelkader wrote:
> > panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> > control interface offsets with 32-bit arithmetic and the size of the host
> > wrapper structures. The offsets are derived from firmware-provided strides,
> > so the arithmetic can wrap before the bounds check, and the host wrapper
> > size is not the size of the firmware control interface being mapped.
> 
> How can the offsets wrap with the firmware-provided strides? It's not like
> the firmware provides arbitrarily large strides.
>

Thanks for the review. Yes, It's unlikely to happen but good to have,
these patches actually address issues reported by sashiko while reviewing
the first two patches regarding firmware sections with oversized data and
truncated firmware.

> > 
> > Use 64-bit arithmetic for the computed offsets and validate against the
> > actual firmware control interface structure sizes with subtraction-based
> > bounds checks. Also validate that the shared section is large enough for
> > the global control interface before using it.
> > 
> > Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index eee2bc7e8541..e2fcbd639c3c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
> >  	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
> >  	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > -			   (csg_idx * glb_iface->control->group_stride) +
> > +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > +			   ((u64)csg_idx * glb_iface->control->group_stride) +
> >  			   CSF_STREAM_CONTROL_OFFSET +
> > -			   (cs_idx * csg_iface->control->stream_stride);
> > +			   ((u64)cs_idx * csg_iface->control->stream_stride);
> >  	struct panthor_fw_cs_iface *first_cs_iface =
> >  		panthor_fw_get_cs_iface(ptdev, 0, 0);
> >  
> > -	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
> > +	if (iface_offset > shared_section_sz ||
> > +	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
> >  		return -EINVAL;
> >  
> >  	spin_lock_init(&cs_iface->lock);
> >  	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> > @@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> >  	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
> > +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > +			   ((u64)csg_idx * glb_iface->control->group_stride);
> >  	unsigned int i;
> >  
> > -	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
> > +	if (iface_offset > shared_section_sz ||
> > +	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
> >  		return -EINVAL;
> >  
> >  	spin_lock_init(&csg_iface->lock);
> >  	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> > @@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
> >  static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  {
> >  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> > +	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> >  	unsigned int i;
> >  
> >  	if (!ptdev->fw->shared_section->mem->kmap)
> >  		return -EINVAL;
> >  
> > +	if (sizeof(*glb_iface->control) > shared_section_sz)
> > +		return -EINVAL;
> > +
> >  	spin_lock_init(&glb_iface->lock);
> >  	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
> >  
> >  	if (!glb_iface->control->version) {
> > -- 
> > 2.43.0
> > 
> 
> I'm OK with the general content of the patch, so:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
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

Thank you.
Best regards,
Osama
