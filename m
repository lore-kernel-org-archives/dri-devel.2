Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C01099B28
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FF910E466;
	Fri, 20 Mar 2026 17:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZW7ipYjC";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F1C10E466
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:52:47 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-64ca423ad53so2520612d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029167; cv=none;
 d=google.com; s=arc-20240605;
 b=J2OuU4EVa2jNIDf1apOxowXeZdtTnzY0rNWDl5hCUIXeUgmCYOA6hJo0Tx6RVPt8D1
 jw7foCS2ijAzEWEero7hqm0pACKXqu9Yii7CEKSHL6Sz2g+WLz7CpsNF35uAN48pTYZ5
 fpGBIE7Eqf0jaxiHZHPP2CL8feAAVygciMeAzQIdpUiLa8Sp5SmgdvMVeU5111W78o+5
 +GC2bHRuj4Jkm9WdFV2y+QvrwBsEevvQKy0rN/w/Gu9tNT2JtMJNA4aiIPTkLPAxlxpR
 SdOTLcwnaQ44VoW0ZFng/7v57cfmP3E4spG3Sa5ghMZE2CXE3RNErf1WXybVovgduBDK
 N8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jzqKUayHP9edpbuU79uv3nBiFh6UCYpOtYrxmChIqeY=;
 fh=9DnNVD/CJXahZ/A8xOAa1S9AVjphOpPMDJGoF6ojwSQ=;
 b=lGfkZ5GM+2bVSm5+mpL4B5p65HSwN9V0+26GgUuZAA7pFxzsMdxAS/2akySsl8J4iV
 C9mT5LvKRtt6w0V1R3AspEgZHOKCdSCpDs8IRY22P8l4K1eXDISbo+SzUDWu8ronmW7a
 OPShwEBOuARwHAHbidcDB/ZQi15XxE33DhW59F0HhXwOzHc+UnVS8AV6LZXyzjOWVSg0
 tYC9P9ICAhef6bNMelW1AEYhY00L9r9PkOxh4pGnmhWUvFcqEBAFNEWVjwsmuodt3vu9
 dhEbt/wbZpw+8GMxEJx+yt0xTEW2qMdRwNTZcFpZ+ynltLdbzx6QfB7EEozX/Rj9ofAP
 9mLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774029167; x=1774633967; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzqKUayHP9edpbuU79uv3nBiFh6UCYpOtYrxmChIqeY=;
 b=ZW7ipYjC+vyFBTKUCqFZxZtXbDvuUldJlw4g3RYF8ihj0FemZ2E1RenqNuchTzmRL8
 kjPTGmWf3Dl6qS9fczrRaW7YuhR1bk6N0xhg6cFeCE+gxpE4RfObNrxS+h1ueppUamPV
 WhtyAzTpVZI/XcSfyUwp8Z74utFaFc+5K0Qh7eYrFomClJGA5J/uLiR50pwigmH2qdpv
 QgBkezSzLCUdsqKLY3Nh3nzTCdAmlTyp9OxKbD+UKWTZ9PHQS3vhQQxpHWRU8y3fJDT3
 oALYIIv8GdmUAy4f4lG0zo42QnVxSo7DhIEOTZ/ZUSdWvgXVpWgzwz0brb3m7Z80SetF
 TWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774029167; x=1774633967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jzqKUayHP9edpbuU79uv3nBiFh6UCYpOtYrxmChIqeY=;
 b=HO+LhKCCDGLX6TTnOgyUZT02RuJpgK4nJAjDp9j4fyiQoSxSfQzveoFC/1t+M7IRjR
 6Tm+UP6xsmI2Kt4REZkHa/zloR+m7XSBXMWRjoFr0L6Fq1t8CjE1OpfZicr+0G+7wQOQ
 g1gygHHuH8wAjPFuxRGzkr1/a9D3VSrfA0XQxKrOkqjpm0ylHFntR4aSUnxI+y/YbsTM
 NmuRSZa0IAHE6qMKNL1z0l2CoNk3uknyUsyurzaFXDJO9UjCd52wrCmpN5p8S9NauFAG
 8LhrhLAsiQsDqiRyUG5CsFhBULxICGmRuZebOhvOy/BLG68R64lUdn6DrhSrtO+AzFRx
 zoyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg8dStkZUQW2GytXwJTjb0JuIhKu5m69W1J8/Z4L4d0cIsmO3kvzgMkCrHtrUv8J6DRes/O4FZiQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxs6y/iDsK61Z+6tQwFR37R5PEmrrYIm6K9UKg19rcc+LfboSPD
 gZJqvHfZ3M0MCRuqMJ6HKiJilSrLi1X0TpWDXXki1KIzJBLS3h7BpQG7kCsWZ1iiM0/hSnnNyJ+
 CqWTFw4vVcqxFgsq/p9/+HdXSA9UHypk=
X-Gm-Gg: ATEYQzzyIcThKOaualqgsJC75z/VWtyEjOkylKgwegF/0rrofH5438CM2UVpCQUB3nS
 3/N6skCTEvwDBlyzPHVR3Qrz8LFMzKfRArBS5b96Xt1ud9BulS2xfEKSWzURehMasXWdb3vBs1Q
 t/ff8d1LTerEsrVu0sufDjCTswpef6LQiGTz2f8OHbjTAFhehnoJXQaiKLtjvNjCngy04ZYwhEa
 imT/oqaW3xm7Bc4FmA9czxdxWSmioDhDqi2sbftr3LLelMp+QfsZdu87XeExPXOWlTX1BUQFtmN
 kIbv
X-Received: by 2002:a05:690e:e83:b0:64e:a9a1:fdb9 with SMTP id
 956f58d0204a3-64eaa702c33mr4585474d50.34.1774029166611; Fri, 20 Mar 2026
 10:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-25-jim.cromie@gmail.com>
 <177402491443.6181.60919381684088042.b4-review@b4>
In-Reply-To: <177402491443.6181.60919381684088042.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:52:19 -0600
X-Gm-Features: AaiRm530GL692oa9s3DUJ1CJBDaPg95JNvy-jkTucGT5VXQChAM653FPkofN1SA
Message-ID: <CAJfuBxysWdtEQAd6X35vMGhDA22Woyd28OzQF1nRW8+j8oOGXQ@mail.gmail.com>
Subject: Re: [PATCH v11 24/65] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE
 args at compile-time
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:49 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> > index 1ba4be9a403a..b2bdfdfb6ba1 100644
> > --- a/lib/test_dynamic_debug.c
> > +++ b/lib/test_dynamic_debug.c
> > @@ -146,8 +146,19 @@ DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, =
D2_CORE + 1, "D3_CORE");
> > [ ... skip 4 lines ... ]
> > +/*
> > + * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
> > + * These will break compilation.
> > + */
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG=
");
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG"=
);
>
> Maybe add a:
>
> DYNAMIC_DEBUG_CLASSMAP_DEFINE(cat_disjoint_bits, 0, 61, "TOOLONG");
>
> So you can also check that an overflow is really checked.
>

IIUC, you want a class that has legal offset, but extends past 63 ?
If so, I think I can add / test that.



> --
> Louis Chauvet <louis.chauvet@bootlin.com>
