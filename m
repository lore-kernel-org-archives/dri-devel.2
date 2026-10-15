Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E9FCCA463
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC9E10FFC0;
	Thu, 15 Oct 2026 16:15:10 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C0110EBCE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:40:57 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-93cc31c18ebso348891385a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060856; cv=none;
 d=google.com; s=arc-20260327;
 b=GGBFj6bxdS2qQPTEF+rpQbt+BxsNLOs5RoHhpPlVEoH2JL7G0w4PhcTIW5/Em9ICsC
 ljfH5Jynz91ZSboa0x+H6+jP68hG98ML0YoTIa8usO7UMr9Z8oTaXvqw336sx/n6a5J4
 LQ9PapIJR2fCRxkzyqq8JSVHVKONtljga0PsyrosXeqiXsEvPwPZuExNSvhNDFjEnyEN
 xo8LsajZN0/Qx4wkw2aMgVW845tkGe75+6wyBK5l3GI/f0z7zfp8oERqt47/S9TFtdR7
 Aey7/39/u4ugS1+5Eqf0J/J91GUZ8EquEQeBW4ZZVztB4ZoVnpEAP+Eyqsi2+ibJBG8s
 YnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
 fh=owznwPExubxoZ4rFwj/6rjHlIA1Z2En7hGi00EBl1hg=;
 b=Dtf2ZEWKTJy4kb+njWla8R/Zp62GY+YLEGNHcj455sejPfQZ/GGjjUvXg1bAWLukPC
 lfSMzmP+zOoOqRTtmTdmqu9DB74RKHzDNUDr7K9sgpOo7+J8Xy1qKhyKbmPTVKJaTBWV
 IrMqPQO3+40nf2IaYryZV30N+7eTles6XcOhk7pjmcO9VXDQPSK+Pk5zbiHJrGHp2QAL
 xBOAeCOIGPEE+TKz/75IplNlPzioW/QO/Py52RDIS0ln3rfqqc9Mtwkj5aGYXI07RRwC
 +tAlbqZpTYnsHTzzAWnIvS4+bUol4ZqrCT9rGi/n3IA6QDT6OmA5+uNAqSv78D1niSIQ
 k7ww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792060856; x=1792665656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
 b=KvnzdQ0YGxZDmBcDTdZp9OGvRVfi9rdltGKidihFpfgpBXrtzAwkPvtYXkYCLiuECe
 Fn2Gzkar89CHy7AIaoGYtAO1sOKiu+niy3cTdoDiPH5/U2lklouUPCpinq8HIxcSDNXh
 SvcEnhliu6mNtUZe10mjLxb6qQQ3FQycvpv29lwQ0ewieKEm4jQHYRG5KRtBzRUI+Ihs
 TXL69fNXqnzIRhhKR3BVqfZTe6R/nh8opTWLVF7pnD6dAkx2RD6YHrhMgq/WP6PmDy6H
 HO3jfIXv67gTSS2ERbmv7CjyARmXGfRGC2zjpNtwh2pUY02UJaEU1/2leklO1MFcAOAo
 59Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060856; x=1792665656;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
 b=vgzsWrdpQyEPEwzBB/7WvrscNxFBSCiCsC09i2nzKNQZWD9aUJm+JpYOKJyNJNrHT2
 wTGkOZ8dG8ZSwaDrwvpnSJZ+C4dFTHiYU+nOwYV4uQZ+/9dthab/qK11MlIhMeAkMzhf
 Bk40HjvdUUmQda76u93IFNs3mOjZxcM7XOP3G1ghwYyfAEN8MwE/z0kifnVmZBin36NX
 nFLyFtyPcHj41tFYC+f0cQRGkMs9bmVsCwkUqeVNA/k3B6pEXwIeYY6O9NXVcNMMl7W8
 0ikbuQvnkdeUqwsj2OTCp5guKZxKjZiXf6s6OrR3MIZOZVlHLbhAT8QucROZcU6atSqb
 Ujfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwocbPkbRbUQZjFbIrQAsnHDpZil6Qr6eGYbTp0YZzkh4vFxQfh1hudLG58D3J7J9JTR9aKhIqajro=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIVl4dzIz/Y/IfqNm/JC/wTuIcw57VH9VKbWF8xZ8eATmja/z28
 XRFzNqHMzQ6voJDDTDN3L4EKoYE+buEqrpWUn0vtYmBUZ9YF27g9HY9ZfEH93LeED/d7o5156lW
 5Lu4LZy6wDzcOzcdQGwq+Ilh/sJozI+M=
X-Gm-Gg: AYBFou0mA1PUvWdh/oveDem2zKpwaunFH2fNwuEeKmNb4rrTea2KfGtWPpvTAIptAq3
 QLHtxNCBbQEtJC6Kxxs4dh5aMH4/NC/8eAJHIthZfRoLdFhjmwslJIll53bHnTaNDNsDobUvuQL
 Uj03CAhXji3pjdTQ/KaRm1Jg32NLVqJ2ZyemVQuIVKFwIkGZKvPHmmNUFjOzSbflpKIZ6BTq1+1
 DfazDKZ45NulKmSXx8UET2byrOklKvsqfdahYmHZ39XjJ0MGekVm6ecXA4iZShnOoBMtVExdHQd
 756jgBOsSTZ94hO4zEdXC4WPpCy4pDQmiR63Kq+IGhVhXX4ghYVGYNllDMTwKSlKv5gXMsSM9xs
 2A2joG4cpl02Z1SpVEhJclzBwBT5FHV4IDwenPspt0W68Yg==
X-Received: by 2002:a05:620a:44c1:b0:93e:6e59:ad16 with SMTP id
 af79cd13be357-93ebd1dfd74mr3037179085a.29.1792060856144; Thu, 15 Oct 2026
 03:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260928081450.19340-1-dilddream31@gmail.com>
 <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
In-Reply-To: <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
From: =?UTF-8?B?6rmA67KU7ISd?= <dilddream31@gmail.com>
Date: Thu, 15 Oct 2026 19:40:44 +0900
X-Gm-Features: AclHuK9ftaX0YjG2NCtLvWvZyiH7eh52x9bAW5dRWFx1APAiB6cYmVIL6REePPY
Message-ID: <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
To: nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

Gentle Ping.

There has been some related discussion here:
https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.f=
r

The patch has also been independently tested, with no reproduction of
the issue reported so far.

Apologies if you received this twice. My previous message was rejected
by the mailing list due to HTML formatting.


Thanks.


2026=EB=85=84 10=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:10, =
=EA=B9=80=EB=B2=94=EC=84=9D <dilddream31@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Gentle Ping.
>
> There has been some related discussion here:
> https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux=
.fr
>
> The patch has also been independently tested, with no reproduction of the=
 issue reported so far.
>
>
> Thanks.
