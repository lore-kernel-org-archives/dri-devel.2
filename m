Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A31F327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5B010E825;
	Tue, 21 Apr 2026 08:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MM6C98PR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997A10E825
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776760179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
 b=MM6C98PRXQXRyyEMOLx48abUBpN7LMmswzRMJVCmk/Km5bsdYdRoMlWYcAcIT1kaN4QNSY
 hojHpyeRbTCiYNdLj3aqUVmZp6Y9X8/Lkz1mEdG5jUdmaxO0KGfsqc0cDNgdCb/7n7Mvad
 1EmgDVqg3Zocjq6uoroD2PExU4Pr8C4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-2DmP4_PDPSC3FL8MagMQaQ-1; Tue, 21 Apr 2026 04:29:37 -0400
X-MC-Unique: 2DmP4_PDPSC3FL8MagMQaQ-1
X-Mimecast-MFC-AGG-ID: 2DmP4_PDPSC3FL8MagMQaQ_1776760177
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7badeafe9d6so51814097b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776760177; x=1777364977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
 b=cNI8LkbuJigHm+YeNcDKTUHiY3OJsU5FBbSJp4KcROV+7U3xHcbSlGV6z6avVv/gSt
 J1xz/lNKXM16uKI4YX+JiMj4ctkojfgCefY+1tYP05txpBbfJ55ygzKVN+lqryUV4U8e
 h8IaeFLq53x5qatSPr5n0HN4VNluMXBsxMXy3JlPmYxxSwrl+8OJz5oHeCWdje2wC2lt
 EqlbokRIKA4SVGWSpcwAuXGq7JDZXgoAky9ibQwvWdsGxWm9aJzVWq7yKZOLPel48Sj+
 Z0kxAEz64goDAid38rcOKzz9nr/N5OGn1QJMw+gUG8l0Mw6e3/wAhgyiRPPrnUOie8ZA
 Cf1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fBL6zaVq/sNFSwXfAZyo682h0eEgCVyE3rOK14AXjg3mo4p9v+4zYHdKwj5PfH9X04OM1igD8rC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygVrUg3XOg5QMtagUHd5VSY+DePwP39LZzRPNnni3ch1s8Jd9C
 O92JKNOMZ7zfa12y3ZHg0Y6zWizj0MYQe3iD4J9RchxXkeuZhCfn7NJAtaIcT5RlQmlg5K6b2yF
 QZ3DVmre9Z1fIPtjkwIuKW7ZQNNT/ZucwBIEWZmZ6Mugj8pv9Dphm1zlHWu+TpEy1x3EeHwaa+U
 dWwbiEzBpJ9LtOPHq4nbGPdS3Tq6vmoMHOAcY0EGQo1Xin
X-Gm-Gg: AeBDietE8pYGOBy9IyShsp7BR8Iyg0fKB+oHMdcKBZEOmDoQjAe+B8CjoBkagdeWscS
 4XO6JQcHtXANKZAYQ06elm9vkCGDCl7XyjusNxRgOpe1lAZQjCJrubM/zAVGm9xt9co/RZ5Oj4o
 D90G5ov0ez6UMwTn4opBkH08Yhwm7fIWvi+YozUWhCYgkhI4Mba5E+bvNPq2a3iVZqyL18lz/Do
 UhpgwT3nuNFfe4B
X-Received: by 2002:a05:690c:1a:b0:7b1:d1af:4b95 with SMTP id
 00721157ae682-7b9ed03ea4amr180130457b3.45.1776760177012; 
 Tue, 21 Apr 2026 01:29:37 -0700 (PDT)
X-Received: by 2002:a05:690c:1a:b0:7b1:d1af:4b95 with SMTP id
 00721157ae682-7b9ed03ea4amr180130217b3.45.1776760176561; Tue, 21 Apr 2026
 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
 <20260420144512.GL3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420144512.GL3102624@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 10:29:25 +0200
X-Gm-Features: AQROBzAEAbEFlPw_UOBBc9Hp9GuZ76mdLqLO_-KNOSIDgp6-Bgs3Cp1G00-BX1o
Message-ID: <CADSE00KyJhzf_p1Z9qZ-PRi5_9pEhSxHnP5wy+kdxexB2a2scw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Kees Cook <kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wa99zBGD-flrENf0WW0IYJCmCS3gMytZ2QsAlrSCT3k_1776760177
X-Mimecast-Originator: redhat.com
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

On Mon, Apr 20, 2026 at 4:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 20, 2026 at 02:28:03PM +0200, Albert Esteve wrote:
> > +bool __kunit_is_suppressed_warning(void)
> > +{
> > +     struct __suppressed_warning *warning;
> > +
> > +     rcu_read_lock();
>
>         guard(rcu)();

Nice. I saw plenty of examples using explicit calls, but I had missed
the guard. Thanks for pointing it out.

>
> > +     list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> > +             if (warning->task =3D=3D current) {
> > +                     warning->counter++;
> > +                     rcu_read_unlock();
> > +                     return true;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return false;
> > +}
> > +
> > +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> >
> > --
> > 2.52.0
> >
>

