Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A26082BDC
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ac7ItojY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B84C10EB7A;
	Mon,  9 Nov 2026 09:31:16 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506A410E02D
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 13:39:38 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8b31261e8a9so399487b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 05:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794145177; cv=none;
 d=google.com; s=arc-20260327;
 b=ZC97YePuxZRO6w+fYGyjijBwvIfTktI3WY3cRyTNyvnFmJ7N3E2JNI/Hh0MEFSpJp+
 3geRnLkpT3nuQXVIbpKpJlVbyiXtoHZqEntzxbMldb3wTuaZyhbyDEl0zg53q/WYYHOE
 /AwcJXrOfwGXe/fI+j4GqD9sde6iS8ZF4L2xVSo4zgoibXuwVXW6Jpz+KJg437iT5BeU
 teuXlteUgmmcQ65FAFAGh3slnJgwTG7KS5+77pXSNQWhIEX9M76u+S03Wb8Zr1Ef4Ngn
 H20TAED057wO96fuEF6pGxZjeoWLouVlYPkRdO4OyJZBrtpF+t+4KvS6KmZ7zlzLgA3S
 8XsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UlBEXto1T1vI8hqE3nAGS+RfUTo8Ud1kQT5eKzeu538=;
 fh=Lf85TD54FYAJSO9Tf9QG+BQQPrVn57ZGrr9yhMpKqzQ=;
 b=hdZIrW/PobbMxIxq0fETTbI6yOKR1dg50sYLuPcmSvmEauHfXEcTAC9HoZlHUq8I0x
 sUi2crOldMwMGQ0VIRcpaakfmnCL5zsbTcDXTWYpk2rt39ja7Liu5AiextFPjSsSAUk7
 W8aNCxApu6SukSzYA/a9RIevSY/nrmHunCk/nc1WvMjEOr1flPahnAG4Vyv76NlGU8Ay
 no29gTpBUGc4/UGoqecLiymzma7o8eyF+6C53hWYO2w7/aVu8PpKjBZrL0zIER6D5QZa
 Q9EZ3lTk0t+FRA5K9Nj6pNFOuHgrufoGleXWIwpd2yEjwI5/Q/YaNiqnBcjnhnZYSTOB
 wwdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794145177; x=1794749977; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UlBEXto1T1vI8hqE3nAGS+RfUTo8Ud1kQT5eKzeu538=;
 b=ac7ItojYNlpUISOEuHuefkK7CCWAMe41J3XWF1EnHKgUfNOQYR/xzLSwQLJ0pDX2qw
 pirfIMrUEhkFTSnI5CbBxhGtRH/OpqpGvbo00/FUC6iIvzy68ub5QsXblY+sE4/LsQxc
 aOXGtekb1MUJYeoPzSJoTIJnWbCuGzaJTOgNOqwF7Vi4hNBpmqF36zuOkx/n8pjXo9Gu
 LSY79YPVKEcc954JULvRuIKQKE3HTQx2foAvpwAfJ3Sqoa1e1VaENJY3k7J/6G61WRKN
 VeYaIUiko+isLW42+uXx7xhFOyMOIdNNfg+z+mGz3Jp9N+gsdkhvF1F8RHPQM/BlNXtG
 dY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794145177; x=1794749977;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UlBEXto1T1vI8hqE3nAGS+RfUTo8Ud1kQT5eKzeu538=;
 b=tPxiBgv/MRaiCx92HnargHS5OpLABc8F2rJ0k0v68Vs1TplUoGAJdlpFGslcBWc5pf
 Vq1gY5iw4/TptUwnjcjbydV7PrU5csdmR+esxWUGL6UggSWNRdocSoIlMoMdd9E9peM8
 4K/FDyRXJ6fgEpOg8Bl5cxYH0hJn2isfcgOCvQnZREf1+uNIgv9yDLYQhZLih0k9nMDw
 eLn6y0DV+CutWTGdAUOlEkyDL9luDlbSG1D6R20YCA+bLM9vSmL0mgM79nkbMp+j+JfR
 V9N/iI+cs/kr28FDcwNA5urHw71GDM99MGy8574wS8LqeWOpc9dZiOCzoCsirJ5ct3G7
 LjJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHi7JNHDapLpWjfw/y0y84udMo7ZsPEKLePn748iDZRwVxhvLfE2pgCG8J8rUaMUX8qjw8SY3H9WMk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FUE5uq1AalDo6O/sk9daAQETlcDOTjZznpJPmAm2t6uEgWi7r
 /5oeA33sL7xL5lUQ+p3ASCthGARKsZqWPrEtxgpQlEOa/NPOJzzDxdtkjqXMOqmykk7jwG3Zb4v
 STvfjoR2jNw5jLnnjC+RtqfcOqNNiKg==
X-Gm-Gg: AYBFou3Gky+/hDJwkB0GI8pbLNcaeET9iPsSkc3AnaxfxD2rYqj4Nk3zjKQvbPQK5iu
 RiKQ1j2AP7GNZg0ZgquQIaLW4u46TebhtE/7wfSh3iQI0ZYUeq75JKLZ+hGxAUBv8PbBpkPH/yh
 Eg/0WUksw8grl9h+Lx9EnqT63fkgrFhvBQmkQKyA1ZUqjC6CSWleM/Sd0MlNAyXBFqjmdyo5H21
 EWTdffOG2jHZmYpoMnpjg8qTg5DlwZvnt3eE+vcERIkjoNLJ0XoK3yh2yFMSCqnbN9dmqeUOkac
 4lOTrZG3WT7b3JFqB0cXMCqKA/lkf2gaOe5B31sChrZLOnr6U61xfFP6gELgjVK8/JqU7n/mjY4
 WuHHLB0EWK6PUhmi1a4u+Nekl2naf8EwpgCEqZah3xsw0AclHhaSRTXCquwqz7FVIZDONEwYj2W
 4i8+JAzVcRb71tvgR8e8KsVk+kQHpjdIUBoPn7DSC42FJqn5s9OmzLkhD0w8oHVVD+5E5FZU+n
X-Received: by 2002:a05:690c:a409:20b0:8ad:bc2e:aad1 with SMTP id
 00721157ae682-8b36cabd454mr7511197b3.17.1794145176847; Sun, 08 Nov 2026
 05:39:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104073813.42429-1-amittibi123@gmail.com>
 <202611080509.DZUY4PHf-lkp@intel.com>
In-Reply-To: <202611080509.DZUY4PHf-lkp@intel.com>
From: amit tibi <amittibi123@gmail.com>
Date: Sun, 8 Nov 2026 15:39:25 +0200
X-Gm-Features: AclHuK_I5WkeXU-gQuiNieSTYLoAn5BYgpouXG5w6Wv3IGW4uW1lu1ln3eX3ZS4
Message-ID: <CAL-THtV1B8cYx0mV6PMKBmy-deNvhWOKw3kCRYzy96UjasqXZA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Replace deprecated DCS display-on calls
To: kernel test robot <lkp@intel.com>
Cc: neil.armstrong@linaro.org, llvm@lists.linux.dev, 
 oe-kbuild-all@lists.linux.dev, hanxu5@huaqin.corp-partner.google.com, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, icenowy@aosc.io, 
 jagan@amarulasolutions.com, linusw@kernel.org, robert.chiras@nxp.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000f10a5b065fc3f9e7"
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f10a5b065fc3f9e7
Content-Type: text/plain; charset="UTF-8"

Thanks, I'll check them out.

On Sat, 7 Nov 2026 at 23:44 kernel test robot <lkp@intel.com> wrote:

> Hi amit,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on v7.4-rc1]
> [also build test WARNING on linus/master next-20261105]
> [cannot apply to drm-misc/drm-misc-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:
> https://github.com/intel-lab-lkp/linux/commits/amit/drm-panel-Replace-deprecated-DCS-display-on-calls/20261104-093813
> base:   v7.4-rc1
> patch link:
> https://lore.kernel.org/r/20261104073813.42429-1-amittibi123%40gmail.com
> patch subject: [PATCH] drm/panel: Replace deprecated DCS display-on calls
> config: loongarch-allmodconfig (
> https://download.01.org/0day-ci/archive/20261108/202611080509.DZUY4PHf-lkp@intel.com/config
> )
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project
> cd708029e0b2869e80abe31ddb175f7c35361f90)
> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
> reproduce (this is a W=1 build): (
> https://download.01.org/0day-ci/archive/20261108/202611080509.DZUY4PHf-lkp@intel.com/reproduce
> )
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202611080509.DZUY4PHf-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c:356:10: warning:
> variable 'ret' is uninitialized when used here [-Wuninitialized]
>      356 |                 return ret;
>          |                        ^~~
>    drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c:350:9: note:
> initialize the variable 'ret' to silence this warning
>      350 |         int ret;
>          |                ^
>          |                 = 0
>    1 warning generated.
>
>
> vim +/ret +356 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
>
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  342
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  343  static int
> k101_im2ba02_enable(struct drm_panel *panel)
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  344  {
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  345   struct k101_im2ba02 *ctx =
> panel_to_k101_im2ba02(panel);
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  346   const struct
> k101_im2ba02_init_cmd *cmd = &timed_cmds[1];
> 7bb5e5e01ffc36b amit          2026-11-04  347   struct
> mipi_dsi_multi_context dsi_ctx = {
> 7bb5e5e01ffc36b amit          2026-11-04  348           .dsi = ctx->dsi,
> 7bb5e5e01ffc36b amit          2026-11-04  349   };
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  350   int ret;
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  351
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  352   msleep(150);
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  353
> 7bb5e5e01ffc36b amit          2026-11-04  354
>  mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> 7bb5e5e01ffc36b amit          2026-11-04  355   if (dsi_ctx.accum_err)
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16 @356           return ret;
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  357
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  358   msleep(50);
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  359
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  360   return
> mipi_dsi_dcs_write_buffer(ctx->dsi, cmd->data, K101_IM2BA02_INIT_CMD_LEN);
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  361  }
> fac47b1ebeda3b5 Icenowy Zheng 2020-01-16  362
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

--000000000000f10a5b065fc3f9e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div>Thanks, I&#39;ll check them out.</div></div><div><div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 7 Nov 202=
6 at 23:44 kernel test robot &lt;<a href=3D"mailto:lkp@intel.com" target=3D=
"_blank">lkp@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Hi amit,<br>
<br>
kernel test robot noticed the following build warnings:<br>
<br>
[auto build test WARNING on v7.4-rc1]<br>
[also build test WARNING on linus/master next-20261105]<br>
[cannot apply to drm-misc/drm-misc-next]<br>
[If your patch is applied to the wrong git tree, kindly drop us a note.<br>
And when submitting patch, we suggest to use &#39;--base&#39; as documented=
 in<br>
<a href=3D"https://git-scm.com/docs/git-format-patch#_base_tree_information=
" rel=3D"noreferrer" target=3D"_blank">https://git-scm.com/docs/git-format-=
patch#_base_tree_information</a>]<br>
<br>
url:=C2=A0 =C2=A0 <a href=3D"https://github.com/intel-lab-lkp/linux/commits=
/amit/drm-panel-Replace-deprecated-DCS-display-on-calls/20261104-093813" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/intel-lab-lkp/linux/c=
ommits/amit/drm-panel-Replace-deprecated-DCS-display-on-calls/20261104-0938=
13</a><br>
base:=C2=A0 =C2=A0v7.4-rc1<br>
patch link:=C2=A0 =C2=A0 <a href=3D"https://lore.kernel.org/r/2026110407381=
3.42429-1-amittibi123%40gmail.com" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/r/20261104073813.42429-1-amittibi123%40gmail.com</a><b=
r>
patch subject: [PATCH] drm/panel: Replace deprecated DCS display-on calls<b=
r>
config: loongarch-allmodconfig (<a href=3D"https://download.01.org/0day-ci/=
archive/20261108/202611080509.DZUY4PHf-lkp@intel.com/config" rel=3D"norefer=
rer" target=3D"_blank">https://download.01.org/0day-ci/archive/20261108/202=
611080509.DZUY4PHf-lkp@intel.com/config</a>)<br>
compiler: clang version 19.1.7 (<a href=3D"https://github.com/llvm/llvm-pro=
ject" rel=3D"noreferrer" target=3D"_blank">https://github.com/llvm/llvm-pro=
ject</a> cd708029e0b2869e80abe31ddb175f7c35361f90)<br>
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)<br>
reproduce (this is a W=3D1 build): (<a href=3D"https://download.01.org/0day=
-ci/archive/20261108/202611080509.DZUY4PHf-lkp@intel.com/reproduce" rel=3D"=
noreferrer" target=3D"_blank">https://download.01.org/0day-ci/archive/20261=
108/202611080509.DZUY4PHf-lkp@intel.com/reproduce</a>)<br>
<br>
If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of<br>
the same patch/commit), kindly add following tags<br>
| Reported-by: kernel test robot &lt;<a href=3D"mailto:lkp@intel.com" targe=
t=3D"_blank">lkp@intel.com</a>&gt;<br>
| Closes: <a href=3D"https://lore.kernel.org/oe-kbuild-all/202611080509.DZU=
Y4PHf-lkp@intel.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ker=
nel.org/oe-kbuild-all/202611080509.DZUY4PHf-lkp@intel.com/</a><br>
<br>
All warnings (new ones prefixed by &gt;&gt;):<br>
<br>
&gt;&gt; drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c:356:10: warning:=
 variable &#39;ret&#39; is uninitialized when used here [-Wuninitialized]<b=
r>
=C2=A0 =C2=A0 =C2=A0356 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~<br>
=C2=A0 =C2=A0drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c:350:9: note:=
 initialize the variable &#39;ret&#39; to silence this warning<br>
=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 0<br>
=C2=A0 =C2=A01 warning generated.<br>
<br>
<br>
vim +/ret +356 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c<br>
<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 342=C2=A0 <br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 343=C2=A0 static int k101_im=
2ba02_enable(struct drm_panel *panel)<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 344=C2=A0 {<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 345=C2=A0 =C2=A0struct k101_=
im2ba02 *ctx =3D panel_to_k101_im2ba02(panel);<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 346=C2=A0 =C2=A0const struct=
 k101_im2ba02_init_cmd *cmd =3D &amp;timed_cmds[1];<br>
7bb5e5e01ffc36b amit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-11-04=C2=A0 347=
=C2=A0 =C2=A0struct mipi_dsi_multi_context dsi_ctx =3D {<br>
7bb5e5e01ffc36b amit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-11-04=C2=A0 348=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dsi =3D ctx-&gt;dsi,<br>
7bb5e5e01ffc36b amit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-11-04=C2=A0 349=
=C2=A0 =C2=A0};<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 350=C2=A0 =C2=A0int ret;<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 351=C2=A0 <br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 352=C2=A0 =C2=A0msleep(150);=
<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 353=C2=A0 <br>
7bb5e5e01ffc36b amit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-11-04=C2=A0 354=
=C2=A0 =C2=A0mipi_dsi_dcs_set_display_on_multi(&amp;dsi_ctx);<br>
7bb5e5e01ffc36b amit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-11-04=C2=A0 355=
=C2=A0 =C2=A0if (dsi_ctx.accum_err)<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16 @356=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 357=C2=A0 <br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 358=C2=A0 =C2=A0msleep(50);<=
br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 359=C2=A0 <br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 360=C2=A0 =C2=A0return mipi_=
dsi_dcs_write_buffer(ctx-&gt;dsi, cmd-&gt;data, K101_IM2BA02_INIT_CMD_LEN);=
<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 361=C2=A0 }<br>
fac47b1ebeda3b5 Icenowy Zheng 2020-01-16=C2=A0 362=C2=A0 <br>
<br>
--<br>
0-DAY CI Kernel Test Service<br>
<a href=3D"https://github.com/intel/lkp-tests/wiki" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/intel/lkp-tests/wiki</a><br>
</blockquote></div></div>
</div>

--000000000000f10a5b065fc3f9e7--
