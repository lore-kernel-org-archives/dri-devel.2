Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354AAD35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E3A10EF4E;
	Wed,  1 Apr 2026 11:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="DUoZlh8z";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA4810EF4E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:43:54 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-899a9f445cbso76698896d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775043834; cv=none;
 d=google.com; s=arc-20240605;
 b=Hna3q8jaaA3pOc4x4YuJ2ZYSfB5CyC9ksWi/e9m6nwLWA6+wprh8xuv/7nEkxWTPJm
 VwFDp7R1TvvJKh8MDl/1gcefjcOmFShQ/hzvE6SbvTMzCq0/WwwGbP+0hQsxnJLt35BL
 FiXYfaisuF4Tjujg77RP9RTa2YSXKrzd5xtCM4hM4q7p3CV3sqtJoMeqCrA7HpWQUg0m
 8rWGnxz4Ipx8FKq5ydx9ir6+RwDCZ0FLcWf4BqzDIGtXx/+YK0m+mvOp7LMkY+YJyq9c
 QUAc7DWG0Q/8nXPJeG94LHIG3d2CnknXDLGjL/wVjqT+5nNsgpEgPPm3RLbzCu5NDuov
 QOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 fh=jBwuA0OdNlFrqQIQ/g62lUKbQbRcxqF81PwZlK/ko4Q=;
 b=MRoDSbeJjhq6P7AZk9MCebjnsG4twloqM9qTDJagr9t8gvLtrR5DpOge2ll3YywPGJ
 Tjm09R6AFBBwZfIgwVwKLdhA4V7htrwd2tzOBYhSnqEJ4sOpg9i0o7Kan+W0Py6co3U/
 /G77FQE5H6uWk8lRVZNupkNlcS3I/DcLDvyFaINrtK1W+NJuSJQgtkxVcK4xHBCgV2VX
 QRfZifva33eW1obTIDS4+umCnRRu4GFSem/7ittOQ/J+CQA1iuH68i8zIAGMcHEWYzMq
 KqkBR5doEyszP1GsCDguhKNcscv7sReGZu3haQ6T+Ni+kD757wIzG5604M9QpMxlf3Bu
 66bA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1775043834; x=1775648634;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 b=DUoZlh8zCUx2NTth54uUu3vi0uGOax58ZQg+0GvfyrB7ZZWzWJ/IgCSwkQE7ww4k9T
 a1r0ACN1Y/eewhJ6qOk0Yhwx20GIIkLoXv6/Z3VMvxw+UHnhqB8oBQuOJ0ypIs2QpTKo
 /OR6A2mqi3fh64YYPwWkdoSkZZLRznRn+srrxlMpLpU8zyluJmM07OKwdzDunjis0eT0
 wQQ21XrYEjbPM6XKTXxjAig7Km63GGukIaxzjE6bqr89IQFewddXlBMoRMPgaxMfFTub
 I/eGIm7HxSESv9Xd/AN/b44KKmo/qOsFdk396S8h06o3gIo/BJx83Zgpb67X0eNZ66qD
 PSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775043834; x=1775648634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 b=bXxaiIqEHvB6DVFRJXipG7h7xdEPiyhfWUWs1LClclpWTyYUPsa3SiBkQo6TL6BJ/o
 uLA5XjOKzu+3aMErkdgUh5jmLNv+N78ppAOU7IXjCy4Kj+XWEpaxDPKTitNq7MGR8vtf
 rHAOA5GvcyoV8+3VbHBjcQGvpR6smC5wvP7jHrOE4El9EKVCbVPjLP7bGLGkgFrpPBj7
 T4bvKOOgdYKTZlDNAZ4MhFPDrMny90liupVGbg0rxrJa3uF4YlFkfnRh5rPDCAi0ASB7
 vMB6RUr8n30WP34CM+BdJD20YcR7E/3Eixqqt/NGddQiX1SAYZwv1Ck6gGUnGhB2xvka
 gA4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCM8TS1/MIEmZ3Kt4xICFNKaS6KWoYa0fk5KmO+boBb5HzpXt+DKGzGXkUgsU6wEv42Q6YFppyKZo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYW/2WGULYqwRXXoZeVAS4NRyoG4z7qFKE5VoiiBQcelzi7+np
 TqRqPKSj5fU1JJjrpFrc7NCPHqATjSA512j/nREYy/iZZJtnOa2DcgYrw+yibk7iPo/H1BEHfHv
 yWxmcpW+WfD1AzJkN3nfcJMNKg25qQPYg3Hq8yfC2Mw==
X-Gm-Gg: ATEYQzycUxhLly5yd03+G2mEDDjDD+s8NosoETeMI1H1xmFbQNvRUXBsYWWNisLiA7N
 OJKU5de1bUSXH4KYhIPpXPznjWczvUr2EOEjBLs8YedoZ5tFeMDK0YWzzrX1rTY3mRlLwyBETOS
 huzcXdxQ2Azd0q6LWlcmN+y0mNxGnz3K4Eff9gvlqa6pfhUP2XHJYQQIqjlxRGzKdM40iW77Let
 G6KM0wpXim8rqMnnixkmQKK8QaqoGmtho61Zx2HGCFqTb+XkdcB6dOa3ER2inzbJad1BsB1Bmm1
 aCIQZOGXNbAP/zxk5q/LpGOyp4I0pzxbKyxLtYJWpA==
X-Received: by 2002:a05:6214:6017:b0:89c:e38f:6b6c with SMTP id
 6a1803df08f44-8a436a1fcd9mr47907356d6.3.1775043833750; Wed, 01 Apr 2026
 04:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
 <acz9H5RtaGUUx6Cl@intel.com>
In-Reply-To: <acz9H5RtaGUUx6Cl@intel.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 1 Apr 2026 12:43:42 +0100
X-Gm-Features: AQROBzCdXxrvf8UgyLJsezxbKvCf1uhBJ-Iz0urPdALgrRljTD4OL7pKkrh1Hr8
Message-ID: <CAPj87rNTNT9227TjrqmDOY6-TNjvuGJTDgjBXF3467Ea8vwzYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
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

Hi,

On Wed, 1 Apr 2026 at 12:10, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Apr 01, 2026 at 09:40:15AM +0100, Daniel Stone wrote:
> > The end game of this isn't Weston logging something to stdout, it's to
> > surface things to userspace so it can guide the kernel into making a
> > good decision for usecases that may not be ones the silicon vendor
> > decided was 'probably the best thing' however many years ago.
>
> I think the problem here is that no one even tried to make a
> real userspace implementation. So it's very hard to judge if this
> new property is actually usable in the end, or if it will just end
> up as historical baggage that we have to carry around forever.
>
> IMO just having userspace log what the kernel said does not fulfill
> the "userspace implementation must be ready before new drm uapi is
> merged" requirement.

Sure. To be honest it seemed pretty obviously reflective of 'max bpc'.
Derek is working on a Weston implementation which uses 'link bpc' as
part of a control loop with 'max bpc' now, which should hopefully
satisfy that.

Cheers,
Daniel
