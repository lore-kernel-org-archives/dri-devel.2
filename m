Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A08C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5D910F248;
	Fri, 21 Aug 2026 07:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIs2OCIa";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFE610F1ED
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:35:02 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso1577997a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787279701; cv=none;
 d=google.com; s=arc-20260327;
 b=HSC+r224LCiDvJGazPJm/C+QzzE59ttKTASpQoD+1QR1VB23yXuE8Yx9KIL8XPDzVc
 jsZdP5nTJCe6sfNr1rU0q6xnIDrcWTMIVpIabmn5qKyt4V/J1VLpvnOWKttWVpjW5WsY
 XGSyuuhBM580spzS+xllDS/4HsmQfQL94ulPKH6KLeWn/6vzAqf+qBJDN2A0HlsuEJLK
 Pe/6655oCd5Fs2bAe7l3LM+zSTaFHErys99YXcqVBwvmvorbOBBRnXupsLX0YUMR1xxZ
 94SpGrnNXjrPTK3em6gFXhZQGegVSI4R8XI1o4cvcqRQVVlVQaAxr/TQZv0DYnKknDzz
 sLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5QZdcXNBQdr13U8BPGDODnZ5OKZMk9kR7dBUEi3Ksl4=;
 fh=Xq3Wm7cZhV3jHDfjtmBQ7vBu+t0VbC63d3aN2WXwtRs=;
 b=NVXJnV9og+CsHyjEdNG/xFesRleZ+DprMH9w+BOCg3NqTNzRjjjpgBUStbfy5UtD9X
 4mH4CMZ97vOyxWePKA+9u5QmkhvE8H2RBN2qO4en4C60LzDdGWYecZ1Y8MHQ3fRmY8b4
 K0jf7MkJFkz01DsIjYvgYgWmjcTBP1itpRNqgV9KNQ0/UA+xHj8QYHWCREg1OrPUKorn
 z5T1arIaL3v0D6CR/OWGFC3Gx2BQyzyyjWDon1lE84S4DzPt0FFvaKoTZD5tSn4xWY68
 5KHaQOy5wL69hRMQ78S0ywqfvCzmuLaTxWBQrFhsdNdtfND1OUL5M6p5So4hPGPtpkYk
 h9Wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787279701; x=1787884501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5QZdcXNBQdr13U8BPGDODnZ5OKZMk9kR7dBUEi3Ksl4=;
 b=kIs2OCIa2qnVF6vkak7z+dARn5GKkWDaHPwcvmWUCVIs9hWpbAQAzCYrXsWJQVcVLe
 6/ONxkTXkc9dPrZ1VdRttmRmHQnXNmSd78SRYkiu0QKs9LoS2M3iT5LO9vpyPHPb7gaX
 GjdersLBPnCpax7nrhO6eOb8chRQ2r0mLc5GJCgeUCn2x9hnXA60qYrS5vdMBI77bGj1
 f2xqY651nTb2SEcTAvl9U9m7fz0Ivg2iq16W97cXo5EXF7SfzCFbS0DrmbHI/VPyoAcU
 ov+V7KDLZEaa7Yx6uRSH60PRtQIMDP0SQDugwxgQaHfpUdmBqsKQpLgLgr+dfTPc81U4
 7GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787279701; x=1787884501;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QZdcXNBQdr13U8BPGDODnZ5OKZMk9kR7dBUEi3Ksl4=;
 b=WQJnDSvC+SZueh43+yWgXo/qJLlUVTBotMiZUVOdq/kWgHpHFM+I2IcvoxFEZZ2got
 vCH8IZ21vUcjzGXEZQ31aaHvvXvyE5R8X4qat4OqbKw+hgGYjPu8O3k8UN0EywNWHCoy
 ZDCytGSGK/BAlUEKbwuhUXwd9Lu5lWKGuQyPWxOlTpLcgCaFUoMUifk2woIdtPLdAGU3
 g0bg8fokpOBID4jbD8j2MB0/QH0CzPPRsOO7c4FpzFVuXABD2DrQAGbOdIriovwFM6Jf
 vY2PJdgTrQq9gVTdgqkDC4WowYM+uzqN3cZL9tV9zJqLlBm2dikAny1PjPNJ/RCqqMHN
 Hoyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDV2HP/Ew6uHxHqM+jloen6CyMP7rRQVkFFfGsjvWwiqDtId760Cy9/xPONw3J56kBEd8zUZC2+Po=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZmLsOOOjhnDlN33sRoHZIF0kcrsgny0JRxpaI+TsMeCmS3+fX
 lCdyJfyAXmnDlIIpLaYbSlq/fcurtHEM+Vo9v86Ahgk/geC6SuAD2AtJOqkmiSsHE/fYfIQ46U/
 5ANR2bo6yamHq3j0V69zmw4lQgNjL+mM=
X-Gm-Gg: AR+sD12Spmr1mzh3f7Zhoa6Oef69UszMa0+tezbCbc4iBxXt/oEVgCcvJJjUhedMph5
 p4brwwf2NyYzwQt/IkJqo7+GZL2lMUThKbsJ1fd75PUfPrn6hsSDDqcmzPHKWQKvLuwjXndy0Zh
 KZuPj8Qez9Pd8KiMfNFv+gv8cdavt6vggctzPNWY4u4PQnCEd3Jx5A/Yiygi2NKuVHKs4GKtKym
 q6ck72O9hTn7i/Ntop4fm76wVl9s4/MhyDNtS37Lt5EJH/2B++6QYlFkgwSFwyigq37v6zHPXEX
 0LhXNk/SQ9SeGDSyLrbaCY6C2OkD/kIzSsNFbpT7YrH2LCKTxt34tQ6x0loqxtmin4IZhpJSOal
 P+ikvJbFlMTMg9dIK5CBTujPFXUfd2UWj0LD+DhYfJU0=
X-Received: by 2002:a05:6402:4584:b0:6a0:a4f5:f4eb with SMTP id
 4fb4d7f45d1cf-6a42f1a5f37mr3225955a12.4.1787279700689; Thu, 20 Aug 2026
 19:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
In-Reply-To: <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
From: Nathan Bourgeois <iridescentrosesfall@gmail.com>
Date: Thu, 20 Aug 2026 22:34:49 -0400
X-Gm-Features: AcwNN1V5XdrjAPd5CfnoI9GnFh3eZ9Ur8FDV7w6rT1a-sJ-swYUViTiwIvCxbOY
Message-ID: <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: Dave Airlie <airlied@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 21 Aug 2026 07:23:07 +0000
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

> Shouldn't we just be calling xe_bo_validate() here instead of
> ttm_tt_populate? (With the correct xe_validation_guard() wrapping).

> Yes, this might be a better solution, making ttm_bo_setup_export()
> completely unnecessary.

If ttm_bo_setup_export() is unnecessary, I'm happy to change the patch
or make a new patch. I will attempt to implement and test this locally.

> This part looks good as different patch from what I'm assuming will be a
> TTM fix.

Regarding this, what do you recommend I do, assuming the patch
remains local to drm/xe? I'm still learning the ropes of contributing.

Nathan

On Thu, Aug 20, 2026 at 9:08=E2=80=AFPM Dave Airlie <airlied@gmail.com> wro=
te:
>
> > Yes, this might be a better solution, making ttm_bo_setup_export()
> > completely unnecessary.
> >
> > It's also a bit odd that, in flows where we don't have backing storage
> > on export, we populate with pages and charge the system memory cgroup,
> > only to move the data to VRAM when the import attach is triggered,
> > resulting in a copy and a change in cgroup charging.
> >
> > I guess the question is why was ttm_bo_setup_export() introduced over
> > just a validation at export?
> >
>
> I'd like to think I had an answer for that, but I don't. Likely
> because I wasn't thinking about VRAM charging at all, and just
> worrying about making sure we had populated some pages for system
> memory ones, so the other side couldn't DoS us.
>
> Dave.
