Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5E2CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F281410E75E;
	Mon,  1 Jun 2026 10:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="D1BzJoW1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E862F10E75E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
 b=D1BzJoW1QrTNa3quIfK/fBkzaVAKXEqGng7o8JtD8uwbTghyYEfzOqt4NCEY3wlg0SxLOU
 urb7yuOay8RQbrdPBHW+Kv/D3XF2ajhLW6+1BwfUJuJbwtWho3ofmJ/9xre43uPV11R/ln
 cRw1taIAEVtfEeB2cEreHBf8bHp2rKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-T-3cPkCCMh2CLUsxQhAV8Q-1; Mon, 01 Jun 2026 06:20:01 -0400
X-MC-Unique: T-3cPkCCMh2CLUsxQhAV8Q-1
X-Mimecast-MFC-AGG-ID: T-3cPkCCMh2CLUsxQhAV8Q_1780309200
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46010392f89so642758f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309200; x=1780914000;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
 b=r7U6BvvHNV7+f5EnpR1WZNQQlvArB/AtI4PmVsG2Q1vbQdlGfrKPNDeUOF90vvtaDb
 rsVRCDNGIS1BbMqO/wkMR1vR3b5W3LFrduyNjQ6VyO391RkJMFfxHfr2m7qryP1CYega
 ifMkUbpT0ZA1L1DZi38HhO6viWrVMfbbpZgkM4R09r+3GzwHdq15iVmpchJfxA4jjdLG
 BPLBXILSkymlMotsuPkHfu94OfyGLcTMx+9uSJt4hy7M2tWjm76Ic5NEGYpiZZ1I+XYt
 VP0gUE9ZQAi9tsuK5DrEC7F9jjeEKvj50P3QPs1P4wQ21WslB0h3ngFt8BO4dzbucunC
 cU9w==
X-Gm-Message-State: AOJu0Yx+n22tYil/bqEc5thpPCIEdhLNrHJJVQjxpHS8oWzCvURqpt5V
 Pj8zMTplRika3hQ60O/xHHOtDGOs5fX6+4V25gr1/y5JJ2ln3iVu9CqclVHn7qEQjl1IXKhDWTy
 iCbU+GzhHWGPMdSpfVJVv1DlEysLb4RyEJNPVGD1rUOd5jrs9NH4eRREeVVUM1Y/7Gr3EEA==
X-Gm-Gg: Acq92OH/ct53DT6AfUxFNq/PHrwG2hO30YrpWQzxUCVKFdCrs2AKSVJXCevgTNk5TJn
 qcn+Ltd8YIfL50HkZBC4SqQKbdJVeldOLRCCAFwbxLaHPcksfMZLyPRoG1t4aAbtVL2ZULPbNKY
 jrFEWXIhw8aUu+jQUdq4DA+GVc5cDpVernTUZzZWWfhTePlFvZh1kyOuBxiKep8U9rmVY8QoMnr
 IN0eI5U6IdpBMkLdmerkJmoQq1FiXuPX3rY686dauyVYCQqsxJrjMRDsMV/UEqjouu09nxYTRuH
 W1fcJcJUPqWCFn1Z+8KzLQhjIHgLd24nKmmX6+1HIkeHBDJYveYAvit4/7mSTo+7mRyWmeLRxSg
 U6HI3LjwQm3PlowaaXzAxDQFNPwh4zqgbU+PsIZ9mlUmJ97pW4Y5ANCDFSOWbnZWlKQSUjrVIQH
 mHjAtl3axQMhcGaDY=
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-45ef8d0d485mr18400675f8f.25.1780309199700; 
 Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-45ef8d0d485mr18400611f8f.25.1780309199267; 
 Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm24570236f8f.17.2026.06.01.03.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:19:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 02/10] drm/atomic-helpers: Evaluate plane damage
 after atomic_check
In-Reply-To: <20260530185716.65688-3-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-3-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:19:57 +0200
Message-ID: <87v7c2lfzm.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H-IqnKj4ZifYAYUFcp20UZkPAePw6ELhxNEl7FOo0r0_1780309200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Each plane's and CRTC's atomic_check might trigger a full modeset. As
> this affects the plane's damage handling, evaluate damage clips after
> running the atomic_check helpers.
>
> Examples can be found in a number of drivers, such as ast, gud, ingenic,
> mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
> Ingenic even re-evaluates damage information in its plane's atomic_check.
> Doing this after the atomic_check helpers ran benefits all drivers.
>
> There's already a damage evaluation before the calls to atomic_check.
> With a few fixes to drivers, this can be removed.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 51f39edc31ed..4c37299e8ccb 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
>  		}
>  	}
>  
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
> +		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> +	}
> +

I wonder if it's worth to mention this in the drm_atomic_helper_check_planes()
function kernel-doc comment. But regardless, the change makes sense to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

