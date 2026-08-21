Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E4CC5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674AE10E3F8;
	Sun, 23 Aug 2026 09:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMYYaEoc";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D133289117
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:07:43 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-52de178a66aso6846231cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787321263; x=1787926063; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QHJgjLvgHDbYJ/uRAJqtcFTfRjwoYjG5WYJnARLGN6I=;
 b=FMYYaEocRAgq0aHEtb0xJ1BtA4WL9iU3S93r37oQq6Ampqv+bVTZHHJoe4XfCtzwQJ
 onWsDnP75JFehE9LKp7JFzG0gi0S/b3PNvsK7Be5JP/uVJSVfregVhhgvEmTEWCwFlGI
 qkeG4jhEpRHgQkYGlGAUtteipaRE7yPxqJvn/ddxyncmtXcTM3CiE8oermXG63c27Vg4
 /P9IMgZRmaJEHGhg4kAtvGHg9SBX/MoGgerAL6PmD+ikxCI63xgEFEdXxSVUH8r9kheQ
 rFDFFGrVFopHemRXI1PwWhnigmRJVIaIe8fb/NwYn5f46sWqEwYFX9oK1BhbGtNx0tQg
 vzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321263; x=1787926063;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHJgjLvgHDbYJ/uRAJqtcFTfRjwoYjG5WYJnARLGN6I=;
 b=RM1KQ8Ps8rPO7j1OOo3rqBZWvZ9auuA0smbeXjvCAYsKw9R4cdoCLz8ywcJn3/iYL8
 10MZeLYu6rVKuISC6dLq6Mawn56Ec/QvujzJqFaQ8nwz38XoCY686nVSHJCOQ6BYXH5U
 /8zyZgVPTN0TRKZ7qk9rmweMYsWs9MIiEs53oRr7Na/TC8txPa+BjReLYNkw22lW03zb
 n5TmIkRsEdY6mwBMXNOqX90pVDEsIOwPe5C1s1u4+dSX0jfNWKCFKzWGFdYiggzARAaI
 1LI4RBBfHyw5lUgASw8mOd+YBqYfQLrmch6HDtL05aRKFvA06JQgCg37OYJbp1c2Ttb8
 Hrpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOU1BotPFj89/CXgOKBx3sB5fDNTORabBRjfXgACvRjZd9SRNlIumYU8JY0aXEYqRwGPP6u4mA6aM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyGptDC2RbLbJs3LoyL0wEKUlDtnTYDHxwYA4209G5eufw+lKb
 5T/8ETXH7a1kd2U7V0e8D2v7mh0AZ1Qm0sr2xPKvBtSg/aQW69EViklF
X-Gm-Gg: AR+sD13jLOGpIhZtJn/J3DvwNklodft96hjBZbd04zUlL+jSHQDK89b/Qb07FiMDaF3
 9Q1WDHlW8wEFW0YAbCkgtIGsy3bK8Dp6lQtBZvrsL1vXrhMd/JRWE3xSs60sv8T83d6hWXDxa0t
 hk6XmLQ2FeRRowyxOUt3bSl5fTcSAJwc5auLPWqID9suu+XSfHDP+KoHXAMlSGo0ZPaFck+hKUL
 pPnvh9grR7w1c4ZqnYNuye/u0p/ZVc/BKvJrWCnN96Ao2v4s5/QmTRbO5jKXqgoPNEYcWRBb22y
 sjGNML/fMZVt4AST4Iz3EZoHcFH3yKXsM4K3buX67InntWVvJ+mP4CLD9KLAW2pmAsUbc3hpgM8
 umIb1CSUvUGXEs+j9RJ7gSaCLxA2FO8Ky3ZWsjI58oj9XQPQbkGZV65In87pVvKxN1BiQzvzorB
 3GqUc180OGFZHbA6AWFspGILe8/TqTPENOtyNFmWMDRaQ/IMU/wxmNREWiOEYF0DfBmWQ4vouB3
 /Poqe/em6CLrqrZnsrU
X-Received: by 2002:a05:622a:5c14:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52df56e4b5dmr59495521cf.9.1787321262531; 
 Fri, 21 Aug 2026 07:07:42 -0700 (PDT)
Received: from smtpclient.apple ([165.85.199.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2a2d62sm62929666d6.38.2026.08.21.07.07.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:07:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <5c4b9949-506b-4a01-b390-a83ec5d63fd5@lankhorst.se>
Date: Fri, 21 Aug 2026 10:07:09 -0400
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 bigeasy@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECED6685-78D9-4B31-BEF3-5ECEA21EA492@gmail.com>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
 <20260821022530.2503120-1-shuangpeng.kernel@gmail.com>
 <5c4b9949-506b-4a01-b390-a83ec5d63fd5@lankhorst.se>
To: Maarten Lankhorst <dev@lankhorst.se>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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



> On Aug 21, 2026, at 07:45, Maarten Lankhorst <dev@lankhorst.se> wrote:
>=20
> Hello,
>=20
> On 8/21/26 04:25, Shuangpeng Bai wrote:
>> Hi Maarten,
>>=20
>> While reviewing this series, I noticed an additional request lifetime
>> issue in signal_irq_work().
>>=20
>> The existing RCU loop removes rq from ce->signals and may then call
>> i915_request_put(rq). If that is the final reference, the request can =
be
>> released and its SLAB_TYPESAFE_BY_RCU slot reused before
>> list_for_each_entry_rcu() advances and reads rq->signal_link.next. =
The
>> RCU read-side critical section does not provide a stable reference to =
the
>> same request object in this cache.
>>=20
>> The v4 conversion to signalers_lock/ce->signal_lock and the
>> list_first_entry_or_null() loop removes this post-put dereference, so =
it
>> also covers this UAF path.
>>=20
>> This is independent of the PREEMPT_RT irq_work starvation trigger. I =
can
>> reach the sequence in a diagnostic run, although KASAN does not =
reliably
>> report it because i915_request uses a SLAB_TYPESAFE_BY_RCU cache.
>>=20
>> Since this also removes a request lifetime UAF from the common =
signaling
>> path, it may be worth considering the relevant fix for stable kernels =
once
>> the series is accepted.
>=20
> The original patch for the conversion actually had this bug. There =
were some
> failures reported by CI, pointing to a use-after-free after the =
changes.
>=20
> Originally I thought it was due to the conversion itself, that the =
lifetime
> was previously sufficiently by RCU. It makes sense that RCU itself =
couldn't
> properly protect that, and that relying on it was a bug to begin with.
>=20
> Thanks, I'll send this patch again separately and attach a stable tag!
> Since you reported the issue, would you want to put your reviewed by
> on the patch as well?

Thanks for checking this. Yes, please add my Reviewed-by tag:

Reviewed-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

Kind regards,
Shuangpeng

>=20
> Kind regards,
> ~Maarten Lankhorst


