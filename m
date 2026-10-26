Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D246606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AKptj4iF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B124710E1D9;
	Mon, 26 Oct 2026 22:28:07 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF4B10E1D9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:28:00 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8565d77c277so29342837b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053679; cv=none;
 d=google.com; s=arc-20260327;
 b=kxPsya8qHIu4KA0UgAUxTgI7A0HMu17HyF3uLz+jxrvQF4CUxYor17BbLW4VaKbcmj
 yfbkHdd8DjqGm4xL4PYHdUzlvf6ii94h2UNXbiqJtakOKf2vJYxhx1gAxY52wcoBZ05l
 spEypzRTpJQN+qBQMXDf+a5QtYwt3COPlywDf+Nk5/EVpivxVeOHPQHhSgE8gtWw7gGc
 +zZt0f6lQQnpLWvEZ2OzZNQ3MWNqIS6e2Nwp6n3oU/1B2OHJl3AxUF79S0+iTihHdB48
 2qW9ljeGbwQWdaXLAaKqolywpJSaXUiJShszj6hS3DRFoZXPCaMCiPIFe+QTgUGjzFYf
 TtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
 fh=jhUT3T+ABw1TK0bCL7dGfDzxFl2q1ig1eKqJP2AzZ68=;
 b=acRrk8THmeFBE9bgeJ04E/IMsAj4YNUIP7TWlqfjFKzGGblG7WfN5PrWJjNnJSr9kz
 9FsqiAA/ZmJ2lmN0HLNO8r0nNHrvrFqrqEAoPETGAnT8Zw+9Up+WIjawMHn0ldh8/Hdg
 GIVXQ6Z7tnyzx0MktIEf/YCEhp7FKVjMaOHhp1BZQaA2PrA6LTnKrR+PkbdRSU+PWvKo
 iUr1VYebRThbQsaN5cVC45/514w6bbkkkeUsNV8I+i6p2EPwCJDiR6FgY78TnKBG2veS
 d5INTDb1S6+jVXCHZZzwpPRJIDFX2eT1Er6Av2WkKfNVDWVZsyR6AaIhrwmGS52hmeZ3
 6Szw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793053679; x=1793658479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
 b=AKptj4iF8TVLFQ7Wx+oiCaESy/SRcJn1hg5FQdeIqxDa3ynadJSq24rQw7HIXZ/0MD
 8srFzCU7ikeVIvaKRVVdASD6t1UBznSygileqV3IEXfVNKu2ilYDkqwzhkvCVhhGexHS
 gebw0vckJ8lqQBdx1VxnU1YyZTPEKMJqd2dUtQv37fgxUt2+wOnjyRyHXZCv/2yMs2W+
 0/k1OeVxVn7D6QZlrWm4oIop2lZRDQsNZ6OwHkrMgIGg+Jnl5VIWWfWFUyn7VfJWJtEJ
 8WxMOp/q3WLm+JO/IJ6JregkC9kAQxpa0gAuMHmPiH2wzi3sXofI+MWM7rygtqlLgvr0
 Kk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793053679; x=1793658479;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K6A7J4OpJDcLLheDWUIyyi0Xo+zxVRi79rgHbCkqBj8=;
 b=v6iZpitnWv3yThRnxfEj6aRT3dlV3e9pkL930p52dm8f7EBJxoMfFdf32YqqLmjzdz
 cfT0IZzUkvMmVzEgq+asUyVMCvuvi3/cveuAw9cmfH+R1FVN7+p26gsx0wcCnE/WM8qu
 6XMmMvSH7IYnTMArM8zT0cdYumq14BOtmY6ydLQoHKhF8bIaV6MVMdF0MwZNw+7GSokG
 OG435tYjG3TI21VRQ9TAVV8umSp57XhFclUKx+rCdeyE2BztYlxwxQx9gaQMLCbbrNzQ
 F6qROJ+FUbfkBgJDciGDhHsFTpig7iZOfPDWNuCu3L8oZ/VBGY9eqDdiKXytpNAmB+uN
 O1mA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1VMATvGuSaWXPubIMmGiH0dDUe8wgrwhNM1F4hZm1KucGvnmZhQqMMH/Xe3YkOGcIaji0xPQk6n0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJsSAkqAvgFKhB5lfwU4G79AOkf34d8sFxdYHlVl4Z5Q/FchMKC
 HdE1dHoV5I6bc96oHvCyy5VA9jiCr2AYKZYy1KS/qzdo71itOYsftgLk3JR3Mi6j0R/qKr7sGnN
 IVkd66AIGFtnKuIviJiPFObq6A0m+e4k=
X-Gm-Gg: AYBFou2JwGDnVD/ZyG2PwdAXZS+qT+CeDMGRSvUnT9VF5MimPk6aXgYs/Ph/XzDPHqO
 9idhYqrR3RXn1c1JsIJl2VRnoJRC/ynCXZ5Mr3rT7BZD94nE6cnVxZxKl8nWhyOj3Ii6D5UTTxw
 ZL/Ra+7omsZZ+1htfgqb/V6IRDlFOX38A5Nk5OkNgW/zQdjbeSrhA9hsOSpIrL9TphoIoulzwEr
 yEqC680I2VQArPggXg9Bg8ewuzt3icT0HMKQ88/R+4oEXm3w7/h2gYYvTHQbj7VCwLvpwDZzJNH
 3c1sf85ABzSfDEWsmfi1q+hccJfKaZQMfqBznqX2hTQ6+U7aFfQ1UWvWJRDSlWgLT4bj18io/VZ
 o8oK6YNIvLG1k537F1eb6vYhucdbOCsOR0B9NvZF6JyrzhM9DjC5oVLViGl45P1jXChKcg2eUzw
 VWXKmAz9BI1GH9vwI=
X-Received: by 2002:a05:690e:1548:20b0:679:afc3:b990 with SMTP id
 956f58d0204a3-67a455751ddmr3346085d50.152.1793053679299; Mon, 26 Oct 2026
 15:27:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-23-3c8cc5725def@gmail.com>
 <sashiko-outbox-170722@kernel.org>
In-Reply-To: <sashiko-outbox-170722@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:27:33 -0600
X-Gm-Features: AclHuK-iFp5xqB6d-LRnKDMtWnZXSOdE3cMaERLXso3BmPK_qGi1CmXSW6vaeP8
Message-ID: <CAJfuBxw9uTaqwRudCe7r8_G3-jh+VvRoEzoY-OcZXC=WpctzOA@mail.gmail.com>
Subject: Re: [PATCH v12 23/40] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
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
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests: regex flaw silently excludes submodule from test as=
sertions
> --
>
> commit d0e8e8cb940b9b06248942fb57c7a41c66ad8636
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod, verifyin=
g
> that class settings and controlling parameter states propagate from paren=
t
> classmap definitions to dependent class users upon module load and during
> runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index c279c795867b6..d759243a4cbe7 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -291,6 +292,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> [ ... ]
> > +    # Real-time mathematical proof that load-time (modprobe) parameter=
 parsing
> > +    # and runtime (sysfs write) parameter configurations are perfectly=
 equivalent!
> > +    local hash_modprobe=3D$(slice_and_hash_ddctrl '\[test_dynamic_debu=
g*\]')
>
> [Severity: Medium]
> Does this regex fail to match the sub-module as intended?
>
> Looking at FT_classmap_inheritance(), it calls slice_and_hash_ddctrl() wh=
ich
> uses grep to filter output. In POSIX Basic Regular Expressions (BRE), the=
 *
> quantifier matches zero or more occurrences of the preceding character (g=
).
>
> This means the regex matches [test_dynamic_debug] but demands that the
> bracket ] immediately follows the g's. It completely fails to match
> [test_dynamic_debug_submod], silently excluding the sub-module from the
> load-time test assertions.
>

fixed in v13

> > +
> > +    # Fresh load with default parameters, then configure them dynamica=
lly at runtime
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +    my_modprobe test_dynamic_debug
> > +    my_modprobe test_dynamic_debug_submod
> > +    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_b=
its
> > +    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
> > +
> > +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug*\=
]')
>
> [Severity: Medium]
> Similar to the issue above, does this regex fail to capture the runtime
> state of the sub-module?
>
> This allows the equivalence check between hash_modprobe and hash_sysfs
> to pass without actually verifying the sub-module inheritance behavior.

yes, now fixed

>
> > +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> > +        echo -e "${RED}: Load-time vs runtime parameter equivalence ch=
eck failed!${NC}"
> > +        exit $ksft_fail
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D23
