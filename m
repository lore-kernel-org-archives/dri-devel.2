Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C8103E19A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35A810E857;
	Wed, 18 Mar 2026 15:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="Er61krbc";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF9910E855
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:05:33 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 199053241B4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:05:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1773846332; bh=WM60fIRXtZi3AvzEk1cKreMZ/TW2mI+YcbmNPgjc66Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Er61krbcZptN2/BXVwr3gjDVJn8tUoi+2w5OPfUiKIsSH6ydZm70JEWgcSxLHchjc
 b0N5w7o+WyJma/EDehW62cXVl77+9SSni6+VCimZ74Qcyoa+2K3C8gXXqbam19lfCA
 7+DvseniiKusidIQZFfP5jhIa6VpONYs0gAwUriIkWzxDVdNtenzu0UiBAmzo4ZZhZ
 +mVGujWm3KTVgruZ4ULpbHB5vp1NOMhYnISvtPZ94yKdH5m0PIPfdsd6vYDjhKPsQK
 XYT9Pt9mnUzl72vgaqpfjc0l94k5fS3722Ofm/XUqKs1bo8nx0424FlcwJ85ayjV8y
 XeGMz4cMJ68sg==
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so14231d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:05:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdN4DSjcB+6kqydPJbOseols/V6wVxI4lrBWt6wLCrYp9BD07utQyyMIVKJ1AdnrnnWF+uWpR+LlM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEbKpb3WXrPZvDh00JOGoOI0qLmEPTAYzSssZXPCg+CnQ3eb/A
 /u0FHsTTXD+9DWe6mgeEI9XpHH8BFfBhWmCwu99OfDPClNRzK7GiYpLWpLzECmB9aLw9UgOTd32
 KIxcl7jIldygYGXOU2SHKJbF6/FhlI44=
X-Received: by 2002:a05:690e:23cf:b0:649:d468:f79f with SMTP id
 956f58d0204a3-64e915c74b5mr2684217d50.59.1773846330156; Wed, 18 Mar 2026
 08:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-atomic-v10-0-f59c8def2e70@intel.com>
In-Reply-To: <20260223-atomic-v10-0-f59c8def2e70@intel.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 18 Mar 2026 16:05:16 +0100
X-Gmail-Original-Message-ID: <CAFZQkGw=VJnzFWnh7GT_59NhuSTiy3-VPOcKdWTZX14rkgW_uw@mail.gmail.com>
X-Gm-Features: AaiRm51rkDId2UF8kdECNIRPUwp9vR45i-ie2wDzuOdRk8LoSU1037TqUxrjWRo
Message-ID: <CAFZQkGw=VJnzFWnh7GT_59NhuSTiy3-VPOcKdWTZX14rkgW_uw@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] User readable error codes on atomic_ioctl failure
To: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
Content-Type: multipart/alternative; boundary="000000000000652e3b064d4dc816"
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

--000000000000652e3b064d4dc816
Content-Type: text/plain; charset="UTF-8"

Hi,

I now have an implementation in KWin:
https://invent.kde.org/plasma/kwin/-/merge_requests/8991

One thing I noticed is still missing is the catch-all case / unspecified
error; the "invalid API usage" enum value would be quite misleading for
that.

- Xaver

--000000000000652e3b064d4dc816
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I now h=
ave an implementation in KWin:=C2=A0<a href=3D"https://invent.kde.org/plasm=
a/kwin/-/merge_requests/8991">https://invent.kde.org/plasma/kwin/-/merge_re=
quests/8991</a></div><div><br></div><div>One thing I noticed is still missi=
ng is the catch-all case / unspecified error; the &quot;invalid API usage&q=
uot; enum value would be quite misleading for that.</div><div><br clear=3D"=
all"></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"=
>- Xaver</div></div></div></div></div>

--000000000000652e3b064d4dc816--
