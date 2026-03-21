Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021421094480
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A7510E034;
	Sat, 21 Mar 2026 16:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lodvN+oU";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0C310E034
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:39:04 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b982518b73fso260085566b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774111142; x=1774715942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+mAGI6D2x7kpdUZk4YxlzGy1eE7Yb9ILgwi8nyiApI=;
 b=lodvN+oUwXFwGGYqLKlh/GuMK7RCi97m9Y8OVk2J4nShALfpjvNjVh5ryk06y+6Ghd
 0+NsKRy+ay7wufsmsx0utC6mjIf/8kGuB/Jx8Xp7jxwbv3sCMoszxYy6M6jBjXiGA7uJ
 vJPwP9EsoMZ0Sll7j2VOBnW0HcQurOJbNPKe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774111142; x=1774715942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+mAGI6D2x7kpdUZk4YxlzGy1eE7Yb9ILgwi8nyiApI=;
 b=pBxvAsvVvpII6xo05yXYXNhUnLOdGsoImRDzne1SHU4CXVM1CNlGlElvRHOV2tztOL
 6nlo4CubTDTNVgxLxibMDdKHvzr482dxrN3Sx0ZdnHhWtn2j/OKfkkY3f6hIUGTJ0jAv
 txuineOCFavPmypcuoM1ANkXVGvcS5F9xTY4ml1edJmRtydZq7qWdw1onxHPSXnrqRW8
 OtRw+RNuYUFli5O6AlJ75AlvqP1btXScW2J53XeWFshAn/A1W32niZB3Ugpru1FAgzBK
 iGhAzMaEr2FzMuAFltciyW+iSScxmIKERveWOKzbwnqpUt1NyvyaeepmZKC5F08K6ZeV
 UR4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOckGKv+yWCPE4mS0pSMGEhN0pen50BT3aln+cnkvjPq/N4p8raA8CZfQWDnuoSQ1DcwY9mbDnqCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvX0KPazOaJ2+gbv0/A+x1iljPDa83xYncDO7EMaAPogiUyQcw
 Ja9gy/MzokW8XzcCO8Da8jMCIOqfi24/pkft6Gpq+fTa3gu/rLmvA03XcUqQQP1WTcw8bDvXJev
 ZecAcbPws
X-Gm-Gg: ATEYQzw0Y75crkZCY9obBtKnTk9gRKH5SAkVpJtVo1l5RM5U3VfR7Fkn2L376sXAccP
 X28PYc7RxWY7XmR2F02S7uvJMIzDu0AmjNBzbMCKZZI6NQnf8mVCG+d9g7lP2VGeBMWhOJOtJLm
 iXEWyLW9fCO4FsV7Sk2P44iDQHzkWvjyK1s/Fz6OrJgC8SEw/qZJOaNKyG//D0EjONZxDD4VEiP
 9WbTV3mFDBJlerhcGqO+41MX0H1NGXlTx2AKaMJ0NWAAVm617kx+fzZURBtjhrWDSqZqdbUr4Lb
 sXm30azfpRlXfzG8hMoMcZyOrXwsnOF1FgV71VVp6j8JZME9/d00suIfFUgnlBhcK2F41GIwFU/
 1CZkCYpdfrx9/OqhM8onRR6kcbWjxvcKT4rOfwxRrVNDUA83o/DiB58uTfzoXfjmvOtjb4S5CSA
 gh04oGQvy5l8Slrk1wORJpSMJkzCWcMbu90pHDyQs7gA/SiHAXIpX/yZ+RSHaLxQ==
X-Received: by 2002:a17:906:2554:b0:b98:1e:6642 with SMTP id
 a640c23a62f3a-b982f3e2c7cmr363434166b.45.1774111141891; 
 Sat, 21 Mar 2026 09:39:01 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43a65sm286825666b.7.2026.03.21.09.39.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 09:39:00 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso1178850f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 09:39:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXw5TB68+Sy3BNAjrhCjBBu2XVT8tXK26d4ND31u0wefXYnT6cG0ahjBHlf3Q1nFSop81aO1N1BFOU=@lists.freedesktop.org
X-Received: by 2002:a05:6000:290d:b0:439:d242:e8fe with SMTP id
 ffacd0b85a97d-43b64242fddmr11167085f8f.11.1774111139960; Sat, 21 Mar 2026
 09:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
 <202603211444.JZ4VbAPo-lkp@intel.com>
In-Reply-To: <202603211444.JZ4VbAPo-lkp@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 21 Mar 2026 09:38:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXD+FmjQusp_inaLhG8=vR3YgtobOp3igSmR54=Ka4bA@mail.gmail.com>
X-Gm-Features: AaiRm50fR7YNH2twmQ7oW8qNNgZ56TEA6Y66221jXJ3dTEgaRip4CTx2LNX3NkE
Message-ID: <CAD=FV=WXD+FmjQusp_inaLhG8=vR3YgtobOp3igSmR54=Ka4bA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, 
 CSW MNF307QS3-2
To: kernel test robot <lkp@intel.com>
Cc: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>,
 neil.armstrong@linaro.org, 
 oe-kbuild-all@lists.linux.dev, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sat, Mar 21, 2026 at 7:03=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Alvin1,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on drm-misc/drm-misc-next]
> [also build test WARNING on linus/master v7.0-rc4]
> [cannot apply to next-20260320]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alvin1-Chen/drm-pa=
nel-edp-Add-BOE-NV153WUM-N42-CMN-N153JCA-ELK-CSW-MNF307QS3-2/20260320-08471=
8
> base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
> patch link:    https://lore.kernel.org/r/20260319050938.556235-1-alvin1.c=
hen%40lcfc.corp-partner.google.com
> patch subject: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JC=
A-ELK, CSW  MNF307QS3-2
> config: i386-randconfig-2006-20250825 (https://download.01.org/0day-ci/ar=
chive/20260321/202603211444.JZ4VbAPo-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260321/202603211444.JZ4VbAPo-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603211444.JZ4VbAPo-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/gpu/drm/panel/panel-edp.c:1893:1: error: expected expression b=
efore '{' token
>     1893 | { \
>          | ^
>    drivers/gpu/drm/panel/panel-edp.c:2028:9: note: in expansion of macro =
'EDP_PANEL_ENTRY'
>     2028 | +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_=
e80, "NV153WUM-N42"),
>          |         ^~~~~~~~~~~~~~~

I think this is the issue I already reported where your patch had an
extra "+" in it. I fixed it when applying the patch. I think the
kernel robot here was just testing the patch itself, not what landed.

So nothing needs to be done here.

-Doug
