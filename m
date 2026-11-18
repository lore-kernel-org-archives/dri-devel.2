Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDA606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tagirov.ch header.i=@tagirov.ch header.a=rsa-sha1 header.s=feb22 header.b=K3P5IJpq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B72510FBF7;
	Thu, 19 Nov 2026 07:48:42 +0000 (UTC)
Received: from tagirov.ch
 (207.201.164.109.static.wline.lns.sme.cust.swisscom.ch [109.164.201.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B1210E11A;
 Wed, 18 Nov 2026 21:24:08 +0000 (UTC)
Received: from mail.tagirov.ch (localhost [127.0.0.1])
 by mail.tagirov.ch (OpenSMTPD) with ESMTP id 737047e7;
 Wed, 18 Nov 2026 22:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tagirov.ch; h=date:from:to
 :cc:subject:message-id:references:mime-version:content-type
 :in-reply-to; s=feb22; bh=D/cd8y6iFDyqQkbXV0QUHE6xz5c=; b=K3P5IJ
 pqJq6hwJveckYe+t282VO9EzC3ERhd8UFLFUTr1NjbZ4LjjFfqNw2CFz+txm0BEA
 meL7VF0mVsZiwuVYcE1yxwk82pcIbwMIv0dA1dVkB/j2j4xkt3pbFVrytXs9jSBb
 kQUpId0EzgkSi0wXMEURIADcXPHt5C+N39WxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tagirov.ch; h=date:from:to
 :cc:subject:message-id:references:mime-version:content-type
 :in-reply-to; q=dns; s=feb22; b=iD0cP4AXxrnXwwnQd0604mdaiwPHu3yS
 dvNRaONbdt6f49W6ciepRVSEyfhH4SzoP2KxtG5XNGCrlT028636Hq5S64gMJGfV
 0CnjdUeU1bCBB3bqEpGuZoFIqCyu8Z9ZkI5EiCKpt14TNaipZOjl3hqIZKnypYbC
 l4J9VMPnKjE=
Received: from localhost (mail.tagirov.ch [local])
 by mail.tagirov.ch (OpenSMTPD) with ESMTPA id 895dac3d;
 Wed, 18 Nov 2026 22:24:30 +0100 (CET)
Date: Wed, 18 Nov 2026 22:24:30 +0100
From: Erik Tagirov <erik@tagirov.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] drm/msm/dpu: set possible_crtcs on cursor planes
Message-ID: <av4Xjn3duCXQ581K@gateway.normienet.tagirov.ch>
References: <av4OfY5sML97l2F_@oasis>
 <7jyydebmplngfnie7sfidwkeomi4xrgaytey6522q7qqsybg47@obppph6ea4ta>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jyydebmplngfnie7sfidwkeomi4xrgaytey6522q7qqsybg47@obppph6ea4ta>
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:22:48PM +0200, Dmitry Baryshkov wrote:
> On Wed, Nov 18, 2026 at 09:47:42PM +0100, Erik Tagirov wrote:
> > I am using a lesser known wayland compositor that uses the possible_crtcs field of a plane to detect
> > which one to use for the cursor. On the Lenovo T14s two cursor planes are created, each with possible_crtcs set
> > to 0xff. Which from my understanding means that they can be used with any crtc.
> > 
> > However, the compositor picks the wrong cursor plane which results in a lag of ~17ms
> > on each DRM_IOCTL_MODE_SETPLANE call. Making the cursor movements sluggish.
> > 
> > After some investigation, I found out that this is due to the legacy_cursor_update flag not being set
> > in drm_atomic_helper_update_plane() which has an impact in msm_atomic_commit_tail() where the fallback branch
> > is taken.
> > 
> > The lag is solved with the patch below.
> > 
> > Best regards
> > - Erik Tagirov
> > 
> > The cursor plane must be used with the correct crtc to ensure an
> > asynchronous commit
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > index da3556eb6ecc..4e0e9c2d8062 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > @@ -877,6 +877,9 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
> >  			ret = PTR_ERR(crtc);
> >  			return ret;
> >  		}
> > +		/* Ensure that cursor planes are commited asynchronously */
> > +		if (cursor_planes[i])
> > +			cursor_planes[i]->possible_crtcs = drm_crtc_mask(crtc);
> 
> Here you are setting that the plane can only be used on a particular
> CRTC. This is not true for these planes (even being cursor, it still can
> be used on all the CRTCs).
> 
Thank you for the quick reply, I understand that the hardware supports
universal planes, so this is not a good solution.

I will see how I can solve this from userspace instead, need to look
more closely at the DRM API maybe there is another way to determine what
plane belongs to what CRTC.
The current implementation does not work, because the possible_crtcs is set to 0xff
and the compositor picks the cursor plane that comes first in the list which is used by crtc109 
instead of one used by crtc108. This why the legacy_cursor_update flag is not set in
drm_atomic_helper_update_plane()

BR
- Erik
> >  	}
> >  
> >  	/* All CRTCs are compatible with all encoders */
> > -- 
> > 2.49.0
> > 
> 
> -- 
> With best wishes
> Dmitry
