Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EC8CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B857810EBE3;
	Wed, 10 Jun 2026 21:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PylB7DtN";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684F110EBE9
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:06:30 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7ea16f090b4so91568567b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
 d=google.com; s=arc-20240605;
 b=bAEIMH9erL/uEOF3qgOuXFrIw14Zs+bXUORPdJgDnswmogSJTznvROuldj8NzheaKe
 TAzlZrj0kOcGjleytK3XhxSbRJR1VsyGosQbduUjEC2aRrmMZdQCEmjTgDXLQabb7pAs
 S/froq10hGP7KTvWWnS0H4NIjod1UNbxi10eHqiPS75nmx7q76qglLPArARy52Et7Mrz
 dhjTVxZwcK+SYDdYNGWDR0qydMp2WCHEo1EKvY8NweASWzoiS0jmK+gVwE+9eRoIQm84
 NpwoGihq/M88oDdsz2clKpglGVx+A0pgtuBKMpwOVEeg3Diz99z7lX6NqLglwtm1SOLC
 KwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 fh=waCnUwAPKfJKNHuV4wEFsMd+rBIuM9QTWEF+8+ZZj/o=;
 b=F7NpdKfs0sjlG59+PoswF+J7/bNNplkj3r6FzmzlEAn5N3pk3am/6obs7SpUcpXq+Q
 65X0gH6tHB6xgpIMxJ5jTIUHpjTWu7OL6BfQq50wvoMsirZP1xxpa0hyKmmhHIM5mY8P
 W5K4/5cFEvrCgidA9GVOiXr+tmrj+vRiddz/SK1RqU75ccGyHHTJEuJJfs3b2lA5cL/C
 SeLCwAL2cLcd4457xAdvhgrYq8PN8oAsgX9YNgLvrNurdt8HKvj11I6JoA10khFbLOVb
 ircNLLQoFJAhoJPnfhnVXbFShfGHlLpCZz/pKxp4PQgRrfYbOZU7sDqq122EJuImaZdS
 XVDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 b=PylB7DtNoywixLevyU+aSGna9WJ2oCJDGaHyYolg/J6MJMytnprlMfzb1wwiCB1C66
 XIlwZ1FxwaDdBGbctCetu1XPeMDXxM99T9Udm54LT+r6yUHxzruZMWnWRhfo5Yp3fLb3
 nhHGZwNEoZd6Xnk5dspYE8q3dDIrmVsVaKQALpgewvniLb3pf/xPMrNyjicNmVznd2sY
 UnUpKH9LgaSkY4zs09UP+LzZt67kABOQUC6WPr6yVuilnpcM+apSoZdhoBgpTGD454Gh
 TGg7U8Nd191I/Q8tn/cdT7BSrR1JU426EsZSS4/a0ycHlUYtw7ysZ0qbDWhP6xWkD27b
 pQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781125589; x=1781730389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 b=emlBIHjLbpQnvqY5PbTcScEG9du2Hlg5LQuZaw6hL4x6TcFMD0PWdPD4lZrVOL/T9t
 BeQBoft4bNDNKnI2Bkl1mF1h18f8QNKyzH1HBI8WjqiacGG1Dox4G2f9QP7zgBWUCa2M
 Mah45aT6rdNkLXIQd3ew5RoI+7fVh5jPvKXPwvu2DE3FcLiXz2jPNwRBZRZp1uXhQP9x
 ek5KHSbgjGn5WqVsNmhuXDNfUItr15lwS4Mr7xX8i5patwvnryhT5Q6vmnCwUL06y/j9
 qIcnpPNgyYsv4teMf8ZJ5aV6Q6/zslTcOvJxxVwrOM/154oZJMYsfgycvwbU+7MmZFgP
 SbdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l1Ng+cUYPQ75ij8eB/tQqtJIEvV80kh4hgvoRMLTLYXLCioWAxkIUxT/7wV1T6xp1Cnzjd6tlqzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3l6OMGqfMoxHZImKX1ZTeldmPmZ7cTwP5iiJRxYPivem4o9Uf
 H+UKrig74ntPC8b8kOfjGOwBAcTY2aowmyuCK6235mbPNiU9DhKMmTi3ggvdU9Qk0vaNN8A5wwv
 EaDLZ+iVNrBuj+Pd8pBaONi/s4zl4e0Y=
X-Gm-Gg: Acq92OGsSvUnRS+I0Ygxo4ahrV8xPjRkzzQiZ43pz1m0qX8XBc1iTp7+WWro9cqcKps
 1G1BSo03VC0sCbQGJVrdTMrc4/DaYUMruI0CoiGzXsgVvHq1eIeu6GDC4W901l8mE5dyi85rMK8
 Ic8ZrbNDCicYesEnrZmaF2HAL5qBFT1LGBsAIf/MaNHghctxlvQL9cqc1i0ek6VZR99yxFJMT8n
 SW9hkya11vD3apBebOnolK9ADm7gSt86jK+pVFfKaxm8QqDgUeJNd7YPxP5Nyg/pIvKlSv67QMN
 zAiHak+bD/9y+F+PBwb1ToKCMQ==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, 
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
 Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
