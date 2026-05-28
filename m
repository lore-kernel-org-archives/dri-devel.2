Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA38CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB1D10F5B2;
	Thu, 28 May 2026 19:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="acrE9dIz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CF310F5A3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779995391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fakoTULzpL8x2UFOvAiDOqwXfj/NdneAEJE6VOYhXQw=;
 b=acrE9dIz84mtKM7TyaUp55feUYmgn5peCTNyOJIWI63Kti3iK+XF8PkAOQLiGesZSQmAzt
 1uAY7uq+viD1bDdTwqhXackvNSdMDNGp6B6lo0SSx0/rRA+s1XnkW1v3X/e7hkYxH5w5b7
 VtSKXOgLvIYDr+I5w/4fxvX02aGDIQ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-l6NQIijGPPiX3FyBv6IzBA-1; Thu, 28 May 2026 15:09:47 -0400
X-MC-Unique: l6NQIijGPPiX3FyBv6IzBA-1
X-Mimecast-MFC-AGG-ID: l6NQIijGPPiX3FyBv6IzBA_1779995387
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cce0957698so5002146d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995387; x=1780600187;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fakoTULzpL8x2UFOvAiDOqwXfj/NdneAEJE6VOYhXQw=;
 b=SIQ4Wn20WnO791MIFg/W1C9JsVj+TtMn3G/m36rLUtlW3+BckhQBm43b6N182c+/SC
 nXXOzFoIWCGyFq6h76tHFWvfigmG6qQ0Hc2OXUT7iRnzSA6HihebdYHV5b9KCO+/NzC3
 wg3vVelWt4NmoXz9iMuLGU8/U20Ax00irNe12jzxMLbbrCBDYzQwMaak6nhPTEIA96LB
 RiwY3n5IRRQ1Uol8+CDdqY9Lt8DpaJe9AwBcgJ6MfVi3AKEGprr2uAxJ+eP66vtD25gl
 Lq0ZtL1pgr1o/BZQjN9zzE7yNQX8+W4jq7Hmqg0wu1XpQm6tMktdYcsrA/TVP1dukGBm
 bNMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Uq9WLYFf9zdc5FsuFC6OniuGravoeT2zLzFEXu1WB6Ai+CvwTqLRYRrgyxPjKhGF2B+vM7saFf2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXdQ9NmlmLr71FYskppsiAeomuKggGZd0rFD4Lml4YJXh8PfXJ
 wmbgUTIWwCzpYsaxJU1pIdvKqTjb0mMMi2iZmjCAve/A4XS293TWQ547q3SvMD5HDRZz0ZhQxf5
 H+X2PWuqk3Ac1b6pxOTbtPGuM1FTASZ5BQ+SoNbVZzLFSenC4p0h1QohqqwbPeLHQ+w8cgg==
X-Gm-Gg: Acq92OHtWxBPbvyCSjYXjevYqLLqusKx+V9LQdaXxRFr8Zuqyspw8jjDGrO59g0fR8g
 MQ5oE1tzcDXwlKHHdUzJtGV+T8WlhJMCIpMuq7RZ7ucEYttT8xWxgjgLqIevUywjg+0F8V/jsza
 ZHDsTb9YVcKP6rWCx/aYrAn/G0eVcuN4GiVr5WMJ9gPbWOnrK8n2J+Bf6WiP1J+jmk6eeZ9TNhC
 fqFkAlATCZABpKlxdvcfg3r5+hgG4cK1KXRxMaW02MXOgrCiv9mPbJdjib+2wb9QiH4QfjiPA2n
 S/lAgCr3jNl3tViX98GVGJ94NCJQ6jO2L0Kj91606Lc/FJ8if7iapHOKM6wKQKZu/OdoI6WGfBl
 LCeTCjjyId/rLs/c0u9GMY0hG5YBa
X-Received: by 2002:a05:6214:252d:b0:8cc:1010:bbcb with SMTP id
 6a1803df08f44-8cce216ca21mr7628966d6.27.1779995387394; 
 Thu, 28 May 2026 12:09:47 -0700 (PDT)
X-Received: by 2002:a05:6214:252d:b0:8cc:1010:bbcb with SMTP id
 6a1803df08f44-8cce216ca21mr7628396d6.27.1779995386957; 
 Thu, 28 May 2026 12:09:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e2018sm211434596d6.28.2026.05.28.12.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 12:09:46 -0700 (PDT)
Message-ID: <c45c2e9096df0b407fa67ee5caee6b4641e2c8ab.camel@redhat.com>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
From: lyude@redhat.com
To: Timur Tabi <ttabi@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "airlied@redhat.com"	 <airlied@redhat.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>,  "tzimmermann@suse.de"	 <tzimmermann@suse.de>,
 "dri-devel@lists.freedesktop.org"	 <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,  "nouveau@lists.freedesktop.org"	
 <nouveau@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"	
 <maarten.lankhorst@linux.intel.com>, "zenghongling@kylinos.cn"	
 <zenghongling@kylinos.cn>, "bskeggs@nvidia.com" <bskeggs@nvidia.com>, 
 "mripard@kernel.org"	 <mripard@kernel.org>, "zhongling0719@126.com"
 <zhongling0719@126.com>
Date: Thu, 28 May 2026 15:09:45 -0400
In-Reply-To: <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
 <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
 <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r9zb58QQ_2f1W4zdOPiAeoilWSLGvyKHicJBfFw-S3g_1779995387
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

On Thu, 2026-05-28 at 19:06 +0000, Timur Tabi wrote:
> On Thu, 2026-05-28 at 19:56 +0200, Danilo Krummrich wrote:
> > I think at least this patch has to be reverted, it causes the
> > following oops
> > probing nouveau on my machine.
> >=20
> > I can't currently look into this, but I think Sashiko [1] has a
> > valid point on
> > this one.
>=20
> I'm not a fan of this series.=C2=A0 When I saw the number of patches, I
> was suspicious, because I have a
> hard time believing that there were so many functions that never
> returned NULL.=C2=A0 The call tree of a
> lot of Nouveau code is pretty deep, and it takes quite a lot of work
> to ensure that there is no
> "return NULL" in any code path.
>=20
> Nouveau is kinda sloppy in this regard, which is why IS_ERR_OR_NULL
> is used so much.=C2=A0 It's a safety
> measure.

FWIW: I already sent a revert for the last patch in the series which
needs a review, but I'm happy to send out a revert for the whole thing
if we want.

You are right - I did actually sit down and try to run through all of
the codepaths for all these functions, but there's clearly a number
that I missed and should have checked sashiko for.=20

