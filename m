Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A48C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 00:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513DB10F112;
	Thu,  2 Jul 2026 00:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NMMXVho7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9352B10F131
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782952232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
 b=NMMXVho79QdNxss59SE8jo1HKEohYC0cedXO0bZDFo+5StgmkD0grA46h8rooYQq2+CEC+
 3/JXyKaBqXLvh/Wn1rzGVAugfOAnweCrfCZvggGUe8Ix3SdXLxP4lP7B2XqfcN5cK+/pGa
 HuUeyXnUZzIRKN9mUdyAFTWZkZnDtFw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-4C5LjmhYNdaGqgcs6j5Miw-1; Wed, 01 Jul 2026 20:30:31 -0400
X-MC-Unique: 4C5LjmhYNdaGqgcs6j5Miw-1
X-Mimecast-MFC-AGG-ID: 4C5LjmhYNdaGqgcs6j5Miw_1782952230
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c98136ceff4so1755588a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 17:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782952230; x=1783557030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
 b=gycvsdIUjaIgwbbtikanQuReXTFYvFIPADX0II8OpKDI3Dia2zin08AnhzGJdb1OOU
 trm7k3SxOUWjwPz6/FU1kJgRrhCbbiMbvix7pVCRILUfFmbpdYoAHzR/ZOuhDNdn+jdO
 YAsV6E/icVbUeLncIcF+NZqKe5vgB/0g7WAQ0MzfAZb6/f4H8A+fqE9pZnWyquwiYzOi
 0cmh1N1qVxZCZ4GKjlBgdNkVDfRB0jArxW2njzWpBNRT8GCjzG3MHdvk5xqglgUdNbpx
 C7yyoSFPcGdeYKpUpnxjSRkuihP9xfmE+/5DgAFITZ3Ndfv5xDlW6796yyOOtv7DAWsQ
 cQsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UXl57nQPn/UZa4TQAFd8EbamC8Nzfc24VwV2YDfIRiJg2dkgom7IEc83o6FVC+hLlyep1aeCKpqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGpgi0X6qivlOUrd12vpg5aAXqgENZqyhvbtz9VHj44fBT5EYW
 2LuDs+ms4078rGsmeJK4T0MqYG+tGW/yU9ptQ8D5c6I6HeK/zpiC98cjluCeJDmDlBKZE0esTyG
 n/UCcaYQi5Aw4NouJfZ7KajeyOdcKv8h+gVRjmyk0i96on9mrAdvAWFKw9rICdE0GHQagWt+2yh
 6QyVgPv7XbyJb0urcuKkXez+W4+UbqVm2sevy71nT8NafP
X-Gm-Gg: AfdE7ckv749rzohxNCMivBkcQJytMn0stLh/QllaCUDbbjQ25uZicGvtOvq5syWnCol
 ie6N5/FD3gEXvXVHj4wboNp6KEWVPU+lumZlxvT2PiiM9gHEFEd9P1wb4UDvk9WnZifjlDVS7FF
 DbjOKpi7BiNJJXRb2xs1IskI3tP0bdR3J1YtnhOn9f7yY9jpAqRKElwOlSTpheK+ld83nQedcTS
 lntP9Vakb4Xl+RKEgH1hQU+lfk=
X-Received: by 2002:a05:6a20:9188:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3bff428abb9mr3232530637.42.1782952229951; 
 Wed, 01 Jul 2026 17:30:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3bff428abb9mr3232455637.42.1782952229092; Wed, 01 Jul 2026
 17:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
In-Reply-To: <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 2 Jul 2026 10:30:17 +1000
X-Gm-Features: AVVi8CcxrtJSClXEO5FKdmTHOwuAtmkEnH-VE9hidyytnYNh0i2fFS2pSdVPCWA
Message-ID: <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Mel Henning <mhenning@darkrefraction.com>, John Hubbard <jhubbard@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: phQsH3nUETipnsoU_mVE4M3zdnRbhtus3HFI1HwMJl8_1782952230
X-Mimecast-Originator: redhat.com
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

On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> (Cc: John)
>
> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
> > It turns out that the only reason our previous fixes looked like they
> > worked for this was because we would occasionally set the Gcoff state t=
o 0
> > in the normal S3 path, which fixed suspend/resume on desktops - but not=
 on
> > machines using runtime suspend.
> >
> > The proper fix is to just never set this flag. Our current guess for th=
e
> > reasoning behind this is that Gcoff likely coincides with GC6, and not
> > literally power off.
>
> I don't think GcOff coincides with GC6, it should actually be a power off=
.
>
> From a quick glance in OpenRM, it seems that with bEnteringGcoffState =3D=
 1 it
> also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.
>
> My guess would be that with bEnteringGcoffState =3D 1, GSP's resume path =
expects
> certain kernel-driver-allocated buffers to still be in place that nouveau=
 didn't
> save off, or rather never had in the first place.
>
> John, do you have some details about this?
>

In nouveau we have the INST_SR_LOST target, for buffers that aren't
preserved, I wonder did something change between 535 and 570 around
what needs to be kept around.

Dave.

