Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D606E1094478
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477AD10E116;
	Sat, 21 Mar 2026 13:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OqeQrTcq";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BF110E116
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 13:57:40 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-64eb7def21dso492442d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 06:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101459; cv=none;
 d=google.com; s=arc-20240605;
 b=J1lLsZ2alTei1xAWlZAboI3zvR1qqYWPk8A7W3qS76unUAJlRgV40ywwbn2SnxtXFS
 D8gr+3BSvm1ZB826DA0D+xdv0t60sX5RPVIC4DI/O8ZlP2cfG1orSgG/hTAs3Tyti9TA
 5NolyolFaj/O62blyRY2hhA33XFkhvZIRTScR4Wta2opXDmkugXYz70kHteTIDiWGpOB
 jXlAgFUChmKGMDxwjLRrfqyEnUaWKb2KZpNDFlda+pzydtzbTv7z9jiUWNJ3LX/KXBbf
 DRaMNSK2hh1KIIZB2A3ywy/B+erL2IQFcq3OA25wkUORDoizwVpFqiqrx36szZTA8MkN
 hkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 fh=CuVar36KxD9ZtnQWzt9J0i2oVQVSL1c/QXkicZKHT64=;
 b=aWrqWvsaT/W4/+dS/iAkwFKrJFg2SxnrnlywvXmbmo0VKDNJ6El2rQr5VtfnW3ptlA
 GkTHR4MxtWHEHMQawvdR++7HJfDYRwdVPgf078ECHT7PgOUByYqYyquwmjphtjVrrNuJ
 IXgMDxppgw7AEqfEVn7ylbFVfZNcfNJIR/qon+8iAG3RyQzqtFILeXenqbOoVKa5xK5r
 3oy8V3I6eV4ijMblUO8uoswRpDmQza5wznfvr365AsFYQca4+ZaTDDiYNFI9rPJLNG6F
 5MQ9yYT3+2Mfa3aUuxKX0mau/HgFIMnDWwVWuf3QvknJK4vmcmqfBLKBAixRcx/mz42m
 yDWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101459; x=1774706259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 b=OqeQrTcqmyAZMuF7te2GIi2jgApHZUeIQUgcOhD0oO2uukKIicevUW6xk12BtY1TSj
 WK8kDMu0WRhmyFtp5qcpnMo5iLqnfzNbZGli36LgLD3Dsncj+aNZ5Gn7sP+BxXRREeRM
 67AXiv2ll/lWX5f2/XYIeXzw2NTbs2ukLuyyU10x9egZLubwP1J1jEnII+3YAEOh7uOk
 P5KqSmTxO65mDxZtkgq+QNxDjoXVS0QaaPri5lEKODVPzykFSe8Hu92kACp4TN9pUKzg
 PzU4Q/VpwKufC5HHzu2D2xgaqbOCh3Cz74b8pDygtOK+oQxBf5DbGYVos9Ofy2T6n1bG
 51Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101459; x=1774706259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 b=gmfzppv8tx/yXkdvmB4rKyIV4J1fpNKE8O9XfR9d7GEdsW+DMglBrV6F++cayMxjkM
 JnhiY4UzZvcl89yCG/OF/oqoz/xlO1d8KzDTZLA7ZunkbDCAd1hJ4Ha398RH0ObYkVFm
 ko7aXKygBsgsex0rB/v0vqcmCdhXdG74wuESA8oMxV8RM0T/n6C/YWsyinHrxR3x4tg0
 bz/+S22f5em/At2sOXDJ690/E/emj3M3D9P448BUpqLokYaG33R6yfY5M95z8Ytyc3wH
 lvJEtiAM1hoqLC/mqQ+v8aJ9h4QBQT7LWFPqBPp+aW8vx5l/RSsRbr90KX0Qq4Osm9PN
 NfVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMlW5hyQAepvcihUZ8czczQ87ICVIXA6rZAHiKZayIpoLyXQE7/486aABKj4mbSBn06RYgI1XmobA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxO6C7XFeSawKALOlz5Oodsa4MoOIQzt5gHPt3NvzR0U8FjXGiv
 7qBgd19yY0A/vYbnlq/SLr+csMK17QNXoTo3waZMjade7ZNTR2iF4qQMTByDjPKrc13yLo0dK1q
 b2GslFOXCGKtxjwz9sAPTENER2HnH3zc=
X-Gm-Gg: ATEYQzzmL1z6TSeQ7qzbSMvD7EvUBBD4FnpSAM6cpUPk0pkpZgn3NgaalgdJvT96LXl
 yE87cOER+kmS0DNGU609JPVjbOQfVSc1Zm5RqDAvLS4SSHh6e8BezTSZMRrIHMqV8fbkxYRM9aX
 B7LktijNnQgVsVdIrPh+x+K8jRbE/QpnOESGxPNAcXHmeM/4BGnPZvEnVzPKg3+JAPHHgYDFuF0
 Orj8ZlQsM6qTRVsNVX1ulSmMnBkd9s+4Zq7Ve5sd9Wvp9iG7tRIX7oLU270aVy0doQyoDKBp9ju
 I+s8
X-Received: by 2002:a05:690e:430e:b0:64c:973e:874b with SMTP id
 956f58d0204a3-64eaa87157amr4846578d50.75.1774101458924; Sat, 21 Mar 2026
 06:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-64-jim.cromie@gmail.com>
 <177402491483.6181.11788631907510647484.b4-review@b4>
In-Reply-To: <177402491483.6181.11788631907510647484.b4-review@b4>
From: jim.cromie@gmail.com
Date: Sat, 21 Mar 2026 07:57:13 -0600
X-Gm-Features: AaiRm53vuyc7die3mB1r_bZxe4JdiA3Dmzfd_np6AsN6-8INJ152fSJj4AtuU3U
Message-ID: <CAJfuBxxOS7zohPDcgDAPmGBXyY8yGOZfkU_-V=5r-qXUBcpo5w@mail.gmail.com>
Subject: Re: [PATCH v11 63/65] drm_buddy: fix 64-bit truncation in power-of-2
 rounding
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 20, 2026 at 10:43=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:20:28 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > drm_test_buddy_alloc_exceeds_max_order() uses the on a u64 value,
> > where they silently truncate the 10GB allocation, giving unexpected
> > success in DRM-CI.  (see below the snip).
> >
> > Fix this by replacing the standard macros with safe 64-bit
> > power-of-two calculations using ilog2().
>
> This is a general DRM bug, if you send a new iteration, can you move it a=
t
> then start so it can be applied easly?
>

Yes.  I also sent it separately so it could be just picked up.

> >
> >
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index b27761246d4b..ff158cc1d27e 100644
> > --- a/drivers/gpu/buddy.c
> > +++ b/drivers/gpu/buddy.c
> > @@ -915,7 +915,7 @@ static int __alloc_contig_try_harder(struct gpu_bud=
dy *mm,
> >       u64 modify_size;
> >       int err;
> >
> > -     modify_size =3D rounddown_pow_of_two(size);
> > +     modify_size =3D 1ULL << ilog2(size);
>
> Thanks for catching this issue!
>
> To avoid this kind of issue later / in other parts of the kernel, maybe y=
ou
> can change the macro itself to properly handle u64? I am thinking about
> something similar to ilog2[1]:
>
> ( \
>         (sizeof(n) <=3D 4) ?              \
>         __rounddown_pow_of_two_u32(n) : \
>         __rounddown_pow_of_two_u64(n)   \
> )
>
> [1]:https://elixir.bootlin.com/linux/v6.19.8/source/include/linux/log2.h#=
L156-L164
>

I will take a look, but if you have an itch, dont hesitate.

> --
> Louis Chauvet <louis.chauvet@bootlin.com>
