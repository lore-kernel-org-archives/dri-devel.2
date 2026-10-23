Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E4606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYijY4dC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6451112C89;
	Fri, 23 Oct 2026 17:13:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67641112C66
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792775586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXynH80RO/xGHb0t0bbutsjbUgHko3YWihcoLi5HDZQ=;
 b=SYijY4dCXz2AgTp05Q1Y+YnDnFDLgVPVZ6UsBdCtCVOjklNTHukJOulTxjX/qBPNbFUmAe
 1Mu0nugNUJwDsUsuTgUE7ESo7pYRR976I8iwWuEQR0vLeg4ZtlxDnduuU/HKI9n24/Ttmf
 IF1cTeUlylOnZdLdsCueS8Rg/5nYzBw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-O-l0exznOtmYGosAO8VZ_g-1; Fri, 23 Oct 2026 13:13:05 -0400
X-MC-Unique: O-l0exznOtmYGosAO8VZ_g-1
X-Mimecast-MFC-AGG-ID: O-l0exznOtmYGosAO8VZ_g_1792775584
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a3c27c9bso21040686d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775584; x=1793380384;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXynH80RO/xGHb0t0bbutsjbUgHko3YWihcoLi5HDZQ=;
 b=qZsoCUFIUBXwXqj7j9whV1tcUX+l9CYDyjXq4TVPZKZAK5Kx8b4MrsNtJKFXtpZB9i
 Es7NIcyv/0QNu5OihVvpg+aeDuatrGLvoK9g49GaEcSNbjMIGQIVlr/HcCrHb93LjBZQ
 fcHJs7vHH96kx0QphaWdU0tkvnNNJfW3dhvI4oIAfPLTKHbrMoovx8MJrdEmTJKs6hkh
 FItrSosK5NSD6+Edh2uXs9EYkd060oUeP3UEh9MPY3FgyuAyPA0uRqaKtlNgug8u8MdW
 2zkl7aM+Hw0c0Apk8no1ZGxyWdahYBbh/Co9fjW4vKqI9QFyrrwFVLgmngd1zHlPfPaL
 dDMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9+A23QIHcP69kbvor35G7bYQnIdcBGqPFeULhWyZ7U7PJ3JGAq/DZo/2F6nYEXnsz/XOQK8mxvLw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/5wpUoA6JDsmuMOeVfc3fyH2THBMXB/TijcWCdk13+4nteEnb
 bx4xXFAPKXssKo+A5jVUjtsceK6nrmXi11ecH7nWBr65rmRxipTbx1JLGk1byQdzXARggxMkIHS
 wu7CnRBwDOIeBHzqOEk3MsIrduocwg+UHtA9yug6+PM+FRtGgsWQt9KH3VUtuSsqVi++DrQ==
X-Gm-Gg: AYBFou3mEQkS65FGgdFwqBkFPTPHEBiYpAlq/jkg/V9CSV0ZwmgZ0aVuMGYtgEoGJ1n
 euDBdIy/1RAqq+53Fc06RZdIu8mA14t8RmOVC4XoByqTUKoEM+DZNPwsSK/7WIcv8EoDCbhy+X4
 MQQwu2NC69Yb/t3DZnhh1xzCLoq7u00ZuK3rsk+Dzk3tK/O7cD1I8EIyOODScAuGA4/lnGteo25
 QcFzCDsGIUqhgTl67nuaSqxl2PF6F7pmCE89mOMxNseqgKrHMYMZUM1O4CACGhsbAYHm3U5oSRS
 g5gJ3NKGn1RIKgqBYFNOxOYl8b0L7cPAoP7kaUDjsqK4tqJ6f7pInSAgr8//aJFwJXKDAas=
X-Received: by 2002:a05:6214:3d0e:b0:919:7384:99a6 with SMTP id
 6a1803df08f44-91c3a9e79b5mr43112276d6.41.1792775584254; 
 Fri, 23 Oct 2026 10:13:04 -0700 (PDT)
X-Received: by 2002:a05:6214:3d0e:b0:919:7384:99a6 with SMTP id
 6a1803df08f44-91c3a9e79b5mr43111616d6.41.1792775583760; 
 Fri, 23 Oct 2026 10:13:03 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4522855csm6449066d6.16.2026.10.23.10.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:13:03 -0700 (PDT)
Message-ID: <8a025f783533d40c0486a8a511e8811b0e52f466.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau: fix GK107 VDPAU regressions
From: lyude@redhat.com
To: Kush Chandak <kushc451@gmail.com>, Risto Pajula <or.pajula@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 13:13:02 -0400
In-Reply-To: <20261022153712.11208-1-kushc451@gmail.com>
References: <20260913201225.5975-1-or.pajula@gmail.com>
 <20261022153712.11208-1-kushc451@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9hE92Nc3W_W-LjyxpGELbQMmHMq8aYGQwTEQxiNMFLY_1792775584
X-Mimecast-Originator: redhat.com
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am going to look at this patch when I have a moment, but I am in the
middle of moving right now so it's likely going to take me a bit,
however:

On Thu, 2026-10-22 at 21:07 +0530, Kush Chandak wrote:
> On Sun, 13 Sep 2026 23:12:23 +0300, Risto Pajula wrote:
> > This series fixes two independent Nouveau regressions affecting
> > VDPAU
> > hardware video decoding on NVIDIA GK107 (Kepler).
>=20
> Tested-by: Kush Chandak <kushc451@gmail.com>
>=20
> I used an AI assistant (Claude) to help debug and test this.

Please don't clog up the mailing list with this. I have seen multiple
people now going through and 'testing' things with LLMs, and the
reality is I'm not going to carry across the tested tags.

If you would like to test, there are plenty of resources available to
figure out how to build a kernel against a patch on a mailing list to
test changes. LLMs frequently hallucinate and lack an understanding of
the tasks they perform. It's already difficult enough keeping up with
code submissions, and given that you cannot use LLM output without both
vetting it, and having the knowledge required to properly vet it, there
really is nothing I can actually establish from "testing" like this. If
you weren't able to actually test without using an LLM and we have
established we can't trust the output of the LLM - how am I supposed to
know it was tested? I can't verify it from what you gave me, and even
if I could - that's just doing what is way too commonplace with these
tools and offloading the work of verifying anything that it spits to
others.

