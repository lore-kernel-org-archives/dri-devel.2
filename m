Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5A7C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D690D10EC8D;
	Tue,  8 Sep 2026 15:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnqlzLgD";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7A210EC8C
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:15:49 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2565so890232a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880549; cv=none;
 d=google.com; s=arc-20260327;
 b=cYIS1GqLersKR/gPrjv6pBumfqt6fWZF6XX1UOAxDr4JgjM3cnCUuo+v8sT9djXOSb
 XqbR4XwckhtYnuWGGGEtGE4zM0jBppSqri+LoMugr8vrB+ZcoFdhbygasNahgVxuRBya
 aILyfwz3uBSWyQYirF0GZQ0DcRIUPnxzfleyqbIi5oUGopt5waKL2co1fWCZr+NABfsF
 ehnW7sfm74jNyxzSVEzCgGn5wIJlbETuH3hnNgUKeWY3QBtmqUg5LgfC3b9E5FIWdOeI
 0UUXRklQmgGgZGv5oovjIUH3XvzkJvxNPA+fL21Rmcnfswop8Hhj1JN7hNqv0OqTrFS7
 aUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=48I/5ZV3M8PQW+Nd+AVAKmbCj8LyPvNeg4eQe0wKYGc=;
 fh=brNGvRGyfPgRbea79DglDujOFrtkpwRQpkKZXpPHBGM=;
 b=lA3btG22bHAyyAccJcGo2V+jeMG1C64GUD1DETFpktonbzy3804P1Y2v1h+Rvkb2zT
 c3sQnmHvQAUtki0OrFluPqtTLQgWKO0HdV+Ur4F/olKzqvdZp4h4sbTvzF39JaVWQROd
 MmsA3Ho4ehC2Au4BYlfPzcapF+2FLJA03oP9r+oXZQRs+rNgGZ5r7Rji42OdnVTqtm+f
 kmQKIHIh2NHJtIUzJephRZPrsBB7k1+g/xTGMidZKmzfUN/pf3ra6oWPhBu9WpxYkcla
 snSuRUdIc82bCAWlbgBe+8ORCFTEWQn4WLROT+xc+SO258BlOwUvjvM0nktEwk4Kf0Ti
 xXJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788880549; x=1789485349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=48I/5ZV3M8PQW+Nd+AVAKmbCj8LyPvNeg4eQe0wKYGc=;
 b=nnqlzLgD9SjelP3hoxqoMhP9omORu3KQXiKGr1wKJoVzOFfHzoo38nxHtV5aQ+smJV
 tOFguYiqSnI1U5jwggyMJVT34pU65DyA3ZLB9jYfiaWCLJMFA7jd10QYLumTszyE7Gdf
 JdiWVbfggU+S5yASECkpgF9rRVemr6Q5MLGbmeCA8QvloFOlSiP4if6sxpr3w/b0R+32
 7ZG0/3Ap/6TFds+lMOmZszYTVdfGkaChhJGV+peafCXCbcrSpoMyForS5h+i9AaEIUQ2
 s7pFCs1eCu7hxCWCj4Xz/bScmFpLt6SyJF+SD4aJAjn54seERpkTFv8OGAH8dXxX08mv
 6bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788880549; x=1789485349;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48I/5ZV3M8PQW+Nd+AVAKmbCj8LyPvNeg4eQe0wKYGc=;
 b=cOJC3vQbS2kzwBFlauZd9H55souvoOUugxkV+QM8eNopF7cs+mVXW4jS2ylmoZ6Hqf
 Ot2IXsVdTpQSfnouydABzQJsUP+sRD7m5JuUYd71w8l5M7bs+iU3Rdxgvi8d1r/nOe7z
 aVNU7sCS8Eo1fkaGmz6IbSFjV+JqsEWv5DPSeWKNG2UHMKU1VHWmAWZcpkC0H8o2o9V8
 02pEXqfvAeb+cuFA/TZMpIOlZsplW1pjeeatKPecv/clcUROuBEy1ySRqahq+37x7QSt
 adz5WcSvrlr7mvRt82Bc/sx+Qv702//BKa/TJMXaGVo736K3DvEvvuv9nzrZJk8ZRxXY
 Dwmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiKfdzHJ1ZGe5UVkfHKzaX44gJrBn/NTHYdhNigStt3GS6oJpve/vD81ms00/UIGFnTHRwmMA3nBU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUChl9Vehaz1RPgOWP0ed1vSbBhqWkALCtRt3QylrgeuC6iqdI
 0iGw4PjPcbs8v0NylM0t/PcTSU023zb7Jkbwmyz3Tq7FHy4XsB6NTEn3vy6+JlUaaqOixCkCx+o
 H2FlLWaVlFSaBb26pBNnCffoogmpNv5nKwMcf
X-Gm-Gg: AYBFou0tDhJ7F4WnnlzcHHASAntI4HqCNBkG7JRk73FjOQbRsbUbHDpao3+hCAfy8q2
 GKeILD6kJitlAgF7cGfV3lDQS2nithegnw/4DWJZBv5hy91fpN78lBsIsTTJ4rQ9DQdfrxeGa/f
 FNMNwTS83cyoM0ZoPsWwSYuPqqPcTyJBHflHNW+ahn+KFzFZnR+1xIhNENt5dTjImYkk67gLg9c
 OPOxqkD+g9k+jzDCEswh/XnTHNNdRYa0eH00Pq4yWDY/xaKowGHSO6VRP6ZKYT3595IwVBs37OE
 fRV2fWPG1ap0O4XQn1umkVKq7WMrakFUc9WEGEM8/KOVGDu9eG2fwgJm0reyYXgK7+IzHPyLpS5
 +1DGEn3/djNLQSPWyiyJRx7XEV+oxcnw=
X-Received: by 2002:a17:90b:2dc5:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-39b9a99459fmr4622408a91.3.1788880548969; Tue, 08 Sep 2026
 08:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <aqAVSgsypMch2c0v@sirena.org.uk>
 <5d3de44a-c382-4ce6-8f52-62696e67fcd0@sirena.org.uk>
In-Reply-To: <5d3de44a-c382-4ce6-8f52-62696e67fcd0@sirena.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 11:15:36 -0400
X-Gm-Features: AcwNN1VnTXeV8V659QiKMCwYI-2o7Ug_RreQwrzcUErxFzh7ylh_yBH27lIHOHY
Message-ID: <CADnq5_MiNmzkDqZRk70_RmJaJWTEXFtu0c+eV3TJ_At=uvJ54Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, 
 Alex Huang <Alex.Huang2@amd.com>, Mario Limonciello <superm1@kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Sep 8, 2026 at 10:07=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 08, 2026 at 03:01:50PM +0100, Mark Brown wrote:
> > Hi all,
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > ERROR: modpost: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/a=
mdgpu_dm_connector_test.ko: symbol 'parse_hdmi_amd_vsdb' undefined!
> >
> > Caused by commit
> >
> >    65198b3d0738 (drm/amd/display: Use HDMI FreeSync range from common E=
DID parser)
>
> Sorry, that should be f65198b3d07389afdcb48e4ad00fea2aded95dfd.
>
> > I have continued to use the version from next-20260831 instead.
>

Fixed here:
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/730c6d8072d8d9a6dbf=
d06c7c5ab4479167a792a

Alex
