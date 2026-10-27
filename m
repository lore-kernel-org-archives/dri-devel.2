Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF705606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fM/2mr+x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FEC10E025;
	Tue, 27 Oct 2026 00:26:51 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3B110E025
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 00:26:45 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-676804a3a22so3568823d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 17:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060804; cv=none;
 d=google.com; s=arc-20260327;
 b=eSfkbTGtf5xM0Op0IYqQZ/ASEgOxAfbrR77EKRjvpWOgWnQGWEhyR/w3kNIwhUK9p+
 ze9raxCxmsmho13WfPywTGzajwrZvm24Yu5EDEFIaX3exZRlyYxeTx4YqR7CUAhcO8P2
 Sec+ao6DFBZ7h7sB6l2f0tefymq4swGZYRAWZt0spQXXx4GlXlF3nqGX3vyKOASo855D
 hWtNPWryqVOWO2ThREy78jTnofMxN1wArvPXhZdwujONlQvpRljz8LRsgShOBKiUQ8ZY
 BJN4OSWvavzFWtYFiVJ6qegrdwJJpZaA5lwpu4jaY3aseGB+sCfmr5EoCDzGJWh+bSqb
 NGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
 fh=Ex586fU952q6bqj+23e9vlTuyE+DwyugdtpR7aQkQFA=;
 b=Vz4HQthK+oFG4OA0czgIelwcTgpaTNVSaIGasz+5t/UusE/Q37f//LSAo7IBf9rcJ7
 3L7I589eCNrMzpPbI9p10fiNyots3Kry8sbilzYPIellSnMFqaVWVyezT0i/s+/xeIzT
 xox5i5pVEf8Ar6P1oKDfng/up7ysqLNQzs2H+zf81ULnhrrbWbUpDG+I+sdQiRC/Heet
 fDgnB6xV+saURldJzSnAcmOL/7uIwm3sOAhc7wJ230Y9/tV4xliqP2pFgPncjFVSBPnN
 ye08cl6HdPrHOATcQzdILubjbtvSlqohTiKH3d4pnfhccRasWfP1ESdwCzsRE/geu3rK
 /ryw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060804; x=1793665604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
 b=fM/2mr+xG6JMX76y0E1PyBH1eSVeF2kHg4gXDB1BJK60YzvkzYMZwOtV8cM9o1fctA
 QwoYKX94xj+yP/yolN5CXd4TQs4np6IVlRGFZd4p1B/xWJ9qKtLo8kNIqOD/qJ117Jfk
 S+UyJY4vAJrtO6V4oIywl8ea6qPEjTGBqeh62sD0jgVNu8IA5F91CMYaxQ0KE1MtAU7t
 6D/FvGuAQs/73+y2T24PsBRfMIpIjSQzRRl4HeqwvHDZ7V0fXT3wgtzufia2M/WeTscH
 xmeF1K+v5EfmD19fiPjdjpHmEFQdColbcv6fXomMoILWynhbm2a3DFUdqYBkKnVPZnTe
 hbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060804; x=1793665604;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eybqDydWM/qmE6WTUncvgQt2QyS6Zq7ps/uXBzvWlWc=;
 b=UnsdqeJIu+kPySboywVHGkX/GI3mlEmQCFpq1JT/ns4FlEITckQBXYOIAV2CUIIhAU
 vkTnGP3y82qsKf2QPNYSRO2+I0AfdvMVvebvkKihFUnCb8NOlcc0g8roSjx5n+9ABSYN
 /5xN7qCEWwEzMu78CcivokmPYNpb48qIX0UIxStYVP8tJoxF+BZHVfTSTJEKONUkEmTC
 SUQfCtma39+lDq4ZuVbQ7f3d0Fg93wmPziwSJRcCir1GBahdYBzCoeebC906Hr+Ngc9K
 cV+4Fy7EBaHZ6KJpEjRBt5jQfNaJZrBMW15xOibj3ugnt7v5L/VY/nQLDeFnv1ih51nl
 +48A==
X-Forwarded-Encrypted: i=1;
 AKwUvByyhRyACk3RrG5dffcEnBsSRaU7HZmWug5mZ28xrUJ77ds7pBYCiMllToBzJzMSn16FlH1UEdBKKwY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqhWYciruho4+AH/i4H4ChfeFTUMjCRuy/uCVqDXbB9i5OlfCv
 WNIOc9dW0+wFNU+W5qpNSyR90sOo4SFHN+gN7pQjY/Fby8JDW/TkV9tKPon7ENSELPg8o0grQyg
 iJiCeIJZaIdhc1NPxQTthh+ctjCZdjtk=
X-Gm-Gg: AYBFou1YATZe75RS6Y6Z57Rix4JWC86z0JBZkWjKdnyQgK7gAGzoj870mVIN1cu4Z10
 OMBndFpHHzxXeU9V9D5gyMpZ6PAWpzWrjNlaJsbGlxQRQu0m0bcR0JM5k9iPjj7VDO2Tj6lyBjR
 vTqrLxWBGZWVNASoXc3RTwTR6+xg1vc9HXmL/ffRa5rDo1z/Vl67IsGzPxTguFSMg+kQieATeyz
 R5+9Y1ueiLhqWerSEnt7xELnmXzYD7tb35RDqwMQf+fUgCAWX9nGWqK5QA1nd1fYwcR0POIfG5Q
 5J4urDPU0dkqofaAn0EbwLO+Skjc9GNZJgBAV3T8K/DxHdcozguj6jBaJlKw+h2tKQqRrEc2uE6
 VcVwLph+mtvNOJeurj/Bn7MxMKwKPc6oBX4TXrs7reZIXnieIRvaeX5LItXc2ccqhsbot4bs2Wt
 0AxqwHgO5fEGjaElg=
X-Received: by 2002:a05:690e:450e:10b0:677:ca67:98f4 with SMTP id
 956f58d0204a3-67a453de253mr3907194d50.45.1793060804234; Mon, 26 Oct 2026
 17:26:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-10-3c8cc5725def@gmail.com>
 <sashiko-outbox-170703@kernel.org>
In-Reply-To: <sashiko-outbox-170703@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:26:18 -0600
X-Gm-Features: AclHuK_jv-lTnu6VYS2062o39f_E507yFRpnLLpthRIG1YaVwpNMuyVZmZdMW28
Message-ID: <CAJfuBxwNEG2ukJbPyVqdu0jKN4_CGh_ZR1pYj1z6AJTErfLakg@mail.gmail.com>
Subject: Re: [PATCH v12 10/40] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
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
 linux-kbuild@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
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

On Tue, Oct 13, 2026 at 8:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] dyndbg: documentation references future struct _ddebug_class_map
> --
>
> commit 4edbf52dcd2e7bd06805f06e89c8d2ce8672c81b
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
>
> This commit removes the unused DD_CLASS_TYPE_DISJOINT_NAMES and
> DD_CLASS_TYPE_LEVEL_NAMES classmap types and their corresponding code.
> It also renames enum class_map_type to enum ddebug_class_map_type.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index a10adac8e8f00..9607121c3072e 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
>
> [ ... ]
>
> > @@ -119,8 +109,8 @@ struct ddebug_class_param {
> >
> >  /**
> >   * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
> > - * @_var:   a struct ddebug_class_map, passed to module_param_cb
> > - * @_type:  enum class_map_type, chooses bits/verbose, numeric/symboli=
c
> > + * @_var:   a struct _ddebug_class_map, passed to module_param_cb
>
> [Severity: Low]
> This isn't a bug, but does this documentation reference a struct that doe=
sn't
> exist yet?
>
> The comment here refers to struct _ddebug_class_map (with an underscore),
> but the macro DECLARE_DYNDBG_CLASSMAP currently instantiates struct
> ddebug_class_map. Is it intentional to document the future name before th=
e
> actual struct rename occurs in a later patch?

yes, intentional.
using future-name avoids having to fix it later.


>
> > + * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
> >   * @_base:  offset of 1st class-name. splits .class_id space
> >   * @classes: class-names used to control class'd prdbgs
> >   */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D10
