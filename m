Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12515C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5441510E41B;
	Thu,  2 Jul 2026 04:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cL811s0F";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1461D10E41B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782965017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kuaTEjeYBWxwOkgYoO9Z5VTdSu33mHKEAQ6hsmDBY08=;
 b=cL811s0FmW1iHDS93q1EbLuGFO+dRcNPA1e0NqrNRBNaDbLZuOnAAG8GDQE6Mzc7MkeFxt
 Es8Vn0q30xWL2S0OFrLO7dAyskQT9S5Q8D3tBEGkfpB9hZ2+V+NXv4e6PJAo1U6wXwBjv9
 KnZ3OI5nZYp8ClHUcfXJAf1lBrzCsz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-3XM3HyW6NxOIhUmvSl8sBA-1; Thu, 02 Jul 2026 00:03:35 -0400
X-MC-Unique: 3XM3HyW6NxOIhUmvSl8sBA-1
X-Mimecast-MFC-AGG-ID: 3XM3HyW6NxOIhUmvSl8sBA_1782965014
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493b21b1fe8so10590615e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 21:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782965014; x=1783569814;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kuaTEjeYBWxwOkgYoO9Z5VTdSu33mHKEAQ6hsmDBY08=;
 b=bNs6aT6w1QVm/Sb18HrobMY/Y7aJg5g70sELGLUdai9lDHWEw52zEpTqRyhsxUQtG/
 CcObUBGEpah0q3+XtUBsl+FeC2DsGAr5pUNlXcsUEy1dvQ8n2J8cCa2YW6Wk/2TBUamR
 iOE8NkKTnNYYfCDu8qQ0S7M5QoyfejcuxV+J3Xo4foutbBuPAy+Dh04+Xsa0V9lUDQgI
 eoz4dzfSqRkl1VpV6xdhSgG5JxS7cT0K1Wi0dZSbbWNJTbidRsW5HL/BiVg1bGNTPqhA
 1+Vt7fqJWmkj8cfKjQv3mSigBcFA0bJeVo3i55/y//RIp9Fu2qCh5rsAfRV5j4biSCLl
 /fjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UOr4ZZPSUv5RtPg9NGdTABBqV31fkLEeF5HDrhhNgZV8pbIRMfQx6PSWG2d/erAnNRaknO/xAXJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI0qWvAzG8Uo+bkomkwMo9STXbelqVk851bPpTvQYhdO/31pzP
 tFoVsT5dSfXTcZ6xnksVTVYdZFhGZ/T3Z479ywKjwc2fBbttPkiVZt9yPNSOQzr01V0QxeGzm/i
 OfyqzLLxg2WeM1GZug89NpS4myhCNSsZL2g8tHAR38s5S/QfIsFvRzHYjcmADuaga8r6VgA==
X-Gm-Gg: AfdE7clB/JiKKF/zkmbbgU0RioySP5hDseHunw8TrS6M2LH9kxmzZWe1fgR4KquZDXo
 mj40lKO5CEj14DwvPLqR7ewEatznbg9bIp4xQYT7izi5KC0BklHZFzx4vk/fhFyKusCWpBxwnUx
 FI+e2PdfFLQGZNX0ba+JrDIjNazZW20fp7PzChZztzuXrMKw28qoQftBQggdIQYZnOrLoEquB+N
 3uAjr2F72QhH/4NUG8W0dscxfEbeKnoD992z032OJ9jkGpUtnHa/4iYcpJgyF+J2ieUD2j9AWHG
 C5TDV99yYZxSDYKyIvDAP8hzvTlwkDCpdkiBCWUgIbpWSbA63uFtwzqFVeK0t4dGy7GfDSEQ2qQ
 tnLbNUV48Wbie0ijCfdW67RD3+pD4lQG7
X-Received: by 2002:a05:600c:60a:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-493c3cf8cc5mr31230625e9.32.1782965014440; 
 Wed, 01 Jul 2026 21:03:34 -0700 (PDT)
X-Received: by 2002:a05:600c:60a:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-493c3cf8cc5mr31230455e9.32.1782965013999; 
 Wed, 01 Jul 2026 21:03:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f8csm11868245e9.11.2026.07.01.21.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 21:03:32 -0700 (PDT)
Date: Thu, 2 Jul 2026 00:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Sergio Lopez <slp@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
Message-ID: <20260702000144-mutt-send-email-mst@kernel.org>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com>
 <akT1XEW766c7Imst@mbp.qyliss.net>
MIME-Version: 1.0
In-Reply-To: <akT1XEW766c7Imst@mbp.qyliss.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H3hkRx9RDiICLWVJnNaUGm4grSte_hRFz8JA--JGLoI_1782965014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Wed, Jul 01, 2026 at 01:10:30PM +0200, Alyssa Ross wrote:
> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
> > If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
> > aligned to blob_alignment. Validate this in verify_blob() so that
> > invalid requests are rejected early.
> >
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> 
> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
> crosvm bug, so hopefully it can be taken care of there.
> 
> https://issuetracker.google.com/issues/529852979

Move fast and beak things, then it takes a wile to fix them)
Do you understand who uses it maybe? Maybe if there's a PR
for both sides it will be handled faster.

> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index c33c057365f8..d0c4edf1eaf4 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
> >  	params->size = rc_blob->size;
> >  	params->blob = true;
> >  	params->blob_flags = rc_blob->blob_flags;
> > +
> > +	if (vgdev->has_blob_alignment &&
> > +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> > +		return -EINVAL;
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.53.0
> >


