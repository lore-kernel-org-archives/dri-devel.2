Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C78C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D05B10EA36;
	Wed, 16 Sep 2026 12:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Su0noJ5n";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CC210E36F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:58:28 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab17a810so68540a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789563507; cv=none;
 d=google.com; s=arc-20260327;
 b=gS4XipOER4BQjWnlm1JK+dOihDVOx/hDjOtfLrUfZM/joRKT/hYCckFGfgAJYn9YEh
 NQ+/WKLYKvbT/aZJ+MCRfpqqTSuFuITYuudW+pCFIrFYDj7aIDpTUB906ddI3+YaghZL
 NrGUAnjNqsAx19pjugPtpxzEDg2PDOxMHwUPha2HMoNLMlxAHqYCOvmUtQwpxsFFW5i+
 DWRf69O9yxF+JPEsdtLyGzXLkqlJRt1DUmhQo3WPskspdLp2yMrGmXFXzIdwm3U9NvkV
 w39flEYfmrGz+OkHN3/1kBGzOQx54HUGTiqINNX9NgPN/qHW+kmBksQzITca+sNyWRlQ
 Cg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 fh=RwJSuEYACsOMFenzsRiUTi4fHjYC5jCUWo3M+pFABio=;
 b=iyh+PHr0q/XRNBGPAHypKLY77y1CF/IJfzu7Zqa9GOO3ccTmQHNAbKuPHiDWEGv0Kd
 Q/C+ZWbwk8TZsYCB9V18Y0gxNVcGK9n1YDlcWerT3gnwG70eWPIO8SfdGe2FIY1b7pfn
 nJcO+iBlun0q1tOKz/kBdSKl7VLWqHTJ/ziVWJH5HawZ8oi0tgRxKSR1+wQ3ngq0egSc
 ZYcJGfEFtnGkMRjTrVmff6GtMvRp7n9S7Wx32L0SDg3xrsStAjxmUKAWwlJIGeQfBhmZ
 KnW2iK9yeS8c8v7vta9IrXfNmFolw9ZDZqkMFdfGmOAn5aCpYneXRNthz8O4pWcRaVMz
 DITg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789563507; x=1790168307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 b=Su0noJ5nqIRVm6kkGO3Tn0xcpsv3niws4NjJqnzHGmSboYCOSrQesZArZcgomFLhHh
 0NyucoVQyZFXp+7ds66TQtwQjyPxJSWe41kNiI5w/njzt22BwkC5M2hvguoWkiXqDr5l
 roaqgc8a/ykJ2gLBw0052HQfMQiyEgVT8zHzlhBN326hTG9cThp9UrlEKG7u1ettcwge
 SQny53sz46WM1qsQz86TgCRe16xGrKdy6Gx/NI0jf1JYQqTvZJNJ3W4GvplIjYDDKGY7
 vN7iFyfUG3HX3qeHQGcMnJZF5f7bYGe5g1GiGIIeTzoGwdliOfdX6RRmWEr8aP/ou53e
 gRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563507; x=1790168307;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 b=xBHlumS/+bWXlmYJ+Ke8omlyjdKSUU4XfDyFPpBycGFCtKJ6vKGRWV9fWxUW/DYYx0
 ZbfkJWioeNwTOIlDLfdz7sM7USS7z0ykqmwTM8ap438VgUeKBqCMfECvkDINHBpmEso7
 l2cTpa3YbBqHAZyx3DUvnXZXo1ziEFr/v+H/wwkdHlzpmfkhlgQ4AJxCCRanbTZGCJHa
 4+U9q81nm8reTdgjTVSQy2ogdzLRiZSi134jnU7/osNnSbeF88tFCZX5nQnLKbyWZ8ot
 AnBOveAk8Hsa+Sz1kFiwr331nGTn45mo0md/BS6jDyQvVgQUq14yJ14AhHdQdZNtOqSy
 +0Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPsUawolzmxDqXNml6RRkORoeuCL/AvH03xVp+Z5HsfFGW43CpLip0PCZzzzf21Dnr1PkpM2MXazk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5JR7gPVEwX2QgO77MudTLV1QIdXf2fFuJhv50o/IqAlsYx4ac
 h6tXz5RBYDPdVc8QZJTtSnbtJyNIRfS2pt244tRX0qi7PqxLyv+hpaXmv9G2YfUJTFmoMB8ukQm
 XTHQe0tSgp0/4AdXlci1fBsGuZ1b6rzg=
X-Gm-Gg: AYBFou1lammOyqeO30ZgDTHbyeQPGb2KRcKiqC6XE3OxTvE8oLSU0NdgwQv/HihdIsg
 TS8IKJ89hzd2d6dK54nHllj6AH7Bwz+lva6UQYdUjwBf0FvJ1+fqDDZszgJ56CTsqzKPmnebGF+
 6FhaNVsoQxuUtpNHmYJryFNLCGEmBTn3OAYFG2pcb0N9TdXHOiSolf7O0U0oGVsw3KTDzi2J/yY
 zTTTB1tGpOw3eJekE4BBjGLTGvFEeJFCESnXSUk5qcjzceZ2IEjsALptE0I08MK20VQZTUmZgVW
 Nbm9QzKqSTbI7Fzvh680HQ+ETLJc/uKLquMwZbJ/W4Vg1Rk3CuV78Yy2XCu5KO7f6i+eZhhhe2q
 B77FJ/kJGqN769cOZhbOSpr0YbCL6FGx7YKVXLZtQdA==
X-Received: by 2002:a17:90b:4a44:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39e1e5ddce1mr3962699a91.6.1789563507423; Wed, 16 Sep 2026
 05:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
 <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 08:58:14 -0400
X-Gm-Features: AcwNN1V-eNmnsnA6Vp7fEkglgpoEParustJjkGuxPErPwN3z_wLoywr9u_8NQ0M
Message-ID: <CADnq5_O5QHaUjy+ppibtLjmn-=exK1pptjjnbO9qrn16O1oxBg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch
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

On Tue, Sep 15, 2026 at 7:20=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > I can drop the patch if you feel strongly, although it is pretty
> > similar your original patch, it just keeps all of the logic within
> > navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
> > specific logic into the core pm code.
> >
> > Alex
>
> I dont have problem with the code, the problem is that, this is not the
> solution to this problem, as i said in the previous, the solution lies
> in the DC not the SMU (i tested by removing dce_v10_0_early_init and addi=
ng
> that function to dce_v10_sw_init), it is also confirmed via the testing u=
sing
> Opencore Lecacy patcher, which makes the display 5K, and make the display=
 not
> use compatibility mode (4K), and it also fixes the SMU problem.
>
> (https://gitlab.freedesktop.org/drm/amd/-/work_items/4455)
>
> You can choose to upstream this, i dont necessarily have a problem with t=
his
> patch as long as i am the patch author (eg using From: )

I'll drop the patch for now.  Once it gets sorted out, we can help
review the new one.

Thanks,

Alex
