Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641D0C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D8710E7E2;
	Wed, 16 Sep 2026 07:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="U4TLZglt";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616D410E309
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:30:50 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c7f7cc52efso57271e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500649; cv=none;
 d=google.com; s=arc-20260327;
 b=kHOBUrE1LtnCl7wzTlBbhuj6TJFH5cKJLwjQ+LFnnML7RSvW2Z3qWMGQ4Rj+N2AA/6
 CckXvv+fDfsIUd45d9rjzj12732hK/S0SQ9AE8QXP09+GLbMNHoIrjilGMoKZUqZvZtl
 QUD4QEoKxAoMQrqboUiCJhS8KcLQHb4+MtumVjBB+d/E3QYAqAH8W0NrqZmWCb/3JCvR
 yiE0hZ2xafZk9zi7Ot0g4+lpB/qbnFLBb87fZhxY+BfZ5O4+fqnKoURYOEJngJDoS2ll
 sTwUtuGJnOzqrzpcom5Ab8qaEXxj9dtnqfyRdk/jQDn+pzsGDjFTn9DAvdsMz7leaRgH
 ablA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 fh=R6UL3XhNszrjjOZL30hEQzBproREKfS6J8gmMkeC8S0=;
 b=TGI8/Ze3A7NDOZROMfsSqNNZlX9t+DHDDwu78VQNtd7Pci/Ce4Hkdn5aRs9fORzVUP
 Hz3StLsXxESMm7XIYpkteM5FF7UEJq7/ahFxC0eGEqVOPeD2ElZ4vBezqY48eO5pBOZ+
 a0emb8TGbPBUWxpK+hAJLhbsH2OPmVUouqx95vD3tcvVqkXCBVLWZiecxnL1i2GR3waD
 WSwIU75tPK0HdlLDtp0HZuY5uP7kRsWB9oY2HpzckAqKcGZSANyVPPFDukyUUmoYtqWN
 akA/cZnlIpMRBOlRPUN59bhHJZr+sMw9gOhoCENv8qW3++ziuH7tR0sygBZFDO2hBqSx
 zgIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789500649; x=1790105449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 b=U4TLZgltCOiET7cQ13TzBg7OVicvjAvBmDx/cs6DgQPBu0oHJ7roVp/fLxYyzfrhdI
 MaN6yX+aKR/0qqpf02ADnRfD0KGMawpyS0IiJ06V80sbgk/zi0/LTdHpKkNgdfWnIMXn
 LouAKjHuDg3D/Vjf4Dd90i6uxfE5GkooTevqNttB+y3dXlD1Q2YPkgN3vHDYoAS3rQT1
 AwVkZvnRwcRAOXFxK2RAwYUIJUm5vCFGZPjQjAW52z4fziTf4cURtWL+MbUR9VNlkViX
 a04q1qE0OntDi/kt2Fk6rQOC39tKAOkActMmHFiPVtEmPW7SjyG9I1TMS43V2qBaCo1I
 QaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500649; x=1790105449;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 b=PPOwx/iO1/QQRtNY29gvg3rFYq2YtElo5OLSVj22P4SXr96DGXuygd2VeNsWY+n7/5
 6grfYw8kf2Tw1jzAUgf4NLOlk5w30FXOa13fsWz+HU3rRpXJhiinuKF3I1MFIAGc4Hs3
 5+YgUMcuM3uajr5HgSm+ytvWT2mf/IGIPOpS9WTpaNMUSiZlYU7wAbdoZS/5kFBBkMu2
 VSEVkWjNILMGUQxTNpY/eXPXhZookYtuZ6UTq2odFBni1IF8fOpgOfb33IjsRVyUZ2zu
 b6NBWVLDS4GY48dzRxnsZ3r0PyfkzOG2HjWOAIASsPkhs80QLYS8EAjblBRduIPaWXo0
 RqgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAZinGGhLeA4hjBgYZDnSEy2GtU7nJU3OIHi4sbahTDNHK3uIdCtyjTE5KYH4qRp0OEeJyjeX5EAE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mMX/9FzpLQ14Cu/Rm7tv1iu4sFfYdbncpb4duNW0YlNsT7X/Wq
 981xcG+DB0IXol35hVeHkSnuBtWUufojl7C9GW436EX4oYTycTEG88xhhZdebVFnJnyq96UP5CG
 bCY2MXrHk/tI9gjnC8xJBfmPX+dC5Iz06R2ida8U=
X-Gm-Gg: AYBFou3+Lugkpw9Zi7loO286x5Ri6hISxOrMI+9av0ZHXya9NaStEhpdNDZzqRzpKKU
 IteDEy5LM5Wve0ResP5vmF9ENf/u/sBVDK6Ba+RTKDLO+QwEckQAQ3Q7imEJWsmNdIgsVq1BlWA
 W8PF+WPCtbW5GspEnGQeK2o5lzNKJqvoKwZXwzFg3mJdVvlBmxwimBWG3OUWGvLAM+q2eF88isI
 nCIYz2hJwMedQaOJanN39NBkj4iXvYCBzyFfjjAF3tpIsQoEwITnhJv67plJKjgVt2nzODRKzkO
 rQ/d32KYobMiw9TypLmNdhqsTRwo+oYFxQ18XBLxpS30NBjlILPNt3sb40eQEN6ODYJTWDrUhJ5
 Mi03QMutergxUFMdDJnymCNsMRT7o2j6ZDrbdpmbSVebxpoDyg6WsL1O7q6avO3M=
X-Received: by 2002:a05:6122:8d4:b0:5c8:3697:9289 with SMTP id
 71dfb90a1353d-5c993b49b7cmr4231155e0c.8.1789500648289; Tue, 15 Sep 2026
 12:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-22-morbo@google.com>
 <202609151147.C5B45CB@keescook>
In-Reply-To: <202609151147.C5B45CB@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 15 Sep 2026 12:30:31 -0700
X-Gm-Features: AcwNN1W7vYosDgc2DMy2_OinBNj1qeEQ35WOY6PL8-NHlzjaHMOKmE1leyIGWNs
Message-ID: <CAGG=3QXYtmJqE5oy5ZD0-G0=GNxK71KKYurusNJvLQNqR-o6+A@mail.gmail.com>
Subject: Re: [PATCH 21/28] NFS: nfsroot: Refactor root_nfs_cat() to use
 snprintf()
To: Kees Cook <kees@kernel.org>
Cc: nikitash.mariiaw@gmail.com, linux-kernel@vger.kernel.org, 
 codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
 linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

On Tue, Sep 15, 2026 at 11:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 08:18:38AM +0000, Bill Wendling wrote:
> >  fs/nfs/nfsroot.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> This collides with:
> https://lore.kernel.org/all/27956255dde39f58d73a7b51cb53cbe3d7804f54.1786=
411026.git.mariianikitash@google.com/
>
> > +     ret =3D snprintf(dest + len, destlen - len, "%s%s",
> > +                    (len && dest[len - 1] !=3D ',') ? "," : "", src);
>
> I prefer Mariia's version because this inline ternary is difficult
> to read.
>
Agreed. I was trying to not stomp on her work. Please ignore this patch.

-bw

> I was expecting to land hers soon if the NFS folks don't pipe up. It is
> one of the rare cases of still being open-coded, but the strlen() usage
> was pre-existing to check for the trailing comma, so it's not a clean
> seq_buf() conversion candidate...
>
> --
> Kees Cook
