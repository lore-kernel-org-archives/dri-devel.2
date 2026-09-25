Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B59DC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7937010FC5A;
	Fri, 25 Sep 2026 20:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dyzEcOJi";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE2910FC5A
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:31:23 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e56a1b327so1182158d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790368282; cv=none;
 d=google.com; s=arc-20260327;
 b=VdkfQY+xq2RNYpVH2VNJJYKqEpRoecsxlK5ahtkYlF+jqon6PG8yAsuL/TuHjrtyRe
 a/OyPYvFah+0YqhfRHMtAwp+ZzKIzk5aChNcy8Y5qJl1WfBqxAfgB2MY4upfLBtpJPve
 q8DjTZrUQ2zh1AwTPz0tZQGnh8tyPrHrDZvM/xPE5T2q2NChg9GWD/wtZFuvVmedHIAc
 S2Q455Eu8oCistRee+h4CHHA5hCx70KfDa9h6EwzCf1cqtK2drpi+h8FV55nji1Id/YW
 VvoVY98v0MS2lIqR0P+ctvkVEDglsrM4bIWTu4DtLwa9tx2j4E9Tm70747qOxR72JJ9l
 WEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
 fh=cSGVvqGR3QRJInlhqttoi9It0snLe5O9eEUr224NmLI=;
 b=EUIA/RRGU4vxhI3f2vYBP6zTR+VrivMviKKj8Y/NwB4R/gxcGGLj/syFCcMyToBq0C
 7vYyjBaBSnfLWJ80+7vf/XUFsNa10SkXt72eif5IfeCdt9zoS/zs4FbjzXEP9gxdvRNC
 Rm9RVGyHOl5RayKS97zyjxjfKH0xAicEuRq68Vv/3ibh1Ai6N+P858nGOlAf61B+LND2
 hgvtIirexaLFSDFVztkPDD1xGZDHHiYIDSjs1rmFw1XoHGC8ffnC3hwq+RuSK/pmiCfj
 aJS3ZNRRJxh5eKoVnuY0imq7CV+cDBgz1mN4tUKuUQugQNZgeMyoWm+8L+deEgurrb4K
 bZtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790368282; x=1790973082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
 b=dyzEcOJiR5Hn3BcZUutz6ji5Ch/qHURV8z1WklcyMYMUfIxUMkxTnHtduLf0+ll04Q
 JcS+Wp4CLhLumrX4F00tZU/xPwF+DC9Fo+pQrcaqrz94fvN+5Xl4pEqaV1Dig3TrFXT9
 o2ND/MMQGtaQkCJ5FLQTS6nYREuN3wQkb6Pi7ES62+X2Zg4UwzOjqgqobL8I+OLBYZg0
 6I3XiUWrNAi52V28GBGU2BIheiLXeRzcAHyQXaefDMAP8thQf1k8S8+KjKzAHi2a0pyf
 2jWhXsplXz/uulln3va3qUMiIST2kPQ6QKz1Yefgk/j7dGa/BULpGoBe2sXbPO8LLvBq
 DB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790368282; x=1790973082;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
 b=rtj2mIgLannHkpZqi+t23FcGM5583HGaYLQH3vmodgT3VzUI/RoGkwgh3zNzaQkNEd
 IGiWJdYfABP5J898WXcI0K+HhFVgf9xpGb64xX8QdUhbzgRYADwhxcHXv9026ah++STB
 Q677bk/A/EmSH1LfUBXVTf3XUEVM/yKBb02gBQeTu2ZpsOgaBN2wOR3/CIlBAifq+gNk
 byfZxRcVSrJGaEMRbvJGX/fuSSHcmXIGRyhLFXPWPYbPmtelpLAeH0dnHQ3sGC7Ya+Ds
 GpHhRgmo4Yl/veWH8J36on2PZjD9L7tqxukuCMOVVnjZkc7Bq0rxwaHzWSGn/B2zskDB
 nJsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCt5K2APwiwpRbd8fzA3XhUf3x8nxA4p6gkijWCwaxz4VlfIE9TLkDr4ttMmoHeigTIzI3DO3R3do=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTo/AKSINF+3LPuZ+qA9S+Y4wzPrSIdvC1SzbfoR4dyVThZHp1
 cnJ3TBQ+6GpGXhh8m5Y/DcYtE1ujPobcGzFEq2GY6B4McWlm4xmSqMkRZFsMXXJQwALSfqmkJLJ
 f2N8p/euJYKZPTEYduhsulX4eusEqDrY=
X-Gm-Gg: AYBFou0M1n5+d0BIZ/LknnR8H1ltahsS+rGZ1nIrr5s7bnIBXFAUwVHmFPnCR5QrEQY
 RLC2SSbZma+Eof3Xzk/c5w70V89oZU8baiHq/ngT8+13SiRfKvvzN6MDB5QnoP5Tw/R1+/wp3JB
 waF8PHlEcVM+JcRb7p/hOJ5zdr6BjlsvG17NjE30SnBETtZAJcX5+NGoCBJX0pCg6U6RxP1QwuK
 kpQoau11J2f2dNVX5IqVK+AavYf547PXnbc9lHr4sNxB3F3j0c+3u0H701OOhl+i/OOJ25sE7l7
 VUrrkxx0FDQihD2TcF970bP61ZIrewgrdRrQDN4RQ7qNlvjxCML5rdTi3Qy+WFeeUMBXe4VXLBl
 WFVbeHpAt2NRh1ubiSuwvgkBSdMVHy9kCEw==
X-Received: by 2002:a05:690e:1382:b0:672:a289:7b0 with SMTP id
 956f58d0204a3-672ed93a88emr3463724d50.76.1790368282266; Fri, 25 Sep 2026
 13:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
In-Reply-To: <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
From: jim.cromie@gmail.com
Date: Fri, 25 Sep 2026 14:30:54 -0600
X-Gm-Features: AclHuK81aQy7pcphOyoCN0Cv4efDR1k93Uxkj909m52hc-_PgnQGdKhUE2sknH8
Message-ID: <CAJfuBxxd8hMf0OcnOK+w-QyizaKY=WA4VL+fyoD3y6EsHW1+og@mail.gmail.com>
Subject: Re: [PATCH v11 00/38] dyndbg: Fix classmaps API for subsystems, query
 extensions, selftests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Philipp Hahn <phahn-oss@avm.de>, 
 kernel test robot <lkp@intel.com>
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

On Wed, Sep 23, 2026 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 23 Sep 2026 16:34:24 -0600 Jim Cromie <jim.cromie@gmail.com> wrot=
e:
>
> > The drm subsystem has *lots* of debug statements, in 11 categories:
> >
> >  $> git grep '\w*_dbg' drivers/gpu/drm/ | wc
> >    5663   30159  542864
>
> Methinks this regexp was overly promiscuous, but point taken.
>
> >  $> git grep 'DRM_DEBUG\w*' drivers/gpu/drm/ | wc
> >    2206   12834  202332
> >
> > All of these are bit-tests on __drm_debug, exposed to users as
> > /sys/module/drm/parameters/debug. Many of these are done often;
> > vblank is done ~100/sec for some displays. Over the uptime of many
> > boxes, this is a lot of cpu cycles on bits that are almost always off.
>
> A __test_bit (or |) every 10ms sounds quite negligible?
>
> Especially if __drm_debug is __read_mostly.  Which it isn't, afaict.
> Um, low-hanging fruit?
>

__drm_debug certainly qualifies.
I will send the patch, separately.

patch 37 adds a +c flag, to count invocations of flagged callsites
it counted 5M calls in 60 sec.  or 83 KHz.
That seems "fast-ish" at least,
perhaps worthy of a static-key over a __read_mostly



> > Dynamic-debug excels at replacing such tests with NOOPs (via static
> > keys). Classmaps was devised to bring that 0-off-cost to drm's
> > categories.
> >
> > Classmaps-v1 went into the kernel in Sept 2022, in 2 chunks:
> >   b7b4eebdba7b..6ea3bf466ac6    # core dyndbg changes
> >   0406faf25fb1..ee7d633f2dfb    # drm adoption
> >
> > Sadly DRM-CI found a regression during init with drm.debug=3D<initval>;
> > the static-keys underneath the drm-dbgs in drm.ko got enabled, but
> > those in drivers & helpers did not.
> >
> > So in Feb 2023, it got pulled:
> > commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> >
> > Root Problem:
> >
> > DECLARE_DYNDBG_CLASSMAP defined the classmap, but its repeated use in
> > both core and drivers violated a K&R rule "define once, refer
> > afterwards". This flaw resulted in a regression; with drm.debug=3D0xFF
> > boot arg, drm-core got enabled, but drivers/helpers did not.
> >
> > This patchset replaces DECLARE_DYNDBG_CLASSMAP with:
> > - DYNAMIC_DEBUG_CLASSMAP_DEFINE (invoked once in the exporting module)
> > - DYNAMIC_DEBUG_CLASSMAP_USE (invoked repeatedly in drivers & helpers)
> >
> > _DEFINE exports the classmap it creates (in drm.ko), and other modules
> > _USE the classmap. The _USE adds a record referencing the _DEFINEd (&
> > exported) classmap in a 2nd __dyndbg_class_users section.
> >
> > At modprobe, dyndbg scans the new section after __dyndbg_class_maps,
> > follows the linkage to the _DEFINEr module, finds the (optional)
> > kernel-param controlling the classmap, examines its drm.debug=3D<initva=
l>,
> > and applies it to the module being initialized.
> >
> > To recapitulate the multi-module problem wo DRM involvement, we add:
> >
> > - tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:
> >   Alters pr_debugs in builtins and test modules,
> >   checks results against checksums of expected results
> >
> > - lib/test_dynamic_debug.c & test_dynamic_debug_submod.c:
> >   Builds parent & _submod modules with _DEFINE and _USE inside #if/#els=
e
> >   blocks, reproducing the 2-module scenario under selftests.
>
> So what I'm understanding is that this series presently has no effect
> upon DRM?

I have 2-3 DRM adaptation patches,
then a single 1-liner patch per driver,
to get DRM using the new API.

39 patches seemed big enough for now,
if you'd like the rest tacked on, Im happy to do so.


> What subsystems *does* it affect?



>
> Sashiko had quite a bit to say.  It hasn't quite completed at present.
>         https://sashiko.dev/#/patchset/20260923-dd-cmap-part2-clean-v11-0=
-9b6c217fdf2f@gmail.com
