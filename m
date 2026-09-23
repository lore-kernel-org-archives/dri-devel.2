Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23BCC98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3D010E18C;
	Wed, 23 Sep 2026 21:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U6++Ynp/";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617E710E177
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 21:57:38 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-32836ad8746so70371eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200657; cv=none;
 d=google.com; s=arc-20260327;
 b=PkaIQMXmcbE8Dw7ZCaMn5fZ+R9E4sswQzF+FXRsQbp9VhofcpcEonupxmkdC56SsvQ
 fC4BiEaZK1fhN6n67Yy29iO5+InZyLVkIfwvPBo5hPXP3S+2Vu4ggI7zYEl22CxLEVRk
 ax2ZXl3GPrfi1nEZBa8nyXkAZxlXpc3FHZyNKglv3ShMhyeEKE0+ixpgwnDY01ZppDbO
 wVOiAIdwhlUTTw0E4zwyrbYTK4hNTbq89QJvDL5ZyK6MvDKKAcK8W0sj3Z58bOSYMzq1
 8gGL0kR5+Ms9QBRFqX4rXy2/FHZnstqqReA0voG//cy4DWE3uw6A+Sf4uMSQ/qrXLiH0
 jc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T24E2HgBT3Ki1o2tFVN/BRTIkQAmjBNrRpnx59eMnNs=;
 fh=r0DiEKkEv+WP5kI2UjrBxrB+C8MofW5vbS4s60GojxA=;
 b=cVcef8dN1O756Ph+4rQ7pWt1HRlbTDAY8aEUn73dymPqYjQq8nqYWjHw4xF1yzL7Sz
 k9eEfynNeXzJMe/8Zpn6gnob86+ui743PLgln0QwrErD5I4iyYhQkKW7UPbw9dvt2tpK
 kjuhAa09c+VmPtqgeuTaJ+I7FUCYNR0CVvpJkWk4t3GIE6Gw9NwU+5bYr+MZkteFpzGI
 BGrIunXmKRoqzBXdbO/COtwXLBt27jt7ADMK2xNd0620DEfstfEjBXnszT7q3Jn9jpk+
 BSYjrO2nJpUskW8W806J9xfwJW4flH7XpqBesHPTJ9MX9cYxcUAsofDWnB7UaASHbXbp
 s6Og==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790200657; x=1790805457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T24E2HgBT3Ki1o2tFVN/BRTIkQAmjBNrRpnx59eMnNs=;
 b=U6++Ynp/jdmHYEMxOIRj0E1d2FeDSiXHd8W0Nvz5F3uYMBMdzaXunQJ+yotetNMP9A
 g3D+DRXqw8B2xg/7O4QJawPBb23pVuyuuAH+AEC5YIgt9Qi+QekmmCM7X5IEKwGkRzZE
 menLcxiS1zqqRLnuSLvpD9cfUdPu3A9n3zfrte995jsyrhSJnwLCztdrVlRXNyfYT1Z6
 AOQuWbnZBMCdXaQ/mXCXxQtr8CocGmBmuULdVU2wnnXw8/Z9d8cV6UueUltUkMM5sUW+
 /rJUuLNOLs40/41tby+z8f+ZQp0A2XkMU70ynfwtsk08EQrz95OeI9qxgsWoYgoR3Apy
 Mtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790200657; x=1790805457;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T24E2HgBT3Ki1o2tFVN/BRTIkQAmjBNrRpnx59eMnNs=;
 b=kJKEhcqDWcCQTBmoRULRA+I+2vAitO+bEw3mUNwAcEYYiXlDcQEKQt8FtKHwWCyodE
 VidgpiVzrxtKWrExdPZiv56g/TkJbzk+zENjzuz4LGAqJYKoYlGI5grmGVaN4sUGcvRA
 6Q3D8+sqwGLMJFrh72TFyIijkkBSSNuTBdtyrDPT4niC3SInUBU8i1n30uZzoFVvL7uW
 vKScFB9cZZPFz7g8nENUmsyoimU7gtTBV2/HZVN6wCngSZs5liP9ZAlz0Hes0olE5DpI
 R5ha7J/rKBVozlADOrdDLQrYyNSFkBSUlSMcsM7f4iXp5QFyyFb1qpmm10ToNix1mf4i
 wGnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIpdp+BMa6mS47cG8oPnLYwNMiCpNkvWUIgUojGTjqCX9PKFUE62Cfe2gCyO3UQDkpiIf43SkcbbI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lKW51Bxcwv1a3Mw/r0BrsUL7pwPHDeeJkorznhZPUSeecbH+qN
 Ymkman01G9u72bFvdjo8bjM4Nes4urZTEzQXhnoQu2iua9NriKMAoAVGDncam84gogP8zhOOdQM
 4oSG34f+AYtZ4/wzjI5pkA16zFUv93Y0=
X-Gm-Gg: AYBFou2OjuoEnko8NmMGhCG/V4LDQc5/aCPBHNOjJycawydfTmqpRov7I4FsXGNA1pJ
 3skAwFy5HJWT6xv5Y/lkV1M2EG2c+Vl4upD4USkXlj1MVGiKObnwMN1U7aaP1gO7COSFZa52nY/
 EtTOLgJo6KFMuDSRRiVoKUaMIrcMiF156X0TqjHRHR+s+vzYiaQZPXYnfjL9l3fAXm44mRkiWbj
 26UVRZhwusW6E9IoyuEd2cTDbtbbx96+V2RyvmEc7DEK4STmAsJcvm1bvFHx2kw04oQg0GABBy/
 sVzhwcXcMSX8CpL/82NCIti8mIhgKLz8m9Faer0jQPnGub1KFxFUfsBcVg25CzaJZLs2rDMTECl
 W+waIfDVG+3Tcpqu/9pRB2Y5qd+9gt6HKKLSvcihfNQ==
X-Received: by 2002:a05:7300:7f28:b0:33c:68b:c4d2 with SMTP id
 5a478bee46e88-3400657428emr416140eec.2.1790200657406; Wed, 23 Sep 2026
 14:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
In-Reply-To: <arPhsTaiqXPgCqAU@sirena.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Sep 2026 17:57:24 -0400
X-Gm-Features: AclHuK_Sy6gy_cFQzs494m9ICFUjGa5KnK2eKmqxNuEJb4IKFn6VLWZL6MmQkaA
Message-ID: <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>, 
 DRI <dri-devel@lists.freedesktop.org>, 
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

On Wed, Sep 23, 2026 at 10:27=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Wed, Sep 23, 2026 at 09:45:38AM -0400, Alex Deucher wrote:
> > On Wed, Sep 23, 2026 at 9:25=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > neither of which have had any response at all.  It really seems like
> > > there is some room for improvement in your processes here, currently
> > > that's three drm trees all held out of -next with the same fairly sim=
ple
> > > build issue.  Can I suggest at least check to see if the code you are
> > > trying to merge is in -next, the drm merge was done after amdgpu had
> > > been held out of -next for several days.
>
> > I sent the PR out on Thursday and you reported the issue on Friday,
> > then the weekend happened.  It was investigated and fixed, however
>
> The actual merge still didn't happen until after I'd reported the issue,
> and then as ever things are now starting to propagate through the other
> drm trees.  It seems fairly obvious that there is room for improvement
> here, for example people could check that the code they're merging has
> at least made it into -next.
>
> > Dave reported a different stack frame warning yesterday so we are
> > trying to make sure that is resolved as well.  In addition we've been
> > trying to figure out why our clang builds did not catch it in the
> > first place.  All the patches should be available momentarily.
>
> OK, that sounds more promising than what had been visible to me.  It
> would be helpful if you could be more communicative regarding these
> issues, the drm trees and over the past couple of releases especially
> the amdgpu tree take substantially more of my time than the rest of
> -next.  Between the frequency of the issues, the length of time they
> persist, the way your process will obviously trigger such issues and the
> near total lack of response to my reports it really never feels like
> that time is valued.

Your reports are valuable and we always take them seriously even if I
don't reply as quickly as I should.  For the issues at hand they
should all be fixed with the following patches:
https://patchwork.freedesktop.org/patch/755725/?series=3D174828&rev=3D1
https://patchwork.freedesktop.org/patch/755741/?series=3D174834&rev=3D1
https://patchwork.freedesktop.org/patch/755769/?series=3D172614&rev=3D2
I'll push a new -next branch with those fixes later today.

Alex
